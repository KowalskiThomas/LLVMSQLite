#include "Standalone/AllIncludes.h"
#include "Standalone/ConstantManager.h"
#include "Standalone/StandalonePrerequisites.h"

template<class Rewriter>
struct MyAssertOperator {
    USING_OPS

    Rewriter& rewriter;
    ConstantManager<Rewriter>& constants;
    MLIRContext* ctx;
    const char* fileName;

    MyAssertOperator(Rewriter& rewriter, ConstantManager<Rewriter>& constants, MLIRContext* ctx, const char* fileName)
            : rewriter(rewriter), constants(constants), ctx(ctx), fileName(fileName)
    {
    }

    void operator()(mlir::Location loc, size_t line, mlir::Value val) {
        auto d = ctx->getRegisteredDialect<LLVMDialect>();
        if (val.getType().isInteger(1) || val.getType() == LLVMType::getIntNTy(d, 1))
            rewriter.template create<CallOp>(loc, f_assert, ValueRange{
                val,
                constants(line, 64),
                constants(T::i8PtrTy, fileName)
            });
        else {
            auto found = false;
            for (auto i = 2; i < 64; i++) {
                if (val.getType().isInteger(i) || val.getType() == LLVMType::getIntNTy(d, i)) {
                    auto valAs1 = rewriter.template create<ICmpOp>(loc, ICmpPredicate::ne,
                                                                   val, constants(0, i));
                    rewriter.template create<CallOp>(loc, f_assert, ValueRange{
                        valAs1, // Condition boolean
                        constants(line, 64), // Line number
                        constants(T::i8PtrTy, fileName) // File name
                    });
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
