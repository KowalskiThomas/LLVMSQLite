#include "Standalone/ConstantManager.h"
#include "Standalone/Lowering/MyBuilder.h"
#include "Standalone/AllIncludes.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"

#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"

extern LLVMFuncOp f_sqlite3VdbeMemSetRowSet;
extern LLVMFuncOp f_sqlite3RowSetTest;
extern LLVMFuncOp f_sqlite3RowSetInsert;

namespace mlir::standalone::passes {
    LogicalResult RowSetTestLowering::matchAndRewrite(RowSetTest rstOp, PatternRewriter &rewriter) const {
        auto op = &rstOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        myOperators

        auto firstBlock = rewriter.getBlock();

        auto pc = rstOp.pcAttr().getUInt();
        auto p1 = rstOp.p1Attr().getSInt();
        auto p2 = rstOp.p2Attr().getSInt();
        auto p3 = rstOp.p3Attr().getSInt();
        auto p4 = rstOp.p4Attr().getSInt();

        ALWAYS_ASSERT(vdbe->aOp[pc].p4type == P4_INT32);

        auto jumpTo = rstOp.jumpTo();
        auto fallthrough = rstOp.fallThrough();

        USE_DEFAULT_BOILERPLATE

        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(rstOp); GO_BACK_TO(curBlock);

        /// pIn1 = &aMem[pOp->p1];
        auto pIn1 = getElementPtrImm(LOC, T::sqlite3_valuePtrTy, vdbeCtx->aMem, p1);

        /// pIn3 = &aMem[pOp->p3];
        auto pIn3 = getElementPtrImm(LOC, T::sqlite3_valuePtrTy, vdbeCtx->aMem, p3);

        /// iSet = pOp->p4.i;
        auto iSet = constants((int)p4, 32);

        auto in1FlagsAddr = getElementPtrImm(LOC, T::i16PtrTy, pIn1, 0, 1);
        auto in1Flags = load(LOC, in1FlagsAddr);
        auto in1FlagsAndBlob = bitAnd(LOC, in1Flags, MEM_Blob);

        curBlock = rewriter.getBlock();
        auto blockAfterIn1NotBlob = SPLIT_GO_BACK_TO(curBlock);
        auto blockIn1NotBlob = SPLIT_GO_BACK_TO(curBlock);

        auto condIn1NotBlob = iCmp(LOC, Pred::eq, in1FlagsAndBlob, 0);

        condBranch(LOC, condIn1NotBlob, blockIn1NotBlob, blockAfterIn1NotBlob);
        { // if ((pIn1->flags & MEM_Blob) == 0)
            ip_start(blockIn1NotBlob);

            auto rc = call(LOC, f_sqlite3VdbeMemSetRowSet, pIn1).getValue();
            { // if (sqlite3VdbeMemSetRowSet(pIn1)) goto no_mem;
                auto rcNull = iCmp(LOC, Pred::eq, rc, 0);
                myAssert(LOCL, rcNull);
            } // end if (sqlite3VdbeMemSetRowSet(pIn1)) goto no_mem;

            branch(LOC, blockAfterIn1NotBlob);
        } // end if ((pIn1->flags & MEM_Blob) == 0)
        ip_start(blockAfterIn1NotBlob);

        curBlock = rewriter.getBlock();
        auto blockAfterISetNotNull = SPLIT_GO_BACK_TO(curBlock);
        auto blockISetNotNull = SPLIT_GO_BACK_TO(curBlock);

        auto condISetNotNull = iCmp(LOC, Pred::ne, iSet, 0);

        condBranch(LOC, condISetNotNull, blockISetNotNull, blockAfterISetNotNull);
        { // if (iSet)
            ip_start(blockISetNotNull);

            auto in1UAddr = getElementPtrImm(LOC, T::i8PtrPtrTy, pIn1, 0, 5);
            auto in1ZAddr = bitCast(LOC, in1UAddr, T::RowSetPtrTy.getPointerTo());
            auto z = load(LOC, in1ZAddr);

            auto in3UAddr = getElementPtrImm(LOC, T::doublePtrTy, pIn3, 0, 0);
            auto in3IAddr = bitCast(LOC, in3UAddr, T::i64PtrTy);
            auto in3Int = load(LOC, in3IAddr);

            auto exists = call(LOC, f_sqlite3RowSetTest, z, iSet, in3Int).getValue();

            auto existsNotNull = iCmp(LOC, Pred::ne, exists, 0);

            condBranch(LOC, existsNotNull, jumpTo, blockAfterISetNotNull);
        } // end if (iSet)
        ip_start(blockAfterISetNotNull);

        curBlock = rewriter.getBlock();
        auto blockAfterISetPositive = SPLIT_GO_BACK_TO(curBlock);
        auto blockISetPositive = SPLIT_GO_BACK_TO(curBlock);

        auto condISetPositive = iCmp(LOC, Pred::sge, iSet, 0);

        condBranch(LOC, condISetPositive, blockISetPositive, blockAfterISetPositive);
        { // if (iSet >= 0)
            ip_start(blockISetPositive);

            /// sqlite3RowSetInsert((RowSet *) pIn1->z, pIn3->u.i);
            // Get (RowSet*) pIn1->z
            auto in1UAddr = getElementPtrImm(LOC, T::i8PtrPtrTy, pIn1, 0, 5);
            auto in1ZAddr = bitCast(LOC, in1UAddr, T::RowSetPtrTy.getPointerTo());
            auto z = load(LOC, in1ZAddr);

            // Get pIn3->u.i
            auto in3UAddr = getElementPtrImm(LOC, T::doublePtrTy, pIn3, 0, 0);
            auto in3IAddr = bitCast(LOC, in3UAddr, T::i64PtrTy);
            auto in3Int = load(LOC, in3IAddr);

            // Actually do the call
            call(LOC, f_sqlite3RowSetInsert, z, in3Int);

            branch(LOC, blockAfterISetPositive);
        } // end if (iSet >= 0)
        ip_start(blockAfterISetPositive);

        branch(LOC, endBlock);
        ip_start(endBlock);

        rewriter.eraseOp(rstOp);

        branch(LOC, fallthrough);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes