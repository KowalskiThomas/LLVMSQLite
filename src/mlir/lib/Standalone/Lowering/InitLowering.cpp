#include "Standalone/Lowering/Printer.h"
#include "Standalone/ConstantManager.h"
#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"

namespace mlir::standalone::passes {
    LogicalResult InitLowering::matchAndRewrite(InitOp initOp, PatternRewriter &rewriter) const {
        auto op = &initOp;
        LOWERING_PASS_HEADER
        USING_OPS
        ConstantManager constants(rewriter, ctx);
        Printer print(ctx, rewriter, __FILE_NAME__);

        auto jumpToAttr = initOp.jumpTo();
        auto pc = initOp.pcAttr().getUInt();

        print(LOCL, "-- Init");
        USE_DEFAULT_BOILERPLATE

        // Rewrite the Once value for all Once instructions
        for(auto i = 0; i < vdbe->nOp; i++) {
            if (vdbe->aOp[i].opcode == OP_Once) {
                auto p1Addr = rewriter.create<GEPOp>(LOC, T::i32PtrTy, vdbeCtx->aOp, ValueRange{
                        constants(i, 32),
                        constants(3, 32)
                });
                rewriter.create<StoreOp>(LOC, constants(0, 32), p1Addr);
            }
        }

        {
            // Update the once value for the Init op
            auto p1Addr = rewriter.create<GEPOp>(LOC, T::i32PtrTy, vdbeCtx->aOp, ValueRange{
                    constants(0, 32),
                    constants(3, 32)
            });
            auto val = rewriter.create<LoadOp>(LOC, p1Addr);
            auto valPlus1 = rewriter.create<AddOp>(LOC, val, constants(1, 32));
            rewriter.create<StoreOp>(LOC, valPlus1, p1Addr);
        }

        if (vdbe->aOp[0].p2 > 0)
            print(LOCL, constants(vdbe->aOp[0].p2, 32), "Init: Jumping to");

        rewriter.create<BranchOp>(LOC, jumpToAttr);

        rewriter.eraseOp(initOp);
        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes