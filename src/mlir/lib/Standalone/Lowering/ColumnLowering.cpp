#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"

#include "Standalone/ConstantManager.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/GetVarint32Operator.h"
#include "Standalone/Lowering/Printer.h"

ExternFuncOp f_sqlite3BtreeCursorIsValid;
ExternFuncOp f_sqlite3VdbeExec2;
extern int64_t maxVdbeSteps;

namespace mlir {
    namespace standalone {
        namespace passes {
            LogicalResult ColumnLowering::matchAndRewrite(Column colOp, PatternRewriter &rewriter) const {
                auto op = &colOp;
                auto &builder = rewriter;
                LOWERING_PASS_HEADER
                LOWERING_NAMESPACE

                // An operation that jumps to op_column_read_header but is written before the op_column_read_header block
                // exists. We'll need to update it later, hence the pointer.
                Operation* operationToUpdateReadHeader = nullptr;

                auto firstBlock = rewriter.getBlock();

                auto stackState = rewriter.create<mlir::LLVM::StackSaveOp>(LOC, T::i8PtrTy);

                ConstantManager constants(rewriter, ctx);
                MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
                GetVarint32Operator generate_getVarint32(rewriter, constants, ctx);
                Printer print(ctx, rewriter, __FILE_NAME__);

                auto pVdbe = constants(T::VdbePtrTy, vdbe);
                auto db = constants(T::sqlite3PtrTy, vdbe->db);
                auto dbEnc = constants(vdbe->db->enc, 8);

                auto curIdxAttr = colOp.getAttrOfType<mlir::IntegerAttr>("curIdx");
                auto columnAttr = colOp.getAttrOfType<mlir::IntegerAttr>("column");
                auto extractToAttr = colOp.getAttrOfType<mlir::IntegerAttr>("extractTo");
                auto defaultValueAttr = colOp.getAttrOfType<mlir::IntegerAttr>("defaultValue");
                auto flagsAttr = colOp.getAttrOfType<mlir::IntegerAttr>("flags");

                auto curIdxValue = constants(curIdxAttr.getSInt(), 32);
                auto columnValue = constants(columnAttr.getSInt(), 32);
                auto extractToValue = constants(extractToAttr.getSInt(), 32);
                auto defaultValueValue = constants(defaultValueAttr.getUInt(), 64);
                auto flagsValue = constants(flagsAttr.getUInt(), 16);
                auto pc = colOp.counterAttr().getSInt();
                auto pOp = &vdbe->aOp[pc];

                // PROGRESS_PRINT_INT(constants(pc, 32), "-- Column");

                if (false) {
                    // TODO: Use our own implementation
                    print(LOCL, "Calling into default implementation");
                    rewriter.create<StoreOp>(LOC, constants(1, 64), constants(T::i64PtrTy, &maxVdbeSteps));
                    rewriter.create<StoreOp>(LOC, constants(pc, 32), constants(T::i32PtrTy, &vdbe->pc));
                    rewriter.create<CallOp>(LOC, f_sqlite3VdbeExec2, ValueRange{
                            constants(T::VdbePtrTy, vdbe)
                    });
                    rewriter.eraseOp(*op);
                    return success();
                }


                auto curIdx = rewriter.create<AllocaOp>(LOC, T::i32PtrTy, constants(1, 32), 0);
                rewriter.create<StoreOp>(LOC, curIdxValue, curIdx);

                // The address of the array of (pointers to) cursors in the VDBE
                auto apCsr = constants(T::VdbeCursorPtrPtrTy, vdbe->apCsr);
                // The address of this particular pointer-to-cursor
                auto cursorAddr = rewriter.create<GEPOp>
                        (LOC, T::VdbeCursorPtrPtrTy, apCsr, ValueRange{
                            curIdxValue
                        });

                // The address of the cursor
                auto pCAddr = rewriter.create<AllocaOp>(LOC, T::VdbeCursorPtrPtrTy, constants(1, 32), 0);
                auto pCValue = rewriter.create<LoadOp>(LOC, cursorAddr);
                rewriter.create<StoreOp>(LOC, pCValue, pCAddr);

                { /// assert pC != 0
                    auto pNotNull = rewriter.create<ICmpOp>
                            (LOC, ICmpPredicate::ne, pCValue,
                    constants(pCValue.getType(), (u8*)nullptr)
                    );
                    myAssert(LOCL, pNotNull);
                } // end assert pC != 0

                // Allocate variable zData (i8*)
                auto zDataAddress = rewriter.create<AllocaOp>(LOC, T::i8PtrPtrTy, constants(1, 32), 0);

                // Allocate variable t (i32*)
                auto tAddr = rewriter.create<AllocaOp>(LOC, T::i32PtrTy, constants(1, 32), 0);

                // Allocate variable rc (i32)
                auto rcAddr = rewriter.create<AllocaOp>(LOC, T::i32PtrTy, constants(1, 32), 0);

                auto rc = rewriter.create<CallOp>(LOC, f_sqlite3VdbeCursorMoveto, ValueRange{
                    pCAddr, curIdx
                }).getResult(0);
                rewriter.create<StoreOp>(LOC, rc, rcAddr);

                // These might have changed since we pass them by reference
                pCValue = rewriter.create<LoadOp>(LOC, pCAddr);
                curIdxValue = rewriter.create<LoadOp>(LOC, curIdx);

                { // assert(rc == 0)
                    auto rcNull = rewriter.create<ICmpOp>
                            (LOC, ICmpPredicate::eq,
                             rc, constants(0, 32)
                            );
                    myAssert(LOCL, rcNull);
                } // end assert(rc == 0)

                auto curBlock = rewriter.getBlock();

                /// pDest = &aMem[pOp->p3];
                // Initialise aMem with its actual value
                auto aMem = constants(T::sqlite3_valuePtrTy, vdbe->aMem);
                // Get the address of the P3'th (extractTo) element
                auto pDest = rewriter.create<GEPOp>
                        (LOC, T::sqlite3_valuePtrTy, aMem, ValueRange{
                            extractToValue
                        });

                { // Bunch of asserts
                    auto nFieldAddr = rewriter.create<GEPOp>
                            (LOC, T::i16PtrTy, pCValue, ValueRange {
                                constants(0, 32),
                                constants(16, 32)
                            });
                    auto nField = rewriter.create<LoadOp>(LOC, nFieldAddr);
                    auto columnValue_16 = rewriter.create<TruncOp>(LOC, T::i16Ty, columnValue);

                    auto p2ltnField = rewriter.create<ICmpOp>
                            (LOC, ICmpPredicate::slt,
                                columnValue_16, nField
                            );
                    myAssert(LOCL, p2ltnField);
                }

                // aOffset = pC->aOffset; (aOffset is an i32*)
                auto aOffsetAddr = rewriter.create<GEPOp>
                        (LOC, T::i32PtrTy.getPointerTo(), pCValue,
                         ValueRange{
                                 constants(0, 32),  // *pC
                                 constants(19, 32)  // Address of aOffset in pC
                         });
                auto aOffset = rewriter.create<LoadOp>(LOC, aOffsetAddr);
                auto aOffset0 = rewriter.create<LoadOp>(LOC, aOffset);

                {
                    // Get the address of pC->curType
                    auto curTypeAddr = rewriter.create<GEPOp>
                            (LOC, T::i8PtrTy, pCValue, ValueRange{
                                    constants(0, 32), // *pC
                                    constants(0, 32)  // curType is the first field
                            });

                    // Load the value of pC->curType
                    auto curType = rewriter.create<LoadOp>(LOC, curTypeAddr);

                    auto notVtab = rewriter.create<ICmpOp>
                            (LOC, ICmpPredicate::ne,
                                curType, constants(CURTYPE_VTAB, 8)
                            );
                    myAssert(LOCL, notVtab);

                    auto notPseudo = rewriter.create<ICmpOp>
                            (LOC, ICmpPredicate::ne,
                             curType, constants(CURTYPE_PSEUDO, 8)
                            );

                    // Load the address of pC->nullRow
                    auto nullRowAddr = rewriter.create<GEPOp>
                            (LOC, T::i8PtrTy, pCValue,
                             ValueRange{
                                     constants(0, 32), // *pC
                                     constants(2, 32)  // nullRow is field 2
                             });
                    auto nullRow = rewriter.create<LoadOp>(LOC, nullRowAddr);
                    auto nullRowNotNull = rewriter.create<ICmpOp>
                            (LOC, ICmpPredicate::ne,
                                nullRow, constants(0, 8)
                            );
                    auto nullRowOrNotPseudo = rewriter.create<OrOp>(LOC, notPseudo, nullRowNotNull);
                    myAssert(LOCL, nullRowOrNotPseudo);
                    print(LOCL, nullRowOrNotPseudo, "NullRowOrNotPseudo");
                    print(LOCL, nullRow, "NullRow");
                    print(LOCL, notPseudo, "NotPseudo");

                    auto notSorter = rewriter.create<ICmpOp>
                            (LOC, ICmpPredicate::ne,
                             curType, constants(CURTYPE_SORTER, 8)
                            );
                    myAssert(LOCL, notSorter);
                }

                // Get the address of pC->iHdrOffset
                auto iHdrOffsetAddr = rewriter.create<GEPOp>
                        (LOC, T::i32PtrTy, pCValue, ValueRange{
                                constants(0, 32),  // &*pC
                                constants(14, 32)  // &pC->iHdrOffset
                        });

                // Get the address of pC->payloadSize
                auto payloadSizeAddress = rewriter.create<GEPOp>
                        (LOC, T::i32PtrTy, pCValue,
                         ValueRange{
                                 constants(0, 32), // *pC
                                 constants(21, 32) // &pC->payloadSize
                         });

                // Get the address of pC->szRow
                auto szRowAddress = rewriter.create<GEPOp>
                        (LOC, T::i32PtrTy, pCValue,
                         ValueRange{
                                 constants(0, 32), // *pC
                                 constants(22, 32) // &pC->szRo
                         });

                // Get the address of pC->aRow (u8*)
                auto pCaRowAddress = rewriter.create<GEPOp>
                        (LOC, T::i8PtrPtrTy, pCValue,
                         ValueRange{
                                 constants(0, 32),
                                 constants(20, 32)
                         });

                // Get the address of pC->nHdrParsedAddr
                auto nHdrParsedAddr = rewriter.create<GEPOp>
                        (LOC, T::i16PtrTy, pCValue, ValueRange{
                                constants(0, 32), // &*pC
                                constants(17, 32) // &pC->nHdrParsedAddr
                        });

                curBlock = rewriter.getBlock();
                auto blockCacheStatusNeqCacheCtr = rewriter.getBlock()->splitBlock(colOp);
                rewriter.setInsertionPoint(colOp);
                auto blockAfterCacheStatusNeqCachePtr = rewriter.getBlock()->splitBlock(colOp);
                rewriter.setInsertionPoint(colOp);
                auto blockColumnEnd = rewriter.getBlock()->splitBlock(colOp);
                rewriter.setInsertionPoint(colOp);

                // Go back to the end of the current block to insert branching
                rewriter.setInsertionPointToEnd(curBlock);

                // Get the address of pC->cacheStatus
                auto cacheStatusAddr = rewriter.create<GEPOp>
                        (LOC, T::i32PtrTy, pCValue,
                         ValueRange{
                                 constants(0, 32), // *pC
                                 constants(9, 32)  // &pC->cacheStatus
                         });
                auto cacheStatus = rewriter.create<LoadOp>(LOC, cacheStatusAddr);

                // Get the address of pC->cacheCtr
                auto cacheCtrAddr = rewriter.create<GEPOp>
                        (LOC, T::i32PtrTy, pVdbe,
                         ValueRange{
                                 constants(0, 32), // &*pVdbe
                                 constants(9, 32)  // &pVdbe->cacheCtr
                         });
                auto cacheCtr = rewriter.create<LoadOp>(LOC, cacheCtrAddr);

                auto cacheStatusNeqCacheCtr = rewriter.create<ICmpOp>
                        (LOC, ICmpPredicate::ne,
                                cacheStatus, cacheCtr
                        );

                rewriter.create<CondBrOp>(LOC, cacheStatusNeqCacheCtr,
                        /* if != */ blockCacheStatusNeqCacheCtr,
                        /* else  */ blockAfterCacheStatusNeqCachePtr);

                { // if cacheStatus != cacheCtr
                    rewriter.setInsertionPointToStart(blockCacheStatusNeqCacheCtr);

                    // print(LOCL, "cacheStatus != cacheCtr");

                    auto block = rewriter.getBlock();
                    auto blockNullRow = rewriter.getBlock()->splitBlock(rewriter.getBlock()->end());
                    rewriter.setInsertionPointToEnd(block);
                    auto blockNotNullRow = rewriter.getBlock()->splitBlock(rewriter.getBlock()->end());
                    rewriter.setInsertionPointToEnd(block);
                    auto blockEndCacheNeStatusCacheCtr = rewriter.getBlock()->splitBlock(rewriter.getBlock()->end());
                    rewriter.setInsertionPointToEnd(block);

                    // Load the address of pC->nullRow
                    auto nullRowAddr = rewriter.create<GEPOp>
                            (LOC, T::i8PtrTy, pCValue,
                             ValueRange{
                                     constants(0, 32), // *pC
                                     constants(2, 32)  // nullRow is 3rd field
                             });

                    // Load the value of pC->nullRow
                    auto nullRow = rewriter.create<LoadOp>(LOC, nullRowAddr);

                    // Check whether pC->nullRow
                    auto nullRowCondition = rewriter.create<ICmpOp>
                            (LOC, ICmpPredicate::ne,
                                    nullRow, constants(0, 8)
                            );

                    // Branch for pC->nullRow
                    rewriter.create<CondBrOp>(LOC, nullRowCondition,
                            /* if pC->nullRow */ blockNullRow,
                            /* else */           blockNotNullRow);


                    { // if pC->nullRow
                        rewriter.setInsertionPointToStart(blockNullRow);
                        // print(LOCL, "pC->nullRow == true");
                        auto currentBlock = rewriter.getBlock();
                        auto blockNotCurTypePseudo = SPLIT_BLOCK; GO_BACK_TO(currentBlock);
                        auto blockCurTypePseudo = SPLIT_BLOCK; GO_BACK_TO(currentBlock);

                        // Get the address of pC->curType
                        auto curTypeAddr = rewriter.create<GEPOp>
                                (LOC, T::i8PtrTy, pCValue, ValueRange{
                                        constants(0, 32), // *pC
                                        constants(0, 32)  // curType is the first field
                                });

                        // Load the value of pC->curType
                        auto curType = rewriter.create<LoadOp>(LOC, curTypeAddr);

                        // Check whether pC->curType == CURTYPE_PSEUDO
                        auto curTypeCondition = rewriter.create<ICmpOp>
                                (LOC, ICmpPredicate::eq,
                                        curType, constants(CURTYPE_PSEUDO, 8)
                                );

                        // Insert branching
                        rewriter.create<CondBrOp>(LOC, curTypeCondition,
                                /* if pC->curType == CURTYPE_PSEUDO */ blockCurTypePseudo,
                                /*                             else */ blockNotCurTypePseudo
                        );

                        { // if (pC->eCurType == CURTYPE_PSEUDO)
                            rewriter.setInsertionPointToStart(blockCurTypePseudo);
                            print(LOCL, "pC->eCurType == CURTYPE_PSEUDO");

                            // pReg = &aMem[pC->seekResult];
                            auto seekResultAddress = rewriter.create<GEPOp>
                                    (LOC, T::i32PtrTy, pCValue,
                                     ValueRange{
                                             constants(0, 32), // &*pC
                                             constants(10, 32) // &pc->seekResult
                                     });

                            auto seekResultValue = rewriter.create<LoadOp>(LOC, seekResultAddress);

                            auto pRegValue = rewriter.create<GEPOp>
                                    (LOC, T::sqlite3_valuePtrTy, aMem,
                                     ValueRange{
                                             seekResultValue, // We want &aMem[pC->seekResult]
                                     });

                            { // assert(pReg->flags & MEM_Blob);
                                auto flagsAddr = rewriter.create<GEPOp>
                                        (LOC, T::i16PtrTy, pRegValue, ValueRange {
                                            constants(0, 32),
                                            constants(1, 32)
                                        });
                                auto flags = rewriter.create<LoadOp>(LOC, flagsAddr);
                                auto flagsAndBlob = rewriter.create<AndOp>
                                        (LOC, flags, constants(MEM_Blob, 16));
                                auto flagsAndBlobNotNull = rewriter.create<ICmpOp>
                                        (LOC, Pred::ne, flagsAndBlob, constants(0, 16));
                                myAssert(LOCL, flagsAndBlobNotNull);
                            } // end assert(pReg->flags & MEM_Blob);

                            // pC->payloadSize = pC->szRow = pReg->n;
                            auto pRegNAddress = rewriter.create<GEPOp>
                                    (LOC, T::i32PtrTy, pRegValue,
                                     ValueRange{
                                             constants(0, 32), // &*pReg
                                             constants(4, 32)  // &pReg->n
                                     });
                            auto pRegNValue = rewriter.create<LoadOp>(LOC, pRegNAddress);
                            rewriter.create<StoreOp>(LOC, pRegNValue, payloadSizeAddress);
                            rewriter.create<StoreOp>(LOC, pRegNValue, szRowAddress);

                            /// pC->aRow = (u8 *) pReg->z;
                            // Get the address of pReg->z (gives an u8**)
                            auto pRegZAddress = rewriter.create<GEPOp>
                                    (LOC, T::i8PtrPtrTy, pRegValue,
                                     ValueRange{
                                             constants(0, 32), // &*pReg
                                             constants(5, 32)  // &pReg->z
                                     });
                            auto pRegZValue = rewriter.create<LoadOp>(LOC, pRegZAddress);
                            rewriter.create<StoreOp>(LOC, pRegZValue, pCaRowAddress);
                            /*
                            // // Cast it to an i64* (u8** -> i64*)
                            // auto castPRegZAddress = rewriter.create<BitcastOp>(LOC, T::i64PtrTy, pRegZAddress);
                            // Load the value of pReg->z (i64)
                            // auto pRegZValue = rewriter.create<LoadOp>(LOC, castPRegZAddress);

                            // Cast it to an i64* (u8* -> i64*)
                            // auto castpCaRowAddress = rewriter.create<BitcastOp>(LOC, T::i64PtrTy, pCaRowAddress);

                            // Store the value of pReg->z in pC->aRow
                            // rewriter.create<StoreOp>(LOC, pRegZValue, castpCaRowAddress);
                             */

                            // Branch out
                            rewriter.create<BranchOp>(LOC, blockEndCacheNeStatusCacheCtr);
                        } // end if (pC->eCurType == CURTYPE_PSEUDO)
                        { // else of if (pC->eCurType == CURTYPE_PSEUDO)
                            rewriter.setInsertionPointToStart(blockNotCurTypePseudo);
                            // print(LOCL, "NOT pC->eCurType == CURTYPE_PSEUDO");

                            rewriter.create<CallOp>(LOC, f_sqlite3VdbeMemSetNull, ValueRange{
                                pDest
                            });

                            rewriter.create<BranchOp>(LOC, blockColumnEnd);
                        } // end else of if pC->eCurType == CURTYPE_PSEUDO
                    } // end if pC->nullRow
                    { // else of if pC->nullRow
                        rewriter.setInsertionPointToStart(blockNotNullRow);
                        // print(LOCL, "NOT pC->nullRow");

                        // Get the address of the cursor from pC->uc.pCursor
                        auto pCrsrAddress = rewriter.create<GEPOp>
                                (LOC, T::VdbeCursorPtrPtrTy, pCValue,
                                 ValueRange{
                                         CONSTANT_INT(0, 32),  // &pC
                                         CONSTANT_INT(12, 32), // &pc->uc
                                         CONSTANT_INT(0, 32)   // pCursor (first field of union-struct)
                                 });

                        // Load the value of the pointer (address of the cursor)
                        auto pCrsrAsCursor = rewriter.create<LoadOp>(LOC, pCrsrAddress);
                        // Convert this VdbeCursor* to BtCursor* (VdbeCursor is a "parent type")
                        auto pCrsr = rewriter.create<BitcastOp>(LOC, T::BtCursorPtrTy, pCrsrAsCursor);

                        { // assert eCurType == CURTYPE_BTREE
                            // Get the address of pC->curType
                            auto curTypeAddr = rewriter.create<GEPOp>
                                    (LOC, T::i8PtrTy, pCValue, ValueRange{
                                            constants(0, 32), // *pC
                                            constants(0, 32)  // curType is the first field
                                    });

                            auto curTypeValue = rewriter.create<LoadOp>(LOC, curTypeAddr);
                            auto curTypeIsBtree = rewriter.create<ICmpOp>
                                    (LOC, ICmpPredicate::eq,
                                        curTypeValue, constants(CURTYPE_BTREE, 8)
                                    );
                            myAssert(LOCL, curTypeIsBtree);

                            auto pCrsrNotNull = rewriter.create<ICmpOp>
                                    (LOC, ICmpPredicate::ne,
                                            pCrsr, constants(T::BtCursorPtrTy, (i8*)0)
                                    );
                            myAssert(LOCL, pCrsrNotNull);

                            { // assert(sqlite3BtreeCursorIsValid(pCrsr));
                                auto isValid = rewriter.create<mlir::LLVM::CallOp>
                                        (LOC, f_sqlite3BtreeCursorIsValid, ValueRange { pCrsr }).getResult(0);
                                myAssert(LOCL, isValid);
                            } // end assert(sqlite3BtreeCursorIsValid(pCrsr));
                        }

                        //// pC->payloadSize = sqlite3BtreePayloadSize(pCrsr);
                        auto payloadSize = rewriter.create<CallOp>
                                (LOC, f_sqlite3BtreePayloadSize, ValueRange{
                                         pCrsr
                                 }).getResult(0);

                        // Store the result in pC->payloadSize
                        rewriter.create<StoreOp>(LOC, payloadSize, payloadSizeAddress);

                        //// pC->aRow = sqlite3BtreePayloadFetch(pCrsr, &pC->szRow);
                        auto payload = rewriter.create<CallOp>
                                (LOC, f_sqlite3BtreePayloadFetch, ValueRange {
                                         pCrsr,
                                         szRowAddress
                                 }).getResult(0);

                        // Store the result in pC->aRow
                        rewriter.create<StoreOp>(LOC, payload, pCaRowAddress);

                        /* TODO if (pC->payloadSize > (u32) db->aLimit[SQLITE_LIMIT_LENGTH]) {
                         * goto too_big;
                         * }
                         */

                        rewriter.create<BranchOp>(LOC, blockEndCacheNeStatusCacheCtr);
                    } // end else of if pC->nullRow == 0

                    { // After condition (but still in cacheStatus != cacheCtr)
                        rewriter.setInsertionPointToStart(blockEndCacheNeStatusCacheCtr);

                        print(LOCL, "After if rowNull");
                        {
                            static size_t counter = 0;
                            auto counterAddr = constants(T::i64PtrTy, &counter);
                            auto curValue = rewriter.create<LoadOp>(LOC, counterAddr);
                            auto newValue = rewriter.create<AddOp>(LOC, curValue, constants(1, 64));
                            rewriter.create<StoreOp>(LOC, newValue, counterAddr);
                            print(LOCL, constants(T::i64PtrTy, &counter), "Counter");
                        }

                        //// pC->cacheStatus = p->cacheCtr;
                        auto newCacheCtr = rewriter.create<LoadOp>(LOC, cacheCtrAddr);
                        rewriter.create<StoreOp>(LOC, newCacheCtr, cacheStatusAddr);

                        print(LOCL, newCacheCtr, "CacheCtr");

                        /// pC->iHdrOffset = getVarint32(pC->aRow, aOffset[0]);
                        auto aRow = rewriter.create<LoadOp>(LOC, pCaRowAddress);
                        generate_getVarint32(/* A = */ aRow, /* B = */ aOffset, /* Result to */ iHdrOffsetAddr);

                        print(LOCL, aRow, "varInt32");

                        rewriter.create<StoreOp>(LOC, constants(0, 16), nHdrParsedAddr);

                        /// if (pC->szRow < aOffset[0])
                        auto curBlock = rewriter.getBlock();
                        auto blockSzRowLessThanAOffset = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                        auto blockSzRowNotLessThanAOffset = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                        auto blockAfterSZRowLessThanAOffset = SPLIT_BLOCK; GO_BACK_TO(curBlock);

                        auto szRow = rewriter.create<LoadOp>(LOC, szRowAddress);
                        auto aOffset0 = rewriter.create<LoadOp>(LOC, aOffset);

                        auto szRowLessThanAOffset = rewriter.create<ICmpOp>
                                (LOC, ICmpPredicate::ult,
                                        szRow, aOffset0
                                );
                        rewriter.create<CondBrOp>(LOC, szRowLessThanAOffset,
                                                  blockSzRowLessThanAOffset,
                                                  blockSzRowNotLessThanAOffset);

                        { // if (pC->szRow < aOffset[0])
                            rewriter.setInsertionPointToStart(blockSzRowLessThanAOffset);
                            print(LOCL, "pC->szRow < aOffset[0]");

                            /// pC->aRow = (u8*)nullptr;
                            rewriter.create<StoreOp>(LOC, constants(T::i8PtrTy, (u8 *) nullptr), pCaRowAddress);
                            /// pC->szRow = 0;
                            rewriter.create<StoreOp>(LOC, constants(0, 32), szRowAddress);

                            // TODO: Add corrupt database check

                            rewriter.create<BranchOp>(LOC, blockAfterSZRowLessThanAOffset);
                        } // end if (pC->szRow < aOffset[0])
                        { // else of if (pC->szRow < aOffset[0])
                            rewriter.setInsertionPointToStart(blockSzRowNotLessThanAOffset);
                            print(LOCL, "NOT pC->szRow < aOffset[0]");

                            // zData = pC->aRow;
                            // print(LOCL, aRow, "aRowContent");
                            rewriter.create<StoreOp>(LOC, aRow, zDataAddress);

                            // print(LOCL, "Going to ReadHeader");
                            auto brOp = rewriter.create<BranchOp>(LOC, blockAfterSZRowLessThanAOffset);
                            operationToUpdateReadHeader = (Operation*)brOp;

                        } // end else of if (pC->szRow < aOffset[0])

                        rewriter.setInsertionPointToStart(blockAfterSZRowLessThanAOffset);
                        rewriter.create<BranchOp>(LOC, blockAfterCacheStatusNeqCachePtr);
                    } // end else of if (pC->szRow < aOffset[0])
                }

                { // After cacheStatus != cachePtr
                    rewriter.setInsertionPointToStart(blockAfterCacheStatusNeqCachePtr);

                    auto nHdrParsed = rewriter.create<LoadOp>(LOC, nHdrParsedAddr);
                    auto nHdrParsedLtP2 = rewriter.create<ICmpOp>
                            (LOC, ICmpPredicate::ule,
                             nHdrParsed,
                             constants(colOp.columnAttr().getValue().getLimitedValue(), 16)
                            );

                    auto curBlock = rewriter.getBlock();
                    auto blockNHdrParsedLtP2 = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                    auto blockNHdrParsedNotLtP2 = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                    auto blockAfterNHdrParsedLtP2 = SPLIT_BLOCK; GO_BACK_TO(curBlock);

                    rewriter.create<CondBrOp>(LOC, nHdrParsedLtP2,
                                              blockNHdrParsedLtP2,
                                              blockNHdrParsedNotLtP2
                    );
                    { // if (pC->nHdrParsed <= p2) (2738)
                        rewriter.setInsertionPointToStart(blockNHdrParsedLtP2);

                        // print(LOCL, "pC->nHdrParsed <= p2");

                        auto iHdrOffset = rewriter.create<LoadOp>(LOC, iHdrOffsetAddr);
                        auto aOffset0 = rewriter.create<LoadOp>(LOC, aOffset);
                        auto iHdrOffsetLtAOffset0 = rewriter.create<ICmpOp>(LOC, ICmpPredicate::ult,
                                                                            iHdrOffset,
                                                                            aOffset0);

                        auto curBlock = rewriter.getBlock();
                        auto blockAfterHdrOffsetLtAOffset0 = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                        auto blockHdrOffsetNotLtAOffset0 = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                        auto blockHdrOffsetLtAOffset0 = SPLIT_BLOCK; GO_BACK_TO(curBlock);

                        rewriter.create<CondBrOp>(LOC, iHdrOffsetLtAOffset0,
                                                  blockHdrOffsetLtAOffset0,
                                                  blockHdrOffsetNotLtAOffset0);

                        { // if (pC->iHdrOffset < aOffset[0])
                            rewriter.setInsertionPointToStart(blockHdrOffsetLtAOffset0);

                            // print(LOCL, "pC->iHdrOffset < aOffset[0]");

                            // if (pC->aRow == 0)
                            auto aRow = rewriter.create<LoadOp>(LOC, pCaRowAddress);
                            auto null = constants(T::i8PtrTy, (u8 *) nullptr);
                            auto aRowIsNull = rewriter.create<ICmpOp>(LOC, ICmpPredicate::eq, aRow, null);

                            auto curBlock = rewriter.getBlock();
                            auto blockAfterRowIsNull = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                            auto blockRowIsNotNull = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                            auto blockRowIsNull = SPLIT_BLOCK; GO_BACK_TO(curBlock);

                            rewriter.create<CondBrOp>(LOC, aRowIsNull,
                                                      blockRowIsNull,
                                                      blockRowIsNotNull);

                            { // if (pC->aRow == 0)
                                rewriter.setInsertionPointToStart(blockRowIsNull);
                                print(LOCL, "TODO: memset(&sMem, 0, sizeof(sMem));");
                                // TODO: memset(&sMem, 0, sizeof(sMem));
                                // TODO: Lines 144-147
                                rewriter.create<BranchOp>(LOC, blockAfterRowIsNull);
                            } // end of if (pC->aRow == 0)
                            { // else of if (pC->aRow == 0)
                                rewriter.setInsertionPointToStart(blockRowIsNotNull);
                                // print(LOCL, "zDataAddress = pC->aRow");
                                rewriter.create<StoreOp>(LOC, aRow, zDataAddress);
                                rewriter.create<BranchOp>(LOC, blockAfterRowIsNull);
                            } // end of else of if (pC->aRow == 0)

                            rewriter.setInsertionPointToStart(blockAfterRowIsNull);

                            // create label op_column_read_header:
                            curBlock = rewriter.getBlock();
                            auto blockOpColumnReadHeader = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                            rewriter.create<BranchOp>(LOC, blockOpColumnReadHeader);

                            assert(operationToUpdateReadHeader);
                            operationToUpdateReadHeader->getBlockOperands()[0].set(blockOpColumnReadHeader);

                            rewriter.setInsertionPointToStart(blockOpColumnReadHeader);
                            // i = pC->nHdrParsed;
                            auto iAddr = rewriter.create<AllocaOp>(LOC, T::i32PtrTy, constants(1, 32), 0);
                            auto iInitialValue_u16 = rewriter.create<LoadOp>(LOC, nHdrParsedAddr);
                            auto iInitialValue = rewriter.create<ZExtOp>(LOC, T::i32Ty, iInitialValue_u16);
                            rewriter.create<StoreOp>(LOC, iInitialValue, iAddr);
                            // (u64) offset64 = aOffset[i];
                            auto offset64Addr = rewriter.create<AllocaOp>(LOC, T::i64PtrTy, constants(1, 32), 0);
                            auto offset64InitialValueAddr = rewriter.create<GEPOp>
                                    (LOC, T::i64PtrTy, aOffset, ValueRange{
                                            iInitialValue // &aOffset[i]
                                    });
                            auto offset64InitialValue_32 = rewriter.create<LoadOp>(LOC, offset64InitialValueAddr);
                            auto offset64InitialValue = rewriter.create<ZExtOp>(LOC, T::i64Ty, offset64InitialValue_32);
                            rewriter.create<StoreOp>(LOC, offset64InitialValue, offset64Addr);
                            // zHdr = zData + pC->iHdrOffset;
                            auto zData = rewriter.create<LoadOp>(LOC, zDataAddress);
                            auto iHdrOffset = rewriter.create<LoadOp>(LOC, iHdrOffsetAddr);
                            // (i8*)zHdr + (i32)pc->iHdrOffset <=> &zHdr[pc->iHdrOffset]
                            // Allocate a zHdr variable
                            auto zHdrAddr = rewriter.create<AllocaOp>(LOC, T::i8PtrPtrTy, constants(1, 32), 0);
                            // Find initial value for zHdr
                            auto zHdrInitialValue = rewriter.create<GEPOp>(LOC, T::i8PtrTy, zData, ValueRange{iHdrOffset});
                            // Store initial value for zHdr
                            rewriter.create<StoreOp>(LOC, zHdrInitialValue, zHdrAddr);
                            /// zEndHdr = zData + aOffset[0];
                            auto aOffset0 = rewriter.create<LoadOp>(LOC, aOffset);
                            // (i8*)zData + (u32)(aOffset[0]) <=> &zData[aOffset[0]]
                            auto zEndHdrValue = rewriter.create<GEPOp>(LOC, T::i8PtrTy, zData, ValueRange{aOffset0});

                            print(LOCL, iInitialValue, "Initial i:");
                            print(LOCL, offset64InitialValue, "initial offset64");
                            print(LOCL, zHdrInitialValue, "zHdr");
                            print(LOCL, zEndHdrValue, "zEndHdr");

                            /* DO WHILE */
                            curBlock = rewriter.getBlock();
                            auto blockAfterDoWhile = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                            auto blockDoWhileCondition = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                            auto blockDoWhileBlock = SPLIT_BLOCK; GO_BACK_TO(curBlock);

                            // Start doing the do-while action
                            rewriter.create<BranchOp>(LOC, blockDoWhileBlock);

                            { // Do-while action block
                                rewriter.setInsertionPointToStart(blockDoWhileBlock);
                                // print(LOCL, "Do-while");
                                auto curBlock = rewriter.getBlock();
                                auto blockIfLt80 = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                                auto blockIfNotLt80 = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                                auto blockAfterIfLt80 = SPLIT_BLOCK; GO_BACK_TO(curBlock);

                                // Get address to pC->aType[i]
                                auto iValue = rewriter.create<LoadOp>(LOC, iAddr);
                                auto aTypeIAddr = rewriter.create<GEPOp>
                                        (LOC, T::i32PtrTy, pCValue, ValueRange{
                                                constants(0, 32),  // *pC
                                                constants(23, 32), // &pC->aType
                                                iValue             // &pC->aType[i]
                                        });
                                // Get zHdr[0] and convert it to an i32
                                auto zHdr = rewriter.create<LoadOp>(LOC, zHdrAddr);
                                auto zHdr0_u8 = rewriter.create<LoadOp>(LOC, zHdr);
                                auto zHdr0 = rewriter.create<ZExtOp>(LOC, T::i32Ty, zHdr0_u8);

                                // t = zHdr[0]
                                rewriter.create<StoreOp>(LOC, zHdr0, tAddr);
                                // pC->aType[i] = zHdr[0]
                                rewriter.create<StoreOp>(LOC, zHdr0, aTypeIAddr);

                                auto aTypeLt80 = rewriter.create<ICmpOp>
                                        (LOC, ICmpPredicate::sgt,
                                            zHdr0_u8, constants(-1, 8)
                                        );

                                rewriter.create<CondBrOp>(LOC, aTypeLt80, blockIfLt80, blockIfNotLt80);
                                { // if ((pC->aType[i] = t = zHdr[0]) < 0x80)
                                    rewriter.setInsertionPointToStart(blockIfLt80);

                                    /// zHdr++ <=> zHdr = zHdr = &zHdr[1]
                                    auto zHdrPlusPlus = rewriter.create<GEPOp>
                                            (LOC, T::i8PtrTy, zHdr, ValueRange{
                                                constants(1, 32)
                                            });
                                    rewriter.create<StoreOp>(LOC, zHdrPlusPlus, zHdrAddr);

                                    /// offset64 += sqlite3VdbeOneByteSerialTypeLen(t);
                                    // Call
                                    auto t_u32 = rewriter.create<LoadOp>(LOC, tAddr);
                                    auto t = rewriter.create<TruncOp>(LOC, T::i8Ty, t_u32);
                                    auto result_u8 = rewriter.create<CallOp>
                                            (LOC, f_sqlite3VdbeOneByteSerialTypeLen,
                                                ValueRange{t}
                                            ).getResult(0);
                                    auto result = rewriter.create<ZExtOp>(LOC, T::i64Ty, result_u8);

                                    // Get current value of offset64
                                    auto offset64 = rewriter.create<LoadOp>(LOC, offset64Addr);
                                    // Add result + offset64
                                    auto newOffset64 = rewriter.create<AddOp>(LOC, offset64, result);
                                    // Store new value in variable
                                    rewriter.create<StoreOp>(LOC, newOffset64, offset64Addr);

                                    rewriter.create<BranchOp>(LOC, blockAfterIfLt80);
                                } // end if ((pC->aType[i] = t = zHdr[0]) < 0x80)
                                { // else of if ((pC->aType[i] = t = zHdr[0]) < 0x80)
                                    rewriter.setInsertionPointToStart(blockIfNotLt80);

                                    /// zHdr += sqlite3GetVarint32(zHdr, &t) <=> zHdr = &zHdr[sqlite...]
                                    // Get current value of zHdr
                                    auto zHdrValue = rewriter.create<LoadOp>(LOC, zHdrAddr);
                                    // Call function
                                    auto result = rewriter.create<CallOp>
                                            (LOC, f_sqlite3GetVarint32, ValueRange{
                                                    zHdrValue, // zHdr
                                                    tAddr      // &t
                                            }).getResult(0);

                                    // Add result to zHdr
                                    auto newZHdrValue = rewriter.create<GEPOp>
                                            (LOC, T::i8PtrTy, zHdrValue,
                                             ValueRange{
                                                     result // &zHdr[result]
                                             });

                                    // Store new value of zHdr
                                    rewriter.create<StoreOp>(LOC, newZHdrValue, zHdrAddr);

                                    /// pC->aType[i] = t
                                    auto tValue = rewriter.create<LoadOp>(LOC, tAddr);
                                    rewriter.create<StoreOp>(LOC, tValue, aTypeIAddr);

                                    /// offset64 += sqlite3VdbeSerialTypeLen(t);
                                    auto offset64Value = rewriter.create<LoadOp>(LOC, offset64Addr);
                                    auto result_u32 = rewriter.create<CallOp>
                                            (LOC, f_sqlite3VdbeSerialTypeLen,
                                                ValueRange{tValue}
                                            ).getResult(0);
                                    result = rewriter.create<ZExtOp>(LOC, T::i64Ty, result_u32);
                                    auto newOffset64Value = rewriter.create<AddOp>(LOC, offset64Value, result);
                                    rewriter.create<StoreOp>(LOC, newOffset64Value, offset64Addr);

                                    rewriter.create<BranchOp>(LOC, blockAfterIfLt80);
                                } // end else of if ((pC->aType[i] = t = zHdr[0]) < 0x80)
                                rewriter.setInsertionPointToStart(blockAfterIfLt80);

                                iValue = rewriter.create<LoadOp>(LOC, iAddr);
                                // i = i + 1
                                auto newIValue = rewriter.create<AddOp>(LOC, iValue, constants(1, 32));
                                // i = newValueOfI (from ++i)
                                rewriter.create<StoreOp>(LOC, newIValue, iAddr);

                                // aOffset[++i] = (u32) (offset64 & 0xffffffff);
                                auto Oxffffffff = constants(0xffffffff, 64);
                                auto offset64Value = rewriter.create<LoadOp>(LOC, offset64Addr);
                                auto andedValue_u64 = rewriter.create<AndOp>(LOC, Oxffffffff, offset64Value);
                                auto andedValue = rewriter.create<TruncOp>(LOC, T::i32Ty, andedValue_u64);

                                auto aOffsetPlusPlusIAddr = rewriter.create<GEPOp>
                                        (LOC, T::i32PtrTy, aOffset, ValueRange{
                                                newIValue // &aOffset[++i]
                                        });

                                // aOffset[newI] = ...
                                rewriter.create<StoreOp>(LOC, andedValue, aOffsetPlusPlusIAddr);

                                rewriter.create<BranchOp>(LOC, blockDoWhileCondition);
                            } // End do-while action block
                            { // Do-while condition block
                                rewriter.setInsertionPointToStart(blockDoWhileCondition);

                                // The value of p2
                                auto p2 = colOp.columnAttr().getSInt();
                                // Load the value of i
                                auto iValue = rewriter.create<LoadOp>(LOC, iAddr);
                                // Cond. 1: i <= p2
                                auto iLessThanP2 = rewriter.create<ICmpOp>
                                        (LOC, ICmpPredicate::sle,
                                            iValue, constants(p2, 32)
                                        );
                                // Cond. 2: zHdr < zEndHdr
                                auto zHdrValue = rewriter.create<LoadOp>(LOC, zHdrAddr);
                                auto zHdrAsInt = rewriter.create<PtrToIntOp>(LOC, T::i64Ty, zHdrValue);
                                auto zEndHdrAsInt = rewriter.create<PtrToIntOp>(LOC, T::i64Ty, zEndHdrValue);
                                auto zHdrLessThanEndHdr = rewriter.create<ICmpOp>
                                        (LOC, ICmpPredicate::ult,
                                            zHdrAsInt, zEndHdrAsInt
                                        );
                                // Both conditions and-combined
                                /// CONDITION: while (i <= p2 && zHdr < zEndHdr);
                                auto doWhileCondition = rewriter.create<AndOp>(LOC, iLessThanP2, zHdrLessThanEndHdr);

                                // Jump back to do-while block if condition else exit
                                rewriter.create<CondBrOp>(LOC, doWhileCondition,
                                                          blockDoWhileBlock,
                                                          blockAfterDoWhile);
                            } // End Do-while condition block

                            rewriter.setInsertionPointToStart(blockAfterDoWhile);

                            auto zHdrValue = rewriter.create<LoadOp>(LOC, zHdrAddr);
                            auto zHdrAsInt = rewriter.create<PtrToIntOp>(LOC, T::i64Ty, zHdrValue);
                            auto zEndHdrAsInt = rewriter.create<PtrToIntOp>(LOC, T::i64Ty, zEndHdrValue);
                            auto offset64Value = rewriter.create<LoadOp>(LOC, offset64Addr);
                            auto payloadSize_u32 = rewriter.create<LoadOp>(LOC, payloadSizeAddress);
                            auto payloadSize = rewriter.create<ZExtOp>(LOC, T::i64Ty, payloadSize_u32);

                            print(LOCL, zHdrValue, "ZHdr");
                            print(LOCL, zEndHdrValue, "ZEndHdr");
                            print(LOCL, offset64Value, "offset64");
                            print(LOCL, payloadSize, "payloadSize");

                            /* A */ auto zHdrGeZEndHdr = rewriter.create<ICmpOp>
                                    (LOC, ICmpPredicate::uge,
                                        zHdrAsInt, zEndHdrAsInt
                                    );
                            /* B */ auto zHdrGtZEndHdr = rewriter.create<ICmpOp>
                                    (LOC, ICmpPredicate::ugt,
                                        zHdrAsInt, zEndHdrAsInt
                                    );
                            /* C */ auto offset64NePayloadSize = rewriter.create<ICmpOp>
                                    (LOC, ICmpPredicate::ne,
                                        offset64Value, payloadSize
                                    );
                            /* D */ auto offset64GtPayloadSize = rewriter.create<ICmpOp>
                                    (LOC, ICmpPredicate::ugt,
                                        offset64Value, payloadSize
                                    );

                            auto bOrC = rewriter.create<OrOp>(LOC, zHdrGtZEndHdr, offset64NePayloadSize);
                            auto aAndBOrC = rewriter.create<AndOp>(LOC, zHdrGeZEndHdr, bOrC);
                            auto aAndBOrCOrD = rewriter.create<OrOp>(LOC, aAndBOrC, offset64GtPayloadSize);

                            curBlock = rewriter.getBlock();
                            auto blockAfterCondition = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                            auto blockConditionTrue = SPLIT_BLOCK; GO_BACK_TO(curBlock);

                            rewriter.create<CondBrOp>(LOC, aAndBOrCOrD, blockConditionTrue, blockAfterCondition);

                            { // if ((zHdr >= zEndHdr && (zHdr > zEndHdr || offset64 != pC->payloadSize)) || (offset64 > pC->payloadSize)
                                rewriter.setInsertionPointToStart(blockConditionTrue);

                                auto curBlock = rewriter.getBlock();
                                auto blockAfterAOffset0Eq0 = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                                auto blockNotAOffset0Eq0 = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                                auto blockAOffset0Eq0 = SPLIT_BLOCK; GO_BACK_TO(curBlock);

                                auto aOffset0Value = rewriter.create<LoadOp>(LOC, aOffset);
                                auto aOffset0Eq0 = rewriter.create<ICmpOp>
                                        (LOC, ICmpPredicate::eq,
                                            aOffset0Value, constants(0, 32)
                                        );
                                rewriter.create<CondBrOp>(LOC, aOffset0Eq0, blockAOffset0Eq0, blockNotAOffset0Eq0);

                                { // if (aOffset[0] == 0)
                                    rewriter.setInsertionPointToStart(blockAOffset0Eq0);

                                    rewriter.create<StoreOp>(LOC, constants(0, 32), iAddr);
                                    rewriter.create<StoreOp>(LOC, zEndHdrValue, zHdrAddr);

                                    rewriter.create<BranchOp>(LOC, blockAfterAOffset0Eq0);
                                } // end if (aOffset[0] == 0)
                                { // else of if (aOffset[0] == 0)
                                    rewriter.setInsertionPointToStart(blockNotAOffset0Eq0);

                                    // TODO: if (pC->aRow == 0) sqlite3VdbeMemRelease(&sMem);
                                    { // goto op_column_corrupt
                                        print(LOCL, "Error: goto op_column_corrupt");
                                        myAssert(LOCL, constants(0, 1));
                                    } // end goto op_column_corrupt

                                    rewriter.create<BranchOp>(LOC, blockAfterAOffset0Eq0);
                                } // end else of if (aOffset[0] == 0)

                                rewriter.setInsertionPointToStart(blockAfterAOffset0Eq0);
                                rewriter.create<BranchOp>(LOC, blockAfterCondition);

                            }

                            rewriter.setInsertionPointToStart(blockAfterCondition);

                            /// pC->nHdrParsed = (u16)i
                            auto iVal_i32 = rewriter.create<LoadOp>(LOC, iAddr);
                            auto iVal = rewriter.create<TruncOp>(LOC, T::i16Ty, iVal_i32);
                            rewriter.create<StoreOp>(LOC, iVal, nHdrParsedAddr);

                            /// pC->iHdrOffset = (u32)(zHdr - zData)
                            auto zHdrVal = rewriter.create<LoadOp>(LOC, zHdrAddr);
                            zHdrAsInt = rewriter.create<PtrToIntOp>(LOC, T::i64Ty, zHdrVal);
                            auto zDataVal = rewriter.create<LoadOp>(LOC, zDataAddress);
                            auto zDataAsInt = rewriter.create<PtrToIntOp>(LOC, T::i64Ty, zDataVal);
                            auto diff_u64 = rewriter.create<SubOp>(LOC, zHdrAsInt, zDataAsInt);
                            auto diff = rewriter.create<TruncOp>(LOC, T::i32Ty, diff_u64);
                            rewriter.create<StoreOp>(LOC, diff, iHdrOffsetAddr);

                            curBlock = rewriter.getBlock();
                            auto blockARowIsNull = SPLIT_BLOCK; GO_BACK_TO(curBlock);

                            // Load pC->aRow
                            auto aRowVal = rewriter.create<LoadOp>(LOC, pCaRowAddress);

                            // Check whether pC->aRow == 0
                            auto null2 = constants(T::i8PtrTy, (i8*)nullptr);
                            aRowIsNull = rewriter.create<ICmpOp>(LOC, ICmpPredicate::eq, aRowVal, null2);

                            // If pC->aRow == 0 go to newly created block, otherwise skip to blockAfterHdrOffsetLtAOffset0
                            rewriter.create<CondBrOp>(LOC, aRowIsNull, blockARowIsNull, blockAfterHdrOffsetLtAOffset0);
                            { // if (pC->aRow == 0)
                                rewriter.setInsertionPointToStart(blockARowIsNull);

                                print(LOCL, "TODO: sqlite3VdbeMemRelease(&sMem);");
                                // TODO: sqlite3VdbeMemRelease(&sMem);
                                // rewriter.create<CallOp>(LOC, f_sqlite3VdbeMemRelease, { sMemAddr });

                                rewriter.create<BranchOp>(LOC, blockAfterHdrOffsetLtAOffset0);
                            } // end if (pC->aRow == 0)
                        } // end if (pC->iHdrOffset < aOffset[0])
                        { // else of if (pC->iHdrOffset < aOffset[0])
                            rewriter.setInsertionPointToStart(blockHdrOffsetNotLtAOffset0);

                            /// t = 0
                            rewriter.create<StoreOp>(LOC, constants(0, 32), tAddr);

                            rewriter.create<BranchOp>(LOC, blockAfterHdrOffsetLtAOffset0);
                        } // end of else of if (pC->iHdrOffset < aOffset[0])
                        rewriter.setInsertionPointToStart(blockAfterHdrOffsetLtAOffset0);

                        curBlock = rewriter.getBlock();
                        // We are already in a condition that is nHdrParsed <= p2
                        // If the condition is false, we just jump out of that parent condition
                        auto blockNHdrParsedLtP2_2 = SPLIT_BLOCK; GO_BACK_TO(curBlock);

                        auto nHdrParsedVal = rewriter.create<LoadOp>(LOC, nHdrParsedAddr);
                        auto p2 = constants(colOp.columnAttr().getSInt(), 16);
                        auto nHdrLtP2 = rewriter.create<ICmpOp>(LOC, ICmpPredicate::sle, nHdrParsedVal, p2);
                        rewriter.create<CondBrOp>(LOC, nHdrLtP2, blockNHdrParsedLtP2_2, blockAfterNHdrParsedLtP2);
                        { // if (pC->nHdrParsed <= p2)
                            rewriter.setInsertionPointToStart(blockNHdrParsedLtP2_2);

                            auto p4TypeAddr = rewriter.create<GEPOp>
                                    (LOC, T::i8PtrTy, constants(T::VdbeOpPtrTy, pOp), ValueRange {
                                constants(0, 32),
                                constants(1, 32)
                            });
                            auto p4Type = rewriter.create<LoadOp>(LOC, p4TypeAddr);
                            auto p4IsMem = rewriter.create<ICmpOp>
                                (LOC, Pred::eq,
                                    p4Type, constants(P4_MEM, 8)
                                );

                            curBlock = rewriter.getBlock();
                            auto blockP4IsMem = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                            auto blockP4IsNotMem = SPLIT_BLOCK; GO_BACK_TO(curBlock);

                            rewriter.create<CondBrOp>(LOC, p4IsMem, blockP4IsMem, blockP4IsNotMem);
                            { // if (pOp->p4type == P4_MEM)
                                rewriter.setInsertionPointToStart(blockP4IsMem);

                                /// sqlite3VdbeMemShallowCopy(pDest, pOp->p4.pMem, MEM_Static);
                                rewriter.create<mlir::LLVM::CallOp>(LOC, f_sqlite3VdbeMemShallowCopy, ValueRange {
                                    pDest,
                                    constants(T::sqlite3_valuePtrTy, (sqlite3_value*)defaultValueAttr.getUInt()),
                                    constants(MEM_Static)
                                });

                                /// goto op_column_out;
                                rewriter.create<mlir::BranchOp>(LOC, blockColumnEnd);
                            } // end if (pOp->p4type == P4_MEM)
                            { // else of if (pOp->p4type == P4_MEM)
                                rewriter.setInsertionPointToStart(blockP4IsNotMem);

                                /// sqlite3VdbeMemSetNull(pDest);
                                rewriter.create<mlir::LLVM::CallOp>(LOC, f_sqlite3VdbeMemSetNull, ValueRange {
                                    pDest
                                });

                                /// goto op_column_out;
                                rewriter.create<mlir::BranchOp>(LOC, blockColumnEnd);
                            } // end else of if (pOp->p4type == P4_MEM)
                            /// (Replaced by goto out) rewriter.create<BranchOp>(LOC, blockAfterNHdrParsedLtP2);
                        } // end if (pC->nHdrParsed <= p2)
                    } // end if (pC->nHdrParsed <= p2)
                    { // else of if (pC->nHdrParsed <= p2)
                        rewriter.setInsertionPointToStart(blockNHdrParsedNotLtP2);

                        /// t = pC->aType[p2]
                        // Constant P2
                        auto p2 = constants(colOp.columnAttr().getSInt(), 32);
                        // Get &pC->aType[p2]
                        auto aTypeP2Addr = rewriter.create<GEPOp>
                                (LOC, T::i32PtrTy, pCValue, ValueRange{
                                        constants(0, 32),  // *pC
                                        constants(23, 32), // &pC->aType
                                        p2             // &pC->aType[p2]
                                });
                        // Load pC->aType[p2]
                        auto aTypeP2 = rewriter.create<LoadOp>(LOC, aTypeP2Addr);
                        // Store value into t
                        rewriter.create<StoreOp>(LOC, aTypeP2, tAddr);

                        rewriter.create<BranchOp>(LOC, blockAfterNHdrParsedLtP2);
                    } // end else (pC->nHdrParsed <= p2)

                    rewriter.setInsertionPointToStart(blockAfterNHdrParsedLtP2);

                    auto generateVdbeDynamic = [&ctx, &rewriter, llvmDialect, &constants](auto pDest) {
                        auto ty = LLVMType::getIntNTy(llvmDialect, 16);
                        auto attr = rewriter.getIntegerAttr(rewriter.getIntegerType(16), MEM_Agg | MEM_Dyn);
                        auto memAggOrMemDyn = rewriter.create<LLVM::ConstantOp>(LOC, ty, attr);
                        auto flagsAddr = rewriter.create<GEPOp>
                                (LOC, T::i16PtrTy, pDest, ValueRange{
                                        constants(0, 32), // &*pDest
                                        constants(1, 32)  // flags is second field of sqlite3_value
                                });
                        auto flags = rewriter.create<LoadOp>(LOC, flagsAddr);
                        Value anded = rewriter.create<mlir::LLVM::AndOp>(LOC, memAggOrMemDyn, flags);
                        auto andedIsNotNull = rewriter.create<ICmpOp>
                                (LOC, ICmpPredicate::eq,
                                 rewriter.create<mlir::LLVM::ConstantOp>
                                         (LOC, T::i16Ty, rewriter.getI16IntegerAttr(0)),
                                 anded
                                );
                        return andedIsNotNull;
                    };

                    auto vdbeMemDynamic = generateVdbeDynamic(pDest);

                    curBlock = rewriter.getBlock();
                    auto blockAfterVdbeMemDynamic = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                    auto blockVdbeMemDynamic = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                    rewriter.create<CondBrOp>(LOC, vdbeMemDynamic, blockVdbeMemDynamic, blockAfterVdbeMemDynamic);

                    { // if (VdbeMemDynamic(pDest))
                        rewriter.setInsertionPointToStart(blockVdbeMemDynamic);

                        /// sqlite3VdbeMemSetNull(pDest);
                        rewriter.create<CallOp>(LOC, f_sqlite3VdbeMemSetNull, ValueRange{pDest});

                        rewriter.create<BranchOp>(LOC, blockAfterVdbeMemDynamic);
                    } // end if (VdbeMemDynamic(pDest))

                    rewriter.setInsertionPointToStart(blockAfterVdbeMemDynamic);

                    { // assert(t == pC->aType[p2]);
                        auto tVal = rewriter.create<LoadOp>(LOC, tAddr);
                        // Constant P2
                        auto p2 = constants(colOp.columnAttr().getSInt(), 32);
                        // Get &pC->aType[p2]
                        auto aTypeP2Addr = rewriter.create<GEPOp>
                                (LOC, T::i32PtrTy, pCValue, ValueRange{
                                        constants(0, 32),  // *pC
                                        constants(23, 32), // &pC->aType
                                        p2             // &pC->aType[p2]
                                });
                        // Load pC->aType[p2]
                        auto aTypeP2 = rewriter.create<LoadOp>(LOC, aTypeP2Addr);
                        auto tEqATypeP2 = rewriter.create<ICmpOp>(LOC, ICmpPredicate::eq, tVal, aTypeP2);
                        myAssert(LOCL, tEqATypeP2);
                    } // end assert(t == pC->aType[p2]);

                    /// if (pC->szRow >= aOffset[p2 + 1])
                    curBlock = rewriter.getBlock();
                    auto blockAfterSzRowGeOffsetP2Plus1 = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                    auto blockSzRowNotGeOffsetP2Plus1 = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                    auto blockSzRowGeOffsetP2Plus1 = SPLIT_BLOCK; GO_BACK_TO(curBlock);

                    // Get pc->szRow
                    auto sZRowVal = rewriter.create<LoadOp>(LOC, szRowAddress);
                    // Get &aOffset[p2 + 1]
                    auto aOffsetP2Plus1Addr = rewriter.create<GEPOp>(LOC, T::i32PtrTy, aOffset, constants(columnAttr.getSInt() + 1, 32));
                    // Load aOffset[p2 + 1]
                    auto aOffsetP2Plus1 = rewriter.create<LoadOp>(LOC, aOffsetP2Plus1Addr);
                    // Check whether pC->szRow >= aOffset[p2 + 1]
                    auto sZRowGtOffsetP2Plus1 = rewriter.create<ICmpOp>(LOC, ICmpPredicate::sge, sZRowVal, aOffsetP2Plus1);
                    // Insert branching
                    rewriter.create<CondBrOp>(LOC, sZRowGtOffsetP2Plus1, blockSzRowGeOffsetP2Plus1, blockSzRowNotGeOffsetP2Plus1);

                    { // if (pC->szRow >= aOffset[p2 + 1])
                        rewriter.setInsertionPointToStart(blockSzRowGeOffsetP2Plus1);

                        /// zData = pC->aRow + aOffset[p2];
                        auto aRowValue = rewriter.create<LoadOp>(LOC, pCaRowAddress);
                        auto aRowAsInteger = rewriter.create<PtrToIntOp>(LOC, T::i64Ty, aRowValue);
                        auto aOffsetP2Addr = rewriter.create<GEPOp>(LOC, T::i32PtrTy, aOffset, constants(columnAttr.getSInt(), 32));
                        auto aOffsetP2_u32 = rewriter.create<LoadOp>(LOC, aOffsetP2Addr);
                        auto aOffsetP2 = rewriter.create<ZExtOp>(LOC, T::i64Ty, aOffsetP2_u32);
                        auto aRowPlusAOffsetP2 = rewriter.create<AddOp>(LOC, aRowAsInteger, aOffsetP2);
                        auto newZDataValue = rewriter.create<IntToPtrOp>(LOC, T::i8PtrTy, aRowPlusAOffsetP2);
                        rewriter.create<StoreOp>(LOC, newZDataValue, zDataAddress);

                        /// if (t < 12)
                        curBlock = rewriter.getBlock();
                        auto blockAfterTLt12 = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                        auto blockNotTLt12 = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                        auto blockTLt12 = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                        auto tValue = rewriter.create<LoadOp>(LOC, tAddr);
                        auto tLt12 = rewriter.create<ICmpOp>(LOC, ICmpPredicate::ult, tValue, constants(12, 32));
                        rewriter.create<CondBrOp>(LOC, tLt12, blockTLt12, blockNotTLt12);

                        { // if (t < 12)
                            rewriter.setInsertionPointToStart(blockTLt12);

                            rewriter.create<CallOp>(LOC, f_sqlite3VdbeSerialGet, ValueRange{
                                newZDataValue, tValue, pDest
                            });

                            rewriter.create<BranchOp>(LOC, blockAfterTLt12);
                        } // end if (t < 12)
                        { // else of if (t < 12)
                            rewriter.setInsertionPointToStart(blockNotTLt12);

                            /// u16 aFlag[] = {MEM_Blob, MEM_Str | MEM_Term};
                            auto aFlag = rewriter.create<AllocaOp>(LOC, T::i16PtrTy, constants(2, 32), 0);
                            rewriter.create<StoreOp>(LOC, constants(MEM_Blob, 16), aFlag);
                            auto aFlag1 = rewriter.create<GEPOp>(LOC, T::i16PtrTy, aFlag, constants(1, 32));
                            rewriter.create<StoreOp>(LOC, constants(MEM_Str | MEM_Term, 16), aFlag1);

                            auto tValue = rewriter.create<LoadOp>(LOC, tAddr);

                            /// pDest->n = len = (t - 12) / 2;
                            auto tMinus12 = rewriter.create<SubOp>(LOC, tValue, constants(12, 32));
                            auto tMinus12Over2 = rewriter.create<LShrOp>(LOC, tMinus12, constants(1, 32));
                            auto len = tMinus12Over2;

                            auto pDestNAddr = rewriter.create<GEPOp>(LOC, T::i32PtrTy, pDest, ValueRange {
                                constants(0, 32), // &*pDest
                                constants(4, 32)  // n is fourth field
                            });

                            rewriter.create<StoreOp>(LOC, tMinus12Over2, pDestNAddr);

                            auto pDestEncAddr = rewriter.create<GEPOp>(LOC, T::i8PtrTy, pDest, ValueRange {
                                constants(0, 32), // &*pDest
                                constants(2, 32)  // enc is second field
                            });
                            rewriter.create<StoreOp>(LOC, dbEnc, pDestEncAddr);

                            /// if (pDest->szMalloc < len + 2)
                            curBlock = rewriter.getBlock();
                            auto blockAfterSzMallocLtLenPlus2 = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                            auto blockNotSzMallocLtLenPlus2 = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                            auto blockSzMallocLtLenPlus2 = SPLIT_BLOCK; GO_BACK_TO(curBlock);

                            // Get &pDest->z (used later)
                            auto zAddr = rewriter.create<GEPOp>(LOC, T::i8PtrPtrTy, pDest,ValueRange {
                                    constants(0, 32), // &*pDest
                                    constants(5, 32)  // 6-th field of sqlite3_value
                            });
                            // Get &pDest->flags (used later)
                            auto flagsAddr = rewriter.create<GEPOp>(LOC, T::i16PtrTy, pDest, ValueRange{
                                    constants(0, 32), // &*pDest
                                    constants(1, 32)  // 1st field
                            });
                            // Get &pDest->szMalloc
                            auto szMallocAddr = rewriter.create<GEPOp>(LOC, T::i32PtrTy, pDest, ValueRange {
                                constants(0, 32), // &*pDest
                                constants(7, 32)  // 7-th field
                            });

                            // Load pDest->szMalloc
                            auto szMalloc = rewriter.create<LoadOp>(LOC, szMallocAddr);
                            // Compute len + 2
                            auto lenPlus2 = rewriter.create<AddOp>(LOC, len, constants(2, 32));
                            // Check whether pDest->szMalloc < len + 2
                            auto szMallocLtLenPlus2 = rewriter.create<ICmpOp>(LOC, ICmpPredicate::slt, szMalloc, lenPlus2);
                            // Insert branching
                            rewriter.create<CondBrOp>(LOC, szMallocLtLenPlus2, blockSzMallocLtLenPlus2, blockNotSzMallocLtLenPlus2);

                            { // if (pDest->szMalloc < len + 2)
                                rewriter.setInsertionPointToStart(blockSzMallocLtLenPlus2);

                                rewriter.create<StoreOp>(LOC, constants(MEM_Null, 16), flagsAddr);

                                auto result = rewriter.create<CallOp>(LOC, f_sqlite3VdbeMemGrow, ValueRange {
                                    pDest, lenPlus2, constants(0, 32)
                                }).getResult(0);

                                { // if (rc != 0) goto no_mem
                                    auto rcIsNull = rewriter.create<ICmpOp>(LOC, ICmpPredicate::eq, rc, constants(0, 32));
                                    myAssert(LOCL, rcIsNull);
                                } // end if (rc != 0) goto no_mem

                                rewriter.create<BranchOp>(LOC, blockAfterSzMallocLtLenPlus2);
                            } // end if (pDest->szMalloc < len + 2)
                            { // else of if (pDest->szMalloc < len + 2)
                                rewriter.setInsertionPointToStart(blockNotSzMallocLtLenPlus2);

                                /// pDest->z = pDest->zMalloc;
                                // Get &pDest->zMalloc
                                auto zMallocAddr = rewriter.create<GEPOp>(LOC, T::i8PtrPtrTy, pDest, ValueRange {
                                    constants(0, 32), // &*pDest
                                    constants(6, 32)  // 7-th field of sqlite3_value
                                });
                                // Load pDest->zMalloc
                                auto zMallocValue = rewriter.create<LoadOp>(LOC, zMallocAddr);

                                // Store pDest->zMalloc into pDest->z
                                rewriter.create<StoreOp>(LOC, zMallocValue, zAddr);

                                rewriter.create<BranchOp>(LOC, blockAfterSzMallocLtLenPlus2);

                            } // end else of (pDest->szMalloc < len + 2)

                            rewriter.setInsertionPointToStart(blockAfterSzMallocLtLenPlus2);

                            /// memcpy(pDest->z, zData, len);
                            auto len_u64 = rewriter.create<ZExtOp>(LOC, T::i64Ty, len);
                            auto zValue = rewriter.create<LoadOp>(LOC, zAddr);
                            auto zDataValue = rewriter.create<LoadOp>(LOC, zDataAddress);
                            rewriter.create<CallOp>(LOC, f_memCpy, ValueRange {
                                zValue, zDataValue, len_u64
                            });

                            /// pDest->z[len] = 0;
                            auto zLen = rewriter.create<GEPOp>(LOC, T::i8PtrTy, zValue, ValueRange{ len });
                            rewriter.create<StoreOp>(LOC, constants(0, 8), zLen);
                            /// pDest->z[len + 1] = 0;
                            auto lenPlus1 = rewriter.create<AddOp>(LOC, len, constants(1, 32));
                            auto zLenPlus1 = rewriter.create<GEPOp>(LOC, T::i8PtrTy, zValue, ValueRange { lenPlus1 });
                            rewriter.create<StoreOp>(LOC, constants(0, 8), zLenPlus1);
                            /// pDest->flags = aFlag[t & 1];
                            // Compute t & (u32)1
                            auto tAnd1 = rewriter.create<AndOp>(LOC, tValue, constants(1, 32));
                            // Get &aFlag[t & 1]
                            auto newFlagAddr = rewriter.create<GEPOp>(LOC, T::i16PtrTy, aFlag, (Value) tAnd1 );
                            // Load aFlag[t & 1]
                            auto newFlag = rewriter.create<LoadOp>(LOC, newFlagAddr);
                            // Store aFlag[t & 1] to pDest->flags
                            rewriter.create<StoreOp>(LOC, newFlag, flagsAddr);

                            rewriter.create<BranchOp>(LOC, blockAfterTLt12);
                        } // end else of if (t < 12)

                        rewriter.setInsertionPointToStart(blockAfterTLt12);
                        rewriter.create<BranchOp>(LOC, blockAfterSzRowGeOffsetP2Plus1);
                    } // end if (pC->szRow >= aOffset[p2 + 1])
                    { // else of if (pC->szRow >= aOffset[p2 + 1])
                        rewriter.setInsertionPointToStart(blockSzRowNotGeOffsetP2Plus1);

                        /// pDest->enc = encoding;
                        auto pDestEncAddr = rewriter.create<GEPOp>(LOC, T::i8PtrTy, pDest, ValueRange {
                                constants(0, 32), // &*pDest
                                constants(2, 32)  // enc is second field
                        });
                        rewriter.create<StoreOp>(LOC, dbEnc, pDestEncAddr);

                        // (pOp->p5 & (OPFLAG_LENGTHARG | OPFLAG_TYPEOFARG)) != 0
                        auto p5AndLengthArgOrTypeOfArg = colOp.flagsAttr().getUInt() & (OPFLAG_LENGTHARG | OPFLAG_TYPEOFARG);
                        auto p5AndLengthArgOrTypeOfArgNotNull = constants(p5AndLengthArgOrTypeOfArg == 0 ? 0 : 1, 1);
                        auto condC = p5AndLengthArgOrTypeOfArgNotNull;

                        // ((t >= 12 && (t & 1) == 0) || (pOp->p5 & OPFLAG_TYPEOFARG) != 0)
                        //// (t & 1) == 0
                        auto tValue = rewriter.create<LoadOp>(LOC, tAddr);
                        auto tAnd1 = rewriter.create<AndOp>(LOC, tValue, constants(1, 32));
                        auto tAnd1IsNull = rewriter.create<ICmpOp>(LOC, ICmpPredicate::eq, tAnd1, constants(0, 32));
                        //// t >= 12
                        auto tGe12 = rewriter.create<ICmpOp>(LOC, ICmpPredicate::sge, tValue, constants(12, 32));
                        //// ((t >= 12 && (t & 1) == 0)
                        auto condA = rewriter.create<AndOp>(LOC, tGe12, tAnd1IsNull);
                        //// (pOp->p5 & OPFLAG_TYPEOFARG) != 0)
                        auto p5AndTypeOfArg = colOp.flagsAttr().getUInt() & OPFLAG_TYPEOFARG;
                        auto p5AndTypeOfArgNotNull = p5AndTypeOfArg == 0 ? 0 : 1;
                        auto condB = constants(p5AndTypeOfArgNotNull, 1);
                        //// ((t >= 12 && (t & 1) == 0) || (pOp->p5 & OPFLAG_TYPEOFARG) != 0)
                        auto condAOrCondB = rewriter.create<OrOp>(LOC, condA, condB);

                        auto condCAnd_condAOrCondB = rewriter.create<AndOp>(LOC, condC, condAOrCondB);

                        auto len = rewriter.create<CallOp>(LOC, f_sqlite3VdbeSerialTypeLen, ValueRange{
                            tValue
                        }).getResult(0);
                        auto lenIsNull = rewriter.create<ICmpOp>(LOC, ICmpPredicate::eq, len, constants(0, 32));

                        auto condCAnd_condAOrCondB__OrLenIsNull = rewriter.create<OrOp>(LOC, condCAnd_condAOrCondB, lenIsNull);

                        curBlock = rewriter.getBlock();
                        auto blockTrue = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                        auto blockFalse = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                        auto blockAfter = SPLIT_BLOCK; GO_BACK_TO(curBlock);

                        rewriter.create<CondBrOp>(LOC, condCAnd_condAOrCondB__OrLenIsNull, blockTrue, blockFalse);
                        { // if (...)
                            rewriter.setInsertionPointToStart(blockTrue);

                            /// sqlite3VdbeSerialGet((u8 *) sqlite3CtypeMap, t, pDest);
                            auto cTypeMap = constants(T::i8PtrTy, (u8*)sqlite3CtypeMap);
                            rewriter.create<CallOp>(LOC, f_sqlite3VdbeSerialGet, ValueRange {
                                cTypeMap, tValue, pDest
                            });

                            rewriter.create<BranchOp>(LOC, blockAfter);
                        } // end if (...)
                        { // else of if (...)
                            rewriter.setInsertionPointToStart(blockFalse);

                            /////// Get pC->uc.pCursor as a BtCursor*
                            // Get the address of the cursor from pC->uc.pCursor
                            auto pCrsrAddress = rewriter.create<GEPOp>
                                    (LOC, T::VdbeCursorPtrPtrTy, pCValue,
                                     ValueRange{
                                             CONSTANT_INT(0, 32),  // &pC
                                             CONSTANT_INT(12, 32), // &pc->uc
                                             CONSTANT_INT(0, 32)   // pCursor (first item of union-struct)
                                     });

                            // Load the value of the pointer (address of the cursor)
                            auto pCrsrAsCursor = rewriter.create<LoadOp>(LOC, pCrsrAddress);
                            // Convert this VdbeCursor* to BtCursor* (VdbeCursor is a "parent type")
                            auto pCrsr = rewriter.create<BitcastOp>(LOC, T::BtCursorPtrTy, pCrsrAsCursor);

                            //// Get aOffset[p2]
                            auto aOffsetP2Addr = rewriter.create<GEPOp>(LOC, T::i32PtrTy, aOffset, constants(colOp.columnAttr().getSInt(), 32));
                            auto aOffsetP2Val = rewriter.create<LoadOp>(LOC, aOffsetP2Addr);

                            /// rc = sqlite3VdbeMemFromBtree(pC->uc.pCursor, aOffset[p2], len, pDest);
                            auto result = rewriter.create<CallOp>(LOC, f_sqlite3VdbeMemFromBtree, ValueRange {
                                pCrsr, aOffsetP2Val, len, pDest
                            }).getResult(0);

                            { // if (rc != SQLITE_OK) goto abort_due_to_error
                                auto rcIsSqliteOK = rewriter.create<ICmpOp>(LOC, ICmpPredicate::eq, rc, constants(SQLITE_OK, 32));
                                myAssert(LOCL, rcIsSqliteOK);
                            } // end if (rc != SQLITE_OK) goto abort_due_to_error

                            /// sqlite3VdbeSerialGet((const u8 *) pDest->z, t, pDest);
                            // Get &pDest->z
                            auto zAddr = rewriter.create<GEPOp>(LOC, T::i8PtrPtrTy, pDest,ValueRange {
                                    constants(0, 32), // &*pDest
                                    constants(5, 32)  // 6-th field of sqlite3_value
                            });
                            // Load pDest->z
                            auto zValue = rewriter.create<LoadOp>(LOC, zAddr);
                            // Convert pDest->z to u8*
                            auto zValueAsU8Ptr = rewriter.create<BitcastOp>(LOC, T::i8PtrTy, zValue);
                            // Call sqlite3VdbeSerialGet
                            rewriter.create<CallOp>(LOC, f_sqlite3VdbeSerialGet, ValueRange {
                                zValueAsU8Ptr, tValue, pDest
                            });

                            /// pDest->flags &= ~MEM_Ephem;
                            auto flagsAddr = rewriter.create<GEPOp>
                                    (LOC, T::i16PtrTy, pDest, ValueRange{
                                            constants(0, 32), // &*pDest
                                            constants(1, 32)  // flags is second field of sqlite3_value
                                    });
                            auto flagsValue = rewriter.create<LoadOp>(LOC, flagsAddr);
                            auto notMemEphem = ~MEM_Ephem;
                            auto newFlagsValue = rewriter.create<AndOp>(LOC, flagsValue, constants(notMemEphem, 16));
                            rewriter.create<StoreOp>(LOC, newFlagsValue, flagsAddr);

                            rewriter.create<BranchOp>(LOC, blockAfter);
                        } // end else of if (...)

                        rewriter.setInsertionPointToStart(blockAfter);
                        rewriter.create<BranchOp>(LOC, blockAfterSzRowGeOffsetP2Plus1);
                    } // end else of if (pC->szRow >= aOffset[p2 + 1])

                    rewriter.setInsertionPointToStart(blockAfterSzRowGeOffsetP2Plus1);

                    rewriter.create<BranchOp>(LOC, blockColumnEnd);
                } // End after cacheStatus != cacheCtr

                rewriter.setInsertionPointToStart(blockColumnEnd);
                print(LOCL, "op_column_out: ending");
                rewriter.create<mlir::LLVM::StackRestoreOp>(LOC, stackState);
                rewriter.eraseOp(colOp);
                return success();
            } // matchAndRewrite
        } // namespace passes
    } // namespace standalone
} // namespace mlir