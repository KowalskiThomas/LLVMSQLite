#include "Standalone/ConstantManager.h"
#include "Standalone/Lowering/MyBuilder.h"
#include "Standalone/AllIncludes.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"
#include "Standalone/DebugUtils.h"
#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"

extern LLVMFuncOp f_sqlite3BtreeClearTable;
extern LLVMFuncOp f_sqlite3BtreeOpen;
extern LLVMFuncOp f_sqlite3BtreeCreateTable;

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

        auto pc = oeOp.pcAttr().getUInt();
        auto p1 = oeOp.curIdxAttr().getSInt();
        auto p2 = oeOp.nColumnAttr().getSInt();
        auto p4 = (KeyInfo*) oeOp.btIndexAttr().getUInt();
        auto p5 = oeOp.flagsAttr().getUInt();

        LLVMSQLITE_ASSERT(p1 >= 0);
        LLVMSQLITE_ASSERT(p2 >= 0);

        USE_DEFAULT_BOILERPLATE

        auto firstBlock = rewriter.getBlock();
        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(oeOp);
        GO_BACK_TO(curBlock);

        static const constexpr int vfsFlags =
                SQLITE_OPEN_READWRITE |
                SQLITE_OPEN_CREATE |
                SQLITE_OPEN_EXCLUSIVE |
                SQLITE_OPEN_DELETEONCLOSE |
                SQLITE_OPEN_TRANSIENT_DB;

        auto stackState = saveStack(LOC);

        /// VdbeCursor *pCx;
        auto pCxAddr = alloca(LOC, T::VdbeCursorPtrPtrTy);
        auto rcAddr = alloca(LOC, T::i32PtrTy);

        /// pCx = p->apCsr[pOp->p1];
        auto existingPCxAddr = getElementPtrImm(LOC, T::VdbeCursorPtrPtrTy, vdbeCtx->apCsr, p1);
        auto initialPCxValue = load(LOC, existingPCxAddr);
        store(LOC, initialPCxValue, pCxAddr);

        curBlock = rewriter.getBlock();
        auto blockAfterAlreadyOpen = SPLIT_GO_BACK_TO(curBlock);
        auto blockNotAlreadyOpen = SPLIT_GO_BACK_TO(curBlock);
        auto blockPCxNotNull = SPLIT_GO_BACK_TO(curBlock);

        auto pCxNotNull = iCmp(LOC, Pred::ne, initialPCxValue, nullptr);

        condBranch(LOC, pCxNotNull, blockPCxNotNull, blockNotAlreadyOpen);
        { // if (pCx)
            ip_start(blockPCxNotNull);
            // Ephemeral table is already open

            auto pCx = initialPCxValue;

            auto pBtxAddr = getElementPtrImm(LOC, T::BtreePtrTy.getPointerTo(), pCx, 0, 6);
            auto pBtx = load(LOC, pBtxAddr);
            auto pBtxNotNull = iCmp(LOC, Pred::ne, pBtx, nullptr);

            curBlock = rewriter.getBlock();
            auto blockAlreadyOpen = SPLIT_GO_BACK_TO(curBlock);

            condBranch(LOC, pBtxNotNull, blockAlreadyOpen, blockNotAlreadyOpen);
            { // if (pCx && pCx->pBtx)
                ip_start(blockAlreadyOpen);

                /// pCx->seqCount = 0;
                auto seqCountAddr = getElementPtrImm(LOC, T::i64PtrTy, pCx, 0, 7);
                store(LOC, 0, seqCountAddr);

                /// pCx->cacheStatus = CACHE_STALE;
                auto cacheStatusAddr = getElementPtrImm(LOC, T::i32PtrTy, pCx, 0, 9);
                store(LOC, CACHE_STALE, cacheStatusAddr);

                /// rc = sqlite3BtreeClearTable(pCx->pBtx, pCx->pgnoRoot, 0);
                auto pgnoRootAddr = getElementPtrImm(LOC, T::i32PtrTy, pCx, 0, 15);
                auto pgnoRoot = load(LOC, pgnoRootAddr);

                auto rc = call(LOC, f_sqlite3BtreeClearTable,
                    pBtx,
                    pgnoRoot,
                    constants(T::i32PtrTy, (int *)nullptr)
                ).getValue();
                store(LOC, rc, rcAddr);

                branch(LOC, blockAfterAlreadyOpen);
            } // end if (pCx && pCx->pBtx)
        } // end if (pCx)
        { // else of if (pCx)
            ip_start(blockNotAlreadyOpen);

            /// pCx = allocateCursor(p, pOp->p1, pOp->p2, -1, CURTYPE_BTREE);
            auto pCx = call(LOC, f_allocateCursor,
                vdbeCtx->p,
                /* iCur = */ constants(p1, 32),
                /* nField = */ constants(p2, 32),
                /* iDb = */ constants(-1, 32),
                /* curType = */ constants(CURTYPE_BTREE, 8)
            ).getValue();
            store(LOC, pCx, pCxAddr);

            { // if (pCx == 0) goto no_mem
                auto pCxNotNull = iCmp(LOC, Pred::ne, pCx, nullptr);
                myAssert(LOCL, pCxNotNull);
            } // end if (pCx == 0) goto no_mem

            /// pCx->isEphemeral = 1;
            // isEphemeral is a bitfield of width 1, so we need to do that bit-or
            auto isEphemeralAddr = getElementPtrImm(LOC, T::i8PtrTy, pCx, 0, 5);
            auto isEphemeral = load(LOC, isEphemeralAddr);
            isEphemeral = bitOr(LOC, isEphemeral, 1);
            store(LOC, isEphemeral, isEphemeralAddr);

            /// rc = sqlite3BtreeOpen(db->pVfs, 0, db, &pCx->pBtx, ...)
            // Get db->pVfs
            auto pVfsAddr = getElementPtrImm(LOC, T::sqlite3_vfsPtrTy.getPointerTo(), vdbeCtx->db, 0, 0);
            auto pVfs = load(LOC, pVfsAddr);

            // Get &pCx->pBtx
            auto pBtxAddr = getElementPtrImm(LOC, T::BtreePtrTy.getPointerTo(), pCx, 0, 6);

            auto rc = call(LOC, f_sqlite3BtreeOpen,
                pVfs,
                constants(T::i8PtrTy, (const char*)nullptr),
                vdbeCtx->db,
                pBtxAddr,
                constants(BTREE_OMIT_JOURNAL | BTREE_SINGLE | p5, 32),
                constants(vfsFlags, 32)
            ).getValue();
            store(LOC, rc, rcAddr);

            auto curBlock = rewriter.getBlock();
            auto blockAfterRcIsOk = SPLIT_GO_BACK_TO(curBlock);
            auto blockRcIsOk = SPLIT_GO_BACK_TO(curBlock);

            auto condRcIsOk = iCmp(LOC, Pred::eq, rc, SQLITE_OK);

            condBranch(LOC, condRcIsOk, blockRcIsOk, blockAfterRcIsOk);
            { // if (rc == SQLITE_OK)
                ip_start(blockRcIsOk);

                auto pBtx = load(LOC, pBtxAddr);
                auto rc = call(LOC, f_sqlite3BtreeBeginTrans,
                    pBtx,
                    constants(1, 32),
                    constants(T::i32PtrTy, (int *) nullptr)
                ).getValue();
                store(LOC, rc, rcAddr);

                branch(LOC, blockAfterRcIsOk);
            } // end if (rc == SQLITE_OK)
            ip_start(blockAfterRcIsOk);

            curBlock = rewriter.getBlock();
            auto blockAfterRcIsOk2 = SPLIT_GO_BACK_TO(curBlock);
            auto blockRcIsOk2 = SPLIT_GO_BACK_TO(curBlock);

            auto lastRc = load(LOC, rcAddr);
            auto condRcIsOk2 = iCmp(LOC, Pred::eq, lastRc, SQLITE_OK);

            condBranch(LOC, condRcIsOk2, blockRcIsOk2, blockAfterRcIsOk2);
            { // if (rc == SQLITE_OK)
                ip_start(blockRcIsOk2);

                auto pKeyInfo = constants(T::KeyInfoPtrTy, p4);
                /*
                {
                    auto keyInfoRefCount = getElementPtrImm(LOC, T::i32PtrTy, pKeyInfo, 0, 0);
                    auto refCountVal = load(LOC, keyInfoRefCount);
                    refCountVal = add(LOC, refCountVal, 1);
                    store(LOC, refCountVal, keyInfoRefCount);
                }
                */

                auto pCxKeyInfoAddr = getElementPtrImm(LOC, T::KeyInfoPtrTy.getPointerTo(), pCx, 0, 13);
                store(LOC, pKeyInfo, pCxKeyInfoAddr);

                // Get (int*)&pCx->pgnoRoot
                auto pgnoRootAddr = getElementPtrImm(LOC, T::i32PtrTy, pCx, 0, 15);

                // Get pCx->uc.pCursor
                auto pCursorAddr = getElementPtrImm(LOC, T::BtCursorPtrTy, pCx, 0, 12, 0);

                auto curBlock = rewriter.getBlock();
                auto blockAfterKeyInfoNotNull = SPLIT_GO_BACK_TO(curBlock);
                auto blockNotKeyInfoNotNull = SPLIT_GO_BACK_TO(curBlock);
                auto blockKeyInfoNotNull = SPLIT_GO_BACK_TO(curBlock);

                auto condKeyInfoNotNull = iCmp(LOC, Pred::ne, pKeyInfo, nullptr);

                condBranch(LOC, condKeyInfoNotNull, blockKeyInfoNotNull, blockNotKeyInfoNotNull);
                { // if ((pCx->pKeyInfo = pKeyInfo = pOp->p4.pKeyInfo) != 0)
                    ip_start(blockKeyInfoNotNull);

                    /// rc = sqlite3BtreeCreateTable(pCx->pBtx, (int *) &pCx->pgnoRoot, BTREE_BLOBKEY | pOp->p5);
                    auto pBtx = load(LOC, pBtxAddr);
                    auto rc = call(LOC, f_sqlite3BtreeCreateTable,
                        pBtx,
                        pgnoRootAddr,
                        constants(BTREE_BLOBKEY | p5, 32)
                    ).getValue();
                    store(LOC, rc, rcAddr);

                    auto curBlock = rewriter.getBlock();
                    auto blockAfterCreateTableOk = SPLIT_GO_BACK_TO(curBlock);
                    auto blockCreateTableOk = SPLIT_GO_BACK_TO(curBlock);

                    auto condCreateTableOk = iCmp(LOC, Pred::eq, rc, SQLITE_OK);

                    condBranch(LOC, condCreateTableOk, blockCreateTableOk, blockAfterCreateTableOk);
                    { // if (rc == SQLITE_OK)
                        ip_start(blockCreateTableOk);

                        /// rc = sqlite3BtreeCursor(pCx->pBtx, pCx->pgnoRoot, BTREE_WRCSR, pKeyInfo, pCx->uc.pCursor);
                        auto pCursor = load(LOC, pCursorAddr);
                        auto pgnoRoot = load(LOC, pgnoRootAddr);
                        auto rc = call(LOC, f_sqlite3BtreeCursor,
                            pBtx,
                            pgnoRoot,
                            constants(BTREE_WRCSR, 32),
                            pKeyInfo,
                            pCursor
                        ).getValue();
                        store(LOC, rc, rcAddr);

                        branch(LOC, blockAfterCreateTableOk);
                    } // end if (rc == SQLITE_OK)

                    ip_start(blockAfterCreateTableOk);

                    /// pCx->isTable = 0;
                    auto isTableAddr = getElementPtrImm(LOC, T::i8PtrTy, pCx, 0, 4);
                    store(LOC, 0, isTableAddr);

                    branch(LOC, blockAfterKeyInfoNotNull);
                } // end if ((pCx->pKeyInfo = pKeyInfo = pOp->p4.pKeyInfo) != 0)
                { // else of if ((pCx->pKeyInfo = pKeyInfo = pOp->p4.pKeyInfo) != 0)
                    ip_start(blockNotKeyInfoNotNull);

                    /// pCx->pgnoRoot = MASTER_ROOT;
                    store(LOC, MASTER_ROOT, pgnoRootAddr);

                    /// rc = sqlite3BtreeCursor(pCx->pBtx, MASTER_ROOT, BTREE_WRCSR, 0, pCx->uc.pCursor);
                    auto pCursor = load(LOC, pCursorAddr);
                    auto pBtx = load(LOC, pBtxAddr);
                    auto rc = call(LOC, f_sqlite3BtreeCursor,
                                   pBtx,
                                   constants(MASTER_ROOT, 32),
                                   constants(BTREE_WRCSR, 32),
                                   constants(T::KeyInfoPtrTy, (KeyInfo*)nullptr),
                                   pCursor
                    ).getValue();
                    store(LOC, rc, rcAddr);

                    /// pCx->isTable = 1;
                    auto isTableAddr = getElementPtrImm(LOC, T::i8PtrTy, pCx, 0, 4);
                    store(LOC, 1, isTableAddr);

                    branch(LOC, blockAfterKeyInfoNotNull);
                } // end else of if ((pCx->pKeyInfo = pKeyInfo = pOp->p4.pKeyInfo) != 0)

                ip_start(blockAfterKeyInfoNotNull);

                branch(LOC, blockAfterRcIsOk2);
            } // end if (rc == SQLITE_OK)

            ip_start(blockAfterRcIsOk2);

            /// pCx->isOrdered = (pOp->p5 != BTREE_UNORDERED);
            // isOrdered is a bitfield of width 1 so we need the bitwise or
            pCx = load(LOC, pCxAddr);
            auto isOrderedAddr = getElementPtrImm(LOC, T::i8PtrTy, pCx, 0, 5);
            auto isOrdered = load(LOC, isOrderedAddr);
            isOrdered = bitOr(LOC, isOrdered, (p5 != BTREE_UNORDERED) ? 1 : 0);
            store(LOC, isOrdered, isOrderedAddr);

            branch(LOC, blockAfterAlreadyOpen);
        } // end else of if (pCx)

        ip_start(blockAfterAlreadyOpen);

        { // if (rc) goto abort_due_to_error;
            auto rcVal = load(LOC, rcAddr);
            auto rcNull = iCmp(LOC, Pred::eq, rcVal, 0);
            myAssert(LOCL, rcNull);
        } // if (rc) goto abort_due_to_error;

        /// pCx->nullRow = 1;
        auto pCx = load(LOC, pCxAddr);
        auto nullRowAddr = getElementPtrImm(LOC, T::i8PtrTy, pCx, 0, 2);
        store(LOC, 1, nullRowAddr);

        branch(LOC, endBlock);

        ip_start(endBlock);

        restoreStack(LOC, stackState);
        rewriter.eraseOp(oeOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes