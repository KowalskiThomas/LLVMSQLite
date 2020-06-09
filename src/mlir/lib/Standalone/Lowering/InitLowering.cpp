#include "Standalone/Lowering/Printer.h"
#include "Standalone/ConstantManager.h"
#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"

namespace mlir {
    namespace standalone {
        namespace passes {
            LogicalResult
            InitLowering::matchAndRewrite(InitOp initOp, PatternRewriter &rewriter) const {
                auto op = &initOp;
                ModuleOp parentModule2 = op->getParentOfType<ModuleOp>();
                int i = 2;
                LOWERING_PASS_HEADER
                ConstantManager constants(rewriter, ctx);
                Printer print(ctx, rewriter, __FILE_NAME__);

                print(LOCL, "-- Init");

                auto jumpToAttr = initOp.jumpTo();

                // Rewrite the Once value for all Once instructions
                for(auto i = 0; i < vdbe->nOp; i++) {
                    if (vdbe->aOp[i].opcode == OP_Once) {
                        auto ptr = PTR_TO_P1(i);
                        rewriter.create<mlir::LLVM::StoreOp>(LOC, constants(0, 32), ptr);
                    }
                }

                {
                    // Update the once value for the Init op
                    auto ptr = PTR_TO_P1(0);
                    auto val = rewriter.create<mlir::LLVM::LoadOp>(LOC, ptr);
                    auto valPlus1 = rewriter.create<mlir::LLVM::AddOp>(LOC, val, constants(1, 32));
                    rewriter.create<mlir::LLVM::StoreOp>(LOC, valPlus1, ptr);
                }

                if (vdbe->aOp[0].p2 > 0)
                    print(LOCL, constants(vdbe->aOp[0].p2, 32), "Init: Jumping to");
                rewriter.create<mlir::BranchOp>(LOC, jumpToAttr);

                rewriter.eraseOp(initOp);
                return success();
            } // matchAndRewrite
        } // namespace passes
    } // namespace standalone
} // namespace mlir