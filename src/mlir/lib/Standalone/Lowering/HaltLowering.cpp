#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"

namespace mlir {
    namespace standalone {
        namespace passes {
            LogicalResult HaltLowering::matchAndRewrite(Halt haltOp, PatternRewriter& rewriter) const {
                auto op = &haltOp;
                LOWERING_PASS_HEADER

                PROGRESS("-- Halt")
                // TODO: This is not complete at all (in comparison with the vdbe.c implementation)

                PROGRESS("Halting execution");
                {
                    auto& builder = rewriter;
                    auto p = CONSTANT_PTR(T::VdbePtrTy, vdbe);
                    rewriter.create<mlir::LLVM::CallOp>(LOC, f_sqlite3VdbeHalt, ValueRange {
                        p
                    });
                    rewriter.create<mlir::ReturnOp>(LOC, (mlir::Value)CONSTANT_INT(SQLITE_DONE, 32));
                }

                rewriter.eraseOp(haltOp);
                return success();
            } // matchAndRewrite
        } // namespace passes
    } // namespace standalone
} // namespace mlir