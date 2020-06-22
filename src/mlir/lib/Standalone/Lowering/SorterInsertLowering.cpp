#include "Standalone/ConstantManager.h"
#include "Standalone/Lowering/MyBuilder.h"
#include "Standalone/AllIncludes.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"

#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"

#include "Standalone/DefaultImplementation.h"


namespace mlir::standalone::passes {
    LogicalResult SorterInsertLowering::matchAndRewrite(SorterInsert siOp, PatternRewriter &rewriter) const {
        auto op = &siOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        myOperators

        auto stackState = saveStack(LOC);

        auto firstBlock = rewriter.getBlock();

        auto curIdx = siOp.curIdxAttr().getSInt();
        auto reg = siOp.regAttr().getSInt();
        auto pc = siOp.pcAttr().getUInt();

        print(LOCL, "-- SorterInsert");
        USE_DEFAULT_BOILERPLATE
        
        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(siOp); GO_BACK_TO(curBlock);

        /// pC = p->apCsr[pOp->p1];
        auto pCValueAddr = getElementPtrImm(LOC, T::VdbeCursorPtrPtrTy, vdbeCtx->apCsr, curIdx);
        auto pC = load(LOC, pCValueAddr);

        /// pIn2 = &aMem[pOp->p2];
        auto pIn = getElementPtrImm(LOC, T::sqlite3_valuePtrTy, vdbeCtx->aMem, reg);

        /// rc = ExpandBlob(pIn2);
        auto rc = expandBlob(LOC, pIn);

        { // if (rc) goto abort_due_to_error;
            auto rcIs0 = iCmp(LOC, Pred::eq, rc, 0);
            myAssert(LOCL, rcIs0);
        } // end if (rc) goto abort_due_to_error;

        /// rc = sqlite3VdbeSorterWrite(pC, pIn2);
        rc = call(LOC, f_sqlite3VdbeSorterWrite, pC, pIn).getValue();

        { // if (rc) goto abort_due_to_error;
            auto rcIs0 = iCmp(LOC, Pred::eq, rc, 0);
            myAssert(LOCL, rcIs0);
        } // end if (rc) goto abort_due_to_error;

        branch(LOC, endBlock);
        ip_start(endBlock);

        restoreStack(LOC, stackState);

        rewriter.eraseOp(siOp);

        return success();
    } // matchAndRewrite"
} // namespace mlir::standalone::passes