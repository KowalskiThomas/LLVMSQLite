#include <llvm/Support/DynamicLibrary.h>

#include <src/mlir/include/Standalone/ConstantManager.h>
#include <src/mlir/include/Standalone/Lowering/MyBuilder.h>
#include "Standalone/AllIncludes.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"

#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"

ExternFuncOp f_applyNumericAffinity;
ExternFuncOp f_sqlite3VdbeMemStringify;
ExternFuncOp f_sqlite3MemCompare;

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

        auto memSetTypeFlag = [&](Value flagsAddr, int flag) {
            auto flagsOut = load(LOC, flagsAddr);
            flagsOut = bitAnd(LOC, flagsOut, ~(MEM_Zero | MEM_TypeMask));
            flagsOut = bitOr(LOC, flagsOut, flag);
            store(LOC, flagsOut, flagsAddr);
        };

        auto firstBlock = rewriter.getBlock();

        auto pc = txnOp.pcAttr().getUInt();
        auto* pOp = &vdbe->aOp[pc];

        auto lhs = txnOp.lhsAttr().getSInt();
        auto p2 = txnOp.p2Attr().getSInt();
        auto rhs = txnOp.rhsAttr().getSInt();
        auto collSeq = (CollSeq *) txnOp.comparatorAttr().getUInt();
        auto flags = txnOp.flagsAttr().getUInt();

        ALWAYS_ASSERT(lhs == pOp->p1 && rhs == pOp->p3 && "Attributes don't match VDBE operation");

        auto jumpTo = txnOp.ifTrue();
        auto fallthrough = txnOp.ifFalse();

        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(txnOp); GO_BACK_TO(curBlock);
        auto compareOpBlock = SPLIT_BLOCK; GO_BACK_TO(curBlock);

        auto stackState = rewriter.create<mlir::LLVM::StackSaveOp>(LOC, T::i8PtrTy);

        /// int res
        auto resAddr = alloca(LOC, T::i32PtrTy);
        /// int res2
        auto res2Addr = alloca(LOC, T::i32PtrTy);

        /// pIn1 = &aMem[pOp->p1];
        auto pIn1Addr = &vdbe->aMem[lhs];
        auto pIn1 = constants(T::sqlite3_valuePtrTy, pIn1Addr);

        /// pIn3 = &aMem[pOp->p3];
        auto pIn3Addr = &vdbe->aMem[rhs];
        auto pIn3 = constants(T::sqlite3_valuePtrTy, pIn3Addr);

        /// u16 flags1 = pIn1->flags
        auto in1FlagsAddr = constants(T::i16PtrTy, &pIn1Addr->flags);
        auto initialFlags1 = load(LOC, in1FlagsAddr);
        print(LOCL, initialFlags1, "Init flags1");
        auto flags1Addr = alloca(LOC, T::i16PtrTy);
        store(LOC, initialFlags1, flags1Addr);

        /// u16 flags3 = pIn3->flags
        auto in3FlagsAddr = constants(T::i16PtrTy, &pIn3Addr->flags);
        auto initialFlags3 = load(LOC, in3FlagsAddr);
        print(LOCL, initialFlags3, "Init flags3");
        auto flags3Addr = alloca(LOC, T::i16PtrTy);
        store(LOC, initialFlags3, flags3Addr);

        /// if ((flags1 | flags3) & MEM_Null)
        // flags1 | flags3
        auto flags1Or3 = bitOr(LOC, initialFlags1, initialFlags3);
        // (flags1 | flags3) & MEM_Null
        auto flags1Or3AndNull = bitAnd(LOC, flags1Or3, MEM_Null);

        print(LOCL, flags1Or3AndNull, "Any null");

        auto blockAfterAnyNull = SPLIT_BLOCK; GO_BACK_TO(curBlock);
        auto blockNotAnyNull = SPLIT_BLOCK; GO_BACK_TO(curBlock);
        auto blockAnyNull = SPLIT_BLOCK; GO_BACK_TO(curBlock);

        auto condAnyNull = iCmp(LOC, Pred::ne, flags1Or3AndNull, 0);

        condBranch(LOC, condAnyNull, blockAnyNull, blockNotAnyNull);
        { // if ((flags1 | flags3) & MEM_Null)
            ip_start(blockAnyNull);

            print(LOCL, "One is null");

            if (flags & SQLITE_NULLEQ) {
                // flags1 & flags3
                auto flags1And3 = bitAnd(LOC, initialFlags1, initialFlags3);
                // flags1 & flags3 & MEM_Null
                auto flags1And3AndNull = bitAnd(LOC, flags1And3, MEM_Null);
                // flags3 & MEM_Cleared
                auto flags3AndCleared = bitAnd(LOC, initialFlags3, MEM_Cleared);

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

                    memSetTypeFlag(pOut, MEM_Null);

                    branch(LOC, endBlock);

                } else /* of if (flags & SQLITE_STOREP2) */ {

                    print(LOCL, "Not StoreP2");
                    rewriter.create<mlir::LLVM::StackRestoreOp>(LOC, stackState);
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

            print(LOCL, "None is null");

            auto affinity = flags & SQLITE_AFF_MASK;
            if (affinity >= SQLITE_AFF_NUMERIC) {
                print(LOCL, "Affinity numeric");
                auto curBlock = rewriter.getBlock();
                auto blockAfterAnyIsString = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                auto blockAnyIsString = SPLIT_BLOCK; GO_BACK_TO(curBlock);

                // (flags1 | flags3) & MEM_Str
                auto flags1Or3AndStr = bitAnd(LOC, flags1Or3, MEM_Str);
                // ((flags1 | flags3) & MEM_Str) != 0
                auto condAnyIsString = iCmp(LOC, Pred::ne, flags1Or3AndStr, 0);

                condBranch(LOC, condAnyIsString, blockAnyIsString, blockAfterAnyIsString);
                { // if ((flags1 | flags3) & MEM_Str)
                    ip_start(blockAnyIsString);

                    print(LOCL, "One is string");

                    auto curBlock = rewriter.getBlock();
                    auto blockAfterIn1IsString = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                    auto blockIn1IsString = SPLIT_BLOCK; GO_BACK_TO(curBlock);

                    /// if ((flags1 & (MEM_Int | MEM_IntReal | MEM_Real | MEM_Str)) == MEM_Str)
                    auto flags1AndFlags = bitAnd(LOC, initialFlags1, (MEM_Int | MEM_IntReal | MEM_Real | MEM_Str));
                    auto in1IsString = iCmp(LOC, Pred::eq, flags1AndFlags, MEM_Str);

                    condBranch(LOC, in1IsString, blockIn1IsString, blockAfterIn1IsString);
                    { // if ((flags1 & (MEM_Int | MEM_IntReal | MEM_Real | MEM_Str)) == MEM_Str)
                        ip_start(blockIn1IsString);

                        print(LOCL, "Applying numeric affinity to 1");
                        /// applyNumericAffinity(pIn1, 0);
                        call(LOC, f_applyNumericAffinity,
                             pIn1,
                             constants(0, 32)
                        );

                        /// flags3 = pIn3->flags;
                        auto newFlags3 = load(LOC, in3FlagsAddr);
                        store(LOC, newFlags3, flags3Addr);

                        branch(LOC, blockAfterIn1IsString);
                    } // end if ((flags1 & (MEM_Int | MEM_IntReal | MEM_Real | MEM_Str)) == MEM_Str)

                    ip_start(blockAfterIn1IsString);

                    /// if ((flags3 & (MEM_Int | MEM_IntReal | MEM_Real | MEM_Str)) == MEM_Str)
                    curBlock = rewriter.getBlock();
                    auto blockAfterIn3IsString = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                    auto blockIn3IsString = SPLIT_BLOCK; GO_BACK_TO(curBlock);

                    // flags3 & (MEM_Int | MEM_IntReal | MEM_Real | MEM_Str)
                    auto flags3AndFlags = bitAnd(LOC, initialFlags3, (MEM_Int | MEM_IntReal | MEM_Real | MEM_Str));
                    // (flags3 & (MEM_Int | MEM_IntReal | MEM_Real | MEM_Str)) == MEM_Str
                    auto in3IsString = iCmp(LOC, Pred::eq, flags3AndFlags, MEM_Str);

                    condBranch(LOC, in3IsString, blockIn3IsString, blockAfterIn3IsString);
                    { // if ((flags3 & (MEM_Int | MEM_IntReal | MEM_Real | MEM_Str)) == MEM_Str)
                        ip_start(blockIn3IsString);

                        print(LOCL, "Applying numeric affinity to 3");
                        /// applyNumericAffinity(pIn3, 0);
                        call(LOC, f_applyNumericAffinity,
                             pIn1,
                             constants(0, 32)
                        );

                        branch(LOC, blockAfterIn3IsString);
                    } // end if ((flags3 & (MEM_Int | MEM_IntReal | MEM_Real | MEM_Str)) == MEM_Str)

                    ip_start(blockAfterIn3IsString);

                    branch(LOC, blockAfterAnyIsString);
                } // end if ((flags1 | flags3) & MEM_Str)

                ip_start(blockAfterAnyIsString);

                /// if ((pIn1->flags & pIn3->flags & MEM_Int) != 0)
                // Load pIn1->flags
                auto flags1Val = load(LOC, in1FlagsAddr);
                // Load pIn3->flags
                auto flags2Val = load(LOC, in3FlagsAddr);

                // pIn1->flags & pIn3->flags
                auto flags1And3 = bitAnd(LOC, flags1Val, flags2Val);
                // (pIn1->flags & pIn3->flags & MEM_Int)
                print(LOCL, flags1And3, "flags1 & flags3");
                auto bothAreInt = bitAnd(LOC, flags1And3, MEM_Int);

                curBlock = rewriter.getBlock();
                auto blockAfterBothAreInt = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                auto blockBothAreInt = SPLIT_BLOCK; GO_BACK_TO(curBlock);

                // // (pIn1->flags & pIn3->flags & MEM_Int) != 0
                auto condBothAreInt = iCmp(LOC, Pred::ne, bothAreInt, 0);

                print(LOCL, condBothAreInt, "Test");
                condBranch(LOC, condBothAreInt, blockBothAreInt, blockAfterBothAreInt);
                { // if ((pIn1->flags & pIn3->flags & MEM_Int) != 0)
                    ip_start(blockBothAreInt);
                    print(LOCL, "Both are int");
                    auto int1Addr = constants(T::i64PtrTy, &pIn1Addr->u.i);
                    auto int3Addr = constants(T::i64PtrTy, &pIn3Addr->u.i);

                    auto int1 = load(LOC, int1Addr);
                    auto int3 = load(LOC, int3Addr);

                    auto curBlock = rewriter.getBlock();
                    auto blockAfter3Gt1 = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                    auto block3Gt1 = SPLIT_BLOCK; GO_BACK_TO(curBlock);

                    auto cond3Gt1 = iCmp(LOC, Pred::sgt, int3, int1);

                    condBranch(LOC, cond3Gt1, block3Gt1, blockAfter3Gt1);
                    { // if (pIn3->u.i > pIn1->u.i)
                        ip_start(block3Gt1);

                        store(LOC, +1, resAddr);

                        branch(LOC, compareOpBlock);
                    } // end if (pIn3->u.i > pIn1->u.i)

                    ip_start(blockAfter3Gt1);

                    curBlock = rewriter.getBlock();
                    auto blockAfter3Lt1 = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                    auto blockNot3Lt1 = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                    auto block3Lt1 = SPLIT_BLOCK; GO_BACK_TO(curBlock);

                    auto cond3Lt1 = iCmp(LOC, Pred::slt, int3, int1);

                    condBranch(LOC, cond3Lt1, block3Lt1, blockNot3Lt1);
                    { // if (pIn3->u.i < pIn1->u.i)
                        ip_start(block3Lt1);

                        store(LOC, -1, resAddr);

                        branch(LOC, blockAfter3Lt1);
                    } // end if (pIn3->u.i < pIn1->u.i)
                    { // else of if (pIn3->u.i < pIn1->u.i)
                        ip_start(blockNot3Lt1);

                        store(LOC, 0, resAddr);

                        branch(LOC, blockAfter3Lt1);
                    } // end else of if (pIn3->u.i < pIn1->u.i)

                    ip_start(blockAfter3Lt1);

                    print(LOCL, "Both int, jumping to compareOpBlock");
                    branch(LOC, compareOpBlock);
                 } // end if ((pIn1->flags & pIn3->flags & MEM_Int) != 0)

                ip_start(blockAfterBothAreInt);

            } else if (affinity >= SQLITE_AFF_TEXT) {
                // flags1 & MEM_Str
                auto flags1AndStr = bitAnd(LOC, initialFlags1, MEM_Str);
                // flags1 & (MEM_Int | MEM_Real | MEM_IntReal)
                auto flags1AndOthers = bitAnd(LOC, initialFlags1, (MEM_Int | MEM_Real | MEM_IntReal));

                // flags1 & MEM_Str == 0
                auto flags1AndStrNull = iCmp(LOC, Pred::eq, flags1AndStr, 0);
                // flags1 & (MEM_Int | MEM_Real | MEM_IntReal) != 0
                auto flags1AndOthersNN = iCmp(LOC, Pred::ne, flags1AndOthers, 0);

                // flags3 & MEM_Str
                auto flags3AndStr = bitAnd(LOC, initialFlags3, MEM_Str);
                // flags3 & (MEM_Int | MEM_Real | MEM_IntReal)
                auto flags3AndOthers = bitAnd(LOC, initialFlags3, (MEM_Int | MEM_Real | MEM_IntReal));

                // flags3 & MEM_Str == 0
                auto flags3AndStrNull = iCmp(LOC, Pred::eq, flags3AndStr, 0);
                // flags3 & (MEM_Int | MEM_Real | MEM_IntReal) != 0
                auto flags3AndOthersNN = iCmp(LOC, Pred::ne, flags3AndOthers, 0);

                auto curBlock = rewriter.getBlock();
                auto blockAfterIn1IsNumeric = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                auto blockIn1IsNumeric = SPLIT_BLOCK; GO_BACK_TO(curBlock);

                auto condIn1IsNumeric = bitAnd(LOC, flags1AndStrNull, flags1AndOthersNN);

                condBranch(LOC, condIn1IsNumeric, blockIn1IsNumeric, blockAfterIn1IsNumeric);
                { // if ((flags1 & MEM_Str) == 0 && (flags1 & (MEM_Int | MEM_Real | MEM_IntReal)) != 0)
                    ip_start(blockIn1IsNumeric);

                    call(LOC, f_sqlite3VdbeMemStringify,
                        pIn1,
                        constants(vdbe->db->enc, 8),
                        constants(1, 8)
                    );

                    /// flags1 = (pIn1->flags & ~MEM_TypeMask) | (flags1 & MEM_TypeMask);
                    auto in1FlagsAndNotTypeMask = bitAnd(LOC, load(LOC, in1FlagsAddr), ~MEM_TypeMask);
                    auto flags1AndTypeMask = bitAnd(LOC, initialFlags1, MEM_TypeMask);
                    auto newFlags1 = bitOr(LOC, in1FlagsAndNotTypeMask, flags1AndTypeMask);
                    store(LOC, newFlags1, flags1Addr);

                    branch(LOC, blockAfterIn1IsNumeric);
                 } // end if ((flags1 & MEM_Str) == 0 && (flags1 & (MEM_Int | MEM_Real | MEM_IntReal)) != 0)

                ip_start(blockAfterIn1IsNumeric);

                curBlock = rewriter.getBlock();
                auto blockAfterIn3IsNumeric = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                auto blockIn3IsNumeric = SPLIT_BLOCK; GO_BACK_TO(curBlock);

                auto condIn3IsNumeric = bitAnd(LOC, flags3AndStrNull, flags3AndOthersNN);

                condBranch(LOC, condIn3IsNumeric, blockIn3IsNumeric, blockAfterIn3IsNumeric);
                { // if ((flags3 & MEM_Str) == 0 && (flags3 & (MEM_Int | MEM_Real | MEM_IntReal)) != 0)
                    ip_start(blockIn3IsNumeric);

                    call(LOC, f_sqlite3VdbeMemStringify,
                         pIn3,
                         constants(vdbe->db->enc, 8),
                         constants(1, 8)
                    );

                    /// flags3 = (pIn3->flags & ~MEM_TypeMask) | (flags3 & MEM_TypeMask);
                    auto in3FlagsAndNotTypeMask = bitAnd(LOC, load(LOC, in3FlagsAddr), ~MEM_TypeMask);
                    auto flags3AndTypeMask = bitAnd(LOC, initialFlags3, MEM_TypeMask);
                    auto newFlags3 = bitOr(LOC, in3FlagsAndNotTypeMask, flags3AndTypeMask);
                    store(LOC, newFlags3, flags3Addr);

                    branch(LOC, blockAfterIn3IsNumeric);
                 } // end if ((flags3 & MEM_Str) == 0 && (flags3 & (MEM_Int | MEM_Real | MEM_IntReal)) != 0)

                ip_start(blockAfterIn3IsNumeric);

            }

            print(LOCL, "Calling memCompare");
            /// res = sqlite3MemCompare(pIn3, pIn1, pOp->p4.pColl);
            auto result = call(LOC, f_sqlite3MemCompare,
                pIn3,
                pIn1,
                constants(T::CollSeqPtrTy, (CollSeq *)collSeq)
            ).getValue();
            store(LOC, result, resAddr);

            branch(LOC, blockAfterAnyNull);
        } // end else of if ((flags1 | flags3) & MEM_Null)

        ip_start(blockAfterAnyNull);

        branch(LOC, compareOpBlock);

        // compare_op:
        ip_start(compareOpBlock);

        static const unsigned char aLTb[] = {1, 0, 0, 1, 1, 0};
        static const unsigned char aEQb[] = {0, 1, 0, 1, 0, 1};
        static const unsigned char aGTb[] = {1, 0, 1, 0, 0, 1};

        curBlock = rewriter.getBlock();
        auto blockAfterResSign = SPLIT_BLOCK; GO_BACK_TO(curBlock);
        auto blockResPositive = SPLIT_BLOCK; GO_BACK_TO(curBlock);
        auto blockResNull = SPLIT_BLOCK; GO_BACK_TO(curBlock);
        auto blockNotResNegative = SPLIT_BLOCK; GO_BACK_TO(curBlock);
        auto blockResNegative = SPLIT_BLOCK; GO_BACK_TO(curBlock);

        auto resValue = load(LOC, resAddr);
        auto condResNegative = iCmp(LOC, Pred::slt, resValue, 0);
        
        condBranch(LOC, condResNegative, blockResNegative, blockNotResNegative);
        { // if (res < 0)
            ip_start(blockResNegative);

            auto res2Value = aLTb[pOp->opcode - OP_Ne];
            store(LOC, res2Value, res2Addr);
        
            branch(LOC, blockAfterResSign);
        } // end if (res < 0)
        { // else if (res == 0) CONDITION
            ip_start(blockNotResNegative);

            auto resIsNull = iCmp(LOC, Pred::eq, resValue, 0);

            condBranch(LOC, resIsNull, blockResNull, blockResPositive);
        } // end else if (res == 0) CONDITION
        { // else if (res == 0)
            ip_start(blockResNull);

            auto res2Value = aEQb[pOp->opcode - OP_Ne];
            store(LOC, res2Value, res2Addr);

            branch(LOC, blockAfterResSign);
        } // end else if (res == 0)
        { // else if (res > 0)
            ip_start(blockResPositive);

            auto res2Value = aGTb[pOp->opcode - OP_Ne];
            store(LOC, res2Value, res2Addr);

            branch(LOC, blockAfterResSign);
        } // end else if (res > 0)

        ip_start(blockAfterResSign);

        /// pIn3->flags = flags3;
        store(LOC, initialFlags3, flags3Addr);
        /// pIn1->flags = flags1;
        store(LOC, initialFlags1, flags1Addr);

        if (pOp->p5 & SQLITE_STOREP2) {
            /// pOut = &aMem[pOp->p2];
            auto pOutAddr = &vdbe->aMem[p2];
            auto pOut = constants(T::sqlite3_valuePtrTy, pOutAddr);
            auto pOutFlagsAddr = constants(T::i16PtrTy, &pOutAddr->flags);
            auto pOutIntegerAddr = constants(T::i64PtrTy, &pOutAddr->u.i);

            /// iCompare = res;
            store(LOC, load(LOC, resAddr), vdbeCtx->iCompare);

            if ((pOp->p5 & SQLITE_KEEPNULL) != 0) {
                /// if ((pOp->opcode == OP_Eq) == res2) break;
                print(LOCL, "TODO: Implement Line 2193");
                myAssert(LOCL, constants(0, 1));
            }

            /// MemSetTypeFlag(pOut, MEM_Int);
            memSetTypeFlag(pOutFlagsAddr, MEM_Int);

            /// pOut->u.i = res2
            store(LOC, load(LOC, res2Addr), pOutIntegerAddr);

            branch(LOC, endBlock);
        } else /* (pOp->p5 & SQLITE_STOREP2) */ {
            auto res2Value = load(LOC, res2Addr);
            auto res2NotNull = iCmp(LOC, Pred::ne, res2Value, 0);
            rewriter.create<mlir::LLVM::StackRestoreOp>(LOC, stackState);
            condBranch(LOC, res2NotNull, jumpTo, fallthrough);
        }

        // end
        ip_start(endBlock);
        rewriter.create<mlir::LLVM::StackRestoreOp>(LOC, stackState);
        branch(LOC, jumpTo);
        rewriter.eraseOp(txnOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes