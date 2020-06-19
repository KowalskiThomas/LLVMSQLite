#include "Standalone/ConstantManager.h"
#include "Standalone/Lowering/MyBuilder.h"
#include "Standalone/AllIncludes.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"

#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"

extern LLVMFuncOp f_sqlite3VdbeAllocUnpackedRecord;
extern LLVMFuncOp f_sqlite3VdbeRecordUnpack;
extern LLVMFuncOp f_sqlite3DbFreeNN;
extern LLVMFuncOp f_sqlite3BtreeMovetoUnpacked;

namespace mlir::standalone::passes {
    LogicalResult NotFoundLowering::matchAndRewrite(NotFound nfOp, PatternRewriter &rewriter) const {
        auto op = &nfOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        myOperators

        auto firstBlock = rewriter.getBlock();

        auto pc = nfOp.pcAttr().getUInt();
        auto p1 = nfOp.p1Attr().getSInt();
        auto p2 = nfOp.p2Attr().getSInt();
        auto p3 = nfOp.p3Attr().getSInt();
        auto p4 = nfOp.p4Attr().getSInt();

        auto jumpTo = nfOp.jumpTo();
        auto fallthrough = nfOp.fallThrough();

        USE_DEFAULT_BOILERPLATE

        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(nfOp); GO_BACK_TO(curBlock);

        auto stackState = saveStack(LOC);
        auto rAddr = alloca(LOC, T::UnpackedRecordPtrTy);
        auto resAddr = alloca(LOC, T::i32PtrTy);
        auto pIdxKeyAddr = alloca(LOC, T::UnpackedRecordPtrTy.getPointerTo());
        auto pFreeAddr = alloca(LOC, T::UnpackedRecordPtrTy.getPointerTo());
        auto takeJumpAddr = alloca(LOC, T::i32PtrTy);

        /// pC = p->apCsr[pOp->p1];
        auto pCAddr = getElementPtrImm(LOC, T::VdbeCursorPtrTy, vdbeCtx->apCsr, p1);
        auto pC = load(LOC, pCAddr);

        /// pIn3 = &aMem[pOp->p3];
        auto pIn3 = getElementPtrImm(LOC, T::sqlite3_valuePtrTy, vdbeCtx->aMem, p3);

        if (p4 > 0) {
            /// r.pKeyInfo = pC->pKeyInfo;
            auto RPKeyInfoAddr = getElementPtrImm(LOC, T::KeyInfoPtrTy, rAddr, 0, 0);
            {
                auto keyInfoAddr = getElementPtrImm(LOC, T::KeyInfoPtrTy.getPointerTo(), pC, 0, 13);
                auto keyInfo = load(LOC, keyInfoAddr);
                store(LOC, keyInfo, RPKeyInfoAddr);
            }

            /// r.nField = (u16) pOp->p4.i;
            auto RNFieldAddr = getElementPtrImm(LOC, T::i16PtrTy, rAddr, 0, 2);
            store(LOC, (u16)p4, RNFieldAddr);

            /// r.aMem = pIn3;
            auto rAMemAddr = getElementPtrImm(LOC, T::sqlite3_valuePtrPtrTy, rAddr, 0, 1);
            store(LOC, pIn3, rAMemAddr);

            /// pIdxKey = &r;
            store(LOC, (Value)rAddr, pIdxKeyAddr);

            /// pFree = 0;
            store(LOC, nullptr, pFreeAddr);
        } else {
            print(LOCL, "TODO: ExpandBlob");
            /// rc = ExpandBlob(pIn3);
            auto rc = call(LOC, f_sqlite3VdbeMemExpandBlob, pIn3).getValue();
            { // if (rc) goto no_mem;
                auto rcNull = iCmp(LOC, Pred::eq, rc, 0);
                myAssert(LOCL, rcNull);
            } // end if (rc) goto no_mem;

            /// pFree = pIdxKey = sqlite3VdbeAllocUnpackedRecord(pC->pKeyInfo);
            auto pKeyInfoAddr = getElementPtrImm(LOC, T::KeyInfoPtrTy.getPointerTo(), pC, 0, 13);
            auto pKeyInfo = load(LOC, pKeyInfoAddr);
            auto pIdxKey = call(LOC, f_sqlite3VdbeAllocUnpackedRecord, pKeyInfo).getValue();
            store(LOC, pIdxKey, pFreeAddr);

            { // if (pIdxKey == 0) goto no_mem;
                auto pIdxKeyNotNull = iCmp(LOC, Pred::ne, pIdxKey, nullptr);
                myAssert(LOCL, pIdxKeyNotNull);
            } // end if (pIdxKey == 0) goto no_mem;

            // Get pin3->n
            auto nAddr = getElementPtrImm(LOC, T::i32PtrTy, pIn3, 0, 4);
            auto n = load(LOC, nAddr);

            // Get pin3->z
            auto zAddr = getElementPtrImm(LOC, T::i8PtrPtrTy, pIn3, 0, 5);
            auto z = load(LOC, zAddr);

            /// sqlite3VdbeRecordUnpack(pC->pKeyInfo, pIn3->n, pIn3->z, pIdxKey);
            call(LOC, f_sqlite3VdbeRecordUnpack, pKeyInfo, n, z, pIdxKey);
        }

        /// pIdxKey->default_rc = 0;
        auto pIdxKey = load(LOC, pIdxKeyAddr);
        auto defaultRcAddr = getElementPtrImm(LOC, T::i8PtrTy, pIdxKey, 0, 3);
        store(LOC, 0, defaultRcAddr);

        /// takeJump = 0;
        store(LOC, 0, takeJumpAddr);

        if (vdbe->aOp[pc].opcode == OP_NoConflict) {
            llvm_unreachable("Not implemented OP_NoConflict");
            /*
            for (ii = 0; ii < pIdxKey->nField; ii++) {
                if (pIdxKey->aMem[ii].flags & MEM_Null) {
                    takeJump = 1;
                    break;
                }
            }
            */
        }

        /// rc = sqlite3BtreeMovetoUnpacked(pC->uc.pCursor, pIdxKey, 0, 0, &res);
        auto pCursorAddr = getElementPtrImm(LOC, T::BtCursorPtrTy, pC, 0, 12, 0);
        auto pCursor = load(LOC, pCursorAddr);
        auto rc = call(LOC, f_sqlite3BtreeMovetoUnpacked,
            pCursor,
            pIdxKey,
            constants(0, 64),
            constants(0, 32),
            resAddr
        ).getValue();

        /// if (pFree) sqlite3DbFreeNN(db, pFree);
        curBlock = rewriter.getBlock();
        auto blockAfterPFreeNotNull = SPLIT_GO_BACK_TO(curBlock);
        auto blockPFreeNotNull = SPLIT_GO_BACK_TO(curBlock);

        auto pFree = load(LOC, pFreeAddr);
        auto condPFreeNotNull = iCmp(LOC, Pred::ne, pFree, nullptr);

        condBranch(LOC, condPFreeNotNull, blockPFreeNotNull, blockAfterPFreeNotNull);
        { // if (pFree)
            ip_start(blockPFreeNotNull);

            auto db = vdbeCtx->db;
            auto pFreeVoidStar = bitCast(LOC, pFree, T::i8PtrTy);
            call(LOC, f_sqlite3DbFreeNN, db, pFreeVoidStar);

            branch(LOC, blockAfterPFreeNotNull);
        } // end if (pFree)
        ip_start(blockAfterPFreeNotNull);

        { // if (rc != SQLITE_OK) goto abort_due_to_error;
            auto rcIsOk = iCmp(LOC, Pred::eq, rc, 0);
            myAssert(LOCL, rcIsOk);
        } // end if (rc != SQLITE_OK) goto abort_due_to_error;

        /// pC->seekResult = res;
        auto seekResultAddr = getElementPtrImm(LOC, T::i32PtrTy, pC, 0, 10);
        auto res = load(LOC, resAddr);
        store(LOC, res, seekResultAddr);

        /// alreadyExists = (res == 0);
        auto alreadyExistsBool = iCmp(LOC, Pred::eq, res, 0);
        auto alreadyExists = zExt(LOC, alreadyExistsBool, T::i8Ty);

        /// pC->nullRow = 1 - alreadyExists;
        auto nullRowAddr = getElementPtrImm(LOC, T::i8PtrTy, pC, 0, 2);
        auto nullRowVal = sub(LOC, constants(1, 8), alreadyExists);
        store(LOC, nullRowVal, nullRowAddr);

        /// pC->deferredMoveto = 0;
        auto deferredMoveToAddr = getElementPtrImm(LOC, T::i8PtrTy, pC, 0, 3);
        store(LOC, 0, deferredMoveToAddr);

        /// pC->cacheStatus = CACHE_STALE;
        auto cacheStatusAddr = getElementPtrImm(LOC, T::i32PtrTy, pC, 0, 9);
        store(LOC, CACHE_STALE, cacheStatusAddr);

        if (vdbe->aOp[pc].opcode == OP_Found) {
            llvm_unreachable("Unimplemented OP_Found");
            /// VdbeBranchTaken(alreadyExists != 0, 2);
            /// if (alreadyExists) goto jump_to_p2;
            restoreStack(LOC, stackState);
        } else {
            /// VdbeBranchTaken(takeJump || alreadyExists == 0, 2);

            /// if (takeJump || !alreadyExists) goto jump_to_p2;
            auto curBlock = rewriter.getBlock();
            auto blockAfter = SPLIT_GO_BACK_TO(curBlock);

            // Get takeJump
            auto takeJump = load(LOC, takeJumpAddr);
            takeJump = iCmp(LOC, Pred::ne, takeJump, 0);

            // Get !alreadyExists
            auto notAlreadyExists = iCmp(LOC, Pred::eq, alreadyExistsBool, 0);
            auto takeJumpOrAlreadyExists = bitOr(LOC, takeJump, notAlreadyExists);

            restoreStack(LOC, stackState);

            // goto jump_to_p2
            condBranch(LOC, takeJumpOrAlreadyExists, jumpTo, blockAfter);
            ip_start(blockAfter);
        }
        branch(LOC, endBlock);
        ip_start(endBlock);

        branch(LOC, fallthrough);
        rewriter.eraseOp(nfOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes