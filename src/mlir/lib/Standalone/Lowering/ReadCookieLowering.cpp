#include "Standalone/ConstantManager.h"
#include "Standalone/Lowering/MyBuilder.h"
#include "Standalone/AllIncludes.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/OutToPrerelease.h"
#include "Standalone/Lowering/Printer.h"

#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"


extern LLVMFuncOp f_sqlite3BtreeGetMeta;

namespace mlir::standalone::passes {
    LogicalResult ReadCookieLowering::matchAndRewrite(ReadCookie txnOp, PatternRewriter &rewriter) const {
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

        auto iDb = p1;
        auto iCookie = constants(p3, 32);

        auto stackState = saveStack(LOC);
        auto iMetaAddr = alloca(LOC, T::i32PtrTy);

        /// sqlite3BtreeGetMeta(db->aDb[iDb].pBt, iCookie, (u32 *) &iMeta);
        auto aDbAddr = getElementPtrImm(LOC, T::DbPtrTy.getPointerTo(), vdbeCtx->db, 0, 4);
        auto aDb = load(LOC, aDbAddr);
        auto pBtAddr = getElementPtrImm(LOC, T::BtreePtrTy.getPointerTo(), aDb, iDb, 1);
        auto pBtValue = load(LOC, pBtAddr);
        call(LOC, f_sqlite3BtreeGetMeta, pBtValue, iCookie, iMetaAddr);

        /// pOut = out2Prerelease(p, pOp);
        auto outToPrelease = Inlining::OutToPrerelease(*vdbeCtx, context, rewriter, print, constants);
        auto pOp = getElementPtrImm(LOC, T::VdbeOpPtrTy, vdbeCtx->aOp, (int)pc);
        auto pOut = outToPrelease(LOC, vdbeCtx->p, pOp);

        /// pOut->u.i = iMeta;
        auto pOutUAddress = getElementPtrImm(LOC, T::doublePtrTy, pOut, 0, 0, 0);
        auto pOutIAddress = bitCast(LOC, pOutUAddress, T::i64PtrTy);
        auto iMeta = load(LOC, iMetaAddr);
        iMeta = zExt(LOC, iMeta, T::i64Ty);
        store(LOC, iMeta, pOutIAddress);

        branch(LOC, endBlock);
        ip_start(endBlock);

        restoreStack(LOC, stackState);

        rewriter.eraseOp(txnOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes