#include <llvm/Support/DynamicLibrary.h>
#include <src/mlir/include/Standalone/Lowering/OutToPrerelease.h>

#include "Standalone/ConstantManager.h"
#include "Standalone/Lowering/MyBuilder.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"
#include "Standalone/StandalonePasses.h"


namespace mlir::standalone::passes {
    LogicalResult IntegerLowering::matchAndRewrite(Integer intOp, PatternRewriter &rewriter) const {
        auto op = &intOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        myOperators

        print(LOCL, "-- Integer");

        auto firstBlock = rewriter.getBlock();

        auto value = intOp.valueAttr().getSInt();
        auto dest = intOp.destAttr().getSInt();
        auto pc = intOp.pcAttr().getUInt();

        auto pOp = constants(T::VdbeOpPtrTy, &vdbe->aOp[pc]);

        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(intOp); GO_BACK_TO(curBlock);

        // auto pOutValue = call(LOC, f_out2Prerelease, constants(T::VdbePtrTy, vdbe), pOp).getValue();
        auto outToPrerelease = Inlining::OutToPrerelease(context, rewriter, print, constants);
        auto pOutValue = outToPrerelease(LOC, vdbe, &vdbe->aOp[pc]);

        // Get &pOut->u.i
        auto pOutUAddressBeforeCast = getElementPtrImm(LOC, T::doublePtrTy, pOutValue, 0, 0, 0);
        auto pOutUAddress = bitCast(LOC, pOutUAddressBeforeCast, T::i64PtrTy);

        store(LOC, value, pOutUAddress);

        branch(LOC, endBlock);

        ip_start(endBlock);
        rewriter.eraseOp(intOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes