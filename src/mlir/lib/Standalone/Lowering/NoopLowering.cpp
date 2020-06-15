#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"
#include "Standalone/ConstantManager.h"
#include "Standalone/Lowering/MyBuilder.h"
#include "Standalone/AllIncludes.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"


namespace mlir::standalone::passes {
    LogicalResult NoopLowering::matchAndRewrite(Noop noopOp, PatternRewriter& rewriter) const {
        auto op = &noopOp;
        LOWERING_PASS_HEADER
        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);

        print(LOCL, "-- NoOp");

        {
            auto operand = constants(noopOp.pcAttr().getUInt(), 64);
            // Macro needs a variable named "builder" so we give it one
            // print(LOCL, operand, "Noop at line");
        }

        rewriter.eraseOp(noopOp);
        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes