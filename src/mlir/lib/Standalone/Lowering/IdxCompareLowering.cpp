#include "Standalone/ConstantManager.h"
#include "Standalone/Lowering/MyBuilder.h"
#include "Standalone/AllIncludes.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"

#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"

extern LLVMFuncOp f_sqlite3VdbeIdxKeyCompare;

namespace mlir::standalone::passes {
    LogicalResult IdxCompareLowering::matchAndRewrite(IdxCompare icOp, PatternRewriter &rewriter) const {
        auto op = &icOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        myOperators

        auto firstBlock = rewriter.getBlock();

        auto pc = icOp.pcAttr().getUInt();
        auto p1 = icOp.curIdxAttr().getSInt();
        auto p3 = icOp.firstRegAttr().getSInt();
        auto p4 = icOp.nRegAttr().getUInt();
        auto p5 = icOp.flagsAttr().getUInt();

        auto opcode = vdbe->aOp[pc].opcode;

        USE_DEFAULT_BOILERPLATE
        
        auto jumpTo = icOp.jumpTo();
        auto fallThrough = icOp.fallThrough();

        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(icOp); GO_BACK_TO(curBlock);

        /// pC = p->apCsr[pOp->p1];
        auto pCAddr = getElementPtrImm(LOC, T::VdbeCursorPtrPtrTy, vdbeCtx->apCsr, p1);
        auto pC = load(LOC, pCAddr);

        auto stackState = saveStack(LOC);
        auto r = alloca(LOC, T::UnpackedRecordPtrTy);
        auto resAddr = alloca(LOC, T::i32PtrTy);

        /// r.pKeyInfo = pC->pKeyInfo;
        auto RPKeyInfoAddr = getElementPtrImm(LOC, T::KeyInfoPtrTy, r, 0, 0);
        {
            auto keyInfoAddr = getElementPtrImm(LOC, T::KeyInfoPtrTy.getPointerTo(), pC, 0, 13);
            auto keyInfo = load(LOC, keyInfoAddr);
            store(LOC, keyInfo, RPKeyInfoAddr);
        }

        /// r.nField = (u16) pOp->p4.i;
        auto RNFieldAddr = getElementPtrImm(LOC, T::i16PtrTy, r, 0, 2);
        store(LOC, (u16)p4, RNFieldAddr);

        auto rDefaultRcAddr = getElementPtrImm(LOC, T::i8PtrTy, r, 0, 3);
        if (opcode < OP_IdxLT) {
            /// r.default_rc = -1;
            store(LOC, -1, rDefaultRcAddr);
        } else {
            /// r.default_rc = 0;
            store(LOC, 0, rDefaultRcAddr);
        }

        /// r.aMem = &aMem[pOp->p3];
        auto rAMemAddr = getElementPtrImm(LOC, T::sqlite3_valuePtrPtrTy, r, 0, 1);
        {
            auto aMem = getElementPtrImm(LOC, T::sqlite3_valuePtrPtrTy, vdbeCtx->aMem, p3);
            store(LOC, aMem, rAMemAddr);
        }

        /// rc = sqlite3VdbeIdxKeyCompare(db, pC, &r, &res);
        auto dbAddr = getElementPtrImm(LOC, T::sqlite3PtrTy.getPointerTo(), vdbeCtx->p, 0, 0);
        auto db = load(LOC, dbAddr);
        auto rc = call(LOC, f_sqlite3VdbeIdxKeyCompare, db, pC, r, resAddr).getValue();

        if ((opcode & 1) == (OP_IdxLT & 1)) {
            /// res = -res;
            auto resValue = load(LOC, resAddr);
            resValue = rewriter.create<SubIOp>(LOC, constants(0, 32), resValue);
            store(LOC, resValue, resAddr);
        } else {
            /// res++
            addInPlace(LOC, resAddr, 1);
        }

        { // if (rc) goto abort_due_to_error;
            auto rcNull = iCmp(LOC, Pred::eq, rc, 0);
            myAssert(LOCL, rcNull);
        } // end if (rc) goto abort_due_to_error;

        branch(LOC, endBlock);

        ip_start(endBlock);

        restoreStack(LOC, stackState);
        rewriter.eraseOp(icOp);

        /// if (res > 0) goto jump_to_p2;
        auto resValue = load(LOC, resAddr);
        auto resPositive = iCmp(LOC, Pred::sgt, resValue, 0);
        condBranch(LOC, resPositive, jumpTo, fallThrough);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes