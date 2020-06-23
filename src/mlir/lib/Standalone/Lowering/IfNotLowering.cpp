#include "Standalone/ConstantManager.h"
#include "Standalone/Lowering/MyBuilder.h"
#include "Standalone/AllIncludes.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"

#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"

extern LLVMFuncOp f_sqlite3VdbeBooleanValue;

namespace mlir::standalone::passes {
    LogicalResult IfNotLowering::matchAndRewrite(IfNot txnOp, PatternRewriter &rewriter) const {
        auto op = &txnOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        myOperators

        auto pc = txnOp.pcAttr().getUInt();
        auto p1 = txnOp.conditionAttr().getSInt();
        auto p3 = txnOp.hintsAttr().getSInt();

        auto jumpTo = txnOp.jumpTo();
        auto fallThrough = txnOp.fallthrough();

        USE_DEFAULT_BOILERPLATE

        auto bitNot = [&](Location loc, Value x) {
            // !x = x ^ 0x1..1
            auto w = builder.getBitWidth(x);
            auto fullOne = constants(-1, w);
            return rewriter.create<mlir::LLVM::XOrOp>(loc, x, fullOne);
        };

        /// c = !sqlite3VdbeBooleanValue(&aMem[pOp->p1], !pOp->p3);
        // Get &aMem[pOp->p1]
        auto reg = getElementPtrImm(LOC, T::sqlite3_valuePtrTy, vdbeCtx->aMem, p1);
        // Get !pOp->p3
        auto notP3 = bitNot(LOC, constants(p3, 32));
        // Call
        auto result = call(LOC, f_sqlite3VdbeBooleanValue, reg, notP3).getValue();

        // Get !sqlite3VdbeBooleanValue...
        // auto c = bitNot(LOC, result);
        auto c = iCmp(LOC, Pred::eq, result, 0);

        condBranch(LOC, c, jumpTo, fallThrough);
        rewriter.eraseOp(txnOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes