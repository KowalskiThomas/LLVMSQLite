#include "Standalone/ConstantManager.h"
#include "Standalone/Lowering/MyBuilder.h"
#include "Standalone/AllIncludes.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"
#include "Standalone/Lowering/OutToPrerelease.h"
#include "Standalone/Lowering/MemSetNull.h"

#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"

extern LLVMFuncOp f_sqlite3VdbeCursorRestore;
extern LLVMFuncOp f_sqlite3VdbeIdxRowid;

namespace mlir::standalone::passes {
    LogicalResult DeferredSeekLowering::matchAndRewrite(DeferredSeek dsOp, PatternRewriter &rewriter) const {
        auto op = &dsOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        Inlining::MemSetNull memSetNull(*vdbeCtx, *ctx, rewriter, print, constants);
        myOperators

        auto firstBlock = rewriter.getBlock();

        auto pc = dsOp.pcAttr().getUInt();
        // curTarget = p1
        auto curTarget = dsOp.curTargetAttr().getSInt();
        // curToMove = p2
        auto curToMove = dsOp.curToMoveAttr().getSInt();
        // array = p4
        // auto array = (const int *) dsOp.arrayAttr().getUInt();

        USE_DEFAULT_BOILERPLATE

        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(dsOp); GO_BACK_TO(curBlock);

        auto stackState = saveStack(LOC);
        auto rowIdAddr = alloca(LOC, T::i64PtrTy);

        auto pCAddr = getElementPtrImm(LOC, T::VdbeCursorPtrTy.getPointerTo(), vdbeCtx->apCsr, curTarget);
        auto pC = load(LOC, pCAddr);

        auto rc = call(LOC, f_sqlite3VdbeCursorRestore, pC).getValue();

        auto nullRowAddr = getElementPtrImm(LOC, T::i8PtrTy, pC, 0, 2);
        auto nullRow = load(LOC, nullRowAddr);

        curBlock = rewriter.getBlock();
        auto blockAfterNullRowNull = SPLIT_GO_BACK_TO(curBlock);
        auto blockNotNullRowNull = SPLIT_GO_BACK_TO(curBlock);
        auto blockNullRowNull = SPLIT_GO_BACK_TO(curBlock);

        auto condNullRowNull = iCmp(LOC, Pred::eq, nullRow, 0);

        condBranch(LOC, condNullRowNull, blockNullRowNull, blockNotNullRowNull);
        { // if (!pC->nullRow)
            ip_start(blockNullRowNull);

            auto pCursorAddr = getElementPtrImm(LOC, T::BtCursorPtrTy, pC, 0, 12, 0);
            auto pCursor = load(LOC, pCursorAddr);
            auto rc = call(LOC, f_sqlite3VdbeIdxRowid, vdbeCtx->db, pCursor, rowIdAddr).getValue();

            { // if (rc != SQLITE_OK) goto abort_due_to_error;
                auto rcIsOk = iCmp(LOC, Pred::eq, rc, SQLITE_OK);
                myAssert(LOCL, rcIsOk);
            } // end if (rc != SQLITE_OK) goto abort_due_to_error;

            if (vdbe->aOp[pc].opcode == OP_DeferredSeek) {
                auto pTabCurAddr = getElementPtrImm(LOC, T::VdbeCursorPtrPtrTy, vdbeCtx->apCsr, curToMove);
                auto pTabCur = load(LOC, pTabCurAddr);

                /// pTabCur->nullRow = 0;
                auto nullRowAddr = getElementPtrImm(LOC, T::i8PtrTy, pTabCur, 0, 2);
                store(LOC, 0, nullRowAddr);

                /// pTabCur->movetoTarget = rowid;
                auto moveToTargetAddr = getElementPtrImm(LOC, T::i64PtrTy, pTabCur, 0, 18);
                auto rowId = load(LOC, rowIdAddr);
                store(LOC, rowId, moveToTargetAddr);

                /// pTabCur->deferredMoveto = 1;
                auto deferredMoveToAddr = getElementPtrImm(LOC, T::i8PtrTy, pTabCur, 0, 3);
                store(LOC, 1, deferredMoveToAddr);

                /// pTabCur->aAltMap = pOp->p4.ai;
                auto aAltMapAddr = getElementPtrImm(LOC, T::i32PtrTy.getPointerTo(), pTabCur, 0, 8);
                auto pOpValue = getElementPtrImm(LOC, T::VdbeOpPtrTy, vdbeCtx->aOp, (int)pc);
                auto p4UAddr = getElementPtrImm(LOC, T::p4unionPtrTy, pOpValue, 0, 6);
                auto p4i32PtrAddr = bitCast(LOC, p4UAddr, T::i32PtrTy.getPointerTo());
                auto p4i32Ptr = load(LOC, p4i32PtrAddr);
                store(LOC, p4i32Ptr, aAltMapAddr);

                /// pTabCur->pAltCursor = pC;
                auto pAltCursorAddr = getElementPtrImm(LOC, T::VdbeCursorPtrPtrTy, pTabCur, 0, 11);
                store(LOC, pC, pAltCursorAddr);
            } else {
                auto outToPrelease = Inlining::OutToPrerelease(*vdbeCtx, context, rewriter, print, constants);
                auto pOp = getElementPtrImm(LOC, T::VdbeOpPtrTy, vdbeCtx->aOp, (int)pc);
                auto pOut = outToPrelease(LOC, vdbeCtx->p, pOp);

                auto pOutUnionAddress = getElementPtrImm(LOC, T::doublePtrTy, pOut, 0, 0, 0);
                auto pOutIntAddress = bitCast(LOC, pOutUnionAddress, T::i64PtrTy);
                auto rowId = load(LOC, rowIdAddr);
                store(LOC, rowId, pOutIntAddress);
            }

            branch(LOC, blockAfterNullRowNull);
        } // end if (!pC->nullRow)
        { // else of if (!pC->nullRow)
            ip_start(blockNotNullRowNull);

            auto mem = getElementPtrImm(LOC, T::sqlite3_valuePtrTy, vdbeCtx->aMem, curToMove);
            memSetNull(LOC, mem);
            // call(LOC, f_sqlite3VdbeMemSetNull, mem);

            branch(LOC, blockAfterNullRowNull);
        } // end else of if (!pC->nullRow)

        ip_start(blockAfterNullRowNull);

        branch(LOC, endBlock);

        ip_start(endBlock);

        restoreStack(LOC, stackState);
        rewriter.eraseOp(dsOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes