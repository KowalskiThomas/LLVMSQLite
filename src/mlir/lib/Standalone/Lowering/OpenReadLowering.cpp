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


                auto pVdbe = rewriter.create<mlir::LLVM::IntToPtrOp>(LOC,
                                                                     T::VdbePtrTy, CONSTANT_INT((uint64_t) vdbe, 64));

                auto aDb = vdbe->db->aDb;
                auto _aDb = rewriter.create<mlir::LLVM::IntToPtrOp>(LOC,
                                                                    T::DbPtrTy, CONSTANT_PTR(aDb));

                auto pDb = rewriter.create<mlir::LLVM::GEPOp>(LOC,
                                                              T::DbPtrTy, _aDb, mlir::ValueRange{orOp.database()});

                auto ppX = rewriter.create<mlir::LLVM::GEPOp>(LOC,
                                                              T::BtreePtrTy.getPointerTo(), pDb,
                                                              mlir::ValueRange{CONSTANT_INT(0, 64),
                                                                               CONSTANT_INT(1, 32)});

                auto pX = rewriter.create<mlir::LLVM::LoadOp>(LOC, ppX);

                auto wrFlag = CONSTANT_INT(0, 32);

                // TODO: Add the case in which (P5 & OPFLAG_P2ISREAG == true)

                // WE ASSUME THAT WE KNOW WE HAVE pOp->p4type == P4_INT32

                auto nField = orOp.P4();

                auto pCur = rewriter.create<mlir::LLVM::CallOp>(LOC,
                                                                f_allocateCursor,
                                                                mlir::ArrayRef<mlir::Value>{
                                                                        pVdbe,
                                                                        orOp.curIdx(),
                                                                        nField,
                                                                        orOp.database(),
                                                                        CONSTANT_INT(CURTYPE_BTREE, 8)}
                ).getResult(0);


//                pCur->nullRow = 1;
                auto pNullRow = rewriter.create<mlir::LLVM::GEPOp>(LOC, T::i8PtrTy, pCur,
                                                                   ValueRange{CONSTANT_INT(0, 32),
                                                                              CONSTANT_INT(2, 32)});
                rewriter.create<mlir::LLVM::StoreOp>(LOC, CONSTANT_INT(1, 8), pNullRow);
//                pCur->isOrdered = 1;

                auto pMixedParameters = rewriter.create<mlir::LLVM::GEPOp>
                        (LOC, T::i8PtrTy, pCur,
                         ValueRange{CONSTANT_INT(0, 32),
                                    CONSTANT_INT(5, 32)});

                mlir::Value curValue = rewriter.create<mlir::LLVM::LoadOp>
                        (LOC, pMixedParameters);

                curValue = rewriter.create<mlir::LLVM::OrOp>(LOC, curValue, CONSTANT_INT(4, 8));
                rewriter.create<mlir::LLVM::StoreOp>(LOC, curValue, pMixedParameters);

                // pCur->pgnoRoot = p2;
                auto ppgnoRoot = rewriter.create<mlir::LLVM::GEPOp>
                        (LOC, T::i32PtrTy, pCur,
                         ValueRange{CONSTANT_INT(0, 32),
                                    CONSTANT_INT(15, 32)});

                rewriter.create<mlir::LLVM::StoreOp>(LOC, orOp.rootPage(), ppgnoRoot);

                auto pKeyInfo = rewriter.create<mlir::LLVM::IntToPtrOp>(LOC,
                                                                        T::KeyInfoPtrTy, CONSTANT_PTR(nullptr));

                auto pCur_uc_pCursor_addr = rewriter.create<mlir::LLVM::GEPOp>
                        (LOC, T::BtCursorPtrTy.getPointerTo(),
                         pCur,
                         ValueRange{CONSTANT_INT(0, 32),
                                    CONSTANT_INT(12, 32),
                                    CONSTANT_INT(0, 32)}
                        );

                auto pCur_uc_pCursor = rewriter.create<mlir::LLVM::LoadOp>(LOC, pCur_uc_pCursor_addr);

                auto rc = rewriter.create<mlir::LLVM::CallOp>
                        (LOC,
                         f_sqlite3BtreeCursor,
                         mlir::ArrayRef<mlir::Value>{pX, orOp.rootPage(), wrFlag, pKeyInfo, pCur_uc_pCursor}
                        ).getResult(0);

                PROGRESS_PRINT_INT(TO_I64(rc), "<- value returned by sqlite3_BtreeCursor")

                // pCur->pKeyInfo = pKeyInfo;
                auto ppKeyInfo = rewriter.create<mlir::LLVM::GEPOp>(LOC, T::KeyInfoPtrTy.getPointerTo(), pCur, ValueRange{ CONSTANT_INT(0, 32), CONSTANT_INT(13, 32) });
                rewriter.create<mlir::LLVM::StoreOp>(LOC, pKeyInfo, ppKeyInfo);

                // TODO: pCur->isTable = pOp->p4type != P4_KEYINFO;

                // TODO: Add p5 & to hint
                unsigned hint = OPFLAG_BULKCSR | OPFLAG_SEEKEQ;
                rewriter.create<mlir::LLVM::CallOp>(LOC, f_sqlite3BtreeCursorHintFlags, ValueRange{pCur_uc_pCursor, CONSTANT_INT(hint, 32)});

                // TODO: if (rc) goto abort_due_to_error

                rewriter.eraseOp(orOp);
                // parentModule.dump();
                return success();
            } // matchAndRewrite
        } // namespace passes
    } // namespace standalone
} // namespace mlir