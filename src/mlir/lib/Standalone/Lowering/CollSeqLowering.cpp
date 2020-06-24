#include "Standalone/ConstantManager.h"
#include "Standalone/Lowering/MyBuilder.h"
#include "Standalone/AllIncludes.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"

#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"


namespace mlir::standalone::passes {
    LogicalResult CollSeqLowering::matchAndRewrite(CollSeq txnOp, PatternRewriter &rewriter) const {
        auto op = &txnOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        myOperators

        auto pc = txnOp.pcAttr().getUInt();
        auto p4 = txnOp.p4Attr().getUInt();

        USE_DEFAULT_BOILERPLATE

        auto firstBlock = rewriter.getBlock();
        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(txnOp); GO_BACK_TO(curBlock);

        // The value of P1 is changed at run-time
        auto pOp = getElementPtrImm(LOC, T::VdbeOpPtrTy, vdbeCtx->aOp, (int)pc);
        auto p1Addr = getElementPtrImm(LOC, T::i32PtrTy, pOp, 0, 3);
        auto p1 = load(LOC, p1Addr);

        curBlock = rewriter.getBlock();
        auto blockAfterP1NotNull = SPLIT_GO_BACK_TO(curBlock);
        auto blockP1NotNull = SPLIT_GO_BACK_TO(curBlock);

        auto condP1NotNull = iCmp(LOC, Pred::ne, p1, 0);

        condBranch(LOC, condP1NotNull, blockP1NotNull, blockAfterP1NotNull);
        { // if (pOp->p1)
            ip_start(blockP1NotNull);

            auto out = getElementPtr(LOC, T::sqlite3_valuePtrTy, vdbeCtx->aMem, p1);
            call(LOC, f_sqlite3VdbeMemSetInt64, out, constants(0, 64));

            branch(LOC, blockAfterP1NotNull);
        } // end if (pOp->p1)

        ip_start(blockAfterP1NotNull);
        branch(LOC, endBlock);

        ip_start(endBlock);
        rewriter.eraseOp(txnOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes