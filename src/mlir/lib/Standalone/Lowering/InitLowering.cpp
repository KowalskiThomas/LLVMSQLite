#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"

namespace mlir {
    namespace standalone {
        namespace passes {
            LogicalResult
            InitLowering::matchAndRewrite(Operation *op, ArrayRef<Value> operands,
                                          ConversionPatternRewriter &rewriter) const {
                LOWERING_PASS_HEADER

                // auto ip = rewriter.saveInsertionPoint();
                // auto* curBlock = rewriter.getBlock();

                // auto parentFunc = op->getParentOfType<mlir::LLVM::LLVMFuncOp>();
                // assert(parentFunc && "Couldn't get parent function");
                // auto* block = parentFunc.addBlock();
                // rewriter.setInsertionPointToStart(block);

                // The number 0
                auto cst0 = rewriter.create<mlir::LLVM::ConstantOp>(LOC, T::i32Ty,
                        rewriter.getIntegerAttr(rewriter.getIntegerType(32), 0));

                // Rewrite the Once value for all Once instructions
                for(auto i = 0; i < vdbe->nOp; i++) {
                    if (vdbe->aOp[i].opcode == OP_Once) {
                        auto ptr = PTR_TO_P1(i);
                        rewriter.create<mlir::LLVM::StoreOp>(LOC, cst0, ptr);
                    }
                }

                {
                    // Update the once value for the Init op
                    auto ptr = PTR_TO_P1(0)
                    rewriter.create<mlir::LLVM::StoreOp>(LOC, cst0, ptr);
                }


                // Branch back to the current block
                // rewriter.create<mlir::BranchOp>(LOC, curBlock);

                // rewriter.restoreInsertionPoint(ip);
                rewriter.eraseOp(op);
                return success();
            } // matchAndRewrite
        } // namespace passes
    } // namespace standalone
} // namespace mlir