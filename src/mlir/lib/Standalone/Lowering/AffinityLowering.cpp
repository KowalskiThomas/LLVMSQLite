#include "Standalone/ConstantManager.h"
#include "Standalone/Lowering/MyBuilder.h"
#include "Standalone/AllIncludes.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"

#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"

extern LLVMFuncOp f_applyAffinity;

namespace mlir::standalone::passes {
    LogicalResult AffinityLowering::matchAndRewrite(Affinity affOp, PatternRewriter &rewriter) const {
        auto op = &affOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        myOperators

        auto firstBlock = rewriter.getBlock();

        auto pc = affOp.pcAttr().getUInt();
        auto p1 = affOp.p1Attr().getSInt();
        auto p2 = affOp.p2Attr().getSInt();
        auto p4 = (const char*)affOp.p4Attr().getUInt();

        USE_DEFAULT_BOILERPLATE

        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(affOp); GO_BACK_TO(curBlock);

        auto zAffinity = p4;

        /// pIn1 = &aMem[pOp->p1];
        auto pIn1 = getElementPtrImm(LOC, T::sqlite3_valuePtrTy, vdbeCtx->aMem, p1);

        while (true) {
            call(LOC, f_applyAffinity,
                pIn1,
                constants(zAffinity[0], 8),
                constants(vdbe->db->enc, 8) /// encoding
            );

            if (zAffinity[0] == SQLITE_AFF_REAL) {
                auto flagsAddr = getElementPtrImm(LOC, T::i16PtrTy, pIn1, 0, 1);
                auto flags = load(LOC, flagsAddr);
                auto flagsAndInt = bitAnd(LOC, flags, MEM_Int);

                auto curBlock = rewriter.getBlock();
                auto blockAfterInIsInt = SPLIT_GO_BACK_TO(curBlock);
                auto blockInIsInt = SPLIT_GO_BACK_TO(curBlock);

                auto condInIsInt = iCmp(LOC, Pred::ne, flagsAndInt, 0);

                condBranch(LOC, condInIsInt, blockInIsInt, blockAfterInIsInt);
                { // if (zAffinity[0] == SQLITE_AFF_REAL && (pIn1->flags & MEM_Int) != 0)
                    ip_start(blockInIsInt);

                    auto inUAddr = getElementPtrImm(LOC, T::doublePtrTy, pIn1, 0, 0);
                    auto inIntegerAddr = bitCast(LOC, inUAddr, T::i64PtrTy);
                    auto inInteger = load(LOC, inIntegerAddr);

                    auto intLe = iCmp(LOC, Pred::sle, inInteger, 140737488355327LL);
                    auto intGe = iCmp(LOC, Pred::sge, inInteger, -140737488355328LL);

                    auto curBlock = rewriter.getBlock();
                    auto blockAfterIntInRange = SPLIT_GO_BACK_TO(curBlock);
                    auto blockNotIntInRange = SPLIT_GO_BACK_TO(curBlock);
                    auto blockIntInRange = SPLIT_GO_BACK_TO(curBlock);

                    auto condIntInRange = bitAnd(LOC, intLe, intGe);

                    condBranch(LOC, condIntInRange, blockIntInRange, blockNotIntInRange);
                    { // if (pIn1->u.i <= 140737488355327LL && pIn1->u.i >= -140737488355328LL)
                        ip_start(blockIntInRange);

                        /// pIn1->flags |= MEM_IntReal;
                        auto newFlags = bitOr(LOC, flags, MEM_IntReal);
                        /// pIn1->flags &= ~MEM_Int;
                        newFlags = bitAnd(LOC, flags, ~MEM_Int);
                        store(LOC, newFlags, flagsAddr);

                        branch(LOC, blockAfterIntInRange);
                    } // end if (pIn1->u.i <= 140737488355327LL && pIn1->u.i >= -140737488355328LL)
                    { // else of if (pIn1->u.i <= 140737488355327LL && pIn1->u.i >= -140737488355328LL)
                        ip_start(blockNotIntInRange);

                        /// pIn1->u.r = (double) pIn1->u.i;
                        auto intAsDouble = rewriter.create<mlir::LLVM::SIToFPOp>(LOC, T::doubleTy, inInteger);
                        store(LOC, (Value)intAsDouble, inUAddr);

                        /// pIn1->flags |= MEM_Real;
                        auto newFlags = bitOr(LOC, flags, MEM_Real);

                        /// pIn1->flags &= ~MEM_Int;
                        newFlags = bitAnd(LOC, newFlags, ~MEM_Int);
                        store(LOC, newFlags, flagsAddr);

                        branch(LOC, blockAfterIntInRange);
                    } // end else of if (pIn1->u.i <= 140737488355327LL && pIn1->u.i >= -140737488355328LL)

                    ip_start(blockAfterIntInRange);

                    branch(LOC, blockAfterInIsInt);
                } // end if (zAffinity[0] == SQLITE_AFF_REAL && (pIn1->flags & MEM_Int) != 0)
                ip_start(blockAfterInIsInt);
            }

            zAffinity++;
            if (zAffinity[0] == 0)
                break;

            pIn1 = getElementPtrImm(LOC, T::sqlite3_valuePtrTy, pIn1, 1);
        }

        branch(LOC, endBlock);

        ip_start(endBlock);
        rewriter.eraseOp(affOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes