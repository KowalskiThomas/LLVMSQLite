#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"

namespace mlir {
    namespace standalone {
        namespace passes {
            LogicalResult
            InitLowering::matchAndRewrite(InitOp initOp, PatternRewriter &rewriter) const {
                auto op = &initOp;
                initOp.dump();
                ModuleOp parentModule2 = op->getParentOfType<ModuleOp>();
                int i = 2;
                LOWERING_PASS_HEADER

                auto jumpToAttr = initOp.jumpTo();

                // The number 0
                auto cst0 = rewriter.create<mlir::LLVM::ConstantOp>(LOC, T::i32Ty,
                        rewriter.getIntegerAttr(rewriter.getIntegerType(32), 0));
                auto cst1 = rewriter.create<mlir::LLVM::ConstantOp>(LOC, T::i32Ty,
                                                                    rewriter.getIntegerAttr(rewriter.getIntegerType(32), 1));

                // Rewrite the Once value for all Once instructions
                for(auto i = 0; i < vdbe->nOp; i++) {
                    if (vdbe->aOp[i].opcode == OP_Once) {
                        auto ptr = PTR_TO_P1(i);
                        rewriter.create<mlir::LLVM::StoreOp>(LOC, cst0, ptr);
                    }
                }

                {
                    // Update the once value for the Init op
                    auto ptr = PTR_TO_P1(0);
                    rewriter.create<mlir::LLVM::StoreOp>(LOC, cst0, ptr);
                }

                rewriter.create<mlir::BranchOp>(LOC, jumpToAttr);

                rewriter.eraseOp(initOp);
                return success();
            } // matchAndRewrite
        } // namespace passes
    } // namespace standalone
} // namespace mlir