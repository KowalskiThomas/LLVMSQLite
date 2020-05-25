#include <llvm/Support/DynamicLibrary.h>

#include <src/mlir/include/Standalone/ConstantManager.h>
#include <src/mlir/include/Standalone/Lowering/MyBuilder.h>
#include "Standalone/AllIncludes.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"

#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"


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

        auto firstBlock = rewriter.getBlock();

        auto curIdx = snOp.curIdxAttr().getSInt();
        auto hints = snOp.hintsAttr().getUInt();

        auto jumpTo = snOp.jumpTo();
        auto fallthrough = snOp.fallthrough();
        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(snOp); GO_BACK_TO(curBlock);

        /// pC = p->apCsr[pOp->p1];
        auto pCValue = vdbe->apCsr[curIdx];
        auto pC = constants(T::VdbeCursorPtrTy, pCValue);

        /// TODO assert(isSorter(pC));

        /// rc = sqlite3VdbeSorterNext(db, pC);
        auto db = constants(T::sqlite3PtrTy, vdbe->db);
        auto rc = call(LOC, f_sqlite3VdbeSorterNext, db, pC).getValue();

        /// goto next_tail;
        auto cacheStatusAddr = constants(T::i32PtrTy, &pCValue->cacheStatus);
        store(LOC, CACHE_STALE, cacheStatusAddr);

        auto nullRowAddr = constants(T::i8PtrTy, &pCValue->nullRow);

        curBlock = rewriter.getBlock();
        auto blockAfterRcIsOk = SPLIT_BLOCK; GO_BACK_TO(curBlock);
        auto blockRcIsOk = SPLIT_BLOCK; GO_BACK_TO(curBlock);

        auto rcIsOk = iCmp(LOC, Pred::eq, rc, SQLITE_OK);
        condBranch(LOC, rcIsOk, blockRcIsOk, blockAfterRcIsOk);
        { // if rc == SQLITE_OK
            ip_start(blockRcIsOk);

            store(LOC, 0, nullRowAddr);

            auto aCounterAddr = constants(T::i32PtrTy, &vdbe->aCounter[hints]);
            auto counterVal = load(LOC, aCounterAddr);
            auto counterValPlus1 = add(LOC, counterVal, 1);
            store(LOC, counterValPlus1, aCounterAddr);

            // TODO goto jump_to_p2_and_check_for_interrupt;

            branch(LOC, blockAfterRcIsOk);
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

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes