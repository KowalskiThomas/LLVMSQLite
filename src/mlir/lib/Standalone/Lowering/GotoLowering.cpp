#include "Standalone/ConstantManager.h"
#include "Standalone/Lowering/Printer.h"

#include "Standalone/AllIncludes.h"

#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"

namespace mlir {
    namespace standalone {
        namespace passes {
            LogicalResult
            GotoLowering::matchAndRewrite(Goto gotoOp, PatternRewriter &rewriter) const {
                auto op = &gotoOp;
                LOWERING_PASS_HEADER
                ConstantManager constants(rewriter, ctx);
                Printer print(ctx, rewriter, __FILE_NAME__);

                print(LOCL, "-- GoTo");

                rewriter.create<mlir::BranchOp>(LOC, gotoOp.dest());

                rewriter.eraseOp(gotoOp);
                return success();
            } // matchAndRewrite
        } // namespace passes
    } // namespace standalone
} // namespace mlir