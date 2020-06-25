#include "Standalone/ConstantManager.h"
#include "Standalone/Lowering/MyBuilder.h"
#include "Standalone/AllIncludes.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"

#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"


extern LLVMFuncOp f_sqlite3BtreeUpdateMeta;
extern LLVMFuncOp f_sqlite3ExpirePreparedStatements;

namespace mlir::standalone::passes {
    LogicalResult SetCookieLowering::matchAndRewrite(SetCookie txnOp, PatternRewriter &rewriter) const {
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

        USE_DEFAULT_BOILERPLATE

        auto firstBlock = rewriter.getBlock();
        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(txnOp); GO_BACK_TO(curBlock);

        /// pDb = &db->aDb[pOp->p1];
        auto aDbAddr = getElementPtrImm(LOC, T::DbPtrTy.getPointerTo(), vdbeCtx->db, 0, 4);
        auto aDb = load(LOC, aDbAddr);
        auto pDb = getElementPtrImm(LOC, T::DbPtrTy, aDb, p1);

        auto pBtAddr = getElementPtrImm(LOC, T::BtreePtrTy.getPointerTo(), pDb, 0, 1);
        auto pBt = load(LOC, pBtAddr);

        /// rc = sqlite3BtreeUpdateMeta(pDb->pBt, pOp->p2, pOp->p3);
        auto rc = call(LOC, f_sqlite3BtreeUpdateMeta,
            pBt,
            constants(p2, 32),
            constants(p3, 32)
        ).getValue();

        auto pSchemaAddr = getElementPtrImm(LOC, T::SchemaPtrTy, pDb, 0, 4);
        auto pSchema = load(LOC, pSchemaAddr);
        if (p2 == BTREE_SCHEMA_VERSION) {
            /// pDb->pSchema->schema_cookie = pOp->p3;
            auto schemaCookieAddr = getElementPtrImm(LOC, T::i32PtrTy, pSchema, 0, 0);
            store(LOC, constants(p3, 32), schemaCookieAddr);

            /// db->mDbFlags |= DBFLAG_SchemaChange;
            auto mDbFlagsAddr = getElementPtrImm(LOC, T::i32PtrTy, vdbeCtx->db, 0, 6);
            auto mDbFlags = load(LOC, mDbFlagsAddr);
            mDbFlags = bitOr(LOC, mDbFlags, DBFLAG_SchemaChange);
            store(LOC, mDbFlags, mDbFlagsAddr);
        } else if (p2 == BTREE_FILE_FORMAT) {
            /// pDb->pSchema->file_format = pOp->p3;
            auto fileFormatAddr = getElementPtrImm(LOC, T::i8PtrTy, pSchema, 0, 7);
            store(LOC, constants(p3, 8), fileFormatAddr);
        }

        if (p1 == 1) {
            /// sqlite3ExpirePreparedStatements(db, 0);
            call(LOC, f_sqlite3ExpirePreparedStatements, vdbeCtx->db, constants(0, 32));
            auto expiredAddr = getElementPtrImm(LOC, T::i32PtrTy, vdbeCtx->p, 0, 35);

            /// p->expired = 0;
            auto val = load(LOC, expiredAddr);
            val = bitAnd(LOC, val, -4);
            val = bitOr(LOC, val, 1);
            store(LOC, val, expiredAddr);
        }

        { // if (rc) goto abort_due_to_error;
            auto rcNull = iCmp(LOC, Pred::eq, rc, 0);
            myAssert(LOCL, rcNull);
        } // end if (rc) goto abort_due_to_error;

        branch(LOC, endBlock);

        ip_start(endBlock);
        rewriter.eraseOp(txnOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes