#include "Standalone/ConstantManager.h"
#include "Standalone/Lowering/MyBuilder.h"
#include "Standalone/Lowering/OutToPrerelease.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"

#include "Standalone/StandalonePasses.h"


namespace mlir::standalone::passes {
    LogicalResult RealLowering::matchAndRewrite(Real realOp, PatternRewriter &rewriter) const {
        auto op = &realOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        myOperators

        auto firstBlock = rewriter.getBlock();

        // pc = Programme Counter
        auto pc = realOp.pcAttr().getUInt();

        // regTo = p2
        auto regTo = realOp.regToAttr().getSInt();
        // pointerToValueAttr = p4
        auto pointerToValue = (double*)realOp.pointerToValueAttr().getUInt();

        print(LOCL, "-- Real");
        USE_DEFAULT_BOILERPLATE

        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(realOp); GO_BACK_TO(curBlock);

        // Get the real value pointed by P4
        auto valueAddr = constants(T::doublePtrTy, pointerToValue);
        auto value = load(LOC, valueAddr);

        auto outToPrerelease = Inlining::OutToPrerelease(*vdbeCtx, context, rewriter, print, constants);
        auto pOp = getElementPtrImm(LOC, T::VdbeOpPtrTy, vdbeCtx->aOp, (int)pc);
        auto pOut = outToPrerelease(LOC, vdbeCtx->p, pOp);

        // Get &pOut->flags
        auto flagsAddr = getElementPtrImm(LOC, T::i16PtrTy, pOut, 0, 1);
        store(LOC, MEM_Real, flagsAddr);

        // Get &pOut->u.r
        auto rAddr = getElementPtrImm(LOC, T::doublePtrTy, pOut, 0, 0, 0);
        store(LOC, value, rAddr);

        branch(LOC, endBlock);

        ip_start(endBlock);

        rewriter.eraseOp(realOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes