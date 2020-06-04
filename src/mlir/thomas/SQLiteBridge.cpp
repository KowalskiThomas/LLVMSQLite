#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/StandalonePassManager.h"
#include "Standalone/StandaloneDialect.h"

#include "SQLiteBridge.h"


#include "llvm/ADT/STLExtras.h"
#include "llvm/ExecutionEngine/ExecutionEngine.h"
#include "llvm/ExecutionEngine/GenericValue.h"
#include "llvm/IR/Argument.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/DerivedTypes.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/ExecutionEngine/OrcMCJITReplacement.h"
#include "llvm/ExecutionEngine/MCJIT.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Verifier.h"
#include "llvm/IR/Type.h"
#include "llvm/Support/Casting.h"
#include "llvm/Support/ManagedStatic.h"
#include "llvm/Support/TargetSelect.h"
#include "llvm/Support/raw_ostream.h"
#include <algorithm>
#include <cassert>
#include <memory>
#include <vector>



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
    mlir::ModuleOp mlirModule;
    std::unique_ptr<llvm::Module> llvmModule;

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
        mlirModule = mlir::ModuleOp::create(builder.getUnknownLoc());

        vdbeDialect->setVdbe(p);

        runPrerequisites(mlirModule, llvmDialect);
    }

    void prepareFunction() {
        ::prepareFunction(context, llvmDialect, mlirModule);

        // llvm::errs() << "-- Original module";
        // theModule.dump();

        mlir::PassManager pm(ctx);
        pm.addPass(std::make_unique<VdbeToLLVM>());
        pm.run(mlirModule);

        // llvm::errs() << "\n\n-- Intermediate module";
        // theModule.dump();

        llvmModule = mlir::translateModuleToLLVMIR(mlirModule);
        // llvm::errs() << "\n\n--LLVM IR-Translated module";
        llvmModule->dump();

        llvm::errs() << "\n\n";
    }

    mlir::ModuleOp& module() {
        return mlirModule;
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
            // llvm::InitializeNativeTargetDisassembler();

            llvm::sys::DynamicLibrary::LoadLibraryPermanently(nullptr);
            auto result = llvm::sys::DynamicLibrary::SearchForAddressOfSymbol("my_assert");
            ALWAYS_ASSERT(result);

            executionEngineCreated = true;
            {
                auto &tempLlvmModule = *llvmModule;
                auto broken = llvm::verifyModule(tempLlvmModule, &llvm::outs());
                ALWAYS_ASSERT(!broken && "Generated IR Module is invalid");

                auto builder = llvm::EngineBuilder(std::move(llvmModule));
                auto engine = builder
                                .setEngineKind(llvm::EngineKind::JIT)
                                .setOptLevel(llvm::CodeGenOpt::Aggressive)
                                .setVerifyModules(true)
                                .create();
                ALWAYS_ASSERT(engine != nullptr && "ExecutionEngine is null!");
                jittedFunctionPointer = reinterpret_cast<decltype(jittedFunctionPointer)>(engine->getFunctionAddress(
                        JIT_MAIN_FN_NAME));
            }
        }

        printTimeDifference(tick, "Optimisation and ExecutionEngine creation");

        int32_t returnedValue = -1;

        sqlite3VdbeEnter(vdbe);
        if (vdbe->rc == SQLITE_NOMEM) {
            err("ERROR: Cannot allocate memory");
            exit(124);
        }

        llvm::outs() << "Calling JITted function\n";
        {
            using testType = int(*)(Vdbe*);
            returnedValue = ((testType)(jittedFunctionPointer))(vdbe);
        }

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

    int runJit2() {
        auto tick = std::chrono::system_clock::now();
        if (!executionEngineCreated) {
            // Initialize LLVM targets.
            llvm::InitializeNativeTarget();
            llvm::InitializeNativeTargetAsmPrinter();

            llvm::sys::DynamicLibrary::LoadLibraryPermanently(nullptr);
            auto result = llvm::sys::DynamicLibrary::SearchForAddressOfSymbol("my_assert");
            printf("Test: %p\n", result);

            executionEngineCreated = true;

            {
                // An optimization pipeline to use within the execution engine.
                auto optPipeline = mlir::makeOptimizingTransformer(
                        /* optLevel */ enableOpt ? 3 : 0,
                        /* sizeLevel */ 0,
                        /* targetMachine */ nullptr
                );

                // Create an MLIR execution engine. The execution engine eagerly JIT-compiles the module.
                // TODO remove: theModule.dump();
                auto maybeEngine = mlir::ExecutionEngine::create(mlirModule, optPipeline);
                assert(maybeEngine && "failed to construct an execution engine");
                if (!maybeEngine) {
                    llvm_unreachable("Couldn't build engine");
                }
                engine = std::move(maybeEngine.get());

                {
                    auto tempFptr = engine->lookup("printf");
                    if (!tempFptr)
                        llvm_unreachable("Nothing\n");
                    else
                        printf("Test: %p\n", tempFptr ? tempFptr.get() : nullptr);
                }
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
