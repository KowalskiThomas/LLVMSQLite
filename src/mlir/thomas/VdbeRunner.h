#pragma once

#include <memory>

#include "llvm/Bitcode/BitcodeReader.h"
#include "llvm/IRReader/IRReader.h"

#include "llvm/ExecutionEngine/MCJIT.h"
#include "llvm/ExecutionEngine/JITLink/JITLink.h"
#include "llvm/ExecutionEngine/ExecutionEngine.h"
#include "llvm/ExecutionEngine/GenericValue.h"
#include "llvm/Transforms/IPO/Inliner.h"
#include "llvm/Transforms/IPO.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/IRBuilder.h"
#include <llvm/IR/LegacyPassManager.h>
#include "llvm/Support/TargetSelect.h"
#include <llvm/Transforms/IPO/PassManagerBuilder.h>
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Verifier.h"
#include "llvm/IR/Type.h"
#include "llvm/Support/ManagedStatic.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Transforms/IPO/FunctionImport.h"
#include "llvm/Transforms/Utils/Cloning.h"
#include "llvm/Support/InitLLVM.h"
#include "llvm/Support/TargetSelect.h"
#include "llvm/Support/raw_ostream.h"
#include "mlir/Pass/PassManager.h"
#include "mlir/IR/Dialect.h"
#include "mlir/IR/MLIRContext.h"
#include "mlir/InitAllDialects.h"
#include "mlir/InitAllPasses.h"
#include "mlir/Pass/Pass.h"
#include "mlir/Support/MlirOptMain.h"
#include "mlir/Target/LLVMIR.h"
#include "mlir/ExecutionEngine/ExecutionEngine.h"
#include "mlir/ExecutionEngine/OptUtils.h"
#include "mlir/IR/Module.h"

#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/StandaloneDialect.h"
#include "Standalone/DebugUtils.h"
#include "Standalone/ErrorCodes.h"

#include "SQLiteBridge.h"
#include "BridgeUtils.h"

#include "VdbeHash.h"

using namespace std::chrono;

const constexpr bool shouldOptimiseModule = false;
const constexpr bool optimiseFunctions = true;
const constexpr bool optimiseCodegen = true;
const constexpr bool optimiseOthers = true;
const constexpr bool duplicateFunctions = true;
const constexpr int optLevel = 3;

extern "C" {
    SQLITE_NOINLINE void vdbeMemClear(Mem *p);
}

void initializeDialects();

[[maybe_unused]] void findUsages(llvm::Module &mod);

struct VdbeRunner {
    static inline std::unordered_map<Vdbe *, VdbeRunner *> runners;

    using MLIRContext = mlir::MLIRContext;
    using VdbeDialect = mlir::standalone::StandaloneDialect;
    using LLVMDialect = mlir::LLVM::LLVMDialect;

    MLIRContext context;
    MLIRContext *ctx;

    LLVMDialect *llvmDialect;
    VdbeDialect *vdbeDialect;

    mlir::OpBuilder builder;
    mlir::ModuleOp mlirModule;
    std::unique_ptr<llvm::Module> llvmModule;

    Vdbe *vdbe;

    ~VdbeRunner() {
        debug("Destroying runner")
    }

    VdbeRunner(Vdbe *p)
            : engine(nullptr),
              vdbe(p),
              llvmModule(nullptr),
              ctx(&context),
              llvmDialect(context.getRegisteredDialect<LLVMDialect>()),
              vdbeDialect(context.getRegisteredDialect<VdbeDialect>()),
              builder(mlir::OpBuilder(ctx)),
              moduleCreated(false),
              engineCreated(false) {
        initializeTargets();
        initializeDialects();
        initialiseTypeCache(llvmDialect);

        mlirModule = mlir::ModuleOp::create(builder.getUnknownLoc());
        vdbeDialect->setVdbe(p);

        runPrerequisites(mlirModule, llvmDialect);
    }

    VdbeRunner(Vdbe *p, std::unique_ptr<llvm::Module> module)
            : engine(nullptr),
              vdbe(p),
              ctx(nullptr),
              llvmDialect(nullptr),
              vdbeDialect(nullptr),
              llvmModule(std::move(module)),
              builder(static_cast<mlir::MLIRContext *>(nullptr)),
              moduleCreated(true),
              engineCreated(false) {
        initializeTargets();
    }

    mlir::ModuleOp &module() {
        return mlirModule;
    }

    void writeModule();

    void optimiseModule();

    int run() {
        if (!moduleCreated) {
            LLVMSQLITE_ASSERT(!engineCreated);
            debug("Creating module");
            writeModule();
            LLVMSQLITE_ASSERT(llvmModule);
            optimiseModule();
            LLVMSQLITE_ASSERT(llvmModule);
            moduleCreated = true;
        } else {
            debug("Skipping module creation");
        }

        if (!engineCreated) {
            debug("Creating EE");
            LLVMSQLITE_ASSERT(!engine);
            createExecutionEngine();
            LLVMSQLITE_ASSERT(engine);
            LLVMSQLITE_ASSERT(jittedFunctionPointer);
            engineCreated = true;
        }

        debug("Everything is ready: running");
        return runJit();
    }

    std::unique_ptr<llvm::ExecutionEngine> engine;
    std::unique_ptr<llvm::TargetMachine> machine;
    bool moduleCreated = false;
    bool engineCreated = false;

    void (*jittedFunctionPointer)(void **) = nullptr;

    using vdbeExecType = int (*)(Vdbe* p, const u8* sqlite3CtypeMap, int* iCompare, const char* percentS, char* sqlite3SmallTypeSizes);

    void initializeTargets();

    void createExecutionEngine() {
        auto tick = system_clock::now();

        debug("Creating an execution engine")
        LLVMSQLITE_ASSERT(llvmModule && "Can't create an ExecutionEngine with no LLVMModule");

        std::map<llvm::StringRef, llvm::GlobalValue *> gv;
        for (auto &gvs : llvmModule->globals())
            gv[gvs.getName()] = llvmModule->getGlobalVariable(gvs.getName());

        auto functions = std::set<std::string>{};
        for (auto &f : llvmModule->functions()) {
            if (!f.getName().empty())
                functions.insert(f.getName().str());
        }

        auto builder = llvm::EngineBuilder(std::move(llvmModule));
        std::string s;
        builder.setErrorStr(&s);

        initializeTargets();
        engine = std::unique_ptr<llvm::ExecutionEngine>
                (builder
                         .setEngineKind(llvm::EngineKind::JIT)
                         .setOptLevel(
                                 optimiseCodegen ? llvm::CodeGenOpt::Aggressive
                                                 : llvm::CodeGenOpt::None)
                         .setVerifyModules(true)
                         .create(machine.get())
                );

        if (!engine) err("Error: " << s);
        ALWAYS_ASSERT(engine != nullptr && "ExecutionEngine is null!");

        if (duplicateFunctions) {
            debug("Adding mappings");

            engine->addGlobalMapping("sqlite3Config", (uint64_t)(void *) &sqlite3Config);

            extern sqlite3_pcache_methods2 sqlite3PCacheSetDefault_defaultMethods;
            engine->addGlobalMapping("sqlite3PCacheSetDefault_defaultMethods",
                                     (uint64_t)(void *) &sqlite3PCacheSetDefault_defaultMethods);

            extern const sqlite3_mem_methods sqlite3MemSetDefault_defaultMethods;
            engine->addGlobalMapping("sqlite3MemSetDefault_defaultMethods",
                                     (uint64_t)(void *) &sqlite3MemSetDefault_defaultMethods);

            extern FuncDef sqlite3RegisterDateTimeFunctions_aDateTimeFuncs[];
            engine->addGlobalMapping("sqlite3RegisterDateTimeFunctions_aDateTimeFuncs",
                                     (uint64_t)(void *) &sqlite3RegisterDateTimeFunctions_aDateTimeFuncs);

            extern sqlite3_io_methods posixIoMethods;
            engine->addGlobalMapping("posixIoMethods",
                                     (uint64_t)(void *) &posixIoMethods);
        }

        debug("Compiling!")
        jittedFunctionPointer = reinterpret_cast<decltype(jittedFunctionPointer)>(
                engine->getFunctionAddress(JIT_MAIN_FN_NAME)
        );

        std::map<void *, llvm::StringRef> addresses;
        for (auto &fname : functions) {
            auto ptr = engine->getFunctionAddress(fname);
            addresses[(void *) ptr] = fname;
        }
        for (auto &p : addresses) {
            debug(p.first << " -> " << p.second);
        }
        ALWAYS_ASSERT(jittedFunctionPointer != nullptr && "JITted function pointer is null!");

        engineCreated = true;

        if (engine->hasError()) {
            err("Engine error: " << engine->getErrorMessage());
            exit(154);
        }

        auto tock = system_clock::now();
        functionCompilationTime = duration_cast<milliseconds>(tock - tick).count();
    }

    int runJit() {
        LLVMSQLITE_ASSERT(moduleCreated);

        debug("Entering VDBE")
        sqlite3VdbeEnter(vdbe);

        if (vdbe->rc == SQLITE_NOMEM) {
            err("ERROR: Cannot allocate memory");
            exit(OUT_OF_MEMORY);
        }

        debug("Calling now");
        extern int iCompare;
        extern char sqlite3SmallTypeSizes[];
        extern const unsigned char sqlite3CtypeMap[];
        int returnedValue = ((vdbeExecType) (jittedFunctionPointer))(
                vdbe,
                sqlite3CtypeMap,
                &iCompare,
                "%s",
                sqlite3SmallTypeSizes
        );

        sqlite3VdbeLeave(vdbe);

#if LLVMSQLITE_DEBUG
        debug("Value returned by VdbeStep: " << returnedValue);
#endif

        if (returnedValue == SQLITE_DONE) {
#ifdef LLVMSQLITE_DEBUG
            debug("Removing VDBE " << (void *) vdbe << " from VDBERunner cache");
#endif
            // TODO: Fix this memory leak
            // delete runners[vdbe];
            runners.erase(vdbe);
        }

        return returnedValue;
    }
};

