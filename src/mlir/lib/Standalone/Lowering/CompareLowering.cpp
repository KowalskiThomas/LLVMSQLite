#include "Standalone/ConstantManager.h"
#include "Standalone/Lowering/MyBuilder.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"
#include "Standalone/StandalonePasses.h"
#include "Standalone/DebugUtils.h"

ExternFuncOp f_sqlite3MemCompare;

namespace mlir::standalone::passes {
    LogicalResult CompareLowering::matchAndRewrite(Compare compOp, PatternRewriter &rewriter) const {
        auto op = &compOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        myOperators

        print(LOCL, "-- Compare");

        auto stackState = saveStack(LOC);

        auto firstBlock = rewriter.getBlock();

        // First LHS = p1
        auto firstLhs = compOp.firstLhsAttr().getSInt();
        // First RHS = p2
        auto firstRhs = compOp.firstRhsAttr().getSInt();
        // nReg = p3
        auto nReg = compOp.nRegAttr().getSInt();
        // keyInfo = p4
        auto keyInfo = (KeyInfo*)compOp.keyInfoAttr().getUInt();
        // flags = p5
        auto flags = compOp.flagsAttr().getSInt();
        // pOp = &  aOp[pc]
        auto pc = compOp.pcAttr().getUInt();
        auto pOp = &vdbe->aOp[pc];

        USE_DEFAULT_BOILERPLATE

        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(compOp); GO_BACK_TO(curBlock);

        auto aPermuteInitValue = (int*)(nullptr);
        auto aPermuteAddr = alloca(LOC, T::i32PtrTy.getPointerTo());

        if ((flags & OPFLAG_PERMUTE) == 0) {
            /// aPermute = 0
            store(LOC, constants(T::i32PtrTy, (int*)nullptr), aPermuteAddr);
            aPermuteInitValue = nullptr;
        } else {
            LLVMSQLITE_ASSERT(pOp > vdbe->aOp);
            LLVMSQLITE_ASSERT(pOp[-1].opcode == OP_Permutation);
            LLVMSQLITE_ASSERT(pOp[-1].p4type == P4_INTARRAY);
            /// aPermute = pOp[-1].p4.ai + 1;
            auto pOpValue = getElementPtrImm(LOC, T::VdbeOpPtrTy, vdbeCtx->aOp, (int)(pc - 1));
            auto p4UAddr = getElementPtrImm(LOC, T::p4unionPtrTy, pOpValue, 0, 6);
            auto p4i32PtrAddr = bitCast(LOC, p4UAddr, T::i32PtrTy.getPointerTo());
            auto p4i32Ptr = load(LOC, p4i32PtrAddr);
            p4i32Ptr = ptrToInt(LOC, p4i32Ptr);
            p4i32Ptr = add(LOC, p4i32Ptr, 1);
            p4i32Ptr = rewriter.create<mlir::LLVM::IntToPtrOp>(LOC, T::i32PtrTy, p4i32Ptr);
            store(LOC, p4i32Ptr, aPermuteAddr);
        }

        curBlock = rewriter.getBlock();
        auto blockAfterFor = SPLIT_BLOCK; GO_BACK_TO(curBlock);

        auto pOpValue = getElementPtrImm(LOC, T::VdbeOpPtrTy, vdbeCtx->aOp, (int)pc);
        auto p4UAddr = getElementPtrImm(LOC, T::p4unionPtrTy, pOpValue, 0, 6);
        auto p4KeyInfoPtrAddr = bitCast(LOC, p4UAddr, T::KeyInfoPtrTy.getPointerTo());
        auto p4KeyInfoPtr = load(LOC, p4KeyInfoPtrAddr);
        auto aColl = getElementPtrImm(LOC, T::CollSeqPtrTy.getPointerTo(), p4KeyInfoPtr, 0, 6, 0);
        auto aSortFlagsAddr = getElementPtrImm(LOC, T::i8PtrTy, p4KeyInfoPtr, 0, 5);
        auto aSortFlags = load(LOC, aSortFlagsAddr);

        for(auto i = 0llu; i < nReg; i++) {
            auto idx = (int)(aPermuteInitValue ? aPermuteInitValue[i] : i);

            auto pCollAddr = getElementPtrImm(LOC, T::CollSeqPtrTy, aColl, (int)i);
            auto pColl = load(LOC, pCollAddr);

            // auto bRev = (pKeyInfo->aSortFlags[i] & KEYINFO_ORDER_DESC);
            auto sortFlagsAddr = getElementPtrImm(LOC, T::i8PtrTy, aSortFlags, (int)i);
            auto sortFlags = load(LOC, sortFlagsAddr);
            auto bRev = bitAnd(LOC, sortFlags, KEYINFO_ORDER_DESC);

            auto lhs = getElementPtrImm(LOC, T::sqlite3_valuePtrTy, vdbeCtx->aMem, firstLhs + idx);
            auto rhs = getElementPtrImm(LOC, T::sqlite3_valuePtrTy, vdbeCtx->aMem, firstRhs + idx);
            auto iCompareValue = call(LOC, f_sqlite3MemCompare, lhs, rhs, pColl).getValue();
            store(LOC, iCompareValue, vdbeCtx->iCompare);
            auto iCompareNotNull = iCmp(LOC, Pred::ne, iCompareValue, 0);

            auto curBlock = rewriter.getBlock();
            auto blockAfterICompareNotNull = SPLIT_BLOCK; GO_BACK_TO(curBlock);
            auto blockICompareNotNull = SPLIT_BLOCK; GO_BACK_TO(curBlock);

            condBranch(LOC, iCompareNotNull, blockICompareNotNull, blockAfterICompareNotNull);
            { // if (iCompare)
                ip_start(blockICompareNotNull);

                auto curBlock = rewriter.getBlock();
                auto blockAfterBigNull = SPLIT_GO_BACK_TO(curBlock);
                auto blockBigNull = SPLIT_GO_BACK_TO(curBlock);

                auto bigNull = bitAnd(LOC, sortFlags, KEYINFO_ORDER_BIGNULL);
                auto condBigNull = iCmp(LOC, Pred::ne, bigNull, 0);

                condBranch(LOC, condBigNull, blockBigNull, blockAfterBigNull);
                { // if (pKeyInfo->aSortFlags[i] & KEYINFO_ORDER_BIGNULL)
                    ip_start(blockBigNull);

                    curBlock = rewriter.getBlock();
                    auto blockAfterAnyNull = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                    auto blockAnyNull = SPLIT_BLOCK; GO_BACK_TO(curBlock);

                    mlir::Value anyNull;
                    { // Determine ((aMem[p1 + idx].flags & MEM_Null) || (aMem[p2 + idx].flags & MEM_Null))
                        auto lhsFlagsAddr = getElementPtrImm(LOC, T::i16PtrTy, vdbeCtx->aMem, firstLhs + idx, 1);
                        auto lhsFlags = load(LOC, lhsFlagsAddr);
                        auto lhsNull16 = bitAnd(LOC, lhsFlags, MEM_Null);
                        auto lhsNull = iCmp(LOC, Pred::ne, lhsNull16, 0);

                        auto rhsFlagsAddr = getElementPtrImm(LOC, T::i16PtrTy, vdbeCtx->aMem, firstRhs + idx, 1);
                        auto rhsFlags = load(LOC, rhsFlagsAddr);
                        auto rhsNull16 = bitAnd(LOC, rhsFlags, MEM_Null);
                        auto rhsNull = iCmp(LOC, Pred::ne, rhsNull16, 0);

                        anyNull = bitOr(LOC, lhsNull, rhsNull);
                    } // End determine ((aMem[p1 + idx].flags & MEM_Null) || (aMem[p2 + idx].flags & MEM_Null))

                    condBranch(LOC, anyNull, blockAnyNull, blockAfterAnyNull);
                    { // if (aMem[p1 + idx].flags & MEM_Null) || (aMem[p2 + idx].flags & MEM_Null)
                        ip_start(blockAnyNull);

                        auto negICompare = sub(LOC, constants(0, 32), iCompareValue);
                        store(LOC, (Value)negICompare, vdbeCtx->iCompare);

                        branch(LOC, blockAfterAnyNull);
                    } // end (aMem[p1 + idx].flags & MEM_Null) || (aMem[p2 + idx].flags & MEM_Null)

                    ip_start(blockAfterAnyNull);

                    branch(LOC, blockAfterBigNull);
                } // end if (pKeyInfo->aSortFlags[i] & KEYINFO_ORDER_BIGNULL)

                ip_start(blockAfterBigNull);

                curBlock = rewriter.getBlock();
                auto blockAfterBRev = SPLIT_GO_BACK_TO(curBlock);
                auto blockBRev = SPLIT_GO_BACK_TO(curBlock);

                auto condBRev = iCmp(LOC, Pred::ne, bRev, 0);
                condBranch(LOC, condBRev, blockBRev, blockAfterBRev);
                { // if (bRev)
                    ip_start(blockBRev);

                    auto iCompareValue = load(LOC, vdbeCtx->iCompare);
                    auto negICompare = sub(LOC, constants(0, 32), iCompareValue);
                    store(LOC, (Value)negICompare, vdbeCtx->iCompare);

                    branch(LOC, blockAfterBRev);
                } // end if (bRev)

                ip_start(blockAfterBRev);

                // Get out of for if iCompare != 0
                branch(LOC, blockAfterFor);
            } // end if (iCompare)

            ip_start(blockAfterICompareNotNull);
            // condBranch(LOC, iCompareNotNull, blockAfterFor, blockICompareNotNull);

        } // end for on registers

        branch(LOC, blockAfterFor);
        ip_start(blockAfterFor);
        branch(LOC, endBlock);
        ip_start(endBlock);
        restoreStack(LOC, stackState);

        rewriter.eraseOp(compOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes