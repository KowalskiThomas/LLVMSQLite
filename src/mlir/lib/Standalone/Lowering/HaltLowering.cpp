#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"

namespace mlir {
    namespace standalone {
        namespace passes {
            LogicalResult HaltLowering::matchAndRewrite(Halt haltOp, PatternRewriter& rewriter) const {
                auto op = &haltOp;
                LOWERING_PASS_HEADER

                PROGRESS("Halting execution");
                {
                    auto& builder = rewriter;
                    rewriter.create<mlir::ReturnOp>(LOC, (mlir::Value)CONSTANT_INT(3, 32));
                }

                rewriter.eraseOp(haltOp);
                return success();
            } // matchAndRewrite
        } // namespace passes
    } // namespace standalone
} // namespace mlir