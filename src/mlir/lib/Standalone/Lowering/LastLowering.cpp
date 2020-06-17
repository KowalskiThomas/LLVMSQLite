#include "Standalone/ConstantManager.h"
#include "Standalone/Lowering/MyBuilder.h"
#include "Standalone/AllIncludes.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"

#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"


extern LLVMFuncOp f_sqlite3BtreeCursorIsValidNN;
extern LLVMFuncOp f_sqlite3BtreeLast;

namespace mlir::standalone::passes {
    LogicalResult LastLowering::matchAndRewrite(Last lstOp, PatternRewriter &rewriter) const {
        auto op = &lstOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        myOperators

        auto firstBlock = rewriter.getBlock();

        auto pc = lstOp.pcAttr().getUInt();
        auto p1 = lstOp.curIdxAttr().getSInt();

        USE_DEFAULT_BOILERPLATE
        
        auto jumpTo = lstOp.jumpTo();
        auto fallThrough = lstOp.fallThrough();

        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(lstOp); GO_BACK_TO(curBlock);

        /// pC = p->apCsr[pOp->p1];
        auto pCAddr = getElementPtrImm(LOC, T::VdbeCursorPtrTy, vdbeCtx->apCsr, p1);
        auto pC = load(LOC, pCAddr);

        /// pCrsr = pC->uc.pCursor;
        auto pCrsrAddr = getElementPtrImm(LOC, T::BtCursorPtrTy, pC, 0, 12, 0);
        auto pCrsr = load(LOC, pCrsrAddr);

        /// res = 0
        // TODO

        if (vdbe->aOp[pc].opcode == OP_SeekEnd) {
            /// pC->seekResult = -1;
            auto seekResultAddr = getElementPtrImm(LOC, T::i32PtrTy, pC, 0, 10);
            store(LOC, constants(-1, 32), seekResultAddr);

            auto result = call(LOC, f_sqlite3BtreeCursorIsValidNN, pCrsr).getValue();
            auto cursorIsValid = iCmp(LOC, Pred::ne, result, 0);

            curBlock = rewriter.getBlock();
            auto blockNotValid = SPLIT_GO_BACK_TO(curBlock);
            condBranch(LOC, cursorIsValid, fallThrough, blockNotValid);

            ip_start(blockNotValid);
        }

        auto stackState = saveStack(LOC);

        /// int res = 0;
        auto res = alloca(LOC, T::i32PtrTy);
        store(LOC, 0, res);

        /// rc = sqlite3BtreeLast(pCrsr, &res);
        auto rc = call(LOC, f_sqlite3BtreeLast, pCrsr, res).getValue();

        /// pC->nullRow = (u8) res;
        auto nullRowAddr = getElementPtrImm(LOC, T::i8PtrTy, pC, 0, 2);
        store(LOC, trunc(LOC, load(LOC, res), T::i8Ty), nullRowAddr);

        /// pC->deferredMoveto = 0;
        auto deferredMoveToAddr = getElementPtrImm(LOC, T::i8PtrTy, pC, 0, 3);
        store(LOC, 0, deferredMoveToAddr);

        /// pC->cacheStatus = CACHE_STALE;
        auto cacheStatusAddr = getElementPtrImm(LOC, T::i32PtrTy, pC, 0, 9);
        store(LOC, CACHE_STALE, cacheStatusAddr);

        { // if (rc) goto abort_due_to_error;
            auto rcNull = iCmp(LOC, Pred::eq, rc, 0);
            myAssert(LOCL, rcNull);
        } // end if (rc) goto abort_due_to_error;

        branch(LOC, endBlock);

        ip_start(endBlock);
        restoreStack(LOC, stackState);
        rewriter.eraseOp(lstOp);

        branch(LOC, jumpTo);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes