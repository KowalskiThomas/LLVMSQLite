#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"

namespace mlir {
    namespace standalone {
        namespace passes {
            LogicalResult
            JumpLowering::matchAndRewrite(Jump jumpOp, PatternRewriter &rewriter) const {
                auto op = &jumpOp;
                LOWERING_PASS_HEADER

                rewriter.create<mlir::BranchOp>(LOC, jumpOp.dest());

                rewriter.eraseOp(jumpOp);
                return success();
            } // matchAndRewrite
        } // namespace passes
    } // namespace standalone
} // namespace mlir