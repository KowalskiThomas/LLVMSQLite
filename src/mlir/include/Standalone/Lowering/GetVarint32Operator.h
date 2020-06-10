namespace mlir {
    struct MLIRContext;
    struct Value;
    struct OpBuilder;
    namespace LLVM {
        struct LLVMFuncOp;
    }
}

extern mlir::LLVM::LLVMFuncOp f_sqlite3GetVarint32;

namespace mlir::standalone::passes {

struct GetVarint32Operator {
    using MLIRContext = mlir::MLIRContext;
    using Value = mlir::Value;
    using OpBuilder = mlir::OpBuilder;

    OpBuilder& rewriter;
    MLIRContext* ctx;
    ConstantManager& constants;

    GetVarint32Operator(OpBuilder& rewriter, ConstantManager& constants, MLIRContext* ctx)
            : rewriter(rewriter), ctx(ctx), constants(constants)
    {
    }

    void operator()(Value A, Value B, Value writeResultTo);
};
}
