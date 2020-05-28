#include <llvm/Support/DynamicLibrary.h>

#include <src/mlir/include/Standalone/ConstantManager.h>
#include <src/mlir/include/Standalone/Lowering/MyBuilder.h>
#include "Standalone/AllIncludes.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"

#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"


ExternFuncOp f_numericType;
ExternFuncOp f_sqlite3VdbeRealValue;
ExternFuncOp f_sqlite3AddInt64;
ExternFuncOp f_sqlite3SubInt64;
ExternFuncOp f_sqlite3MulInt64;
ExternFuncOp f_sqlite3IsNaN;

namespace mlir::standalone::passes {
    LogicalResult ArithmeticLowering::matchAndRewrite(Arithmetic mathOp, PatternRewriter &rewriter) const {
        auto op = &mathOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        myOperators

        auto pc = mathOp.pcAttr().getUInt();
        auto p1 = mathOp.P1Attr().getSInt();
        auto p2 = mathOp.P2Attr().getSInt();
        auto resultReg = mathOp.resultRegAttr().getSInt();

        auto* pOp = &vdbe->aOp[pc];

        if (false) {
            // TODO: Use our own implementation
            print(LOCL, "Calling into default implementation");
            store(LOC, 1, constants(T::i64PtrTy, &maxVdbeSteps));
            rewriter.create<StoreOp>(LOC, constants(pc, 32), constants(T::i32PtrTy, &vdbe->pc));
            call(LOC, f_sqlite3VdbeExec2, constants(T::VdbePtrTy, vdbe));
            rewriter.eraseOp(mathOp);
            return success();
        }

        auto firstBlock = rewriter.getBlock();
        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(mathOp); GO_BACK_TO(curBlock);

        auto blockResultIsNull = SPLIT_BLOCK; GO_BACK_TO(curBlock);

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

        /// pIn1 = &aMem[pOp->p1];
        auto pIn1Addr = &vdbe->aMem[p1];
        auto pIn1 = constants(T::sqlite3_valuePtrTy, pIn1Addr);

        /// type1 = numericType(pIn1);
        auto type1 = call(LOC, f_numericType, pIn1).getValue();

        /// pIn2 = &aMem[pOp->p2];
        auto pIn2Addr = &vdbe->aMem[p2];
        auto pIn2 = constants(T::sqlite3_valuePtrTy, pIn2Addr);

        /// type2 = numericType(pIn2);
        auto type2 = call(LOC, f_numericType, pIn2).getValue();

        /// pOut = &aMem[pOp->p3];
        auto pOutAddr = &vdbe->aMem[resultReg];
        auto flagsOutAddr = constants(T::i16PtrTy, &pOutAddr->flags);
        auto pOut = constants(T::sqlite3_valuePtrTy, pOutAddr);

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
        auto blockBothNotNull = SPLIT_BLOCK; GO_BACK_TO(curBlock);
        auto blockAnyNull = SPLIT_BLOCK; GO_BACK_TO(curBlock);
        auto blockNotBothInt = SPLIT_BLOCK; GO_BACK_TO(curBlock);
        auto blockBothInt = SPLIT_BLOCK; GO_BACK_TO(curBlock);

        condBranch(LOC, bothAreInt, blockBothInt, blockNotBothInt);
        { // if ((type1 & type2 & MEM_Int) != 0)
            ip_start(blockBothInt);

            auto curBlock = rewriter.getBlock();
            auto blockAfterSwitch = SPLIT_BLOCK; GO_BACK_TO(curBlock);

            /// iA = pIn1->u.i;
            auto iA = load(LOC, constants(T::i64PtrTy, &pIn1Addr->u.i));

            /// iB = pIn2->u.i;
            auto iBValue = load(LOC, constants(T::i64PtrTy, &pIn2Addr->u.i));
            auto iB = alloca(LOC, T::i64PtrTy);
            store(LOC, iBValue, iB);

            // IDEA: Use native operations here
            switch (pOp->opcode) {
                case OP_Add: {
                    /// if (sqlite3AddInt64(&iB, iA))
                    auto result = call(LOC, f_sqlite3AddInt64, iB, iA).getValue();

                    /// goto fp_math;
                    auto resultIsNull = iCmp(LOC, Pred::eq, result, 0);
                    condBranch(LOC, resultIsNull, blockAfterSwitch, blockBothNotNull);

                    break;
                }
                case OP_Subtract: {
                    auto result = call(LOC, f_sqlite3SubInt64, iB, iA).getValue();

                    /// goto fp_math;
                    auto resultIsNull = iCmp(LOC, Pred::eq, result, 0);
                    condBranch(LOC, resultIsNull, blockAfterSwitch, blockBothNotNull);

                    break;
                }
                case OP_Multiply: {
                    auto result = call(LOC, f_sqlite3MulInt64, iB, iA).getValue();

                    /// goto fp_math;
                    auto resultIsNull = iCmp(LOC, Pred::eq, result, 0);
                    condBranch(LOC, resultIsNull, blockAfterSwitch, blockBothNotNull);

                    break;
                }
                case OP_Divide: {
                    auto iAIsZero = iCmp(LOC, Pred::eq, iA, 0);

                    // TODO: if (iA == -1 && iB == SMALLEST_INT64) goto fp_math;

                    auto curBlock = rewriter.getBlock();
                    auto blockAfterIANotZero = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                    auto blockiAIsNotZero = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                    condBranch(LOC, iAIsZero, blockResultIsNull, blockiAIsNotZero);

                    { // if (iA != 0)
                        ip_start(blockiAIsNotZero);

                        auto newIB = sDiv(LOC, iBValue, iA);
                        store(LOC, (Value)newIB, iB);

                        branch(LOC, blockAfterSwitch);
                    } // end if (iA != 0)

                    ip_start(blockAfterIANotZero);

                    branch(LOC, blockAfterSwitch);

                    break;
                }
                default: /* Remainder */ {
                    auto iAIsZero = iCmp(LOC, Pred::eq, iA, 0);

                    // TODO: if (iA == -1) iA = 1;

                    auto curBlock = rewriter.getBlock();
                    auto blockAfterANotZero = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                    auto blockiAIsNotZero = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                    condBranch(LOC, iAIsZero, blockResultIsNull, blockiAIsNotZero);

                    { // if (iA != 0)
                        ip_start(blockiAIsNotZero);

                        // TODO: Lines 1688

                        print(LOCL, "Error: Remainder is not yet supported!");
                        myAssert(LOCL, constants(0, 1));

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
            store(LOC, iBValue, constants(T::i64PtrTy, &pOutAddr->u.i));

            /// MemSetTypeFlag(pOut, MEM_Int);
            auto flagsOut = load(LOC, flagsOutAddr);
            flagsOut = bitAnd(LOC, flagsOut, ~(MEM_Zero | MEM_TypeMask));
            flagsOut = bitOr(LOC, flagsOut, MEM_Int);
            store(LOC, flagsOut, flagsOutAddr);

            branch(LOC, blockAfterType);
        } // end if ((type1 & type2 & MEM_Int) != 0)
        { // else of if ((type1 & type2 & MEM_Int) != 0)
            ip_start(blockNotBothInt);
            auto anyNull = bitAnd(LOC, flags, MEM_Null);
            anyNull = iCmp(LOC, Pred::ne, anyNull, 0);
            condBranch(LOC, anyNull, blockAnyNull, blockBothNotNull);
        } // end else of if ((type1 & type2 & MEM_Int) != 0)
        { // if ((flags & MEM_Null) != 0) "AnyNull"
            ip_start(blockAnyNull);
            branch(LOC, blockResultIsNull);
        } // end if ((flags & MEM_Null) != 0) "AnyNull"
        { // else of if ((flags & MEM_Null) != 0) "BothNotNull"
            ip_start(blockBothNotNull);

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
                    rB = fRem(LOC, rB, rA);

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
                    /// iB = sqlite3VdbeIntValue(pIn2);
                    /// if (iA == 0) goto arithmetic_result_is_null;
                    /// if (iA == -1) iA = 1;
                    /// rB = (double) (iB % iA);
                    // TODO
                    print(LOCL, "ERROR: Unsupported Float Remainder");
                    myAssert(LOCL, constants(0, 1));
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
            store(LOC, rB, constants(T::doublePtrTy, &pOutAddr->u.r));

            /// MemSetTypeFlag(pOut, MEM_Real);
            auto flagsOut = load(LOC, flagsOutAddr);
            flagsOut = bitAnd(LOC, flagsOut, ~(MEM_Zero | MEM_TypeMask));
            flagsOut = bitOr(LOC, flagsOut, MEM_Real);
            store(LOC, flagsOut, flagsOutAddr);

            branch(LOC, blockAfterType);
        } // end else of if ((flags & MEM_Null) != 0) "BothNotNull"

        ip_start(blockAfterType);

        branch(LOC, endBlock);

        ip_start(endBlock);
        rewriter.eraseOp(mathOp);

        { // arithmetic_result_is_null:
            ip_start(blockResultIsNull);

            print(LOCL, "Arithmetic: Result is NULL");
            call(LOC, f_sqlite3VdbeMemSetNull, pOut);

            branch(LOC, endBlock);
        } // end arithmetic_result_is_null:

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes