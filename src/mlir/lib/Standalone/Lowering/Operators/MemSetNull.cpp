#include "mlir/Dialect/LLVMIR/LLVMDialect.h"

#include "Standalone/Lowering/MemSetNull.h"
#include "Standalone/Lowering/Printer.h"
#include "Standalone/TypeDefinitions.h"
#include "Standalone/ConstantManager.h"
#include "Standalone/Utils.h"
#include "Standalone/VdbeContext.h"

extern mlir::LLVM::LLVMFuncOp f_sqlite3AtoF;
extern mlir::LLVM::LLVMFuncOp f_sqlite3VdbeIntegerAffinity;
extern mlir::LLVM::LLVMFuncOp f_vdbeMemClearExternAndSetNull;

extern "C" {
#include "sqlite3.h"
#include "src/vdbeInt.h"
}


namespace mlir::standalone::passes::Inlining {

    MemSetNull::MemSetNull(VdbeContext& vdbeCtx, MLIRContext& context, OpBuilder& rewriter, Printer& print, ConstantManager& constants)
            : vdbeCtx(vdbeCtx), mlirContext(context), rewriter(rewriter), printer(print), constantManager(constants)
    {
    }

    Value MemSetNull::operator()(Location loc, Value pMem) {
        auto& constants = constantManager;
        auto& context = mlirContext;
        auto ctx = &context;
        LOWERING_NAMESPACE

        // #define VdbeMemDynamic(X) (((X)->flags&(MEM_Agg|MEM_Dyn))!=0)
        auto flagsAddr = rewriter.create<GEPOp>(loc, T::i16PtrTy, pMem, ValueRange{
                constants(0, 32),
                constants(1, 32)
        });
        auto flagsValue = rewriter.create<LoadOp>(loc, flagsAddr);
        auto memDynamic = rewriter.create<AndOp>(loc, flagsValue, constants(MEM_Agg | MEM_Dyn, 16));

        auto curBlock = rewriter.getBlock();
        auto blockAfterMemDynamic = SPLIT_BLOCK; GO_BACK_TO(curBlock);
        auto blockNotMemDynamic = SPLIT_BLOCK; GO_BACK_TO(curBlock);
        auto blockMemDynamic = SPLIT_BLOCK; GO_BACK_TO(curBlock);

        auto condMemDynamic = rewriter.create<ICmpOp>
                (loc, Pred::ne,
                      memDynamic,
                      constants(0, 16)
        );

        rewriter.create<CondBrOp>(loc, condMemDynamic, blockMemDynamic, blockNotMemDynamic);
        { // if (VdbeMemDynamic(pOut))
            rewriter.setInsertionPointToStart(blockMemDynamic);

            /// vdbeMemClearExternAndSetNull(pMem);
            rewriter.create<CallOp>(loc, f_vdbeMemClearExternAndSetNull, ValueRange { pMem });

            rewriter.create<BranchOp>(loc, blockAfterMemDynamic);
        }
        {
            rewriter.setInsertionPointToStart(blockNotMemDynamic);

            /// pMem->flags = MEM_Null;
            rewriter.create<StoreOp>(loc, constants(MEM_Null, 16), flagsAddr);

            rewriter.create<BranchOp>(loc, blockAfterMemDynamic);
        }
        rewriter.setInsertionPointToStart(blockAfterMemDynamic);
    }
}