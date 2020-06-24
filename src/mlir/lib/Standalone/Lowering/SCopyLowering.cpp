#include "Standalone/ConstantManager.h"
#include "Standalone/Lowering/MyBuilder.h"
#include "Standalone/AllIncludes.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"

#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"


namespace mlir::standalone::passes {
    LogicalResult SCopyLowering::matchAndRewrite(SCopy txnOp, PatternRewriter &rewriter) const {
        auto op = &txnOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        myOperators

        auto pc = txnOp.pcAttr().getUInt();
        auto p1 = txnOp.p1Attr().getSInt();
        auto p2 = txnOp.p2Attr().getSInt();

        USE_DEFAULT_BOILERPLATE

        auto firstBlock = rewriter.getBlock();
        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(txnOp); GO_BACK_TO(curBlock);

        /// pIn1 = &aMem[pOp->p1];
        auto pIn1 = getElementPtrImm(LOC, T::sqlite3_valuePtrTy, vdbeCtx->aMem, p1);

        /// pOut = &aMem[pOp->p2];
        auto pOut = getElementPtrImm(LOC, T::sqlite3_valuePtrTy, vdbeCtx->aMem, p2);

        /// sqlite3VdbeMemShallowCopy(pOut, pIn1, MEM_Ephem);
        call(LOC, f_sqlite3VdbeMemShallowCopy, pOut, pIn1, constants(MEM_Ephem, 32));

        branch(LOC, endBlock);

        ip_start(endBlock);
        rewriter.eraseOp(txnOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes