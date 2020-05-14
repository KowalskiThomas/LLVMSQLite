#include "sqlite_bridge.h"
#include "Standalone/StandaloneDialect.h"
#include "Standalone/StandalonePassManager.h"
#include "Standalone/StandalonePasses.h"

int runJit(mlir::ModuleOp module, Vdbe* p) {
    // Initialize LLVM targets.
    llvm::InitializeNativeTarget();
    llvm::InitializeNativeTargetAsmPrinter();

    // An optimization pipeline to use within the execution engine.
    auto optPipeline = mlir::makeOptimizingTransformer(
            /*optLevel=*/enableOpt ? 3 : 0, /*sizeLevel=*/0,
            /*targetMachine=*/nullptr);

    // Create an MLIR execution engine. The execution engine eagerly JIT-compiles
    // the module.
    auto maybeEngine = mlir::ExecutionEngine::create(module, optPipeline);
    assert(maybeEngine && "failed to construct an execution engine");
    if (!maybeEngine) {
        llvm_unreachable("Couldn't build engine");
    }
    auto &engine = maybeEngine.get();

    int32_t returnedValue = -1;

    auto expectedFPtr = engine->lookup(JIT_MAIN_FN_NAME);
    decltype(expectedFPtr.takeError()) result = llvm::Error::success();
    if (!expectedFPtr)
        result = expectedFPtr.takeError();

    if (result) {
        llvm::errs() << "JIT invocation failed\n";
        return -1;
    } else {
        sqlite3VdbeEnter(p);
        if (p->rc == SQLITE_NOMEM) {
            err("ERROR: Can't allocate memory")
        }

        auto fptr = *expectedFPtr;
        // The function wants addresses to arguments
        // So if we want to pass value 123, we need to
        // - Put 123 in a variable var
        // - Put the address of var in a variable addr
        // - Pass the address of addr
        // The last parameter is used to store the returned value
        llvm::outs() << "Calling\n";
        llvm::SmallVector<void*, 8> args = {(void*)&p, (void*)&returnedValue };
        (*fptr)(args.data());
    }

    llvm::outs() << "Returned value " << returnedValue << '\n';
    llvm::outs().flush();

    return returnedValue;
}
