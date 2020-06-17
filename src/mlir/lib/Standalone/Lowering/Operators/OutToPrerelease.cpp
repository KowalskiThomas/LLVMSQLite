#include "mlir/IR/Value.h"
#include "mlir/Dialect/LLVMIR/LLVMDialect.h"

#include "Standalone/Lowering/OutToPrerelease.h"
#include "Standalone/Lowering/Printer.h"
#include "Standalone/TypeDefinitions.h"
#include "Standalone/ConstantManager.h"
#include "Standalone/Utils.h"

extern "C" {
    #include "src/sqliteInt.h"
    #include "sqlite3.h"
    #include "src/vdbeInt.h"
    #include "src/vdbe.h"
}

extern mlir::LLVM::LLVMFuncOp f_out2PrereleaseWithClear;

namespace mlir::standalone::passes::Inlining {

    OutToPrerelease::OutToPrerelease(MLIRContext& context, OpBuilder& rewriter, Printer& print, ConstantManager& constants)
        : mlirContext(context), rewriter(rewriter), printer(print), constantManager(constants)
    {
    }

    // TODO: Fix that (remove IntToPtr's)
    Value OutToPrerelease::operator()(Location loc, Vdbe* vdbe, VdbeOp* pOp) {
        auto& constants = constantManager;
        auto& context = mlirContext;
        auto ctx = &context;
        LOWERING_NAMESPACE

        auto stackState = rewriter.create<mlir::LLVM::StackSaveOp>(loc, T::i8PtrTy);

        /// assert(pOp->p2 > 0);
        /// assert(pOp->p2 <= (p->nMem + 1 - p->nCursor));

        /// pOut = &p->aMem[pOp->p2];
        auto pOut = constants(T::sqlite3_valuePtrTy, &vdbe->aMem[pOp->p2]);

        /// memAboutToChange(p, pOut);

        // #define VdbeMemDynamic(X) (((X)->flags&(MEM_Agg|MEM_Dyn))!=0)

        /// if (VdbeMemDynamic(pOut))
        auto flagsAddr = rewriter.create<GEPOp>(loc, T::i16PtrTy, pOut, ValueRange{
                constants(0, 32),
                constants(1, 32)
        });

        auto flagsValue = rewriter.create<LoadOp>(loc, flagsAddr);
        auto memDynamic = rewriter.create<AndOp>(loc, flagsValue, constants(MEM_Agg | MEM_Dyn, 16));

        auto curBlock = rewriter.getBlock();
        auto blockAfterMemDynamic = SPLIT_BLOCK; GO_BACK_TO(curBlock);
        auto blockNotMemDynamic = SPLIT_BLOCK; GO_BACK_TO(curBlock);
        auto blockMemDynamic = SPLIT_BLOCK; GO_BACK_TO(curBlock);

        auto condMemDynamic = rewriter.create<ICmpOp>(loc, Pred::ne,
            memDynamic,
            constants(0, 16)
        );

        auto pOutResult = rewriter.create<AllocaOp>
            (loc, T::sqlite3_valuePtrPtrTy, constants(1, 32), 0);

        rewriter.create<CondBrOp>(loc, condMemDynamic, blockMemDynamic, blockNotMemDynamic);
        { // if (VdbeMemDynamic(pOut))
            rewriter.setInsertionPointToStart(blockMemDynamic);

            /// return out2PrereleaseWithClear(pOut);
            auto callResult = rewriter.create<CallOp>
                (loc, f_out2PrereleaseWithClear, ValueRange {
                    constants(T::VdbePtrTy, vdbe),
                    constants(T::VdbeOpPtrTy, pOp)
                }).getResult(0);

            rewriter.create<StoreOp>(loc, callResult, pOutResult);

            rewriter.create<BranchOp>(loc, blockAfterMemDynamic);
        } // end if (VdbeMemDynamic(pOut))
        { // else of if (VdbeMemDynamic(pOut))
            rewriter.setInsertionPointToStart(blockNotMemDynamic);

            /// pOut->flags = MEM_Int;
            rewriter.create<StoreOp>(loc, constants(MEM_Int, 16), flagsAddr);

            /// return pOut;
            rewriter.create<StoreOp>(loc, pOut, pOutResult);

            rewriter.create<BranchOp>(loc, blockAfterMemDynamic);
        } // end else of if (VdbeMemDynamic(pOut))

        rewriter.setInsertionPointToStart(blockAfterMemDynamic);

        auto resultingPOut = rewriter.create<LoadOp>(loc, pOutResult);

        rewriter.create<mlir::LLVM::StackRestoreOp>(loc, stackState);

        return resultingPOut;
    }
}