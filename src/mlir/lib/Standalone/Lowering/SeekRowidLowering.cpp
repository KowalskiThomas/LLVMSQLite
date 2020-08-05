#include "Standalone/ConstantManager.h"
#include "Standalone/Lowering/MyBuilder.h"
#include "Standalone/AllIncludes.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"

#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"

extern LLVMFuncOp f_applyAffinity;
extern LLVMFuncOp f_sqlite3BtreeMovetoUnpacked;

namespace mlir::standalone::passes {
    LogicalResult SeekRowidLowering::matchAndRewrite(SeekRowid srOp, PatternRewriter &rewriter) const {
        auto op = &srOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        myOperators

        auto firstBlock = rewriter.getBlock();

        auto pc = srOp.pcAttr().getUInt();
        auto p1 = srOp.curIdxAttr().getSInt();
        auto p3 = srOp.regAttr().getSInt();

        USE_DEFAULT_BOILERPLATE

        auto jumpTo = srOp.jumpTo();
        auto fallThrough = srOp.fallThrough();

        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(srOp);
        GO_BACK_TO(curBlock);

        auto stackState = saveStack(LOC);

        auto resAddr = alloca(LOC, T::i32PtrTy);
        auto iKeyAddr = alloca(LOC, T::i64PtrTy);
        auto rcAddr = alloca(LOC, T::i32PtrTy);

        auto pIn3 = getElementPtrImm(LOC, T::sqlite3_valuePtrTy, vdbeCtx->aMem, p3);

        auto inFlagsAddr = getElementPtrImm(LOC, T::i16PtrTy, pIn3, 0, 1);
        auto inFlags = load(LOC, inFlagsAddr);
        auto inFlagsAndInt = bitAnd(LOC, inFlags, MEM_Int | MEM_IntReal);

        curBlock = rewriter.getBlock();
        auto blockAfterInNotNumeric = SPLIT_GO_BACK_TO(curBlock);
        auto blockInNumeric = SPLIT_GO_BACK_TO(curBlock);
        auto blockInNotNumeric = SPLIT_GO_BACK_TO(curBlock);

        auto condInNotInt = iCmp(LOC, Pred::eq, inFlagsAndInt, 0);

        condBranch(LOC, condInNotInt, blockInNotNumeric, blockInNumeric);
        { // if ((pIn3->flags & (MEM_Int | MEM_IntReal)) == 0)
            ip_start(blockInNotNumeric);

            /// Mem x = pIn3[0];
            auto x = alloca(LOC, T::sqlite3_valuePtrTy);
            store(LOC, load(LOC, pIn3), x);

            /// applyAffinity(&x, SQLITE_AFF_NUMERIC, encoding);
            call(LOC, f_applyAffinity, x, constants(SQLITE_AFF_NUMERIC, 8), constants(vdbe->db->enc, 8));

            /// if ((x.flags & MEM_Int) == 0) goto jump_to_p2;
            auto xFlagsAddr = getElementPtrImm(LOC, T::i16PtrTy, x, 0, 1);
            auto xFlags = load(LOC, xFlagsAddr);
            auto xFlagsAndInt = bitAnd(LOC, xFlags, MEM_Int);
            auto xNotInt = iCmp(LOC, Pred::eq, xFlagsAndInt, 0);

            auto curBlock = rewriter.getBlock();
            auto blockInt = SPLIT_GO_BACK_TO(curBlock);

            /// ... goto jump_to_p2
            condBranch(LOC, xNotInt, jumpTo, blockInt);
            ip_start(blockInt);

            /// iKey = x.u.i;
            auto xUAddr = getElementPtrImm(LOC, T::doublePtrTy, x, 0, 0);
            auto xIntAddr = bitCast(LOC, xUAddr, T::i64PtrTy);
            auto xInt = load(LOC, xIntAddr);
            store(LOC, xInt, iKeyAddr);

            branch(LOC, blockAfterInNotNumeric);
        } // end if ((pIn3->flags & (MEM_Int | MEM_IntReal)) == 0)
        { // else of if ((pIn3->flags & (MEM_Int | MEM_IntReal)) == 0)
            ip_start(blockInNumeric);

            auto inUAddr = getElementPtrImm(LOC, T::doublePtrTy, pIn3, 0, 0);
            auto inIntAddr = bitCast(LOC, inUAddr, T::i64PtrTy);
            auto inInt = load(LOC, inIntAddr);
            store(LOC, inInt, iKeyAddr);

            branch(LOC, blockAfterInNotNumeric);
        } // end else of if ((pIn3->flags & (MEM_Int | MEM_IntReal)) == 0)

        ip_start(blockAfterInNotNumeric);

        /// pC = p->apCsr[pOp->p1];
        auto pCAddr = getElementPtrImm(LOC, T::VdbeCursorPtrPtrTy, vdbeCtx->apCsr, p1);
        auto pC = load(LOC, pCAddr);

        /// pCrsr = pC->uc.pCursor;
        auto pCrsrAddr = getElementPtrImm(LOC, T::BtCursorPtrTy, pC, 0, 12, 0);
        auto pCrsr = load(LOC, pCrsrAddr);

        /// res = 0
        store(LOC, 0, resAddr);

        /// rc = sqlite3BtreeMovetoUnpacked(pCrsr, 0, iKey, 0, &res);
        auto iKeyValue = load(LOC, iKeyAddr);
        auto rcValue = call(LOC, f_sqlite3BtreeMovetoUnpacked,
                            pCrsr,
                            constants(T::UnpackedRecordPtrTy, (UnpackedRecord*)nullptr),
                            iKeyValue,
                            constants(0, 32),
                            resAddr
        ).getValue();
        store(LOC, rcValue, rcAddr);

        /// pC->movetoTarget = iKey;
        auto moveToTargetAddr = getElementPtrImm(LOC, T::i64PtrTy, pC, 0, 18);
        store(LOC, iKeyValue, moveToTargetAddr);

        /// pC->nullRow = 0;
        auto nullRowAddr = getElementPtrImm(LOC, T::i8PtrTy, pC, 0, 2);
        store(LOC, 0, nullRowAddr);

        /// pC->cacheStatus = CACHE_STALE;
        auto cacheStatusAddr = getElementPtrImm(LOC, T::i32PtrTy, pC, 0, 9);
        store(LOC, CACHE_STALE, cacheStatusAddr);

        /// pC->deferredMoveto = 0;
        auto deferredMoveToAddr = getElementPtrImm(LOC, T::i8PtrTy, pC, 0, 3);
        store(LOC, 0, deferredMoveToAddr);

        /// pC->seekResult = res;
        auto resValue = load(LOC, resAddr);
        auto seekResultAddr = getElementPtrImm(LOC, T::i32PtrTy, pC, 0, 10);
        store(LOC, resValue, seekResultAddr);

        /// if (res != 0)
        curBlock = rewriter.getBlock();
        auto blockAfterResNotNull = SPLIT_BLOCK;
        GO_BACK_TO(curBlock);
        auto blockResNotNull = SPLIT_BLOCK;
        GO_BACK_TO(curBlock);

        auto condResNotNull = iCmp(LOC, Pred::ne, resValue, 0);

        condBranch(LOC, condResNotNull, blockResNotNull, blockAfterResNotNull);
        { // if (res != 0)
            ip_start(blockResNotNull);

            if (vdbe->aOp[pc].p2 == 0) {
                store(LOC, SQLITE_CORRUPT_BKPT, rcAddr);
                branch(LOC, blockAfterResNotNull);
            } else {
                restoreStack(LOC, stackState);
                branch(LOC, jumpTo);
            }

            // No branch here: it's in the if-else
        } // end if (res != 0)

        ip_start(blockAfterResNotNull);

        branch(LOC, endBlock);
        ip_start(endBlock);

        { // if (rc) goto abort_due_to_error;
            auto rc = load(LOC, rcAddr);
            auto rcNull = iCmp(LOC, Pred::eq, rc, 0);
            myAssert(LOCL, rcNull);
        } // end if (rc) goto abort_due_to_error;

        restoreStack(LOC, stackState);
        branch(LOC, fallThrough);
        rewriter.eraseOp(srOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes