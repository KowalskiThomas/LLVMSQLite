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

        // TODO
        auto pOp = (VdbeOp*)(nullptr);

        // First LHS = p1
        auto firstLhs = compOp.firstLhsAttr().getSInt();
        // First RHS = p2
        auto firstRhs = compOp.firstRhsAttr().getSInt();
        // nReg = p3
        auto nReg = compOp.nRegAttr().getSInt();
        // keyInfo = p4
        auto keyInfo = compOp.keyInfoAttr().getUInt();
        // flags = p5
        auto flags = compOp.flagsAttr().getUInt();

        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(compOp); GO_BACK_TO(curBlock);

        auto aPermuteInitValue = (int*)(nullptr);
        auto aPermuteAddr = alloca(LOC, T::i32PtrTy);

        if (flags & OPFLAG_PERMUTE) {
            store(LOC, 0, aPermuteAddr);
            aPermuteInitValue = nullptr;
        } else {
            aPermuteInitValue = pOp[-1].p4.ai + 1;
            store(LOC, (uint64_t)aPermuteInitValue, aPermuteAddr);
        }

        curBlock = rewriter.getBlock();
        auto blockAfterFor = SPLIT_BLOCK; GO_BACK_TO(curBlock);
        // auto blockFor = SPLIT_BLOCK; GO_BACK_TO(curBlock);

        for(auto i = 0llu; i < nReg; i++) {
            auto idx = (int)(aPermuteInitValue ? aPermuteInitValue[i] : i);

            auto pKeyInfo = (KeyInfo*)keyInfo;
            auto pColl = pKeyInfo->aColl[i];
            auto bRef = (pKeyInfo->aSortFlags[i] & KEYINFO_ORDER_DESC);

            auto arg1 = constants(T::sqlite3_valuePtrTy, &vdbe->aMem[firstLhs + idx]);
            auto arg2 = constants(T::sqlite3_valuePtrTy, &vdbe->aMem[firstRhs + idx]);
            auto iCompare = call(LOC, f_sqlite3MemCompare, arg1, arg2, constants(T::CollSeqPtrTy, pColl)).getValue();
            auto iCompareNotNull = iCmp(LOC, Pred::ne, iCompare, 0);

            auto curBlock = rewriter.getBlock();
            auto blockAfterICompareNotNull = SPLIT_BLOCK; GO_BACK_TO(curBlock);
            auto blockICompareNotNull = SPLIT_BLOCK; GO_BACK_TO(curBlock);

            condBranch(LOC, iCompareNotNull, blockICompareNotNull, blockAfterICompareNotNull);

            { // if (iCompare)
                ip_start(blockICompareNotNull);



                // Get out of for if comparison != 0
                branch(LOC, blockAfterFor);
            } // end if (iCompare)

            ip_start(blockAfterICompareNotNull);

        }

        ip_start(blockAfterFor);

        print(LOCL, "In block after for");

        branch(LOC, endBlock);

        ip_start(endBlock);

        rewriter.eraseOp(compOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes