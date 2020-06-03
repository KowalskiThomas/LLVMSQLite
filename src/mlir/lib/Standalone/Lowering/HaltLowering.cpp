#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"
#include "Standalone/ConstantManager.h"
#include "Standalone/Lowering/MyBuilder.h"
#include "Standalone/AllIncludes.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"


namespace mlir {
    namespace standalone {
        namespace passes {
            LogicalResult HaltLowering::matchAndRewrite(Halt haltOp, PatternRewriter& rewriter) const {
                auto op = &haltOp;
                LOWERING_PASS_HEADER
                ConstantManager constants(rewriter, ctx);
                MyBuilder builder(ctx, constants, rewriter);
                MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
                Printer print(ctx, rewriter, __FILE_NAME__);

                print(LOCL, "-- Halt");
                // TODO: This is not complete at all (in comparison with the vdbe.c implementation)

                print(LOCL, "Halting execution");
                {
                    auto& builder = rewriter;
                    auto p = CONSTANT_PTR(T::VdbePtrTy, vdbe);
                    rewriter.create<mlir::LLVM::CallOp>(LOC, f_sqlite3VdbeHalt, ValueRange {
                        p
                    });
                    rewriter.create<mlir::ReturnOp>(LOC, (mlir::Value)CONSTANT_INT(SQLITE_DONE, 32));
                }

// je suis le commentaire de MATHILDE LA PLUS BELLE DE LA TERRE
                rewriter.eraseOp(haltOp);
                return success();
            } // matchAndRewrite
        } // namespace passes
    } // namespace standalone
} // namespace mlir