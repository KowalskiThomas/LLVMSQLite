#include <llvm/Support/DynamicLibrary.h>

#include <src/mlir/include/Standalone/ConstantManager.h>
#include <src/mlir/include/Standalone/Lowering/MyBuilder.h>
#include "Standalone/AllIncludes.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"

#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"

extern LLVMFuncOp f_applyNumericAffinity;

namespace mlir::standalone::passes {
    LogicalResult CompareJumpLowering::matchAndRewrite(CompareJump txnOp, PatternRewriter &rewriter) const {
        auto op = &txnOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        myOperators

        auto firstBlock = rewriter.getBlock();

        auto pc = txnOp.pcAttr().getUInt();
        auto lhs = txnOp.lhsAttr().getSInt();
        auto p2 = txnOp.p2Attr().getSInt();
        auto rhs = txnOp.rhsAttr().getSInt();
        auto comparator = (FuncDef *) txnOp.comparatorAttr().getUInt();
        auto flags = txnOp.flagsAttr().getUInt();

        auto jumpTo = txnOp.ifTrue();
        auto fallthrough = txnOp.ifFalse();

        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(txnOp);
        GO_BACK_TO(curBlock);

        auto resAddr = alloca(LOC, T::i32PtrTy);

        auto pIn1Addr = &vdbe->aMem[rhs];
        auto pIn3Addr = &vdbe->aMem[lhs];

        auto pIn1 = constants(T::sqlite3_valuePtrTy, pIn1Addr);
        auto pIn3 = constants(T::sqlite3_valuePtrTy, pIn3Addr);

        auto flags1Addr = constants(T::i16PtrTy, &pIn1Addr->flags);
        auto flags3Addr = constants(T::i16PtrTy, &pIn3Addr->flags);

        auto flags1 = load(LOC, flags1Addr);
        auto flags3 = load(LOC, flags3Addr);

        auto flags1Or3 = bitOr(LOC, flags1, flags3);
        auto flags1Or3AndNull = bitAnd(LOC, flags1Or3, MEM_Null);

        auto blockAfterAnyNull = SPLIT_BLOCK;
        GO_BACK_TO(curBlock);
        auto blockNotAnyNull = SPLIT_BLOCK;
        GO_BACK_TO(curBlock);
        auto blockAnyNull = SPLIT_BLOCK;
        GO_BACK_TO(curBlock);

        auto condAnyNull = iCmp(LOC, Pred::ne, flags1Or3AndNull, 0);

        condBranch(LOC, condAnyNull, blockAnyNull, blockNotAnyNull);
        { // if ((flags1 | flags3) & MEM_Null)
            ip_start(blockAnyNull);

            if (flags & SQLITE_NULLEQ) {

                // flags1 & flags3
                auto flags1And3 = bitAnd(LOC, flags1, flags3);
                // flags1 & flags3 & MEM_Null
                auto flags1And3AndNull = bitAnd(LOC, flags1And3, MEM_Null);
                // flags3 & MEM_Cleared
                auto flags3AndCleared = bitAnd(LOC, flags3, MEM_Cleared);

                // Whether (flags1 & flags3 & MEM_Null) != 0
                auto bothNull = iCmp(LOC, Pred::ne, flags1Or3AndNull, 0);
                // Whether (flags3 & MEM_Cleared) == 0
                auto in3NotCleared = iCmp(LOC, Pred::eq, flags3AndCleared, 0);

                // Full condition
                auto condOperandsEqual = bitAnd(LOC, bothNull, in3NotCleared);

                auto curBlock = rewriter.getBlock();
                auto blockAfterOperandsEqual = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                auto blockNotOperandsEqual = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                auto blockOperandsEqual = SPLIT_BLOCK; GO_BACK_TO(curBlock);

                condBranch(LOC, condOperandsEqual, blockOperandsEqual, blockNotOperandsEqual);
                { // if ((flags1 & flags3 & MEM_Null) != 0 && (flags3 & MEM_Cleared) == 0
                    ip_start(blockOperandsEqual);

                    // res = 0;  /* Operands are equal */
                    store(LOC, 0, resAddr);

                    branch(LOC, blockAfterOperandsEqual);
                } // end if ((flags1 & flags3 & MEM_Null) != 0 && (flags3 & MEM_Cleared) == 0
                { // else of if ((flags1 & flags3 & MEM_Null) != 0 && (flags3 & MEM_Cleared) == 0
                    ip_start(blockNotOperandsEqual);

                    // res = ((flags3 & MEM_Null) ? -1 : +1);  /* Operands are not equal */
                    print(LOCL, "TODO: res = ((flags3 & MEM_Null) ? -1 : +1);");
                    myAssert(LOCL, constants(0, 1));

                    branch(LOC, blockAfterOperandsEqual);
                } // end else of if ((flags1 & flags3 & MEM_Null) != 0 && (flags3 & MEM_Cleared) == 0

                ip_start(blockAfterOperandsEqual);
                branch(LOC, blockAfterAnyNull);

            } else /* of if (pOp->p5 & SQLITE_NULLEQ) */ {

                if (flags & SQLITE_STOREP2) {

                    auto pOut = constants(T::sqlite3_valuePtrTy, &vdbe->aMem[p2]);
                    store(LOC, 1, vdbeCtx->iCompare);

                    print(LOCL, "TODO: MemSetTypeFlag(pOut, MEM_Null);");

                    branch(LOC, endBlock);

                } else /* of if (flags & SQLITE_STOREP2) */ {

                    if (flags & SQLITE_JUMPIFNULL)
                        branch(LOC, jumpTo);
                    else
                        branch(LOC, endBlock);

                } // end else of if (flags & SQLITE_STOREP2)

            } // end else of if (pOp->p5 & SQLITE_NULLEQ)

            // NOTE: No branch(...) here because it's done in the if-else blocks
        } // end if ((flags1 | flags3) & MEM_Null)
        { // else of if ((flags1 | flags3) & MEM_Null)
            ip_start(blockNotAnyNull);

            auto affinity = flags & SQLITE_AFF_MASK;
            if (affinity >= SQLITE_AFF_NUMERIC) {


                auto curBlock = rewriter.getBlock();
                auto blockAfterAnyIsString = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                auto blockAnyIsString = SPLIT_BLOCK; GO_BACK_TO(curBlock);

                auto flags1Or3AndStr = bitAnd(LOC, flags1Or3, MEM_Str);
                auto condAnyIsString = iCmp(LOC, Pred::ne, flags1Or3AndStr, 0);

                condBranch(LOC, condAnyIsString, blockAnyIsString, blockAfterAnyIsString);
                { // if ((flags1 | flags3) & MEM_Str)
                    ip_start(blockAnyIsString);

                    auto curBlock = rewriter.getBlock();
                    auto blockAfterIn1IsString = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                    auto blockIn1IsString = SPLIT_BLOCK; GO_BACK_TO(curBlock);

                    auto flags1AndFlags = bitAnd(LOC, flags1, (MEM_Int | MEM_IntReal | MEM_Real | MEM_Str));
                    auto in1IsString = iCmp(LOC, Pred::eq, flags1AndFlags, MEM_Str);

                    condBranch(LOC, in1IsString, blockIn1IsString, blockAfterIn1IsString);
                    { // if ((flags1 & (MEM_Int | MEM_IntReal | MEM_Real | MEM_Str)) == MEM_Str)
                        ip_start(blockIn1IsString);

                        /// applyNumericAffinity(pIn1, 0);
                        call(LOC, f_applyNumericAffinity,
                            pIn1,
                            constants(0, 32)
                        );

                        /// flags3 = pIn3->flags;
                        auto flags3 = load(LOC, flags3Addr);

                        branch(LOC, blockAfterIn1IsString);
                    } // end if ((flags1 & (MEM_Int | MEM_IntReal | MEM_Real | MEM_Str)) == MEM_Str)

                    ip_start(blockAfterIn1IsString);

                    curBlock = rewriter.getBlock();
                    auto blockAfterIn3IsString = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                    auto blockIn3IsString = SPLIT_BLOCK; GO_BACK_TO(curBlock);

                    flags3 = load(LOC, flags3Addr);
                    auto flags3AndFlags = bitAnd(LOC, flags3, (MEM_Int | MEM_IntReal | MEM_Real | MEM_Str));
                    auto in3IsString = iCmp(LOC, Pred::eq, flags3AndFlags, MEM_Str);

                    condBranch(LOC, in3IsString, blockIn3IsString, blockAfterIn3IsString);
                    { // if ((flags3 & (MEM_Int | MEM_IntReal | MEM_Real | MEM_Str)) == MEM_Str)
                        ip_start(blockIn3IsString);

                        /// applyNumericAffinity(pIn3, 0);
                        call(LOC, f_applyNumericAffinity,
                            pIn3,
                            constants(0, 32)
                        );

                        branch(LOC, blockAfterIn3IsString);
                    } // end if ((flags3 & (MEM_Int | MEM_IntReal | MEM_Real | MEM_Str)) == MEM_Str)

                    ip_start(blockAfterIn3IsString);

                    branch(LOC, blockAfterAnyIsString);
                } // end if ((flags1 | flags3) & MEM_Str)

                ip_start(blockAfterAnyIsString);

                flags1 = load(LOC, flags1Addr);
                flags3 = load(LOC, flags3Addr);

                auto flags1And3 = bitAnd(LOC, flags1, flags3);
                auto bothAreInt = bitAnd(LOC, flags1And3, MEM_Int);

                curBlock = rewriter.getBlock();
                auto blockAfterBothAreInt = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                auto blockBothAreInt = SPLIT_BLOCK; GO_BACK_TO(curBlock);

                auto condBothAreInt = iCmp(LOC, Pred::ne, bothAreInt, 0);

                condBranch(LOC, condBothAreInt, blockBothAreInt, blockAfterBothAreInt);
                { // if ((pIn1->flags & pIn3->flags & MEM_Int) != 0)
                    ip_start(blockBothAreInt);

                    print(LOCL, "TODO: Line 2113...");

                    branch(LOC, blockAfterBothAreInt);
                 } // end if ((pIn1->flags & pIn3->flags & MEM_Int) != 0)

                ip_start(blockAfterBothAreInt);

            } else if (affinity >= SQLITE_AFF_TEXT) {

                print(LOCL, "TODO: affinity >= SQLITE_AFF_TEXT");

            }

            branch(LOC, blockAfterAnyNull);
        } // end else of if ((flags1 | flags3) & MEM_Null)

        ip_start(blockAfterAnyNull);

        // compare_op:

        print(LOCL, "TODO: Implement compare_op: ...");

        branch(LOC, endBlock);

        ip_start(endBlock);

        branch(LOC, jumpTo);

        rewriter.eraseOp(txnOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes