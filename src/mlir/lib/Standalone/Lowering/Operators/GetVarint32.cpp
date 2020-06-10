#include "Standalone/AllIncludes.h"
#include "Standalone/ConstantManager.h"
#include "Standalone/TypeDefinitions.h"

#include "Standalone/Lowering/GetVarint32Operator.h"

namespace mlir::standalone::passes {
void GetVarint32Operator::operator()(GetVarint32Operator::Value A, GetVarint32Operator::Value B,
                                     GetVarint32Operator::Value writeResultTo) {
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

    LOWERING_NAMESPACE

    // Read the content of pointer A
    auto valA = rewriter.template create<LoadOp>(LOC, A);

    // Create new blocks:
    // - One for if *A < 0x80
    // - One for the else (A >= 0x80)
    // - One for reuniting control flow
    auto curBlock = rewriter.getBlock();
    auto blockAfter = SPLIT_BLOCK; GO_BACK_TO(curBlock);
    auto blockNotLessThan80 = SPLIT_BLOCK; GO_BACK_TO(curBlock);
    auto blockLessThan80 = SPLIT_BLOCK; GO_BACK_TO(curBlock);

    // Check whether *A < 0x80
    auto condLessThan80 = rewriter.template create<ICmpOp>
            (LOC, ICmpPredicate::sgt, valA, constants(-1, 8));

    // Insert branching
    rewriter.template create<CondBrOp>(LOC, condLessThan80,
                                       blockLessThan80,
                                       blockNotLessThan80);

    { // if *A < 0x80
        rewriter.setInsertionPointToStart(blockLessThan80);

        // Convert *A to u32
        auto aAsU32 = rewriter.template create<ZExtOp>(LOC, T::i32Ty, valA);

        // B = *A
        rewriter.template create<StoreOp>(LOC, aAsU32, B);

        // "Return" 1
        rewriter.template create<StoreOp>(LOC, constants(1, 32), writeResultTo);

        rewriter.template create<BranchOp>(LOC, blockAfter);
    } // end of if *A < 0x80
    { // else of if *A < 0x80
        rewriter.setInsertionPointToStart(blockNotLessThan80);

        // Convert B to u32*
        auto bAsU32Ptr = rewriter.template create<BitcastOp>(LOC, T::i32PtrTy, B);
        // Call sqlite3GetVarint32(A, (u32*)B)
        auto result = rewriter.template create<CallOp>
                (LOC, f_sqlite3GetVarint32, mlir::ValueRange {
                        A,
                        bAsU32Ptr
                }).getResult(0);

        // "Return" the result of the function
        // sqlite3GetVarint32 returns an u8 so we need to extend it
        auto resultAsI32 = rewriter.template create<ZExtOp>(LOC, T::i32Ty, result);
        rewriter.template create<StoreOp>(LOC, resultAsI32, writeResultTo);
        rewriter.template create<BranchOp>(LOC, blockAfter);
    } // end else of if *A < 0x80

    rewriter.setInsertionPointToStart(blockAfter);
}
}
