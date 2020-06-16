#include "Standalone/ConstantManager.h"
#include "Standalone/Lowering/MyBuilder.h"
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

        // firstToReg = p2
        auto firstToReg = mvOp.firstToRegAttr().getSInt();
        // firstFromReg = p1
        auto firstFromReg = mvOp.firstFromRegAttr().getSInt();
        // nReg = p3
        auto nReg = mvOp.nRegAttr().getSInt();
        // pc
        auto pc = mvOp.pcAttr().getUInt();

        print(LOCL, "-- Move");
        USE_DEFAULT_BOILERPLATE

        auto pInValue = &vdbe->aMem[firstFromReg];
        auto pOutValue = &vdbe->aMem[firstToReg];
        auto pIn = getElementPtrImm(LOC, T::sqlite3_valuePtrTy, vdbeCtx->aMem, firstFromReg);
        auto pOut = getElementPtrImm(LOC, T::sqlite3_valuePtrTy, vdbeCtx->aMem, firstToReg);
        do {
            call(LOC, f_sqlite3VdbeMemMove, pOut, pIn);

            pInValue++;
            pOutValue++;
            pIn = getElementPtrImm(LOC, T::sqlite3_valuePtrTy, pIn, 1);
            pOut = getElementPtrImm(LOC, T::sqlite3_valuePtrTy, pOut, 1);
        } while (--nReg);

        rewriter.eraseOp(mvOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes