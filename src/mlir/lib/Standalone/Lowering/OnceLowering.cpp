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
    LogicalResult OnceLowering::matchAndRewrite(Once oOp, PatternRewriter &rewriter) const {
        auto op = &oOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        myOperators

        print(LOCL, "-- Once");

        auto firstBlock = rewriter.getBlock();

        auto pc = oOp.pcAttr().getUInt();
        if (false) { // call to default
            // TODO: Use our own implementation
            rewriter.create<StoreOp>(LOC, constants(1, 64), constants(T::i64PtrTy, &maxVdbeSteps));
            rewriter.create<StoreOp>(LOC, constants(pc, 32), constants(T::i32PtrTy, &vdbe->pc));
            rewriter.create<CallOp>(LOC, f_sqlite3VdbeExec2, ValueRange {constants(T::VdbePtrTy, vdbe) });
            rewriter.eraseOp(*op);

            if (op->getOperation()->isKnownTerminator()) {
                rewriter.create<BranchOp>(LOC, vdbeCtx->jumpsBlock);
            }

            return success();
        }


        auto fallthrough = oOp.fallthrough();
        auto jumpTo = oOp.jumpTo();

        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(oOp); GO_BACK_TO(curBlock);

        auto pVdbe = constants(T::VdbePtrTy, vdbe);
        auto pFrameAddr = getElementPtrImm(LOC, T::VdbeFramePtrTy.getPointerTo(), pVdbe, 0, 43);
        auto pFrameValue = load(LOC, pFrameAddr);
        auto pFrameValueInt = ptrToInt(LOC, pFrameValue);

        // Get p->aOp[0].p1
        auto initValueAddress = constants(T::i32PtrTy, &vdbe->aOp[0].p1);
        auto initValue = load(LOC, initValueAddress);

        // Get &pOp->p1
        auto p1Address = constants(T::i32PtrTy, &vdbe->aOp[pc].p1);

        curBlock = rewriter.getBlock();
        auto blockAfterFrameNotNull = SPLIT_BLOCK; GO_BACK_TO(curBlock);
        auto blockNotFrameNotNull = SPLIT_BLOCK; GO_BACK_TO(curBlock);
        auto blockFrameNotNull = SPLIT_BLOCK; GO_BACK_TO(curBlock);

        auto pFrameNotNull = iCmp(LOC, Pred::ne, pFrameValueInt, 0);
        condBranch(LOC, pFrameNotNull, blockFrameNotNull, blockNotFrameNotNull);
        { // if (p->pFrame)
            ip_start(blockFrameNotNull);

            /// if ((p->pFrame->aOnce[iAddr / 8] & (1 << (iAddr & 7))) != 0)
            // Get p->pFrame->aOnce[iAddr / 8]
            auto aOnceAddr = getElementPtrImm(LOC, T::i8PtrPtrTy, pFrameValue, 0, 6);
            auto aOnce = load(LOC, aOnceAddr);
            auto iAddrOver8 = constants(pc / 8, 32);
            auto onceValueAddr = getElementPtr(LOC, T::i8PtrTy, aOnce, iAddrOver8);
            auto onceValue = load(LOC, onceValueAddr);

            auto rhs = (1 << (pc & 7));
            auto bothAnded = bitAnd(LOC, iAddrOver8, rhs);
            auto bothAndedNotNull = iCmp(LOC, Pred::ne, bothAnded, 0);

            auto curBlock = rewriter.getBlock();
            auto blockNotJump = SPLIT_BLOCK; GO_BACK_TO(curBlock);
            condBranch(LOC, bothAndedNotNull, jumpTo, blockNotJump);

            ip_start(blockNotJump);

            /// p->pFrame->aOnce[iAddr / 8] |= 1 << (iAddr & 7);
            auto newOnceValue = bitOr(LOC, onceValue, rhs);
            store(LOC, onceValue, onceValueAddr);

            branch(LOC, blockAfterFrameNotNull);
        } // end if (p->pFrame)
        { // else of if (p->pFrame)
            ip_start(blockNotFrameNotNull);

            /// if (p->aOp[0].p1 == pOp->p1) goto jump_to_p2;
            auto p1Value = load(LOC, p1Address);

            // Check whether pOp->p1 == p->aOp[0].p1
            auto p1IsInit = iCmp(LOC, Pred::eq, p1Value, initValue);

            ///
            condBranch(LOC, p1IsInit, jumpTo, blockAfterFrameNotNull);
        } // end else of if (p->pFrame)

        ip_start(blockAfterFrameNotNull);

        /// pOp->p1 = p->aOp[0].p1;
        store(LOC, initValue, p1Address);

        branch(LOC, endBlock);

        ip_start(endBlock);

        branch(LOC, fallthrough);
        rewriter.eraseOp(oOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes