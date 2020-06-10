#include <llvm/Support/DynamicLibrary.h>

#include <src/mlir/include/Standalone/ConstantManager.h>
#include <src/mlir/include/Standalone/Lowering/MyBuilder.h>
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"

#include "Standalone/StandalonePasses.h"


namespace mlir::standalone::passes {
    LogicalResult JumpLowering::matchAndRewrite(Jump jmpOp, PatternRewriter &rewriter) const {
        auto op = &jmpOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        myOperators

        print(LOCL, "-- Jump");

        auto firstBlock = rewriter.getBlock();

        auto ifEq = jmpOp.ifEqual();
        auto ifLess = jmpOp.ifLess();
        auto ifGreater = jmpOp.ifGreater();

        auto pc = jmpOp.pcAttr().getUInt();

        if (false) { // call to default
            // TODO: Use our own implementation
            rewriter.create<StoreOp>(LOC, constants(1, 64), constants(T::i64PtrTy, &maxVdbeSteps));
            rewriter.create<StoreOp>(LOC, constants(pc, 32), constants(T::i32PtrTy, &vdbe->pc));
            rewriter.create<CallOp>(LOC, f_sqlite3VdbeExec2, ValueRange {constants(T::VdbePtrTy, vdbe) });
            rewriter.eraseOp(*op);

            if (op->getOperation()->isKnownTerminator()) {
                rewriter.create<BranchOp>(LOC, vdbeCtx->jumpsBlock);
            }

            return success();
        }

        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(jmpOp); GO_BACK_TO(curBlock);

        auto iCompareAddr = vdbeCtx->iCompare;
        auto iCompare = load(LOC, iCompareAddr);

        auto iCompareNegative = iCmp(LOC, Pred::slt, iCompare, 0);
        condBranch(LOC, iCompareNegative, ifLess, endBlock);

        ip_start(endBlock);
        auto iComparePositive = iCmp(LOC, Pred::sgt, iCompare, 0);
        condBranch(LOC, iComparePositive, ifGreater, ifEq);

        rewriter.eraseOp(jmpOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes