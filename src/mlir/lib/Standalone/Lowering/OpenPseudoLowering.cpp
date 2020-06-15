#include "Standalone/ConstantManager.h"
#include "Standalone/Lowering/MyBuilder.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"

#include "Standalone/StandalonePasses.h"


namespace mlir::standalone::passes {
    LogicalResult OpenPseudoLowering::matchAndRewrite(OpenPseudo opOp, PatternRewriter &rewriter) const {
        auto op = &opOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        myOperators

        print(LOCL, "-- OpenPseudo");

        auto firstBlock = rewriter.getBlock();

        auto curIdx = opOp.curIdxAttr().getSInt();
        auto reg = opOp.regAttr().getSInt();
        auto nFields = opOp.nFieldsAttr().getSInt();

        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(opOp); GO_BACK_TO(curBlock);

        auto pCx = call(LOC, f_allocateCursor,
            constants(T::VdbePtrTy, vdbe),
            constants(curIdx, 32),
            constants(nFields, 32),
            constants(-1, 32),
            constants(CURTYPE_PSEUDO, 8)
        ).getValue();

        { // if (pCx == 0) goto no_mem;
            auto pCxInt = ptrToInt(LOC, pCx);
            auto pCxNotNull = iCmp(LOC, Pred::ne, pCxInt, 0);
            myAssert(LOCL, pCxNotNull);
        } // end if (pCx == 0) goto no_mem;

        auto nullRowAddr = getElementPtrImm(LOC, T::i8PtrTy, pCx, 0, 2);
        store(LOC, 1, nullRowAddr);

        auto seekResultAddr = getElementPtrImm(LOC, T::i32PtrTy, pCx, 0, 10);
        store(LOC, reg, seekResultAddr);

        auto isTableAddr = getElementPtrImm(LOC, T::i8PtrTy, pCx, 0, 4);
        store(LOC, 1, isTableAddr);

        auto result = call(LOC, f_sqlite3BtreeFakeValidCursor).getValue();
        auto pCursorAddr = getElementPtrImm(LOC, T::BtCursorPtrTy, pCx, 0, 12, 0);
        store(LOC, result, pCursorAddr);

        branch(LOC, endBlock);

        ip_start(endBlock);

        rewriter.eraseOp(opOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes