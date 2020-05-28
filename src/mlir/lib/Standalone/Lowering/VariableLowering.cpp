#include <llvm/Support/DynamicLibrary.h>

#include <src/mlir/include/Standalone/ConstantManager.h>
#include <src/mlir/include/Standalone/Lowering/MyBuilder.h>
#include "Standalone/AllIncludes.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"

#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"


namespace mlir::standalone::passes {
    LogicalResult VariableLowering::matchAndRewrite(Variable varOp, PatternRewriter &rewriter) const {
        auto op = &varOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        myOperators

        auto firstBlock = rewriter.getBlock();

        // regTo = p2
        auto regTo = varOp.regToAttr().getSInt();
        // parameter name = p4
        auto parameterName = varOp.parameterNameAttr().getUInt();
        // p1 = parameter identifier
        auto p1 = varOp.p1Attr().getSInt();

        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(varOp); GO_BACK_TO(curBlock);

        branch(LOC, endBlock);

        ip_start(endBlock);

        print(LOCL, "TODO: Implement Variable");

        rewriter.eraseOp(varOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes