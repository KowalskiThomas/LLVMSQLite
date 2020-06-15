#include "Standalone/ConstantManager.h"
#include "Standalone/Lowering/MyBuilder.h"
#include "Standalone/AllIncludes.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"

#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"


namespace mlir::standalone::passes {
    LogicalResult IfNotZeroLowering::matchAndRewrite(IfNotZero inzOp, PatternRewriter &rewriter) const {
        auto op = &inzOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        myOperators

        auto firstBlock = rewriter.getBlock();

        auto pc = inzOp.pcAttr().getUInt();
        auto p1 = inzOp.regAttr().getSInt();

        auto jumpTo = inzOp.jumpTo();
        auto fallThrough = inzOp.fallThrough();

        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(inzOp); GO_BACK_TO(curBlock);

        branch(LOC, endBlock);

        ip_start(endBlock);
        rewriter.eraseOp(inzOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes