#include <llvm/Support/DynamicLibrary.h>

#include <src/mlir/include/Standalone/ConstantManager.h>
#include <src/mlir/include/Standalone/Lowering/MyBuilder.h>
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"

#include "Standalone/StandalonePasses.h"


namespace mlir::standalone::passes {
    LogicalResult RealLowering::matchAndRewrite(Real txnOp, PatternRewriter &rewriter) const {
        auto op = &txnOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        myOperators

        auto firstBlock = rewriter.getBlock();

        // pc = Programme Counter
        auto pc = txnOp.pcAttr().getUInt();
        auto* pOp = &vdbe->aOp[pc];

        // regTo = p2
        auto regTo = txnOp.regToAttr().getSInt();
        // pointerToValueAttr = p4
        auto pointerToValue = (double*)txnOp.pointerToValueAttr().getUInt();

        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(txnOp); GO_BACK_TO(curBlock);

        // Get the real value pointed by P4
        auto valueAddr = constants(T::doublePtrTy, pointerToValue);
        auto value = load(LOC, valueAddr);

        print(LOCL, value, "Loading OP_Real: ");

        // pOut = out2Prerelease(p, pOp);
        auto pOut = call(LOC, f_out2Prerelease,
            constants(T::VdbePtrTy, vdbe),
            constants(T::VdbeOpPtrTy, pOp)
        ).getValue();

        // Get &pOut->flags
        auto flagsAddr = getElementPtrImm(LOC, T::i16PtrTy, pOut, 0, 1);
        store(LOC, MEM_Real, flagsAddr);

        // Get &pOut->u.r
        auto rAddr = getElementPtrImm(LOC, T::doublePtrTy, pOut, 0, 0, 0);
        store(LOC, value, rAddr);

        branch(LOC, endBlock);

        ip_start(endBlock);

        rewriter.eraseOp(txnOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes