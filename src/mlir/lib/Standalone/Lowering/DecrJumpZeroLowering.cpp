#include "Standalone/ConstantManager.h"
#include "Standalone/Lowering/MyBuilder.h"
#include "Standalone/AllIncludes.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"

#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"


namespace mlir::standalone::passes {
    LogicalResult DecrJumpZeroLowering::matchAndRewrite(DecrJumpZero djzOp, PatternRewriter &rewriter) const {
        auto op = &djzOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        myOperators

        auto pc = djzOp.pcAttr().getSInt();
        auto p1 = djzOp.p1Attr().getSInt();
        auto p2 = djzOp.p2Attr().getSInt();

        auto jumpTo = djzOp.jumpTo();
        auto fallThrough = djzOp.fallThrough();

        USE_DEFAULT_BOILERPLATE

        auto firstBlock = rewriter.getBlock();
        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(djzOp); GO_BACK_TO(curBlock);

        /// pIn1 = &aMem[pOp->p1];
        auto pIn1 = getElementPtrImm(LOC, T::sqlite3_valuePtrTy, vdbeCtx->aMem, p1);

        /// if (pIn1->u.i > SMALLEST_INT64) pIn1->u.i--;
        auto inUAddr = getElementPtrImm(LOC, T::doublePtrTy, pIn1, 0, 0);
        auto inIntegerAddr = bitCast(LOC, inUAddr, T::i64PtrTy);
        auto inInteger = load(LOC, inIntegerAddr);

        curBlock = rewriter.getBlock();
        auto blockAfterDecrement = SPLIT_GO_BACK_TO(curBlock);
        auto blockDecrement = SPLIT_GO_BACK_TO(curBlock);

        auto intGtSmallestInt64 = iCmp(LOC, Pred::sgt, inInteger, SMALLEST_INT64);

        condBranch(LOC, intGtSmallestInt64, blockDecrement, blockAfterDecrement);
        { // if (pIn1->u.i > SMALLEST_INT64)
            ip_start(blockDecrement);

            /// pIn1->u.i--;
            auto newInValue = sub(LOC, inInteger, constants(1, 64));
            store(LOC, newInValue, inIntegerAddr);

            branch(LOC, blockAfterDecrement);
        } // end if (pIn1->u.i > SMALLEST_INT64)
        ip_start(blockAfterDecrement);
        branch(LOC, endBlock);
        ip_start(endBlock);

        inInteger = load(LOC, inIntegerAddr);
        auto intIsZero = iCmp(LOC, Pred::eq, inInteger, 0);
        condBranch(LOC, intIsZero, jumpTo, fallThrough);

        rewriter.eraseOp(djzOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes