#include "Standalone/ConstantManager.h"
#include "Standalone/Lowering/MyBuilder.h"
#include "Standalone/AllIncludes.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"

#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"


namespace mlir::standalone::passes {
    LogicalResult IsNullLowering::matchAndRewrite(IsNull txnOp, PatternRewriter &rewriter) const {
        auto op = &txnOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        myOperators

        auto pc = txnOp.pcAttr().getUInt();
        auto p1 = txnOp.regAttr().getSInt();

        auto jumpTo = txnOp.jumpTo();
        auto fallThrough = txnOp.fallthrough();

        USE_DEFAULT_BOILERPLATE

        /// pIn1 = &aMem[pOp->p1];
        auto pIn1 = getElementPtrImm(LOC, T::sqlite3_valuePtrTy, vdbeCtx->aMem, p1);

        /// if ((pIn1->flags & MEM_Null) != 0) ...
        auto flagsAddr = getElementPtrImm(LOC, T::i16PtrTy, pIn1, 0, 1);
        auto flags = load(LOC, flagsAddr);
        auto flagsAndNull = bitAnd(LOC, flags, MEM_Null);
        auto inIsNull = iCmp(LOC, Pred::ne, flagsAndNull, 0);

        /// ... goto jump_to_p2;
        condBranch(LOC, inIsNull, jumpTo, fallThrough);
        rewriter.eraseOp(txnOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes