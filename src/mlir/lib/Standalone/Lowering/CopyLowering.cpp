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
    LogicalResult CopyLowering::matchAndRewrite(Copy txnOp, PatternRewriter &rewriter) const {
        auto op = &txnOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        myOperators

        print(LOCL, "-- Copy");

        auto firstBlock = rewriter.getBlock();

        auto firstFromRegAttr = txnOp.firstFromRegAttr();
        auto nFromRegAttr = txnOp.nFromRegAttr();
        auto firstToRegAttr = txnOp.firstToRegAttr();

        auto firstFromReg = firstFromRegAttr.getSInt();
        auto nReg = nFromRegAttr.getSInt() + 1;
        auto firstToReg = firstToRegAttr.getSInt();

        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(txnOp); GO_BACK_TO(curBlock);

        for(size_t i = 0; i < nReg; i++) {
            auto pIn = constants(T::sqlite3_valuePtrTy, &vdbe->aMem[firstFromReg + i]);
            auto pOut = constants(T::sqlite3_valuePtrTy, &vdbe->aMem[firstToReg + i]);

            call(LOC, f_sqlite3VdbeMemShallowCopy, pOut, pIn, constants(MEM_Ephem, 32));
        }

        branch(LOC, endBlock);

        ip_start(endBlock);
        rewriter.eraseOp(txnOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes