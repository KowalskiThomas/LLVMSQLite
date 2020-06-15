#include "Standalone/ConstantManager.h"
#include "Standalone/Lowering/MyBuilder.h"
#include "Standalone/AllIncludes.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"

#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"


namespace mlir::standalone::passes {
    LogicalResult DeferredSeekLowering::matchAndRewrite(DeferredSeek dsOp, PatternRewriter &rewriter) const {
        auto op = &dsOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        myOperators

        auto firstBlock = rewriter.getBlock();

        auto pc = dsOp.pcAttr().getUInt();
        auto curTarget = dsOp.curTargetAttr().getSInt();
        auto curToMove = dsOp.curToMoveAttr().getSInt();
        auto array = (const int*)dsOp.arrayAttr().getUInt();

        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(dsOp); GO_BACK_TO(curBlock);

        branch(LOC, endBlock);

        ip_start(endBlock);
        rewriter.eraseOp(dsOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes