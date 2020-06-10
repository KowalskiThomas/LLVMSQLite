#include <llvm/Support/DynamicLibrary.h>

#include <src/mlir/include/Standalone/ConstantManager.h>
#include <src/mlir/include/Standalone/Lowering/MyBuilder.h>
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"

#include "Standalone/StandalonePasses.h"

ExternFuncOp f_sqlite3VdbeMemMove;

namespace mlir::standalone::passes {
    LogicalResult MoveLowering::matchAndRewrite(Move mvOp, PatternRewriter &rewriter) const {
        auto op = &mvOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        myOperators

        print(LOCL, "-- Move");

        // firstToReg = p2
        auto firstToReg = mvOp.firstToRegAttr().getSInt();
        // firstFromReg = p1
        auto firstFromReg = mvOp.firstFromRegAttr().getSInt();
        // nReg = p3
        auto nReg = mvOp.nRegAttr().getSInt();
        // pc
        auto pc = mvOp.pcAttr().getUInt();

        if (false) { // call to default
            // TODO: Use our own implementation
            store(LOC, 1, constants(T::i64PtrTy, &maxVdbeSteps));
            rewriter.create<StoreOp>(LOC, constants(pc, 32), constants(T::i32PtrTy, &vdbe->pc));
            call(LOC, f_sqlite3VdbeExec2, constants(T::VdbePtrTy, vdbe));
            rewriter.eraseOp(*op);

            if (op->getOperation()->isKnownTerminator()) {
                rewriter.create<BranchOp>(LOC, vdbeCtx->jumpsBlock);
            }

            return success();
        }


        auto pInValue = &vdbe->aMem[firstFromReg];
        auto pOutValue = &vdbe->aMem[firstToReg];
        do {
            auto pIn = constants(T::sqlite3_valuePtrTy, pInValue);
            auto pOut = constants(T::sqlite3_valuePtrTy, pOutValue);

            call(LOC, f_sqlite3VdbeMemMove, pOut, pIn);

            pInValue++;
            pOutValue++;
        } while (--nReg);

        rewriter.eraseOp(mvOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes