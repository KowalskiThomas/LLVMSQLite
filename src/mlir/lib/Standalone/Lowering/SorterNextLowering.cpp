#include "Standalone/ConstantManager.h"
#include "Standalone/Lowering/MyBuilder.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"

#include "Standalone/StandalonePasses.h"


namespace mlir::standalone::passes {
    LogicalResult SorterNextLowering::matchAndRewrite(SorterNext snOp, PatternRewriter &rewriter) const {
        auto op = &snOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        myOperators

        print(LOCL, "-- SorterNext");

        auto firstBlock = rewriter.getBlock();

        auto curIdx = snOp.curIdxAttr().getSInt();
        auto hints = snOp.hintsAttr().getUInt();
        auto pc = snOp.pcAttr().getUInt();
        if (false) { // call to default
            // TODO: Use our own implementation
            rewriter.create<StoreOp>(LOC, constants(1, 64), constants(T::i64PtrTy, &maxVdbeSteps));
            rewriter.create<StoreOp>(LOC, constants(pc, 32), constants(T::i32PtrTy, &vdbe->pc));
            rewriter.create<CallOp>(LOC, f_sqlite3VdbeExec2, ValueRange {constants(T::VdbePtrTy, vdbe) });
            rewriter.eraseOp(*op);

            if (op->getOperation()->isKnownTerminator()) {
                rewriter.create<BranchOp>(LOC, vdbeCtx->jumpsBlock);
            }

            return success();
        }

        auto jumpTo = snOp.jumpTo();
        auto fallthrough = snOp.fallthrough();
        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(snOp); GO_BACK_TO(curBlock);

        /// pC = p->apCsr[pOp->p1];
        auto pCValueAddr = getElementPtrImm(LOC, T::VdbeCursorPtrTy.getPointerTo(), vdbeCtx->apCsr, curIdx);
        auto pC = load(LOC, pCValueAddr);

        /// TODO assert(isSorter(pC));

        /// rc = sqlite3VdbeSorterNext(db, pC);
        auto db = vdbeCtx->db;
        auto rc = call(LOC, f_sqlite3VdbeSorterNext, db, pC).getValue();

        /// goto next_tail;
        auto cacheStatusAddr = getElementPtrImm(LOC, T::i32PtrTy, pC, 0, 9);
        store(LOC, CACHE_STALE, cacheStatusAddr);

        auto nullRowAddr = getElementPtrImm(LOC, T::i8PtrTy, pC, 0, 2);

        curBlock = rewriter.getBlock();
        auto blockAfterRcIsOk = SPLIT_BLOCK; GO_BACK_TO(curBlock);
        auto blockRcIsOk = SPLIT_BLOCK; GO_BACK_TO(curBlock);

        auto rcIsOk = iCmp(LOC, Pred::eq, rc, SQLITE_OK);
        condBranch(LOC, rcIsOk, blockRcIsOk, blockAfterRcIsOk);
        { // if rc == SQLITE_OK
            ip_start(blockRcIsOk);

            store(LOC, 0, nullRowAddr);

            /* TODO: Hints counter
            auto aCounterAddr = constants(T::i32PtrTy, &vdbe->aCounter[hints]);
            auto counterVal = load(LOC, aCounterAddr);
            auto counterValPlus1 = add(LOC, counterVal, 1);
            store(LOC, counterValPlus1, aCounterAddr);
            */

            branch(LOC, jumpTo);
            // print(LOCL, "goto jump_to_p2_and_check_for_interrupt");
            // branch(LOC, blockAfterRcIsOk);
        } // end if rc == SQLITE_OK

        ip_start(blockAfterRcIsOk);

        { // if (rc != SQLITE_DONE) goto abort_due_to_error;
            auto rcNeDone = iCmp(LOC, Pred::ne, rc, SQLITE_DONE);

            // TODO: rc = SQLITE_OK;

            // pC->nullRow = 1;
            store(LOC, 1, nullRowAddr);

        } // end if (rc != SQLITE_DONE) goto abort_due_to_error;

        branch(LOC, endBlock);

        ip_start(endBlock);

        rewriter.eraseOp(snOp);

        branch(LOC, fallthrough);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes