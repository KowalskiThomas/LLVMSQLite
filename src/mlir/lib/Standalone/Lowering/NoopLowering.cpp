#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"

namespace mlir {
    namespace standalone {
        namespace passes {
            LogicalResult
            NoopLowering::matchAndRewrite(Noop noopOp, PatternRewriter& rewriter) const {
                auto op = &noopOp;
                LOWERING_PASS_HEADER

                {
                    auto operand = noopOp.pc();
                    // Macro needs a variable named "builder" so we give it one
                    auto& builder = rewriter;
                    PROGRESS_PRINT_INT_REWRITER(operand, "Noop at");
                }

                rewriter.eraseOp(noopOp);
                return success();
            } // matchAndRewrite
        } // namespace passes
    } // namespace standalone
} // namespace mlir