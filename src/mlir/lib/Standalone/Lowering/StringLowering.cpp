#include "Standalone/ConstantManager.h"
#include "Standalone/Lowering/MyBuilder.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"
#include "Standalone/Lowering/OutToPrerelease.h"

#include "Standalone/StandalonePasses.h"


namespace mlir::standalone::passes {
    LogicalResult StringLowering::matchAndRewrite(String strOp, PatternRewriter &rewriter) const {
        auto op = &strOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        myOperators

        auto firstBlock = rewriter.getBlock();

        auto pc = strOp.pcAttr().getUInt();
        auto* pOp = &vdbe->aOp[pc];
        // regTo = p2
        auto regTo = strOp.regToAttr().getSInt();
        // string = p4
        auto string = strOp.stringAttr().getUInt();
        // hints = p3
        auto hints = strOp.hintsAttr().getSInt();
        // flags = p5
        auto flags = strOp.flagsAttr().getUInt();
        // len = p1
        auto len = strOp.lenAttr().getSInt();
        if (false) { // call to default
            // TODO: Use our own implementation
            rewriter.create<StoreOp>(LOC, constants(1, 64), constants(T::i64PtrTy, &maxVdbeSteps));
            rewriter.create<StoreOp>(LOC, constants(pc, 32), constants(T::i32PtrTy, &vdbe->pc));
            rewriter.create<CallOp>(LOC, f_sqlite3VdbeExec2, ValueRange {constants(T::VdbePtrTy, vdbe) });
            rewriter.eraseOp(*op);

            if (op->getOperation()->isKnownTerminator()) {
                rewriter.create<BranchOp>(LOC, vdbeCtx->jumpsBlock);
            }

            return success();
        }

        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(strOp); GO_BACK_TO(curBlock);

        auto outToPrerelease = Inlining::OutToPrerelease(context, rewriter, print, constants);
        auto pOut = outToPrerelease(LOC, vdbe, pOp);

        branch(LOC, endBlock);
        ip_start(endBlock);

        auto pOutFlagsAddr = getElementPtrImm(LOC, T::i16PtrTy, pOut, 0, 1);
        auto pOutEncAddr = getElementPtrImm(LOC, T::i8PtrTy, pOut, 0, 2);
        auto pOutNAddr = getElementPtrImm(LOC, T::i32PtrTy, pOut, 0, 4);
        auto pOutZAddr = getElementPtrImm(LOC, T::i8PtrPtrTy, pOut, 0, 5);
        store(LOC, MEM_Str | MEM_Static | MEM_Term, pOutFlagsAddr);
        store(LOC, constants(T::i8PtrTy, (char*)string), pOutZAddr);
        store(LOC, len, pOutNAddr);
        store(LOC, vdbe->db->enc, pOutEncAddr);

        // TODO: Line 1238

        rewriter.eraseOp(strOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes