#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"

namespace mlir {
    namespace standalone {
        namespace passes {
            LogicalResult OpenReadLowering::matchAndRewrite(OpenRead orOp, PatternRewriter &rewriter) const {
                auto op = &orOp;
                auto &builder = rewriter;
                LOWERING_PASS_HEADER
                LOWERING_NAMESPACE

                mlir::Value curIdx = CONSTANT_INT(orOp.curIdxAttr().getSInt(), 32);
                mlir::Value databaseIdx = CONSTANT_INT(orOp.databaseAttr().getSInt(), 32);


                auto pVdbe = CONSTANT_PTR(T::VdbePtrTy, vdbe);
                // rewriter.create<IntToPtrOp>(LOC, T::VdbePtrTy, CONSTANT_INT(vdbe, 64));

                auto aDb = vdbe->db->aDb;
                auto _aDb = CONSTANT_PTR(T::DbPtrTy, aDb);
                // rewriter.create<IntToPtrOp>(LOC, T::DbPtrTy, CONSTANT_INT(aDb, 64));

                auto pDb = rewriter.create<GEPOp>
                    (LOC, T::DbPtrTy, _aDb, mlir::ValueRange{
                        CONSTANT_INT(orOp.databaseAttr().getSInt(), 32)
                    });

                auto ppX = rewriter.create<GEPOp>(LOC,
                                                  T::BtreePtrTy.getPointerTo(), pDb,
                                                  mlir::ValueRange{CONSTANT_INT(0, 64),
                                                                   CONSTANT_INT(1, 32)});

                auto pX = rewriter.create<LoadOp>(LOC, ppX);

                // TODO: pOp->opcode == OpenWrite ...

                auto wrFlag = CONSTANT_INT(0, 32);

                auto p5Value = orOp.P5Attr().getUInt();
                Value rootPage = CONSTANT_INT(orOp.rootPageAttr().getSInt(), 32);
                // If P5 says that P2 is a register (and not an integer)
                if (p5Value & OPFLAG_P2ISREG) {
                    out("Writing special case for OPFLAG_P2ISREG");
                    // Get the address at which the array of sqlite3_value (aMem) starts
                    auto addressOfRegisters = rewriter.create<IntToPtrOp>(LOC, T::sqlite3_valuePtrTy,
                                                                          (Value) CONSTANT_INT(vdbe->aMem, 64));
                    // Get the address of the value we're looking for
                    auto adressOfValue = rewriter.create<GEPOp>
                            (LOC,
                             LLVMType::getDoubleTy(llvmDialect).getPointerTo(), // Union has a double only
                             addressOfRegisters, /* This is the address of the sqlite3_value array */
                             ValueRange{ /* p2 = */ rootPage,          // Index in array
                                     CONSTANT_INT(0, 32), // Element 0 of struct
                                     CONSTANT_INT(0, 32)  // Element 0 of union-struct
                             });

                    out("TODO: Add 3826 sqlite3VdbeMemIntegerify(pIn2);")

                    // Load the content at the address of the union
                    auto regContent = rewriter.create<LoadOp>(LOC, adressOfValue);
                    // Register contains a union -> BitCast it to i64
                    auto valueOfRegisterP2 = rewriter.create<BitcastOp>(LOC, T::i64Ty, regContent);
                    // rootPage is supposed to be an i32 -> Truncate
                    auto valueAsI32 = rewriter.create<mlir::LLVM::TruncOp>(LOC, T::i32Ty, valueOfRegisterP2);
                    // Update what rootPage is
                    rootPage = valueAsI32;
                }

                // WE ASSUME THAT WE KNOW WE HAVE pOp->p4type == P4_INT32
                // TODO: Add the other case
                auto nField = CONSTANT_INT(orOp.P4Attr().getSInt(), 32);

                auto pCur = rewriter.create<CallOp>
                        (LOC, f_allocateCursor, mlir::ValueRange{
                            pVdbe,
                            curIdx,
                            nField,
                            databaseIdx,
                            CONSTANT_INT(CURTYPE_BTREE, 8)
                        }).getResult(0);

                // pCur->nullRow = 1;
                auto pNullRow = rewriter.create<GEPOp>
                        (LOC, T::i8PtrTy, pCur,ValueRange{
                            CONSTANT_INT(0, 32),
                            CONSTANT_INT(2, 32)
                        });
                rewriter.create<StoreOp>(LOC, CONSTANT_INT(1, 8), pNullRow);

                // pCur->isOrdered = 1;
                auto pMixedParameters = rewriter.create<GEPOp>
                        (LOC, T::i8PtrTy, pCur, ValueRange{
                            CONSTANT_INT(0, 32),
                            CONSTANT_INT(5, 32)
                        });

                mlir::Value curValue = rewriter.create<LoadOp>(LOC, pMixedParameters);

                curValue = rewriter.create<OrOp>(LOC, curValue, CONSTANT_INT(4, 8));
                rewriter.create<StoreOp>(LOC, curValue, pMixedParameters);

                // pCur->pgnoRoot = p2;
                auto ppgnoRoot = rewriter.create<GEPOp>
                        (LOC, T::i32PtrTy, pCur, ValueRange{
                            CONSTANT_INT(0, 32),
                            CONSTANT_INT(15, 32)
                        });

                rewriter.create<StoreOp>(LOC, rootPage, ppgnoRoot);

                // TODO: To update when using P4_KEYINFO
                auto pKeyInfo = CONSTANT_PTR(T::KeyInfoPtrTy, nullptr);

                auto pCur_uc_pCursor_addr = rewriter.create<GEPOp>
                        (LOC, T::BtCursorPtrTy.getPointerTo(), pCur, ValueRange{
                            CONSTANT_INT(0, 32),  // &*pCur
                            CONSTANT_INT(12, 32), // &pCur->uc
                            CONSTANT_INT(0, 32)   // &pCur->uc.pCursor
                        });

                auto pCur_uc_pCursor = rewriter.create<LoadOp>(LOC, pCur_uc_pCursor_addr);

                auto rc = rewriter.create<CallOp>
                        (LOC, f_sqlite3BtreeCursor, ValueRange{
                            pX, rootPage, wrFlag, pKeyInfo, pCur_uc_pCursor
                        }).getResult(0);

                PROGRESS_PRINT_INT(TO_I64(rc), "Value returned by sqlite3_BtreeCursor:")

                /// pCur->pKeyInfo = pKeyInfo;
                auto ppKeyInfo = rewriter.create<GEPOp>
                        (LOC, T::KeyInfoPtrTy.getPointerTo(), pCur, ValueRange{
                            CONSTANT_INT(0, 32),
                            CONSTANT_INT(13, 32)
                        });
                rewriter.create<StoreOp>(LOC, pKeyInfo, ppKeyInfo);

                // TODO: pCur->isTable = pOp->p4type != P4_KEYINFO;

                unsigned hint = p5Value & (OPFLAG_BULKCSR | OPFLAG_SEEKEQ);
                rewriter.create<CallOp>(LOC, f_sqlite3BtreeCursorHintFlags, ValueRange{
                    pCur_uc_pCursor, CONSTANT_INT(hint, 32)
                });


                // TODO: if (rc) goto abort_due_to_error

                rewriter.eraseOp(orOp);
                return success();
            } // matchAndRewrite
        } // namespace passes
    } // namespace standalone
} // namespace mlir