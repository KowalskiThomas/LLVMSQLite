#include "Standalone/ConstantManager.h"
#include "Standalone/Lowering/MyBuilder.h"
#include "Standalone/Lowering/NumericType.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"
#include "Standalone/Lowering/MemSetNull.h"

#include "Standalone/StandalonePasses.h"

extern GlobalOp aMem;

#define JIT_STATIC_TYPING_ARITHMETIC

ExternFuncOp f_numericType;
ExternFuncOp f_sqlite3VdbeRealValue;
ExternFuncOp f_sqlite3AddInt64;
ExternFuncOp f_sqlite3SubInt64;
ExternFuncOp f_sqlite3MulInt64;
ExternFuncOp f_sqlite3IsNaN;
ExternFuncOp f_sqlite3VdbeIntValue;
ExternFuncOp f_printTypeOf;

extern "C" {
    extern const int* query_types[];
    extern const int query_id;
}

namespace mlir::standalone::passes {
    LogicalResult ArithmeticLowering::matchAndRewrite(Arithmetic mathOp, PatternRewriter &rewriter) const {
        auto op = &mathOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        Inlining::MemSetNull memSetNull(*vdbeCtx, *ctx, rewriter, print, constants);
        myOperators

        auto pc = mathOp.pcAttr().getUInt();
        auto p1 = mathOp.P1Attr().getSInt();
        auto p2 = mathOp.P2Attr().getSInt();
        auto resultReg = mathOp.resultRegAttr().getSInt();

        auto* pOp = &vdbe->aOp[pc];

        USE_DEFAULT_BOILERPLATE

        auto firstBlock = rewriter.getBlock();
        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(mathOp); GO_BACK_TO(curBlock);

        switch (pOp->opcode) {
            case OP_Add:
                print(LOCL, "-- Arithmetic / Add"); break;
            case OP_Subtract:
                print(LOCL, "-- Arithmetic / Subtract"); break;
            case OP_Multiply:
                print(LOCL, "-- Arithmetic / Multiply"); break;
            case OP_Divide:
                print(LOCL, "-- Arithmetic / Divide"); break;
            default:
                print(LOCL, "-- Arithmetic / Remainder"); break;
        }
        auto stackState = saveStack(LOC);

        auto numericType = Inlining::NumericType(context, rewriter, print, constants);

        /// pIn1 = &aMem[pOp->p1];
        auto pIn1 = getElementPtrImm(LOC, T::sqlite3_valuePtrTy, vdbeCtx->aMem, p1);

        /// pIn2 = &aMem[pOp->p2];
        auto pIn2 = getElementPtrImm(LOC, T::sqlite3_valuePtrTy, vdbeCtx->aMem, p2);

        /// pOut = &aMem[pOp->p3];
        auto pOutAddr = &vdbe->aMem[resultReg];
        auto pOut = getElementPtrImm(LOC, T::sqlite3_valuePtrTy, vdbeCtx->aMem, resultReg);
        auto flagsOutAddr = getElementPtrImm(LOC, T::i16PtrTy, pOut, 0, 1);

#ifdef JIT_STATIC_TYPING_ARITHMETIC
        { // A priori typing
            auto types = query_types[query_id > 0 ? 1 : 0];
            auto t1 = types[op->P1Attr().getSInt()];
            auto t2 = types[op->P2Attr().getSInt()];

            if (t1 != 0 && t1 == t2) {
                if (t1 == MEM_Real) {
                    out("Using REAL a priori knowledge on " << pOp->p1 << " and " << pOp->p2)
                    memSetTypeFlag(flagsOutAddr, MEM_Real);
                    auto outRealAddr = getElementPtrImm(LOC, T::doublePtrTy, pOut, 0, 0, 0);

                    auto r1Addr = getElementPtrImm(LOC, T::doublePtrTy, pIn1, 0, 0, 0);
                    auto r1 = load(LOC, r1Addr);

                    auto r2Addr = getElementPtrImm(LOC, T::doublePtrTy, pIn2, 0, 0, 0);
                    auto r2 = load(LOC, r2Addr);

                    switch(pOp->opcode) {
                        case OP_Add: {
                            auto result = fAdd(LOC, r1, r2);
                            store(LOC, result, outRealAddr);
                            break;
                        }
                        case OP_Subtract: {
                            auto result = fSub(LOC, r2, r1);
                            store(LOC, result, outRealAddr);
                            break;
                        }
                        case OP_Multiply: {
                            auto result = fMul(LOC, r1, r2);
                            store(LOC, result, outRealAddr);
                            break;
                        }
                        case OP_Divide: {
                            auto result = fDiv(LOC, r2, r1);
                            store(LOC, result, outRealAddr);
                            break;
                        }
                        case OP_Remainder: {
                            auto result = fRem(LOC, r2, r1);
                            store(LOC, result, outRealAddr);
                            break;
                        }
                    }
                    branch(LOC, endBlock);
                    ip_start(endBlock);
                    rewriter.eraseOp(mathOp);
                    return success();
                } else if (t1 == MEM_Int) {
                    out("Using INTEGER a priori knowledge on " << pOp->p1 << " and " << pOp->p2)
                    memSetTypeFlag(flagsOutAddr, MEM_Int);
                    auto outRealAddr = getElementPtrImm(LOC, T::doublePtrTy, pOut, 0, 0, 0);
                    auto outIntAddr = bitCast(LOC, outRealAddr, T::i64PtrTy);

                    auto r1Addr = getElementPtrImm(LOC, T::doublePtrTy, pIn1, 0, 0, 0);
                    auto i1Addr = bitCast(LOC, r1Addr, T::i64PtrTy);
                    auto i1 = load(LOC, i1Addr);

                    auto r2Addr = getElementPtrImm(LOC, T::doublePtrTy, pIn2, 0, 0, 0);
                    auto i2Addr = bitCast(LOC, r2Addr, T::i64PtrTy);
                    auto i2 = load(LOC, i2Addr);

                    switch(pOp->opcode) {
                        case OP_Add: {
                            auto result = add(LOC, i1, i2);
                            store(LOC, result, outIntAddr);
                            break;
                        }
                        case OP_Subtract: {
                            auto result = sub(LOC, i2, i1);
                            store(LOC, result, outIntAddr);
                            break;
                        }
                        case OP_Multiply: {
                            auto result = mul(LOC, i1, i2);
                            store(LOC, result, outIntAddr);
                            break;
                        }
                        case OP_Divide: {
                            auto result = isDiv(LOC, i2, i1);
                            store(LOC, result, outIntAddr);
                            break;
                        }
                        case OP_Remainder: {
                            auto result = isRem(LOC, i2, i1);
                            store(LOC, result, outIntAddr);
                            break;
                        }
                    }

                    branch(LOC, endBlock);
                    ip_start(endBlock);
                    rewriter.eraseOp(mathOp);
                    return success();
                } else {
                    /* Fallthrough */
                }
            }
        } // End a priori typing
#endif

        auto blockResultIsNull = SPLIT_BLOCK; GO_BACK_TO(curBlock);
        /// type1 = numericType(pIn1);
        auto type1 = numericType(LOC, pIn1);

        /// type2 = numericType(pIn2);
        auto type2 = numericType(LOC, pIn2);

        /// flags = pIn1->flags | pIn2->flags;
        // Get pIn1->flags
        auto flags1Addr = getElementPtrImm(LOC, T::i16PtrTy, pIn1, 0, 1);
        auto flags1 = load(LOC, flags1Addr);

        // Get pIn2->flags
        auto flags2Addr = getElementPtrImm(LOC, T::i16PtrTy, pIn2, 0, 1);
        auto flags2 = load(LOC, flags2Addr);

        // Compute pIn1->flags | pIn2->flags
        auto flags = bitOr(LOC, flags1, flags2);

        /// if ((type1 & type2 & MEM_Int) != 0)
        auto bothAreInt = bitAnd(LOC, type1, type2);
        bothAreInt = bitAnd(LOC, bothAreInt, MEM_Int);
        bothAreInt = iCmp(LOC, Pred::ne, bothAreInt, 0);

        curBlock = rewriter.getBlock();
        auto blockAfterType = SPLIT_BLOCK; GO_BACK_TO(curBlock);
        auto blockFpMath = SPLIT_BLOCK; GO_BACK_TO(curBlock);
        auto blockAnyNull = SPLIT_BLOCK; GO_BACK_TO(curBlock);
        auto blockNotBothInt = SPLIT_BLOCK; GO_BACK_TO(curBlock);
        auto blockBothInt = SPLIT_BLOCK; GO_BACK_TO(curBlock);

        condBranch(LOC, bothAreInt, blockBothInt, blockNotBothInt);
        { // if ((type1 & type2 & MEM_Int) != 0)
            ip_start(blockBothInt);

            auto curBlock = rewriter.getBlock();
            auto blockAfterSwitch = SPLIT_BLOCK; GO_BACK_TO(curBlock);

            /// iA = pIn1->u.i;
            auto iAUncasted = getElementPtrImm(LOC, T::doublePtrTy, pIn1, 0, 0);
            auto iAAddr = bitCast(LOC, iAUncasted, T::i64PtrTy);
            auto iA = load(LOC, iAAddr);

            /// iB = pIn2->u.i;
            auto iBValueAddrUncasted = getElementPtrImm(LOC, T::doublePtrTy, pIn2, 0, 0);
            auto iBValueAddr = bitCast(LOC, iBValueAddrUncasted, T::i64PtrTy);
            auto iBValue = load(LOC, iBValueAddr);
            auto iB = alloca(LOC, T::i64PtrTy);
            store(LOC, iBValue, iB);

            // IDEA: Use native operations here
            switch (pOp->opcode) {
                case OP_Add: {
                    /// if (sqlite3AddInt64(&iB, iA)) ...
                    auto result = call(LOC, f_sqlite3AddInt64, iB, iA).getValue();

                    /// ... goto fp_math;
                    auto resultIsFalse = iCmp(LOC, Pred::eq, result, 0);
                    condBranch(LOC, resultIsFalse, blockAfterSwitch, blockFpMath);

                    break;
                }
                case OP_Subtract: {
                    /// if (sqlite3SubInt64(&iB, iA)) ...
                    auto result = call(LOC, f_sqlite3SubInt64, iB, iA).getValue();

                    /// ... goto fp_math;
                    auto resultIsNull = iCmp(LOC, Pred::eq, result, 0);
                    condBranch(LOC, resultIsNull, blockAfterSwitch, blockFpMath);

                    break;
                }
                case OP_Multiply: {
                    /// if (sqlite3MulInt64(&iB, iA)) ...
                    auto result = call(LOC, f_sqlite3MulInt64, iB, iA).getValue();

                    /// ... goto fp_math;
                    auto resultIsFalse = iCmp(LOC, Pred::eq, result, 0);
                    condBranch(LOC, resultIsFalse, blockAfterSwitch, blockFpMath);

                    break;
                }
                case OP_Divide: {
                    auto iAIsZero = iCmp(LOC, Pred::eq, iA, 0);

                    auto iAIsNegOne = iCmp(LOC, Pred::eq, iA, -1);
                    auto iBIsSmallestInt64 = iCmp(LOC, Pred::eq, iBValue, SMALLEST_INT64);
                    auto fullCond = bitAnd(LOC, iAIsNegOne, iBIsSmallestInt64);

                    auto curBlock = rewriter.getBlock();
                    auto blockNoJump = SPLIT_GO_BACK_TO(curBlock);

                    condBranch(LOC, fullCond, blockFpMath, blockNoJump);
                    ip_start(blockNoJump);

                    curBlock = rewriter.getBlock();
                    auto blockAfterIANotZero = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                    auto blockiAIsNotZero = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                    condBranch(LOC, iAIsZero, blockResultIsNull, blockiAIsNotZero);

                    { // if (iA != 0)
                        ip_start(blockiAIsNotZero);

                        auto newIB = isDiv(LOC, iBValue, iA);
                        store(LOC, (Value)newIB, iB);

                        branch(LOC, blockAfterSwitch);
                    } // end if (iA != 0)

                    ip_start(blockAfterIANotZero);

                    branch(LOC, blockAfterSwitch);

                    break;
                }
                default: /* Remainder */ {
                    auto iAIsZero = iCmp(LOC, Pred::eq, iA, 0);

                    auto curBlock = rewriter.getBlock();
                    auto blockAfterANotZero = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                    auto blockiAIsNotZero = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                    condBranch(LOC, iAIsZero, blockResultIsNull, blockiAIsNotZero);
                    { // if (iA != 0)
                        ip_start(blockiAIsNotZero);

                        /// if (iA == -1) iA = 1;
                        auto iAIsNegOne = iCmp(LOC, Pred::eq, iA, -1);
                        auto tempAddr = alloca(LOC, T::i64PtrTy);
                        store(LOC, iA, tempAddr);
                        auto curBlock = rewriter.getBlock();
                        auto blockAfterAIsNegOne = SPLIT_GO_BACK_TO(curBlock);
                        auto blockAIsNegOne = SPLIT_GO_BACK_TO(curBlock);

                        condBranch(LOC, iAIsNegOne, blockAIsNegOne, blockAfterAIsNegOne);
                        { // if (iA == -1)
                            ip_start(blockAIsNegOne);

                            /// iA = 1
                            store(LOC, -1, tempAddr);

                            branch(LOC, blockAfterAIsNegOne);
                        } // end if (iA == -1)
                        ip_start(blockAfterAIsNegOne);

                        iA = load(LOC, tempAddr);

                        /// iB %= iA
                        auto result = isRem(LOC, iBValue, iA);
                        store(LOC, result, iB);

                        branch(LOC, blockAfterANotZero);
                    } // end if (iA != 0)

                    ip_start(blockAfterANotZero);

                    branch(LOC, blockAfterSwitch);
                    break;
                }
            }

            ip_start(blockAfterSwitch);

            /// pOut->u.i = iB;
            iBValue = load(LOC, iB);
            auto outputAddrUncasted = getElementPtrImm(LOC, T::doublePtrTy, pOut, 0, 0);
            auto outputAddr = bitCast(LOC, outputAddrUncasted, T::i64PtrTy);
            store(LOC, iBValue, outputAddr);

            /// MemSetTypeFlag(pOut, MEM_Int);
            memSetTypeFlag(flagsOutAddr, MEM_Int);

            branch(LOC, blockAfterType);
        } // end if ((type1 & type2 & MEM_Int) != 0)
        { // else of if ((type1 & type2 & MEM_Int) != 0)
            ip_start(blockNotBothInt);
            auto anyNull = bitAnd(LOC, flags, MEM_Null);
            anyNull = iCmp(LOC, Pred::ne, anyNull, 0);
            condBranch(LOC, anyNull, blockAnyNull, blockFpMath);
        } // end else of if ((type1 & type2 & MEM_Int) != 0)
        { // if ((flags & MEM_Null) != 0) "AnyNull"
            ip_start(blockAnyNull);
            branch(LOC, blockResultIsNull);
        } // end if ((flags & MEM_Null) != 0) "AnyNull"
        { // else of if ((flags & MEM_Null) != 0) "BothNotNull"
            ip_start(blockFpMath);

            /// rA = sqlite3VdbeRealValue(pIn1);
            auto rA = call(LOC, f_sqlite3VdbeRealValue, pIn1).getValue();

            /// rB = sqlite3VdbeRealValue(pIn2);
            auto rB = call(LOC, f_sqlite3VdbeRealValue, pIn2).getValue();

            switch (pOp->opcode) {
                case OP_Add: {
                    /// rB += rA;
                    rB = fAdd(LOC, rB, rA);

                    break;
                }
                case OP_Subtract: {
                    /// rB -= rA;
                    rB = fSub(LOC, rB, rA);

                    break;
                }
                case OP_Multiply: {
                    /// rB *= rA;
                    rB = fMul(LOC, rB, rA);

                    break;
                }
                case OP_Divide: {
                    /// TODO if (rA == (double) 0) goto arithmetic_result_is_null;
                    /// rB /= rA;
                    rB = fDiv(LOC, rB, rA);

                    break;
                }
                default: {
                    /// iA = sqlite3VdbeIntValue(pIn1);
                    auto iA = call(LOC, f_sqlite3VdbeIntValue, pIn1).getValue();
                    /// iB = sqlite3VdbeIntValue(pIn2);
                    auto iB = call(LOC, f_sqlite3VdbeIntValue, pIn2).getValue();

                    { /// if (iA == 0) goto arithmetic_result_is_null;
                        auto curBlock = rewriter.getBlock();
                        auto blockAfter = SPLIT_GO_BACK_TO(curBlock);
                        auto iANull = iCmp(LOC, Pred::eq, iA, 0);
                        condBranch(LOC, iANull, blockResultIsNull, blockAfter);
                        ip_start(blockAfter);
                    }

                    { /// if (iA == -1) iA = 1;
                        auto curBlock = rewriter.getBlock();
                        auto blockAfter = SPLIT_GO_BACK_TO(curBlock);
                        auto blockANegOne = SPLIT_GO_BACK_TO(curBlock);
                        auto iANegOne = iCmp(LOC, Pred::eq, iA, -1);
                        auto tempAddr = alloca(LOC, T::i64PtrTy);
                        store(LOC, iA, tempAddr);
                        condBranch(LOC, iANegOne, blockANegOne, blockAfter);
                        {
                            ip_start(blockANegOne);
                            store(LOC, 1, tempAddr);
                            branch(LOC, blockAfter);
                        }
                        ip_start(blockAfter);
                        iA = load(LOC, tempAddr);
                    }

                    /// rB = (double) (iB % iA);
                    auto result = isRem(LOC, iB, iA);
                    auto resultCasted = rewriter.create<mlir::LLVM::SIToFPOp>(LOC, T::doubleTy, result);
                    rB = resultCasted;

                    break;
                }
            }

            /// if (sqlite3IsNaN(rB)) goto arithmetic_result_is_null;
            auto curBlock = rewriter.getBlock();
            auto blockAfterIsNaN = SPLIT_BLOCK; GO_BACK_TO(curBlock);

            auto isNan = call(LOC, f_sqlite3IsNaN, rB).getValue();
            auto condIsNaN = iCmp(LOC, Pred::ne, isNan, 0);

            condBranch(LOC, condIsNaN, blockResultIsNull, blockAfterIsNaN);

            ip_start(blockAfterIsNaN);

            /// pOut->u.r = rB;
            auto pOut2 = getElementPtrImm(LOC, T::doublePtrTy, pOut, 0, 0);
            auto pOutA = bitCast(LOC, pOut2, T::doublePtrTy);
            store(LOC, rB, pOutA);

            /// MemSetTypeFlag(pOut, MEM_Real);
            memSetTypeFlag(flagsOutAddr, MEM_Real);

            branch(LOC, blockAfterType);
        } // end else of if ((flags & MEM_Null) != 0) "BothNotNull"

        ip_start(blockAfterType);

        branch(LOC, endBlock);

        ip_start(endBlock);

        restoreStack(LOC, stackState);
        rewriter.eraseOp(mathOp);

        { // arithmetic_result_is_null:
            ip_start(blockResultIsNull);

            print(LOCL, "Arithmetic: Result is NULL");
            memSetNull(LOC, pOut);
            // call(LOC, f_sqlite3VdbeMemSetNull, pOut);

            branch(LOC, endBlock);
        } // end arithmetic_result_is_null:

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes
