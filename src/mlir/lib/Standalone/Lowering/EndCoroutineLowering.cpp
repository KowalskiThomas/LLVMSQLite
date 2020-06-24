#include "Standalone/ConstantManager.h"
#include "Standalone/Lowering/MyBuilder.h"
#include "Standalone/AllIncludes.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"

#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"


namespace mlir::standalone::passes {
    LogicalResult EndCoroutineLowering::matchAndRewrite(EndCoroutine ecOp, PatternRewriter &rewriter) const {
        auto op = &ecOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        myOperators

        auto pc = ecOp.pcAttr().getUInt();
        auto p1 = ecOp.p1Attr().getSInt();

        USE_DEFAULT_BOILERPLATE

        auto firstBlock = rewriter.getBlock();
        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(ecOp); GO_BACK_TO(curBlock);

        /// pIn1 = &aMem[pOp->p1];
        auto pIn1 = getElementPtrImm(LOC, T::sqlite3_valuePtrTy, vdbeCtx->aMem, p1);

        /// pCaller = &aOp[pIn1->u.i];
        auto inUAddr = getElementPtrImm(LOC, T::doublePtrTy, pIn1, 0, 0);
        auto inIntegerAddr = bitCast(LOC, inUAddr, T::i64PtrTy);
        auto pIn1Int = load(LOC, inIntegerAddr);
        pIn1Int = trunc(LOC, pIn1Int, T::i32Ty);

        auto pCaller = getElementPtr(LOC, T::VdbeOpPtrTy, vdbeCtx->aOp, pIn1Int);
        auto pCallerP2Addr = getElementPtrImm(LOC, T::i32PtrTy, pCaller, 0, 4);
        auto pCallerP2 = load(LOC, pCallerP2Addr);

        // Get &vdbe->pc
        auto pcAddr = getElementPtrImm(LOC, T::i32PtrTy, vdbeCtx->p, 0, 10);
        // Store target in &vdbe->pc
        store(LOC, pCallerP2, pcAddr);

        /// pIn1->flags = MEM_Undefined;
        auto flagsAddr = getElementPtrImm(LOC, T::i16PtrTy, pIn1, 0, 1);
        store(LOC, MEM_Undefined, flagsAddr);

        branch(LOC, endBlock);
        ip_start(endBlock);

        // Branch to jumpsBlock
        branch(LOC, vdbeCtx->jumpsBlock);
        rewriter.eraseOp(ecOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes