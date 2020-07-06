#include "Standalone/ConstantManager.h"
#include "Standalone/Lowering/MyBuilder.h"
#include "Standalone/AllIncludes.h"
#include "Standalone/Lowering/OutToPrerelease.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"

#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"


extern LLVMFuncOp f_sqlite3VdbeCursorRestore;
extern LLVMFuncOp f_sqlite3BtreeIntegerKey;

namespace mlir::standalone::passes {
    LogicalResult RowidLowering::matchAndRewrite(Rowid txnOp, PatternRewriter &rewriter) const {
        auto op = &txnOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        myOperators

        auto firstBlock = rewriter.getBlock();

        auto pc = txnOp.pcAttr().getUInt();
        auto p1 = txnOp.p1Attr().getSInt();
        auto p2 = txnOp.p2Attr().getSInt();

        USE_DEFAULT_BOILERPLATE

        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(txnOp); GO_BACK_TO(curBlock);

        auto stackState = saveStack(LOC);
        auto vAddr = alloca(LOC, T::i64PtrTy);

        auto outToPrerelease = Inlining::OutToPrerelease(*vdbeCtx, context, rewriter, print, constants);
        auto pOp = getElementPtrImm(LOC, T::VdbeOpPtrTy, vdbeCtx->aOp, (int)pc);
        auto pOut = outToPrerelease(LOC, vdbeCtx->p, pOp);

        /// pC = p->apCsr[pOp->p1];
        auto pCAddr = getElementPtrImm(LOC, T::VdbeCursorPtrPtrTy, vdbeCtx->apCsr, p1);
        auto pC = load(LOC, pCAddr);

        /// if (pC->nullRow)
        auto nullRowAddr = getElementPtrImm(LOC, T::i8PtrTy, pC, 0, 2);
        auto nullRow = load(LOC, nullRowAddr);
        auto nullRowNotNull = iCmp(LOC, Pred::ne, nullRow, 0);

#ifndef SQLITE_OMIT_VIRTUALTABLE
      llvm_unreachable("RowidLowering.cpp:56 This has been written assuming SQLITE_OMIT_VIRTUALTABLE")
#endif

        curBlock = rewriter.getBlock();
        auto blockAfter = SPLIT_GO_BACK_TO(curBlock);
        auto blockElse = SPLIT_GO_BACK_TO(curBlock);
        auto blockCurTypeVtab = SPLIT_GO_BACK_TO(curBlock);
        auto blockNotDeferredMoveTo = SPLIT_GO_BACK_TO(curBlock);
        auto blockDeferredMoveTo = SPLIT_GO_BACK_TO(curBlock);
        auto blockNullRowNull = SPLIT_GO_BACK_TO(curBlock);
        auto blockNullRowNotNull = SPLIT_GO_BACK_TO(curBlock);

        condBranch(LOC, nullRowNotNull, blockNullRowNotNull, blockNullRowNull);
        { // if (pC->nullRow)
            ip_start(blockNullRowNotNull);

            /// pOut->flags = MEM_Null
            auto outFlagsAddr = getElementPtrImm(LOC, T::i16PtrTy, pOut, 0, 1);
            store(LOC, MEM_Null, outFlagsAddr);

            /// break;
            branch(LOC, endBlock);
        } // end if (pC->nullRow)
        { // else of if (pC->nullRow)
            ip_start(blockNullRowNull);

            auto deferredMoveToAddr = getElementPtrImm(LOC, T::i8PtrTy, pC, 0, 3);
            auto deferredMoveTo = load(LOC, deferredMoveToAddr);
            auto deferredMoveToNotNull = iCmp(LOC, Pred::ne, deferredMoveTo, 0);

            condBranch(LOC, deferredMoveToNotNull, blockDeferredMoveTo, blockNotDeferredMoveTo);
        } // end else of if (pC->nullRow)
        { // if (pC->deferredMoveTo)
            ip_start(blockDeferredMoveTo);

            /// v = pC->movetoTarget;
            auto moveToTargetAddr = getElementPtrImm(LOC, T::i64PtrTy, pC, 0, 18);
            auto moveToTarget = load(LOC, moveToTargetAddr);
            store(LOC, moveToTarget, vAddr);

            branch(LOC, blockAfter);
        } // end if (pC->deferredMoveTo)
        { // else of if (pC->deferredMoveTo)
            ip_start(blockNotDeferredMoveTo);

            // else if (pC->eCurType == CURTYPE_VTAB)
            auto curTypeAddr = getElementPtrImm(LOC, T::i8PtrTy, pC, 0, 0);
            auto curType = load(LOC, curTypeAddr);
            auto curTypeVtab = iCmp(LOC, Pred::eq, curType, CURTYPE_VTAB);

            condBranch(LOC, curTypeVtab, blockCurTypeVtab, blockElse);
        } // end else of if (pC->deferredMoveTo)
        { // if (pC->eCurType == CURTYPE_VTAB)
            ip_start(blockCurTypeVtab);

            /// pVtab = pC->uc.pVCur->pVtab;
            auto pCursorAddr = getElementPtrImm(LOC, T::BtCursorPtrTy.getPointerTo(), pC, 0, 12, 0);
            pCursorAddr = bitCast(LOC, pCursorAddr, T::sqlite3_vtab_cursorPtrPtrTy);
            auto pVCur = load(LOC, pCursorAddr);
            auto pVtabAddr = getElementPtrImm(LOC, T::sqlite3_vtabPtrPtrTy, pVCur, 0, 0);
            auto pVtab = load(LOC, pVtabAddr);

            /// pModule = pVtab->pModule;
            auto pModuleAddr = getElementPtrImm(LOC, T::sqlite3_modulePtrTy.getPointerTo(), pVtab, 0, 0);
            auto pModule = load(LOC, pModuleAddr);

            /// rc = pModule->xRowid(pC->uc.pVCur, &v);
            print(LOCL, "TODO: Call pModule->xRowId");
            myAssert(LOCL, constants(0, 1));

            branch(LOC, blockAfter);
        } // end if (pC->eCurType == CURTYPE_VTAB)
        { // else of if (pC->eCurType == CURTYPE_VTAB)
            ip_start(blockElse);

            /// rc = sqlite3VdbeCursorRestore(pC);
            auto rc = call(LOC, f_sqlite3VdbeCursorRestore, pC).getValue();

            { // if (rc) goto abort_due_to_error;
                auto rcNull = iCmp(LOC, Pred::eq, rc, 0);
                myAssert(LOCL, rcNull);
            } // end if (rc) goto abort_due_to_error;

            auto nullRowAddr = getElementPtrImm(LOC, T::i8PtrTy, pC, 0, 2);
            auto nullRow = load(LOC, nullRowAddr);
            auto nullRowNotNull = iCmp(LOC, Pred::ne, nullRow, 0);

            auto curBlock = rewriter.getBlock();
            auto blockAfterNullRowNotNull = SPLIT_GO_BACK_TO(curBlock);
            auto blockNullRowNotNull = SPLIT_GO_BACK_TO(curBlock);

            condBranch(LOC, nullRowNotNull, blockNullRowNotNull, blockAfterNullRowNotNull);
            { // if (pC->nullRow)
                ip_start(blockNullRowNotNull);

                /// pOut->flags = MEM_Null
                auto flagsAddr = getElementPtrImm(LOC, T::i16PtrTy, pOut, 0, 1);
                store(LOC, constants(MEM_Null, 16), flagsAddr);

                /// break;
                branch(LOC, endBlock);
            } // end if (pC->nullRow)
            ip_start(blockAfterNullRowNotNull);

            /// v = sqlite3BtreeIntegerKey(pC->uc.pCursor);
            auto pCursorAddr = getElementPtrImm(LOC, T::BtCursorPtrTy, pC, 0, 12, 0);
            auto pCursor = load(LOC, pCursorAddr);
            auto result = call(LOC, f_sqlite3BtreeIntegerKey, pCursor).getValue();
            store(LOC, result, vAddr);

            branch(LOC, blockAfter);
        } // end else of if (pC->eCurType == CURTYPE_VTAB)
        ip_start(blockAfter);

        /// pOut->u.i = v;
        auto outUAddr = getElementPtrImm(LOC, T::doublePtrTy, pOut, 0, 0, 0);
        auto outIAddr = bitCast(LOC, outUAddr, T::i64PtrTy);
        auto vVal = load(LOC, vAddr);
        store(LOC, vVal, outIAddr);

        branch(LOC, endBlock);
        ip_start(endBlock);

        restoreStack(LOC, stackState);
        rewriter.eraseOp(txnOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes