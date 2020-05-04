#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"

namespace mlir {
    namespace standalone {
        namespace passes {
            LogicalResult
            NoopLowering::matchAndRewrite(Operation *op, ArrayRef<Value> operands,
                                          ConversionPatternRewriter &rewriter) const {
                LOWERING_PASS_HEADER

                {
                    auto operand = operands.front();
                    // Macro needs a variable named "builder" so we give it one
                    auto& builder = rewriter;
                    PROGRESS_PRINT_INT_REWRITER(operand, "Noop at");
                }

                rewriter.eraseOp(op);
                return success();
            } // matchAndRewrite
        } // namespace passes
    } // namespace standalone
} // namespace mlir