#include "Standalone/ConstantManager.h"
#include "Standalone/Lowering/MyBuilder.h"
#include "Standalone/AllIncludes.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"

#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"


extern LLVMFuncOp f_sqlite3BtreeInsert;

namespace mlir::standalone::passes {
    LogicalResult IdxInsertLowering::matchAndRewrite(IdxInsert iiOp, PatternRewriter &rewriter) const {
        auto op = &iiOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        myOperators

        auto firstBlock = rewriter.getBlock();

        auto pc = iiOp.pcAttr().getUInt();
        auto p1 = iiOp.curIdxAttr().getSInt();
        auto p2 = iiOp.regAttr().getSInt();
        auto p3 = iiOp.p3Attr().getSInt();
        auto p4 = iiOp.p4Attr().getUInt();
        auto p5 = iiOp.flagsAttr().getUInt();

        USE_DEFAULT_BOILERPLATE

        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(iiOp); GO_BACK_TO(curBlock);

        auto pCAddr = getElementPtrImm(LOC, T::VdbeCursorPtrPtrTy, vdbeCtx->apCsr, p1);
        auto pC = load(LOC, pCAddr);

        auto pIn2 = getElementPtrImm(LOC, T::sqlite3_valuePtrTy, vdbeCtx->aMem, p2);

        if (p5 & OPFLAG_NCHANGE) {
            print(LOCL, "TODO: p5 & OPFLAG_NCHANGE != 0");
            // TODO: p->nChange++
        }

        // rc = ExpandBlob(pIn2)
        auto rc = expandBlob(LOC, pIn2);
        { // if (rc) goto abort_due_to_error;
            auto rcNull = iCmp(LOC, Pred::eq, rc, 0);
            myAssert(LOCL, rcNull);
        } // end if (rc) goto abort_due_to_error;

        auto stackState = saveStack(LOC);
        auto x = alloca(LOC, T::BtreePayloadPtrTy);

        /// x.nKey = pIn2->n;
        auto nKeyAddr = getElementPtrImm(LOC, T::i64PtrTy, x, 0, 1);
        auto nInAddr = getElementPtrImm(LOC, T::i32PtrTy, pIn2, 0, 4);
        auto nIn = load(LOC, nInAddr);
        nIn = zExt(LOC, nIn, T::i64Ty);
        store(LOC, nIn, nKeyAddr);

        /// x.pKey = pIn2->z;
        auto pKeyAddr = getElementPtrImm(LOC, T::i64PtrTy, x, 0, 0);
        auto nInZAddr = getElementPtrImm(LOC, T::i8PtrPtrTy, pIn2, 0, 5);
        auto nInZ = load(LOC, nInZAddr);
        store(LOC, nInZ, pKeyAddr);

        /// x.aMem = aMem + pOp->p3;
        auto aMemAddr = getElementPtrImm(LOC, T::i64PtrTy, x, 0, 3);
        auto aMemP3 = getElementPtrImm(LOC, T::sqlite3_valuePtrTy, vdbeCtx->aMem, p3);
        store(LOC, aMemP3, aMemAddr);

        /// x.nMem = (u16) pOp->p4.i;
        auto nMemAddr = getElementPtrImm(LOC, T::i64PtrTy, x, 0, 4);
        auto nMem = constants(p4, 16);
        store(LOC, nMem, nMemAddr);

        {
            auto pCursorAddr = getElementPtrImm(LOC, T::BtCursorPtrTy, pC, 0, 12, 0);
            auto pCursor = load(LOC, pCursorAddr);

            auto flags = constants(p5 & (OPFLAG_APPEND | OPFLAG_SAVEPOSITION), 32);
            auto seekResult = (p5 & OPFLAG_USESEEKRESULT) ?
                    load(LOC, getElementPtrImm(LOC, T::i32PtrTy, pC, 0, 10)) :
                    constants(0, 32);

            rc = call(LOC, f_sqlite3BtreeInsert, pCursor, x, flags, seekResult).getValue();
        }

        { // if (rc) goto abort_due_to_error;
            auto rcNull = iCmp(LOC, Pred::eq, rc, 0);
            myAssert(LOCL, rcNull);
        } // end if (rc) goto abort_due_to_error;

        /// pC->cacheStatus = CACHE_STALE;
        auto cacheStatusAddr = getElementPtrImm(LOC, T::i32PtrTy, pC, 0, 9);
        store(LOC, CACHE_STALE, cacheStatusAddr);

        branch(LOC, endBlock);
        ip_start(endBlock);

        restoreStack(LOC, stackState);
        rewriter.eraseOp(iiOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes