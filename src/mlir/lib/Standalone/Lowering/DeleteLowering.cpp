#include "Standalone/ConstantManager.h"
#include "Standalone/Lowering/MyBuilder.h"
#include "Standalone/AllIncludes.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"

#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"

extern LLVMFuncOp f_sqlite3BtreeIntegerKey;
extern LLVMFuncOp f_sqlite3BtreeDelete;

namespace mlir::standalone::passes {
    LogicalResult DeleteLowering::matchAndRewrite(Delete delOp, PatternRewriter &rewriter) const {
        auto op = &delOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        myOperators

        auto firstBlock = rewriter.getBlock();

        auto pc = delOp.pcAttr().getUInt();
        auto p1 = delOp.curIdxAttr().getSInt();
        auto opflags = delOp.p2Attr().getSInt();
        auto p3 = delOp.p3Attr().getSInt();
        auto p4 = delOp.p4Attr().getUInt();
        auto p5 = delOp.p5Attr().getUInt();

        USE_DEFAULT_BOILERPLATE
        
        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(delOp); GO_BACK_TO(curBlock);

        auto stackState = saveStack(LOC);
        auto zDbAddr = alloca(LOC, T::i8PtrPtrTy);
        auto pTabAddr = alloca(LOC, T::TablePtrPtrTy);

        auto pCAddr = getElementPtrImm(LOC, T::VdbeCursorPtrTy, vdbeCtx->apCsr, p1);
        auto pC = load(LOC, pCAddr);

        auto pCursorAddr = getElementPtrImm(LOC, T::BtCursorPtrTy, pC, 0, 12, 0);
        auto pCursor = load(LOC, pCursorAddr);

        // DEBUG FEATURE call(LOC, f_sqlite3VdbeIncrWriteCounter, vdbeCtx->p, pC);
        auto pOp = getElementPtrImm(LOC, T::VdbeOpPtrTy, vdbeCtx->aOp, (int)pc);
        
        auto p4typeAddr = getElementPtrImm(LOC, T::i8PtrTy, pOp, 0, 1);
        auto p4type = load(LOC, p4typeAddr);
        auto p4typeIsTable = iCmp(LOC, Pred::eq, p4type, P4_TABLE);

        auto updateCallbackAddr = getElementPtrImm(LOC, T::i8PtrPtrTy, vdbeCtx->db, 0, 52);
        auto updateCallback = load(LOC, updateCallbackAddr);
        updateCallback = ptrToInt(LOC, updateCallback);
        auto hasUpdateHook = iCmp(LOC, Pred::ne, updateCallback, 0);

        curBlock = rewriter.getBlock();
        auto blockAfterTableHasUpdateHook = SPLIT_BLOCK; GO_BACK_TO(curBlock);
        auto blockNotTableHasUpdateHook = SPLIT_BLOCK; GO_BACK_TO(curBlock);
        auto blockTableHasUpdateHook = SPLIT_BLOCK; GO_BACK_TO(curBlock);

        auto condTableHasUpdateHook = bitAnd(LOC, p4typeIsTable, hasUpdateHook);

        condBranch(LOC, condTableHasUpdateHook, blockTableHasUpdateHook, blockNotTableHasUpdateHook);
        { // if (pOp->p4type == P4_TABLE && HAS_UPDATE_HOOK(db))
            ip_start(blockTableHasUpdateHook);

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
            auto p4Addr = getElementPtrImm(LOC, T::p4unionPtrTy, pOp, 0, 6);
            auto p4ValueAddr = getElementPtrImm(LOC, T::i8PtrPtrTy, p4Addr, 0, 0);
            p4ValueAddr = bitCast(LOC, p4ValueAddr, T::TablePtrPtrTy);
            auto pTabValue = load(LOC, p4ValueAddr);
            store(LOC, pTabValue, pTabAddr);

            if ((vdbe->aOp[pc].p5 & OPFLAG_SAVEPOSITION) != 0) {
                auto isTableAddr = getElementPtrImm(LOC, T::i8PtrTy, pC, 0, 4);

                auto curBlock = rewriter.getBlock();
                auto blockAfterIsTableCursor = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                auto blockIsTableCursor = SPLIT_BLOCK; GO_BACK_TO(curBlock);

                auto isTable = load(LOC, isTableAddr);
                auto condIsTableCursor = iCmp(LOC, Pred::ne, isTable, 0);
                
                condBranch(LOC, condIsTableCursor, blockIsTableCursor, blockAfterIsTableCursor);
                { // if (pC->isTable)
                    ip_start(blockIsTableCursor);

                    /// pC->movetoTarget = sqlite3BtreeIntegerKey(pC->uc.pCursor);
                    auto moveToTargetAddr = getElementPtrImm(LOC, T::i64PtrTy, pC, 0, 18);

                    auto callResult = call(LOC, f_sqlite3BtreeIntegerKey, pCursor).getValue();

                    store(LOC, callResult, moveToTargetAddr);
                
                    branch(LOC, blockAfterIsTableCursor);
                 } // end if (pC->isTable)
                
                ip_start(blockAfterIsTableCursor);
            }

            branch(LOC, blockAfterTableHasUpdateHook);
        } // end if (pOp->p4type == P4_TABLE && HAS_UPDATE_HOOK(db))
        { // else of if (pOp->p4type == P4_TABLE && HAS_UPDATE_HOOK(db))
            ip_start(blockNotTableHasUpdateHook);

            store(LOC, (void*)nullptr, pTabAddr);
            store(LOC, (void*)nullptr, zDbAddr);

            branch(LOC, blockAfterTableHasUpdateHook);
        } // end else of if (pOp->p4type == P4_TABLE && HAS_UPDATE_HOOK(db))

        ip_start(blockAfterTableHasUpdateHook);

        // Line 5152
        /// rc = sqlite3BtreeDelete(pC->uc.pCursor, pOp->p5);
        auto rc = call(LOC, f_sqlite3BtreeDelete, pCursor, constants(p5, 8)).getValue();

        { // if (rc) goto abort_due_to_error;
            auto rcNull = iCmp(LOC, Pred::eq, rc, 0);
            myAssert(LOCL, rcNull);
        } // end if (rc) goto abort_due_to_error;

        /// pC->cacheStatus = CACHE_STALE;
        auto cacheStatusAddr = getElementPtrImm(LOC, T::i32PtrTy, pC, 0, 9);
        store(LOC, CACHE_STALE, cacheStatusAddr);

        /// pC->seekResult = 0;
        auto seekResultAddr = getElementPtrImm(LOC, T::i32PtrTy, pC, 0, 10);
        store(LOC, constants(0, 32), seekResultAddr);

        if (opflags & OPFLAG_NCHANGE) {
            print(LOCL, "TODO: CALLBACK");
            // TODO: auto nChangeAddr = getElementPtrImm(LOC, T::i32PtrTy, vdbeCtx->p, 0, )
        }

        branch(LOC, endBlock);

        ip_start(endBlock);

        restoreStack(LOC, stackState);
        rewriter.eraseOp(delOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes