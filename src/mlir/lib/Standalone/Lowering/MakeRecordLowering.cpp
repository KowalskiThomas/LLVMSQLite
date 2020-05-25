#include <llvm/Support/DynamicLibrary.h>

#include <src/mlir/include/Standalone/ConstantManager.h>
#include <src/mlir/include/Standalone/Lowering/MyBuilder.h>
#include "Standalone/AllIncludes.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"

#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"

ExternFuncOp f_applyAffinity;
ExternFuncOp f_sqlite3VarintLen;

namespace mlir::standalone::passes {
    LogicalResult MakeRecordLowering::matchAndRewrite(MakeRecord mrOp, PatternRewriter &rewriter) const {
        auto op = &mrOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        myOperators

        auto firstBlock = rewriter.getBlock();

        // firstFromReg = P1
        auto firstFromReg = mrOp.firstRegFromAttr().getSInt();
        // nReg = P2
        auto nReg = mrOp.nRegAttr().getSInt();
        // dest = P3
        auto dest = mrOp.destAttr().getSInt();
        // affinities = P4
        auto affinities = (char*)(mrOp.affinitiesAttr().getUInt());

        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(mrOp); GO_BACK_TO(curBlock);

        /// i64 nData = 0
        auto nDataAddr = alloca(LOC, T::i64PtrTy);
        /// i32 nHdr = 0
        auto nHdrAddr = alloca(LOC, T::i32PtrTy);
        /// i64 nZero = 0
        auto nZeroAddr = alloca(LOC, T::i64PtrTy);

        auto nField = firstFromReg;
        auto pData0Value = &vdbe->aMem[nField];
        auto pData0 = constants(T::sqlite3_valuePtrTy, pData0Value);
        nField = nReg;
        auto pLastValue = &pData0Value[nField - 1];
        auto pLast = constants(T::sqlite3_valuePtrTy, pLastValue);
        auto file_format = constants(vdbe->minWriteFileFormat, 32);

        auto zAffinity = constants(T::i8PtrTy, affinities);

        /// pOut = &aMem[pOp->p3];
        auto pOut = constants(T::sqlite3_valuePtrTy, &vdbe->aMem[dest]);

        if (affinities) {
            auto pRecValue = pData0Value;
            do {
                auto pRec = constants(T::sqlite3_valuePtrTy, pRecValue);
                call(LOC, f_applyAffinity,
                    pRec,
                    constants(affinities[0], 8),
                    constants(vdbe->db->enc, 8)
                );

                if (affinities[0] == SQLITE_AFF_REAL) {
                    auto pRecFlagsAddr = getElementPtrImm(LOC, T::i16PtrTy, pRec, 0, 1);
                    auto pRecFlagsValue = load(LOC, pRecFlagsAddr);
                    auto flagsAndInt = bitAnd(LOC, pRecFlagsValue, MEM_Int);
                    auto flagsAndIntNotNull = iCmp(LOC, Pred::ne, flagsAndInt, 0);

                    auto curBlock = rewriter.getBlock();
                    auto blockAfterRecIsInt = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                    auto blockRecIsInt = SPLIT_BLOCK; GO_BACK_TO(curBlock);

                    { // if (pRec->flags & MEM_Int)
                        ip_start(blockRecIsInt);

                        auto flagsOrIntReal = bitOr(LOC, pRecFlagsValue, MEM_IntReal);
                        auto flagsAndNotInt = bitAnd(LOC, flagsOrIntReal, ~(MEM_Int));

                        store(LOC, flagsAndNotInt, pRecFlagsAddr);

                        branch(LOC, blockAfterRecIsInt);
                    } // end if (pRec->flags & MEM_Int)

                    ip_start(blockAfterRecIsInt);

                    affinities++;
                    pRecValue++;
                }
            } while (affinities[0]);
        }

        auto PlusPlus = [&](mlir::Location loc, AllocaOp& addr) {
            auto value = load(loc, addr);
            auto valuePlus1 = add(loc, value, 1);
            store(loc, valuePlus1, addr);
        };

        auto pRecValue = pLastValue;
        do {
            auto pRec = constants(T::sqlite3_valuePtrTy, pRecValue);
            auto recFlagsAddr = getElementPtrImm(LOC, T::i16PtrTy, pRec, 0, 1);
            auto recFlagsValue = load(LOC, recFlagsAddr);

            auto recNull = iCmp(LOC, Pred::ne, bitAnd(LOC, recFlagsValue, MEM_Null), 0);
            auto recInt = iCmp(LOC, Pred::ne, bitAnd(LOC, recFlagsValue, MEM_Int | MEM_IntReal), 0);
            auto recReal = iCmp(LOC, Pred::ne, bitAnd(LOC, recFlagsValue, MEM_Real), 0);
            auto uTempAddress = getElementPtrImm(LOC, T::i32PtrTy, pRec, 0, 8);

            auto curBlock = rewriter.getBlock();
            auto blockAfter = SPLIT_BLOCK; GO_BACK_TO(curBlock);
            auto blockElseType = SPLIT_BLOCK; GO_BACK_TO(curBlock);
            auto blockRecReal = SPLIT_BLOCK; GO_BACK_TO(curBlock);
            auto blockRecInt = SPLIT_BLOCK; GO_BACK_TO(curBlock);
            auto blockRecNull = SPLIT_BLOCK; GO_BACK_TO(curBlock);
            auto blockNotRecNull = SPLIT_BLOCK; GO_BACK_TO(curBlock);
            auto blockNotRecInt = SPLIT_BLOCK; GO_BACK_TO(curBlock);

            condBranch(LOC, recNull, blockRecNull, blockNotRecNull);
            { // if rec is NULL
                ip_start(blockRecNull);


                auto curBlock = rewriter.getBlock();
                auto blockAfterZero = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                auto blockNotZero = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                auto blockZero = SPLIT_BLOCK; GO_BACK_TO(curBlock);

                auto recIsZero = iCmp(LOC, Pred::ne, bitAnd(LOC, recFlagsValue, MEM_Zero), 0);
                condBranch(LOC, recIsZero, blockZero, blockNotZero);
                { // if (pRec->flags & MEM_Zero)
                    ip_start(blockZero);

                    store(LOC, 10, uTempAddress);

                    branch(LOC, blockAfterZero);
                } // end if (pRec->flags & MEM_Zero)
                { // else of if (pRec->flags & MEM_Zero)
                    ip_start(blockNotZero);

                    store(LOC, 0, uTempAddress);

                    branch(LOC, blockAfterZero);
                } // end else of if (pRec->flags & MEM_Zero)

                ip_start(blockAfterZero);

                /// nHdr++
                PlusPlus(LOC, nHdrAddr);

                branch(LOC, blockAfter);
            } // end if rec is NULL
            { // else of if rec is NULL
                ip_start(blockNotRecNull);
                condBranch(LOC, recInt, blockRecInt, blockNotRecInt);
            } // end else of if rec is NULL
            { // if rec is Int
                ip_start(blockRecInt);

                /// i64 i = pRec->u.i;
                auto i = load(LOC, constants(T::i64PtrTy, &pRecValue->u));

                auto uu = alloca(LOC, T::i64PtrTy);

                auto iNegative = iCmp(LOC, Pred::slt, i, 0);

                auto curBlock = rewriter.getBlock();
                auto blockAfterINegative = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                auto blockNotINegative = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                auto blockINegative = SPLIT_BLOCK; GO_BACK_TO(curBlock);

                condBranch(LOC, iNegative, blockINegative, blockNotINegative);
                { // if (i < 0)
                    ip_start(blockINegative);

                    /// uu = ~i;
                    // We have ~X = X ^ 11..1
                    auto notI = rewriter.create<mlir::LLVM::XOrOp>(LOC, i, constants(~(uint64_t)(0), 64));
                    store(LOC, (Value)notI, uu);

                    branch(LOC, blockAfterINegative);
                } // end if (i < 0)
                { // else of if (i < 0)
                    ip_start(blockNotINegative);

                    store(LOC, i, uu);

                    branch(LOC, blockAfterINegative);
                } // end else of if (i < 0)

                ip_start(blockAfterINegative);

                PlusPlus(LOC, nHdrAddr);

                auto uuVal = load(LOC, uu);
                auto uuSize1 = iCmp(LOC, Pred::slt, uuVal, 127);
                auto uuSize2 = iCmp(LOC, Pred::slt, uuVal, 32767);
                auto uuSize3 = iCmp(LOC, Pred::slt, uuVal, 8388607);
                auto uuSize4 = iCmp(LOC, Pred::slt, uuVal, 2147483647);
                auto uuSize5 = iCmp(LOC, Pred::slt, uuVal, 140737488355327LL);

                curBlock = rewriter.getBlock();
                auto blockAfterSize = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                auto blockNotSize5 = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                auto blockSize5 = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                auto blockNotSize4 = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                auto blockSize4 = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                auto blockNotSize3 = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                auto blockSize3 = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                auto blockNotSize2 = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                auto blockSize2 = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                auto blockNotSize1 = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                auto blockSize1 = SPLIT_BLOCK; GO_BACK_TO(curBlock);

                condBranch(LOC, uuSize1, blockSize1, blockNotSize1);
                { // if (uu <= 127)
                    ip_start(blockSize1);
                    print(LOCL, "TODO: 3099-..");
                    branch(LOC, blockAfterSize);
                } // end if (uu <= 127)
                { // else of if (uu <= 127)
                    ip_start(blockNotSize1);
                    condBranch(LOC, uuSize2, blockSize2, blockNotSize2);
                } // end else of if (uu <= 127)
                { // if (uu <= 32767)
                    ip_start(blockSize2);

                    addInPlace(LOC, nDataAddr, 2);
                    store(LOC, 2, uTempAddress);

                    branch(LOC, blockAfterSize);
                } // end if (uu <= 32767)
                { // else of if (uu <= 32767)
                    ip_start(blockNotSize2);
                    condBranch(LOC, uuSize3, blockSize3, blockNotSize3);
                } // end else of if (uu <= 32767)
                { // if (uu <= 8388607)
                    ip_start(blockSize3);

                    addInPlace(LOC, nDataAddr, 3);
                    store(LOC, 3, uTempAddress);

                    branch(LOC, blockAfterSize);
                } // end if (uu <= 8388607)
                { // else of if (uu <= 8388607)
                    ip_start(blockNotSize3);
                    condBranch(LOC, uuSize4, blockSize4, blockNotSize4);
                } // end else of if (uu <= 8388607)
                { // if (uu <= 2147483647)
                    ip_start(blockSize4);

                    addInPlace(LOC, nDataAddr, 4);
                    store(LOC, 4, uTempAddress);

                    branch(LOC, blockAfterSize);
                } // end if (uu <= 2147483647)
                { // else of if (uu <= 2147483647)
                    ip_start(blockNotSize4);
                    condBranch(LOC, uuSize5, blockSize5, blockNotSize5);
                } // end else of if (uu <= 2147483647)
                { // if (uu <= 140737488355327LL)
                    ip_start(blockSize5);

                    addInPlace(LOC, nDataAddr, 6);
                    store(LOC, 5, uTempAddress);

                    branch(LOC, blockAfterSize);
                } // end if (uu <= 140737488355327LL)
                { // else of if (uu <= 140737488355327LL)
                    ip_start(blockNotSize5);

                    addInPlace(LOC, nDataAddr, 8);

                    auto curBlock = rewriter.getBlock();
                    auto blockNotRecIntReal = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                    auto blockRecIntReal = SPLIT_BLOCK; GO_BACK_TO(curBlock);

                    auto recIsIntReal = iCmp(LOC, Pred::ne, bitAnd(LOC, recFlagsValue, MEM_IntReal), 0);
                    condBranch(LOC, recIsIntReal, blockRecIntReal, blockNotRecIntReal);

                    { // if (pRec->flags & MEM_IntReal)
                        ip_start(blockRecIntReal);

                        auto newFlags = recFlagsValue;
                        newFlags = bitAnd(LOC, newFlags, ~(MEM_IntReal));
                        newFlags = bitOr(LOC, newFlags, MEM_Real);
                        store(LOC, newFlags, recFlagsAddr);
                        store(LOC, 7, uTempAddress);

                        branch(LOC, blockAfterSize);
                    } // end if (pRec->flags & MEM_IntReal)
                    { // else of if (pRec->flags & MEM_IntReal)
                        ip_start(blockNotRecIntReal);
                        store(LOC, 6, uTempAddress);
                        branch(LOC, blockAfterSize);
                    } // end else of (pRec->flags & MEM_IntReal)

                    // branch(LOC, blockAfterSize);
                } // end else of if (uu <= 140737488355327LL)

                ip_start(blockAfterSize);

                branch(LOC, blockAfter);

            } // end if rec is Int
            { // else of if rec is Int
                ip_start(blockNotRecInt);
                condBranch(LOC, recReal, blockRecReal, blockElseType);
            } // end of else if rec is Int
            { // if rec is Real
                ip_start(blockRecReal);

                PlusPlus(LOC, nHdrAddr);
                addInPlace(LOC, nDataAddr, 8);
                store(LOC, 7, uTempAddress);

                branch(LOC, blockAfter);
            } // end if rec is Real
            { // else of if rec is Real
                ip_start(blockElseType);

                /// len = (u32) pRec->n;
                auto nAddr = getElementPtrImm(LOC, T::i32PtrTy, pRec, 0, 4);
                auto lenInitialValue = load(LOC, nAddr);
                auto lenAddr = alloca(LOC, T::i32PtrTy);
                store(LOC, lenInitialValue, lenAddr);

                /// serial_type = (len * 2) + 12 + ((pRec->flags & MEM_Str) != 0);
                auto serialTypeAddr = alloca(LOC, T::i32PtrTy);
                auto twoLen = add(LOC, lenInitialValue, lenInitialValue);
                auto plus12 = add(LOC, twoLen, 12);
                auto flagsAndStr = bitAnd(LOC, recFlagsValue, MEM_Str);
                auto flagsAndStrNotNull = iCmp(LOC, Pred::ne, flagsAndStr, 0);
                auto flagsAndStrNN32 = rewriter.create<ZExtOp>(LOC, T::i32Ty, flagsAndStrNotNull);
                auto serialTypeInitialValue = add(LOC, plus12, (Value)flagsAndStrNN32);
                store(LOC, serialTypeInitialValue, serialTypeAddr);

                auto flagsAndZero = bitAnd(LOC, recFlagsValue, MEM_Zero);

                auto curBlock = rewriter.getBlock();
                auto blockAfterRecIsZero = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                auto blockRecIsZero = SPLIT_BLOCK; GO_BACK_TO(curBlock);

                auto recIsZero = iCmp(LOC, Pred::ne, flagsAndZero, 0);
                condBranch(LOC, recIsZero, blockRecIsZero, blockAfterRecIsZero);
                { // if (pRec->flags & MEM_Zero)
                    ip_start(blockRecIsZero);

                    /// serial_type += pRec->u.nZero * 2;
                    // Get &pRec->u
                    auto pRecUnionAddr = getElementPtrImm(LOC, T::doublePtrTy, pRec, 0, 0);
                    // Cast &pRec->u to (i32*)
                    auto pRecNZeroAddr = bitCast(LOC, pRecUnionAddr, T::i32PtrTy);
                    // Load pRec->u.nZero
                    auto pRecNZeroValue = load(LOC, pRecNZeroAddr);
                    // Compute pRec->u.nZero * 2
                    auto nZero2 = add(LOC, pRecNZeroValue, pRecNZeroValue);
                    // Add it to serial_type
                    addInPlace(LOC, serialTypeAddr, nZero2);

                    auto curBlock = rewriter.getBlock();
                    auto blockNDataNotNull = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                    auto blockNDataNull = SPLIT_BLOCK; GO_BACK_TO(curBlock);

                    auto nDataNotNull = iCmp(LOC, Pred::ne, load(LOC, nDataAddr), 0);
                    condBranch(LOC, nDataNotNull, blockNDataNotNull, blockNDataNull);
                    { // if (nData)
                        ip_start(blockNDataNotNull);

                        /// if (sqlite3VdbeMemExpandBlob(pRec)) goto no_mem;
                        auto rc = call(LOC, f_sqlite3VdbeMemExpandBlob, pRec).getValue();
                        { // if (sqlite3VdbeMemExpandBlob(pRec)) goto no_mem;
                            auto rcIsNull = iCmp(LOC, Pred::eq, rc, 0);
                            myAssert(LOCL, rcIsNull);
                        } // end if (sqlite3VdbeMemExpandBlob(pRec)) goto no_mem;

                        /// len += pRec->u.nZero;
                        addInPlace(LOC, lenAddr, pRecNZeroValue);

                        branch(LOC, blockAfterRecIsZero);
                    } // end if (nData)
                    { // else of if (nData)
                        ip_start(blockNDataNull);
                        /// nZero += pRec->u.nZero;
                        auto pRecNZeroValue64 = rewriter.create<ZExtOp>(LOC, T::i64Ty, pRecNZeroValue);
                        addInPlace(LOC, nZeroAddr, (Value)pRecNZeroValue64);
                        branch(LOC, blockAfterRecIsZero);
                    } // end else of if (nData)

                    // branch(LOC, blockAfterRecIsZero);
                } // end if (pRec->flags & MEM_Zero)

                ip_start(blockAfterRecIsZero);

                /// nData += len;
                auto lenValue = load(LOC, lenAddr);
                auto len64 = rewriter.create<ZExtOp>(LOC, T::i64Ty, lenValue);
                addInPlace(LOC, nDataAddr, (Value)len64);

                /// nHdr += sqlite3VarintLen(serial_type);
                auto serialTypeValue = load(LOC, serialTypeAddr);
                auto serialTypeValue64 = rewriter.create<ZExtOp>(LOC, T::i64Ty, serialTypeValue);
                auto callResult = call(LOC, f_sqlite3VarintLen, serialTypeValue64).getValue();
                addInPlace(LOC, nHdrAddr, callResult);

                /// pRec->uTemp = serial_type;
                store(LOC, serialTypeValue, uTempAddress);

                branch(LOC, blockAfter);
            } // end else of if rec is Real

            ip_start(blockAfter);

            pRecValue--;
            if (pRecValue == pData0Value)
                break;

        } while (true);

        // Line 3160 (and on)

        auto nHdrValue = load(LOC, nHdrAddr);
        auto nHdrValue64 = rewriter.create<ZExtOp>(LOC, T::i64Ty, nHdrValue);
        auto nHdrLt126 = iCmp(LOC, Pred::slt, nHdrValue, 126);
        curBlock = rewriter.getBlock();
        auto blockAfterNHdrLt126 = SPLIT_BLOCK; GO_BACK_TO(curBlock);
        auto blockNotNHdrLt126 = SPLIT_BLOCK; GO_BACK_TO(curBlock);
        auto blockNHdrLt126 = SPLIT_BLOCK; GO_BACK_TO(curBlock);

        condBranch(LOC, nHdrLt126, blockNHdrLt126, blockNotNHdrLt126);
        { // if (nHdr <= 126)
            ip_start(blockNHdrLt126);
            /// nHdr += 1;
            addInPlace(LOC, nHdrAddr, 1);
            branch(LOC, blockAfterNHdrLt126);
        } // end if (nHdr <= 126)
        { // else of if (nHdr <= 126)
            ip_start(blockNotNHdrLt126);

            /// nVarint = sqlite3VarintLen(nHdr);
            auto nVarint = call(LOC, f_sqlite3VarintLen, nHdrValue64).getValue();

            /// nHdr += nVarint;
            addInPlace(LOC, nHdrAddr, nVarint);

            /// if (nVarint < sqlite3VarintLen(nHdr)) nHdr++;
            curBlock = rewriter.getBlock();
            auto blockVarintLtNHdr = SPLIT_BLOCK; GO_BACK_TO(curBlock);
            auto varintLen = call(LOC, f_sqlite3VarintLen, nHdrValue64).getValue();
            auto nVarintLt = iCmp(LOC, Pred::slt, nVarint, varintLen);
            condBranch(LOC, nVarintLt, blockVarintLtNHdr, blockAfterNHdrLt126);
            { // if (nVarint < sqlite3VarintLen(nHdr))
                ip_start(blockVarintLtNHdr);
                /// nHdr++
                addInPlace(LOC, nHdrAddr, 1);
                branch(LOC, blockAfterNHdrLt126);
            } // end if (nVarint < sqlite3VarintLen(nHdr))
            // (Replaced) branch(LOC, blockAfterNHdrLt126);
        } // end else of (nHdr <= 126)

        ip_start(blockAfterNHdrLt126);

        auto nHdr64 = rewriter.create<ZExtOp>(LOC, T::i64Ty, load(LOC, nHdrAddr));
        auto nByte = add(LOC, nHdr64, load(LOC, nDataAddr));

        branch(LOC, endBlock);

        ip_start(endBlock);
        print(LOCL, "end of makerecord");
        rewriter.eraseOp(mrOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes