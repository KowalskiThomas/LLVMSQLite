#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"
#include "Standalone/ConstantManager.h"

namespace mlir::standalone::passes {
    LogicalResult RewindLowering::matchAndRewrite(Rewind rewindOp, PatternRewriter& rewriter) const {
        auto op = &rewindOp;
        auto& builder = rewriter;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE
        ConstantManager constants(rewriter, ctx);
        Printer print(ctx, rewriter, __FILE_NAME__);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);

        auto curIdx = constants(rewindOp.curIdxAttr().getSInt(), 32);

        auto jumpTo = rewindOp.jumpToIfEmpty();
        auto fallthrough = rewindOp.fallthrough();

        auto pc = rewindOp.pcAttr().getUInt();

        print(LOCL, "-- Rewind");
        USE_DEFAULT_BOILERPLATE

        auto stackState = rewriter.create<mlir::LLVM::StackSaveOp>(LOC, T::i8PtrTy);

        auto firstBlock = rewriter.getBlock();

        /// pC = p->apCsr[pOp->p1];
        // The address of the array of (pointers to) cursors in the VDBE
        auto apCsrAddr = rewriter.create<GEPOp>
                (LOC, T::VdbeCursorPtrPtrTy.getPointerTo(), vdbeCtx->p, ValueRange{
                        constants(0, 32),
                        constants(21, 32)
                });
        auto apCsr = rewriter.create<LoadOp>(LOC, apCsrAddr);
        // The address of this particular pointer-to-cursor
        auto pCAddr = rewriter.create<mlir::LLVM::GEPOp>(LOC, T::VdbeCursorPtrPtrTy, apCsr, ValueRange{ curIdx });
        // The address of the cursor
        auto pC = rewriter.create<LoadOp>(LOC, pCAddr);
        // A variable to store results from functions
        auto res = rewriter.create<AllocaOp>(LOC, T::i32PtrTy, constants(1, 32), 0);
        rewriter.create<StoreOp>(LOC, constants(1, 32), res);

        // The address of the curType field
        auto curTypeAddr = rewriter.create<GEPOp>(LOC, T::i8PtrTy, pC,
                ValueRange{
                            constants(0, 32), // First element of Cursor*
                            constants(0, 32)  // curType is first element of struct
        });

        // Load the curType field
        auto curType = rewriter.create<LoadOp>(LOC, curTypeAddr);
        // Check whether it contains CURTYPE_SORTER
        auto isSorter = rewriter.create<ICmpOp>(LOC, mlir::LLVM::ICmpPredicate::eq, curType, constants(CURTYPE_SORTER, 8));

        // The block to be used if the cursor is a sorter
        auto blockSorter = rewriter.getBlock()->splitBlock(rewindOp);
        rewriter.setInsertionPoint(rewindOp);

        // The block to be used if the cursor is not a sorter
        auto blockNotSorter = rewriter.getBlock()->splitBlock(rewindOp);
        rewriter.setInsertionPoint(rewindOp);

        // The block to go back at the end of the branches
        auto endBlock = rewriter.getBlock()->splitBlock(rewindOp);
        rewriter.setInsertionPointToEnd(firstBlock);

        // The return code from the functions
        auto rc = rewriter.create<AllocaOp>(LOC, T::i32PtrTy, constants(1, 32), 0);
        rewriter.create<StoreOp>(LOC, constants(0, 32), rc);

        // Branching for isSorter
        rewriter.create<CondBrOp>(LOC, isSorter, blockSorter, blockNotSorter);

        {
            // isSorter branch
            auto ip = rewriter.saveInsertionPoint();
            rewriter.setInsertionPointToStart(blockSorter);

            // Call sqlite3VdbeSorterRewind
            auto tempRc = rewriter.create<CallOp>(LOC, f_sqlite3VdbeSorterRewind, ValueRange{ pC, res }).getResult(0);
            // Store its result in rc
            rewriter.create<StoreOp>(LOC, tempRc, rc);
            // Go to endBlock
            rewriter.create<BranchOp>(LOC, endBlock);

            rewriter.restoreInsertionPoint(ip);
        }

        {
            // not isSorter branch
            rewriter.setInsertionPointToStart(blockNotSorter);

            // Get the address of the cursor from pC->uc.pCursor
            auto pCrsrAddress = rewriter.create<GEPOp>
                    (LOC, T::VdbeCursorPtrPtrTy, pC, ValueRange{
                        constants(0, 32),  // &pC
                        constants(12, 32), // &pc->uc
                        constants(0, 32)   // pCursor (first item of union-struct)
                    });

            // Load the value of the pointer (address of the cursor)
            auto pCrsrAsCursor = rewriter.create<LoadOp>(LOC, pCrsrAddress);
            // Convert this VdbeCursor* to BtCursor* (VdbeCursor is a "parent type")
            auto pCrsr = rewriter.create<BitcastOp>(LOC, T::BtCursorPtrTy, pCrsrAsCursor);
            // Call sqlite3BtreeFirst
            auto tempRc = rewriter.create<CallOp>(LOC, f_sqlite3BtreeFirst, ValueRange{
                pCrsr, res
            }).getResult(0);
            // Store the result in rc
            rewriter.create<StoreOp>(LOC, tempRc, rc);

            // print(LOCL, tempRc, "Returned by sqlite3BtreeFirst");

            /// pC->deferredMoveto = 0;
            auto deferredMoveToAddr = rewriter.create<GEPOp>
                    (LOC, T::i8PtrTy, pC, ValueRange{
                        constants(0, 32), // Address of *pC
                        constants(3, 32)  // Address of deferredMoveTo
                    });
            rewriter.create<StoreOp>(LOC, constants(0, 8), deferredMoveToAddr);

            /// pC->cacheStatus = CACHE_STALE;
            auto cacheStatusAddr = rewriter.create<GEPOp>
                    (LOC, T::i32PtrTy, pC, ValueRange{
                        constants(0, 32), // Address of *pC
                        constants(9, 32)  // Address of cacheStatus
                    });
            rewriter.create<StoreOp>(LOC, constants(CACHE_STALE, 32), cacheStatusAddr);

            // Branch back to endBlock
            rewriter.create<BranchOp>(LOC, endBlock);
        }

        rewriter.setInsertionPointToStart(endBlock);

        { // if (rc) goto abort_due_to_error;
            auto rcVal = rewriter.create<LoadOp>(LOC, rc);
            auto rcNull = rewriter.create<ICmpOp>(LOC, Pred::eq, rcVal, constants(0, 32));
            myAssert(LOCL, rcNull);
        } // end if (rc) goto abort_due_to_error;

        /// pC->nullRow = (u8) res;
        auto resValue = rewriter.create<LoadOp>(LOC, res);
        auto resAsI8 = rewriter.create<TruncOp>(LOC, T::i8Ty, resValue);
        auto pNullRow = rewriter.create<GEPOp>
                (LOC, T::VdbeCursorTy, pC, ValueRange{
                    constants(0, 32), // Address of *pC
                    constants(2, 32)  // Address of pC->nullRow
                });
        rewriter.create<StoreOp>(LOC, resAsI8, pNullRow);

        rewriter.create<mlir::LLVM::StackRestoreOp>(LOC, stackState);
        auto condResNotNull = rewriter.create<ICmpOp>
            (LOC, Pred::ne,
                resValue, constants(0, 32)
            );
        rewriter.create<CondBranchOp>(LOC, condResNotNull, jumpTo, fallthrough);

        rewriter.eraseOp(rewindOp);
        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes
