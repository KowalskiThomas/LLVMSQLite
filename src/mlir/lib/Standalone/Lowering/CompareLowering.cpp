#include <llvm/Support/DynamicLibrary.h>

#include <src/mlir/include/Standalone/ConstantManager.h>
#include <src/mlir/include/Standalone/Lowering/MyBuilder.h>
#include "Standalone/AllIncludes.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"

#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"

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

        auto firstBlock = rewriter.getBlock();

        // First LHS = p1
        auto firstLhs = compOp.firstLhsAttr().getSInt();
        // First RHS = p2
        auto firstRhs = compOp.firstRhsAttr().getSInt();
        // nReg = p3
        auto nReg = compOp.nRegAttr().getSInt();
        // keyInfo = p4
        auto keyInfo = compOp.keyInfoAttr().getUInt();
        // flags = p5
        auto flags = compOp.flagsAttr().getSInt();
        // pOp = &  aOp[pc]
        auto pOp = &vdbe->aOp[compOp.pcAttr().getUInt()];

        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(compOp); GO_BACK_TO(curBlock);

        auto aPermuteInitValue = (int*)(nullptr);
        auto aPermuteAddr = alloca(LOC, T::i32PtrTy);

        CALL_DEBUG
        CALL_DEBUG
        CALL_DEBUG

        if ((flags & OPFLAG_PERMUTE) == 0) {
            store(LOC, 0, aPermuteAddr);
            aPermuteInitValue = nullptr;
        } else {
            assert(pOp > vdbe->aOp);
            assert(pOp[-1].opcode == OP_Permutation);
            assert(pOp[-1].p4type == P4_INTARRAY);
            aPermuteInitValue = pOp[-1].p4.ai + 1;
            store(LOC, (uint64_t)aPermuteInitValue, aPermuteAddr);
        }

        curBlock = rewriter.getBlock();
        auto blockAfterFor = SPLIT_BLOCK; GO_BACK_TO(curBlock);

        for(auto i = 0llu; i < nReg; i++) {
            auto idx = (int)(aPermuteInitValue ? aPermuteInitValue[i] : i);

            auto pKeyInfo = (KeyInfo*)keyInfo;
            auto pColl = pKeyInfo->aColl[i];
            auto bRev = (pKeyInfo->aSortFlags[i] & KEYINFO_ORDER_DESC);

            auto arg1 = constants(T::sqlite3_valuePtrTy, &vdbe->aMem[firstLhs + idx]);
            auto arg2 = constants(T::sqlite3_valuePtrTy, &vdbe->aMem[firstRhs + idx]);
            auto iCompareValue = call(LOC, f_sqlite3MemCompare, arg1, arg2, constants(T::CollSeqPtrTy, pColl)).getValue();
            store(LOC, iCompareValue, vdbeCtx->iCompare);
            auto iCompareNotNull = iCmp(LOC, Pred::ne, iCompareValue, 0);

            auto curBlock = rewriter.getBlock();
            auto blockAfterICompareNotNull = SPLIT_BLOCK; GO_BACK_TO(curBlock);
            auto blockICompareNotNull = SPLIT_BLOCK; GO_BACK_TO(curBlock);

            condBranch(LOC, iCompareNotNull, blockICompareNotNull, blockAfterICompareNotNull);

            { // if (iCompare)
                ip_start(blockICompareNotNull);

                if (pKeyInfo->aSortFlags[i] & KEYINFO_ORDER_BIGNULL) {
                    curBlock = rewriter.getBlock();

                    auto blockAfterNull = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                    auto blockNull = SPLIT_BLOCK; GO_BACK_TO(curBlock);

                    mlir::Value aRegIsNull;
                    {
                        auto lhsFlagsAddr = constants(T::i16PtrTy, &vdbe->aMem[firstLhs + idx].flags);
                        auto lhsFlags = load(LOC, lhsFlagsAddr);
                        auto lhsNullAnd = bitAnd(LOC, lhsFlags, MEM_Null);
                        auto lhsNull = iCmp(LOC, Pred::eq, lhsNullAnd, 0);

                        auto rhsFlagsAddr = constants(T::i16PtrTy, &vdbe->aMem[firstRhs + idx].flags);
                        auto rhsFlags = load(LOC, rhsFlagsAddr);
                        auto rhsNullAnd = bitAnd(LOC, rhsFlags, MEM_Null);
                        auto rhsNull = iCmp(LOC, Pred::eq, rhsNullAnd, 0);

                        aRegIsNull = bitOr(LOC, lhsNull, rhsNull);
                    }

                    condBranch(LOC, aRegIsNull, blockNull, blockAfterNull);
                    { // if (aMem[p1 + idx].flags & MEM_Null) || (aMem[p2 + idx].flags & MEM_Null)
                        ip_start(blockNull);

                        auto negICompare = rewriter.create<SRemOp>(LOC, constants(0, 32), iCompareValue);
                        store(LOC, (Value)negICompare, vdbeCtx->iCompare);

                        branch(LOC, blockAfterNull);
                    } // end (aMem[p1 + idx].flags & MEM_Null) || (aMem[p2 + idx].flags & MEM_Null)

                    out("in possibly null")
                    ip_start(blockAfterNull);
                } else {
                    out("not writing a lot o fstuff")
                }

                CALL_DEBUG
                CALL_DEBUG
                if (bRev) {
                    auto iCompareValue = load(LOC, vdbeCtx->iCompare);
                    auto negICompare = rewriter.create<SRemOp>(LOC, constants(0, 32), iCompareValue);
                    store(LOC, (Value)negICompare, vdbeCtx->iCompare);
                }

                // Get out of for if comparison != 0
                branch(LOC, blockAfterICompareNotNull);

            } // end if (iCompare)

             ip_start(blockAfterICompareNotNull);

        }

        branch(LOC, blockAfterFor);

        ip_start(blockAfterFor);

        CALL_DEBUG
        print(LOCL, "In block after for");

        branch(LOC, endBlock);

        ip_start(endBlock);

        rewriter.eraseOp(compOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes