#include <llvm/Support/DynamicLibrary.h>

#include <src/mlir/include/Standalone/ConstantManager.h>
#include <src/mlir/include/Standalone/Lowering/MyBuilder.h>
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"

#include "Standalone/StandalonePasses.h"


namespace mlir::standalone::passes {
    LogicalResult ReturnLowering::matchAndRewrite(Return retOp, PatternRewriter &rewriter) const {
        auto op = &retOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        myOperators

        print(LOCL, "-- Return");

        auto firstBlock = rewriter.getBlock();
        auto goBackToAddr = retOp.continueAtNextInstructionFromRegAttr().getSInt();
        auto pc = retOp.pcAttr().getUInt();

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

        /// pOp = &aOp[pIn1->u.i];
        // Get &pIn1
        auto regAddr = constants(T::sqlite3_valuePtrTy, &vdbe->aMem[goBackToAddr]);
        // Get &pIn1->u.d
        auto unionValueAddr = getElementPtrImm(LOC, T::doublePtrTy, regAddr, 0, 0, 0);
        // Get &pIn1->u.i
        auto targetAddr = bitCast(LOC, unionValueAddr, T::i64PtrTy);
        // Load pIn->u.i
        auto target = load(LOC, targetAddr);
        // Add 1
        target = add(LOC, target, 1);
        // Get &vdbe->pc
        auto pCAddr = constants(T::i64PtrTy, &vdbe->pc);
        // Store target in &vdbe->pc
        store(LOC, target, pCAddr);

        // TODO: Debug
        // print(LOCL, target, "Return: Returning to");

        // Branch to jumpsBlock
        branch(LOC, vdbeCtx->jumpsBlock);
        rewriter.eraseOp(retOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes