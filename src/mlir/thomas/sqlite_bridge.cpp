#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/StandalonePassManager.h"
#include "Standalone/StandaloneDialect.h"

#include "sqlite_bridge.h"

bool enableOpt = false;
const char* const JIT_MAIN_FN_NAME = "jittedFunction";

static bool initialised = false;

void init() {
    if (initialised)
        return;

    initialised = true;
    mlir::registerAllDialects();
    mlir::registerAllPasses();

    using VdbeDialect = mlir::standalone::StandaloneDialect;
    mlir::registerDialect<VdbeDialect>();
}

int jitVdbeStep(Vdbe* p) {
    init();
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

    writeFunction(context, llvmDialect, theModule);

    llvm::errs() << "Original module\n";
    theModule.dump();
    llvm::errs() << "\n\n";

    mlir::PassManager pm(ctx);
    pm.addPass(std::make_unique<VdbeToLLVM>());
    pm.run(theModule);

    llvm::errs() << "Translated module\n";
    auto mod = mlir::translateModuleToLLVMIR(theModule);
    mod->dump();

    runJit(theModule);

    llvm::errs() << "\n\n";
}
