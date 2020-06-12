#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"
#include "Standalone/ConstantManager.h"
#include "Standalone/Lowering/MyBuilder.h"
#include "Standalone/AllIncludes.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"


namespace mlir::standalone::passes {
    LogicalResult HaltLowering::matchAndRewrite(Halt haltOp, PatternRewriter& rewriter) const {
        auto op = &haltOp;
        LOWERING_PASS_HEADER
        USING_OPS
        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);

        // TODO: This is not complete at all (in comparison with the vdbe.c implementation)
        print(LOCL, "-- Halt");

        print(LOCL, "Halting execution");
        {
            auto& builder = rewriter;
            rewriter.create<CallOp>(LOC, f_sqlite3VdbeHalt, ValueRange {
                vdbeCtx->p
            });
            rewriter.create<ReturnOp>(LOC, (Value)constants(SQLITE_DONE, 32));
        }

        // je suis le commentaire de MATHILDE LA PLUS BELLE DE LA TERRE
        rewriter.eraseOp(haltOp);
        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes