#include <llvm/Support/DynamicLibrary.h>

#include <src/mlir/include/Standalone/ConstantManager.h>
#include <src/mlir/include/Standalone/Lowering/MyBuilder.h>
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"

#include "Standalone/StandalonePasses.h"


namespace mlir::standalone::passes {
    LogicalResult StringLowering::matchAndRewrite(String strOp, PatternRewriter &rewriter) const {
        auto op = &strOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        myOperators

        auto firstBlock = rewriter.getBlock();

        // regTo = p2
        auto regTo = strOp.regToAttr().getSInt();
        // string = p4
        auto string = strOp.stringAttr().getUInt();
        // hints = p3
        auto hints = strOp.hintsAttr().getSInt();
        // flags = p5
        auto flags = strOp.flagsAttr().getUInt();
        // len = p1
        auto len = strOp.lenAttr().getSInt();

        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(strOp); GO_BACK_TO(curBlock);

        branch(LOC, endBlock);

        ip_start(endBlock);

        print(LOCL, "TODO: Implement String");

        rewriter.eraseOp(strOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes