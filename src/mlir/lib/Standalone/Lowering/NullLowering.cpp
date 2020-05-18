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

        auto firstRegAttr = nullOp.firstRegAttr();
        auto lastRegAttr = nullOp.lastRegAttr();
        auto setMemClearedAttr = nullOp.setMemClearedAttr();

        auto firstReg = firstRegAttr.getSInt();
        auto lastReg = lastRegAttr.getSInt();
        auto cnt = lastReg - firstReg;
        auto setMemCleared = setMemClearedAttr.getSInt();
        auto pc = nullOp.pcAttr().getUInt();

        auto pOp = &vdbe->aOp[pc];
        auto pOut = call(LOC, f_out2Prerelease,
            constants(T::VdbePtrTy, vdbe), constants(T::VdbeOpPtrTy, pOp)
        ).getValue();

        auto nullFlagValue = setMemClearedAttr ? (MEM_Null | MEM_Cleared) : MEM_Null;
        auto nullFlag = constants(nullFlagValue, 16);

        auto flagsAddr = getElementPtrImm(LOC, T::i16PtrTy, pOut, 0, 1);
        store(LOC, nullFlag, flagsAddr);
        auto nAddr = getElementPtrImm(LOC, T::i32PtrTy, pOut, 0, 4);
        store(LOC, 0, nAddr);

        while (cnt > 0) {
            pOut = getElementPtrImm(LOC, T::sqlite3_valuePtrTy, pOut, 1);
            call(LOC, f_sqlite3VdbeMemSetNull, pOut);
            auto flagsAddr = getElementPtrImm(LOC, T::i16PtrTy, pOut, 0, 1);
            store(LOC, nullFlag, flagsAddr);
            auto nAddr = getElementPtrImm(LOC, T::i32PtrTy, pOut, 0, 4);
            store(LOC, 0, nAddr);

            cnt--;
        }

        rewriter.eraseOp(nullOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes