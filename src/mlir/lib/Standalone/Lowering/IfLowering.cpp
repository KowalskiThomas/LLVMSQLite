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

        auto firstBlock = rewriter.getBlock();

        auto conditionReg = ifOp.conditionAttr().getSInt();
        auto hints = ifOp.hintsAttr().getSInt();
        auto pc = ifOp.pcAttr().getUInt();

        print(LOCL, "-- If");
        USE_DEFAULT_BOILERPLATE

        auto jumpTo = ifOp.jumpTo();
        auto fallThrough = ifOp.fallthrough();

        auto pMem = getElementPtrImm(LOC, T::sqlite3_valuePtrTy, vdbeCtx->aMem, conditionReg);
        auto c = call(LOC, f_sqlite3VdbeBooleanValue,
            pMem,
            constants(hints, 32)
        ).getValue();

        auto cNotNull = iCmp(LOC, Pred::ne, c, 0);
        condBranch(LOC, cNotNull, jumpTo, fallThrough);

        rewriter.eraseOp(ifOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes