#include <llvm/Support/DynamicLibrary.h>

#include "Standalone/ConstantManager.h"
#include "Standalone/Lowering/MyBuilder.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"

#include "Standalone/StandalonePasses.h"

ExternFuncOp f_sqlite3VdbeBooleanValue;

namespace mlir::standalone::passes {
    LogicalResult IfLowering::matchAndRewrite(If ifOp, PatternRewriter &rewriter) const {
        auto op = &ifOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        myOperators

        print(LOCL, "-- If");

        auto firstBlock = rewriter.getBlock();

        auto conditionReg = ifOp.conditionAttr().getSInt();
        auto hints = ifOp.hintsAttr().getSInt();
        auto pc = ifOp.pcAttr().getUInt();
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


        auto jumpTo = ifOp.jumpTo();
        auto fallThrough = ifOp.fallthrough();

        auto* pMem = &vdbe->aMem[conditionReg];
        auto c = call(LOC, f_sqlite3VdbeBooleanValue,
            constants(T::sqlite3_valuePtrTy, pMem),
            constants(hints, 32)
        ).getValue();

        auto cNotNull = iCmp(LOC, Pred::ne, c, 0);
        condBranch(LOC, cNotNull, jumpTo, fallThrough);

        rewriter.eraseOp(ifOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes