#include "Standalone/ConstantManager.h"
#include "Standalone/Lowering/MyBuilder.h"
#include "Standalone/AllIncludes.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"

#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"


extern LLVMFuncOp f_sqlite3VdbeFreeCursor;

namespace mlir::standalone::passes {
    LogicalResult CloseLowering::matchAndRewrite(Close txnOp, PatternRewriter &rewriter) const {
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

        USE_DEFAULT_BOILERPLATE

        auto firstBlock = rewriter.getBlock();
        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(txnOp); GO_BACK_TO(curBlock);

        auto apCsrAddr = getElementPtrImm(LOC, T::VdbeCursorPtrPtrTy.getPointerTo(), vdbeCtx->p, 0, 21);
        auto apCsr = load(LOC, apCsrAddr);
        auto pCAddr = getElementPtrImm(LOC, T::VdbeCursorPtrTy.getPointerTo(), apCsr, p1);
        auto pC = load(LOC, pCAddr);

        call(LOC, f_sqlite3VdbeFreeCursor, vdbeCtx->p, pC);
        store(LOC, constants(T::VdbeCursorPtrTy, (VdbeCursor*)nullptr), pCAddr);

        branch(LOC, endBlock);

        ip_start(endBlock);
        rewriter.eraseOp(txnOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes