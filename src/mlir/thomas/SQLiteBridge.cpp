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
#include <llvm/IR/LegacyPassManager.h>
#include <llvm/Support/Debug.h>
#include <llvm/ExecutionEngine/Orc/Core.h>
#include <llvm/ExecutionEngine/Orc/ThreadSafeModule.h>
#include <llvm/Support/Error.h>
#include <llvm/Transforms/IPO/PassManagerBuilder.h>
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Verifier.h"
#include "llvm/IR/Type.h"
#include "llvm/Support/Casting.h"
#include "llvm/Support/ManagedStatic.h"
#include "llvm/Support/TargetSelect.h"
#include "llvm/Support/raw_ostream.h"
#include <cassert>
#include <memory>

template<typename T>
void write_to_file(const T& x, const char* fileName) {
    std::string s;
    auto temp = llvm::raw_string_ostream(s);
    x.print(temp, nullptr);
    auto fd = fopen(fileName, "w");
    fwrite(s.c_str(), sizeof(char), s.size(), fd);
    fclose(fd);
}

bool enableOpt = true;
const char* const JIT_MAIN_FN_NAME = "jittedFunction";

class VdbeRunner;
static auto runners = std::unordered_map<Vdbe*, VdbeRunner*>{};

using namespace std::chrono;

unsigned long long functionPreparationTime;
unsigned long long functionOptimisationTime;

template<typename T>
void printTimeDifference(time_point<T> tick, std::string msg) {
    auto tock = system_clock::now();
    auto diff = tock - tick;
    printf("%s time difference: %llu ms\n",
           msg.c_str(),
           duration_cast<milliseconds>(diff).count());
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

    LLVMDialect* llvmDialect;
    VdbeDialect* vdbeDialect;

    mlir::OpBuilder builder;
    mlir::ModuleOp mlirModule;
    std::unique_ptr<llvm::Module> llvmModule;

    Vdbe* vdbe;

    ~VdbeRunner() {
        debug("Destroying runner")
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

#ifdef DEBUG_MACHINE
        // llvm::errs() << "-- Original module";
        // theModule.dump();
#endif

        mlir::PassManager pm(ctx);
        pm.addPass(std::make_unique<VdbeToLLVM>());
        pm.run(mlirModule);

#ifdef DEBUG_MACHINE
        // llvm::errs() << "\n\n-- Intermediate module";
        // theModule.dump();
#endif

        llvmModule = mlir::translateModuleToLLVMIR(mlirModule);

#ifdef DEBUG_MACHINE
        // write_to_file(*llvmModule, "unoptimised_ir.ll");
#endif
    }

    mlir::ModuleOp& module() {
        return mlirModule;
    }

    int run() {
        if (!functionPrepared) {
            auto tick = system_clock::now();
            prepareFunction();
            auto tock = system_clock::now();
            functionPreparationTime = (unsigned long long)(duration_cast<milliseconds>(tock - tick).count());
            functionPrepared = true;
        }
        return runJit();
    }

    std::unique_ptr<mlir::ExecutionEngine> engine;
    bool executionEngineCreated = false;
    bool functionPrepared = false;
    void(*jittedFunctionPointer)(void**) = nullptr;
    using vdbeExecType = int(*)(Vdbe*);

    int runJit() {
        if (!executionEngineCreated) {
            auto tick = std::chrono::system_clock::now();

            // Initialize LLVM targets.
            llvm::InitializeNativeTarget();
            llvm::InitializeNativeTargetAsmPrinter();
            // llvm::InitializeNativeTargetDisassembler();

            llvm::sys::DynamicLibrary::LoadLibraryPermanently(nullptr);

            executionEngineCreated = true;
            {
                auto &tempLlvmModule = *llvmModule;
                auto broken = llvm::verifyModule(tempLlvmModule, &llvm::outs());
#ifdef DEBUG_MACHINE
                if (broken) {
                    tempLlvmModule.dump();
                }
#endif
                ALWAYS_ASSERT(!broken && "Generated IR Module is invalid");

                auto passManagerBuilder = llvm::PassManagerBuilder();
                llvm::legacy::FunctionPassManager functionPassManager(&*llvmModule);
                passManagerBuilder.populateFunctionPassManager(functionPassManager);

                functionPassManager.doInitialization();
                for (llvm::Function &f : *llvmModule)
                    functionPassManager.run(f);
                functionPassManager.doFinalization();

                llvm::legacy::PassManager modulePassManager;
                passManagerBuilder.populateModulePassManager(modulePassManager);
                modulePassManager.run(*llvmModule);
                // write_to_file(*llvmModule, "after.ll");

                auto builder = llvm::EngineBuilder(std::move(llvmModule));
                auto engine = builder
                                .setEngineKind(llvm::EngineKind::JIT)
                                .setOptLevel(llvm::CodeGenOpt::Aggressive)
                                .setVerifyModules(true)
                                .create();

                ALWAYS_ASSERT(engine != nullptr && "ExecutionEngine is null!");
                jittedFunctionPointer = reinterpret_cast<decltype(jittedFunctionPointer)>(
                    engine->getFunctionAddress(JIT_MAIN_FN_NAME)
                );
                ALWAYS_ASSERT(jittedFunctionPointer != nullptr && "JITted function pointer is null!");
            }

            auto tock = system_clock::now();
            functionOptimisationTime = duration_cast<milliseconds>(tock - tick).count();
        } // if (!executionEngineCreated)

        sqlite3VdbeEnter(vdbe);
        if (vdbe->rc == SQLITE_NOMEM) {
            err("ERROR: Cannot allocate memory");
            exit(124);
        }

        int returnedValue = ((vdbeExecType)(jittedFunctionPointer))(vdbe);

        sqlite3VdbeLeave(vdbe);

        debug("Value returned by VdbeStep: " << returnedValue);

        if (returnedValue == SQLITE_DONE) {
            debug("Removing VDBE " << (void*)vdbe << " from VDBERunner cache");
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
        debug("Creating a new VDBERunner");
        auto tick = std::chrono::system_clock::now();
        runners[p] = new VdbeRunner(p);
        printTimeDifference(tick, "VdbeRunner creation");
    }

    runner = runners[p];
    auto result = runner->run();
    return result;
}
