#include <llvm/Support/DynamicLibrary.h>

#include <src/mlir/include/Standalone/ConstantManager.h>
#include <src/mlir/include/Standalone/Lowering/MyBuilder.h>
#include "Standalone/AllIncludes.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"

#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"


namespace mlir::standalone::passes {
    LogicalResult AggStepLowering::matchAndRewrite(AggStep aggStepOp, PatternRewriter &rewriter) const {
        auto op = &aggStepOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        myOperators

        auto firstBlock = rewriter.getBlock();

        auto p1Attr = aggStepOp.p1Attr();
        auto accumulatorRegAttr = aggStepOp.toRegAttr();
        auto firstRegAttr = aggStepOp.firstRegAttr();
        auto nRegAttr = aggStepOp.nRegAttr();
        auto functionAttr = aggStepOp.functionAttr();

        auto p1 = p1Attr.getUInt();
        auto accumulatorReg = accumulatorRegAttr.getSInt();
        auto firstReg = firstRegAttr.getSInt();
        auto nReg = nRegAttr.getSInt();
        auto functionAddress = functionAttr.getUInt();

        auto pc = aggStepOp.pcAttr().getUInt();
        VdbeOp* pOp = &vdbe->aOp[pc];

        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(aggStepOp); GO_BACK_TO(curBlock);

        // auto nAddr = alloca(LOC, T::i32PtrTy);
        // store(LOC, nReg, nAddr);

        auto rcAddr = alloca(LOC, T::i32PtrTy);
        store(LOC, 0, rcAddr);

        auto mallocSize = nReg * sizeof(sqlite3_value *) +
                (sizeof(sqlite3_context) + sizeof(Mem) - sizeof(sqlite3_value *));

        auto pCtx = alloca(LOC, T::sqlite3_contextPtrTy.getPointerTo());
        auto pCtxValueVoidStar = call
                (LOC, f_sqlite3DbMallocRawNN,
                    constants(T::sqlite3PtrTy, vdbe->db),
                    constants(mallocSize, 64)
                ).getValue();
        auto pCtxValue = bitCast(LOC, pCtxValueVoidStar, T::sqlite3_contextPtrTy);
        store(LOC, pCtxValue, pCtx);

        { // if (pCtx == 0) goto no_mem
            // TODO: Here
        }

        auto pOutAddr = getElementPtrImm(LOC, T::sqlite3_valuePtrTy.getPointerTo(), pCtxValue, 0, 0);
        auto pFuncAddr = getElementPtrImm(LOC, T::FuncDefPtrTy.getPointerTo(), pCtxValue, 0, 1);
        auto pMemAddr = getElementPtrImm(LOC, T::sqlite3_valuePtrTy.getPointerTo(), pCtxValue, 0, 2);
        auto pVdbeAddr = getElementPtrImm(LOC, T::VdbePtrTy.getPointerTo(), pCtxValue, 0, 3);
        auto iOpAddr = getElementPtrImm(LOC, T::i32PtrTy, pCtxValue, 0, 4);
        auto isErrorAddr = getElementPtrImm(LOC, T::i32PtrTy, pCtxValue, 0, 5);
        auto skipFlagAddr = getElementPtrImm(LOC, T::i8PtrTy, pCtxValue, 0, 6);
        auto argcAddr = getElementPtrImm(LOC, T::i8PtrTy, pCtxValue, 0, 7);
        auto argvAddrArr = getElementPtrImm(LOC, T::Arr_1_sqlite3_valuePtrTy, pCtxValue, 0, 8);
        auto argvAddr = bitCast(LOC, argvAddrArr, T::sqlite3_valuePtrPtrTy);

        {
            auto p4TypeAddr = getElementPtrImm(LOC, T::i8PtrTy, constants(T::VdbeOpPtrTy, pOp), 0, 1);
            auto p4UnionAddr = rewriter.create<GEPOp>
                    (LOC, T::p4unionPtrTy, constants(T::VdbeOpPtrTy, pOp), ValueRange {
                        constants(0, 32),
                        constants(6, 32)
                    });
            auto p4UnionValueAddr = getElementPtrImm(LOC, T::i8PtrTy.getPointerTo(), p4UnionAddr, 0, 0);


            /// (Mem *) &(pCtx->argv[n]);
            auto pOutValueUncasted = getElementPtrImm(LOC, T::sqlite3_valuePtrPtrTy, argvAddr, nReg);
            auto pOutValue = bitCast(LOC, pOutValueUncasted, T::sqlite3_valuePtrTy);

            call(LOC, f_sqlite3VdbeMemInit,
                 pOutValue, // Of type sqlite3_value*
                 constants(T::sqlite3PtrTy, vdbe->db), // Of type sqlite3*
                 constants(MEM_Null, 16) // Of type u16
            );

            store(LOC, constants(T::sqlite3_valuePtrTy, (Mem*)nullptr), pMemAddr);
            store(LOC, pOutValue, pOutAddr);
            store(LOC, constants(T::FuncDefPtrTy, (void*)functionAddress), pFuncAddr);

            assert(pc == pOp - vdbe->aOp && "pc is assumed to be pOp - vdbe->aOp");
            store(LOC, constants(pc, 32), iOpAddr);
            store(LOC, constants(T::VdbePtrTy, vdbe), pVdbeAddr);
            store(LOC, 0, skipFlagAddr);
            store(LOC, 0, isErrorAddr);
            store(LOC, nReg, argcAddr);

            /// pOp->p4type = P4_FUNCCTX;
            store(LOC, P4_FUNCCTX, p4TypeAddr);
            /// pOp->p4.pCtx = pCtx;
            auto ctxAsI8Ptr = bitCast(LOC, pCtxValue, T::i8PtrTy);
            store(LOC, ctxAsI8Ptr, p4UnionValueAddr);
        }

        // TODO: pOp->opcode = OP_AggStep1 // Later

        /** Fallthrough into OP_AggStep */

        /// int i;
        auto iAddr = alloca(LOC, T::i32PtrTy);
        auto pMemValue = constants(T::sqlite3_valuePtrTy, &vdbe->aMem[accumulatorReg]);

        auto pCtxPMemAddr = getElementPtrImm(LOC, T::sqlite3_valuePtrPtrTy, pCtxValue, 0, 2);
        auto pCtxPMemVal = load(LOC, pCtxPMemAddr);
        auto pCtxPMemNePMem = iCmp(LOC, Pred::ne, pCtxPMemVal, pMemValue);

        curBlock = rewriter.getBlock();
        auto blockAfterPMemNe = SPLIT_BLOCK; GO_BACK_TO(curBlock);
        auto blockPMemNe = SPLIT_BLOCK; GO_BACK_TO(curBlock);
        condBranch(LOC, pCtxPMemNePMem, blockPMemNe, blockAfterPMemNe);
        {
            ip_start(blockPMemNe);

            store(LOC, pMemValue, pCtxPMemAddr);
            auto argcVal_8 = load(LOC, argcAddr);
            auto argcVal = rewriter.create<ZExtOp>(LOC, T::i32Ty, argcVal_8);
            auto argcValMinus1 = add(LOC, argcVal, -1);
            auto iAddr = alloca(LOC, T::i32PtrTy);
            store(LOC, argcValMinus1, iAddr);

            curBlock = rewriter.getBlock();
            auto blockAfterFor = SPLIT_BLOCK; GO_BACK_TO(curBlock);
            auto blockCond = SPLIT_BLOCK; GO_BACK_TO(curBlock);
            auto blockAction = SPLIT_BLOCK; GO_BACK_TO(curBlock);

            branch(LOC, blockCond);

            { // Condition block
                ip_start(blockCond);

                // Load the current value of i
                auto iVal = load(LOC, iAddr);

                // Check if i >= 0
                auto iGe0 = iCmp(LOC, Pred::sge, iVal, 0);

                condBranch(LOC, iGe0, blockAction, blockAfterFor);
            } // End Condition block
            { // Action block
                ip_start(blockAction);

                // Load the current value of i
                auto iVal = load(LOC, iAddr);

                /// pCtx->argv[i] = &aMem[pOp->p2 + i]
                // &pCtx->argv[i]
                auto argvIAddr = getElementPtr(LOC, T::sqlite3_valuePtrPtrTy, argvAddr, iVal);
                // &aMem[pOp->p2 + i]
                auto p2PlusI = add(LOC, iVal, firstReg);
                auto newArgvIVal = getElementPtr(LOC, T::sqlite3_valuePtrTy,
                        constants(T::sqlite3_valuePtrTy, vdbe->aMem),
                        p2PlusI
                    );
                /// pCtx->argv[i] = &aMem[pOp->p2 + i];
                store(LOC, newArgvIVal, argvIAddr);

                /// i--
                auto iValMinus1 = add(LOC, iVal, -1);
                store(LOC, iValMinus1, iAddr);

                // Branch back to condition block
                branch(LOC, blockCond);
            } // End Action block

            ip_start(blockAfterFor);

            branch(LOC, blockAfterPMemNe);
        }
        ip_start(blockAfterPMemNe);

        /// pMem->n++
        auto pMemNAddr = getElementPtrImm(LOC, T::i32PtrTy, pMemValue, 0, 4);
        {
            auto nValue = load(LOC, pMemNAddr);
            auto nValuePlus1 = add(LOC, nValue, 1);
            store(LOC, nValuePlus1, pMemNAddr);
        }

        auto funcDefAddr = load(LOC, pFuncAddr);
        static auto funcType = LLVMType::getFunctionTy(
            LLVMType::getVoidTy(llvmDialect), {
                    T::sqlite3_contextPtrTy,
                    T::i32Ty,
                    T::sqlite3_valuePtrPtrTy
            }, false);
        auto argcValue = load(LOC, argcAddr);
        if (p1) {
            assert(false);
            auto xInverseAddr = getElementPtrImm(LOC, funcType.getPointerTo(), funcDefAddr, 0, 7);
            // call(LOC, f_callXInversePtr, load(LOC, xInverseAddr), pCtxValue, argcValue, argvAddr);
        } else {
            auto xSFuncAddr = getElementPtrImm(LOC, funcType.getPointerTo().getPointerTo(), funcDefAddr, 0, 4);
            auto xsFuncAddrAsI64Ptr = bitCast(LOC, xSFuncAddr, T::i64PtrTy);
            auto xsFunc = load(LOC, xsFuncAddrAsI64Ptr);
            auto argcValue32 = rewriter.create<ZExtOp>(LOC, T::i32Ty, argcValue);
            call(LOC, f_callXSFuncPtr, xsFunc, pCtxValue, argcValue32, argvAddr);
        }

        auto isErrorVal = load(LOC, isErrorAddr);
        auto isErrorNotNull = iCmp(LOC, Pred::ne, isErrorVal, 0);

        curBlock = rewriter.getBlock();
        auto blockAfterIsError = SPLIT_BLOCK; GO_BACK_TO(curBlock);
        auto blockIsError = SPLIT_BLOCK; GO_BACK_TO(curBlock);

        condBranch(LOC, isErrorNotNull, blockIsError, blockAfterIsError);
        { // if (pCtx->isError)
            ip_start(blockIsError);

            auto isErrorPositive = iCmp(LOC, Pred::sgt, isErrorVal, 0);
            auto curBlock = rewriter.getBlock();
            auto blockAfterIsErrorPos = SPLIT_BLOCK; GO_BACK_TO(curBlock);
            auto blockIsErrorPos = SPLIT_BLOCK; GO_BACK_TO(curBlock);
            condBranch(LOC, isErrorPositive, blockIsErrorPos, blockAfterIsErrorPos);

            { // if (pCtx->isError > 0)
                ip_start(blockIsErrorPos);

                print(LOCL, "TODO: Error while computing aggregate function");
                store(LOC, isErrorVal, rcAddr);

                branch(LOC, blockAfterIsErrorPos);
            } // end if (pCtx->isError > 0)

            ip_start(blockAfterIsErrorPos);

            auto skipFlagVal = load(LOC, skipFlagAddr);
            auto skipFlagNotNull = iCmp(LOC, Pred::ne, skipFlagVal, 0);

            curBlock = rewriter.getBlock();
            auto blockAfterSkipFlagNN = SPLIT_BLOCK; GO_BACK_TO(curBlock);
            auto blockSkipFlagNN = SPLIT_BLOCK; GO_BACK_TO(curBlock);
            condBranch(LOC, skipFlagNotNull, blockSkipFlagNN, blockAfterSkipFlagNN);

            { // if (pCtx->skipFlag)
                ip_start(blockSkipFlagNN);

                assert(pOp[-1].opcode == OP_CollSeq);

                /// i = pOp[-1].p1
                auto newIValue = pOp[-1].p1;
                auto pOpMinus1P1 = constants(newIValue, 32);
                store(LOC, pOpMinus1P1, iAddr);

                /// if (i) sqlite3VdbeMemSetInt64(&aMem[i], 1);
                if (newIValue) {
                    ///
                    call(LOC, f_sqlite3VdbeMemSetInt64,
                            constants(T::sqlite3_valuePtrTy, &vdbe->aMem[newIValue]),
                            constants(1, 64)
                    );
                }

                store(LOC, 0, skipFlagAddr);

                branch(LOC, blockAfterSkipFlagNN);
            } // end if (pCtx->skipFlag)

            ip_start(blockAfterSkipFlagNN);

            /// sqlite3VdbeMemRelease(pCtx->pOut);
            auto pOutValue = load(LOC, pOutAddr);
            call(LOC, f_sqlite3VdbeMemRelease, pOutValue);

            /// pCtx->pOut->flags = MEM_Null;
            auto flagsAddr = getElementPtrImm(LOC, T::i16PtrTy, pOutValue, 0, 1);
            store(LOC, MEM_Null, flagsAddr);

            /// pCtx->isError = 0;
            store(LOC, 0, isErrorAddr);

            { // assert rc != 0
                auto rcVal = load(LOC, rcAddr);
                auto rcIs0 = iCmp(LOC, Pred::ne, rcVal, 0);
                myAssert(LOCL, rcIs0);
            } // end assert rc != 0

            branch(LOC, blockAfterIsError);
        } // end if (pCtx->isError)

        ip_start(blockAfterIsError);

        branch(LOC, endBlock);

        ip_start(endBlock);
        rewriter.eraseOp(aggStepOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes