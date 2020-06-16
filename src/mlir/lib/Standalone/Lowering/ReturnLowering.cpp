#include "Standalone/ConstantManager.h"
#include "Standalone/Lowering/MyBuilder.h"
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


        auto firstBlock = rewriter.getBlock();
        auto goBackToAddr = retOp.continueAtNextInstructionFromRegAttr().getSInt();
        auto pc = retOp.pcAttr().getUInt();

        print(LOCL, "-- Return");
        USE_DEFAULT_BOILERPLATE 

        /// pOp = &aOp[pIn1->u.i];
        // Get &pIn1
        auto regAddr = getElementPtrImm(LOC, T::sqlite3_valuePtrTy, vdbeCtx->aMem, goBackToAddr);
        // Get &pIn1->u.d
        auto unionValueAddr = getElementPtrImm(LOC, T::doublePtrTy, regAddr, 0, 0, 0);
        // Get &pIn1->u.i
        auto targetAddr = bitCast(LOC, unionValueAddr, T::i64PtrTy);
        // Load pIn->u.i
        auto target = load(LOC, targetAddr);
        // Add 1
        target = add(LOC, target, 1);
        // Truncate to 32 bits
        target = trunc(LOC, target, T::i32Ty);
        // Get &vdbe->pc
        auto pCAddr = getElementPtrImm(LOC, T::i32PtrTy, vdbeCtx->p, 0, 10);
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