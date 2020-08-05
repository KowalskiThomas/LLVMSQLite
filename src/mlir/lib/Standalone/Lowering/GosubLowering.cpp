#include "Standalone/ConstantManager.h"
#include "Standalone/Lowering/MyBuilder.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"

#include "Standalone/StandalonePasses.h"


namespace mlir::standalone::passes {
    LogicalResult GosubLowering::matchAndRewrite(Gosub gsOp, PatternRewriter &rewriter) const {
        auto op = &gsOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        myOperators

        print(LOCL, "-- GoSub");

        auto firstBlock = rewriter.getBlock();

        auto writeAddressTo = gsOp.writeAddressToAttr().getSInt();
        auto pc = gsOp.pcAttr().getUInt();
        auto jumpToBlock = gsOp.jumpTo();

        USE_DEFAULT_BOILERPLATE

        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(gsOp); GO_BACK_TO(curBlock);

        /// pIn1 = &aMem[pOp->p1];
        auto pIn1 = getElementPtrImm(LOC, T::sqlite3_valuePtrTy, vdbeCtx->aMem, writeAddressTo);

        /// pIn1->flags = MEM_Int;
        auto flagsAddr = getElementPtrImm(LOC, T::i16PtrTy, pIn1, 0, 1);
        store(LOC, MEM_Int, flagsAddr);

        /// pIn1->u.i = (int) (pOp - aOp);
        auto unionValueAddress = getElementPtrImm(LOC, T::doublePtrTy, pIn1, 0, 0, 0);
        auto intValueAddress = bitCast(LOC, unionValueAddress, T::i64PtrTy);
        auto diff = constants(pc, 64);
        store(LOC, diff, intValueAddress);

        branch(LOC, endBlock);

        ip_start(endBlock);

        branch(LOC, jumpToBlock);
        rewriter.eraseOp(gsOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes