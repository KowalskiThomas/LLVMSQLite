#include <llvm/Support/DynamicLibrary.h>

#include <src/mlir/include/Standalone/ConstantManager.h>
#include <src/mlir/include/Standalone/Lowering/MyBuilder.h>
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"

#include "Standalone/StandalonePasses.h"

ExternFuncOp f_sqlite3VdbeSorterInit;

namespace mlir::standalone::passes {
    LogicalResult SorterOpenLowering::matchAndRewrite(SorterOpen soOp, PatternRewriter &rewriter) const {
        auto op = &soOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        myOperators

        print(LOCL, "-- SorterOpen");

        auto firstBlock = rewriter.getBlock();

        auto curIdx = soOp.curIdxAttr().getSInt();
        auto nCol = soOp.nColAttr().getSInt();
        auto p3 = soOp.p3Attr().getSInt();
        auto p4 = soOp.p4Attr().getUInt();
        auto pc = soOp.pcAttr().getUInt();
        if (false) { // call to default
            // TODO: Use our own implementation
            rewriter.create<StoreOp>(LOC, constants(1, 64), constants(T::i64PtrTy, &maxVdbeSteps));
            rewriter.create<StoreOp>(LOC, constants(pc, 32), constants(T::i32PtrTy, &vdbe->pc));
            rewriter.create<CallOp>(LOC, f_sqlite3VdbeExec2, ValueRange {constants(T::VdbePtrTy, vdbe) });
            rewriter.eraseOp(*op);

            if (op->getOperation()->isKnownTerminator()) {
                rewriter.create<BranchOp>(LOC, vdbeCtx->jumpsBlock);
            }

            return success();
        }


        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(soOp); GO_BACK_TO(curBlock);

        auto pCx = call(LOC, f_allocateCursor,
                constants(T::VdbePtrTy, vdbe),
                constants(curIdx, 32),
                constants(nCol, 32),
                constants(-1, 32),
                constants(CURTYPE_SORTER, 8)).getValue();

        { // if (pCx == 0) goto no_mem
            auto pCxInt = ptrToInt(LOC, pCx);
            auto pCxNotNull = iCmp(LOC, Pred::ne, pCxInt, 0);
            myAssert(LOCL, pCxNotNull);
        } // end if (pCx == 0) goto no_mem

        auto keyInfoAddr = getElementPtrImm(LOC, T::KeyInfoPtrTy.getPointerTo(), pCx, 0, 13);
        store(LOC, constants(T::KeyInfoPtrTy, (void*)p4), keyInfoAddr);

        auto rc = call(LOC, f_sqlite3VdbeSorterInit,
                constants(T::sqlite3PtrTy, vdbe->db),
                constants(p3, 32),
                pCx).getValue();

        { // if (rc) goto abort_due_to_error
            auto rcNull = iCmp(LOC, Pred::eq, rc, 0);
            myAssert(LOCL, rcNull);
        } // end if (rc) goto abort_due_to_error
        
        branch(LOC, endBlock);

        ip_start(endBlock);

        rewriter.eraseOp(soOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes