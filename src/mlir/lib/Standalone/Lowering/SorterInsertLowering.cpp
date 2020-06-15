#include "Standalone/ConstantManager.h"
#include "Standalone/Lowering/MyBuilder.h"
#include "Standalone/AllIncludes.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"

#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"


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

        print(LOCL, "-- SorterInsert");
        auto stackState = saveStack(LOC);

        auto firstBlock = rewriter.getBlock();

        auto curIdx = siOp.curIdxAttr().getSInt();
        auto reg = siOp.regAttr().getSInt();

        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(siOp); GO_BACK_TO(curBlock);

        auto pCValueAddr = getElementPtrImm(LOC, T::VdbeCursorPtrPtrTy, vdbeCtx->apCsr, curIdx);
        auto pIn = getElementPtrImm(LOC, T::sqlite3_valuePtrTy, vdbeCtx->aMem, reg);

        auto pC = load(LOC, pCValueAddr);

        mlir::Value rcTemp;
        auto rc = alloca(LOC, T::i32PtrTy);
        {
            auto flagsAddr = getElementPtrImm(LOC, T::i16PtrTy, pIn, 0, 1);
            auto flagsValue = load(LOC, flagsAddr);
            auto flagsAndMemZero = bitAnd(LOC, flagsValue, MEM_Zero);
            auto flagsAndMemZeroNotNull = iCmp(LOC, Pred::ne, flagsAndMemZero, 0);

            store(LOC, 0, rc);

            auto curBlock = rewriter.getBlock();
            auto blockAfter = SPLIT_BLOCK; GO_BACK_TO(curBlock);
            auto blockFlagsAndMemZeroNotNull = SPLIT_BLOCK; GO_BACK_TO(curBlock);

            condBranch(LOC, flagsAndMemZeroNotNull, blockFlagsAndMemZeroNotNull, blockAfter);

            { // if pIn->flags & MEM_Zero
                ip_start(blockFlagsAndMemZeroNotNull);

                auto rcTemp = call(LOC, f_sqlite3VdbeMemExpandBlob, pIn).getValue();
                store(LOC, rcTemp, rc);

                branch(LOC, blockAfter);
            } // end if pIn->flags & MEM_Zero

            ip_start(blockAfter);
            rcTemp = load(LOC, rc);
        }

        { // if (rc) goto abort_due_to_error;
            auto rcIs0 = iCmp(LOC, Pred::eq, rcTemp, 0);
            myAssert(LOCL, rcIs0);
        } // end if (rc) goto abort_due_to_error;

        rcTemp = call(LOC, f_sqlite3VdbeSorterWrite, pC, pIn).getValue();

        { // if (rc) goto abort_due_to_error;
            auto rcIs0 = iCmp(LOC, Pred::eq, rcTemp, 0);
            myAssert(LOCL, rcIs0);
        } // end if (rc) goto abort_due_to_error;

        branch(LOC, endBlock);

        ip_start(endBlock);
        restoreStack(LOC, stackState);
        rewriter.eraseOp(siOp);

        return success();
    } // matchAndRewrite"
} // namespace mlir::standalone::passes