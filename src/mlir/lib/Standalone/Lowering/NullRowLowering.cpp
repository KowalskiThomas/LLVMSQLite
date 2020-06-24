#include "Standalone/ConstantManager.h"
#include "Standalone/Lowering/MyBuilder.h"
#include "Standalone/AllIncludes.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"

#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"

extern LLVMFuncOp f_sqlite3BtreeClearCursor;

namespace mlir::standalone::passes {
    LogicalResult NullRowLowering::matchAndRewrite(NullRow txnOp, PatternRewriter &rewriter) const {
        auto op = &txnOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        myOperators

        auto pc = txnOp.pcAttr().getUInt();
        auto p1 = txnOp.curIdxAttr().getSInt();

        USE_DEFAULT_BOILERPLATE

        auto firstBlock = rewriter.getBlock();
        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(txnOp); GO_BACK_TO(curBlock);

        /// pC = p->apCsr[pOp->p1];
        auto pCAddr = getElementPtrImm(LOC, T::VdbeCursorPtrTy.getPointerTo(), vdbeCtx->apCsr, p1);
        auto pC = load(LOC, pCAddr);

        /// pC->nullRow = 1;
        auto nullRowAddr = getElementPtrImm(LOC, T::i8PtrTy, pC, 0, 2);
        store(LOC, 1, nullRowAddr);

        /// pC->cacheStatus = CACHE_STALE;
        auto cacheStatusAddr = getElementPtrImm(LOC, T::i32PtrTy, pC, 0, 9);
        store(LOC, CACHE_STALE, cacheStatusAddr);

        /// if (pC->eCurType == CURTYPE_BTREE)
        auto curTypeAddr = getElementPtrImm(LOC, T::i8PtrTy, pC, 0, 0);
        auto curType = load(LOC, curTypeAddr);

        curBlock = rewriter.getBlock();
        auto blockAfterCurTypeBtree = SPLIT_GO_BACK_TO(curBlock);
        auto blockCurTypeBtree = SPLIT_GO_BACK_TO(curBlock);

        auto condCurTypeBtree = iCmp(LOC, Pred::eq, curType, CURTYPE_BTREE);
        condBranch(LOC, condCurTypeBtree, blockCurTypeBtree, blockAfterCurTypeBtree);
        { // if (pC->eCurType == CURTYPE_BTREE)
            ip_start(blockCurTypeBtree);

            /// sqlite3BtreeClearCursor(pC->uc.pCursor);
            // Get pC->uc.pCursor
            auto pCursorAddr = getElementPtrImm(LOC, T::BtCursorPtrTy, pC, 0, 12, 0);
            auto pCursor = load(LOC, pCursorAddr);
            // Call
            call(LOC, f_sqlite3BtreeClearCursor, pCursor);

            branch(LOC, blockAfterCurTypeBtree);
        } // end if (pC->eCurType == CURTYPE_BTREE)
        ip_start(blockAfterCurTypeBtree);
        branch(LOC, endBlock);
        ip_start(endBlock);

        rewriter.eraseOp(txnOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes