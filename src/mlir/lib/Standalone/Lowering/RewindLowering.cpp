#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"

namespace mlir {
    namespace standalone {
        namespace passes {
            LogicalResult RewindLowering::matchAndRewrite(Rewind rewindOp, PatternRewriter& rewriter) const {
                auto op = &rewindOp;
                auto& builder = rewriter;
                LOWERING_PASS_HEADER
                using namespace mlir::LLVM;
                using LoadOp = mlir::LLVM::LoadOp;
                using CallOp = mlir::LLVM::CallOp;
                using StoreOp = mlir::LLVM::StoreOp;
                using OrOp = mlir::LLVM::OrOp;
                using AndOp = mlir::LLVM::AndOp;
                using AllocaOp = mlir::LLVM::AllocaOp;

                auto firstBlock = rewriter.getBlock();

                // The address of the array of (pointers to) cursors in the VDBE
                auto apCsr = CONSTANT_PTR(T::VdbeCursorPtrPtrTy, vdbe->apCsr);
                // The address of this particular pointer-to-cursor
                auto pCAddr = rewriter.create<mlir::LLVM::GEPOp>(LOC, T::VdbeCursorPtrPtrTy, apCsr, ValueRange{ rewindOp.curIdx() });
                // The address of the cursor
                auto pC = rewriter.create<LoadOp>(LOC, pCAddr);
                // A variable to store results from functions
                auto res = rewriter.create<AllocaOp>(LOC, T::i32PtrTy, CONSTANT_INT(1, 32), 0);

                // The address of the curType field
                auto curTypeAddr = rewriter.create<GEPOp>(LOC, T::i8PtrTy, pC,
                        ValueRange{
                                    CONSTANT_INT(0, 32), // First element of Cursor*
                                    CONSTANT_INT(0, 32)  // curType is first element of struct
                });

                // Load the curType field
                auto curType = rewriter.create<LoadOp>(LOC, curTypeAddr);
                // Check whether it contains CURTYPE_SORTER
                auto isSorter = rewriter.create<ICmpOp>(LOC, mlir::LLVM::ICmpPredicate::eq, curType, CONSTANT_INT(CURTYPE_SORTER, 8));

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
                auto rc = rewriter.create<AllocaOp>(LOC, T::i32PtrTy, CONSTANT_INT(1, 32), 0);
                rewriter.create<StoreOp>(LOC, CONSTANT_INT(0, 32), rc);

                // Branching for isSorter
                rewriter.create<CondBrOp>(LOC, isSorter, blockSorter, blockNotSorter);

                {
                    // isSorter branch
                    auto ip = rewriter.saveInsertionPoint();
                    rewriter.setInsertionPointToStart(blockSorter);

                    PROGRESS("OP_Rewind: Cursor is a sorter");
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
                    auto ip = rewriter.saveInsertionPoint();
                    rewriter.setInsertionPointToStart(blockNotSorter);

                    PROGRESS("OP_Rewind: Cursor is not a sorter");
                    // Get the address of the cursor from pC->uc.pCursor
                    auto pCrsrAddress = rewriter.create<GEPOp>(LOC, T::VdbeCursorPtrPtrTy, pC,
                            ValueRange{CONSTANT_INT(0, 32),  // &pC
                                              CONSTANT_INT(12, 32), // &pc->uc
                                              CONSTANT_INT(0, 32)   // pCursor (first item of union-struct)
                    });

                    // Load the value of the pointer (address of the cursor)
                    auto pCrsrAsCursor = rewriter.create<LoadOp>(LOC, pCrsrAddress);
                    // Convert this VdbeCursor* to BtCursor* (VdbeCursor is a "parent type")
                    auto pCrsr = rewriter.create<BitcastOp>(LOC, T::BtCursorPtrTy, pCrsrAsCursor);
                    // Call sqlite3BtreeFirst
                    auto tempRc = rewriter.create<CallOp>(LOC, f_sqlite3BtreeFirst,
                                            ValueRange{pCrsr, res}).getResult(0);
                    // Store the result in rc
                    rewriter.create<StoreOp>(LOC, tempRc, rc);

                    // TRANSLATED pC->deferredMoveto = 0;
                    auto deferredMoveToAddr = rewriter.create<GEPOp>(LOC, T::i8PtrTy, pC,
                            ValueRange{CONSTANT_INT(0, 32), // Address of pC
                                       CONSTANT_INT(3, 32)}); // Address of deferredMoveTo
                    rewriter.create<StoreOp>(LOC, CONSTANT_INT(0, 8), deferredMoveToAddr);

                    // TRANSLATED pC->cacheStatus = CACHE_STALE;
                    auto cacheStatusAddr = rewriter.create<GEPOp>(LOC, T::i32PtrTy, pC,
                            ValueRange{CONSTANT_INT(0, 32), // Address of *pC
                                       CONSTANT_INT(9, 32)}); // Address of cacheStatus
                    rewriter.create<StoreOp>(LOC, CONSTANT_INT(CACHE_STALE, 32), cacheStatusAddr);

                    // Branch back to endBlock
                    rewriter.create<BranchOp>(LOC, endBlock);

                    rewriter.restoreInsertionPoint(ip);
                }

                rewriter.setInsertionPointToStart(endBlock);

                // TODO: if (rc) goto abort_due_to_error;

                // TRANSLATED pC->nullRow = (u8) res;
                auto resValue = rewriter.create<LoadOp>(LOC, res);
                auto resAsI8 = rewriter.create<TruncOp>(LOC, T::i8Ty, resValue);
                auto pNullRow = rewriter.create<GEPOp>(LOC, T::VdbeCursorTy, pC,
                        ValueRange{
                    CONSTANT_INT(0, 32), // Address of *pC
                    CONSTANT_INT(2, 32)  // Address of pC->nullRow
                });
                rewriter.create<StoreOp>(LOC, resAsI8, pNullRow);

                // TODO: if (res) goto jump_to_p2;

                /*
                rewriter.eraseOp(rewindOp);
                err("QSDQSD");
                parentModule.dump();
                err("\n");
                return success();
                */

                rewriter.eraseOp(rewindOp);
                return success();
            } // matchAndRewrite
        } // namespace passes
    } // namespace standalone
} // namespace mlir