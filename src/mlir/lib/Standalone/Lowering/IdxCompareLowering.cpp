#include "Standalone/ConstantManager.h"
#include "Standalone/Lowering/MyBuilder.h"
#include "Standalone/AllIncludes.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"

#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"


namespace mlir::standalone::passes {
    LogicalResult IdxCompareLowering::matchAndRewrite(IdxCompare icOp, PatternRewriter &rewriter) const {
        auto op = &icOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        myOperators

        auto firstBlock = rewriter.getBlock();

        auto pc = icOp.pcAttr().getUInt();
        auto p1 = icOp.curIdxAttr().getSInt();
        auto p2 = icOp.firstRegAttr().getSInt();
        auto p4 = icOp.nRegAttr().getUInt();
        auto p5 = icOp.flagsAttr().getUInt();

        USE_DEFAULT_BOILERPLATE
        
        auto jumpTo = icOp.jumpTo();
        auto fallThrough = icOp.fallThrough();

        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(icOp); GO_BACK_TO(curBlock);

        branch(LOC, endBlock);

        ip_start(endBlock);
        rewriter.eraseOp(icOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes