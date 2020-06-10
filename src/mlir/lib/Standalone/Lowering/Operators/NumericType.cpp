#include "mlir/IR/Value.h"
#include "mlir/Dialect/LLVMIR/LLVMDialect.h"

#include "Standalone/Lowering/NumericType.h"
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

extern mlir::LLVM::LLVMFuncOp f_computeNumericType;

namespace mlir::standalone::passes::Inlining {

    NumericType::NumericType(MLIRContext &context, OpBuilder &rewriter, Printer &print, ConstantManager &constants)
            : mlirContext(context), rewriter(rewriter), printer(print), constantManager(constants) {
    }

    Value NumericType::operator()(Location loc, Value pIn) {
        auto &constants = constantManager;
        auto &context = mlirContext;
        auto ctx = &context;
        LOWERING_NAMESPACE

        auto stackState = rewriter.create<mlir::LLVM::StackSaveOp>(LOC, T::i8PtrTy);

        auto resultAddr = rewriter.create<AllocaOp>(loc, T::i16PtrTy, constants(1, 32), 0);

        auto numericFlags = (u16) (MEM_Int | MEM_IntReal | MEM_Real);
        auto seqFlags = (u16) (MEM_Str | MEM_Blob);

        auto flagsAddr = rewriter.create<GEPOp>
                (LOC, T::i16PtrTy, pIn, ValueRange{
                        constants(0, 32),
                        constants(1, 32)
                });
        auto flagsValue = rewriter.create<LoadOp>(LOC, flagsAddr);

        auto flagsAndNumeric = rewriter.create<AndOp>(LOC, flagsValue, constants(numericFlags, 16));

        auto curBlock = rewriter.getBlock();
        auto blockAfterMemNumeric = SPLIT_BLOCK;
        GO_BACK_TO(curBlock);
        auto blockNotMemNumeric = SPLIT_BLOCK;
        GO_BACK_TO(curBlock);
        auto blockMemNumeric = SPLIT_BLOCK;
        GO_BACK_TO(curBlock);

        auto condMemNumeric = rewriter.create<ICmpOp>
                (LOC, Pred::ne,
                 flagsAndNumeric,
                 constants(0, 16)
                );

        rewriter.create<CondBrOp>(LOC, condMemNumeric, blockMemNumeric, blockNotMemNumeric);
        { // if (pMem->flags & (MEM_Int | MEM_Real | MEM_IntReal))
            rewriter.setInsertionPointToStart(blockMemNumeric);

            rewriter.create<StoreOp>(loc, flagsAndNumeric, resultAddr);

            rewriter.create<BranchOp>(LOC, blockAfterMemNumeric);
        } // end if (pMem->flags & (MEM_Int | MEM_Real | MEM_IntReal))
        { // else of if (pMem->flags & (MEM_Int | MEM_Real | MEM_IntReal))
            rewriter.setInsertionPointToStart(blockNotMemNumeric);

            auto flagsAndSeq = rewriter.create<AndOp>(loc, flagsValue, constants(seqFlags, 16));

            auto curBlock = rewriter.getBlock();
            auto blockAfterMemIsSeq = SPLIT_BLOCK;
            GO_BACK_TO(curBlock);
            auto blockNotMemIsSeq = SPLIT_BLOCK;
            GO_BACK_TO(curBlock);
            auto blockMemIsSeq = SPLIT_BLOCK;
            GO_BACK_TO(curBlock);

            auto condMemIsSeq = rewriter.create<ICmpOp>
                (LOC, Pred::ne,
                    flagsAndSeq,
                    constants(0, 16)
                );

            rewriter.create<CondBrOp>(LOC, condMemIsSeq, blockMemIsSeq, blockNotMemIsSeq);
            { // if (pMem->flags & (MEM_Str | MEM_Blob))
                rewriter.setInsertionPointToStart(blockMemIsSeq);

                /// return computeNumericType(pMem);
                auto callResult = rewriter.create<CallOp>
                    (LOC, f_computeNumericType, ValueRange {
                        pIn
                    });

                rewriter.create<BranchOp>(LOC, blockAfterMemIsSeq);
            } // end if (pMem->flags & (MEM_Str | MEM_Blob))
            { // else of if (pMem->flags & (MEM_Str | MEM_Blob))
                rewriter.setInsertionPointToStart(blockNotMemIsSeq);

                /// return 0
                rewriter.create<StoreOp>(loc, constants(0, 16), resultAddr);

                rewriter.create<BranchOp>(LOC, blockAfterMemIsSeq);
            } // end else of if (pMem->flags & (MEM_Str | MEM_Blob))

            rewriter.setInsertionPointToStart(blockAfterMemIsSeq);
            rewriter.create<BranchOp>(loc, blockAfterMemNumeric);
        } // end else of if (pMem->flags & (MEM_Int | MEM_Real | MEM_IntReal))

        rewriter.setInsertionPointToStart(blockAfterMemNumeric);

        auto resultValue = rewriter.create<LoadOp>(loc, resultAddr);
        return resultValue;
    }
}