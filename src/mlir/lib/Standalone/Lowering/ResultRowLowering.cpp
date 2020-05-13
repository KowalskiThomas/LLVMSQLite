#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"

namespace mlir::standalone::passes {
    LogicalResult ResultRowLowering::matchAndRewrite(ResultRow rrOp, PatternRewriter &rewriter) const {
        auto op = &rrOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE



        rewriter.eraseOp(rrOp);
        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes