#include "Standalone/ConstantManager.h"
#include "Standalone/Lowering/MyBuilder.h"
#include "Standalone/AllIncludes.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"

#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"


namespace mlir::standalone::passes {
    LogicalResult TransactionLowering::matchAndRewrite(Transaction txnOp, PatternRewriter &rewriter) const {
        auto op = &txnOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        myOperators

        print(LOCL, "-- Transaction");
        auto stackState = rewriter.create<StackSaveOp>(LOC, T::i8PtrTy);

        auto firstBlock = rewriter.getBlock();

        auto dbIdxAttr = txnOp.dbIdxAttr();
        auto isWriteAttr = txnOp.isWriteAttr();
        auto p3Attr = txnOp.P3Attr();
        auto p4Attr = txnOp.P4Attr();
        auto p5Attr = txnOp.P5Attr();

        auto dbIdx = dbIdxAttr.getSInt();
        auto isWriteValue = isWriteAttr.getSInt();
        auto p3Value = p3Attr.getSInt();
        auto p4Value = p4Attr.getSInt();
        auto p5Value = p5Attr.getSInt();

        // if (pOp->p2 && (db->flags & SQLITE_QueryOnly) != 0)
        auto isQueryOnly = (vdbe->db->flags & SQLITE_QueryOnly) != 0;
        auto condition = constants((isWriteValue != 0 && isQueryOnly) ? 1 : 0, 1);
        auto rc = SQLITE_READONLY;
        // TODO: goto abort_due_to_error

        auto db = vdbeCtx->db;
        auto aDbAddr = rewriter.create<GEPOp>(LOC, T::DbPtrTy.getPointerTo(), db, ValueRange {
                constants(0, 32),
                constants(4, 32)
        });
        auto aDb = rewriter.create<LoadOp>(LOC, aDbAddr);
        auto pBtAddr = getElementPtrImm(LOC, T::BtreePtrTy.getPointerTo(), aDb, dbIdx, 1);
        auto pBtValue = load(LOC, pBtAddr);
        auto pBtValueInt = ptrToInt(LOC, pBtValue);

        auto metaAddr = alloca(LOC, T::i32PtrTy);
        auto rcAddr = alloca(LOC, T::i32PtrTy);

        auto pBtNotNull = iCmp(LOC, Pred::ne, pBtValueInt, 0);
        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(txnOp); GO_BACK_TO(curBlock);
        auto blockAfterBtNotNull = SPLIT_BLOCK; GO_BACK_TO(curBlock);
        auto blockBtNotNull = SPLIT_BLOCK; GO_BACK_TO(curBlock);
        condBranch(LOC, pBtNotNull, blockBtNotNull, blockAfterBtNotNull);
        { // if (pBt)
            ip_start(blockBtNotNull);

            auto rcTemp = call(LOC, f_sqlite3BtreeBeginTrans,
                    pBtValue, constants(isWriteValue, 32), metaAddr).getValue();
            store(LOC, rcTemp, rcAddr);

            { // if rc != SQLITE_OK goto abort_due_to_error
                auto rcTempIsSqliteOk = iCmp(LOC, Pred::eq, rcTemp, SQLITE_OK);
                myAssert(LOCL, rcTempIsSqliteOk);
            } // end if rc != SQLITE_OK goto abort_due_to_error

            /// iStatement is 13-th element
            auto iStatementAddr = getElementPtrImm(LOC, T::i32PtrTy, vdbeCtx->p, 0, 13);

            if (vdbe->usesStmtJournal && isWriteValue && (vdbe->db->autoCommit == 0 || vdbe->db->nVdbeRead > 1)) {
                if (vdbe->iStatement == 0) {
                    /// db->nStatement++;
                    constexpr auto nStatementOffset = 79;
                    auto nStatementAddr = getElementPtrImm(LOC, T::i32PtrTy, vdbeCtx->db, 0, nStatementOffset);
                    auto nStatementValue = load(LOC, nStatementAddr);
                    auto nStatementPlus1 = add(LOC, nStatementValue, 1);
                    store(LOC, nStatementPlus1, nStatementAddr);

                    /// p->iStatement = db->nSavepoint + db->nStatement;
                    constexpr auto nSavepointOffset = 78;
                    auto nSavepointAddr = getElementPtrImm(LOC, T::i32PtrTy, vdbeCtx->db, nSavepointOffset);
                    auto nSavepointValue = load(LOC, nSavepointAddr);
                    auto sum = add(LOC, nSavepointValue, nStatementValue);
                    store(LOC, sum, iStatementAddr);
                } // end if (vdbe->iStatement == 0) {

#ifndef SQLITE_OMIT_VIRTUALTABLE
                /// rc = sqlite3VtabSavepoint(db, SAVEPOINT_BEGIN, p->iStatement - 1);
                auto iStatementValue = load(LOC, iStatementAddr);
                auto iStatementValueMinus1 = add(LOC, iStatementValue, -1);
                auto tempRc = call(LOC, f_sqlite3VtabSavepoint,
                        constants(SAVEPOINT_BEGIN, 32), iStatementValueMinus1).getValue();
                store(LOC, tempRc, rcAddr);

                /// if (rc == SQLITE_OK)
                auto rcIsOk = iCmp(LOC, Pred::eq, tempRc, SQLITE_OK);
                auto curBlock = rewriter.getBlock();
                auto blockAfterRcIsOk = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                auto blockRcIsOk = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                condBranch(LOC, rcIsOk, blockRcIsOk, blockAfterRcIsOk);
                { // if (rc == SQLITE_OK)
                    ip_start(blockRcIsOk);

                    auto rcTemp = call(LOC, f_sqlite3BtreeBeginStmt, pBtValue, iStatementValue).getValue();
                    store(LOC, rcTemp, rcAddr);

                    branch(LOC, blockAfterRcIsOk);
                } // end if (rc == SQLITE_OK)

                ip_start(blockAfterRcIsOk);
#endif

                /// Reload rc (phi-like)
                rcTemp = load(LOC, rcAddr);

                /// p->nStmtDefCons = db->nDeferredCons;
                constexpr auto nStmtDefConsOffset = 15;
                constexpr auto nDeferredConsOffset = 80;
                constexpr auto nStmtDefImmConsOffset = 81;
                constexpr auto nDeferredImmOffset = 81;
                auto nStmtDefConsAddr = getElementPtrImm(LOC, T::i64PtrTy, vdbeCtx->p, nStmtDefConsOffset);
                auto nDeferredCons = getElementPtrImm(LOC, T::i64PtrTy, vdbeCtx->db, nDeferredConsOffset);
                auto nDeferredConsVal = load(LOC, nDeferredCons);
                store(LOC, nDeferredConsVal, nStmtDefConsAddr);
                /// p->nStmtDefImmCons = db->nDeferredImmCons;
                auto nStmtDefImmConsAddr = getElementPtrImm(LOC, T::i64PtrTy, vdbeCtx->p, nStmtDefImmConsOffset);
                auto nDeferredImmConsAddr = getElementPtrImm(LOC, T::i64PtrTy, vdbeCtx->db, nDeferredImmOffset);
                auto nDeferredImmConsVal = load(LOC, nDeferredImmConsAddr);
                store(LOC, nDeferredConsVal, nStmtDefImmConsAddr);
            } // end if (vdbe->usesStmtJournal && isWriteValue && (vdbe->db->autoCommit == 0 || vdbe->db->nVdbeRead > 1))

            branch(LOC, blockAfterBtNotNull);
        } // end if (pBt)

        ip_start(blockAfterBtNotNull);

        /// if (pOp->p5
        ///     && (iMeta != pOp->p3
        ///         || db->aDb[pOp->p1].pSchema->iGeneration != pOp->p4.i)
        auto p5NotNull = constants(p5Value == 0 ? 0 : 1, 1);
        auto iMetaValue = load(LOC, metaAddr);
        auto metaNeP3 = iCmp(LOC, Pred::ne, iMetaValue, p3Value);
        auto p4AsInt = (int)p4Value;

        auto pSchemaAddr = getElementPtrImm(LOC, T::SchemaPtrTy.getPointerTo(), aDb, dbIdx, 4);
        auto pSchema = load(LOC, pSchemaAddr);
        auto generationAddr = getElementPtrImm(LOC, T::i32PtrTy, pSchema, 0, 1);
        auto generationVal = load(LOC, generationAddr);

        auto generationNeP4 = iCmp(LOC, Pred::ne, generationVal, p4AsInt);
        auto generationNeP4_Or_metaNep3 = bitOr(LOC, generationNeP4, metaNeP3);
        auto p5NotNull__And__generationNeP4_Or_metaNep3 = bitAnd(LOC, p5NotNull, generationNeP4_Or_metaNep3);

        curBlock = rewriter.getBlock();
        auto blockAfterCondition = SPLIT_BLOCK; GO_BACK_TO(curBlock);
        auto blockCondition = SPLIT_BLOCK; GO_BACK_TO(curBlock);
        condBranch(LOC, p5NotNull__And__generationNeP4_Or_metaNep3, blockCondition, blockAfterCondition);
        { /// if (...)
            ip_start(blockCondition);

            print(LOCL, "TODO: sqlite3DbFree(db, p->zErrMsg);");
            print(LOCL, "TODO: p->zErrMsg = sqlite3DbStrDup(db, \"database schema has changed\");");

            branch(LOC, blockAfterCondition);
        } /// end if (...)

        ip_start(blockAfterCondition);

        { /// if (rc) goto abort_due_to_error;
            auto rcValue = load(LOC, rcAddr);
            auto rcIsNull = iCmp(LOC, Pred::eq, rcValue, 0);
            myAssert(LOCL, rcIsNull);
        }

        branch(LOC, endBlock);

        ip_start(endBlock);
        rewriter.create<StackRestoreOp>(LOC, stackState);
        rewriter.eraseOp(txnOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes