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
    LogicalResult MakeRecordLowering::matchAndRewrite(MakeRecord mrOp, PatternRewriter &rewriter) const {
        auto op = &mrOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        myOperators

        auto firstBlock = rewriter.getBlock();

        auto firstFromReg = mrOp.firstRegFromAttr().getSInt();
        auto nReg = mrOp.nRegAttr().getSInt();
        auto dest = mrOp.destAttr().getSInt();
        auto affinities = mrOp.affinitiesAttr().getUInt();

        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(mrOp); GO_BACK_TO(curBlock);

        branch(LOC, endBlock);

        ip_start(endBlock);
        rewriter.eraseOp(mrOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes