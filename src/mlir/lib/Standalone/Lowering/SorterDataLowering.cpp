#include "Standalone/ConstantManager.h"
#include "Standalone/Lowering/MyBuilder.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"

#include "Standalone/StandalonePasses.h"


namespace mlir::standalone::passes {
    LogicalResult SorterDataLowering::matchAndRewrite(SorterData sdOp, PatternRewriter &rewriter) const {
        auto op = &sdOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        myOperators

        print(LOCL, "-- SorterData");

        auto firstBlock = rewriter.getBlock();

        auto curIdx = sdOp.curIdxAttr().getSInt();
        auto reg = sdOp.regAttr().getSInt();
        auto curClearHeader = sdOp.curClearHeaderAttr().getSInt();
        auto pc = sdOp.pcAttr().getUInt();

        USE_DEFAULT_BOILERPLATE

        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(sdOp); GO_BACK_TO(curBlock);

        /// pOut = &aMem[pOp->p2];
        auto pOut = getElementPtrImm(LOC, T::sqlite3_valuePtrTy, vdbeCtx->aMem, reg);
        /// pC = p->apCsr[pOp->p1];
        auto apCsrAddr = getElementPtrImm(LOC, T::VdbeCursorPtrPtrTy.getPointerTo(), vdbeCtx->p, 0, 21);
        auto apCsr = load(LOC, apCsrAddr);
        auto pCValueAddr = getElementPtrImm(LOC, T::VdbeCursorPtrTy.getPointerTo(), apCsr, curIdx);
        auto pC = load(LOC, pCValueAddr);
        // TODO
        /// assert(isSorter(pC));

        /// rc = sqlite3VdbeSorterRowkey(pC, pOut);
        auto rc = call(LOC, f_sqlite3VdbeSorterRowkey, pC, pOut).getValue();

        // TODO
        /// assert(rc != SQLITE_OK || (pOut->flags & MEM_Blob));

        // TODO
        /// assert(pOp->p1 >= 0 && pOp->p1 < p->nCursor);

        { // if (rc) goto abort_due_to_error;
            auto rcIsNull = iCmp(LOC, Pred::eq, rc, 0);
            myAssert(LOCL, rcIsNull);
        } // end if (rc) goto abort_due_to_error;

        /// p->apCsr[pOp->p3]->cacheStatus = CACHE_STALE;
        auto otherCursorPointerValueAddress = getElementPtrImm(LOC, T::VdbeCursorPtrTy.getPointerTo(), apCsr, curClearHeader);
        auto otherCursorPointer = load(LOC, otherCursorPointerValueAddress);
        auto cacheStatusAddr = getElementPtrImm(LOC, T::i32PtrTy, otherCursorPointer, 0, 9);
        store(LOC, CACHE_STALE, cacheStatusAddr);

        branch(LOC, endBlock);

        ip_start(endBlock);

        rewriter.eraseOp(sdOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes