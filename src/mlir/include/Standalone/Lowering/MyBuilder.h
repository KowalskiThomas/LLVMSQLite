#pragma once

#include <src/mlir/include/Standalone/TypeDefinitions.h>

template<typename Rewriter>
struct MyBuilder {
    USING_OPS

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

    Value insertICmpOp(mlir::Location loc, ICmpPredicate pred, mlir::Value lhs, int rhs) {
        auto cst = constants(rhs, getBitWidth(lhs));
        return rewriter.template create<ICmpOp>(loc, pred, lhs, cst);
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

    Value insertGEPOp(Location loc, mlir::Type ty, Value base, ValueRange indexes) {
        return rewriter.template create<GEPOp>(loc, ty, base, indexes);
    }

    Value insertLoad(Location loc, Value addr) {
        return rewriter.template create<LoadOp>(loc, addr);
    }

    Value insertAddOp(Location loc, Value lhs, Value rhs) {
        return rewriter.template create<AddOp>(loc, lhs, rhs);
    }

    Value insertPtrToIntOp(Location loc, Value ptr) {
        return rewriter.template create<PtrToIntOp>(loc, T::i64Ty, ptr);
    }

    Value insertIntToPtrOp(Location loc, Type ty, Value i) {
        return rewriter.template create<IntToPtrOp>(loc, ty, i);
    }

    Value insertBitcastOp(Location loc, Value x, Type ty) {
        return rewriter.template create<BitcastOp>(loc, ty, x);
    }

    size_t getBitWidth(Type x) const {
        static std::vector<size_t> possibleSizes { 1, 8, 16, 32, 64 };
        auto rightSize = 0llu;
        for(auto size : possibleSizes)
            if (x.isInteger(size)
                || x == LLVMType::getIntNTy(llvmDialect, size) ) {
                rightSize = size;
                break;
            }

        assert(rightSize > 0);
        return rightSize;
    }

    size_t getBitWidth(Value v) const {
        return getBitWidth(v.getType());
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

    Value insertAndOp(Location loc, Value lhs, Value rhs) {
        return rewriter.template create<AndOp>(loc, lhs, rhs);
    }

    Value insertAndOp(Location loc, Value lhs, int rhs) {
        auto rightSize = getBitWidth(lhs);
        auto cst = constants(rhs, rightSize);
        return insertAndOp(loc, lhs, cst);
    }

    void insertStoreOp(Location loc, Value value, Value addr) {
        rewriter.template create<StoreOp>(loc, value, addr);
    }

    void insertStoreOp(Location loc, int x, Value addr) {
        // mlir::LLVM::LLVMType::isPointerTy()
        assert(addr.getType().cast<mlir::LLVM::LLVMType>().isPointerTy());
        auto ty = addr.getType().cast<mlir::LLVM::LLVMType>().getPointerElementTy();
        out(ty);
        assert(ty.isIntegerTy());
        auto width = getBitWidth(ty);

        auto cst = constants(x, width);
        insertStoreOp(loc, cst, addr);
    }
};

#undef alloca
#define myOperators  \
auto alloca = [&builder](mlir::Location loc, mlir::Type ty) { \
    return builder.insertAllocaOp(loc, ty); \
}; \
 \
auto call = [&builder](mlir::Location loc, LLVM::LLVMFuncOp f, auto... args) { \
    return builder.insertCallOp(loc, f, ValueRange{args...}); \
}; \
 \
auto iCmp = [&builder](mlir::Location loc, ICmpPredicate pred, Value lhs, auto rhs) { \
    return builder.insertICmpOp(loc, pred, lhs, rhs); \
}; \
 \
auto branch = [&builder](mlir::Location loc, mlir::Block* b) { \
    return builder.insertBranchOp(loc, b); \
}; \
 \
auto condBranch = [&builder](mlir::Location loc, Value cond, Block* bTrue, Block* bFalse) { \
    builder.insertCondBranchOp(loc, cond, bTrue, bFalse); \
}; \
 \
auto ip_start = [&rewriter](mlir::Block* b) { \
    rewriter.setInsertionPointToStart(b); \
}; \
 \
auto getElementPtr = [&builder](mlir::Location loc, mlir::Type ty, Value base, auto... indexes) { \
    return builder.insertGEPOp(loc, ty, base, indexes...); \
}; \
 \
auto getElementPtrImm = [&builder, &rewriter, llvmDialect, &constants](mlir::Location loc, mlir::Type ty, Value base, auto... indexes) { \
    llvm::SmallVector<int, 16> x { indexes... }; \
    llvm::SmallVector<Value, 16> values; \
    auto intTy = LLVMType::getIntNTy(llvmDialect, 32); \
    for(auto i : x) { \
        auto attr = rewriter.getIntegerAttr(rewriter.getIntegerType(32), i); \
        values.push_back(rewriter.create<mlir::LLVM::ConstantOp>(loc, intTy, attr)); \
    } \
    return builder.insertGEPOp(loc, ty, base, (mlir::ValueRange) values); \
}; \
 \
auto load = [&builder](mlir::Location loc, mlir::Value addr) { \
    return builder.insertLoad(loc, addr); \
}; \
 \
auto add = [&builder](mlir::Location loc, mlir::Value val, auto x) { \
    return builder.insertAddOp(loc, val, x); \
}; \
 \
auto bitOr = [&builder](mlir::Location loc, mlir::Value val, auto x) { \
    return builder.insertOrOp(loc, val, x); \
}; \
 \
auto bitAnd = [&builder](mlir::Location loc, mlir::Value val, auto x) { \
    return builder.insertAndOp(loc, val, x); \
}; \
 \
auto store = [&builder](mlir::Location loc, auto value, mlir::Value addr) { \
    builder.insertStoreOp(loc, value, addr); \
}; \
\
auto ptrToInt = [&builder](mlir::Location loc, mlir::Value value) { \
    return builder.insertPtrToIntOp(loc, value); \
}; \
\
auto bitCast = [&builder](mlir::Location loc, mlir::Value value, mlir::Type ty) {\
    return builder.insertBitcastOp(loc, value, ty);\
}; \
