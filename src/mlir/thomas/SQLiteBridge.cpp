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
            // If the type has already been converted, return what we know is the remapped type
            if (cache.find(ty) != cache.cend()) {
                return cache[ty];
            }

            auto result = remapTypeImpl(ty);

#ifdef PRINT_REMAPPED
            if (ty->isStructTy() && !cast<StructType>(ty)->isLiteral()) {
                out(""
                            << "Remapped '" << ty->getStructName()
                            << "' defined as " << *ty
                            << " to '" << result->getStructName()
                            << "' defined as " << *result);
            } else {
                out(""
                        << "Remapped '" << *ty << "'"
                        << " to '" << *result << "'");
            }
#endif

            return result;
        }

        virtual Type *remapTypeImpl(Type *ty) {
            // Most complex case: the type is an aggregate
            if (ty->isStructTy()) {
                // Get the corresponding StructType
                auto sTy = llvm::cast<llvm::StructType>(ty);
                if (sTy->isLiteral())
                {
                    SmallVector<Type*, 16> elts;
                    for(auto inTy : sTy->elements())
                        elts.push_back(remapType(inTy));

                    return llvm::StructType::get(ty->getContext(), elts, sTy->isPacked());
                }

                // Try to find an equivalent type in our module
                auto nameFrom = ty->getStructName();
                // If the aggregate name starts with struct., we might have an equivalent without "struct."
//                if (nameFrom.startswith("struct."))
//                    nameTo = nameFrom.slice(7, nameFrom.size());
//                else if (nameFrom.startswith("union."))
//                    // Same thing for unions
//                    nameTo = nameFrom.slice(6, nameFrom.size());
//                else if (mod.getTypeByName(nameFrom) != nullptr) {
//                    nameTo = nameFrom;
//                } else {
//                    // Trap for unexpected cases
//                    err("Can't convert type " << *ty);
//                    llvm_unreachable("Can't convert this type!");
//                }
                std::string nameTo;
                nameTo += nameFrom.str() + "ty";
                auto toTy = mod.getTypeByName(nameTo);

                // Now, we try and get that type instance we have in our module
                if (toTy == nullptr) {
                    // The type has not been defined yet
                    out("Can't find " << ty->getStructName() << " as '" << nameTo << "', defined as " << *ty);

                    // We create an opaque type for it
                    toTy = StructType::create(mod.getContext(), nameTo);
                    LLVMSQLITE_ASSERT(toTy->isOpaque());
                    // Put in the cache
                    cache[ty] = toTy;

                    // If the other type is explicit, then we need to "copy" it recursively
                    if (!sTy->isOpaque()) {
                        // We gather its element types
                        SmallVector<Type *, 16> types;
                        for (int i = 0; i < sTy->getStructNumElements(); i++) {
                            // Each element of the remapped type is the remapped type of the element
                            auto iTh = remapType(sTy->getStructElementType(i));
                            types.push_back(iTh);
                        }

                        // And we set the body of our new aggregate
                        toTy->setBody(types, sTy->isPacked());
                    }

                    out("  -> Defined new type " << *toTy);
                    return cache[ty] = toTy;
                } else {
                    // If it already exists
                    if (toTy->isOpaque() && !sTy->isOpaque()) {
                        // Maybe we didn't know it, but actually we have a definition for it now

                        // Cache it already because we're gonna have a recursive call
                        cache[ty] = toTy;

                        // Do the same thing as before: remap each element type
                        SmallVector<Type *, 16> types;
                        for (int i = 0; i < sTy->getStructNumElements(); i++) {
                            auto iTh = remapType(sTy->getStructElementType(i));
                            types.push_back(iTh);
                        }

                        // Set the body of the already existing type (which should be opaque right now)
                        toTy->setBody(types, sTy->isPacked());

                        out("De-opaqued " << *sTy << " to " << *toTy);
                        return cache[ty] = toTy;
                    } else {
                        // So it's not currently opaque. In this case, the elements in it must correspond to the
                        // remapped element from the other struct. At least we hope so.
                        out("Found type " << *ty << " (mapped to " << *toTy << ")");
                        return cache[ty] = toTy;
                    }
                }
            } else if (ty->isPointerTy()) {
                // Remapped(Pointer<T>) = Pointer<Remapped(T)>
                return cache[ty] = remapType(ty->getPointerElementType())->getPointerTo();
            } else if (ty->isIntegerTy() || ty->isFloatingPointTy() || ty->isVoidTy()) {
                // Integer / Floats are common across modules as long as the LLVMContext is the same
                return cache[ty] = ty;
            } else if (ty->isArrayTy()) {
                // Remapped(Array<T, X>) -> Array<Remapped(T), X>
                auto aTy = cast<ArrayType>(ty);
                auto numElements = aTy->getArrayNumElements();
                return cache[ty] = ArrayType::get(remapType(aTy->getElementType()), numElements);
            } else if (ty->isFunctionTy()) {
                // We have a special function for handling functions (dawg)
                auto fTy = cast<FunctionType>(ty);
                // out("Function type: " << *fTy);
                return cache[ty] = remapFunctionType(fTy);
            } else if (ty->isVectorTy()) {
                auto vTy = cast<VectorType>(ty);
                return cache[ty] = VectorType::get(
                    remapType(remapType(vTy->getElementType())),
                    vTy->getElementCount()
                );
            }

            // Fail with a lot of noise if we can't remap the type
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

            auto result = FunctionType::get(resultTy, paramTy, ty->isVarArg());
            return funcCache[ty] = result;
        }
    };
}

namespace llvm {
struct GlobalValueConverter {
    using ValueToValueMapTy = ValueMap<const Value *, WeakTrackingVH>;

    Module& mod;
    TypeRemapper& typeMap;
    ValueToValueMapTy& valueMap;

    GlobalValueConverter(Module& m, TypeRemapper& typeMap, ValueToValueMapTy& valueMap)
        : mod(m), typeMap(typeMap), valueMap(valueMap)
    {
    }

    GlobalVariable* convert(GlobalVariable& gv) {
        out("Global " << gv);
        auto name = gv.getName() + "_conv";
        auto ty = typeMap.remapType(gv.getType())->getPointerElementType();
        auto dataTy = gv.getType()->getPointerElementType();
        out("Original " << *dataTy << " ours: " << *ty);

        auto init = gv.getInitializer();
        auto newInit = convert(init);

        out("New init: " << *newInit);
        auto outGlobal = new GlobalVariable(
                mod,
                ty,
                false,
                llvm::GlobalValue::LinkageTypes::ExternalLinkage,
                newInit,
                name,
                nullptr,
                llvm::GlobalValue::ThreadLocalMode::NotThreadLocal,
                0, false
        );

        return outGlobal;
    }

private:
    Constant* convert(Constant* cst) {
        llvm::Constant* toInit;
        // LLVMSQLITE_ASSERT(cst->getType()->isPointerTy());
        auto ty = cst->getType();
        out("Initializer type: " << *ty << " value: " << *cst);

        if (ty->isIntegerTy() || ty->isFloatingPointTy()) {
            return cst;
        } else if (ty->isStructTy()) {
            auto initializers = llvm::SmallVector<Constant*, 256>();
            if (cst->isZeroValue())
                return Constant::getNullValue(typeMap.remapType(ty));

            auto sInit = cast<ConstantStruct>(cst);

            out(*sInit);

            for(auto& x : sInit->operands()) {
                initializers.push_back(convert(cast<Constant>(x)));
                out("Added of type " << *initializers.back()->getType());
            }

            return ConstantStruct::get(cast<StructType>(typeMap.remapType(ty)), initializers);
        } else if (ty->isArrayTy()) {
            auto arrTy = llvm::cast<llvm::ArrayType>(ty);
            auto newArrTy = cast<ArrayType>(typeMap.remapType(arrTy));
            if (arrTy == newArrTy)
                return cst;

            auto initArr = llvm::SmallVector<llvm::Constant*, 256>();
            for(auto& x : llvm::cast<llvm::ConstantArray>(cst)->operands()) {
                initArr.push_back(convert(cast<Constant>(x)));
            }

            return ConstantArray::get(newArrTy, initArr);
        } else if (ty->isPointerTy()) {
            auto newTy = cast<PointerType>(typeMap.remapType(ty));
            if (cst->isNullValue())
                return Constant::getNullValue(newTy);

            if (ty->getPointerElementType()->isFunctionTy()) {
                out("Is Function" << *ty->getPointerElementType());
                auto f = cast<Function>(cst);

                auto mappedF = valueMap[f];
                out("F : " << f->getName() << " mapped to " << mappedF->getName());
                auto cstMappedF = cast<Function>(mappedF);
                return ConstantExpr::getBitCast(cstMappedF, cstMappedF->getType());
            } else {
                out("PointerType! New type: " << *newTy << " Old def: " << *cst);
                out("ConstantExpression: " << cst->containsConstantExpression());
                out(*cst);
                out(cst->getAggregateElement((int)0));
            }

            return cst;
            // return ConstantPointerNull::get(newTy);
        } else {
            out("Can't convert type " << *ty);
            llvm_unreachable("Couldn't convert that.");
        }

        // écris moi qq mots s'il te plait
        // mathilde thevenot
        // quand je suis parti de Vichu j'étais super content parce que j'allais te revoir
        // j'ai attendu impatiemment qu'on aille te retrouver à la gare
        // Quand t'es rentrée je t'ai trouvée delightful
        // j'ai passé un merveilleux week end avec toi
        // j'aimerais vraiment beaucoup aller faire des randonnées avec toi dans le vercors
        // parce que c'est trop beau
        // et que Issy c'est chouette mais c'est quand même moins bien
        // (pour marcher)
        // (pour icade je dis pas)
        // du coup voilà
        // même si brigitte est débile et qu'elle a acheté UN COUTEAU ELECTRIQUE
        // jpp
        // je t'aime fort
        // UN COUTEAU ELECTRIQUEdwjfkqsljdklqjsd
        // genre elle coupe un magret de canard pas un tronc d'arbre
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
                auto broken = llvm::verifyModule(*llvmModule, &llvm::errs());
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

                 // TODO: Optimise
                static constexpr const bool optimise = false;
                auto passManagerBuilder = llvm::PassManagerBuilder();
                passManagerBuilder.OptLevel = optimise ? 3 : 0;
                passManagerBuilder.SizeLevel = 0;
                passManagerBuilder.Inliner = optimise ? llvm::createFunctionInliningPass() : nullptr;
                passManagerBuilder.MergeFunctions = optimise;
                passManagerBuilder.LoopVectorize = optimise;
                passManagerBuilder.SLPVectorize = optimise;
                passManagerBuilder.DisableUnrollLoops = !optimise;
                passManagerBuilder.RerollLoops = optimise;
                passManagerBuilder.PerformThinLTO = optimise;
                passManagerBuilder.LibraryInfo = new llvm::TargetLibraryInfoImpl(targetTriple);
                machine->adjustPassManager(passManagerBuilder);

                extern std::unique_ptr<llvm::Module> loadedModule;
                LLVMSQLITE_ASSERT(loadedModule != nullptr);

#define LLVMSQLITE_DUPLICATE_FUNCTIONS true
#if LLVMSQLITE_DUPLICATE_FUNCTIONS
                out("--------- MODULE TYPES LIST --------")
                for(auto t : llvmModule->getIdentifiedStructTypes()) {
                    out("In Module: " << *t);
                }

                auto typeMap = llvm::TypeRemapper{*llvmModule};
                llvm::ValueToValueMapTy valueMap;
                auto gvConverter = llvm::GlobalValueConverter(*llvmModule, typeMap, valueMap);
                for(auto& func : loadedModule->functions())
                {
                    auto cloneFrom = &func;
                    LLVMSQLITE_ASSERT(cloneFrom != nullptr);

                    auto cloneIn = llvmModule->getFunction(cloneFrom->getName());
                    if (cloneIn == nullptr) {
                        // out("Creating type for " << cloneFrom->getName());
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
                    auto itFrom = cloneFrom->arg_begin();
                    auto itTo = cloneIn->arg_begin();

                    while (itFrom != cloneFrom->arg_end()) {
                        LLVMSQLITE_ASSERT(itTo != cloneIn->arg_end());
                        valueMap[&*itFrom] = itTo;
                        ++itFrom, ++itTo;
                    }

                    for(auto& f : loadedModule->functions()) {
                        auto newCalled = llvmModule->getOrInsertFunction(
                            f.getName(),
                            typeMap.remapFunctionType(f.getFunctionType())
                        );
                        valueMap[&f] = llvmModule->getFunction(f.getName());
                    }

                    for(auto& git : loadedModule->globals()) {
                        valueMap[&git] = gvConverter.convert(git);
                    }

                    // <3 beaucoup

                    if (cloneFrom->begin() != cloneFrom->end()) {
                        // out("Cloning " << cloneFrom->getName() << " to " << cloneIn->getName());
                        llvm::CloneFunctionInto(cloneIn, cloneFrom, valueMap, false, returns, "", nullptr, &typeMap);
                    }
                }

                writeToFile("debug.ll", *llvmModule);

#if 0
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
                            } else {
                                for(int k = 0; k < i.getNumOperands(); k++) {
                                    auto operand = (llvm::Value*)i.getOperand(k);
                                    auto opTy = operand->getType();
                                    if (opTy->isPointerTy() && opTy->getPointerElementType()->isFunctionTy()) {
                                        out("Changing for" << i);
                                        if (operand->hasName()) {
                                            out(operand->getName() << " " << *operand->getType());
                                        }
                                        //auto constPtr = llvm::cast_or_null<llvm::Function>(operand);
                                        /*if (fCalled->hasName()) {
                                            llvmModule->getOrInsertFunction(
                                                fCalled->getName(),
                                                typeMap.remapFunctionType(fCalled->getFunctionType())
                                            );
                                            auto newCalled = llvmModule->getFunction(fCalled->getName());
                                            i.setOperand(k, newCalled);
                                        }*/
                                    }
                                }
                            }
                        }
                    }
                }
#endif
#endif

                if (optimise) {
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

                    // Optimise the module
                    modulePassManager.run(*llvmModule);
                }

#if DEBUG_MACHINE && LLVMSQLITE_DEBUG
                writeToFile("jit_llvm_optimised.ll", *llvmModule);
#endif

                // Create an ExecutionEngine
                auto builder = llvm::EngineBuilder(std::move(llvmModule));
                auto engine = builder
                                .setEngineKind(llvm::EngineKind::JIT)
                                .setOptLevel(optimise ? llvm::CodeGenOpt::Aggressive : llvm::CodeGenOpt::None)
                                .setVerifyModules(true)
                                .create();
                ALWAYS_ASSERT(engine != nullptr && "ExecutionEngine is null!");

                // TODO: Remove
                /// Add the sqlite3.ll module to the ExecutionEngine
                /// engine->addModule(std::move(loadedModule));

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
