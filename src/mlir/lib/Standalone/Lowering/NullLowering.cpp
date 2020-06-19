#include "Standalone/ConstantManager.h"
#include "Standalone/Lowering/MyBuilder.h"
#include "Standalone/Lowering/OutToPrerelease.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"

#include "Standalone/StandalonePasses.h"


namespace mlir::standalone::passes {
    LogicalResult NullLowering::matchAndRewrite(Null nullOp, PatternRewriter &rewriter) const {
        auto op = &nullOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        myOperators

        auto firstBlock = rewriter.getBlock();

        /// p2 = firstReg
        auto firstReg = nullOp.firstRegAttr().getSInt();
        /// p3 = lastReg
        auto lastReg = nullOp.lastRegAttr().getSInt();
        auto setMemCleared = nullOp.setMemClearedAttr().getSInt();
        auto pc = nullOp.pcAttr().getUInt();

        print(LOCL, "-- Null");
        USE_DEFAULT_BOILERPLATE

        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(nullOp); GO_BACK_TO(curBlock);

        /// pOut = out2Prerelease(p, pOp);
        auto outToPrerelease = Inlining::OutToPrerelease(*vdbeCtx,context, rewriter, print, constants);
        auto pOp = getElementPtrImm(LOC, T::VdbeOpPtrTy, vdbeCtx->aOp, (int)pc);
        auto pOut = outToPrerelease(LOC, vdbeCtx->p, pOp);

        /// cnt = pOp->p3 - pOp->p2;
        auto cnt = lastReg - firstReg;

        branch(LOC, endBlock);
        rewriter.setInsertionPointToStart(endBlock);

        /// pOut->flags = nullFlag = pOp->p1 ? (MEM_Null | MEM_Cleared) : MEM_Null;
        auto flagsAddr = getElementPtrImm(LOC, T::i16PtrTy, pOut, 0, 1);
        auto nullFlagValue = setMemCleared ? (MEM_Null | MEM_Cleared) : MEM_Null;
        auto nullFlag = constants(nullFlagValue, 16);
        store(LOC, nullFlag, flagsAddr);

        /// pOut->n = 0;
        auto nAddr = getElementPtrImm(LOC, T::i32PtrTy, pOut, 0, 4);
        store(LOC, 0, nAddr);

        while (cnt > 0) {
            /// pOut++;
            pOut = getElementPtrImm(LOC, T::sqlite3_valuePtrTy, pOut, 1);

            /// sqlite3VdbeMemSetNull(pOut);
            call(LOC, f_sqlite3VdbeMemSetNull, pOut);

            /// pOut->flags = nullFlag;
            auto flagsAddr = getElementPtrImm(LOC, T::i16PtrTy, pOut, 0, 1);
            store(LOC, nullFlag, flagsAddr);

            /// pOut->n = 0;
            auto nAddr = getElementPtrImm(LOC, T::i32PtrTy, pOut, 0, 4);
            store(LOC, 0, nAddr);

            cnt--;
        }

        rewriter.eraseOp(nullOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes