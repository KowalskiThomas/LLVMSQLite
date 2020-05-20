#include "Standalone/AllIncludes.h"

#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"

namespace mlir {
    namespace standalone {
        namespace passes {
            LogicalResult
            GotoLowering::matchAndRewrite(Goto gotoOp, PatternRewriter &rewriter) const {
                auto op = &gotoOp;
                LOWERING_PASS_HEADER

                rewriter.create<mlir::BranchOp>(LOC, gotoOp.dest());

                rewriter.eraseOp(gotoOp);
                return success();
            } // matchAndRewrite
        } // namespace passes
    } // namespace standalone
} // namespace mlir