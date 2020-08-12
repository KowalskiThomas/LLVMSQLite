#include "SQLiteBridge.h"
#include "VdbeRunner.h"

#include <chrono>

#include "llvm/Transforms/IPO/PassManagerBuilder.h"
#include "llvm-c/Transforms/PassManagerBuilder.h"
#include "llvm/ADT/STLExtras.h"
#include "llvm/ADT/SmallVector.h"
#include "llvm/Analysis/BasicAliasAnalysis.h"
#include "llvm/Analysis/CFLAndersAliasAnalysis.h"
#include "llvm/Analysis/CFLSteensAliasAnalysis.h"
#include "llvm/Analysis/GlobalsModRef.h"
#include "llvm/Analysis/InlineCost.h"
#include "llvm/Analysis/Passes.h"
#include "llvm/Analysis/ScopedNoAliasAA.h"
#include "llvm/Analysis/TargetLibraryInfo.h"
#include "llvm/Analysis/TypeBasedAliasAnalysis.h"
#include "llvm/IR/DataLayout.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/IR/Verifier.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/ManagedStatic.h"
#include "llvm/Transforms/AggressiveInstCombine/AggressiveInstCombine.h"
#include "llvm/Transforms/IPO.h"
#include "llvm/Transforms/IPO/Attributor.h"
#include "llvm/Transforms/IPO/ForceFunctionAttrs.h"
#include "llvm/Transforms/IPO/FunctionAttrs.h"
#include "llvm/Transforms/IPO/InferFunctionAttrs.h"
#include "llvm/Transforms/InstCombine/InstCombine.h"
#include "llvm/Transforms/Instrumentation.h"
#include "llvm/Transforms/Scalar.h"
#include "llvm/Transforms/Scalar/GVN.h"
#include "llvm/Transforms/Scalar/InstSimplifyPass.h"
#include "llvm/Transforms/Scalar/LICM.h"
#include "llvm/Transforms/Scalar/LoopUnrollPass.h"
#include "llvm/Transforms/Scalar/SimpleLoopUnswitch.h"
#include "llvm/Transforms/Utils.h"
#include "llvm/Transforms/Vectorize.h"
#include "llvm/Transforms/Vectorize/LoopVectorize.h"
#include "llvm/Transforms/Vectorize/SLPVectorizer.h"
#include "llvm/Transforms/Vectorize/VectorCombine.h"


#include "Standalone/StandalonePassManager.h"

#define LLVMSQLITE_FORCE_ENABLE_DUMPTODISK false
#define LLVMSQLITE_FORCE_DISABLE_DUMPTODISK true

#if LLVMSQLITE_DEBUG && !LLVMSQLITE_FORCE_ENABLE_DUMPTODISK
#if LLVMSQLITE_FORCE_ENABLE_DUMPTODISK
#define LLVMSQLITE_DUMPTODISK true
#else
#define LLVMSQLITE_DUMPTODISK false
#endif
#else
#define LLVMSQLITE_DUMPTODISK true
#endif

/** Copyright / legal / plagiarism notice
 * This file is very much inspired (and copy / pasted from)
 * the following official LLVM CloneModule.cpp file.
 * Though much of it has been modified because the use case is
 * different here, the core features are taken from it:
 * https://llvm.org/doxygen/CloneModule_8cpp_source.html
 **/

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

void VdbeRunner::writeModule() {
    auto tick = high_resolution_clock::now();
    ::writeFunction(context, llvmDialect, mlirModule);

#if DEBUG_MACHINE && LLVMSQLITE_DEBUG
    writeToFile("jit_mlir_vdbe_module.mlir", mlirModule);
#endif

    mlir::PassManager pm(ctx);
    pm.addPass(std::make_unique<VdbeToLLVM>());
    pm.run(mlirModule);

#if DEBUG_MACHINE && LLVMSQLITE_DEBUG
    writeToFile("jit_mlir_llvm_module.mlir", mlirModule);
#endif

    llvmModule = std::move(mlir::translateModuleToLLVMIR(mlirModule));

#if DEBUG_MACHINE && LLVMSQLITE_DEBUG
    writeToFile("jit_llvm_unoptimised.ll", *llvmModule);
#endif
    auto tock = high_resolution_clock::now();
    functionPreparationTime = (unsigned long long) (duration_cast<milliseconds>(tock - tick).count());
}

void VdbeRunner::optimiseModule() {
    auto tick = high_resolution_clock::now();
    initializeTargets();

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

    LLVMSQLITE_ASSERT(machine);

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
    debug("Triple: " << machine->getTargetTriple().getTriple());

    extern std::unique_ptr<llvm::Module> loadedModule;
    LLVMSQLITE_ASSERT(loadedModule != nullptr);

    std::unordered_map<std::string, llvm::GlobalVariable *> gv;
    if (duplicateFunctions) {
        debug("Copying function declarations");

        llvm::ValueToValueMapTy VMap;

        static std::unordered_set<std::string> inlined = {
                "sqlite3VdbeMemIntegerify",
                "applyNumericAffinity",
                "sqlite3AtoF",
                "alsoAnInt",
                "sqlite3VdbeIntegerAffinity",
                "doubleToInt64",
                "sqlite3Atoi64",
                "sqlite3VdbeMemRealify",
                "sqlite3BtreeCursorHintFlags",
                "sqlite3VdbeMemShallowCopy",
                "sqlite3VdbeMemNulTerminate",
                "sqlite3VdbeRecordUnpack",
                "sqlite3GetVarint",
                "sqlite3VdbeSerialGet",
                "sqlite3AddInt64",
                "sqlite3SubInt64",
                "numericType",
                "sqlite3VdbeRealValue",
                "sqlite3MulInt64",
                "sqlite3IsNaN",
                "sqlite3VdbeIntValue",
                "applyAffinity",
                "sqlite3VdbeMemShallowCopy",
                "sqlite3VdbeMemExpandBlob",
                "sqlite3VdbeMemTooBig",
                // "sqlite3BtreeMovetoUnpacked",
                "sqlite3BtreeLast",
                "sqlite3PutVarint",
                "sqlite3VarintLen",
                "sqlite3VdbeMemClearAndResize",
                "sqlite3VdbeSerialPut"
        };

        auto shouldInline = [&](const llvm::Function &f) {
            if (!doInlining)
                return false;

            if (inlined.find(f.getName().str()) != inlined.cend()) {
                debug("Should inline " << f.getName());
                return true;
            }

            debug("Skipping inlining of " << f.getName());
            return false;
        };

        auto shouldCopyNoInline = [&](const llvm::Function &f) {
            if (f.getName().startswith("llvm.")) {
                return true;
            }

            static auto toCopyNoInline = std::set<std::string>{
/*                    "vdbeMemClearExternAndSetNull",
                    "sqlite3_log",
                    "getAndInitPage",
                    "sqlite3PcacheRelease",
                    "btreeMoveto",
                    "sqlite3VdbeMemGrow",
                    "sqlite3VdbeMemTranslate",
                    "vdbeMemAddTerminator",
                    "strlen",*/
            };

            auto shouldCopy = toCopyNoInline.find(f.getName().str()) != toCopyNoInline.cend();
            if (shouldCopy) debug("Should copy " << f.getName());
            return shouldCopy;
        };

        std::set<std::string> globalsToExternalise{
                "sqlite3Config",
                "MemJournalMethods",
                "dotlockIoFinderImpl",
                "posixIoMethods",
                "sqlite3AlterFunctions.aAlterTableFuncs",
                "sqlite3Apis",
                "sqlite3Attach.attach_func",
                "sqlite3RegisterBuiltinFunctions.aBuiltinFunc",
                "sqlite3Detach.detach_func",
                "sqlite3MemSetDefault_defaultMethods",
                "sqlite3PCacheSetDefault_defaultMethods",
                "sqlite3RegisterBuiltinFunctions_aBuiltinFunc",
                "sqlite3RegisterDateTimeFunctions_aDateTimeFuncs",
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

            if (globalsToExternalise.find(I->getName().str()) != globalsToExternalise.cend())
                GV->setExternallyInitialized(true);

            GV->copyAttributesFrom(&*I);
            VMap[&*I] = GV;
            gv[GV->getName().str()] = GV;
        }

        // Copy function declarations
        for (const llvm::Function &I : *loadedModule) {
            debug("Copying declaration of " << I.getName());
            auto *NF = llvmModule->getFunction(I.getName());
            if (!NF) {
                // If we don't already have that function declared, add it
                NF = llvm::Function::Create(
                        llvm::cast<llvm::FunctionType>(I.getValueType()),
                        llvm::GlobalValue::ExternalLinkage,
                        I.getAddressSpace(),
                        I.getName(),
                        llvmModule.get()
                );
            }

            NF->copyAttributesFrom(&I);
            VMap[&I] = NF;
        }

        debug("Copying alias declarations");
        // Loop over the aliases in the module
        for (auto I = loadedModule->alias_begin(), E = loadedModule->alias_end(); I != E; ++I) {
            if (false) {
                // An alias cannot act as an external reference, so we need to create
                // either a function or a global variable depending on the value type.
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
            auto *GA = llvm::GlobalAlias::create(
                    I->getValueType(),
                    I->getType()->getPointerAddressSpace(),
                    I->getLinkage(),
                    I->getName(),
                    llvmModule.get()
            );
            debug("Copying GV " << GA->getName());
            GA->copyAttributesFrom(&*I);
            VMap[&*I] = GA;
        }

        debug("Copying globals");
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

            copyComdat(GV, &*I);
        }

        debug("Copying function bodies")
        for (const llvm::Function &I : *loadedModule) {
            if (I.isDeclaration()) {
                continue;
            }

            llvm::Function *F = llvm::cast<llvm::Function>(VMap[&I]);
            if (!shouldInline(I) && !shouldCopyNoInline(I)) {
                F->setCallingConv(llvm::CallingConv::C);
                debug("Not copying body of " << I.getName());
                continue;
            }

            if (I.getParent() != loadedModule.get()) {
                debug("Not in current module: " << I.getName());
                continue;
            }

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

            F->setCallingConv(llvm::CallingConv::C);
            if (shouldInline(*F)) {
                F->addFnAttr(llvm::Attribute::AlwaysInline);
                F->removeFnAttr(llvm::Attribute::NoInline);
                F->removeFnAttr(llvm::Attribute::OptimizeNone);
            }
        }

        debug("Copying alias bodies")
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

        for (auto &g : *llvmModule) {
            for (auto &block : g) {
                for (auto &inst : block) {
                    if (llvm::isa<llvm::CallInst>(inst)) {
                        auto &callInst = llvm::cast<llvm::CallInst>(inst);
                        auto calledFunction = callInst.getCalledFunction();
                        if (true) { // (calledFunction && !shouldInline(*calledFunction)) {
                            callInst.setCallingConv(llvm::CallingConv::C);
                            callInst.setTailCall(false);
                        }
                    }
                }
            }
        }


        writeToFile("jit_llvm_with_functions.ll", *llvmModule);
    }

    if (optimiseFunctions) {
        debug("Optimising functions")
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

    if (shouldOptimiseModule) {
        debug("Optimising the module")
        // Create the ModulePassManager
        llvm::legacy::PassManager MPM;
        passManagerBuilder.populateModulePassManager(MPM);
        MPM.add(llvm::createTargetTransformInfoWrapperPass(machine->getTargetIRAnalysis()));

        MPM.add(llvm::createIPSCCPPass());
        MPM.add(llvm::createCalledValuePropagationPass());
        MPM.add(llvm::createGlobalOptimizerPass()); // Optimize out global vars
        // Promote any localized global vars.
        MPM.add(llvm::createPromoteMemoryToRegisterPass());

        MPM.add(llvm::createDeadArgEliminationPass()); // Dead argument elimination

        MPM.add(llvm::createInstructionCombiningPass()); // Clean up after IPCP & DAE
        // llvm::addExtensionsToPM(llvm::EP_Peephole, MPM);
        MPM.add(llvm::createCFGSimplificationPass()); // Clean up after IPCP & DAE


        // Optimise the module
        MPM.run(*llvmModule);

#if DEBUG_MACHINE && LLVMSQLITE_DEBUG
        writeToFile("jit_llvm_after_module_opt.ll", *llvmModule);
#endif
    }

    debug("Module preparation done");
    writeToFile("jit_llvm_final.ll", *llvmModule);

#if LLVMSQLITE_DUMPTODISK
        VdbeHash vdbeHash;
        std::string moduleFileName = vdbeHash.getFileName(vdbe);
        debug("Dumping to '" << moduleFileName << "'");
        writeToFile(moduleFileName.c_str(), *llvmModule);
#endif

    auto tock = high_resolution_clock::now();
    functionOptimisationTime = duration_cast<milliseconds>(tock - tick).count();
}

void VdbeRunner::initializeTargets() {
    bool error = llvm::InitializeNativeTarget();
    ALWAYS_ASSERT(!error && "InitializeNativeTarget returned an error!");

    error = llvm::InitializeNativeTargetAsmPrinter();
    ALWAYS_ASSERT(!error && "InitializeNativeTargetAsmPrinter returned an error!");

    if (!machine) {
        auto maybeHost = llvm::orc::JITTargetMachineBuilder::detectHost();
        if (!maybeHost) {
            err("Host could not be detected: " << maybeHost.takeError());
            exit(SQLITE_BRIDGE_FAILURE);
        }
        auto host = *maybeHost;

        llvm::orc::JITTargetMachineBuilder tmb(host);
        tmb.setCodeGenOptLevel(llvm::CodeGenOpt::Aggressive);
        auto maybeMachine = tmb.createTargetMachine();
        if (!maybeMachine) {
            err("Target machine could not be created: " << maybeMachine.takeError());
            exit(SQLITE_BRIDGE_FAILURE);
        }
        machine = std::move(*maybeMachine);
    }
}

void initializeDialects() {
    mlir::registerAllDialects();

    using VdbeDialect = mlir::standalone::StandaloneDialect;
    mlir::registerDialect<VdbeDialect>();
}

[[maybe_unused]] void findUsages(llvm::Module &mod) {
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
    for (auto &match : matches) {
        out('"' << match << "\", ");
    }
}
