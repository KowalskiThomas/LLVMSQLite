#include "Standalone/ConstantManager.h"
#include "Standalone/Lowering/MyBuilder.h"
#include "Standalone/Lowering/ApplyNumericAffinity.h"
#include "Standalone/AllIncludes.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"

#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"

extern LLVMFuncOp f_applyNumericAffinity;
extern LLVMFuncOp f_sqlite3VdbeIntValue;
extern LLVMFuncOp f_sqlite3BtreeLast;
extern LLVMFuncOp f_sqlite3BtreeMovetoUnpacked;
extern LLVMFuncOp f_sqlite3BtreeCursorHasHint;
extern LLVMFuncOp f_sqlite3BtreePrevious;
extern LLVMFuncOp f_sqlite3BtreeEof;

namespace mlir::standalone::passes {
    LogicalResult SeekGELowering::matchAndRewrite(SeekGE skOp, PatternRewriter &rewriter) const {
        auto op = &skOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        Inlining::ApplyNumericAffinity applyNumericAffinity(*vdbeCtx, *ctx, rewriter, print, constants);
        myOperators

        auto pc = skOp.pcAttr().getSInt();
        auto p1 = skOp.p1Attr().getSInt();
        auto p2 = skOp.p2Attr().getSInt();
        auto p3 = skOp.p3Attr().getSInt();
        auto p4 = skOp.p4Attr().getUInt();

        auto jumpTo = skOp.jumpTo();
        auto fallThrough = skOp.fallThrough();
        auto skipNext = skOp.skipNext();

        USE_DEFAULT_BOILERPLATE

        auto firstBlock = rewriter.getBlock();
        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(skOp); GO_BACK_TO(curBlock);
        auto blockSeekNotFound = SPLIT_GO_BACK_TO(curBlock);

        auto stackState = saveStack(LOC);
        /// int res = 0;
        auto resAddr = alloca(LOC, T::i32PtrTy);
        store(LOC, 0, resAddr);

        /// int eqOnly = 0;
        auto eqOnlyAddr = alloca(LOC, T::i32PtrTy);
        store(LOC, 0, eqOnlyAddr);

        /// pC = p->apCsr[pOp->p1];
        auto pCAddr = getElementPtrImm(LOC, T::VdbeCursorPtrTy, vdbeCtx->apCsr, p1);
        auto pC = load(LOC, pCAddr);

        auto pCursorAddr = getElementPtrImm(LOC, T::BtCursorPtrTy, pC, 0, 12, 0);
        auto pCursor = load(LOC, pCursorAddr);

        /// oc = pOp->opcode;
        auto initialOc = vdbe->aOp[pc].opcode;
        auto ocAddr = alloca(LOC, T::i32PtrTy);
        store(LOC, initialOc, ocAddr);

        /// pC->nullRow = 0;
        auto nullRowAddr = getElementPtrImm(LOC, T::i8PtrTy, pC, 0, 2);
        store(LOC, 0, nullRowAddr);

        /// pC->deferredMoveto = 0;
        auto deferredMoveToAddr = getElementPtrImm(LOC, T::i8PtrTy, pC, 0, 3);
        store(LOC, 0, deferredMoveToAddr);

        /// pC->cacheStatus = CACHE_STALE;
        auto cacheStatusAddr = getElementPtrImm(LOC, T::i32PtrTy, pC, 0, 9);
        store(LOC, CACHE_STALE, cacheStatusAddr);

        /// if (pC->isTable)
        auto isTableAddr = getElementPtrImm(LOC, T::i8PtrTy, pC, 0, 4);
        auto isTable = load(LOC, isTableAddr);

        curBlock = rewriter.getBlock();
        auto blockAfterIsTable = SPLIT_GO_BACK_TO(curBlock);
        auto blockNotIsTable = SPLIT_GO_BACK_TO(curBlock);
        auto blockIsTable = SPLIT_GO_BACK_TO(curBlock);

        auto condIsTable = iCmp(LOC, Pred::ne, isTable, 0);

        condBranch(LOC, condIsTable, blockIsTable, blockNotIsTable);
        { // if (pC->isTable)
            ip_start(blockIsTable);

            /// pIn3 = &aMem[pOp->p3];
            auto pIn3 = getElementPtrImm(LOC, T::sqlite3_valuePtrTy, vdbeCtx->aMem, p3);

            /// flags3 = pIn3->flags;
            auto in3FlagsAddr = getElementPtrImm(LOC, T::i16PtrTy, pIn3, 0, 1);
            auto initialFlags3 = load(LOC, in3FlagsAddr);

            auto in3AndFlags = bitAnd(LOC, initialFlags3, (MEM_Int | MEM_Real | MEM_IntReal | MEM_Str));
            auto in3IsString = iCmp(LOC, Pred::eq, in3AndFlags, MEM_Str);

            auto curBlock = rewriter.getBlock();
            auto blockAfterApplyNumericAff = SPLIT_GO_BACK_TO(curBlock);
            auto blockApplyNumericAff = SPLIT_GO_BACK_TO(curBlock);

            auto condApplyNumericAff = in3IsString;

            condBranch(LOC, condApplyNumericAff, blockApplyNumericAff, blockAfterApplyNumericAff);
            { // if ((flags3 & (MEM_Int | MEM_Real | MEM_IntReal | MEM_Str)) == MEM_Str)
                ip_start(blockApplyNumericAff);

                /// applyNumericAffinity(pIn3, 0);
                applyNumericAffinity(LOC, pIn3, constants(0, 32));

                branch(LOC, blockAfterApplyNumericAff);
            } // end if ((flags3 & (MEM_Int | MEM_Real | MEM_IntReal | MEM_Str)) == MEM_Str)
            ip_start(blockAfterApplyNumericAff);

            /// iKey = sqlite3VdbeIntValue(pIn3);
            auto iKey = call(LOC, f_sqlite3VdbeIntValue, pIn3).getValue();

            /// newType = pIn3->flags;
            auto newType = load(LOC, in3FlagsAddr);

            /// pIn3->flags = flags3;
            store(LOC, initialFlags3, in3FlagsAddr);

            auto newTypeAndIntFlags = bitAnd(LOC, newType, MEM_Int | MEM_IntReal);
            auto newTypeNotInt = iCmp(LOC, Pred::eq, newTypeAndIntFlags, 0);

            curBlock = rewriter.getBlock();
            auto blockAfterNewTypeNotInteger = SPLIT_GO_BACK_TO(curBlock);
            auto blockNewTypeNotInteger = SPLIT_GO_BACK_TO(curBlock);

            condBranch(LOC, newTypeNotInt, blockNewTypeNotInteger, blockAfterNewTypeNotInteger);
            { // if ((newType & (MEM_Int | MEM_IntReal)) == 0)
                ip_start(blockNewTypeNotInteger);

                auto newTypeAndRealFlag = bitAnd(LOC, newType, MEM_Real);
                auto newTypeNotReal = iCmp(LOC, Pred::eq, newTypeAndRealFlag, 0);

                auto curBlock = rewriter.getBlock();
                auto blockAfterNewTypeNotReal = SPLIT_GO_BACK_TO(curBlock);
                auto blockNotNewTypeNotReal = SPLIT_GO_BACK_TO(curBlock);
                auto blockNewTypeNotReal = SPLIT_GO_BACK_TO(curBlock);

                condBranch(LOC, newTypeNotReal, blockNewTypeNotReal, blockNotNewTypeNotReal);
                { // if ((newType & MEM_Real) == 0)
                    ip_start(blockNewTypeNotReal);

                    auto newTypeAndNull = bitAnd(LOC, newType, MEM_Null);
                    auto ocGeSeekGE = constants(initialOc >= OP_SeekGE ? 1 : 0, 1);

                    auto curBlock = rewriter.getBlock();
                    auto blockAfterNoJump = SPLIT_GO_BACK_TO(curBlock);
                    auto blockNoJump = SPLIT_GO_BACK_TO(curBlock);

                    condBranch(LOC, ocGeSeekGE, jumpTo, blockNoJump);

                    { /// else of ((newType & MEM_Null) || oc >= OP_SeekGE)
                        ip_start(blockNoJump);

                        auto rc = call(LOC, f_sqlite3BtreeLast, pCursor, resAddr).getValue();
                        { // if (rc != SQLITE_OK) goto abort_due_to_error;
                            auto rcNull = iCmp(LOC, Pred::eq, rc, 0);
                            myAssert(LOCL, rcNull);
                        } // if (rc != SQLITE_OK) goto abort_due_to_error;

                        /// goto seek_not_found;
                        branch(LOC, blockSeekNotFound);
                    } /// end else of if ((newType & MEM_Null) || oc >= OP_SeekGE)
                    ip_start(blockAfterNoJump);

                    branch(LOC, blockAfterNewTypeNotReal);
                } // end if ((newType & MEM_Real) == 0)
                { // else of if ((newType & MEM_Real) == 0)
                    ip_start(blockNotNewTypeNotReal);

                    auto iKeyDouble = rewriter.create<mlir::LLVM::SIToFPOp>(LOC, T::doubleTy, iKey);
                    auto in3RealAddr = getElementPtrImm(LOC, T::doublePtrTy, pIn3, 0, 0, 0);
                    auto in3Real = load(LOC, in3RealAddr);

                    auto curBlock = rewriter.getBlock();
                    auto blockAfterIn3LtIKey = SPLIT_GO_BACK_TO(curBlock);
                    auto blockIn3LtIKey = SPLIT_GO_BACK_TO(curBlock);

                    auto real3LtIKey = rewriter.create<mlir::LLVM::FCmpOp>(LOC, FCmpPredicate::olt, in3Real, iKeyDouble);
                    condBranch(LOC, real3LtIKey, blockIn3LtIKey, blockAfterIn3LtIKey);
                    { // if (pIn3->u.r < (double) iKey)
                        ip_start(blockIn3LtIKey);

                        auto ocVal = load(LOC, ocAddr);
                        auto ocAnd01 = bitAnd(LOC, ocVal, 0x0001);
                        auto seekGtAnd01 = bitAnd(LOC, constants(OP_SeekGT, 32), 0x0001);
                        auto bothEqual = iCmp(LOC, Pred::eq, ocAnd01, seekGtAnd01);

                        auto curBlock = rewriter.getBlock();
                        auto blockAfterDecrementOC = SPLIT_GO_BACK_TO(curBlock);
                        auto blockDecrementOC = SPLIT_GO_BACK_TO(curBlock);

                        condBranch(LOC, bothEqual, blockDecrementOC, blockAfterDecrementOC);
                        { // if ((oc & 0x0001) == (OP_SeekGT & 0x0001))
                            ip_start(blockDecrementOC);

                            auto newOc = sub(LOC, ocVal, constants(-1, 32));
                            store(LOC, newOc, ocAddr);

                            branch(LOC, blockAfterDecrementOC);
                        } // end if ((oc & 0x0001) == (OP_SeekGT & 0x0001))
                        ip_start(blockAfterDecrementOC);

                        branch(LOC, blockAfterIn3LtIKey);
                    } // end if (pIn3->u.r < (double) iKey)
                    ip_start(blockAfterIn3LtIKey);

                    curBlock = rewriter.getBlock();
                    auto blockAfterIn3GtIKey = SPLIT_GO_BACK_TO(curBlock);
                    auto blockIn3GtIKey = SPLIT_GO_BACK_TO(curBlock);

                    auto real3GtIKey = rewriter.create<mlir::LLVM::FCmpOp>(LOC, FCmpPredicate::ogt, in3Real, iKeyDouble);
                    condBranch(LOC, real3GtIKey, blockIn3GtIKey, blockAfterIn3GtIKey);
                    { // if (pIn3->u.r > (double) iKey)
                        ip_start(blockIn3GtIKey);

                        auto ocVal = load(LOC, ocAddr);
                        auto ocAnd01 = bitAnd(LOC, ocVal, 0x0001);
                        auto seekLtAnd01 = bitAnd(LOC, constants(OP_SeekLT, 32), 0x0001);

                        auto curBlock = rewriter.getBlock();
                        auto blockIncrement = SPLIT_GO_BACK_TO(curBlock);
                        auto blockAfterIncrement = SPLIT_GO_BACK_TO(curBlock);

                        auto bothEqual = iCmp(LOC, Pred::eq, ocAnd01, seekLtAnd01);
                        condBranch(LOC, bothEqual, blockIncrement, blockAfterIncrement);
                        { // if ((oc & 0x0001) == (OP_SeekLT & 0x0001))
                            ip_start(blockIncrement);

                            auto ocPlus1 = add(LOC, ocVal, 1);
                            store(LOC, ocPlus1, ocAddr);

                            branch(LOC, blockAfterIncrement);
                        } // end if ((oc & 0x0001) == (OP_SeekLT & 0x0001))
                        ip_start(blockAfterIncrement);
                        branch(LOC, blockAfterIn3GtIKey);
                    } // end if (pIn3->u.r > (double) iKey)
                    ip_start(blockAfterIn3GtIKey);

                    branch(LOC, blockAfterNewTypeNotReal);
                } // end else of if ((newType & MEM_Real) == 0)
                ip_start(blockAfterNewTypeNotReal);

                branch(LOC, blockAfterNewTypeNotInteger);
            } // end if ((newType & (MEM_Int | MEM_IntReal)) == 0)
            ip_start(blockAfterNewTypeNotInteger);

            /// rc = sqlite3BtreeMovetoUnpacked(pC->uc.pCursor, 0, (u64) iKey, 0, &res);
            auto pCursorAddr = getElementPtrImm(LOC, T::BtCursorPtrTy, pC, 0, 12, 0);
            auto pCursor = load(LOC, pCursorAddr);
            auto rc = call(LOC, f_sqlite3BtreeMovetoUnpacked,
                    pCursor,
                    constants(T::UnpackedRecordPtrTy, (UnpackedRecord*)nullptr),
                    zExt(LOC, iKey, T::i64Ty),
                    constants(0, 32),
                    resAddr).getValue();

            /// pC->movetoTarget = iKey;
            auto moveToTargetAddr = getElementPtrImm(LOC, T::i64PtrTy, pC, 0, 18);
            store(LOC, iKey, moveToTargetAddr);

            { // if (rc != SQLITE_OK) goto abort_due_to_error;
                auto rcOk = iCmp(LOC, Pred::eq, rc, SQLITE_OK);
                myAssert(LOCL, rcOk);
            } // end if (rc != SQLITE_OK) goto abort_due_to_error;

            branch(LOC, blockAfterIsTable);
        } // end if (pC->isTable)
        { // else of if (pC->isTable)
            ip_start(blockNotIsTable);

            /// sqlite3BtreeCursorHasHint(pC->uc.pCursor, BTREE_SEEK_EQ)
            auto pCursorAddr = getElementPtrImm(LOC, T::BtCursorPtrTy, pC, 0, 12, 0);
            auto pCursor = load(LOC, pCursorAddr);
            auto hasHint = call(LOC,
                f_sqlite3BtreeCursorHasHint,
                pCursor
                // Opted constants(BTREE_SEEK_EQ, 32)
            ).getValue();

            auto curBlock = rewriter.getBlock();
            auto blockAfterHasHint = SPLIT_GO_BACK_TO(curBlock);
            auto blockHasHint = SPLIT_GO_BACK_TO(curBlock);

            auto condHasHint = iCmp(LOC, Pred::ne, hasHint, 0);
            condBranch(LOC, condHasHint, blockHasHint, blockAfterHasHint);
            { // if (sqlite3BtreeCursorHasHint(pC->uc.pCursor, BTREE_SEEK_EQ))
                ip_start(blockHasHint);

                store(LOC, 1, eqOnlyAddr);

                branch(LOC, blockAfterHasHint);
            } // end if (sqlite3BtreeCursorHasHint(pC->uc.pCursor, BTREE_SEEK_EQ))
            ip_start(blockAfterHasHint);

            /// nField = pOp->p4.i;
            auto nField = p4;

            auto rAddr = alloca(LOC, T::UnpackedRecordPtrTy);

            /// r.pKeyInfo = pC->pKeyInfo;
            auto RPKeyInfoAddr = getElementPtrImm(LOC, T::KeyInfoPtrTy, rAddr, 0, 0);
            {
                auto keyInfoAddr = getElementPtrImm(LOC, T::KeyInfoPtrTy.getPointerTo(), pC, 0, 13);
                auto keyInfo = load(LOC, keyInfoAddr);
                store(LOC, keyInfo, RPKeyInfoAddr);
            }

            /// r.nField = (u16) nField;
            auto RNFieldAddr = getElementPtrImm(LOC, T::i16PtrTy, rAddr, 0, 2);
            store(LOC, (u16)p4, RNFieldAddr);

            /// r.default_rc = ((1 & (oc - OP_SeekLT)) ? -1 : +1);
            auto rDefaultRcAddr = getElementPtrImm(LOC, T::i8PtrTy, rAddr, 0, 3);
            auto defaultRc = (1 & (initialOc - OP_SeekLT)) ? -1 : +1;
            store(LOC, defaultRc, rDefaultRcAddr);

            /// r.aMem = &aMem[pOp->p3];
            auto rAMemAddr = getElementPtrImm(LOC, T::sqlite3_valuePtrPtrTy, rAddr, 0, 1);
            {
                auto aMem = getElementPtrImm(LOC, T::sqlite3_valuePtrPtrTy, vdbeCtx->aMem, p3);
                store(LOC, aMem, rAMemAddr);
            }

            /// r.eqSeen = 0;
            auto rEqSeenAddr = getElementPtrImm(LOC, T::i8PtrTy, rAddr, 0, 7);
            store(LOC, 0, rEqSeenAddr);

            auto rc = call(LOC, f_sqlite3BtreeMovetoUnpacked,
                    pCursor,
                    rAddr,
                    constants(0, 64),
                    constants(0, 32),
                    resAddr
            ).getValue();

            { // if (rc != SQLITE_OK) goto abort_due_to_error;
                auto rcOk = iCmp(LOC, Pred::eq, rc, SQLITE_OK);
                myAssert(LOCL, rcOk);
            } // end if (rc != SQLITE_OK) goto abort_due_to_error;

            /// if (eqOnly && r.eqSeen == 0)
            auto eqOnly = load(LOC, eqOnlyAddr);
            eqOnly = iCmp(LOC, Pred::ne, eqOnly, 0);
            auto eqSeen = load(LOC, rEqSeenAddr);
            auto eqSeen0 = iCmp(LOC, Pred::eq, eqSeen, 0);
            auto notFound = bitAnd(LOC, eqOnly, eqSeen0);

            curBlock = rewriter.getBlock();
            auto blockAfter = SPLIT_GO_BACK_TO(curBlock);
            condBranch(LOC, notFound, blockSeekNotFound, blockAfter);

            ip_start(blockAfter);
            branch(LOC, blockAfterIsTable);
        } // end else of if (pC->isTable)
        ip_start(blockAfterIsTable);

        auto res = load(LOC, resAddr);
        auto resNull = iCmp(LOC, Pred::eq, res, 0);
        auto oc = load(LOC, ocAddr);
        if (initialOc >= OP_SeekGE) {
            auto resNegative = iCmp(LOC, Pred::slt, res, 0);
            /// if (res < 0 || (res == 0 && oc == OP_SeekGT))
            auto ocIsGt = iCmp(LOC, Pred::eq, oc, OP_SeekGT);
            auto resNullAndOcIsGt = bitAnd(LOC, resNull, ocIsGt);
            auto cond = bitOr(LOC, resNegative, resNullAndOcIsGt);

            auto curBlock = rewriter.getBlock();
            auto blockAfterResNegative = SPLIT_GO_BACK_TO(curBlock);
            auto blockNotResNegative = SPLIT_GO_BACK_TO(curBlock);
            auto blockResNegative = SPLIT_GO_BACK_TO(curBlock);

            condBranch(LOC, cond, blockResNegative, blockNotResNegative);
            { // if (res < 0 || (res == 0 && oc == OP_SeekGT))
                ip_start(blockResNegative);

                /// res = 0;
                store(LOC, 0, resAddr);

                /// rc = sqlite3BtreeNext(pC->uc.pCursor, 0);
                auto rc = call(LOC, f_sqlite3BtreeNext, pCursor, constants(0, 32)).getValue();

                { // if (rc != SQLITE_OK && rc != SQLITE_DONE) goto abort_due_to_error;
                    auto rcOk = iCmp(LOC, Pred::eq, rc, SQLITE_OK);
                    auto rcDone = iCmp(LOC, Pred::eq, rc, SQLITE_DONE);
                    auto rcOkDone = bitOr(LOC, rcOk, rcDone);
                    myAssert(LOCL, rcOkDone);
                } // end if (rc != SQLITE_OK && rc != SQLITE_DONE) goto abort_due_to_error;

                auto curBlock = rewriter.getBlock();
                auto blockAfterDone = SPLIT_GO_BACK_TO(curBlock);
                auto blockDone = SPLIT_GO_BACK_TO(curBlock);

                auto rcIsDone = iCmp(LOC, Pred::eq, rc, SQLITE_DONE);
                condBranch(LOC, rcIsDone, blockDone, blockAfterDone);
                { // if (rc == SQLITE_DONE)
                    ip_start(blockDone);

                    /// res = 1
                    store(LOC, 1, resAddr);

                    branch(LOC, blockAfterDone);
                } // end if (rc == SQLITE_DONE)
                ip_start(blockAfterDone);

                branch(LOC, blockAfterResNegative);
            } // end if (res < 0 || (res == 0 && oc == OP_SeekGT))
            { // else of if (res < 0 || (res == 0 && oc == OP_SeekGT))
                ip_start(blockNotResNegative);

                store(LOC, 0, resAddr);

                branch(LOC, blockAfterResNegative);
            } // end else of if (res < 0 || (res == 0 && oc == OP_SeekGT))
            ip_start(blockAfterResNegative);
        } else {
            auto resPositive = iCmp(LOC, Pred::sgt, res, 0);
            auto ocIsLt = iCmp(LOC, Pred::eq, oc, OP_SeekLT);
            auto ocIsLtAndResNull = bitAnd(LOC, resNull, ocIsLt);
            auto cond = bitOr(LOC, resPositive, ocIsLtAndResNull);

            auto curBlock = rewriter.getBlock();
            auto blockAfterResPositive = SPLIT_GO_BACK_TO(curBlock);
            auto blockNotResPositive = SPLIT_GO_BACK_TO(curBlock);
            auto blockResPositive = SPLIT_GO_BACK_TO(curBlock);

            condBranch(LOC, cond, blockResPositive, blockNotResPositive);
            { // if (res > 0 || (res == 0 && oc == OP_SeekLT))
                ip_start(blockResPositive);

                /// res = 0
                store(LOC, 0, resAddr);

                /// rc = sqlite3BtreePrevious(pC->uc.pCursor, 0);
                auto rc = call(LOC, f_sqlite3BtreePrevious, pCursor, constants(0, 32)).getValue();

                { // if (rc != SQLITE_OK && rc != SQLITE_DONE) goto abort_due_to_error;
                    auto rcOk = iCmp(LOC, Pred::eq, rc, SQLITE_OK);
                    auto rcDone = iCmp(LOC, Pred::eq, rc, SQLITE_DONE);
                    auto rcOkDone = bitOr(LOC, rcOk, rcDone);
                    myAssert(LOCL, rcOkDone);
                } // end if (rc != SQLITE_OK && rc != SQLITE_DONE) goto abort_due_to_error;

                auto curBlock = rewriter.getBlock();
                auto blockAfterDone = SPLIT_GO_BACK_TO(curBlock);
                auto blockDone = SPLIT_GO_BACK_TO(curBlock);

                auto rcIsDone = iCmp(LOC, Pred::eq, rc, SQLITE_DONE);
                condBranch(LOC, rcIsDone, blockDone, blockAfterDone);
                { // if (rc == SQLITE_DONE)
                    ip_start(blockDone);

                    /// res = 1
                    store(LOC, 1, resAddr);

                    branch(LOC, blockAfterDone);
                } // end if (rc == SQLITE_DONE)
                ip_start(blockAfterDone);

                branch(LOC, blockAfterResPositive);
            } // end if (res > 0 || (res == 0 && oc == OP_SeekLT))
            { // else of if (res > 0 || (res == 0 && oc == OP_SeekLT))
                ip_start(blockNotResPositive);

                /// res = sqlite3BtreeEof(pC->uc.pCursor);
                auto rc = call(LOC, f_sqlite3BtreeEof, pCursor).getValue();
                store(LOC, rc, resAddr);

                branch(LOC, blockAfterResPositive);
            } // end else of if (res > 0 || (res == 0 && oc == OP_SeekLT))

            ip_start(blockAfterResPositive);
        }
        branch(LOC, endBlock);

        /// seek_not_found:
        ip_start(blockSeekNotFound);
        branch(LOC, endBlock);
        ip_start(endBlock);

        res = load(LOC, resAddr);
        auto resNotNull = iCmp(LOC, Pred::ne, res, 0);

        curBlock = rewriter.getBlock();
        auto blockNoJump = SPLIT_GO_BACK_TO(curBlock);

        /// if (res) goto jump_to_p2;
        // TODO: Fix stack memory leak
        condBranch(LOC, resNotNull, jumpTo, blockNoJump);

        ip_start(blockNoJump);
        auto eqOnly = load(LOC, eqOnlyAddr);
        auto eqOnlyNotNull = iCmp(LOC, Pred::ne, eqOnly, 0);

        restoreStack(LOC, stackState);
        condBranch(LOC, eqOnlyNotNull, skipNext, fallThrough);

        rewriter.eraseOp(skOp);
        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes