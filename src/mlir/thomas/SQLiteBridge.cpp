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

// This takes too much time:
static const constexpr bool optimiseModule = false;
static const constexpr bool optimiseFunctions = true;
static const constexpr bool optimiseCodegen = true;
static const constexpr bool optimiseOthers = true;
static const constexpr bool duplicateFunctions = true;
static const constexpr int optLevel = 3;

extern "C" {
void printTypeOf(const char *, const uint32_t, Vdbe *p, Mem *);
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

void writeToFile(const char *const fileName, std::string s) {
    // out("Writing to file " << fileName);
    auto fd = fopen(fileName, "w");
    fwrite(s.c_str(), sizeof(char), s.size(), fd);
    fclose(fd);
}

void writeToFile(const char *const fileName, mlir::ModuleOp &x) {
    std::string s;
    auto stream = llvm::raw_string_ostream(s);
    x.print(stream);
    writeToFile(fileName, s);
}

void writeToFile(const char *const fileName, llvm::Module &m) {
    std::string s;
    auto stream = llvm::raw_string_ostream(s);
    stream << m;
    writeToFile(fileName, s);
}

bool enableOpt = true;
const char *const JIT_MAIN_FN_NAME = "jittedFunction";

static auto runners = std::unordered_map<Vdbe *, VdbeRunner *>{};

unsigned long long functionPreparationTime;
unsigned long long functionOptimisationTime;

namespace llvm {
    static void copyComdat(GlobalObject *Dst, const GlobalObject *Src) {
        const Comdat *SC = Src->getComdat();
        if (!SC)
            return;
        Comdat *DC = Dst->getParent()->getOrInsertComdat(SC->getName());
        DC->setSelectionKind(SC->getSelectionKind());
        Dst->setComdat(DC);
    }
}

static void initRuntime() {
    mlir::registerAllDialects();

    using VdbeDialect = mlir::standalone::StandaloneDialect;
    mlir::registerDialect<VdbeDialect>();
}

void findUsages(llvm::Module& mod) {
    std::set<std::string> matches;
    for (auto &g : mod) {
        for (auto &block : g) {
            for (auto &inst : block) {
                if (llvm::isa<llvm::CallInst>(inst))
                    continue;

                for (auto &op : inst.operands()) {
                    if (op->getType()->isPointerTy()
                        && op->getType()->getPointerElementType()->isFunctionTy()) {
                        matches.insert(op->getName().str());
                    }
                }
            }
        }
    }
    for(auto& match : matches) {
        out('"' << match << "\", ");
    }
}

struct VdbeRunner {
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
              ctx(&context),
              llvmDialect(context.getRegisteredDialect<LLVMDialect>()),
              vdbeDialect(context.getRegisteredDialect<VdbeDialect>()),
              builder(mlir::OpBuilder(ctx)) {
        initRuntime();

        initialiseTypeCache(llvmDialect);
        mlirModule = mlir::ModuleOp::create(builder.getUnknownLoc());

        vdbeDialect->setVdbe(p);

        runPrerequisites(mlirModule, llvmDialect);
    }

    void prepareFunction() {
        ::prepareFunction(context, llvmDialect, mlirModule);

#if DEBUG_MACHINE && LLVMSQLITE_DEBUG
        writeToFile("jit_mlir_vdbe_module.mlir", mlirModule);
#endif

        mlir::PassManager pm(ctx);
        pm.addPass(std::make_unique<VdbeToLLVM>());
        pm.run(mlirModule);

#if DEBUG_MACHINE && LLVMSQLITE_DEBUG
        writeToFile("jit_mlir_llvm_module.mlir", mlirModule);
#endif

        llvmModule = mlir::translateModuleToLLVMIR(mlirModule);

#if DEBUG_MACHINE && LLVMSQLITE_DEBUG
        writeToFile("jit_llvm_unoptimised.ll", *llvmModule);
#endif
    }

    mlir::ModuleOp &module() {
        return mlirModule;
    }

    int run() {
        if (!functionPrepared) {
            auto tick = system_clock::now();
            prepareFunction();
            auto tock = system_clock::now();
            functionPreparationTime = (unsigned long long) (duration_cast<milliseconds>(tock - tick).count());
            functionPrepared = true;
        }
        return runJit();
    }

    std::unique_ptr<mlir::ExecutionEngine> engine;
    bool executionEngineCreated = false;
    bool functionPrepared = false;

    void (*jittedFunctionPointer)(void **) = nullptr;

    using vdbeExecType = int (*)(Vdbe *);

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
                auto broken = llvm::verifyModule(*llvmModule, &llvm::errs());
#ifdef DEBUG_MACHINE
                if (broken) {
                    llvmModule->dump();
                    err("Broken module found, exiting.");
                    exit(SQLITE_BRIDGE_FAILURE);
                }
#else
                if (broken) {
                    llvm_unreachable("Generated IR Module is invalid");
                }
#endif

                auto maybeHost = llvm::orc::JITTargetMachineBuilder::detectHost();
                if (!maybeHost) {
                    err("Host could not be detected: " << maybeHost.takeError());
                    exit(SQLITE_BRIDGE_FAILURE);
                }
                auto host = *maybeHost;
                llvm::orc::JITTargetMachineBuilder tmb(host);
                auto maybeMachine = tmb.createTargetMachine();
                if (!maybeMachine) {
                    err("Target machine could not be created: " << maybeMachine.takeError());
                    exit(SQLITE_BRIDGE_FAILURE);
                }
                auto &machine = *maybeMachine;
                auto targetTriple = machine->getTargetTriple();

                auto passManagerBuilder = llvm::PassManagerBuilder();
                passManagerBuilder.OptLevel = optLevel;
                passManagerBuilder.SizeLevel = 0;
                passManagerBuilder.Inliner = llvm::createFunctionInliningPass(500000);
                passManagerBuilder.MergeFunctions = optimiseOthers;
                passManagerBuilder.LoopVectorize = optimiseOthers;
                passManagerBuilder.SLPVectorize = optimiseOthers;
                passManagerBuilder.DisableUnrollLoops = !optimiseOthers;
                passManagerBuilder.RerollLoops = optimiseOthers;
                passManagerBuilder.PerformThinLTO = optimiseOthers;
                passManagerBuilder.LibraryInfo = new llvm::TargetLibraryInfoImpl(targetTriple);
                machine->adjustPassManager(passManagerBuilder);

                extern std::unique_ptr<llvm::Module> loadedModule;
                LLVMSQLITE_ASSERT(loadedModule != nullptr);

                std::unordered_map<std::string, llvm::GlobalVariable *> gv;
                if (duplicateFunctions) {
                    out("Copying function declarations");

                    llvm::ValueToValueMapTy VMap;

                    static std::unordered_set<std::string> inlined = {
                        "sqlite3VdbeMemIntegerify",
                        "applyNumericAffinity",
                        "sqlite3AtoF",
                        "alsoAnInt",
                        "sqlite3VdbeIntegerAffinity",
                        "doubleToInt64",
                        "sqlite3Atoi64"

                        "llvm.lifetime.end.p0i8",
                        "llvm.lifetime.start.p0i8",

//                        "getPageNormal",
//                        "sqlite3BtreeNext",
//                        "btreeNext",
//                        "moveToChild",
//                        "getAndInitPage",
//                        "moveToParent",
//                        "releasePageNotNull"
//                        "moveToLeftmost",

                    };

                    auto shouldCopy = [&](const llvm::Function& f) {
                        if (f.getName().startswith("llvm."))
                            return true;

                        if (inlined.find(f.getName().str()) != inlined.cend())
                            return true;

                        return false;
                    };

                    std::set<std::string> globalsToExternalise {
                        "sqlite3Config",
                        "MemJournalMethods",
                        "dotlockIoFinderImpl",
                        "posixIoMethods",
                        "sqlite3AlterFunctions.aAlterTableFuncs",
                        "sqlite3Apis",
                        "sqlite3Attach.attach_func",
                        "sqlite3Detach.detach_func",
                        "sqlite3MemSetDefault.defaultMethods",
                        "sqlite3PCacheSetDefault.defaultMethods",
                        "sqlite3RegisterBuiltinFunctions.aBuiltinFunc",
                        "sqlite3RegisterDateTimeFunctions.aDateTimeFuncs",
                        "sqlite3WindowFunctions.aWindowFuncs",
                        "sqlite3_os_init.aVfs",
                        "statGetFuncdef",
                        "statInitFuncdef",
                        "statPushFuncdef",
                        "flockIoMethods",
                        "proxyIoMethods",
                        "dotlockIoMethods",
                        "nfsIoMethods",
                        "aSyscall",
                        "nolockIoMethods",
                        "afpIoMethods",

                        "autolockIoFinderImpl",
                        "nolockIoFinderImpl",
                        "dotlockIoFinderImpl",
                        "posixIoFinderImpl",
                        "flockIoFinderImpl",
                        "afpIoFinderImpl",
                        "nfsIoFinderImpl",
                        "proxyIoFinderImpl",

                        "autolockIoFinder",
                        "nolockIoFinder",
                        "dotlockIoFinder",
                        "posixIoFinder",
                        "flockIoFinder",
                        "afpIoFinder",
                        "nfsIoFinder",
                        "proxyIoFinder",
                    };

                    // Copy globals
                    for (auto I = loadedModule->global_begin(), E = loadedModule->global_end(); I != E; ++I) {
                        llvm::GlobalVariable *GV;
                        GV = new llvm::GlobalVariable(*llvmModule,
                                                      I->getValueType(),
                                                      I->isConstant(),
                                                      I->getLinkage(),
                                                      (llvm::Constant *) nullptr,
                                                      I->getName(),
                                                      (llvm::GlobalVariable *) nullptr,
                                                      I->getThreadLocalMode(),
                                                      I->getType()->getAddressSpace());
                        out("Copying " << GV->getName());

                        if (globalsToExternalise.find(I->getName().str()) != globalsToExternalise.cend())
                            GV->setExternallyInitialized(true);

                        GV->copyAttributesFrom(&*I);
                        VMap[&*I] = GV;
                        gv[GV->getName().str()] = GV;
                    }

                    findUsages(*loadedModule);

                    // Copy function declarations
                    for (const llvm::Function &I : *loadedModule) {
                        if (!shouldCopy(I)) {
                            continue;
                        } else {
                            out("Inlining " << I.getName());
                        }

                        auto* NF = llvmModule->getFunction(I.getName());
                        if (!NF) {
                            // If we don't already have that function declared, add it
                            NF = llvm::Function::Create(
                                    llvm::cast<llvm::FunctionType>(I.getValueType()),
                                    I.getLinkage(),
                                    I.getAddressSpace(), I.getName(), llvmModule.get());
                        }

                        NF->copyAttributesFrom(&I);
                        VMap[&I] = NF;
                    }

                    out("Copying alias declarations");
                    // Loop over the aliases in the module
                    for (auto I = loadedModule->alias_begin(), E = loadedModule->alias_end(); I != E; ++I) {
                        if (false) {
                            // An alias cannot act as an external reference, so we need to create
                            // either a function or a global variable depending on the value type.
                            // FIXME: Once pointee types are gone we can probably pick one or the
                            // other.
                            llvm::GlobalValue *GV;
                            if (I->getValueType()->isFunctionTy())
                                GV = llvm::Function::Create(llvm::cast<llvm::FunctionType>(I->getValueType()),
                                                            llvm::GlobalValue::ExternalLinkage,
                                                            I->getAddressSpace(), I->getName(), llvmModule.get());
                            else
                                GV = new llvm::GlobalVariable(
                                        *llvmModule, I->getValueType(), false, llvm::GlobalValue::ExternalLinkage,
                                        nullptr, I->getName(), nullptr,
                                        I->getThreadLocalMode(), I->getType()->getAddressSpace());
                            VMap[&*I] = GV;
                            // We do not copy attributes (mainly because copying between different
                            // kinds of globals is forbidden), but this is generally not required for
                            // correctness.
                            continue;
                        }
                        auto *GA = llvm::GlobalAlias::create(I->getValueType(),
                                                             I->getType()->getPointerAddressSpace(),
                                                             I->getLinkage(), I->getName(), llvmModule.get());
                        GA->copyAttributesFrom(&*I);
                        VMap[&*I] = GA;
                    }

                    out("Copying globals");
                    for (auto I = loadedModule->global_begin(), E = loadedModule->global_end(); I != E; ++I) {
                        if (I->isDeclaration())
                            continue;

                        llvm::GlobalVariable *GV = llvm::cast<llvm::GlobalVariable>(VMap[&*I]);
                        if (globalsToExternalise.find(GV->getName().str()) != globalsToExternalise.cend()) {
                            // Skip after setting the correct linkage for an external reference.
                            GV->setLinkage(llvm::GlobalValue::ExternalLinkage);
                            continue;
                        }

                        if (I->hasInitializer())
                            GV->setInitializer(MapValue(I->getInitializer(), VMap));

                        llvm::SmallVector<std::pair<unsigned, llvm::MDNode *>, 1> MDs;
                        I->getAllMetadata(MDs);
                        for (auto MD : MDs)
                            GV->addMetadata(MD.first,
                                            *MapMetadata(MD.second, VMap, llvm::RF_MoveDistinctMDs));

                        llvm::copyComdat(GV, &*I);
                    }

                    out("Copying function bodies")
                    for (const llvm::Function &I : *loadedModule) {
                        if (I.isDeclaration())
                            continue;

                        if (inlined.find(I.getName().str()) == inlined.cend()) {
                            // Skip after setting the correct linkage for an external reference.
                            // F->setLinkage(llvm::GlobalValue::ExternalLinkage);
                            // Personality function is not valid on a declaration.
                            out("Not copying body of " << I.getName());
                            // F->setPersonalityFn(nullptr);
                            continue;
                        }

                        llvm::Function *F = llvm::cast<llvm::Function>(VMap[&I]);
                        llvm::Function::arg_iterator DestI = F->arg_begin();
                        for (llvm::Function::const_arg_iterator J = I.arg_begin(); J != I.arg_end();
                             ++J) {
                            DestI->setName(J->getName());
                            VMap[&*J] = &*DestI++;
                        }

                        llvm::SmallVector<llvm::ReturnInst *, 8> Returns; // Ignore returns cloned.
                        CloneFunctionInto(F, &I, VMap, /*ModuleLevelChanges=*/true, Returns);

                        if (I.hasPersonalityFn())
                            F->setPersonalityFn(MapValue(I.getPersonalityFn(), VMap));

                        copyComdat(F, &I);

                        if (inlined.find(F->getName().str()) != inlined.cend()) {
                            F->addFnAttr(llvm::Attribute::AlwaysInline);
                            F->removeFnAttr(llvm::Attribute::NoInline);
                            F->removeFnAttr(llvm::Attribute::OptimizeNone);
                        }
                    }

                    out("Copying alias bodies")
                    for (auto I = loadedModule->alias_begin(), E = loadedModule->alias_end();
                         I != E; ++I) {
                        // We already dealt with undefined aliases above.
                        llvm::GlobalAlias *GA = llvm::cast<llvm::GlobalAlias>(VMap[&*I]);
                        if (const llvm::Constant *C = I->getAliasee())
                            GA->setAliasee(MapValue(C, VMap));
                    }

                    const auto *LLVM_DBG_CU = loadedModule->getNamedMetadata("llvm.dbg.cu");
                    for (auto I = loadedModule->named_metadata_begin(), E = loadedModule->named_metadata_end();
                         I != E; ++I) {
                        const llvm::NamedMDNode &NMD = *I;
                        llvm::NamedMDNode *NewNMD = llvmModule->getOrInsertNamedMetadata(NMD.getName());
                        if (&NMD == LLVM_DBG_CU) {
                            // Do not insert duplicate operands.
                            llvm::SmallPtrSet<const void *, 8> Visited;
                            for (const auto *Operand : NewNMD->operands())
                                Visited.insert(Operand);
                            for (const auto *Operand : NMD.operands()) {
                                auto *MappedOperand = MapMetadata(Operand, VMap);
                                if (Visited.insert(MappedOperand).second)
                                    NewNMD->addOperand(MappedOperand);
                            }
                        } else
                            for (unsigned i = 0, e = NMD.getNumOperands(); i != e; ++i)
                                NewNMD->addOperand(MapMetadata(NMD.getOperand(i), VMap));
                    }

                    writeToFile("jit_llvm_with_functions.ll", *llvmModule);
                }

                if (optimiseFunctions) {
                    out("Optimising functions")
                    // Create the FunctionPassManager
                    llvm::legacy::FunctionPassManager functionPassManager(&*llvmModule);
                    passManagerBuilder.populateFunctionPassManager(functionPassManager);
                    functionPassManager.add(llvm::createTargetTransformInfoWrapperPass(machine->getTargetIRAnalysis()));

                    // Optimise functions
                    functionPassManager.doInitialization();
                    for (llvm::Function &f : *llvmModule)
                        functionPassManager.run(f);
                    functionPassManager.doFinalization();

#if DEBUG_MACHINE && LLVMSQLITE_DEBUG
                    writeToFile("jit_llvm_after_functions_opt.ll", *llvmModule);
#endif
                }

                if (optimiseModule) {
                    out("Optimising the module")
                    // Create the ModulePassManager
                    llvm::legacy::PassManager modulePassManager;
                    passManagerBuilder.populateModulePassManager(modulePassManager);
                    modulePassManager.add(llvm::createTargetTransformInfoWrapperPass(machine->getTargetIRAnalysis()));

                    // Optimise the module
                    modulePassManager.run(*llvmModule);

#if DEBUG_MACHINE && LLVMSQLITE_DEBUG
                    writeToFile("jit_llvm_after_module_opt.ll", *llvmModule);
#endif
                }

                out("Module preparation done");
                writeToFile("jit_llvm_final.ll", *llvmModule);

                auto functions = std::set<llvm::StringRef>{};
                for(auto& f : llvmModule->functions()) {
                    functions.insert(f.getName());
                }

                out("Creating an execution engine")
                // Create an ExecutionEngine
                auto builder = llvm::EngineBuilder(std::move(llvmModule));
                auto engine = builder
                        .setEngineKind(llvm::EngineKind::JIT)
                        .setOptLevel(optimiseCodegen ? llvm::CodeGenOpt::Aggressive : llvm::CodeGenOpt::None)
                        .setVerifyModules(true)
                        .create();
                ALWAYS_ASSERT(engine != nullptr && "ExecutionEngine is null!");

                if (duplicateFunctions) {
                    engine->addGlobalMapping(gv["sqlite3Config"], (void*)&sqlite3Config);

                    extern sqlite3_pcache_methods2 sqlite3PCacheSetDefault_defaultMethods;
                    engine->addGlobalMapping(gv["sqlite3PCacheSetDefault.defaultMethods"], (void*)&sqlite3PCacheSetDefault_defaultMethods);

                    extern const sqlite3_mem_methods sqlite3MemSetDefault_defaultMethods;
                    engine->addGlobalMapping(gv["sqlite3MemSetDefault.defaultMethods"], (void*)&sqlite3MemSetDefault_defaultMethods);

                    extern FuncDef sqlite3RegisterDateTimeFunctions_aDateTimeFuncs[];
                    engine->addGlobalMapping(gv["sqlite3RegisterDateTimeFunctions.aDateTimeFuncs"], (void*)&sqlite3RegisterDateTimeFunctions_aDateTimeFuncs);

                    extern sqlite3_io_methods posixIoMethods;
                    engine->addGlobalMapping(gv["posixIoMethods"], (void*)&posixIoMethods);
                }

                out("Compiling!")
                jittedFunctionPointer = reinterpret_cast<decltype(jittedFunctionPointer)>(
                        engine->getFunctionAddress(JIT_MAIN_FN_NAME)
                );

                std::map<void*, llvm::StringRef> addresses;
                for(auto& fname : functions) {
                    auto ptr = engine->getFunctionAddress(fname.str());
                    addresses[(void*)ptr] = fname;
                }
                for(auto& p : addresses) {
                    debug(p.first << " -> " << p.second);
                }
                ALWAYS_ASSERT(jittedFunctionPointer != nullptr && "JITted function pointer is null!");
            }

            auto tock = system_clock::now();
            functionOptimisationTime = duration_cast<milliseconds>(tock - tick).count();
        } // if (!executionEngineCreated)

        out("Entering VDBE")
        sqlite3VdbeEnter(vdbe);

        if (vdbe->rc == SQLITE_NOMEM) {
            err("ERROR: Cannot allocate memory");
            exit(OUT_OF_MEMORY);
        }

        debug("Calling now");
        int returnedValue = ((vdbeExecType) (jittedFunctionPointer))(vdbe);

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

int jitVdbeStep(Vdbe *p) {
    initRuntime();

    VdbeRunner *runner = nullptr;
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
