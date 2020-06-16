#include "Standalone/ConstantManager.h"
#include "Standalone/Lowering/MyBuilder.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"
#include "Standalone/DefaultImplementation.h"

#include "Standalone/StandalonePasses.h"

ExternFuncOp f_sqlite3VdbeMemTooBig;

namespace mlir::standalone::passes {
    LogicalResult AggFinalLowering::matchAndRewrite(AggFinal afOp, PatternRewriter &rewriter) const {
        auto op = &afOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        myOperators

        auto firstBlock = rewriter.getBlock();

        auto functionAttr = afOp.functionAttr();
        auto nArgsAttr = afOp.nArgsAttr();
        auto toRegAttr = afOp.toRegAttr();
        auto pc = afOp.pcAttr().getUInt();

        auto accumReg = toRegAttr.getSInt();
        auto pFunc = constants(T::FuncDefPtrTy, (void*)functionAttr.getUInt());

        print(LOCL, "-- AggFinal");
        USE_DEFAULT_BOILERPLATE

        auto stackState = saveStack(LOC);

        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(afOp); GO_BACK_TO(curBlock);

        // Get pMem, which is &aMem[accumReg]
        auto pMem = getElementPtrImm(LOC, T::sqlite3_valuePtrTy, vdbeCtx->aMem, accumReg);

        auto rcAddr = alloca(LOC, T::i32PtrTy);
        auto rcTemp = call(LOC, f_sqlite3VdbeMemFinalize, pMem, pFunc).getValue();
        store(LOC, rcTemp, rcAddr);

        { // assert rc == 0
            auto rcIs0 = iCmp(LOC, Pred::eq, rcTemp, 0);
            myAssert(LOCL, rcIs0);
        } // end assert rc == 0

        call(LOC, f_sqlite3VdbeChangeEncoding, pMem, constants(vdbe->db->enc, 32));

        { // if (sqlite3VdbeMemTooBig) goto too_big;
            auto tooBig = call(LOC, f_sqlite3VdbeMemTooBig, pMem).getValue();
            auto notTooBig = iCmp(LOC, Pred::eq, tooBig, 0);
            myAssert(LOCL, notTooBig);
        } //

        branch(LOC, endBlock);

        ip_start(endBlock);
        restoreStack(LOC, stackState);
        rewriter.eraseOp(afOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes