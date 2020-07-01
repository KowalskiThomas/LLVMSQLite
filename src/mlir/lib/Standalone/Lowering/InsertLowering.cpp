#include "Standalone/ConstantManager.h"
#include "Standalone/Lowering/MyBuilder.h"
#include "Standalone/AllIncludes.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"

#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"


extern LLVMFuncOp f_sqlite3BtreeInsert;

namespace mlir::standalone::passes {
    LogicalResult InsertLowering::matchAndRewrite(Insert txnOp, PatternRewriter &rewriter) const {
        auto op = &txnOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        myOperators

        auto pc = txnOp.pcAttr().getUInt();
        auto p1 = txnOp.p1Attr().getSInt();
        auto p2 = txnOp.p2Attr().getSInt();
        auto p3 = txnOp.p3Attr().getSInt();
        auto p4 = txnOp.p4Attr().getUInt();
        auto p5 = txnOp.p5Attr().getUInt();

        USE_DEFAULT_BOILERPLATE

        auto firstBlock = rewriter.getBlock();
        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(txnOp); GO_BACK_TO(curBlock);

        /// pData = &aMem[pOp->p2];
        auto pData = getElementPtrImm(LOC, T::sqlite3_valuePtrTy, vdbeCtx->aMem, p2);

        /// pC = p->apCsr[pOp->p1];
        auto pCAddr = getElementPtrImm(LOC, T::VdbeCursorPtrTy.getPointerTo(), vdbeCtx->apCsr, p1);
        auto pC = load(LOC, pCAddr);

        /// pKey = &aMem[pOp->p3];
        auto pKey = getElementPtrImm(LOC, T::sqlite3_valuePtrTy, vdbeCtx->aMem, p3);

        // BtreePayload x;
        auto stackState = saveStack(LOC);
        auto pTabAddr = alloca(LOC, T::TablePtrPtrTy);
        auto zDbAddr = alloca(LOC, T::i8PtrPtrTy);
        auto x = alloca(LOC, T::BtreePayloadPtrTy);
        auto nKeyAddr = getElementPtrImm(LOC, T::i64PtrTy, x, 0, 1);
        auto pKeyUAddr = getElementPtrImm(LOC, T::doublePtrTy, pKey, 0, 0, 0);
        auto pKeyIAddr = bitCast(LOC, pKeyUAddr, T::i64PtrTy);
        auto pKeyInt = load(LOC, pKeyIAddr);
        store(LOC, pKeyInt, nKeyAddr);

        auto p4type = constants(vdbe->aOp[pc].p4type, 32);
        auto p4IsTable = iCmp(LOC, Pred::eq, p4type, P4_TABLE);

        auto updateCallbackAddr = getElementPtrImm(LOC, T::i8PtrPtrTy, vdbeCtx->db, 0, 52);
        auto updateCallback = load(LOC, updateCallbackAddr);
        updateCallback = ptrToInt(LOC, updateCallback);
        auto hasUpdateHook = iCmp(LOC, Pred::ne, updateCallback, 0);

        curBlock = rewriter.getBlock();
        auto blockAfterTableAndUpdateHook = SPLIT_GO_BACK_TO(curBlock);
        auto blockNotTableAndUpdateHook = SPLIT_GO_BACK_TO(curBlock);
        auto blockTableAndUpdateHook = SPLIT_GO_BACK_TO(curBlock);

        auto condTableAndUpdateHook = bitAnd(LOC, p4IsTable, hasUpdateHook);

        condBranch(LOC, condTableAndUpdateHook, blockTableAndUpdateHook, blockNotTableAndUpdateHook);
        { // if (pOp->p4type == P4_TABLE && HAS_UPDATE_HOOK(db))
            ip_start(blockTableAndUpdateHook);

            /// zDb = db->aDb[pC->iDb].zDbSName;
            auto iDbAddr = getElementPtrImm(LOC, T::i8PtrTy, pC, 0, 1);
            auto iDb = load(LOC, iDbAddr);

            auto aDbAddr = getElementPtrImm(LOC, T::DbPtrTy.getPointerTo(), vdbeCtx->db, 0, 4);
            auto aDb = load(LOC, aDbAddr);

            auto db = getElementPtr(LOC, T::sqlite3PtrTy, aDb, iDb);
            auto dbNameAddr = getElementPtrImm(LOC, T::i8PtrPtrTy, db, 0, 0);
            auto dbName = load(LOC, dbNameAddr);

            store(LOC, dbName, zDbAddr);

            /// pTab = pOp->p4.pTab;
            auto pOp = getElementPtrImm(LOC, T::VdbeOpPtrTy, vdbeCtx->aOp, (int)pc);
            auto p4UAddr = getElementPtrImm(LOC, T::p4unionPtrTy, pOp, 0, 6);
            auto p4TablePtrAddr = bitCast(LOC, p4UAddr, T::TablePtrTy.getPointerTo());
            auto p4TablePtr = load(LOC, p4TablePtrAddr);
            store(LOC, p4TablePtr, pTabAddr);

            branch(LOC, blockAfterTableAndUpdateHook);
        } // end if (pOp->p4type == P4_TABLE && HAS_UPDATE_HOOK(db))
        { // else of if (pOp->p4type == P4_TABLE && HAS_UPDATE_HOOK(db))
            ip_start(blockNotTableAndUpdateHook);

            /// pTab = 0;
            store(LOC, constants(T::TablePtrTy, (Table*)nullptr), pTabAddr);

            /// zDb = 0;
            store(LOC, constants(T::i8PtrTy, (char*)nullptr), zDbAddr);

            branch(LOC, blockAfterTableAndUpdateHook);
        } // end else of if (pOp->p4type == P4_TABLE && HAS_UPDATE_HOOK(db))
        ip_start(blockAfterTableAndUpdateHook);

        if (p5 & OPFLAG_NCHANGE) {
            /// p->nChange++
            auto nChangeAddr = getElementPtrImm(LOC, T::i32PtrTy, vdbeCtx->p, 0, 12);
            auto nChange = load(LOC, nChangeAddr);
            nChange = add(LOC, nChange, constants(1, 32));
            store(LOC, nChange, nChangeAddr);
        }

        if (p5 & OPFLAG_LASTROWID) {
            auto lastRowIdAddr = getElementPtrImm(LOC, T::i64PtrTy, vdbeCtx->db, 0, 8);
            auto nKey = load(LOC, nKeyAddr);
            store(LOC, nKey, lastRowIdAddr);
        }

        /// x.pData = pData->z;
        auto pDataZAddr = getElementPtrImm(LOC, T::i8PtrPtrTy, pData, 0, 5);
        auto pDataZ = load(LOC, pDataZAddr);
        auto xPDataAddr = getElementPtrImm(LOC, T::i8PtrPtrTy, x, 0, 2);
        store(LOC, pDataZ, xPDataAddr);

        /// x.nData = pData->n;
        auto pDataNAddr = getElementPtrImm(LOC, T::i32PtrTy, pData, 0, 4);
        auto pDataN = load(LOC, pDataNAddr);
        auto xNDataAddr = getElementPtrImm(LOC, T::i32PtrTy, x, 0, 5);
        store(LOC, pDataN, xNDataAddr);

        /// seekResult = ((pOp->p5 & OPFLAG_USESEEKRESULT) ? pC->seekResult : 0);
        Value seekResult;
        if (p5 & OPFLAG_USESEEKRESULT) {
            auto pCSeekResultAddr = getElementPtrImm(LOC, T::i32PtrTy, pC, 0, 10);
            auto pCSeekResult = load(LOC, pCSeekResultAddr);
            seekResult = pCSeekResultAddr;
        } else {
            seekResult = constants(0, 32);
        }

        auto pDataFlagsAddr = getElementPtrImm(LOC, T::i16PtrTy, pData, 0, 1);
        auto pDataFlags = load(LOC, pDataFlagsAddr);
        auto pDataFlagsAndZero = bitAnd(LOC, pDataFlags, MEM_Zero);

        auto nZeroAddr = getElementPtrImm(LOC, T::i32PtrTy, x, 0, 6);

        curBlock = rewriter.getBlock();
        auto blockAfterPDataIsZero = SPLIT_GO_BACK_TO(curBlock);
        auto blockNotPDataIsZero = SPLIT_GO_BACK_TO(curBlock);
        auto blockPDataIsZero = SPLIT_GO_BACK_TO(curBlock);

        auto condPDataIsZero = iCmp(LOC, Pred::ne, pDataFlagsAndZero, 0);

        condBranch(LOC, condPDataIsZero, blockPDataIsZero, blockNotPDataIsZero);
        { // if (pData->flags & MEM_Zero)
            ip_start(blockPDataIsZero);

            /// x.nZero = pData->u.nZero;
            auto pDataUAddr = getElementPtrImm(LOC, T::doublePtrTy, pData, 0, 0);
            auto pDataNZeroAddr = bitCast(LOC, pDataUAddr, T::i32PtrTy);
            auto pDataNZero = load(LOC, pDataNZeroAddr);

            store(LOC, pDataNZero, nZeroAddr);

            branch(LOC, blockAfterPDataIsZero);
        } // end if (pData->flags & MEM_Zero)
        { // else of if (pData->flags & MEM_Zero)
            ip_start(blockNotPDataIsZero);

            /// x.nZero = 0;
            store(LOC, 0, nZeroAddr);

            branch(LOC, blockAfterPDataIsZero);
        } // end else of if (pData->flags & MEM_Zero)
        ip_start(blockAfterPDataIsZero);

        /// x.pKey = 0;
        auto xPKeyAddr = getElementPtrImm(LOC, T::i8PtrPtrTy, x, 0, 0);
        store(LOC, constants(T::i8PtrTy, (char*)nullptr), xPKeyAddr);

        auto pCursorAddr = getElementPtrImm(LOC, T::BtCursorPtrTy, pC, 0, 12, 0);
        auto pCursor = load(LOC, pCursorAddr);
        auto rc = call(LOC, f_sqlite3BtreeInsert,
                pCursor,
                x,
                constants(p5 & (OPFLAG_APPEND | OPFLAG_SAVEPOSITION), 32),
                seekResult
        ).getValue();

        /// pC->deferredMoveto = 0;
        auto deferredMoveToAddr = getElementPtrImm(LOC, T::i8PtrTy, pC, 0, 3);
        store(LOC, 0, deferredMoveToAddr);

        /// pC->cacheStatus = CACHE_STALE;
        auto cacheStatusAddr = getElementPtrImm(LOC, T::i32PtrTy, pC, 0, 9);
        store(LOC, CACHE_STALE, cacheStatusAddr);

        { // if (rc) goto abort_due_to_error
            auto rcNull = iCmp(LOC, Pred::eq, rc, 0);
            myAssert(LOCL, rcNull);
        } // end if (rc) goto abort_due_to_error

        /// if (pTab)
        auto pTab = load(LOC, pTabAddr);

        curBlock = rewriter.getBlock();
        auto blockAfterPTabNotNull = SPLIT_GO_BACK_TO(curBlock);
        auto blockPTabNotNull = SPLIT_GO_BACK_TO(curBlock);

        auto condPTabNotNull = iCmp(LOC, Pred::ne, pTab, constants(T::TablePtrTy, (Table*)nullptr));

        condBranch(LOC, condPTabNotNull, blockPTabNotNull, blockAfterPTabNotNull);
        { // if (pTab)
            ip_start(blockPTabNotNull);

            print(LOCL, "TODO: Callback");
            /* TODO: db->xUpdateCallback(db->pUpdateArg,
                                (pOp->p5 & OPFLAG_ISUPDATE) ? SQLITE_UPDATE : SQLITE_INSERT,
                                zDb, pTab->zName, x.nKey); */

            branch(LOC, blockAfterPTabNotNull);
        } // end if (pTab)

        ip_start(blockAfterPTabNotNull);
        branch(LOC, endBlock);
        ip_start(endBlock);

        restoreStack(LOC, stackState);
        rewriter.eraseOp(txnOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes