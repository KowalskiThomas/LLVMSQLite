#include "Standalone/ConstantManager.h"
#include "Standalone/Lowering/MyBuilder.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"
#include "Standalone/ErrorCodes.h"
#include "Standalone/StandalonePasses.h"

namespace mlir::standalone::passes {
    LogicalResult String8Lowering::matchAndRewrite(String8 strOp, PatternRewriter &rewriter) const {
        auto op = &strOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        myOperators

        err("String8 should not be used!");
        exit(ILLEGAL_LOWERING_USED);

        auto firstBlock = rewriter.getBlock();

        // pc = Programme Counter
        auto pc = strOp.pcAttr().getUInt();
        // regTo = p2
        auto regTo = strOp.regToAttr().getSInt();
        // string = p4
        auto string = (const char*)strOp.stringAttr().getUInt();

        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(strOp); GO_BACK_TO(curBlock);

        branch(LOC, endBlock);

        ip_start(endBlock);

        myAssert(LOCL, constants(0, 1));

        rewriter.eraseOp(strOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes