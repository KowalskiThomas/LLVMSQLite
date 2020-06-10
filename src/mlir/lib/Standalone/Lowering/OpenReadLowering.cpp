#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"
#include "Standalone/Lowering/Printer.h"
#include "Standalone/ConstantManager.h"
#include "Standalone/Lowering/AssertOperator.h"

namespace mlir {
    namespace standalone {
        namespace passes {
            LogicalResult OpenReadLowering::matchAndRewrite(OpenRead orOp, PatternRewriter &rewriter) const {
                auto op = &orOp;
                auto &builder = rewriter;
                LOWERING_PASS_HEADER
                LOWERING_NAMESPACE
                ConstantManager constants(rewriter, ctx);
                Printer print(ctx, rewriter, __FILE_NAME__);
                MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);

                print(LOCL, "-- OpenRead");

                mlir::Value curIdx = constants(orOp.curIdxAttr().getSInt(), 32);
                mlir::Value databaseIdx = constants(orOp.databaseAttr().getSInt(), 32);

                auto pc = orOp.counterAttr().getUInt();
                auto pOp = &vdbe->aOp[pc];
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

                auto pVdbe = CONSTANT_PTR(T::VdbePtrTy, vdbe);
                // rewriter.create<IntToPtrOp>(LOC, T::VdbePtrTy, constants(vdbe, 64));

                auto aDb = vdbe->db->aDb;
                auto _aDb = CONSTANT_PTR(T::DbPtrTy, aDb);
                // rewriter.create<IntToPtrOp>(LOC, T::DbPtrTy, constants(aDb, 64));

                auto pDb = rewriter.create<GEPOp>
                    (LOC, T::DbPtrTy, _aDb, mlir::ValueRange{
                        constants(orOp.databaseAttr().getSInt(), 32)
                    });

                auto ppX = rewriter.create<GEPOp>(LOC,
                                                  T::BtreePtrTy.getPointerTo(), pDb,
                                                  mlir::ValueRange{constants(0, 64),
                                                                   constants(1, 32)});

                auto pX = rewriter.create<LoadOp>(LOC, ppX);

                // TODO: pOp->opcode == OpenWrite ...

                auto wrFlag = constants(0, 32);

                auto p5Value = orOp.P5Attr().getUInt();
                Value rootPage = constants(orOp.rootPageAttr().getSInt(), 32);
                // If P5 says that P2 is a register (and not an integer)
                if (p5Value & OPFLAG_P2ISREG) {
                    // Get the address at which the array of sqlite3_value (aMem) starts
                    auto addressOfRegisters = constants(T::sqlite3_valuePtrTy, vdbe->aMem);
                    // Get the address of the value we're looking for
                    auto adressOfValue = rewriter.create<GEPOp>
                            (LOC,
                             LLVMType::getDoubleTy(llvmDialect).getPointerTo(), // Union has a double only
                             addressOfRegisters, /* This is the address of the sqlite3_value array */
                             ValueRange{ /* p2 = */ rootPage,          // Index in array
                                     constants(0, 32), // Element 0 of struct
                                     constants(0, 32)  // Element 0 of union-struct
                             });

                    out("TODO: Add 3826 sqlite3VdbeMemIntegerify(pIn2);")
                    exit(126);

                    // Load the content at the address of the union
                    auto regContent = rewriter.create<LoadOp>(LOC, adressOfValue);
                    // Register contains a union -> BitCast it to i64
                    auto valueOfRegisterP2 = rewriter.create<BitcastOp>(LOC, T::i64Ty, regContent);
                    // rootPage is supposed to be an i32 -> Truncate
                    auto valueAsI32 = rewriter.create<mlir::LLVM::TruncOp>(LOC, T::i32Ty, valueOfRegisterP2);
                    // Update what rootPage is
                    rootPage = valueAsI32;
                }

                auto pKeyInfo = constants(T::KeyInfoPtrTy, (KeyInfo*)nullptr);
                Value nField;
                assert(pOp->p4type == P4_INT32 || pOp->p4type == P4_KEYINFO);
                if (pOp->p4type == P4_INT32) {
                    nField = constants(orOp.P4Attr().getUInt(), 32);
                } else {
                    pKeyInfo = constants(orOp.P4Attr().getUInt(), 64);
                    pKeyInfo = rewriter.create<BitcastOp>(LOC, T::KeyInfoPtrTy, pKeyInfo);
                    auto nAllFieldAddr = rewriter.create<GEPOp>
                        (LOC, T::i16PtrTy, pKeyInfo, mlir::ValueRange {
                            constants(0, 64),
                            constants(3, 64)
                        });
                    nField = rewriter.create<LoadOp>(LOC, nAllFieldAddr);
                }

                auto pCur = rewriter.create<CallOp>
                        (LOC, f_allocateCursor, mlir::ValueRange{
                            pVdbe,
                            curIdx,
                            nField,
                            databaseIdx,
                            constants(CURTYPE_BTREE, 8)
                        }).getResult(0);

                // pCur->nullRow = 1;
                auto pNullRow = rewriter.create<GEPOp>
                        (LOC, T::i8PtrTy, pCur,ValueRange{
                                constants(0, 32),
                            constants(2, 32)
                        });
                rewriter.create<StoreOp>(LOC, constants(1, 8), pNullRow);

                // pCur->isOrdered = 1;
                auto pMixedParameters = rewriter.create<GEPOp>
                        (LOC, T::i8PtrTy, pCur, ValueRange{
                            constants(0, 32),
                            constants(5, 32)
                        });

                mlir::Value curValue = rewriter.create<LoadOp>(LOC, pMixedParameters);

                curValue = rewriter.create<OrOp>(LOC, curValue, constants(4, 8));
                rewriter.create<StoreOp>(LOC, curValue, pMixedParameters);

                // pCur->pgnoRoot = p2;
                auto ppgnoRoot = rewriter.create<GEPOp>
                        (LOC, T::i32PtrTy, pCur, ValueRange{
                            constants(0, 32),
                            constants(15, 32)
                        });

                rewriter.create<StoreOp>(LOC, rootPage, ppgnoRoot);

                auto pCur_uc_pCursor_addr = rewriter.create<GEPOp>
                        (LOC, T::BtCursorPtrTy.getPointerTo(), pCur, ValueRange{
                            constants(0, 32),  // &*pCur
                            constants(12, 32), // &pCur->uc
                            constants(0, 32)   // &pCur->uc.pCursor
                        });

                auto pCur_uc_pCursor = rewriter.create<LoadOp>(LOC, pCur_uc_pCursor_addr);

                auto rc = rewriter.create<CallOp>
                        (LOC, f_sqlite3BtreeCursor, ValueRange{
                            pX, rootPage, wrFlag, pKeyInfo, pCur_uc_pCursor
                        }).getResult(0);

                // print(LOCL, rc, "Value returned by sqlite3_BtreeCursor:");

                /// pCur->pKeyInfo = pKeyInfo;
                auto ppKeyInfo = rewriter.create<GEPOp>
                        (LOC, T::KeyInfoPtrTy.getPointerTo(), pCur, ValueRange{
                            constants(0, 32),
                            constants(13, 32)
                        });
                rewriter.create<StoreOp>(LOC, pKeyInfo, ppKeyInfo);

                /// pCur->isTable = pOp->p4type != P4_KEYINFO;
                auto isTableAddr = rewriter.create<GEPOp>
                        (LOC, T::i8PtrTy, pCur, ValueRange {
                            constants(0, 32),
                            constants(4, 32)
                        });
                rewriter.create<StoreOp>(LOC, constants(pOp->p4type != P4_KEYINFO ? 1 : 0, 8), isTableAddr);

                unsigned hint = p5Value & (OPFLAG_BULKCSR | OPFLAG_SEEKEQ);
                rewriter.create<CallOp>(LOC, f_sqlite3BtreeCursorHintFlags, ValueRange{
                    pCur_uc_pCursor, constants(hint, 32)
                });

                { // if (rc) goto abort_due_to_error
                    auto rcNull = rewriter.create<ICmpOp>
                        (LOC, Pred::eq,
                            rc, constants(0, 32)
                        );
                    myAssert(LOCL, rcNull);
                } // end if (rc) goto abort_due_to_error

                rewriter.eraseOp(orOp);
                return success();
            } // matchAndRewrite
        } // namespace passes
    } // namespace standalone
} // namespace mlir