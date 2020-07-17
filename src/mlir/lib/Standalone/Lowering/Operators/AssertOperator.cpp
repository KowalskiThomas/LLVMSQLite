#include "Standalone/Lowering/AssertOperator.h"

#define LLVMSQLITE_FORCE_ENABLE_ASSERT false
#define LLVMSQLITE_FORCE_DISABLE_ASSERT false

#if LLVMSQLITE_DEBUG || LLVMSQLITE_FORCE_ENABLE_ASSERT
#if LLVMSQLITE_FORCE_DISABLE_ASSERT
#define LLVMSQLITE_ENABLE_JIT_ASSERT false
#else
#define LLVMSQLITE_ENABLE_JIT_ASSERT true
#endif
#else
#define LLVMSQLITE_ENABLE_JIT_ASSERT false
#endif

void MyAssertOperator::operator()(const mlir::Location loc, const size_t line, mlir::Value val) {
#if LLVMSQLITE_ENABLE_JIT_ASSERT
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
#endif
}
