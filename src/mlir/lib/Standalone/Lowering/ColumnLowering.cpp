#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"

#include "Standalone/ConstantManager.h"

/*#ifdef DEBUG_CALLED
#error "CALL_DEBUG used more than once!" // First use at " ##__LINE__
#else
#define DEBUG_CALLED
#endif*/
#define CALL_DEBUG { \
    rewriter.create<CallOp>(LOC, f_debug, ValueRange{}); \
}

#define EXIT_PASS_EARLY(with_call_to_debug) { \
    if (with_call_to_debug) { \
        CALL_DEBUG \
    } \
    rewriter.eraseOp(colOp); \
    err("QSDQSD EXIT EARLY"); \
    parentModule.dump(); \
    return success(); \
};

#define SPLIT_BLOCK rewriter.getBlock()->splitBlock(rewriter.getBlock()->end());
#define GO_BACK_TO(b) rewriter.setInsertionPointToEnd(b)

namespace mlir {
    namespace standalone {
        namespace passes {
            LogicalResult ColumnLowering::matchAndRewrite(Column colOp, PatternRewriter &rewriter) const {
                auto op = &colOp;
                auto &builder = rewriter;
                LOWERING_PASS_HEADER
                LOWERING_NAMESPACE

                ConstantManager constants(rewriter, ctx);
                auto pVdbe = constants(T::VdbePtrTy, vdbe);

                auto curIdxAttr = colOp.getAttrOfType<mlir::IntegerAttr>("curIdx");
                auto columnAttr = colOp.getAttrOfType<mlir::IntegerAttr>("column");
                auto extractToAttr = colOp.getAttrOfType<mlir::IntegerAttr>("extractTo");
                auto defaultValueAttr = colOp.getAttrOfType<mlir::IntegerAttr>("defaultValue");
                auto flagsAttr = colOp.getAttrOfType<mlir::IntegerAttr>("flags");

                auto curIdxValue = constants(curIdxAttr.getValue().getLimitedValue(32), 32);
                auto extractToValue = constants(extractToAttr.getValue().getLimitedValue(32), 32);

                auto curIdx = rewriter.create<AllocaOp>(LOC, T::i32PtrTy, constants(1, 32), 0);
                rewriter.create<StoreOp>(LOC, curIdxValue, curIdx);

                PROGRESS_PRINT_INT(curIdxValue, "OP_Column: Cursor index");

                // The address of the array of (pointers to) cursors in the VDBE
                auto apCsr = constants(T::VdbeCursorPtrPtrTy, vdbe->apCsr);
                // The address of this particular pointer-to-cursor
                auto pCAddr = rewriter.create<GEPOp>(LOC, T::VdbeCursorPtrPtrTy, apCsr, ValueRange{curIdxValue});
                // The address of the cursor
                auto pCValue = rewriter.create<LoadOp>(LOC, pCAddr);
                auto pC = rewriter.create<AllocaOp>(LOC, T::VdbeCursorPtrPtrTy, constants(1, 32), 0);
                rewriter.create<StoreOp>(LOC, pCValue, pC);

                auto rc = rewriter.create<CallOp>(LOC, f_sqlite3VdbeCursorMoveto,
                                                  ValueRange{pC, curIdx}).getResult(0);

                // TODO: if (rc) goto abort_due_to_error;

                // pDest = &aMem[pOp->p3];
                // Initialise aMem with its actual value
                auto aMem = CONSTANT_PTR(T::sqlite3_valuePtrTy, vdbe->aMem);
                // Get the address of the P3'th (extractTo) element
                auto pDest = rewriter.create<GEPOp>(LOC, T::sqlite3_valuePtrTy, aMem,
                                                    ValueRange{extractToValue});

                // aOffset = pC->aOffset;
                auto aOffsetAddr = rewriter.create<GEPOp>
                        (LOC, T::i32PtrTy.getPointerTo(), pCValue,
                         ValueRange{
                                 constants(0, 32), // Address of *pC
                                 constants(19, 32)  // Address of aOffset in pC
                         });
                auto aOffset = rewriter.create<LoadOp>(LOC, aOffsetAddr);

                auto curBlock = rewriter.getBlock();

                auto blockCacheStatusNeqCacheCtr = rewriter.getBlock()->splitBlock(colOp);
                rewriter.setInsertionPoint(colOp);
                auto blockAfterCacheStatusNeqCachePtr = rewriter.getBlock()->splitBlock(colOp);
                rewriter.setInsertionPoint(colOp);
                auto blockColumnEnd = rewriter.getBlock()->splitBlock(colOp);
                rewriter.setInsertionPoint(colOp);
                // GO_BACK_TO(curBlock);

                // Go back to the end of the current block to insert branching
                rewriter.setInsertionPointToEnd(curBlock);

                auto cacheStatusAddr = rewriter.create<GEPOp>
                        (LOC, T::i32PtrTy, pCValue,
                         ValueRange{
                                 constants(0, 32), // *pC
                                 constants(9, 32)  // Address of field cacheStatus
                         });
                auto cacheStatus = rewriter.create<LoadOp>(LOC, cacheStatusAddr);

                auto cacheCtrAddr = rewriter.create<GEPOp>
                        (LOC, T::i32PtrTy, pVdbe,
                         ValueRange{
                                 constants(0, 32), // *pVdbe
                                 constants(9, 32)  // Address of cacheCtr in Vdbe
                         });
                auto cacheCtr = rewriter.create<LoadOp>(LOC, cacheCtrAddr);

                auto cacheStatusNeqCacheCtr = rewriter.create<ICmpOp>(LOC, ICmpPredicate::ne, cacheStatus, cacheCtr);
                rewriter.create<CondBrOp>
                        (LOC, cacheStatusNeqCacheCtr,
                                /* if != */ blockCacheStatusNeqCacheCtr,
                                /* else  */ blockAfterCacheStatusNeqCachePtr
                        );

                /* if cacheStatus != cacheCtr */
                {
                    // BLOCK if cacheStatus != cacheCtr
                    auto ip = rewriter.saveInsertionPoint();
                    rewriter.setInsertionPointToStart(blockCacheStatusNeqCacheCtr);
                    auto block = rewriter.getBlock();

                    PROGRESS("cacheStatus != cacheCtr")

                    auto payloadSizeAddress = rewriter.create<GEPOp>
                            (LOC, T::i32PtrTy, pCValue,
                             ValueRange{
                                     constants(0, 32), // *pC
                                     constants(21, 32)  // &pC->payloadSize
                             });
                    auto szRowAddress = rewriter.create<GEPOp>
                            (LOC, T::i32PtrTy, pCValue,
                             ValueRange{
                                     constants(0, 32), // *pC
                                     constants(22, 32)  // &pC->szRo
                             });
                    // Get the address of pC->aRow (u8*)
                    auto pCaRowAddress = rewriter.create<GEPOp>
                            (LOC, T::i8PtrPtrTy, pCValue,
                             ValueRange{
                                     constants(0, 32),
                                     constants(20, 32)
                             });

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
                                     constants(2, 32)  // nullRow is field 2
                             });

                    // Load the value of pC->nullRow
                    auto nullRow = rewriter.create<LoadOp>(LOC, nullRowAddr);

                    // Check whether pC->nullRow == 0
                    auto nullRowCondition = rewriter.create<ICmpOp>(LOC, ICmpPredicate::ne, nullRow, constants(0, 8));

                    // Branch for pC->nullRow == 0
                    rewriter.create<CondBrOp>(LOC, nullRowCondition,
                            /* if pC->nullRow == 0 */ blockNullRow,
                            /* else */                blockNotNullRow);
                    /* if nullRow */
                    {
                        // BLOCK if nullRow
                        rewriter.setInsertionPointToStart(blockNullRow);
                        PROGRESS("nullRow = true branch")
                        auto blockCurTypePseudo = rewriter.getBlock()->splitBlock(rewriter.getBlock()->end());
                        rewriter.setInsertionPointToEnd(blockNullRow);
                        auto blockNotCurTypePseudo = rewriter.getBlock()->splitBlock(rewriter.getBlock()->end());

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
                                (LOC, ICmpPredicate::eq, curType, constants(CURTYPE_PSEUDO, 8));

                        // Create the branching
                        rewriter.create<CondBrOp>(LOC, curTypeCondition,
                                /* if pC->curType == CURTYPE_PSEUDO */ blockCurTypePseudo,
                                /*                             else */ blockNotCurTypePseudo
                        );

                        /* if CURTYPE_PSEUDO */
                        {
                            rewriter.setInsertionPointToStart(blockCurTypePseudo);
                            PROGRESS("CURTYPE_PSEUDO branch")

                            // pReg = &aMem[pC->seekResult];
                            auto seekResultAddress = rewriter.create<GEPOp>
                                    (LOC, T::i32PtrTy, pCValue,
                                     ValueRange{
                                             constants(0, 32), // *pC
                                             constants(10, 32) // pc->seekResult
                                     });

                            auto seekResultValue = rewriter.create<LoadOp>(LOC, seekResultAddress);

                            auto pRegValue = rewriter.create<GEPOp>
                                    (LOC, T::sqlite3_valuePtrTy, aMem,
                                     ValueRange{
                                             seekResultValue, // We want &aMem[pC->seekResult]
                                     });

                            // pC->payloadSize = pC->szRow = pReg->n;
                            auto pRegNAddress = rewriter.create<GEPOp>
                                    (LOC, T::i32PtrTy, pRegValue,
                                     ValueRange{
                                             constants(0, 32), // *pReg
                                             constants(4, 32) // &pReg->n
                                     });
                            auto pRegNValue = rewriter.create<LoadOp>(LOC, pRegNAddress);
                            rewriter.create<StoreOp>(LOC, pRegNValue, payloadSizeAddress);
                            rewriter.create<StoreOp>(LOC, pRegNValue, szRowAddress);

                            //// pC->aRow = (u8 *) pReg->z;
                            // Get the address of pReg->z (gives an u8**)
                            auto pRegZAddress = rewriter.create<GEPOp>
                                    (LOC, T::i32PtrTy, pRegValue,
                                     ValueRange{
                                             constants(0, 32), // *pReg
                                             constants(5, 32)  // &pReg->z
                                     });
                            // Cast it to an i64* (u8** -> i64*)
                            auto castPRegZAddress = rewriter.create<BitcastOp>(LOC, T::i64PtrTy, pRegZAddress);
                            // Load the value of pReg->z (i64)
                            auto pRegZValue = rewriter.create<LoadOp>(LOC, castPRegZAddress);

                            // Cast it to an i64* (u8* -> i64*)
                            auto castpCaRowAddress = rewriter.create<BitcastOp>(LOC, T::i64PtrTy, pCaRowAddress);

                            // Store the value of pReg->z in pC->aRow
                            rewriter.create<StoreOp>(LOC, pRegZValue, castpCaRowAddress);

                            // Branch out
                            rewriter.create<BranchOp>(LOC, blockEndCacheNeStatusCacheCtr);
                        }
                        /* else (NOT CURTYPE_PSEUDO) */
                        {
                            rewriter.setInsertionPointToStart(blockNotCurTypePseudo);
                            PROGRESS("NOT CURTYPE_PSEUDO branch")

                            rewriter.create<CallOp>(LOC, f_sqlite3VdbeMemSetNull, ValueRange{pDest});

                            // PROGRESS("TODO: goto_op_column_out")
                            // TODO: goto op_column_out;
                            rewriter.create<BranchOp>(LOC, blockColumnEnd);

                            // rewriter.create<BranchOp>(LOC, blockEndCacheNeStatusCacheCtr);
                        }
                    }
                    /* else (not nullRow) */
                    {
                        rewriter.setInsertionPointToStart(blockNotNullRow);
                        PROGRESS("NOT nullRow branch")

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

                        //// pC->payloadSize = sqlite3BtreePayloadSize(pCrsr);
                        auto payloadSize = rewriter.create<CallOp>
                                (LOC, f_sqlite3BtreePayloadSize,
                                 ValueRange{
                                         pCrsr
                                 }).getResult(0);

                        // Store the result in pC->payloadSize
                        rewriter.create<StoreOp>(LOC, payloadSize, payloadSizeAddress);

                        //// pC->aRow = sqlite3BtreePayloadFetch(pCrsr, &pC->szRow);
                        auto payload = rewriter.create<CallOp>
                                (LOC, f_sqlite3BtreePayloadFetch,
                                 ValueRange{
                                         pCrsr,
                                         szRowAddress
                                 }).getResult(0);

                        // Store the result in pC->aRow
                        rewriter.create<StoreOp>(LOC, payload, pCaRowAddress);

                        /* TODO if (pC->payloadSize > (u32) db->aLimit[SQLITE_LIMIT_LENGTH]) {
                         * goto too_big;
                         * }
                         */

                        rewriter.create<mlir::BranchOp>(LOC, blockEndCacheNeStatusCacheCtr);
                    }

                    /* After condition (but still in cacheStatus != cacheCtr) */
                    {
                        // BLOCK EndCacheStatusNeqCacheCtr
                        rewriter.setInsertionPointToStart(blockEndCacheNeStatusCacheCtr);

                        //// pC->cacheStatus = p->cacheCtr;
                        auto newCacheCtr = rewriter.create<LoadOp>(LOC, cacheCtrAddr);
                        rewriter.create<StoreOp>(LOC, newCacheCtr, cacheStatusAddr);

                        //// pC->iHdrOffset = getVarint32(pC->aRow, aOffset[0]);
                        auto iHdrOffsetAddr = rewriter.create<GEPOp>
                                (LOC, T::i32PtrTy, pCValue, ValueRange{
                                        constants(0, 32),  // &*pC
                                        constants(14, 32)  // &pC->iHdrOffset
                                });

                        // TODO: Work on that!
                        auto generate_getVarint32 = [&rewriter, &ctx, &constants](auto A, auto B, auto writeResultTo) {
                            // #define getVarint32(A,B)  \
                            //   (u8)((*(A)<(u8)0x80)?((B)=(u32)*(A)),1:sqlite3GetVarint32((A),(u32 *)&(B)))
                            //
                            // Func getVarint32(A, B) as u8:
                            //   If *A < 0x80 Then
                            //     B = (u32)*A
                            //     Return 1
                            //   Else
                            //     Return sqlite3GetVarint32(A, (u32*)&B)
                            //   EndIf

                            // Read the content of pointer A
                            auto valA = rewriter.create<LoadOp>(LOC, A);

                            PROGRESS("THOMAS");

                            // Create new blocks:
                            // - One for if *A < 0x80
                            // - One for the else (A >= 0x80)
                            // - One for reuniting control flow
                            auto curBlock = rewriter.getBlock();
                            auto blockAfter = SPLIT_BLOCK;
                            GO_BACK_TO(curBlock);
                            auto blockMoreThan80 = SPLIT_BLOCK;
                            GO_BACK_TO(curBlock);
                            auto blockLessThan80 = SPLIT_BLOCK;
                            GO_BACK_TO(curBlock);


                            // Check whether the *A < 0x80
                            auto condLessThan80 = rewriter.create<ICmpOp>
                                    (LOC, ICmpPredicate::ult, valA, constants(0x80, 8));

                            // Insert branching 
                            rewriter.create<CondBrOp>(LOC, condLessThan80, blockLessThan80, blockMoreThan80);

                            /* if *A < 0x80 */
                            {
                                rewriter.setInsertionPointToStart(blockLessThan80);

                                PROGRESS("*A < 0x80")
                                // Convert *A to u32
                                auto aAsU32 = rewriter.create<ZExtOp>(LOC, T::i32Ty, valA);

                                // B = *A
                                rewriter.create<StoreOp>(LOC, aAsU32, B);

                                // "Return" 1
                                rewriter.create<StoreOp>(LOC, constants(1, 32), writeResultTo);

                                rewriter.create<BranchOp>(LOC, blockAfter);
                            }
                            /* else */
                            {
                                rewriter.setInsertionPointToStart(blockMoreThan80);

                                PROGRESS("ELSE(*A < 0x80)")
                                // Convert B to u32*
                                auto bAsU32Ptr = rewriter.create<BitcastOp>(LOC, T::i32PtrTy, B);
                                // Call sqlite3GetVarint32(A, (u32*)B)
                                auto result = rewriter.create<CallOp>
                                        (LOC, f_sqlite3GetVarint32,
                                         ValueRange{
                                            A,
                                            bAsU32Ptr
                                         }).getResult(0);

                                // "Return" the result of the function
                                // sqlite3GetVarint32 returns an u8 so we need to extend it
                                auto resultAsI32 = rewriter.create<ZExtOp>(LOC, T::i32Ty, result);
                                rewriter.create<StoreOp>(LOC, resultAsI32, writeResultTo);
                                rewriter.create<BranchOp>(LOC, blockAfter);
                            }

                            rewriter.setInsertionPointToStart(blockAfter);
                        };

                        auto aRow = rewriter.create<LoadOp>(LOC, pCaRowAddress);
                        err("Type of aRow")
                        aRow.getType().dump();

                        PROGRESS("HELLO 1")
                        generate_getVarint32(/* A = */ aRow, /* B = */ aOffset, /* Result to */ iHdrOffsetAddr);
                        PROGRESS("HELLO 2")

                        //// pC->nHdrParsed = 0;
                        auto nHdrParsedAddr = rewriter.create<GEPOp>
                                (LOC, T::i16PtrTy, pCValue, ValueRange{
                                        constants(0, 32), // &*pC
                                        constants(17, 32) // &pC->nHdrParsedAddr
                                });
                        rewriter.create<StoreOp>(LOC, constants(0, 16), nHdrParsedAddr);

                        // CALL_DEBUG
                        /* TODO: Uncomment
                        */

                        // TODO: Next instruction: if (pC->szRow < aOffset[0]) {

                        rewriter.create<BranchOp>(LOC, blockAfterCacheStatusNeqCachePtr);
                    }
                    rewriter.restoreInsertionPoint(ip);
                }

                rewriter.setInsertionPointToStart(blockAfterCacheStatusNeqCachePtr);
                rewriter.create<BranchOp>(LOC, blockColumnEnd);

                rewriter.setInsertionPointToStart(blockColumnEnd);
                err("COLEND" << blockColumnEnd)
                CALL_DEBUG
                PROGRESS("op_column_out: ending")

                rewriter.eraseOp(colOp);
                return success();
            } // matchAndRewrite
        } // namespace passes
    } // namespace standalone
} // namespace mlir