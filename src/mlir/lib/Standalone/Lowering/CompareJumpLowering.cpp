#include "Standalone/ConstantManager.h"
#include "Standalone/Lowering/MyBuilder.h"
#include "Standalone/Lowering/ApplyNumericAffinity.h"
#include "Standalone/AllIncludes.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"
#include "Standalone/DebugUtils.h"
#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"

#define JIT_STATIC_TYPING_COMPARE

// ExternFuncOp f_applyNumericAffinity;
ExternFuncOp f_sqlite3VdbeMemStringify;
ExternFuncOp f_sqlite3MemCompare;
ExternFuncOp f_printTypeOf;

extern "C" {
    extern const int* query_types[];
    extern const int query_id;
}

namespace mlir::standalone::passes {
    LogicalResult CompareJumpLowering::matchAndRewrite(CompareJump cjOp, PatternRewriter &rewriter) const {
        auto op = &cjOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        Inlining::ApplyNumericAffinity applyNumericAffinity(*vdbeCtx, *ctx, rewriter, print, constants);
        myOperators

        auto firstBlock = rewriter.getBlock();

        auto pc = cjOp.pcAttr().getUInt();
        auto* pOp = &vdbe->aOp[pc];

        auto lhs = cjOp.lhsAttr().getSInt();
        auto p2 = cjOp.p2Attr().getSInt();
        auto rhs = cjOp.rhsAttr().getSInt();
        auto collSeq = (CollSeq *) cjOp.comparatorAttr().getUInt();
        auto flags = cjOp.flagsAttr().getUInt();

        USE_DEFAULT_BOILERPLATE

        LLVMSQLITE_ASSERT(lhs == pOp->p1 && rhs == pOp->p3 && "Attributes don't match VDBE operation");

        auto jumpTo = cjOp.ifTrue();
        auto fallthrough = cjOp.ifFalse();

        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(cjOp); GO_BACK_TO(curBlock);

        auto stackState = rewriter.create<mlir::LLVM::StackSaveOp>(LOC, T::i8PtrTy);

        /// int res
        auto resAddr = alloca(LOC, T::i32PtrTy);
        /// int res2
        auto res2Addr = alloca(LOC, T::i32PtrTy);

        /// pIn1 = &aMem[pOp->p1];
        auto pIn1 = getElementPtrImm(LOC, T::sqlite3_valuePtrTy, vdbeCtx->aMem, lhs);

        /// pIn3 = &aMem[pOp->p3];
        auto pIn3 = getElementPtrImm(LOC, T::sqlite3_valuePtrTy, vdbeCtx->aMem, rhs);

        /// u16 flags1 = pIn1->flags
        auto in1FlagsAddr = getElementPtrImm(LOC, T::i16PtrTy, pIn1, 0, 1);
        auto initialFlags1 = load(LOC, in1FlagsAddr);
        auto flags1Addr = alloca(LOC, T::i16PtrTy);
        store(LOC, initialFlags1, flags1Addr);

        /// u16 flags3 = pIn3->flags
        auto in3FlagsAddr = getElementPtrImm(LOC, T::i16PtrTy, pIn3, 0, 1);
        auto initialFlags3 = load(LOC, in3FlagsAddr);
        auto flags3Addr = alloca(LOC, T::i16PtrTy);
        store(LOC, initialFlags3, flags3Addr);

#ifdef JIT_STATIC_TYPING_COMPARE
        {
            auto types = query_types[query_id > 0 ? 1 : 0];
            auto t1 = types[op->lhsAttr().getSInt()];
            auto t3 = types[op->rhsAttr().getSInt()];

            if (t1 != 0 && t1 == t3) {
                if (t1 == MEM_Real) {
                    out("Using REAL a priori knowledge on " << pOp->p1 << " and " << pOp->p3)
                    auto r1Addr = getElementPtrImm(LOC, T::doublePtrTy, pIn1, 0, 0, 0);
                    auto r1 = load(LOC, r1Addr);

                    auto r3Addr = getElementPtrImm(LOC, T::doublePtrTy, pIn3, 0, 0, 0);
                    auto r3 = load(LOC, r3Addr);
                    Value result;

                    using FPred = mlir::LLVM::FCmpPredicate;
                    auto fCmp = [&](Location loc, FPred pred, Value a, Value b) {
                        return rewriter.create<mlir::LLVM::FCmpOp>(loc, pred, a, b);
                    };

                    switch (pOp->opcode) {
                        case OP_Eq: {
                            result = fCmp(LOC, FPred::oeq, r3, r1);
                            break;
                        }
                        case OP_Ge: {
                            result = fCmp(LOC, FPred::oge, r3, r1);
                            break;
                        }
                        case OP_Gt: {
                            result = fCmp(LOC, FPred::ogt, r3, r1);
                            break;
                        }
                        case OP_Le: {
                            result = fCmp(LOC, FPred::ole, r3, r1);
                            break;
                        }
                        case OP_Lt: {
                            result = fCmp(LOC, FPred::olt, r3, r1);
                            break;
                        }
                        case OP_Ne: {
                            result = fCmp(LOC, FPred::one, r3, r1);
                            break;
                        }
                        default:
                            llvm_unreachable("No CompareJump operation was found");
                    }

                    if (pOp->p5 & SQLITE_STOREP2) {
                        auto pOut = getElementPtrImm(LOC, T::sqlite3_valuePtrTy, vdbeCtx->aMem, p2);
                        store(LOC, 1, vdbeCtx->iCompare);

                        auto pOutFlagsAddr = getElementPtrImm(LOC, T::i16PtrTy, pOut, 0, 1);
                        memSetTypeFlag(pOutFlagsAddr, MEM_Int);

                        auto outRealAddr = getElementPtrImm(LOC, T::doublePtrTy, pOut, 0, 0, 0);
                        auto outIntAddr = bitCast(LOC, outRealAddr, T::i64PtrTy);
                        store(LOC, result, outIntAddr);
                        err("Unimplemented iCompare");
                        exit(99);
                        // iCompare = r3 < r1 ? -1 : (r3 > r1 ? 1 : 0);

                        branch(LOC, endBlock);
                        ip_start(endBlock);
                        rewriter.eraseOp(cjOp);
                        return success();
                    } else {
                        auto resultNotNull = iCmp(LOC, Pred::ne, result, 0);
                        restoreStack(LOC, stackState);
                        condBranch(LOC, resultNotNull, jumpTo, fallthrough);
                        ip_start(endBlock);
                        branch(LOC, fallthrough);
                        rewriter.eraseOp(cjOp);
                        return success();
                    }
                } else if (t1 == MEM_Int) {
                    out("Using INTEGER a priori knowledge on " << pOp->p1 << " and " << pOp->p3)
                    auto r1Addr = getElementPtrImm(LOC, T::doublePtrTy, pIn1, 0, 0, 0);
                    auto i1Addr = bitCast(LOC, r1Addr, T::i64PtrTy);
                    auto i1 = load(LOC, i1Addr);

                    auto r3Addr = getElementPtrImm(LOC, T::doublePtrTy, pIn3, 0, 0, 0);
                    auto i3Addr = bitCast(LOC, r3Addr, T::i64PtrTy);
                    auto i3 = load(LOC, i3Addr);
                    Value result;

                    switch (pOp->opcode) {
                        case OP_Eq: {
                            result = iCmp(LOC, Pred::eq, i3, i1);
                            break;
                        }
                        case OP_Ge: {
                            result = iCmp(LOC, Pred::sge, i3, i1);
                            break;
                        }
                        case OP_Gt: {
                            result = iCmp(LOC, Pred::sgt, i3, i1);
                            break;
                        }
                        case OP_Le: {
                            result = iCmp(LOC, Pred::sle, i3, i1);
                            break;
                        }
                        case OP_Lt: {
                            result = iCmp(LOC, Pred::slt, i3, i1);
                            break;
                        }
                        case OP_Ne: {
                            result = iCmp(LOC, Pred::ne, i3, i1);
                            break;
                        }
                        default:
                            llvm_unreachable("No CompareJump operation was found");
                    }

                    if (pOp->p5 & SQLITE_STOREP2) {
                        auto pOut = getElementPtrImm(LOC, T::sqlite3_valuePtrTy, vdbeCtx->aMem, p2);
                        store(LOC, 1, vdbeCtx->iCompare);

                        auto pOutFlagsAddr = getElementPtrImm(LOC, T::i16PtrTy, pOut, 0, 1);
                        memSetTypeFlag(pOutFlagsAddr, MEM_Int);

                        auto outRealAddr = getElementPtrImm(LOC, T::doublePtrTy, pOut, 0, 0, 0);
                        auto outIntAddr = bitCast(LOC, outRealAddr, T::i64PtrTy);
                        store(LOC, result, outIntAddr);
                        err("Unimplemented iCompare");
                        exit(99);
                        // iCompare = i3 < i1 ? -1 : (i3 > i1 ? 1 : 0);

                        branch(LOC, endBlock);
                        ip_start(endBlock);
                        rewriter.eraseOp(cjOp);
                        return success();
                    } else {
                        auto resultNotNull = iCmp(LOC, Pred::ne, result, 0);
                        restoreStack(LOC, stackState);
                        condBranch(LOC, resultNotNull, jumpTo, fallthrough);
                        ip_start(endBlock);
                        branch(LOC, fallthrough);
                        rewriter.eraseOp(cjOp);
                        return success();
                    }
                }
            }
        }
#endif

        auto compareOpBlock = SPLIT_BLOCK; GO_BACK_TO(curBlock);

        /// if ((flags1 | flags3) & MEM_Null)
        // flags1 | flags3
        auto flags1Or3 = bitOr(LOC, initialFlags1, initialFlags3);
        // (flags1 | flags3) & MEM_Null
        auto flags1Or3AndNull = bitAnd(LOC, flags1Or3, MEM_Null);

        auto blockAfterAnyNull = SPLIT_BLOCK; GO_BACK_TO(curBlock);
        auto blockNotAnyNull = SPLIT_BLOCK; GO_BACK_TO(curBlock);
        auto blockAnyNull = SPLIT_BLOCK; GO_BACK_TO(curBlock);

        auto condAnyNull = iCmp(LOC, Pred::ne, flags1Or3AndNull, 0);

        condBranch(LOC, condAnyNull, blockAnyNull, blockNotAnyNull);
        { // if ((flags1 | flags3) & MEM_Null)
            ip_start(blockAnyNull);

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
                    auto flags3 = load(LOC, flags3Addr);
                    auto flags3AndNull = bitAnd(LOC, flags3, MEM_Null);

                    auto curBlock = rewriter.getBlock();
                    auto blockAfterIn3IsNull = SPLIT_GO_BACK_TO(curBlock);
                    auto blockNotIn3IsNull = SPLIT_GO_BACK_TO(curBlock);
                    auto blockIn3IsNull = SPLIT_GO_BACK_TO(curBlock);

                    auto condIn3IsNull = iCmp(LOC, Pred::ne, flags3AndNull, 0);

                    condBranch(LOC, condIn3IsNull, blockIn3IsNull, blockNotIn3IsNull);
                    { // if (flags3 & MEM_Null)
                        ip_start(blockIn3IsNull);

                        store(LOC, -1, resAddr);

                        branch(LOC, blockAfterIn3IsNull);
                    } // end if (flags3 & MEM_Null)
                    { // else of if (flags3 & MEM_Null)
                        ip_start(blockNotIn3IsNull);

                        store(LOC, 1, resAddr);

                        branch(LOC, blockAfterIn3IsNull);
                    } // end else of if (flags3 & MEM_Null)

                    ip_start(blockAfterIn3IsNull);

                    branch(LOC, blockAfterOperandsEqual);
                } // end else of if ((flags1 & flags3 & MEM_Null) != 0 && (flags3 & MEM_Cleared) == 0

                ip_start(blockAfterOperandsEqual);
                branch(LOC, blockAfterAnyNull);

            } else /* of if (pOp->p5 & SQLITE_NULLEQ) */ {

                if (flags & SQLITE_STOREP2) {

                    auto pOut = getElementPtrImm(LOC, T::sqlite3_valuePtrTy, vdbeCtx->aMem, p2);
                    store(LOC, 1, vdbeCtx->iCompare);

                    /// MemSetTypeFlag(pOut, MEM_Null);
                    memSetTypeFlag(pOut, MEM_Null);

                    branch(LOC, endBlock);

                } else /* of if (flags & SQLITE_STOREP2) */ {

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

            // LLVMSQLITE_ASSERT(tyLeft == 0 || tyLeft == -1 || tyRight == 0 || tyRight == -1 || tyLeft == tyRight);

            auto affinity = flags & SQLITE_AFF_MASK;
            if (affinity >= SQLITE_AFF_NUMERIC) {
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

                    auto curBlock = rewriter.getBlock();
                    auto blockAfterIn1IsString = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                    auto blockIn1IsString = SPLIT_BLOCK; GO_BACK_TO(curBlock);

                    /// if ((flags1 & (MEM_Int | MEM_IntReal | MEM_Real | MEM_Str)) == MEM_Str)
                    auto flags1AndFlags = bitAnd(LOC, initialFlags1, (MEM_Int | MEM_IntReal | MEM_Real | MEM_Str));
                    auto in1IsString = iCmp(LOC, Pred::eq, flags1AndFlags, MEM_Str);

                    condBranch(LOC, in1IsString, blockIn1IsString, blockAfterIn1IsString);
                    { // if ((flags1 & (MEM_Int | MEM_IntReal | MEM_Real | MEM_Str)) == MEM_Str)
                        ip_start(blockIn1IsString);

                        /// applyNumericAffinity(pIn1, 0);
                        applyNumericAffinity(LOC, pIn1, constants(0, 32));
                        /*call(LOC, f_applyNumericAffinity,
                             pIn1,
                             constants(0, 32)
                        );*/

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

                        /// applyNumericAffinity(pIn3, 0);
                        applyNumericAffinity(LOC, pIn3, constants(0, 32));
                        /*call(LOC, f_applyNumericAffinity,
                             pIn3,
                             constants(0, 32)
                        );*/

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
                auto bothAreInt = bitAnd(LOC, flags1And3, MEM_Int);

                curBlock = rewriter.getBlock();
                auto blockAfterBothAreInt = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                auto blockBothAreInt = SPLIT_BLOCK; GO_BACK_TO(curBlock);

                // // (pIn1->flags & pIn3->flags & MEM_Int) != 0
                auto condBothAreInt = iCmp(LOC, Pred::ne, bothAreInt, 0);

                condBranch(LOC, condBothAreInt, blockBothAreInt, blockAfterBothAreInt);
                { // if ((pIn1->flags & pIn3->flags & MEM_Int) != 0)
                    ip_start(blockBothAreInt);
                    auto u1Addr = getElementPtrImm(LOC, T::doublePtrTy, pIn1, 0, 0);
                    auto int1Addr = bitCast(LOC, u1Addr, T::i64PtrTy);
                    auto u3Addr = getElementPtrImm(LOC, T::doublePtrTy, pIn3, 0, 0);
                    auto int3Addr = bitCast(LOC, u3Addr, T::i64PtrTy);

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

                    branch(LOC, compareOpBlock);
                 } // end if ((pIn1->flags & pIn3->flags & MEM_Int) != 0)

                ip_start(blockAfterBothAreInt);

            }
            else if (affinity >= SQLITE_AFF_TEXT)
            {
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

            /// res = sqlite3MemCompare(pIn3, pIn1, pOp->p4.pColl);
            auto pOpValue = getElementPtrImm(LOC, T::VdbeOpPtrTy, vdbeCtx->aOp, (int)pc);
            auto p4UAddr = getElementPtrImm(LOC, T::p4unionPtrTy, pOpValue, 0, 6);
            auto p4CollSeqPtrAddr = bitCast(LOC, p4UAddr, T::CollSeqPtrTy.getPointerTo());
            auto p4CollSeqPtr = load(LOC, p4CollSeqPtrAddr);
            auto result = call(LOC, f_sqlite3MemCompare,
                pIn3,
                pIn1,
                p4CollSeqPtr
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
            auto pOut = getElementPtrImm(LOC, T::sqlite3_valuePtrTy, vdbeCtx->aMem, p2);
            auto pOutFlagsAddr = getElementPtrImm(LOC, T::i16PtrTy, pOut, 0, 1);
            auto pOutUAddr = getElementPtrImm(LOC, T::doublePtrTy, pOut, 0, 0);
            auto pOutIntegerAddr = bitCast(LOC, pOutUAddr, T::i64PtrTy);

            /// iCompare = res;
            store(LOC, load(LOC, resAddr), vdbeCtx->iCompare);

            if ((pOp->p5 & SQLITE_KEEPNULL) != 0) {
                /// if ((pOp->opcode == OP_Eq) == res2) break;
                auto res2 = load(LOC, res2Addr);
                if (pOp->opcode == OP_Eq) {
                    auto res2NotNull = iCmp(LOC, Pred::ne, res2, 0);
                    auto curBlock = rewriter.getBlock();
                    auto blockAfter = SPLIT_GO_BACK_TO(curBlock);
                    condBranch(LOC, res2NotNull, endBlock, blockAfter);
                } else {
                    auto res2Null = iCmp(LOC, Pred::eq, res2, 0);
                    auto curBlock = rewriter.getBlock();
                    auto blockAfter = SPLIT_GO_BACK_TO(curBlock);
                    condBranch(LOC, res2Null, endBlock, blockAfter);
                }
            }

            /// MemSetTypeFlag(pOut, MEM_Int);
            memSetTypeFlag(pOutFlagsAddr, MEM_Int);

            /// pOut->u.i = res2
            store(LOC, load(LOC, res2Addr), pOutIntegerAddr);

            branch(LOC, endBlock);
        } else /* of (pOp->p5 & SQLITE_STOREP2) */ {
            auto res2Value = load(LOC, res2Addr);
            auto res2NotNull = iCmp(LOC, Pred::ne, res2Value, 0);
            rewriter.create<mlir::LLVM::StackRestoreOp>(LOC, stackState);
            condBranch(LOC, res2NotNull, jumpTo, fallthrough);
        }

        // end
        ip_start(endBlock);
        rewriter.create<mlir::LLVM::StackRestoreOp>(LOC, stackState);
        branch(LOC, jumpTo);
        rewriter.eraseOp(cjOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes
