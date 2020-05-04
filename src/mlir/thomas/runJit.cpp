#include "sqlite_bridge.h"
#include "Standalone/StandaloneDialect.h"
#include "Standalone/StandalonePassManager.h"
#include "Standalone/StandalonePasses.h"

int runJit(mlir::ModuleOp module) {
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

    // Invoke the JIT-compiled function.
    struct Vdbe {
        void* sqlite3ptr = 0;
        Vdbe* vdbeptr = 0;
        Vdbe* vdbeptr2 = 0;
        void* parseptr = 0;
        int16_t myInt = 0;
        int32_t myOtherInt = 0;
    };

    Vdbe my_vdbe;
    int32_t returnedValue = -1;

    void* arg1 = &my_vdbe;
    void* arg2 = (void*)456;
    void* arg3 = (void*)789;

    auto expectedFPtr = engine->lookup(JIT_MAIN_FN_NAME);
    decltype(expectedFPtr.takeError()) result = llvm::Error::success();
    if (!expectedFPtr)
        result = expectedFPtr.takeError();

    if (result) {
        llvm::errs() << "JIT invocation failed\n";
        return -1;
    } else {
        auto fptr = *expectedFPtr;
        // The function wants addresses to arguments
        // So if we want to pass value 123, we need to
        // - Put 123 in a variable var
        // - Put the address of var in a variable addr
        // - Pass the address of addr
        // The last parameter is used to store the returned value
        llvm::outs() << "Calling\n";
        llvm::SmallVector<void*, 8> args = {(void*)&arg1, (void*)&arg2, (void*)&arg3, (void*)&returnedValue };
        (*fptr)(args.data());
    }

    llvm::outs() << my_vdbe.myInt << ' ' << my_vdbe.myOtherInt << ' ' << arg2 << ' ' << arg3 << ' ' << returnedValue << '\n';
    llvm::outs().flush();

    return 0;
}
