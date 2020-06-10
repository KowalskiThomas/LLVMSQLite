#include <llvm/Support/DynamicLibrary.h>

#include "Standalone/ConstantManager.h"
#include "Standalone/Lowering/MyBuilder.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"

#include "Standalone/StandalonePasses.h"


namespace mlir::standalone::passes {
    LogicalResult CopyLowering::matchAndRewrite(Copy copyOp, PatternRewriter &rewriter) const {
        auto op = &copyOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        myOperators

        print(LOCL, "-- Copy");

        auto firstBlock = rewriter.getBlock();

        auto firstFromRegAttr = copyOp.firstFromRegAttr();
        auto nFromRegAttr = copyOp.nFromRegAttr();
        auto firstToRegAttr = copyOp.firstToRegAttr();

        auto firstFromReg = firstFromRegAttr.getSInt();
        auto nReg = nFromRegAttr.getSInt() + 1;
        auto firstToReg = firstToRegAttr.getSInt();
        auto pc = copyOp.pcAttr().getUInt();

        if (false) { // call to default
            // TODO: Use our own implementation
            store(LOC, 1, constants(T::i64PtrTy, &maxVdbeSteps));
            rewriter.create<StoreOp>(LOC, constants(pc, 32), constants(T::i32PtrTy, &vdbe->pc));
            call(LOC, f_sqlite3VdbeExec2, constants(T::VdbePtrTy, vdbe));
            rewriter.eraseOp(*op);
            return success();
        }


        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(copyOp); GO_BACK_TO(curBlock);

        for(size_t i = 0; i < nReg; i++) {
            auto pIn = constants(T::sqlite3_valuePtrTy, &vdbe->aMem[firstFromReg + i]);
            auto pOut = constants(T::sqlite3_valuePtrTy, &vdbe->aMem[firstToReg + i]);

            call(LOC, f_sqlite3VdbeMemShallowCopy, pOut, pIn, constants(MEM_Ephem, 32));
        }

        branch(LOC, endBlock);

        ip_start(endBlock);
        rewriter.eraseOp(copyOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes