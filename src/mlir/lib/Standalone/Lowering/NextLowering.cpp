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
    LogicalResult NextLowering::matchAndRewrite(Next nxtOp, PatternRewriter &rewriter) const {
        auto op = &nxtOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        myOperators

        print(LOCL, "-- Next");

        rewriter.eraseOp(nxtOp);

        auto curIdxAttr = nxtOp.curIdxAttr();
        auto jumpTo = nxtOp.jumpTo();
        auto fallthrough = nxtOp.fallthrough();
        auto hintsAttr = nxtOp.curHintAttr();
        auto advancerAttr = nxtOp.advancerAttr();
        auto p5Attr = nxtOp.P5Attr();

        auto curIdxValue = curIdxAttr.getSInt();
        auto hintsValue = hintsAttr.getSInt();
        auto advancerValue = advancerAttr.getUInt();
        auto p5Value = p5Attr.getUInt();

        out("Next cursor index " << curIdxValue);

        auto pCAddr = constants(T::VdbeCursorPtrPtrTy, &vdbe->apCsr[curIdxValue]);
        auto pCValue = load(LOC, pCAddr);

        { // assert pC != 0
            auto pcValue2 = ptrToInt(LOC, pCValue);
            auto pCNotNull = iCmp(LOC, Pred::ne, pcValue2, 0);
            myAssert(LOCL, pCNotNull);
        } // end assert pC != 0

        /// rc = pOp->p4.xAdvance(pC->uc.pCursor, pOp->p3);

        LLVMFuncOp toCall;
        if (advancerValue == (uint64_t)sqlite3BtreeNext) {
            toCall = f_sqlite3BtreeNext;
        } else {
            err("Unsupported advancer " << advancerValue);
            exit(11);
        }

        /// rc = pOp->p4.xAdvance(pC->uc.pCursor, pOp->p3);
        // Get &pC->uc.pCursor
        auto pCursorAddr = rewriter.create<GEPOp>
                (LOC, T::BtCursorPtrTy.getPointerTo(), pCValue, ValueRange{
                        constants(0, 32),  // &*pC
                        constants(12, 32), // &pC->uc
                        constants(0, 32)   // &pC->uc.pCursor
                });
        // Load pC->uc.pCursor
        auto pCursor = load(LOC, pCursorAddr);
        // Convert pC->uc.pCursor to a BtCursor*
        auto pCursorAsBtree = bitCast(LOC, pCursor, T::BtCursorPtrTy);
        // Call the advancer function
        auto rc = call(LOC, toCall, pCursorAsBtree, constants(hintsValue, 32)).getValue();

        print(LOCL, rc, "Advancer result:");

        // Get &pC->nullRow (used later)
        auto nullRowAddr = getElementPtrImm(LOC, T::i8PtrTy, pCValue, 0, 2);

        /// pC->cacheStatus = CACHE_STALE;
        auto cacheStatusAddr = getElementPtrImm(LOC, T::i32PtrTy, pCValue, 0, 9);
        store(LOC, CACHE_STALE, cacheStatusAddr);

        /// if (rc == SQLITE_OK)
        auto rcIsOk = iCmp(LOC, Pred::eq, rc, SQLITE_OK);

        auto curBlock = rewriter.getBlock();
        auto blockAfter = SPLIT_BLOCK; GO_BACK_TO(curBlock);
        auto blockOk = SPLIT_BLOCK; GO_BACK_TO(curBlock);

        condBranch(LOC, rcIsOk, blockOk, blockAfter);

        { // if (rc == SQLITE_OK)
            ip_start(blockOk);

            /// pC->nullRow = 0
            store(LOC, 0, nullRowAddr);


            /// p->aCounter[pOp->p5]++
            auto aCounterAddr = constants(T::i32PtrTy, (int*)&vdbe->aCounter[p5Value]);
            auto aCounterValue = load(LOC, aCounterAddr);
            auto aCounterValuePlus1 = add(LOC, aCounterValue, 1);
            store(LOC, aCounterValuePlus1, aCounterAddr);

            // TODO: goto jump_to_p2_and_check_for_interrupt;

            branch(LOC, jumpTo);
        } // end if (rc == SQLITE_OK)

        ip_start(blockAfter);

        { // assert rc == SQLITE_DONE
            auto rcIsDone = iCmp(LOC, Pred::eq, rc, SQLITE_DONE);
            myAssert(LOCL, rcIsDone);
        } // end assert rc == SQLITE_DONE

        // TODO: rc = SQLITE_OK

        /// pC->nullRow = 1
        store(LOC, 1, nullRowAddr);

        // TODO: goto check_for_interrupt;
        branch(LOC, fallthrough);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes