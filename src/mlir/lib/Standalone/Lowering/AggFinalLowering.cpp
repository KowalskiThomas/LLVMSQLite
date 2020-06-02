#include <llvm/Support/DynamicLibrary.h>

#include <src/mlir/include/Standalone/ConstantManager.h>
#include <src/mlir/include/Standalone/Lowering/MyBuilder.h>
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"

#include "Standalone/StandalonePasses.h"

ExternFuncOp f_sqlite3VdbeMemTooBig;

namespace mlir::standalone::passes {
    LogicalResult AggFinalLowering::matchAndRewrite(AggFinal txnOp, PatternRewriter &rewriter) const {
        auto op = &txnOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        myOperators

        auto firstBlock = rewriter.getBlock();

        auto functionAttr = txnOp.functionAttr();
        auto nArgsAttr = txnOp.nArgsAttr();
        auto toRegAttr = txnOp.toRegAttr();

        auto accumReg = toRegAttr.getSInt();
        auto pFunc = constants(T::FuncDefPtrTy, (void*)functionAttr.getUInt());

        print(LOCL, "-- AggFinal");

        auto stackState = saveStack(LOC);

        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(txnOp); GO_BACK_TO(curBlock);

        auto pMem = constants(T::sqlite3_valuePtrTy, &vdbe->aMem[accumReg]);

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
        rewriter.eraseOp(txnOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes