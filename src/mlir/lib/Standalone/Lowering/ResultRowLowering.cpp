#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"
#include "Standalone/ConstantManager.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/MyBuilder.h"
#include "Standalone/Lowering/Printer.h"

#undef alloca

namespace mlir::standalone::passes {
    LogicalResult ResultRowLowering::matchAndRewrite(ResultRow rrOp, PatternRewriter &rewriter) const {
        auto op = &rrOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE
        using Pred = ICmpPredicate;

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        Printer print(ctx, rewriter, __FILE_NAME__);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        myOperators

        print(LOCL, "-- ResultRow");
        auto stackState = saveStack(LOC);

        auto i = alloca(LOC, T::i32PtrTy);

        auto p = vdbeCtx->p;
        auto rc = call(LOC, f_sqlite3VdbeCheckFk, p, constants(0, 32)).getValue();
        auto sqliteOk = constants(SQLITE_OK, 32);

        auto rcNeOk = iCmp(LOC, Pred::ne, rc, sqliteOk);

        auto curBlock = rewriter.getBlock();

        auto blockEndResultRow = curBlock->splitBlock(rrOp); GO_BACK_TO(curBlock);

        auto blockAfterRcNeOk = SPLIT_BLOCK; GO_BACK_TO(curBlock);
        auto blockRcNeOk = SPLIT_BLOCK; GO_BACK_TO(curBlock);

        condBranch(LOC, rcNeOk, blockRcNeOk, blockAfterRcNeOk);
        { // if (SQLITE_OK != (rc = sqlite3VdbeCheckFk(p, 0)))
            rewriter.setInsertionPointToStart(blockRcNeOk);

            print(LOCL, "(SQLITE_OK != (rc = sqlite3VdbeCheckFk(p, 0))");
            myAssert(LOCL, constants(0, 1));

            branch(LOC, blockAfterRcNeOk);
        } // end if (SQLITE_OK != (rc = sqlite3VdbeCheckFk(p, 0)))

        ip_start(blockAfterRcNeOk);

        rc = call(LOC, f_sqlite3VdbeCloseStatement,
            vdbeCtx->p, constants(SAVEPOINT_RELEASE, 32)
        ).getValue();

        auto cacheCtrAddr = getElementPtr(LOC, T::i32PtrTy, vdbeCtx->p,
                constants(0, 32), // &*p
                constants(9, 32)  // cacheCtr is 10-th element
                );

        auto cacheCtrValue = load(LOC, cacheCtrAddr);
            auto cacheCtrPlus2 = add(LOC, cacheCtrValue, 2);
        auto cacheCtrOr1 = bitOr(LOC, cacheCtrValue, 1);
        store(LOC, cacheCtrOr1, cacheCtrAddr);

        int firstCol = rrOp.firstColAttr().getSInt();
        int nCol = rrOp.nColAttr().getSInt();
        // Out of JIT
        auto pMem = &vdbe->aMem[firstCol];
        auto pMemJit = getElementPtrImm(LOC, T::sqlite3_valuePtrTy, vdbeCtx->aMem, firstCol);
        // In JIT
        /// p->pResultSet = &aMem[pOp->p1];
        auto aMemP1Addr = getElementPtrImm(LOC, T::sqlite3_valuePtrTy, vdbeCtx->aMem, firstCol);
        auto pResultSetAddr = getElementPtrImm(LOC, T::sqlite3_valuePtrPtrTy, p, 0, 27);
        store(LOC, aMemP1Addr, pResultSetAddr);
        for(size_t it = 0; it < nCol; it++) {
            auto pMemIAddr = getElementPtrImm(LOC, T::sqlite3_valuePtrTy, pMemJit, i);
            { // De-ephemeralize
                auto pMemFlagsAddr = getElementPtrImm(LOC, T::i16PtrTy, pMemIAddr, 0, 1);
                auto pMemFlagsValue = load(LOC, pMemFlagsAddr);
                auto flagsAndEphem = bitAnd(LOC, pMemFlagsValue, MEM_Ephem);
                auto flagsAndEphemNotNull = iCmp(LOC, Pred::ne, flagsAndEphem, 0);

                auto curBlock = rewriter.getBlock();
                auto blockAfterFlagAndEphemNotNull = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                auto blockFlagsAndEphemNotNull = SPLIT_BLOCK; GO_BACK_TO(curBlock);

                condBranch(LOC, flagsAndEphemNotNull, blockFlagsAndEphemNotNull, blockAfterFlagAndEphemNotNull);

                { // if &pMem[i]->flags&MEM_Ephem
                    ip_start(blockFlagsAndEphemNotNull);
                    auto rc = call(LOC, f_sqlite3VdbeMemMakeWriteable, pMemIAddr);
                    branch(LOC, blockAfterFlagAndEphemNotNull);
                } // end if &pMem[i]->flags&MEM_Ephem

                ip_start(blockAfterFlagAndEphemNotNull);

            } // End De-ephemeralize
            call(LOC, f_sqlite3VdbeMemNulTerminate, pMemIAddr);
        }

        { // if (db->mallocFailed) goto no_mem;
            auto dbAddr = getElementPtrImm(LOC, T::sqlite3PtrTy.getPointerTo(),
                vdbeCtx->p,
                0,
                0
            );
            auto db = load(LOC, dbAddr);
            auto mallocFailedAddr = getElementPtrImm(LOC, T::i8PtrTy, db, 0, 19);
            auto mallocFailed = load(LOC, mallocFailedAddr);
            auto mallocFailedFalse = iCmp(LOC, Pred::eq, mallocFailed, 0);
            myAssert(LOCL, mallocFailedFalse);
        } // end if (db->mallocFailed) goto no_mem;

        /// p->pc = (int) (pOp - aOp) + 1;
        auto pcAddr = getElementPtrImm(LOC, T::i32PtrTy, vdbeCtx->p, 0, 10);
        // auto pcAddr = constants(T::i32PtrTy, &vdbe->pc);
        auto newPc = constants(rrOp.counterAttr().getSInt() + 1, 32);
        store(LOC, newPc, pcAddr);

        branch(LOC, blockEndResultRow);

        ip_start(blockEndResultRow);

        // auto aCountAddr = constants(T::i32PtrTy, &vdbe->aCounter[SQLITE_STMTSTATUS_VM_STEP]);
        // auto aCountVal = rewriter.create<LoadOp>(LOC, aCountAddr);
        // auto newAcountVal = rewriter.create<AddOp>(LOC, aCountVal, constants(1, 32));
        // rewriter.create<StoreOp>(LOC, newAcountVal, aCountAddr);

        restoreStack(LOC, stackState);
        rewriter.create<LLVM::ReturnOp>(LOC, constants(SQLITE_ROW, 32));

        rewriter.eraseOp(rrOp);
        return success();
    } // matchAndRewrite

#define alloca __alloca(size)

} // namespace mlir::standalone::passes