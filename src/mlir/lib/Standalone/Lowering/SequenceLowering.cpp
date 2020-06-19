#include "Standalone/ConstantManager.h"
#include "Standalone/Lowering/MyBuilder.h"
#include "Standalone/AllIncludes.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/OutToPrerelease.h"
#include "Standalone/Lowering/Printer.h"

#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"


namespace mlir::standalone::passes {
    LogicalResult SequenceLowering::matchAndRewrite(Sequence seqOp, PatternRewriter &rewriter) const {
        auto op = &seqOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        myOperators

        auto firstBlock = rewriter.getBlock();

        auto pc = seqOp.pcAttr().getUInt();
        auto p1 = seqOp.curIdxAttr().getSInt();
        auto p2 = seqOp.regAttr().getSInt();

        USE_DEFAULT_BOILERPLATE
        
        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(seqOp); GO_BACK_TO(curBlock);

        /// pOut = out2Prerelease(p, pOp);
        auto outToPrerelease = Inlining::OutToPrerelease(*vdbeCtx, context, rewriter, print, constants);
        auto pOp = getElementPtrImm(LOC, T::VdbeOpPtrTy, vdbeCtx->aOp, (int)pc);
        auto pOut = outToPrerelease(LOC, vdbeCtx->p, pOp);

        auto pOutUAddr = getElementPtrImm(LOC, T::doublePtrTy, pOut, 0, 0);
        auto pOutIntegerAddr = bitCast(LOC, pOutUAddr, T::i64PtrTy);

        /// pOut->u.i = p->apCsr[pOp->p1]->seqCount++;
        auto cursorAddr = getElementPtrImm(LOC, T::VdbeCursorPtrPtrTy, vdbeCtx->apCsr, p1);
        auto cursor = load(LOC, cursorAddr);
        auto seqCountAddr = getElementPtrImm(LOC, T::i64PtrTy, cursor, 0, 7);
        auto seqCount = load(LOC, seqCountAddr);
        seqCount = add(LOC, seqCount, 1);
        store(LOC, seqCount, seqCountAddr);
        store(LOC, seqCount, pOutIntegerAddr);

        branch(LOC, endBlock);

        ip_start(endBlock);
        rewriter.eraseOp(seqOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes