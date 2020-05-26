#include <llvm/Support/DynamicLibrary.h>

#include <src/mlir/include/Standalone/ConstantManager.h>
#include <src/mlir/include/Standalone/Lowering/MyBuilder.h>
#include "Standalone/AllIncludes.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"

#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"


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
        // auto goBackTo = retOp.continueAt();
        auto goBackToAddr = retOp.continueAtNextInstructionFromRegAttr().getSInt();

        /// pOp = &aOp[pIn1->u.i];
        // Get &pIn1
        auto regAddr = constants(T::sqlite3_valuePtrTy, &vdbe->aMem[goBackToAddr]);
        // Get &pIn1->u.d
        auto unionValueAddr = getElementPtrImm(LOC, T::doublePtrTy, regAddr, 0, 0, 0);
        // Get &pIn1->u.i
        auto targetAddr = bitCast(LOC, unionValueAddr, T::i32PtrTy);
        // Load pIn->u.i
        auto target = load(LOC, targetAddr);
        // Add 1
        target = add(LOC, target, 1);
        // Get &vdbe->pc
        auto pCAddr = constants(T::i32PtrTy, &vdbe->pc);
        // Store target in &vdbe->pc
        store(LOC, target, pCAddr);

        // Debug
        print(LOCL, target, "Return: Returning to");

        // Branch to jumpsBlock
        branch(LOC, vdbeCtx->jumpsBlock);
        rewriter.eraseOp(retOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes