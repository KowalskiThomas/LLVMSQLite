#include "Standalone/ConstantManager.h"
#include "Standalone/Lowering/MyBuilder.h"
#include "Standalone/AllIncludes.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"
#include "Standalone/Lowering/OutToPrerelease.h"

#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"


extern LLVMFuncOp f_sqlite3VdbeMemSetStr;

namespace mlir::standalone::passes {
    LogicalResult BlobLowering::matchAndRewrite(Blob txnOp, PatternRewriter &rewriter) const {
        auto op = &txnOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        myOperators

        auto pc = txnOp.pcAttr().getUInt();
        auto p1 = txnOp.p1Attr().getSInt();
        auto p3 = txnOp.p3Attr().getSInt();
        auto p4 = txnOp.p4Attr().getUInt();

        USE_DEFAULT_BOILERPLATE

        auto firstBlock = rewriter.getBlock();
        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(txnOp); GO_BACK_TO(curBlock);

        /// pOut = out2Prerelease(p, pOp);
        auto outToPrerelease = Inlining::OutToPrerelease(*vdbeCtx, *ctx, rewriter, print, constants);
        auto pOp = getElementPtrImm(LOC, T::VdbeOpPtrTy, vdbeCtx->aOp, (int)pc);
        auto pOut = outToPrerelease(LOC, vdbeCtx->p, pOp);

        /// sqlite3VdbeMemSetStr(pOut, pOp->p4.z, pOp->p1, 0, 0);
        call(LOC, f_sqlite3VdbeMemSetStr,
                pOut,
                constants(T::i8PtrTy, (char*)p4),
                constants(p1, 32),
                constants(0, 8),
                constants(T::i8PtrTy, (void*)nullptr)
        );

        /// pOut->enc = encoding;
        // TODO

        branch(LOC, endBlock);

        ip_start(endBlock);
        rewriter.eraseOp(txnOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes