#include "Standalone/ConstantManager.h"
#include "Standalone/Lowering/MyBuilder.h"
#include "Standalone/AllIncludes.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"

#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"


namespace mlir::standalone::passes {
    LogicalResult YieldLowering::matchAndRewrite(Yield txnOp, PatternRewriter &rewriter) const {
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

        USE_DEFAULT_BOILERPLATE

        auto firstBlock = rewriter.getBlock();
        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(txnOp); GO_BACK_TO(curBlock);

        /// pIn1 = &aMem[pOp->p1];
        auto pIn1 = getElementPtrImm(LOC, T::sqlite3_valuePtrTy, vdbeCtx->aMem, p1);

        /// pIn1->flags = MEM_Int;
        auto flagsAddr = getElementPtrImm(LOC, T::i16PtrTy, pIn1, 0, 1);
        store(LOC, MEM_Int, flagsAddr);

        /// pcDest = (int) pIn1->u.i;
        auto inUAddr = getElementPtrImm(LOC, T::doublePtrTy, pIn1, 0, 0);
        auto inIntegerAddr = bitCast(LOC, inUAddr, T::i64PtrTy);
        auto pcDest = load(LOC, inIntegerAddr);
        pcDest = add(LOC, pcDest, 1);

        /// pIn1->u.i = (int) (pOp - aOp);
        store(LOC, pc, inIntegerAddr);

        /// pOp = &aOp[pcDest];
        auto pcAddr = getElementPtrImm(LOC, T::i32PtrTy, vdbeCtx->p, 0, 10);
        pcDest = trunc(LOC, pcDest, T::i32Ty);
        store(LOC, pcDest, pcAddr);

        branch(LOC, endBlock);
        ip_start(endBlock);

        branch(LOC, vdbeCtx->jumpsBlock);
        rewriter.eraseOp(txnOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes