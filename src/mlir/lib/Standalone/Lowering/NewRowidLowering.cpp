#include "Standalone/ConstantManager.h"
#include "Standalone/Lowering/MyBuilder.h"
#include "Standalone/AllIncludes.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"
#include "Standalone/Lowering/OutToPrerelease.h"

#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"

#ifdef SQLITE_32BIT_ROWID
#   define MAX_ROWID 0x7fffffff
#else
#   define MAX_ROWID  (i64)( (((u64)0x7fffffff)<<32) | (u64)0xffffffff )
#endif

extern LLVMFuncOp f_sqlite3BtreeIntegerKey;
extern LLVMFuncOp f_sqlite3BtreeLast;
extern LLVMFuncOp f_sqlite3VdbeMemIntegerify;
extern LLVMFuncOp f_sqlite3_randomness;
extern LLVMFuncOp f_sqlite3BtreeMovetoUnpacked;

namespace mlir::standalone::passes {
    LogicalResult NewRowidLowering::matchAndRewrite(NewRowid nriOp, PatternRewriter &rewriter) const {
        auto op = &nriOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        myOperators

        auto pc = nriOp.pcAttr().getUInt();
        auto p1 = nriOp.p1Attr().getSInt();
        auto p2 = nriOp.p2Attr().getSInt();
        auto p3 = nriOp.p3Attr().getSInt();

        USE_DEFAULT_BOILERPLATE

        auto firstBlock = rewriter.getBlock();
        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(nriOp); GO_BACK_TO(curBlock);

        auto stackState = saveStack(LOC);

        auto vAddr = alloca(LOC, T::i64PtrTy);
        store(LOC, 0, vAddr);

        auto resAddr = alloca(LOC, T::i32PtrTy);
        store(LOC, 0, resAddr);

        auto pMemAddr = alloca(LOC, T::sqlite3_valuePtrPtrTy);

        /// pOut = out2Prerelease(p, pOp);
        auto outToPrerelease = Inlining::OutToPrerelease(*vdbeCtx, *ctx, rewriter, print, constants);
        auto pOp = getElementPtrImm(LOC, T::VdbeOpPtrTy, vdbeCtx->aOp, (int)pc);
        auto pOut = outToPrerelease(LOC, vdbeCtx->p, pOp);

        /// pC = p->apCsr[pOp->p1]
        auto pCAddr = getElementPtrImm(LOC, T::VdbeCursorPtrPtrTy, vdbeCtx->apCsr, p1);
        auto pC = load(LOC, pCAddr);

        auto pCursorAddr = getElementPtrImm(LOC, T::BtCursorPtrTy, pC, 0, 12, 0);
        auto pCursor = load(LOC, pCursorAddr);

        { // anonymous scope
            /// if (!pC->useRandomRowid)
            auto useRandomRowidAddr = getElementPtrImm(LOC, T::i8PtrTy, pC, 0, 5);
            auto mixedFlags = load(LOC, useRandomRowidAddr);
            auto useRandomRowid = bitAnd(LOC, mixedFlags, 2);

            auto curBlock = rewriter.getBlock();
            auto blockAfterUseRandomRowId = SPLIT_GO_BACK_TO(curBlock);
            auto blockUseRandomRowId = SPLIT_GO_BACK_TO(curBlock);

            auto condUseRandomRowId = iCmp(LOC, Pred::ne, useRandomRowid, 0);

            condBranch(LOC, condUseRandomRowId, blockUseRandomRowId, blockAfterUseRandomRowId);
            { // if (!pC->useRandomRowid)
                ip_start(blockUseRandomRowId);

                auto rc = call(LOC, f_sqlite3BtreeLast, pCursor, resAddr).getValue();

                { // if (rc != SQLITE_OK) goto abort_due_to_error
                    auto rcNull = iCmp(LOC, Pred::eq, rc, SQLITE_OK);
                    myAssert(LOCL, rcNull);
                } // end if (rc != SQLITE_OK) goto abort_due_to_error

                auto curBlock = rewriter.getBlock();
                auto blockAfterResNotNull = SPLIT_GO_BACK_TO(curBlock);
                auto blockNotResNotNull = SPLIT_GO_BACK_TO(curBlock);
                auto blockResNotNull = SPLIT_GO_BACK_TO(curBlock);

                auto res = load(LOC, resAddr);
                auto condResNotNull = iCmp(LOC, Pred::ne, res, 0);

                condBranch(LOC, condResNotNull, blockResNotNull, blockNotResNotNull);
                { // if (res)
                    ip_start(blockResNotNull);

                    /// v = 1;
                    store(LOC, 1, vAddr);

                    branch(LOC, blockAfterResNotNull);
                } // end if (res)
                { // else of if (res)
                    ip_start(blockNotResNotNull);

                    /// v = sqlite3BtreeIntegerKey(pC->uc.pCursor);
                    auto vVal = call(LOC, f_sqlite3BtreeIntegerKey, pCursor).getValue();
                    store(LOC, vVal, vAddr);

                    auto curBlock = rewriter.getBlock();
                    auto blockAfterVGeMaxRowId = SPLIT_GO_BACK_TO(curBlock);
                    auto blockNotVGeMaxRowId = SPLIT_GO_BACK_TO(curBlock);
                    auto blockVGeMaxRowId = SPLIT_GO_BACK_TO(curBlock);

                    auto condVGeMaxRowId = iCmp(LOC, Pred::sge, vVal, MAX_ROWID);

                    condBranch(LOC, condVGeMaxRowId, blockVGeMaxRowId, blockNotVGeMaxRowId);
                    { // if (v >= MAX_ROWID)
                        ip_start(blockVGeMaxRowId);

                        /// pC->useRandomRowid = 1;
                        store(LOC, 1, useRandomRowidAddr);

                        branch(LOC, blockAfterVGeMaxRowId);
                    } // end if (v >= MAX_ROWID)
                    { // else of if (v >= MAX_ROWID)
                        ip_start(blockNotVGeMaxRowId);

                        /// v++;
                        vVal = add(LOC, vVal, 1);
                        store(LOC, vVal, vAddr);

                        branch(LOC, blockAfterVGeMaxRowId);
                    } // end else of if (v >= MAX_ROWID)
                    ip_start(blockAfterVGeMaxRowId);

                    branch(LOC, blockAfterResNotNull);
                } // end else of if (res)
                ip_start(blockAfterResNotNull);

                branch(LOC, blockAfterUseRandomRowId);
            } // end if (!pC->useRandomRowid)
            ip_start(blockAfterUseRandomRowId);

            if (p3) {
                auto pFrameAddr = getElementPtrImm(LOC, T::VdbeFramePtrTy.getPointerTo(), vdbeCtx->p, 0, 43);
                auto pFrame = load(LOC, pFrameAddr);

                auto curBlock = rewriter.getBlock();
                auto blockAfterPFrameNotNull = SPLIT_GO_BACK_TO(curBlock);
                auto blockNotPFrameNotNull = SPLIT_GO_BACK_TO(curBlock);
                auto blockPFrameNotNull = SPLIT_GO_BACK_TO(curBlock);

                auto condPFrameNotNull = iCmp(LOC, Pred::ne, pFrame, constants(T::VdbeFramePtrTy, (VdbeFrame*)nullptr));

                condBranch(LOC, condPFrameNotNull, blockPFrameNotNull, blockNotPFrameNotNull);
                { // if (p->pFrame)
                    ip_start(blockPFrameNotNull);

                    print(LOCL, "TODO: if (p->pFrame != nullptr)");

                    branch(LOC, blockAfterPFrameNotNull);
                } // end if (p->pFrame)
                { // else of if (p->pFrame)
                    ip_start(blockNotPFrameNotNull);

                    /// pMem = &aMem[pOp->p3];
                    auto pMem = getElementPtrImm(LOC, T::sqlite3_valuePtrTy, vdbeCtx->aMem, p3);
                    store(LOC, pMem, pMemAddr);

                    branch(LOC, blockAfterPFrameNotNull);
                } // end else of if (p->pFrame)
                ip_start(blockAfterPFrameNotNull);

                /// sqlite3VdbeMemIntegerify(pMem);
                auto pMem = load(LOC, pMemAddr);
                call(LOC, f_sqlite3VdbeMemIntegerify, pMem);

                auto pMemUAddr = getElementPtrImm(LOC, T::doublePtrTy, pMem, 0, 0);
                auto pMemIntAddr = bitCast(LOC, pMemUAddr, T::i64PtrTy);
                auto pMemInt = load(LOC, pMemIntAddr);
                auto pMemIntIsMaxRowid = iCmp(LOC, Pred::eq, pMemInt, MAX_ROWID);

                auto mixedFlags = load(LOC, useRandomRowidAddr);
                auto useRandomRowid = bitAnd(LOC, mixedFlags, 2);
                useRandomRowid = iCmp(LOC, Pred::ne, useRandomRowid, 0);

                curBlock = rewriter.getBlock();
                auto blockAfter = SPLIT_GO_BACK_TO(curBlock);
                auto block = SPLIT_GO_BACK_TO(curBlock);
                
                auto cond = bitOr(LOC, useRandomRowid, pMemIntIsMaxRowid);
                
                condBranch(LOC, cond, block, blockAfter);
                { // if (pMem->u.i == MAX_ROWID || pC->useRandomRowid)
                    ip_start(block);

                    print(LOCL, "rc = SQLITE_FULL");
                    myAssert(LOCL, constants(0, 1));
                
                    branch(LOC, blockAfter);
                } // end if (pMem->u.i == MAX_ROWID || pC->useRandomRowid)

                auto v = load(LOC, vAddr);
                auto pMemIntPlus1 = add(LOC, pMemInt, 1);

                curBlock = rewriter.getBlock();
                auto blockAfterSetVToPMemInt = SPLIT_GO_BACK_TO(curBlock);
                auto blockSetVToPMemInt = SPLIT_GO_BACK_TO(curBlock);

                auto condSetVToPMemInt = iCmp(LOC, Pred::slt, v, pMemIntPlus1);

                condBranch(LOC, condSetVToPMemInt, blockSetVToPMemInt, blockAfterSetVToPMemInt);
                { // if (v < pMem->u.i + 1)
                    ip_start(blockSetVToPMemInt);

                    /// v = pMem->u.i + 1;
                    store(LOC, pMemIntPlus1, vAddr);

                    branch(LOC, blockAfterSetVToPMemInt);
                } // end if (v < pMem->u.i + 1)
                ip_start(blockAfterSetVToPMemInt);

                v = load(LOC, vAddr);
                store(LOC, v, pMemIntAddr);

                ip_start(blockAfter);
            } // end if (p3)

            curBlock = rewriter.getBlock();
            auto blockAfterUseRandomRowid = SPLIT_GO_BACK_TO(curBlock);
            auto blockUseRandomRowid = SPLIT_GO_BACK_TO(curBlock);

            mixedFlags = load(LOC, useRandomRowidAddr);
            useRandomRowid = bitAnd(LOC, mixedFlags, 2);
            auto condUseRandomRowid = iCmp(LOC, Pred::ne, useRandomRowid, 0);

            condBranch(LOC, condUseRandomRowid, blockUseRandomRowid, blockAfterUseRandomRowid);
            { // if (pC->useRandomRowid)
                ip_start(blockUseRandomRowid);

                /// cnt = 0
                auto cntAddr = alloca(LOC, T::i32PtrTy);

                auto curBlock = rewriter.getBlock();
                auto dwAfterBlock = SPLIT_GO_BACK_TO(curBlock);
                auto dwCondBlock = SPLIT_GO_BACK_TO(curBlock);
                auto dwBodyBlock = SPLIT_GO_BACK_TO(curBlock);

                branch(LOC, dwBodyBlock);
                { // Do-while body
                    ip_start(dwBodyBlock);

                    /// sqlite3_randomness(sizeof(v), &v);
                    call(LOC, f_sqlite3_randomness,
                            constants(builder.getBitWidth(vAddr.getType().cast<LLVMType>().getPointerElementTy()) / CHAR_BIT, 32),
                            bitCast(LOC, vAddr, T::i8PtrTy)
                        );

                    /// v &= (MAX_ROWID >> 1);
                    auto v = load(LOC, vAddr);
                    auto shiftedMaxRowId = MAX_ROWID >> 1;
                    v = bitAnd(LOC, v, shiftedMaxRowId);

                    /// v++;
                    v = add(LOC, v, 1);
                    store(LOC, v, vAddr);

                    branch(LOC, dwCondBlock);
                } // End do-while body
                { // Do-while condition block
                    ip_start(dwCondBlock);

                    /// (rc = sqlite3BtreeMovetoUnpacked(pC->uc.pCursor, 0, (u64) v, 0, &res)) == SQLITE_OK
                    auto rc = call(LOC, f_sqlite3BtreeMovetoUnpacked,
                            pCursor,
                            constants(T::UnpackedRecordPtrTy, (UnpackedRecord*)nullptr),
                            load(LOC, vAddr),
                            constants(0, 32),
                            resAddr
                    ).getValue();
                    auto rcOk = iCmp(LOC, Pred::eq, rc, SQLITE_OK);

                    /// && (res == 0)
                    auto res = load(LOC, resAddr);
                    auto res0 = iCmp(LOC, Pred::eq, res, 0);

                    /// && (++cnt < 100)
                    auto cnt = load(LOC, cntAddr);
                    cnt = add(LOC, cnt, 1);
                    store(LOC, cnt, cntAddr);
                    auto cntLt100 = iCmp(LOC, Pred::slt, cnt, 100);

                    // Build the full condition
                    auto cond = bitAnd(LOC, rcOk, res0);
                    cond = bitAnd(LOC, cond, cntLt100);

                    condBranch(LOC, cond, dwBodyBlock, dwAfterBlock);
                } // End do-while condition block
                ip_start(dwAfterBlock);

                branch(LOC, blockAfterUseRandomRowid);
            } // end if (pC->useRandomRowid)
            ip_start(blockAfterUseRandomRowid);

            /// pC->deferredMoveto = 0;
            auto deferredMoveToAddr = getElementPtrImm(LOC, T::i8PtrTy, pC, 0, 3);
            store(LOC, 0, deferredMoveToAddr);

            /// pC->cacheStatus = CACHE_STALE;
            auto cacheStatusAddr = getElementPtrImm(LOC, T::i32PtrTy, pC, 0, 9);
            store(LOC, CACHE_STALE, cacheStatusAddr);
        } // end anonymous scope

        branch(LOC, endBlock);
        ip_start(endBlock);

        /// pOut->u.i = v;
        auto pOutUAddr = getElementPtrImm(LOC, T::doublePtrTy, pOut, 0, 0);
        auto pOutIntAddr = bitCast(LOC, pOutUAddr, T::i64PtrTy);
        auto v = load(LOC, vAddr);
        store(LOC, v, pOutIntAddr);

        restoreStack(LOC, stackState);
        rewriter.eraseOp(nriOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes