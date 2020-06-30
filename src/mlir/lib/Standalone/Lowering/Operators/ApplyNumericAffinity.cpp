#include "mlir/Dialect/LLVMIR/LLVMDialect.h"

#include "Standalone/Lowering/ApplyNumericAffinity.h"
#include "Standalone/Lowering/Printer.h"
#include "Standalone/TypeDefinitions.h"
#include "Standalone/ConstantManager.h"
#include "Standalone/Utils.h"
#include "Standalone/VdbeContext.h"

extern mlir::LLVM::LLVMFuncOp f_sqlite3AtoF;
extern mlir::LLVM::LLVMFuncOp f_sqlite3VdbeIntegerAffinity;

extern "C" {
#include "sqlite3.h"
#include "src/vdbeInt.h"
}

namespace mlir::standalone::passes::Inlining {

    ApplyNumericAffinity::ApplyNumericAffinity(VdbeContext& vdbeCtx, MLIRContext& context, OpBuilder& rewriter, Printer& print, ConstantManager& constants)
            : vdbeCtx(vdbeCtx), mlirContext(context), rewriter(rewriter), printer(print), constantManager(constants)
    {
    }

    Value ApplyNumericAffinity::alsoAnInt(Location loc, Value pRec, Value rValue, Value out) {
        auto& constants = constantManager;
        auto& context = mlirContext;
        auto ctx = &context;
        LOWERING_NAMESPACE

        return constants(1, 1);
    }

    void ApplyNumericAffinity::operator()(Location loc, Value mem, Value bTryForInt) {
        auto& constants = constantManager;
        auto& context = mlirContext;
        auto ctx = &context;
        LOWERING_NAMESPACE

        auto stackState = rewriter.create<mlir::LLVM::StackSaveOp>(loc, T::i8PtrTy);

        auto rValueAddr = rewriter.create<AllocaOp>(LOC, T::doublePtrTy, constants(1, 32), 0);

        auto uAddr = rewriter.create<GEPOp>(loc, T::doublePtrTy, mem, ValueRange {
            constants(0, 32),
            constants(0, 32),
            constants(0, 32)
        });
        auto iAddr = rewriter.create<BitcastOp>(loc, T::i64PtrTy, uAddr);

        auto flagsAddr = rewriter.create<GEPOp>(loc, T::i16PtrTy, mem, ValueRange {
            constants(0, 32),
            constants(1, 32)
        });

        auto encAddr = rewriter.create<GEPOp>(loc, T::i8PtrTy, mem, ValueRange {
            constants(0, 32),
            constants(2, 32)
        });
        auto enc = rewriter.create<LoadOp>(loc, encAddr);

        auto zAddr = rewriter.create<GEPOp>(loc, T::i8PtrPtrTy, mem, ValueRange {
            constants(0, 32),
            constants(5, 32)
        });
        auto z = rewriter.create<LoadOp>(loc, zAddr);

        auto nAddr = rewriter.create<GEPOp>(loc, T::i32PtrTy, mem, ValueRange {
           constants(0, 32),
           constants(4, 32)
        });
        auto n = rewriter.create<LoadOp>(loc, nAddr);

        auto rc = rewriter.create<CallOp>(loc, f_sqlite3AtoF, ValueRange{
                z, rValueAddr, n, enc
        }).getResult(0);

        auto curBlock = rewriter.getBlock();
        auto blockEnd = SPLIT_GO_BACK_TO(curBlock);
        auto blockRemoveStr = SPLIT_GO_BACK_TO(curBlock);
        auto blockMoreThan1 = SPLIT_GO_BACK_TO(curBlock);
        auto block1 = SPLIT_GO_BACK_TO(curBlock);
        auto blockNotLe0 = SPLIT_GO_BACK_TO(curBlock);

        auto rcLe0 = rewriter.create<ICmpOp>(loc, ICmpPredicate::sle, rc, constants(0, 32));
        rewriter.create<CondBrOp>(loc, rcLe0, blockEnd, blockNotLe0);
        {
            rewriter.setInsertionPointToStart(blockNotLe0);

            auto rc1 = rewriter.create<ICmpOp>(loc, ICmpPredicate::eq, rc, constants(1, 32));
            rewriter.create<CondBrOp>(loc, rc1, block1, blockMoreThan1);
            { // if (rc == 1)
                rewriter.setInsertionPointToStart(block1);

                // Check alsoAnInt(pRec, rValue, &pRec->u.i)
                auto rValue = rewriter.create<LoadOp>(loc, rValueAddr);
                auto alsoInt = alsoAnInt(loc, mem, rValue, iAddr);

                auto curBlock = rewriter.getBlock();
                auto blockAlsoInt = SPLIT_GO_BACK_TO(curBlock);

                rewriter.create<CondBrOp>(loc, alsoInt, blockAlsoInt, blockMoreThan1);

                { // if (alsoAnInt(...)
                    rewriter.setInsertionPointToStart(blockAlsoInt);

                    auto flags = rewriter.create<LoadOp>(loc, flagsAddr);
                    auto flagsOrInt = rewriter.create<OrOp>(loc, flags, constants(MEM_Int, 16));
                    rewriter.create<StoreOp>(loc, flagsOrInt, flagsAddr);

                    rewriter.create<BranchOp>(loc, blockRemoveStr);
                } // end if (alsoAnInt(...)
            } // end if (rc == 1)
            { // if (rc >= 1 || rc == 1 && !alsoAnInt)
                rewriter.setInsertionPointToStart(blockMoreThan1);

                auto rValue = rewriter.create<LoadOp>(loc, rValueAddr);
                rewriter.create<StoreOp>(loc, rValue, uAddr);

                auto flags = rewriter.create<LoadOp>(loc, flagsAddr);
                auto flagsOrReal = rewriter.create<OrOp>(loc, flags, constants(MEM_Real, 16));
                rewriter.create<StoreOp>(loc, flagsOrReal, flagsAddr);

                auto curBlock = rewriter.getBlock();
                auto blockAfterTryForInt = SPLIT_GO_BACK_TO(curBlock);
                auto blockTryForInt = SPLIT_GO_BACK_TO(curBlock);

                auto condTryForInt = rewriter.create<ICmpOp>(LOC, Pred::ne, bTryForInt, constants(0, 32));

                rewriter.create<CondBrOp>(LOC, condTryForInt, blockTryForInt, blockAfterTryForInt);
                { // if (bTryForInt)
                    rewriter.setInsertionPointToStart(blockTryForInt);

                    rewriter.create<CallOp>(LOC, f_sqlite3VdbeIntegerAffinity, ValueRange { mem });

                    rewriter.create<BranchOp>(loc, blockAfterTryForInt);
                } // end if (bTryForInt)
                rewriter.setInsertionPointToStart(blockAfterTryForInt);

                rewriter.create<BranchOp>(loc, blockRemoveStr);
            } // end if (rc >= 1 || rc == 1 && !alsoAnInt)
            rewriter.setInsertionPointToStart(blockRemoveStr);

            /// pRec->flags &= ~MEM_Str;
            auto flags = rewriter.create<LoadOp>(loc, flagsAddr);
            auto flagsAndNotStr = rewriter.create<AndOp>(loc, flags, constants(~MEM_Str, 16));
            rewriter.create<StoreOp>(loc, flagsAndNotStr, flagsAddr);

            rewriter.create<BranchOp>(loc, blockEnd);
        }

        rewriter.setInsertionPointToStart(blockEnd);
        rewriter.create<mlir::LLVM::StackRestoreOp>(loc, stackState);
    }

}