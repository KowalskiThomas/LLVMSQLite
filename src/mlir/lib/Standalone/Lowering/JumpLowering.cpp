#include "Standalone/ConstantManager.h"
#include "Standalone/Lowering/MyBuilder.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"

#include "Standalone/StandalonePasses.h"


namespace mlir::standalone::passes {
    LogicalResult JumpLowering::matchAndRewrite(Jump jmpOp, PatternRewriter &rewriter) const {
        auto op = &jmpOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        myOperators

        auto firstBlock = rewriter.getBlock();

        auto ifEq = jmpOp.ifEqual();
        auto ifLess = jmpOp.ifLess();
        auto ifGreater = jmpOp.ifGreater();

        auto pc = jmpOp.pcAttr().getUInt();

        print(LOCL, "-- Jump");
        USE_DEFAULT_BOILERPLATE

        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(jmpOp); GO_BACK_TO(curBlock);

        auto iCompareAddr = vdbeCtx->iCompare;
        auto iCompare = load(LOC, iCompareAddr);

        auto iCompareNegative = iCmp(LOC, Pred::slt, iCompare, 0);
        condBranch(LOC, iCompareNegative, ifLess, endBlock);

        ip_start(endBlock);
        auto iComparePositive = iCmp(LOC, Pred::sgt, iCompare, 0);
        condBranch(LOC, iComparePositive, ifGreater, ifEq);

        rewriter.eraseOp(jmpOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes