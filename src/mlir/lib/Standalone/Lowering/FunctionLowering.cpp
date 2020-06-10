#include <llvm/Support/DynamicLibrary.h>

#include "Standalone/ConstantManager.h"
#include "Standalone/Lowering/MyBuilder.h"
#include "Standalone/AllIncludes.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"

#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"

ExternFuncOp f_sqlite3_value_text;
ExternFuncOp f_sqlite3VdbeError;

namespace mlir::standalone::passes {
    LogicalResult FunctionLowering::matchAndRewrite(Function fnOp, PatternRewriter &rewriter) const {
        auto op = &fnOp;
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

        auto pc = fnOp.pcAttr().getUInt();
        auto p1 = fnOp.constantBitmaskAttr().getSInt();
        auto p2 = fnOp.firstInRegAttr().getSInt();
        auto p3 = fnOp.outRegAttr().getSInt();
        auto p4 = (sqlite3_context*) fnOp.functionAttr().getUInt();

        if (false) { // call to default
            // TODO: Use our own implementation
            store(LOC, 1, constants(T::i64PtrTy, &maxVdbeSteps));
            rewriter.create<StoreOp>(LOC, constants(pc, 32), constants(T::i32PtrTy, &vdbe->pc));
            call(LOC, f_sqlite3VdbeExec2, constants(T::VdbePtrTy, vdbe));
            rewriter.eraseOp(fnOp);
            return success();
        }

        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(fnOp); GO_BACK_TO(curBlock);

        auto pVdbe = constants(T::VdbePtrTy, vdbe);
        auto aMemAddress = getElementPtrImm(LOC, T::sqlite3_valuePtrTy.getPointerTo(), pVdbe, 0, 17);
        auto aMemValue = load(LOC, aMemAddress);
        // auto pOut = getElementPtrImm(LOC, T::sqlite3_valuePtrTy, aMemValue, p3);
        // TODO: Fix that:
        auto pOut = constants(T::sqlite3_valuePtrTy, &vdbe->aMem[p3]);


        auto pCtx = constants(T::sqlite3_contextPtrTy, p4);
        auto pCtxOutAddr = getElementPtrImm(LOC, T::sqlite3_valuePtrTy.getPointerTo(), pCtx, 0, 0);
        auto pCtxOutValue = load(LOC, pCtxOutAddr);
        auto pFuncAddr = getElementPtrImm(LOC, T::FuncDefPtrTy.getPointerTo(), pCtx, 0, 1);
        auto argcAddr = getElementPtrImm(LOC, T::i8PtrTy, pCtx, 0, 7);
        auto argcValue = load(LOC, argcAddr);
        auto argcValue32 = rewriter.create<ZExtOp>(LOC, T::i32Ty, argcValue);

        auto argvAddrArr = getElementPtrImm(LOC, T::Arr_1_sqlite3_valuePtrTy, pCtx, 0, 8);
        auto argvAddr = bitCast(LOC, argvAddrArr, T::sqlite3_valuePtrPtrTy);


        curBlock = rewriter.getBlock();
        auto blockAfterCtxOutNeOut = SPLIT_BLOCK; GO_BACK_TO(curBlock);
        auto blockNotCtxOutNeOut = SPLIT_BLOCK; GO_BACK_TO(curBlock);
        auto blockCtxOutNeOut = SPLIT_BLOCK; GO_BACK_TO(curBlock);


        auto condCtxOutNeOut = rewriter.create<ICmpOp>(LOC, Pred::ne,
            ptrToInt(LOC, pCtxOutValue),
            ptrToInt(LOC, pOut)
        );

        condBranch(LOC, condCtxOutNeOut, blockCtxOutNeOut, blockNotCtxOutNeOut);
        { // if (pCtx->pOut != pOut)
            ip_start(blockCtxOutNeOut);

            /// pCtx->pVdbe = p;
            auto pVdbeAddr = getElementPtrImm(LOC, T::VdbePtrTy.getPointerTo(), pCtx, 0, 3);
            store(LOC, pVdbe, pVdbeAddr);

            /// pCtx->pOut = pOut;
            store(LOC, pOut, pCtxOutAddr);

            for(auto i = p4->argc - 1; i >= 0; i--) {
                // auto memAddress = getElementPtrImm(LOC, T::sqlite3_valuePtrTy, aMemValue, p2 + i);
                auto memAddress = constants(T::sqlite3_valuePtrTy, &vdbe->aMem[p2 + i]);
                auto argAddr = getElementPtrImm(LOC, T::sqlite3_valuePtrPtrTy, argvAddr, i);
                store(LOC, memAddress, argAddr);
            }

            branch(LOC, blockAfterCtxOutNeOut);
        } // end if (pCtx->pOut != pOut)
        { // else of if (pCtx->pOut != pOut)
            ip_start(blockNotCtxOutNeOut);

            branch(LOC, blockAfterCtxOutNeOut);
        } // end else of if (pCtx->pOut != pOut)

        ip_start(blockAfterCtxOutNeOut);

        auto pOutFlagsAddr = getElementPtrImm(LOC, T::i16PtrTy, pOut, 0, 1);
        memSetTypeFlag(pOutFlagsAddr, MEM_Null);

        { /// (*pCtx->pFunc->xSFunc)(pCtx, pCtx->argc, pCtx->argv);
            auto funcDefAddr = load(LOC, pFuncAddr);
            static auto funcType = LLVMType::getFunctionTy(
                    LLVMType::getVoidTy(llvmDialect), {
                            T::sqlite3_contextPtrTy,
                            T::i32Ty,
                            T::sqlite3_valuePtrPtrTy
                    }, false);
            auto xSFuncAddr = getElementPtrImm(LOC, funcType.getPointerTo().getPointerTo(), funcDefAddr, 0, 4);
            auto xsFuncAddrAsI64Ptr = bitCast(LOC, xSFuncAddr, T::i64PtrTy);
            auto xsFunc = load(LOC, xsFuncAddrAsI64Ptr);

            call(LOC, f_callXSFuncPtr,
                xsFunc,
                pCtx,
                argcValue32,
                argvAddr
            );
        }

        auto isErrorAddr = getElementPtrImm(LOC, T::i32PtrTy, pCtx, 0, 5);
        auto isError = load(LOC, isErrorAddr);

        curBlock = rewriter.getBlock();
        auto blockAfterIsError = SPLIT_BLOCK; GO_BACK_TO(curBlock);
        auto blockIsError = SPLIT_BLOCK; GO_BACK_TO(curBlock);

        auto condIsError = iCmp(LOC, Pred::ne, isError, 0);

        condBranch(LOC, condIsError, blockIsError, blockAfterIsError);
        { // if (pCtx->isError)
            ip_start(blockIsError);

            auto isErrorPositive = iCmp(LOC, Pred::sgt, isError, 0);
            auto curBlock = rewriter.getBlock();
            auto blockAfterIsErrorPos = SPLIT_BLOCK; GO_BACK_TO(curBlock);
            auto blockIsErrorPos = SPLIT_BLOCK; GO_BACK_TO(curBlock);
            condBranch(LOC, isErrorPositive, blockIsErrorPos, blockAfterIsErrorPos);

            { // if (pCtx->isError > 0)
                ip_start(blockIsErrorPos);

                auto valueText = call(LOC, f_sqlite3_value_text, pOut).getValue();

                call(LOC, f_sqlite3VdbeError,
                     constants(T::VdbePtrTy, vdbe),
                     constants(T::i8PtrTy, (char*)"%s"),
                     valueText
                );

                branch(LOC, blockAfterIsErrorPos);
            } // end if (pCtx->isError > 0)

            ip_start(blockAfterIsErrorPos);

            // TODO: Lines 7714...
            print(LOCL, "TODO: Lines 7714...");
            myAssert(LOCL, constants(0, 1));

            branch(LOC, blockAfterIsError);
         } // end if (pCtx->isError)

        ip_start(blockAfterIsError);

        /// if (pOut->flags & (MEM_Str | MEM_Blob))
        curBlock = rewriter.getBlock();
        auto blockAfterOutStrOrBlob = SPLIT_BLOCK; GO_BACK_TO(curBlock);
        auto blockOutStrOrBlob = SPLIT_BLOCK; GO_BACK_TO(curBlock);

        auto outFlags = load(LOC, pOutFlagsAddr);
        auto flagsAndStrOrBlob = bitAnd(LOC, outFlags, MEM_Str | MEM_Blob);
        auto outIsStrOrBlob = iCmp(LOC, Pred::ne, flagsAndStrOrBlob, 0);

        condBranch(LOC, outIsStrOrBlob, blockOutStrOrBlob, blockAfterOutStrOrBlob);
        { // if (pOut->flags & (MEM_Str | MEM_Blob)
            ip_start(blockOutStrOrBlob);

            call(LOC, f_sqlite3VdbeChangeEncoding, pOut, constants(vdbe->db->enc, 32));

            // TODO: if (sqlite3VdbeMemTooBig(pOut)) goto too_big;

            branch(LOC, blockAfterOutStrOrBlob);
         } // end if (pOut->flags & (MEM_Str | MEM_Blob)

        ip_start(blockAfterOutStrOrBlob);

        branch(LOC, endBlock);

        ip_start(endBlock);
        rewriter.eraseOp(fnOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes