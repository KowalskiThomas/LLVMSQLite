#include "Standalone/ConstantManager.h"
#include "Standalone/Lowering/MyBuilder.h"
#include "Standalone/AllIncludes.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"

#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"


namespace mlir::standalone::passes {
    LogicalResult IdxInsertLowering::matchAndRewrite(IdxInsert iiOp, PatternRewriter &rewriter) const {
        auto op = &iiOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        myOperators

        auto firstBlock = rewriter.getBlock();

        auto pc = iiOp.pcAttr().getUInt();
        auto p1 = iiOp.curIdxAttr().getSInt();
        auto p2 = iiOp.regAttr().getSInt();
        auto p3 = iiOp.p3Attr().getSInt();
        auto p4 = iiOp.p4Attr().getSInt();
        auto p5 = iiOp.flagsAttr().getSInt();

        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(iiOp); GO_BACK_TO(curBlock);

        branch(LOC, endBlock);

        ip_start(endBlock);
        rewriter.eraseOp(iiOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes