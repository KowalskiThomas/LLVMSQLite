#include "Standalone/AllIncludes.h"
#include "Standalone/ConstantManager.h"

template<class Rewriter>
struct MyAssertOperator {
    using ValueRange = mlir::ValueRange;
    using MLIRContext = mlir::MLIRContext;

    Rewriter& rewriter;
    ConstantManager<Rewriter>& constants;
    MLIRContext* ctx;

    MyAssertOperator(Rewriter& rewriter, ConstantManager<Rewriter>& constants, MLIRContext* ctx)
            : rewriter(rewriter), constants(constants), ctx(ctx)
    {
    }

    void operator()(mlir::Location loc, mlir::Value val) {
        auto d = ctx->getRegisteredDialect<LLVMDialect>();
        if (val.getType().isInteger(1) || val.getType() == LLVMType::getIntNTy(d, 1))
            rewriter.template create<CallOp>(loc, f_assert, ValueRange{val});
        else {
            auto found = false;
            for (auto i = 2; i < 64; i++) {
                if (val.getType().isInteger(i) || val.getType() == LLVMType::getIntNTy(d, i)) {
                    auto valAs1 = rewriter.template create<ICmpOp>(loc, ICmpPredicate::ne,
                                                                   val, constants(0, i));
                    rewriter.template create<CallOp>(loc, f_assert, ValueRange{valAs1});
                    found = true;
                    break;
                }
            }
            if (found)
                return;

            err("Couldn't find the right operation to convert variable for assertion")
            val.dump();
        }
    }
};
