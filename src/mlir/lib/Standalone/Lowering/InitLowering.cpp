#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"

namespace mlir {
    namespace standalone {
        namespace passes {
            LogicalResult
            InitLowering::matchAndRewrite(InitOp initOp, PatternRewriter &rewriter) const {
                auto op = &initOp;
                LOWERING_PASS_HEADER

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

                {
                    auto ptrToP2 = PTR_TO_P2(0);
                    auto p2 = rewriter.create<mlir::LLVM::LoadOp>(LOC, ptrToP2);

                    // Check whether p2 == 0
                    auto comparison = rewriter.create<mlir::LLVM::ICmpOp>(LOC, mlir::LLVM::ICmpPredicate::eq, p2, cst0);


                    auto p2Minus1 = rewriter.create<mlir::LLVM::URemOp>(LOC, p2, cst1);


                    // If P2 == 0, then jump to next block, otherwise jump to instruction P2 - 1
                    auto branch = rewriter.create<mlir::LLVM::CondBrOp>(LOC,
                            /* P2 == 0 ? */ comparison,
                            /* Then */ vdbeDialect->vdbeContext.blocks[2],
                            /* Else */ vdbeDialect->vdbeContext.blocks[p2]
                    );

                }

                // Split the block to get rid of the existing BranchOp
                /* auto end = */ rewriter.getBlock()->splitBlock(initOp);
                rewriter.eraseOp(initOp);
                return success();
            } // matchAndRewrite
        } // namespace passes
    } // namespace standalone
} // namespace mlir