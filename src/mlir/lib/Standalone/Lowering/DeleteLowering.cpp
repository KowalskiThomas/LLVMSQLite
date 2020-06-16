#include "Standalone/ConstantManager.h"
#include "Standalone/Lowering/MyBuilder.h"
#include "Standalone/AllIncludes.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"

#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"


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
        auto p2 = delOp.p2Attr().getSInt();
        auto p3 = delOp.p3Attr().getSInt();
        auto p4 = delOp.p4Attr().getUInt();
        auto p5 = delOp.p5Attr().getUInt();

        USE_DEFAULT_BOILERPLATE
        
        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(delOp); GO_BACK_TO(curBlock);

        branch(LOC, endBlock);

        ip_start(endBlock);
        rewriter.eraseOp(delOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes