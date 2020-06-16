#include "Standalone/ConstantManager.h"
#include "Standalone/Lowering/MyBuilder.h"
#include "Standalone/AllIncludes.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"

#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"

extern LLVMFuncOp f_sqlite3BtreeClearTable;

namespace mlir::standalone::passes {
    LogicalResult OpenEphemeralLowering::matchAndRewrite(OpenEphemeral oeOp, PatternRewriter &rewriter) const {
        auto op = &oeOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        myOperators

        auto firstBlock = rewriter.getBlock();

        auto pc = oeOp.pcAttr().getUInt();
        auto p1 = oeOp.curIdxAttr().getSInt();
        auto p2 = oeOp.nColumnAttr().getSInt();
        auto p4 = (Btree*) oeOp.btIndexAttr().getUInt();
        auto p5 = oeOp.flagsAttr().getSInt();

        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(oeOp); GO_BACK_TO(curBlock);

        static const int vfsFlags =
                SQLITE_OPEN_READWRITE |
                SQLITE_OPEN_CREATE |
                SQLITE_OPEN_EXCLUSIVE |
                SQLITE_OPEN_DELETEONCLOSE |
                SQLITE_OPEN_TRANSIENT_DB;

        // auto pCxAddr = getElementPtrImm(LOC, T::VdbeCursorPtrTy.getPointerTo(), vdbeCtx->apCsr, p1);
        // auto pCx = load(LOC, pCxAddr);

        // auto pCxNotNull = iCmp(LOC, Pred::ne, pCx, 0);

        // auto pBtxAddr = getElementPtrImm(LOC, T::BtreePtrTy.getPointerTo(), pCx, 0, 6);
        // auto pBtx = load(LOC, pBtxAddr);
        // auto pBtxNotNull = iCmp(LOC, Pred::ne, pBtx, 0);
        
        auto bothNotNull = constants(0, 1); // bitAnd(LOC, pCxNotNull, pBtxNotNull);
        
        curBlock = rewriter.getBlock();
        auto blockAfterBothNull = SPLIT_BLOCK; GO_BACK_TO(curBlock);
        auto blockNotBothNotNull = SPLIT_BLOCK; GO_BACK_TO(curBlock);
        auto blockBothNotNull = SPLIT_BLOCK; GO_BACK_TO(curBlock);
        
        condBranch(LOC, bothNotNull, blockBothNotNull, blockNotBothNotNull);
        { // if (pCx && pCx->pBtx)
            ip_start(blockBothNotNull);
        
            /// pCx->seqCount = 0;
            // auto seqCountAddr = getElementPtrImm(LOC, T::i64PtrTy, pCx, 0, 7);
            // store(LOC, 0, seqCountAddr);
            
            /// pCx->cacheStatus = CACHE_STALE;
            // auto cacheStatusAddr = getElementPtrImm(LOC, T::i32PtrTy, pCx, 0, 9);
            // store(LOC, CACHE_STALE, cacheStatusAddr);

            /// rc = sqlite3BtreeClearTable(pCx->pBtx, pCx->pgnoRoot, 0);
            // auto pgnoRootAddr = getElementPtrImm(LOC, T::i32Ty, pCx, 0, 15);
            // auto pgnoRoot = load(LOC, pgnoRootAddr);

            // auto rc = call(LOC, f_sqlite3BtreeClearTable,
            //     pBtx,
//                 pgnoRoot,
            //              constants(T::i32PtrTy, (int*)0)
            // );
            
            branch(LOC, blockAfterBothNull);
         } // end if (pCx && pCx->pBtx)
         { // else of if (pCx && pCx->pBtx)
             ip_start(blockNotBothNotNull);

             // TODO: Line 4019 ...

             branch(LOC, blockAfterBothNull);
         } // end else of if (pCx && pCx->pBtx)
        
        ip_start(blockAfterBothNull);

        // TODO: Lines 4055 ...

        branch(LOC, endBlock);

        ip_start(endBlock);
        rewriter.eraseOp(oeOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes