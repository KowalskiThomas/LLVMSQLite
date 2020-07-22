#include "Standalone/ConstantManager.h"
#include "Standalone/Lowering/MyBuilder.h"
#include "Standalone/AllIncludes.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"

#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"

extern LLVMFuncOp f_sqlite3VdbeMemRealify;

namespace mlir::standalone::passes {
    LogicalResult RealAffinityLowering::matchAndRewrite(RealAffinity raOp, PatternRewriter &rewriter) const {
        auto op = &raOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        myOperators

        auto pc = raOp.pcAttr().getUInt();
        auto p1 = raOp.p1Attr().getSInt();

        USE_DEFAULT_BOILERPLATE

        auto firstBlock = rewriter.getBlock();
        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(raOp); GO_BACK_TO(curBlock);

        /// pIn1 = &aMem[pOp->p1];
        auto pIn1 = getElementPtrImm(LOC, T::sqlite3_valuePtrTy, vdbeCtx->aMem, p1);

        /// flags = pIn1->flags;
        auto in1FlagsAddr = getElementPtrImm(LOC, T::i16PtrTy, pIn1, 0, 1);
        auto flags = load(LOC, in1FlagsAddr);

        auto flagsAndIntOrIntReal = bitAnd(LOC, flags, MEM_Int | MEM_IntReal);

        curBlock = rewriter.getBlock();
        auto blockAfterIsInt = SPLIT_GO_BACK_TO(curBlock);
        auto blockIsInt = SPLIT_GO_BACK_TO(curBlock);

        auto condIsInt = iCmp(LOC, Pred::ne, flagsAndIntOrIntReal, 0);

        condBranch(LOC, condIsInt, blockIsInt, blockAfterIsInt);
        { // if (pIn1->flags & (MEM_Int|MEM_IntReal))
            ip_start(blockIsInt);

            call(LOC, f_sqlite3VdbeMemRealify, pIn1);

            branch(LOC, blockAfterIsInt);
        } // end if (pIn1->flags & (MEM_Int|MEM_IntReal))

        ip_start(blockAfterIsInt);
        branch(LOC, endBlock);

        ip_start(endBlock);
        rewriter.eraseOp(raOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes