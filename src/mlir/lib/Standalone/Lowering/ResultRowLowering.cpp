#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"
#include "Standalone/ConstantManager.h"

template<typename Rewriter>
struct MyBuilder {
    using MLIRContext = mlir::MLIRContext;
    using Value = mlir::Value;
    using Block = mlir::Block;
    using Location = mlir::Location;
    using ValueRange = mlir::ValueRange;

    using LoadOp = mlir::LLVM::LoadOp;
    using CallOp = mlir::LLVM::CallOp;
    using StoreOp = mlir::LLVM::StoreOp;
    using OrOp = mlir::LLVM::OrOp;
    using AndOp = mlir::LLVM::AndOp;
    using AllocaOp = mlir::LLVM::AllocaOp;
    using BranchOp = mlir::BranchOp;

    MLIRContext* ctx;
    LLVMDialect* llvmDialect;
    ConstantManager<Rewriter>& constants;
    Rewriter& rewriter;

    MyBuilder(MLIRContext* ctx, ConstantManager<Rewriter>& constants, Rewriter& rewriter)
        : ctx(ctx), constants(constants), rewriter(rewriter),
          llvmDialect(ctx->getRegisteredDialect<LLVMDialect>())
    {
    }

    AllocaOp insertAllocaOp(mlir::Location loc, mlir::Type ty) {
        return rewriter.template create<mlir::LLVM::AllocaOp>(loc, ty, constants(1, 32), 0);
    }

    Value insertCallOp(mlir::Location loc, LLVMFuncOp func, mlir::ValueRange range) {
        return rewriter.template create<CallOp>(loc, func, range).getResult(0);
    }

    Value insertICmpOp(mlir::Location loc, ICmpPredicate pred, mlir::Value lhs, mlir::Value rhs) {
        return rewriter.template create<ICmpOp>(loc, pred, lhs, rhs);
    }

    void insertBranchOp(mlir::Location loc, mlir::Block* b) {
        rewriter.template create<BranchOp>(loc, b);
    }

    void insertCondBranchOp(Location loc, Value cond, Block* bTrue, Block* bFalse) {
        rewriter.template create<CondBrOp>(loc, cond, bTrue, bFalse);
    }

    template<typename... V>
    Value insertGEPOp(Location loc, mlir::Type ty, Value base, V... indexes) {
        return rewriter.template create<GEPOp>(loc, ty, base, ValueRange{ indexes... });
    }

    Value insertLoad(Location loc, Value addr) {
        return rewriter.template create<LoadOp>(loc, addr);
    }

    Value insertAddOp(Location loc, Value lhs, Value rhs) {
        return rewriter.template create<AddOp>(loc, lhs, rhs);
    }

    size_t getBitWidth(Value x) const {
        static std::vector<size_t> possibleSizes { 1, 8, 16, 32, 64 };
        auto rightSize = 0llu;
        for(auto size : possibleSizes)
            if (x.getType().isInteger(size)
                || x.getType() == LLVMType::getIntNTy(llvmDialect, size) ) {
                rightSize = size;
                break;
            }

        assert(rightSize > 0);
        return rightSize;
    }

    Value insertAddOp(Location loc, Value lhs, int rhs) {
        auto rightSize = getBitWidth(lhs);
        auto cst = constants(rhs, rightSize);
        return insertAddOp(loc, lhs, cst);
    }

    Value insertOrOp(Location loc, Value lhs, Value rhs) {
        return rewriter.template create<OrOp>(loc, lhs, rhs);
    }

    Value insertOrOp(Location loc, Value lhs, int rhs) {
        auto rightSize = getBitWidth(lhs);
        auto cst = constants(rhs, rightSize);
        return insertOrOp(loc, lhs, cst);
    }

    void insertStoreOp(Location loc, Value value, Value addr) {
        rewriter.template create<StoreOp>(loc, value, addr);
    }
};

#undef alloca

namespace mlir::standalone::passes {
    LogicalResult ResultRowLowering::matchAndRewrite(ResultRow rrOp, PatternRewriter &rewriter) const {
        auto op = &rrOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE
        using Pred = ICmpPredicate;

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);

        auto alloca = [&builder](mlir::Location loc, mlir::Type ty) {
            return builder.insertAllocaOp(loc, ty);
        };

        auto call = [&builder](mlir::Location loc, LLVM::LLVMFuncOp f, auto... args) {
            return builder.insertCallOp(loc, f, ValueRange{args...});
        };

        auto iCmp = [&builder](mlir::Location loc, ICmpPredicate pred, Value lhs, Value rhs) {
            return builder.insertICmpOp(loc, pred, lhs, rhs);
        };

        auto branch = [&builder](mlir::Location loc, mlir::Block* b) {
            return builder.insertBranchOp(loc, b);
        };

        auto condBranch = [&builder](mlir::Location loc, Value cond, Block* bTrue, Block* bFalse) {
            builder.insertCondBranchOp(loc, cond, bTrue, bFalse);
        };

        auto ip_start = [&rewriter](mlir::Block* b) {
            rewriter.setInsertionPointToStart(b);
        };

        auto getElementPtr = [&builder](mlir::Location loc, mlir::Type ty, Value base, auto... indexes) {
            return builder.insertGEPOp(loc, ty, base, indexes...);
        };

        auto load = [&builder](mlir::Location loc, mlir::Value addr) {
            return builder.insertLoad(loc, addr);
        };

        auto add = [&builder](mlir::Location loc, mlir::Value val, auto x) {
            return builder.insertAddOp(loc, val, x);
        };

        auto bitOr = [&builder](mlir::Location loc, mlir::Value val, auto x) {
            return builder.insertOrOp(loc, val, x);
        };

        auto store = [&builder](mlir::Location loc, mlir::Value value, mlir::Value addr) {
            builder.insertStoreOp(loc, value, addr);
        };

        auto i = alloca(LOC, T::i32PtrTy);

        auto rc = call(LOC, f_sqlite3VdbeCheckFk, constants(T::VdbePtrTy, vdbe), constants(0, 32));
        auto sqliteOk = constants(SQLITE_OK, 32);

        auto rcNeOk = iCmp(LOC, Pred::ne, rc, sqliteOk);

        auto curBlock = rewriter.getBlock();

        auto blockEndResultRow = curBlock->splitBlock(rrOp); GO_BACK_TO(curBlock);

        auto blockAfterRcNeOk = SPLIT_BLOCK; GO_BACK_TO(curBlock);
        auto blockRcNeOk = SPLIT_BLOCK; GO_BACK_TO(curBlock);

        condBranch(LOC, rcNeOk, blockRcNeOk, blockAfterRcNeOk);
        { // if (SQLITE_OK != (rc = sqlite3VdbeCheckFk(p, 0)))
            rewriter.setInsertionPointToStart(blockRcNeOk);

            PROGRESS("TODO: GoTo OP_ResultRow: Abort due to error")

            branch(LOC, blockAfterRcNeOk);
        } // end if (SQLITE_OK != (rc = sqlite3VdbeCheckFk(p, 0)))

        ip_start(blockAfterRcNeOk);

        rc = call(LOC, f_sqlite3VdbeCloseStatement, constants(T::VdbePtrTy, vdbe), constants(SAVEPOINT_RELEASE, 32));

        auto cacheCtrAddr = getElementPtr(LOC, T::i32PtrTy, constants(T::VdbePtrTy, vdbe),
                constants(0, 32), // &*p
                constants(9, 32)  // cacheCtr is 10-th element
                );

        auto cacheCtrValue = load(LOC, cacheCtrAddr);
        auto cacheCtrPlus2 = add(LOC, cacheCtrValue, 2);
        auto cacheCtrOr1 = bitOr(LOC, cacheCtrValue, 1);
        store(LOC, cacheCtrOr1, cacheCtrAddr);

        branch(LOC, blockEndResultRow);

        ip_start(blockEndResultRow);

        rewriter.eraseOp(rrOp);
        return success();
    } // matchAndRewrite

#define alloca __alloca(size)

} // namespace mlir::standalone::passes