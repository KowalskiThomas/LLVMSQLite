#include "Standalone/ConstantManager.h"
#include "Standalone/Lowering/MyBuilder.h"
#include "Standalone/AllIncludes.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"

#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"


namespace mlir::standalone::passes {
    LogicalResult OpenEphemeralLowering::matchAndRewrite(OpenEphemeral oeOp, PatternRewriter &rewriter) const {
        auto op = &oeOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        myOperators

        auto firstBlock = rewriter.getBlock();

        auto pc = oeOp.pcAttr().getUInt();
        auto p1 = oeOp.curIdxAttr().getSInt();
        auto p2 = oeOp.nColumnAttr().getSInt();
        auto p4 = (Btree*) oeOp.btIndexAttr().getUInt();
        auto p5 = oeOp.flagsAttr().getSInt();

        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(oeOp); GO_BACK_TO(curBlock);

        branch(LOC, endBlock);

        ip_start(endBlock);
        rewriter.eraseOp(oeOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes