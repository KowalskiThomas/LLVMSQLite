#include "Standalone/ConstantManager.h"
#include "Standalone/Lowering/MyBuilder.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"

#include "Standalone/StandalonePasses.h"

ExternFuncOp f_applyAffinity;
ExternFuncOp f_sqlite3VarintLen;
ExternFuncOp f_sqlite3VdbeMemClearAndResize;
ExternFuncOp f_sqlite3PutVarint;
ExternFuncOp f_sqlite3VdbeSerialPut;

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

        auto printA = [&](mlir::Location loc, size_t line, auto& addr, const char* label) {
            print(loc, line, load(loc, addr), label);
        };

        auto firstBlock = rewriter.getBlock();

        // firstFromReg = P1
        auto firstFromReg = mrOp.firstRegFromAttr().getSInt();
        // nReg = P2
        auto nReg = mrOp.nRegAttr().getSInt();
        // dest = P3
        auto dest = mrOp.destAttr().getSInt();
        // affinities = P4
        auto affinities = (char*)(mrOp.affinitiesAttr().getUInt());
        // pc = vdbe->pc = Programme counter
        auto pc = mrOp.pcAttr().getUInt();

        print(LOCL, "-- MakeRecord");
        USE_DEFAULT_BOILERPLATE



        auto stackState = saveStack(LOC);

        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(mrOp); GO_BACK_TO(curBlock);

        /// i64 nData = 0
        auto nDataAddr = alloca(LOC, T::i64PtrTy);
        store(LOC, 0, nDataAddr);

        /// i32 nHdr = 0
        auto nHdrAddr = alloca(LOC, T::i32PtrTy);
        store(LOC, 0, nHdrAddr);

        /// i64 nZero = 0
        auto nZeroAddr = alloca(LOC, T::i64PtrTy);
        store(LOC, 0, nZeroAddr);

        /// u8* zPayload
        auto zPayloadAddr = alloca(LOC, T::i8PtrPtrTy);

        /// nField = pOp->p1;
        auto nField = firstFromReg;

        /// zAffinity = pOp->p4.z;
        auto pOpValue = getElementPtrImm(LOC, T::VdbeOpPtrTy, vdbeCtx->aOp, (int)pc);
        auto p4UAddr = getElementPtrImm(LOC, T::p4unionPtrTy, pOpValue, 0, 6);
        auto p4i8PtrAddr = bitCast(LOC, p4UAddr, T::i8PtrTy.getPointerTo());
        auto p4i8Ptr = load(LOC, p4i8PtrAddr);
        auto zAffinity = p4i8Ptr;

        /// pData0 = &aMem[nField];
        auto pData0Value = &vdbe->aMem[nField];
        auto pData0 = getElementPtrImm(LOC, T::sqlite3_valuePtrTy, vdbeCtx->aMem, nField);

        /// nField = pOp->p2;
        nField = nReg;

        /// pLast = &pData0[nField - 1];
        auto pLastValue = &pData0Value[nField - 1];
        auto pLast = getElementPtrImm(LOC, T::sqlite3_valuePtrTy, pData0, nField - 1);

        /// file_format = p->minWriteFileFormat;
        auto file_format = constants(vdbe->minWriteFileFormat, 32);

        /// pOut = &aMem[pOp->p3];
        auto pOutInitialValue = &vdbe->aMem[dest];
        auto pOut = getElementPtrImm(LOC, T::sqlite3_valuePtrTy, vdbeCtx->aMem, dest);

        /// if (zAffinity)
        if (affinities) {
            auto pRecValue = pData0Value;
            auto pRec = pData0;
            do {
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
                }
                affinities++;
                pRecValue++;
                pRec = getElementPtrImm(LOC, T::i8PtrTy, pRec, 1);
            } while (affinities[0]);
        }

        auto PlusPlus = [&](mlir::Location loc, AllocaOp& addr) {
            auto value = load(loc, addr);
            auto valuePlus1 = add(loc, value, 1);
            store(loc, valuePlus1, addr);
        };

        auto pRecValue = pLastValue;
        auto pRec = pLast;
        do {
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
            auto blockNotRecInt = SPLIT_BLOCK; GO_BACK_TO(curBlock);
            auto blockRecInt = SPLIT_BLOCK; GO_BACK_TO(curBlock);
            auto blockNotRecNull = SPLIT_BLOCK; GO_BACK_TO(curBlock);
            auto blockRecNull = SPLIT_BLOCK; GO_BACK_TO(curBlock);

            condBranch(LOC, recNull, blockRecNull, blockNotRecNull);
            { // if rec is NULL
                ip_start(blockRecNull);

                auto curBlock = rewriter.getBlock();
                auto blockAfterZero = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                auto blockNotZero = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                auto blockZero = SPLIT_BLOCK; GO_BACK_TO(curBlock);

                auto recIsZero = iCmp(LOC, Pred::ne, bitAnd(LOC, recFlagsValue, MEM_Zero), 0);
                print(LOCL, recIsZero, "RecIsZero");
                condBranch(LOC, recIsZero, blockZero, blockNotZero);
                { // if (pRec->flags & MEM_Zero)
                    ip_start(blockZero);

                    /// pRec->uTemp = 10;
                    store(LOC, 10, uTempAddress);

                    branch(LOC, blockAfterZero);
                } // end if (pRec->flags & MEM_Zero)
                { // else of if (pRec->flags & MEM_Zero)
                    ip_start(blockNotZero);

                    /// pRec->uTemp = 0;
                    store(LOC, 0, uTempAddress);

                    branch(LOC, blockAfterZero);
                } // end else of if (pRec->flags & MEM_Zero)

                ip_start(blockAfterZero);

                /// nHdr++
                print(LOCL, load(LOC, nHdrAddr), "nHdr");
                PlusPlus(LOC, nHdrAddr);
                print(LOCL, load(LOC, nHdrAddr), "nHdr++");

                branch(LOC, blockAfter);
            } // end if rec is NULL
            { // else of if rec is NULL
                ip_start(blockNotRecNull);
                condBranch(LOC, recInt, blockRecInt, blockNotRecInt);
            } // end else of if rec is NULL
            { // if rec is Int
                ip_start(blockRecInt);

                /// i64 i = pRec->u.i;
                auto pRecUnionAddr = getElementPtrImm(LOC, T::doublePtrTy, pRec, 0, 0);
                auto pRecIntegerAddr = bitCast(LOC, pRecUnionAddr, T::i64PtrTy);
                auto i = load(LOC, pRecIntegerAddr);

                auto uu = alloca(LOC, T::i64PtrTy);

                auto iNegative = iCmp(LOC, Pred::slt, i, 0);

                auto curBlock = rewriter.getBlock();
                auto blockAfterINegative = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                auto blockNotINegative = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                auto blockINegative = SPLIT_BLOCK; GO_BACK_TO(curBlock);

                condBranch(LOC, iNegative, blockINegative, blockNotINegative);
                { // if (i < 0)
                    ip_start(blockINegative);
print(LOCL, "is negative");
                    /// uu = ~i;
                    // We have ~X = X ^ 11..1
                    static_assert(~(uint64_t)(0) + 1 < ~(uint64_t)(0), "I was wrong");
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

                    auto curBlock = rewriter.getBlock();
                    auto blockAfterCondition = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                    auto blockNotCondition = SPLIT_BLOCK; GO_BACK_TO(curBlock);
                    auto blockCondition = SPLIT_BLOCK; GO_BACK_TO(curBlock);

                    /// if ((i & 1) == i && file_format >= 4)
                    auto iAnd1 = bitAnd(LOC, i, 1);
                    auto iAnd1Is1 = iCmp(LOC, Pred::eq, iAnd1, i);
                    auto fileFormatGe4 = iCmp(LOC, Pred::sge, file_format, 4);
                    auto condCondition = bitAnd(LOC, iAnd1Is1, fileFormatGe4);

                    condBranch(LOC, condCondition, blockCondition, blockNotCondition);
                    { // if ((i & 1) == i && file_format >= 4)
                        ip_start(blockCondition);

                        /// pRec->uTemp = 8 + (u32) uu;
                        auto val = load(LOC, uu);
                        val = rewriter.create<TruncOp>(LOC, T::i32Ty, val);
                        val = add(LOC, val, 8);
                        store(LOC, val, uTempAddress);

                        branch(LOC, blockAfterCondition);
                    } // end if ((i & 1) == i && file_format >= 4)
                    { // else of if ((i & 1) == i && file_format >= 4)
                        ip_start(blockNotCondition);

                        /// nData++
                        PlusPlus(LOC, nDataAddr);

                        /// pRec->uTemp = 1
                        store(LOC, 1, uTempAddress);

                        branch(LOC, blockAfterCondition);
                    } // end else of if ((i & 1) == i && file_format >= 4)

                    ip_start(blockAfterCondition);

                    branch(LOC, blockAfterSize);
                } // end if (uu <= 127)
                { // else of if (uu <= 127)
                    ip_start(blockNotSize1);
                    condBranch(LOC, uuSize2, blockSize2, blockNotSize2);
                } // end else of if (uu <= 127)
                { // if (uu <= 32767)
                    ip_start(blockSize2);

// print(LOCL, "Size 2");
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

// print(LOCL, "Size 3");
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

// print(LOCL, "Size 4");
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

// print(LOCL, "Size 5");
                    addInPlace(LOC, nDataAddr, 6);
                    store(LOC, 5, uTempAddress);

                    branch(LOC, blockAfterSize);
                } // end if (uu <= 140737488355327LL)
                { // else of if (uu <= 140737488355327LL)
                    ip_start(blockNotSize5);

// print(LOCL, "Size BIG");
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

            if (pRecValue == pData0Value)
                break;
            pRecValue--;
            pRec = getElementPtrImm(LOC, T::i8PtrTy, pRec, -1);

        } while (true);

        // Line 3160 (and on)

        auto zAddress = getElementPtrImm(LOC, T::i8PtrTy, pOut, 0, 5);

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

        /// nByte = nHdr + nData;
        auto nHdr64 = zExt(LOC, load(LOC, nHdrAddr), T::i64Ty);
        auto nByte = add(LOC, nHdr64, load(LOC, nDataAddr));

        /// if (nByte + nZero <= pOut->szMalloc)
        auto szMallocAddr = getElementPtrImm(LOC, T::i32PtrTy, pOut, 0, 7);
        auto szMalloc = load(LOC, szMallocAddr);
        auto szMalloc64 = rewriter.create<ZExtOp>(LOC, T::i64Ty, szMalloc);
        auto nZeroValue = load(LOC, nZeroAddr);
        auto nBytePlusNZero = add(LOC, nByte, nZeroValue);
        auto lengthLtMallocSize = iCmp(LOC, Pred::sle, nBytePlusNZero, (Value)szMalloc64);

        curBlock = rewriter.getBlock();
        auto blockAfterLengthLtMallocSize = SPLIT_BLOCK; GO_BACK_TO(curBlock);
        auto blockNotLengthLtMallocSize = SPLIT_BLOCK; GO_BACK_TO(curBlock);
        auto blockLengthLtMallocSize = SPLIT_BLOCK; GO_BACK_TO(curBlock);

        condBranch(LOC, lengthLtMallocSize, blockLengthLtMallocSize, blockNotLengthLtMallocSize);
        { // if (nByte + nZero <= pOut->szMalloc)
            ip_start(blockLengthLtMallocSize);

            /// pOut->z = pOut->zMalloc;
            auto zMallocAddress = getElementPtrImm(LOC, T::i8PtrTy, pOut, 0, 6);
            auto zMalloc = load(LOC, zMallocAddress);
            store(LOC, zMalloc, zAddress);

            branch(LOC, blockAfterLengthLtMallocSize);
        } // end if (nByte + nZero <= pOut->szMalloc)
        { // else of if (nByte + nZero <= pOut->szMalloc)
            ip_start(blockNotLengthLtMallocSize);

            auto curBlock = rewriter.getBlock();
            auto blockAfterMoreThanLimitLength = SPLIT_BLOCK; GO_BACK_TO(curBlock);
            auto blockMoreThanLimitLength = SPLIT_BLOCK; GO_BACK_TO(curBlock);

            auto condMoreThanLimitLength = iCmp(LOC, Pred::sgt, nBytePlusNZero, vdbe->db->aLimit[SQLITE_LIMIT_LENGTH]);

            condBranch(LOC, condMoreThanLimitLength, blockMoreThanLimitLength, blockAfterMoreThanLimitLength);
            { // if (nByte + nZero > db->aLimit[SQLITE_LIMIT_LENGTH])
                ip_start(blockMoreThanLimitLength);

                print(LOCL, "Error: too_big");
                myAssert(LOCL, constants(0, 1));

                branch(LOC, blockAfterMoreThanLimitLength);
             } // end if (nByte + nZero > db->aLimit[SQLITE_LIMIT_LENGTH])

            ip_start(blockAfterMoreThanLimitLength);

            /// if (sqlite3VdbeMemClearAndResize(pOut, (int) nByte))
            curBlock = rewriter.getBlock();
            auto blockAfterClearAndResize = SPLIT_BLOCK; GO_BACK_TO(curBlock);
            auto blockClearAndResize = SPLIT_BLOCK; GO_BACK_TO(curBlock);

            auto nByte32 = rewriter.create<TruncOp>(LOC, T::i32Ty, nByte);
            auto callResult = call(LOC, f_sqlite3VdbeMemClearAndResize, pOut, nByte32).getValue();
            auto condClearAndResize = iCmp(LOC, Pred::ne, callResult, 0);

            condBranch(LOC, condClearAndResize, blockClearAndResize, blockAfterClearAndResize);
            { // if (sqlite3VdbeMemClearAndResize(pOut, (int) nByte))
                ip_start(blockClearAndResize);

                print(LOCL, "sqlite3VdbeMemClearAndResize returned not null");
                myAssert(LOCL, constants(0, 1));

                branch(LOC, blockAfterClearAndResize);
             } // end if (sqlite3VdbeMemClearAndResize(pOut, (int) nByte))

            ip_start(blockAfterClearAndResize);

            branch(LOC, blockAfterLengthLtMallocSize);
        } // end else of if (nByte + nZero <= pOut->szMalloc)

        ip_start(blockAfterLengthLtMallocSize);

        /// pOut->n = (int) nByte;
        auto nAddr = getElementPtrImm(LOC, T::i32PtrTy, pOut, 0, 4);
        auto nByte32 = rewriter.create<TruncOp>(LOC, T::i32Ty, nByte);
        store(LOC, (Value)nByte32, nAddr);

        /// pOut->flags = MEM_Blob;
        auto flagsAddr = getElementPtrImm(LOC, T::i16PtrTy, pOut, 0, 1);
        store(LOC, MEM_Blob, flagsAddr);

        /// if (nZero)
        curBlock = rewriter.getBlock();
        auto blockAfterNZeroNotNull = SPLIT_BLOCK; GO_BACK_TO(curBlock);
        auto blockNZeroNotNull = SPLIT_BLOCK; GO_BACK_TO(curBlock);

        nZeroValue = load(LOC, nZeroAddr);
        auto condNZeroNotNull = iCmp(LOC, Pred::ne, nZeroValue, 0);

        condBranch(LOC, condNZeroNotNull, blockNZeroNotNull, blockAfterNZeroNotNull);
        { // if (nZero)
            ip_start(blockNZeroNotNull);

            /// pOut->u.nZero = nZero;
            auto unionValueAddress = getElementPtrImm(LOC, T::doublePtrTy, pOut, 0, 0, 0);
            auto nZeroAddr = bitCast(LOC, unionValueAddress, T::i32PtrTy);
            auto nZeroValue32 = rewriter.create<TruncOp>(LOC, T::i32Ty, nZeroValue);
            store(LOC, (Value)nZeroValue32, nZeroAddr);

            /// pOut->flags |= MEM_Zero;
            auto flagsValue = load(LOC, flagsAddr);
            auto flagsOrZero = bitOr(LOC, flagsValue, MEM_Zero);
            store(LOC, flagsOrZero, flagsAddr);

            branch(LOC, blockAfterNZeroNotNull);
         } // end if (nZero)

        ip_start(blockAfterNZeroNotNull);

        /// zHdr = (u8 *) pOut->z;
        auto zHdrAddr = alloca(LOC, T::i8PtrPtrTy);
        auto zHdrValue = load(LOC, zAddress);
        store(LOC, zHdrValue, zHdrAddr);

        /// zPayload = zHdr + nHdr; <=> zPayload = &zHdr[nHdr]
        nHdrValue = load(LOC, nHdrAddr);
        nHdrValue64 = rewriter.create<ZExtOp>(LOC, T::i64Ty, nHdrValue);
        {
            // Put that in a restricted scope to not have access to them later
            auto zPayloadValue = getElementPtr(LOC, T::i8PtrTy, zHdrValue, nHdrValue);
            // auto zPayloadValue = load(LOC, zPayloadValueAddr);
            store(LOC, zPayloadValue, zPayloadAddr);
        }

        /// zHdr += putVarint32(zHdr, nHdr) <=> zHdr = &zHdr[putVarInt(...)]
        // TODO: print(LOCL, "TODO: Replace function call with macro expansion");
        auto putVarIntResult = call(LOC, f_sqlite3PutVarint, zHdrValue, nHdrValue64).getValue();
        zHdrValue = getElementPtr(LOC, T::i8PtrTy, zHdrValue, putVarIntResult);
        store(LOC, zHdrValue, zHdrAddr);

        /// pRec = pData0
        pRecValue = pData0Value;
        pRec = pData0;
        Value zPayloadValue = load(LOC, zPayloadAddr);
        do {
            /// serial_type = pRec->uTemp;
            auto uTempAddress = getElementPtrImm(LOC, T::i32PtrTy, pRec, 0, 8);
            auto serialType = load(LOC, uTempAddress);
            auto serialType64 = rewriter.create<ZExtOp>(LOC, T::i64Ty, serialType);

            /// zHdr += putVarint32(zHdr, serial_type);
            // TODO print(LOCL, "TODO: Replace function call with macro expansion");
            auto putVarIntResult = call(LOC, f_sqlite3PutVarint, zHdrValue, serialType64).getValue();
            zHdrValue = getElementPtr(LOC, T::i8PtrTy, zHdrValue, putVarIntResult);
            store(LOC, zHdrValue, zHdrAddr);

            /// zPayload += sqlite3VdbeSerialPut(zPayload, pRec, serial_type);
            auto serialPutResult = call(LOC, f_sqlite3VdbeSerialPut, zPayloadValue, pRec, serialType).getValue();
            zPayloadValue = getElementPtr(LOC, T::i8PtrTy, zPayloadValue, serialPutResult);

            pRec = getElementPtrImm(LOC, T::i8PtrTy, pRec, 1);
        } while ((++pRecValue) <= pLastValue);

        branch(LOC, endBlock);

        ip_start(endBlock);
        restoreStack(LOC, stackState);
        rewriter.eraseOp(mrOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes