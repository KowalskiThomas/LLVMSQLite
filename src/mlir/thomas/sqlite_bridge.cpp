#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/StandalonePassManager.h"
#include "Standalone/StandaloneDialect.h"

#include "sqlite_bridge.h"

bool enableOpt = false;
const char* const JIT_MAIN_FN_NAME = "jittedFunction";

static bool initialised = false;

static void init() {
    if (initialised)
        return;

    initialised = true;
    mlir::registerAllDialects();
    mlir::registerAllPasses();

    using VdbeDialect = mlir::standalone::StandaloneDialect;
    mlir::registerDialect<VdbeDialect>();
}

struct VdbeRunner {
    using MLIRContext = mlir::MLIRContext;
    using VdbeDialect = mlir::standalone::StandaloneDialect;

    MLIRContext context;
    MLIRContext* ctx;

    mlir::LLVM::LLVMDialect* llvmDialect;

    mlir::OpBuilder builder;
    mlir::ModuleOp theModule;

    VdbeDialect* vdbeDialect;

    Vdbe* vdbe;

    ~VdbeRunner() {
        out("Destroying runner")
    }

    VdbeRunner(Vdbe* p)
    : engine(nullptr),
      vdbe(p),
      ctx(&context),
      llvmDialect(context.getRegisteredDialect<LLVMDialect>()),
      vdbeDialect(ctx->getRegisteredDialect<VdbeDialect>()),
      builder(mlir::OpBuilder(ctx))
    {
        init();

        initialiseTypeCache(llvmDialect);
        theModule = mlir::ModuleOp::create(builder.getUnknownLoc());

        vdbeDialect->setVdbe(p);

        Prerequisites::runPrerequisites(theModule, llvmDialect);
    }

    void prepareFunction() {
        ::prepareFunction(context, llvmDialect, theModule);

        llvm::errs() << "Original module\n";
        theModule.dump();
        llvm::errs() << "\n\n";

        mlir::PassManager pm(ctx);
        pm.addPass(std::make_unique<VdbeToLLVM>());
        pm.run(theModule);

        llvm::errs() << "Intermediate module\n";
        theModule.dump();

        llvm::errs() << "LLVM IR-Translated module\n";
        auto mod = mlir::translateModuleToLLVMIR(theModule);
        mod->dump();
        llvm::errs() << "\n\n";
    }

    mlir::ModuleOp& module() {
        return theModule;
    }

    int run() {
        if (!runningInitialised)
            prepareFunction();
        return runJit();
    }

    std::unique_ptr<mlir::ExecutionEngine> engine;
    bool runningInitialised = false;
    void(*fptr)(void**) = nullptr;

    int runJit() {

        if (!runningInitialised) {
            // Initialize LLVM targets.
            llvm::InitializeNativeTarget();
            llvm::InitializeNativeTargetAsmPrinter();

            runningInitialised = true;

            // An optimization pipeline to use within the execution engine.
            auto optPipeline = mlir::makeOptimizingTransformer(
                    /* optLevel */ enableOpt ? 3 : 0,
                    /* sizeLevel */ 0,
                    /* targetMachine */ nullptr
            );

            {
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
                    fptr = *expectedFPtr;
                }
            }
        }

        int32_t returnedValue = -1;

        sqlite3VdbeEnter(vdbe);
        if (vdbe->rc == SQLITE_NOMEM) {
            err("ERROR: Can't allocate memory")
        }

        // The function wants addresses to arguments
        // So if we want to pass value 123, we need to
        // - Put 123 in a variable var
        // - Put the address of var in a variable addr
        // - Pass the address of addr
        // The last parameter is used to store the returned value
        llvm::outs() << "Calling\n";
        llvm::SmallVector<void*, 8> args = {(void*)&vdbe, (void*)&returnedValue };
        (*fptr)(args.data());


        llvm::outs() << "Returned value " << returnedValue << '\n';
        llvm::outs().flush();

        return returnedValue;

    }

};

/*
auto getModuleForVdbe(Vdbe* p) {
    if (modules.find(p) != modules.end()) {
        out("Using already defined module");
        return modules[p];
    }

    auto context = mlir::MLIRContext();
    auto ctx = &context;
    auto llvmDialect = ctx->getRegisteredDialect<mlir::LLVM::LLVMDialect>();
    initialiseTypeCache(llvmDialect);
    auto builder = mlir::OpBuilder(ctx);
    auto theModule = mlir::ModuleOp::create(builder.getUnknownLoc());

    auto vdbeDialect = ctx->getRegisteredDialect<mlir::standalone::StandaloneDialect>();
    vdbeDialect->setVdbe(p);

    Prerequisites::generateReferenceToProgress(theModule, llvmDialect);
    Prerequisites::runPrerequisites(theModule, llvmDialect);

    prepareFunction(context, llvmDialect, theModule);

    llvm::errs() << "Original module\n";
    theModule.dump();
    llvm::errs() << "\n\n";

    mlir::PassManager pm(ctx);
    pm.addPass(std::make_unique<VdbeToLLVM>());
    pm.run(theModule);

    llvm::errs() << "Intermediate module\n";
    theModule.dump();

    llvm::errs() << "Translated module\n";
    auto mod = mlir::translateModuleToLLVMIR(theModule);
    mod->dump();
    llvm::errs() << "\n\n";

    modules[p] = theModule;
    return theModule;
}
*/

auto runners = std::unordered_map<Vdbe*, VdbeRunner*>{};

int jitVdbeStep(Vdbe* p) {
    init();

    if (runners.find(p) != runners.end()) {
        return runners[p]->run();
    }

    runners[p] = new VdbeRunner(p);
    return runners[p]->run();
}
