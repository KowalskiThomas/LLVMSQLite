#include "Standalone/ConstantManager.h"
#include "Standalone/Lowering/MyBuilder.h"
#include "Standalone/AllIncludes.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"

#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"


namespace mlir::standalone::passes {
    LogicalResult IfNotZeroLowering::matchAndRewrite(IfNotZero inzOp, PatternRewriter &rewriter) const {
        auto op = &inzOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        myOperators

        auto firstBlock = rewriter.getBlock();

        auto pc = inzOp.pcAttr().getUInt();
        auto p1 = inzOp.regAttr().getSInt();

        auto jumpTo = inzOp.jumpTo();
        auto fallThrough = inzOp.fallThrough();

        USE_DEFAULT_BOILERPLATE

        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(inzOp); GO_BACK_TO(curBlock);

        auto pIn1 = getElementPtrImm(LOC, T::sqlite3_valuePtrTy, vdbeCtx->aMem, p1);
        auto inUnionAddr = getElementPtrImm(LOC, T::doublePtrTy, pIn1, 0, 0);
        auto inIntAddr = bitCast(LOC, inUnionAddr, T::i64PtrTy);
        auto inInt = load(LOC, inIntAddr);
        auto inIntNotNull = iCmp(LOC, Pred::ne, inInt, 0);

        curBlock = rewriter.getBlock();
        auto blockJump = SPLIT_GO_BACK_TO(curBlock);

        condBranch(LOC, inIntNotNull, blockJump, endBlock);
        { // if (pIn1->u.i)
            ip_start(blockJump);

            inInt = add(LOC, inInt, -1);
            store(LOC, inInt, inIntAddr);

            branch(LOC, jumpTo);
        } // end if (pIn1->u.i)

        ip_start(endBlock);
        rewriter.eraseOp(inzOp);

        branch(LOC, fallThrough);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes