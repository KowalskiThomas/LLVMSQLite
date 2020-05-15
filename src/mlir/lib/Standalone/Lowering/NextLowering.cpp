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
    LogicalResult NextLowering::matchAndRewrite(Next nxtOp, PatternRewriter &rewriter) const {
        auto op = &nxtOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        myOperators

        rewriter.eraseOp(nxtOp);

        auto curIdxAttr = nxtOp.curIdxAttr();
        auto jumpToAttr = nxtOp.jumpToAttr();
        auto hintsAttr = nxtOp.curHintAttr();
        auto advancerAttr = nxtOp.advancerAttr();
        auto p5Attr = nxtOp.P5Attr();

        auto curIdxValue = curIdxAttr.getSInt();
        auto jumpToValue = jumpToAttr.getSInt();
        auto hintsValue = hintsAttr.getSInt();
        auto advancerValue = advancerAttr.getUInt();
        auto p5Value = p5Attr.getUInt();

        out("Next cursor index " << curIdxValue);

        auto pCAddr = constants(T::VdbeCursorPtrPtrTy, &vdbe->apCsr[curIdxValue]);
        auto pCValue = load(LOC, pCAddr);

        { // assert pC != 0
            auto pcValue2 = ptrToInt(LOC, pCValue);
            auto pCNotNull = iCmp(LOC, Pred::ne, pcValue2, 0);
            myAssert(LOCL, pCNotNull);
        } // end assert pC != 0

        /// rc = pOp->p4.xAdvance(pC->uc.pCursor, pOp->p3);

        LLVMFuncOp toCall;
        if (advancerValue == (uint64_t)sqlite3BtreeNext) {
            toCall = f_sqlite3BtreeNext;
        } else {
            err("Unsupported advancer " << advancerValue);
            exit(11);
        }

        auto pCursorAddr = rewriter.create<GEPOp>
                (LOC, T::BtCursorPtrTy.getPointerTo(), pCValue, ValueRange{
                        constants(0, 32),  // &*pC
                        constants(12, 32), // &pC->uc
                        constants(0, 32)   // &pC->uc.pCursor
                });
        auto pCursor = rewriter.create<LoadOp>(LOC, pCursorAddr);
        auto pCursorAsBtree = bitCast(LOC, pCursor, T::BtCursorPtrTy);

        print(LOCL, "BeforeCall");
        auto rc = call(LOC, toCall, pCursorAsBtree, constants(hintsValue, 32));

        /// pC->cacheStatus = CACHE_STALE;
        // TODO: 5585

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes