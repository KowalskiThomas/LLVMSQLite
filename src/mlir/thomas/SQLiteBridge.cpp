#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/StandalonePassManager.h"
#include "Standalone/StandaloneDialect.h"
#include "Standalone/ErrorCodes.h"
#include "Standalone/DebugUtils.h"

#include "SQLiteBridge.h"

#include "llvm/Bitcode/BitcodeReader.h"
#include "llvm/Bitcode/BitcodeWriter.h"
#include "llvm/IRReader/IRReader.h"

#include "llvm/ADT/STLExtras.h"
#include "llvm/ExecutionEngine/ExecutionEngine.h"
#include "llvm/ExecutionEngine/GenericValue.h"
#include "llvm/IR/Argument.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/Transforms/IPO/Inliner.h"
#include "llvm/Transforms/IPO.h"
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
#include "llvm/Transforms/IPO/FunctionImport.h"
#include "llvm/Transforms/Utils/Cloning.h"

#include "Standalone/TypeDefinitions.h"

extern "C" {
void printTypeOf(const char*, const uint32_t, Vdbe *p, Mem *);
}

namespace llvm {
    struct TypeRemapper : public ValueMapTypeRemapper {
        Module& mod;
        std::unordered_map<Type*, Type*> cache;

        TypeRemapper(Module& m)
            : mod(m)
        {
        }

        virtual Type *remapType(Type *ty) {
            if (cache.find(ty) != cache.cend()) {
                return cache[ty];
            }

            if (ty->isStructTy()) {
                auto sTy = llvm::cast<llvm::StructType>(ty);
                if (sTy->isLiteral())
                    return ty;

                // Try to find an equivalent type in our module
                auto nameFrom = ty->getStructName();
                StringRef nameTo;
                if (nameFrom.startswith("struct."))
                    nameTo = nameFrom.slice(7, nameFrom.size());
                else if (nameFrom.startswith("union."))
                    nameTo = nameFrom.slice(6, nameFrom.size());
                else {
                    err("Can't convert type " << *ty);
                    llvm_unreachable("Can't convert this type!");
                }

                auto toTy = mod.getTypeByName(nameTo);
                if (toTy == nullptr) {
                    out("Can't find " << ty->getStructName() << " as '" << nameTo << "'");

                    toTy = StructType::create(mod.getContext(), nameTo);
                    LLVMSQLITE_ASSERT(toTy->isOpaque());
                    cache[ty] = toTy;

                    if (!sTy->isOpaque()) {
                        SmallVector<Type*, 16> types;
                        for(int i = 0; i < sTy->getStructNumElements(); i++) {
                            auto iTh = remapType(sTy->getStructElementType(i));
                            types.push_back(iTh);
                        }
                        toTy->setBody(types, sTy->isPacked());
                    }

                    out("  -> Defined new type " << *toTy);
                    return ty;
                } else {
                    if (toTy->isOpaque() && !sTy->isOpaque()) {
                        cache[ty] = toTy;

                        SmallVector<Type*, 16> types;
                        for(int i = 0; i < sTy->getStructNumElements(); i++) {
                            auto iTh = remapType(sTy->getStructElementType(i));
                            types.push_back(iTh);
                        }

                        toTy->setBody(types, sTy->isPacked());

                        out("De-opaqued " << *sTy << " to " << *toTy);
                    } else {
                        out("Remapped '" << ty->getStructName() << " to '" << toTy->getStructName() << "'");
                        return toTy;
                    }
                }
            } else if (ty->isPointerTy()) {
                return cache[ty] = remapType(ty->getPointerElementType())->getPointerTo();
            }

            err("Could not remap type '" << *ty << "'");
            llvm_unreachable("Could not remap type!");
            return nullptr;
        }

        std::unordered_map<FunctionType*, FunctionType*> funcCache;
        FunctionType* remapFunctionType(FunctionType* ty) {
            if (funcCache.find(ty) != funcCache.cend())
                return funcCache[ty];

            auto resultTy = remapType(ty->getReturnType());
            SmallVector<Type*, 16> paramTy;
            for(int i = 0; i < ty->getNumParams(); i++) {
                paramTy.push_back(remapType(ty->getParamType(i)));
            }

            auto result = FunctionType::get(resultTy, paramTy, false);
            // out("In type: " << *ty << " Out ty: " << *result);
            return funcCache[ty] = result;
        }
    };
}

using namespace std::chrono;

class VdbeRunner;

template<typename T>
void printTimeDifference(time_point<T> tick, std::string msg) {
    auto tock = system_clock::now();
    auto diff = tock - tick;
    printf("%s time difference: %llu ms\n",
           msg.c_str(),
           duration_cast<milliseconds>(diff).count());
}

void writeToFile(const char* const fileName, std::string s) {
    // out("Writing to file " << fileName);
    auto fd = fopen(fileName, "w");
    fwrite(s.c_str(), sizeof(char), s.size(), fd);
    fclose(fd);
}

void writeToFile(const char* const fileName, mlir::ModuleOp& x) {
    std::string s;
    auto stream = llvm::raw_string_ostream(s);
    x.print(stream);
    writeToFile(fileName, s);
}

void writeToFile(const char* const fileName, llvm::Module& m) {
    std::string s;
    auto stream = llvm::raw_string_ostream(s);
    stream << m;
    writeToFile(fileName, s);
}

bool enableOpt = true;
const char* const JIT_MAIN_FN_NAME = "jittedFunction";

static auto runners = std::unordered_map<Vdbe*, VdbeRunner*>{};

unsigned long long functionPreparationTime;
unsigned long long functionOptimisationTime;

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

#if DEBUG_MACHINE && LLVMSQLITE_DEBUG
        writeToFile("jit_mlir_vdbe_module.ll", mlirModule);
#endif

        mlir::PassManager pm(ctx);
        pm.addPass(std::make_unique<VdbeToLLVM>());
        pm.run(mlirModule);

#if DEBUG_MACHINE && LLVMSQLITE_DEBUG
        writeToFile("jit_mlir_llvm_module.ll", mlirModule);
#endif

        llvmModule = mlir::translateModuleToLLVMIR(mlirModule);

#if DEBUG_MACHINE && LLVMSQLITE_DEBUG
        writeToFile("jit_llvm_unoptimised.ll", *llvmModule);
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

            { // Initialize LLVM targets.
                bool error = llvm::InitializeNativeTarget();
                ALWAYS_ASSERT(!error && "InitializeNativeTarget returned an error!");

                error = llvm::InitializeNativeTargetAsmPrinter();
                ALWAYS_ASSERT(!error && "InitializeNativeTargetAsmPrinter returned an error!");

                // TODO: Get that to work: llvm::InitializeNativeTargetDisassembler();
            } // End Initialize LLVM targets.

            llvm::sys::DynamicLibrary::LoadLibraryPermanently(nullptr);

            executionEngineCreated = true;
            {
                auto broken = llvm::verifyModule(*llvmModule, &llvm::outs());
#ifdef DEBUG_MACHINE
                if (broken) {
                    llvmModule->dump();
                    err("Broken module found, exiting.");
                    exit(SQLITE_BRIDGE_FAILURE);
                }
#endif
                if(broken) {
                    llvm_unreachable("Generated IR Module is invalid");
                }

                auto maybeHost = llvm::orc::JITTargetMachineBuilder::detectHost();
                if (!maybeHost) {
                    err("Host could not be detected: " << maybeHost.takeError());
                    exit(SQLITE_BRIDGE_FAILURE);
                }
                auto host = *maybeHost;
                llvm::orc::JITTargetMachineBuilder tmb(host);
                auto maybeMachine = tmb.createTargetMachine();
                if (!maybeMachine) {
                    out("Target machine could not be created: " <<maybeMachine.takeError());
                    exit(SQLITE_BRIDGE_FAILURE);
                }
                auto& machine = *maybeMachine;
                auto targetTriple = machine->getTargetTriple();

                auto passManagerBuilder = llvm::PassManagerBuilder();
                passManagerBuilder.OptLevel = 3;
                passManagerBuilder.SizeLevel = 0;
                passManagerBuilder.Inliner = llvm::createFunctionInliningPass();
                passManagerBuilder.MergeFunctions = true;
                passManagerBuilder.LoopVectorize = true;
                passManagerBuilder.SLPVectorize = true;
                passManagerBuilder.DisableUnrollLoops = false;
                passManagerBuilder.RerollLoops = true;
                passManagerBuilder.PerformThinLTO = true;
                passManagerBuilder.LibraryInfo = new llvm::TargetLibraryInfoImpl(targetTriple);
                machine->adjustPassManager(passManagerBuilder);

                llvm::SMDiagnostic diag;
                out("Loading sqlite3.ll");
                auto loadedModule = llvm::parseIRFile("sqlite3.ll", diag, llvmDialect->getLLVMContext());
                if (!loadedModule) {
                    err("Error while loading module: " << diag.getMessage());
                    exit(SQLITE_BRIDGE_FAILURE);
                }

                LLVMSQLITE_ASSERT(loadedModule != nullptr);

#define LLVMSQLITE_DUPLICATE_FUNCTIONS true
#if LLVMSQLITE_DUPLICATE_FUNCTIONS
                auto typeMap = llvm::TypeRemapper{*llvmModule};
                for(auto& func : loadedModule->functions())
                {
                    auto cloneFrom = &func;
                    LLVMSQLITE_ASSERT(cloneFrom != nullptr);

                    auto cloneIn = llvmModule->getFunction(cloneFrom->getName());
                    if (cloneIn == nullptr) {
                        auto f = llvm::Function::Create(
                            typeMap.remapFunctionType(cloneFrom->getFunctionType()),
                            llvm::GlobalValue::ExternalLinkage,
                            cloneFrom->getName(),
                            *llvmModule
                        );
                        cloneIn = f;
                    }
                    LLVMSQLITE_ASSERT(cloneIn != nullptr);

                    llvm::SmallVector<llvm::ReturnInst*, 16> returns;
                    llvm::ValueToValueMapTy map;

                    auto itFrom = cloneFrom->arg_begin();
                    auto itTo = cloneIn->arg_begin();

                    while (itFrom != cloneFrom->arg_end()) {
                        LLVMSQLITE_ASSERT(itTo != cloneIn->arg_end());
                        map[&*itFrom] = itTo;

                        ++itFrom, ++itTo;
                    }

                    if (cloneFrom->begin() != cloneFrom->end())
                        llvm::CloneFunctionInto(cloneIn, cloneFrom, map, false, returns, "", nullptr, &typeMap);
                }

                writeToFile("debug.ll", *llvmModule);

                for(auto& func : llvmModule->functions()) {
                    for(auto& bb : func) {
                        for (auto& i : bb.getInstList()) {
                            llvm::Instruction& inst = i;
                            auto callInst = llvm::dyn_cast<llvm::CallBase>(&inst);
                            if (callInst) {
                                auto calledFunction = callInst->getCalledFunction();
                                if (!calledFunction || !calledFunction->hasName())
                                    continue;

                                auto newCalled = llvmModule->getOrInsertFunction(calledFunction->getName(), typeMap.remapFunctionType(calledFunction->getFunctionType()));
                                // out("OldCalled: " << *(calledFunction->getFunctionType()));
                                // out("NewCalled: " << *(newCalled.getFunctionType()) << " / " << newCalled.getCallee()->getName());
                                callInst->setCalledFunction(newCalled);
                            }
                        }
                    }
                }
#endif

                // Create the FunctionPassManager
                llvm::legacy::FunctionPassManager functionPassManager(&*llvmModule);
                passManagerBuilder.populateFunctionPassManager(functionPassManager);
                functionPassManager.add(llvm::createTargetTransformInfoWrapperPass(machine->getTargetIRAnalysis()));

                // Optimise functions
                functionPassManager.doInitialization();
                for (llvm::Function &f : *llvmModule)
                    functionPassManager.run(f);
                functionPassManager.doFinalization();

                // Create the ModulePassManager
                llvm::legacy::PassManager modulePassManager;
                passManagerBuilder.populateModulePassManager(modulePassManager);
                modulePassManager.add(llvm::createTargetTransformInfoWrapperPass(machine->getTargetIRAnalysis()));

#if !LLVMSQLITE_DUPLICATE_FUNCTIONS
                // Optimise the module
                modulePassManager.run(*llvmModule);
#endif

#if DEBUG_MACHINE && LLVMSQLITE_DEBUG
                writeToFile("jit_llvm_optimised.ll", *llvmModule);
#endif

                // Create an ExecutionEngine
                auto builder = llvm::EngineBuilder(std::move(llvmModule));
                auto engine = builder
                                .setEngineKind(llvm::EngineKind::JIT)
                                .setOptLevel(llvm::CodeGenOpt::Aggressive)
                                .setVerifyModules(true)
                                .create();
                ALWAYS_ASSERT(engine != nullptr && "ExecutionEngine is null!");

                // Add the sqlite3.ll module to the ExecutionEngine
                // engine->addModule(std::move(loadedModule));

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
            exit(OUT_OF_MEMORY);
        }

        int returnedValue = ((vdbeExecType)(jittedFunctionPointer))(vdbe);

        sqlite3VdbeLeave(vdbe);

#if LLVMSQLITE_DEBUG
        debug("Value returned by VdbeStep: " << returnedValue);
#endif

        if (returnedValue == SQLITE_DONE) {
#ifdef LLVMSQLITE_DEBUG
            debug("Removing VDBE " << (void*)vdbe << " from VDBERunner cache");
#endif
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
#if LLVMSQLITE_DEBUG
        debug("Creating a new VDBERunner");
#endif
        auto tick = std::chrono::system_clock::now();
        runners[p] = new VdbeRunner(p);
        printTimeDifference(tick, "VdbeRunner creation");
    }

    runner = runners[p];
    auto result = runner->run();
    return result;
}
