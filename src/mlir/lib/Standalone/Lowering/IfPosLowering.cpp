#include "Standalone/ConstantManager.h"
#include "Standalone/Lowering/MyBuilder.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"

#include "Standalone/StandalonePasses.h"


namespace mlir::standalone::passes {
    LogicalResult IfPosLowering::matchAndRewrite(IfPos ifOp, PatternRewriter &rewriter) const {
        auto op = &ifOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        myOperators

        print(LOCL, "-- IfPos");

        auto firstBlock = rewriter.getBlock();

        auto destReg = ifOp.integerRegAttr().getSInt();
        auto toSubtract = ifOp.toSubtractAttr().getSInt();

        auto jumpTo = ifOp.jumpTo();
        auto fallThrough = ifOp.fallthrough();

        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(ifOp); GO_BACK_TO(curBlock);

        auto pIn = getElementPtrImm(LOC, T::sqlite3_valuePtrTy, vdbeCtx->aMem, destReg);
        auto unionAddress = getElementPtrImm(LOC, T::doublePtrTy, pIn, 0, 0, 0);
        auto intAddress = bitCast(LOC, unionAddress, T::i64PtrTy);
        auto value = load(LOC, intAddress);

        curBlock = rewriter.getBlock();
        auto blockAfterValuePositive = SPLIT_BLOCK; GO_BACK_TO(curBlock);
        auto blockValuePositive = SPLIT_BLOCK; GO_BACK_TO(curBlock);

        auto condValuePositive = iCmp(LOC, Pred::sgt, value, 0);

        condBranch(LOC, condValuePositive, blockValuePositive, blockAfterValuePositive);
        { // if (pIn1->u.i > 0)
            ip_start(blockValuePositive);

            /// pIn1->u.i -= pOp->p3;
            auto newValue = sub(LOC, value, constants(toSubtract, 64));
            store(LOC, (Value)newValue, intAddress);

            branch(LOC, blockAfterValuePositive);
         } // end if (pIn1->u.i > 0)

        ip_start(blockAfterValuePositive);

        branch(LOC, endBlock);
        ip_start(endBlock);

        condBranch(LOC, condValuePositive, jumpTo, fallThrough);

        rewriter.eraseOp(ifOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes