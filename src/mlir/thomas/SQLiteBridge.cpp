#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/StandalonePassManager.h"
#include "Standalone/StandaloneDialect.h"

#include "SQLiteBridge.h"

bool enableOpt = true;
const char* const JIT_MAIN_FN_NAME = "jittedFunction";

class VdbeRunner;
static auto runners = std::unordered_map<Vdbe*, VdbeRunner*>{};

template<typename T>
void printTimeDifference(std::chrono::time_point<T> tick, std::string msg) {
    auto tock = std::chrono::system_clock::now();
    auto diff = tock - tick;
    printf("%s time difference: %llu ms\n",
           msg.c_str(),
           std::chrono::duration_cast<std::chrono::milliseconds>(diff).count());
}

static void initRuntime() {
    mlir::registerAllDialects();
    mlir::registerAllPasses();

    using VdbeDialect = mlir::standalone::StandaloneDialect;
    mlir::registerDialect<VdbeDialect>();
}

struct VdbeRunner {
    using MLIRContext = mlir::MLIRContext;
    using VdbeDialect = mlir::standalone::StandaloneDialect;
    using LLVMDialect = mlir::LLVM::LLVMDialect;

    MLIRContext context;
    MLIRContext* ctx;

    mlir::LLVM::LLVMDialect* llvmDialect;
    VdbeDialect* vdbeDialect;

    mlir::OpBuilder builder;
    mlir::ModuleOp theModule;

    Vdbe* vdbe;

    ~VdbeRunner() {
        out("Destroying runner")
    }

    VdbeRunner(Vdbe* p)
    : engine(nullptr),
      vdbe(p),
      ctx(&context),
      llvmDialect(context.getRegisteredDialect<LLVMDialect>()),
      vdbeDialect(context.getRegisteredDialect<VdbeDialect>()),
      builder(mlir::OpBuilder(ctx))
    {
        initRuntime();

        initialiseTypeCache(llvmDialect);
        theModule = mlir::ModuleOp::create(builder.getUnknownLoc());

        vdbeDialect->setVdbe(p);

        runPrerequisites(theModule, llvmDialect);
    }

    void prepareFunction() {
        ::prepareFunction(context, llvmDialect, theModule);

        // llvm::errs() << "-- Original module";
        // theModule.dump();

        mlir::PassManager pm(ctx);
        pm.addPass(std::make_unique<VdbeToLLVM>());
        pm.run(theModule);

        // llvm::errs() << "\n\n-- Intermediate module";
        // theModule.dump();

        auto mod = mlir::translateModuleToLLVMIR(theModule);
        // llvm::errs() << "\n\n--LLVM IR-Translated module";
        // mod->dump();

        llvm::errs() << "\n\n";
    }

    mlir::ModuleOp& module() {
        return theModule;
    }

    int run() {
        if (!functionPrepared) {
            auto tick = std::chrono::system_clock::now();
            prepareFunction();
            printTimeDifference(tick, "Function preparation");
            functionPrepared = true;
        }
        return runJit();
    }

    std::unique_ptr<mlir::ExecutionEngine> engine;
    bool executionEngineCreated = false;
    bool functionPrepared = false;
    void(*jittedFunctionPointer)(void**) = nullptr;

    int runJit() {
        auto tick = std::chrono::system_clock::now();
        if (!executionEngineCreated) {
            // Initialize LLVM targets.
            llvm::InitializeNativeTarget();
            llvm::InitializeNativeTargetAsmPrinter();

            executionEngineCreated = true;

            {
                // An optimization pipeline to use within the execution engine.
                auto optPipeline = mlir::makeOptimizingTransformer(
                        /* optLevel */ enableOpt ? 3 : 0,
                        /* sizeLevel */ 0,
                        /* targetMachine */ nullptr
                );

                // Create an MLIR execution engine. The execution engine eagerly JIT-compiles
                // the module.
                auto maybeEngine = mlir::ExecutionEngine::create(theModule, optPipeline);
                assert(maybeEngine && "failed to construct an execution engine");
                if (!maybeEngine) {
                    llvm_unreachable("Couldn't build engine");
                }
                engine = std::move(maybeEngine.get());
            }

            {
                // Determine a pointer to the JITted function
                auto expectedFPtr = engine->lookup(JIT_MAIN_FN_NAME);
                // decltype(expectedFPtr.takeError()) result = llvm::Error::success();
                if (!expectedFPtr) {
                    llvm::errs() << "JIT invocation failed\n";
                    return -1;
                } else {
                    jittedFunctionPointer = *expectedFPtr;
                }
            }
        }
        printTimeDifference(tick, "Optimisation and ExecutionEngine creation");

        int32_t returnedValue = -1;

        sqlite3VdbeEnter(vdbe);
        if (vdbe->rc == SQLITE_NOMEM) {
            err("ERROR: Cannot allocate memory");
            exit(124);
        }

        // The function wants addresses to arguments
        // So if we want to pass value 123, we need to
        // - Put 123 in a variable var
        // - Put the address of var in a variable addr
        // - Pass the value of addr
        // The last parameter is used to store the returned value
        llvm::outs() << "Calling JITted function\n";
        llvm::SmallVector<void*, 8> args = {(void*)&vdbe, (void*)&returnedValue };
        (*jittedFunctionPointer)(args.data());

        sqlite3VdbeLeave(vdbe);

        out("Value returned by VDBEStep: " << returnedValue);

        if (returnedValue == SQLITE_DONE) {
            out("Removing VDBE " << (void*)vdbe << " from VDBERunner cache");
            // TODO: Fix this memory leak
            // delete runners[vdbe];
            runners.erase(vdbe);
        }

        return returnedValue;
    }

};

int jitVdbeStep(Vdbe* p) {
    initRuntime();

    VdbeRunner* runner = nullptr;
    if (runners.find(p) == runners.end()) {
        out("Creating a new VDBERunner");
        auto tick = std::chrono::system_clock::now();
        runners[p] = new VdbeRunner(p);
        printTimeDifference(tick, "VdbeRunner creation");
    }

    runner = runners[p];
    auto result = runner->run();
    return result;
}
