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
    LogicalResult MoveLowering::matchAndRewrite(Move mvOp, PatternRewriter &rewriter) const {
        auto op = &mvOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        myOperators

        print(LOCL, "-- Move");

        auto firstBlock = rewriter.getBlock();

        auto firstToReg = mvOp.firstToRegAttr().getSInt();
        auto firstFromReg = mvOp.firstFromRegAttr().getSInt();
        auto nReg = mvOp.nRegAttr().getSInt();

        // auto curBlock = rewriter.getBlock();
        // auto endBlock = curBlock->splitBlock(mvOp); GO_BACK_TO(curBlock);

        // branch(LOC, endBlock);

        // ip_start(endBlock);

        print(LOCL, "TODO: Implement Move Lowering");

        rewriter.eraseOp(mvOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes