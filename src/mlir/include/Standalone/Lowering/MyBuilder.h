#pragma once

#include "Standalone/ConstantManager.h"
#include "Standalone/Utils.h"
#include "Standalone/TypeDefinitions.h"

struct MyBuilder {
    using OpBuilder = mlir::OpBuilder;
    USING_OPS

    MLIRContext* ctx;
    LLVMDialect* llvmDialect;
    ConstantManager& constants;
    OpBuilder& rewriter;

    MyBuilder(MLIRContext* ctx, ConstantManager& constants, OpBuilder& rewriter)
            : ctx(ctx), constants(constants), rewriter(rewriter),
              llvmDialect(ctx->getRegisteredDialect<LLVMDialect>())
    {
    }

    AllocaOp insertAllocaOp(mlir::Location loc, mlir::Type ty);

    llvm::Optional<Value> insertCallOp(mlir::Location loc, LLVMFuncOp func, mlir::ValueRange range);

    Value insertICmpOp(mlir::Location loc, ICmpPredicate pred, mlir::Value lhs, mlir::Value rhs);

    Value insertICmpOp(mlir::Location loc, ICmpPredicate pred, mlir::Value lhs, int rhs);

    void insertBranchOp(mlir::Location loc, mlir::Block* b);

    void insertCondBranchOp(Location loc, Value cond, Block* bTrue, Block* bFalse);

    template<typename... V>
    Value insertGEPOp(Location loc, mlir::Type ty, Value base, V... indexes) {
        return rewriter.create<GEPOp>(loc, ty, base, ValueRange{ indexes... });
    }

    Value insertGEPOp(Location loc, mlir::Type ty, Value base, ValueRange indexes);

    Value insertLoad(Location loc, Value addr);

    Value insertAddOp(Location loc, Value lhs, Value rhs);

    Value insertPtrToIntOp(Location loc, Value ptr);

    Value insertIntToPtrOp(Location loc, Type ty, Value i);

    Value insertBitCastOp(Location loc, Value x, Type ty);

    size_t getBitWidth(Type x) const;

    size_t getBitWidth(Value v) const;

    template<typename Int>
    Value insertAddOp(Location loc, Value lhs, Int rhs) {
        static_assert(std::is_integral<Int>::value);
        auto rightSize = getBitWidth(lhs);
        auto cst = constants(rhs, rightSize);
        return insertAddOp(loc, lhs, cst);
    }

    Value insertOrOp(Location loc, Value lhs, Value rhs);

    Value insertOrOp(Location loc, Value lhs, int rhs);

    Value insertAndOp(Location loc, Value lhs, Value rhs);

    Value insertAndOp(Location loc, Value lhs, int rhs);

    void insertStoreOp(Location loc, Value value, Value addr);

    void insertStoreOp(Location loc, int x, Value addr);

    void insertStoreOp(Location loc, void* ptr, Value addr);

    Value insertSDivOp(Location loc, Value divided, Value by);

    Value insertMulOp(Location loc, Value a, Value b);

    Value insertRemOp(Location loc, Value a, Value b);

    Value insertFDivOp(Location loc, Value divided, Value by);

    Value insertFRemOp(Location loc, Value a, Value b);

    Value insertFSubOp(Location loc, Value a, Value b);

    Value insertFAddOp(Location loc, Value a, Value b);

    Value insertFMulOp(Location loc, Value a, Value b);

    Value insertZExtOp(Location loc, Value a, Type targetType);

    Value insertZExtOp(Location loc, Value x, size_t targetWidth);

    Value insertTruncOp(Location loc, Value x, Type targetType);

    Value insertTruncOp(Location loc, Value x, size_t targetWidth);

    Value insertSaveStack(Location loc);

    void insertRestoreStack(Location loc, Value stackState);
};

#undef alloca
#define myOperators  \
auto alloca = [&builder](mlir::Location loc, mlir::Type ty) { \
    return builder.insertAllocaOp(loc, ty); \
}; \
 \
auto call = [&builder](mlir::Location loc, LLVM::LLVMFuncOp f, auto... args) { \
    return builder.insertCallOp(loc, f, mlir::ValueRange{args...}); \
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
    llvm::SmallVector<long long, 16> x { indexes... }; \
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
auto store = [&builder](mlir::Location loc, auto value, mlir::Value addr) { \
    builder.insertStoreOp(loc, value, addr); \
}; \
 \
auto add = [&builder](mlir::Location loc, mlir::Value val, auto x) { \
    return builder.insertAddOp(loc, val, x); \
}; \
auto addInPlace = [&builder, &load, &add, &store](mlir::Location loc, mlir::LLVM::AllocaOp addr, auto x) { \
    auto val = load(loc, addr); \
    auto result = add(loc, val, x); \
    store(loc, result, addr); \
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
auto ptrToInt = [&builder](mlir::Location loc, mlir::Value value) { \
    return builder.insertPtrToIntOp(loc, value); \
}; \
\
auto bitCast = [&builder](mlir::Location loc, mlir::Value value, mlir::Type ty) {\
    return builder.insertBitCastOp(loc, value, ty);\
}; \
auto sDiv = [&](Location loc, auto a, auto b) { \
    return builder.insertSDivOp(loc, a, b); \
}; \
auto mul = [&](Location loc, auto a, auto b) { \
    return builder.insertMulOp(loc, a, b); \
}; \
auto rem = [&](Location loc, auto a, auto b) { \
    return builder.insertRemOp(loc, a, b); \
}; \
auto fAdd = [&](Location loc, auto a, auto b) { \
    return builder.insertFAddOp(loc, a, b); \
}; \
auto fRem = [&](Location loc, auto a, auto b) { \
    return builder.insertFRemOp(loc, a, b); \
}; \
auto fSub = [&](Location loc, auto a, auto b) { \
    return builder.insertFSubOp(loc, a, b); \
}; \
auto fMul = [&](Location loc, auto a, auto b) { \
    return builder.insertFMulOp(loc, a, b); \
}; \
auto fDiv = [&](Location loc, auto a, auto b) { \
    return builder.insertFDivOp(loc, a, b); \
}; \
auto zExt = [&](Location loc, auto a, auto b) { \
    return builder.insertZExtOp(loc, a, b); \
}; \
auto trunc = [&](Location loc, auto a, auto b) { \
    return builder.insertTruncOp(loc, a, b); \
}; \
auto saveStack = [&](Location loc) { \
    return builder.insertSaveStack(loc); \
}; \
auto restoreStack = [&](Location loc, Value state) { \
    builder.insertRestoreStack(loc, state); \
}; \
auto memSetTypeFlag = [&](Value flagsAddr, int flag) { \
    auto flagsOut = load(LOC, flagsAddr); \
    flagsOut = bitAnd(LOC, flagsOut, ~(MEM_Zero | MEM_TypeMask)); \
    flagsOut = bitOr(LOC, flagsOut, flag); \
    store(LOC, flagsOut, flagsAddr); \
}; \

