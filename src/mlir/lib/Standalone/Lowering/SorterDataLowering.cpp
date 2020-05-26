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
    LogicalResult SorterDataLowering::matchAndRewrite(SorterData sdOp, PatternRewriter &rewriter) const {
        auto op = &sdOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        myOperators

        auto firstBlock = rewriter.getBlock();

        auto curIdx = sdOp.curIdxAttr().getSInt();
        auto reg = sdOp.regAttr().getSInt();
        auto curClearHeader = sdOp.curClearHeaderAttr().getSInt();

        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(sdOp); GO_BACK_TO(curBlock);

        /// pOut = &aMem[pOp->p2];
        auto pOut = constants(T::sqlite3_valuePtrTy, &vdbe->aMem[reg]);
        /// pC = p->apCsr[pOp->p1];
        auto pCValueAddr = constants(T::VdbeCursorPtrTy.getPointerTo(), &vdbe->apCsr[curIdx]);
        auto pC = load(LOC, pCValueAddr);
        // TODO
        /// assert(isSorter(pC));

        /// rc = sqlite3VdbeSorterRowkey(pC, pOut);
        auto rc = call(LOC, f_sqlite3VdbeSorterRowkey, pC, pOut).getValue();

        // TODO
        /// assert(rc != SQLITE_OK || (pOut->flags & MEM_Blob));

        // TODO
        /// assert(pOp->p1 >= 0 && pOp->p1 < p->nCursor);

        { // if (rc) goto abort_due_to_error;
            auto rcIsNull = iCmp(LOC, Pred::eq, rc, 0);
            myAssert(LOCL, rcIsNull);
        }

        /// p->apCsr[pOp->p3]->cacheStatus = CACHE_STALE;
        auto otherCursorPointerValueAddress = constants(T::VdbeCursorPtrTy.getPointerTo(), &vdbe->apCsr[curClearHeader]);
        auto otherCursorPointer = load(LOC, otherCursorPointerValueAddress);
        auto cacheStatusAddr = getElementPtrImm(LOC, T::i32PtrTy, otherCursorPointer, 0, 9);
        store(LOC, CACHE_STALE, cacheStatusAddr);

        branch(LOC, endBlock);

        ip_start(endBlock);

        rewriter.eraseOp(sdOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes