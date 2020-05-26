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

        { //
            // TODO: if (sqlite3VdbeMemTooBig(pMem)) goto too_big;
        } //

        branch(LOC, endBlock);

        ip_start(endBlock);
        rewriter.eraseOp(txnOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes