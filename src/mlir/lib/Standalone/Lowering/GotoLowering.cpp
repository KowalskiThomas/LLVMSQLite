#include "Standalone/AllIncludes.h"

#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"

namespace mlir {
    namespace standalone {
        namespace passes {
            LogicalResult
            GotoLowering::matchAndRewrite(Goto jumpOp, PatternRewriter &rewriter) const {
                auto op = &jumpOp;
                LOWERING_PASS_HEADER

                rewriter.create<mlir::BranchOp>(LOC, jumpOp.dest());

                rewriter.getBlock()->splitBlock(jumpOp);
                rewriter.eraseOp(jumpOp);
                return success();
            } // matchAndRewrite
        } // namespace passes
    } // namespace standalone
} // namespace mlir