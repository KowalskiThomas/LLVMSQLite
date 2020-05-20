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
    LogicalResult OpenPseudoLowering::matchAndRewrite(OpenPseudo opOp, PatternRewriter &rewriter) const {
        auto op = &opOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        myOperators

        auto firstBlock = rewriter.getBlock();

        auto curIdx = opOp.curIdxAttr().getSInt();
        auto reg = opOp.regAttr().getSInt();
        auto nFields = opOp.nFieldsAttr().getSInt();

        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(opOp); GO_BACK_TO(curBlock);

        branch(LOC, endBlock);

        ip_start(endBlock);
        rewriter.eraseOp(opOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes