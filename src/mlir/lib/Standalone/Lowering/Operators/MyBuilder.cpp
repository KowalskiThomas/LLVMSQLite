#include "Standalone/Lowering/MyBuilder.h"

using Value = mlir::Value;
using ValueRange = mlir::ValueRange;
using Block = mlir::Block;
using Type = mlir::Type;
using Location = mlir::Location;
using LLVMType = mlir::LLVM::LLVMType;

static bool isFloatingPointType(Type t) {
    auto llvmT = t.cast<LLVMType>();
    return llvmT.isFloatTy() || llvmT.isDoubleTy() || llvmT.isHalfTy();
}

size_t MyBuilder::getBitWidth(Type x) const {
    static std::vector<size_t> possibleSizes { 1, 8, 16, 32, 64 };
    auto rightSize = 0llu;
    for(auto size : possibleSizes)
        if (x.isInteger(size)
            || x == LLVMType::getIntNTy(llvmDialect, size) ) {
            rightSize = size;
            break;
        }

    if (rightSize == 0)
        err("Couldn't find bit width for type " << x)

    assert(rightSize > 0 && "Couldn't find bit-width of value");
    return rightSize;
}

size_t MyBuilder::getBitWidth(Value v) const {
    return getBitWidth(v.getType());
}


MyBuilder::AllocaOp MyBuilder::insertAllocaOp(Location loc, mlir::Type ty) {
    return rewriter.create<mlir::LLVM::AllocaOp>(loc, ty, constants(1, 32), 0);
}

llvm::Optional<Value> MyBuilder::insertCallOp(Location loc, MyBuilder::LLVMFuncOp func, ValueRange range) {
    if (func.getNumFuncResults() == 0) {
        rewriter.create<CallOp>(loc, func, range);
        return llvm::None;
    }
    auto callOp = rewriter.create<CallOp>(loc, func, range);
    Value result = callOp.getResult(0);
    return llvm::Optional<Value>(result);
}

Value MyBuilder::insertICmpOp(Location loc, MyBuilder::ICmpPredicate pred, Value lhs, Value rhs) {
    return rewriter.create<ICmpOp>(loc, pred, lhs, rhs);
}

Value MyBuilder::insertICmpOp(Location loc, MyBuilder::ICmpPredicate pred, Value lhs, int rhs) {
/*    auto llvmType = lhs.getType().cast<mlir::LLVM::LLVMType>();
    if (llvmType && llvmType.isPointerTy()) {
        out("test");
        auto rhsPointer = rewriter.create<IntToPtrOp>(loc, llvmType, constants(rhs, 64));
        return insertICmpOp(loc, pred, lhs, (Value)rhsPointer);
    }*/

    Value cst = constants(rhs, getBitWidth(lhs));
    return rewriter.create<ICmpOp>(loc, pred, lhs, cst);
}

void MyBuilder::insertBranchOp(Location loc, Block *b) {
    rewriter.create<BranchOp>(loc, b);
}

void MyBuilder::insertCondBranchOp(MyBuilder::Location loc, Value cond, MyBuilder::Block *bTrue, MyBuilder::Block *bFalse) {
    rewriter.create<CondBrOp>(loc, cond, bTrue, bFalse);
}

Value MyBuilder::insertGEPOp(MyBuilder::Location loc, mlir::Type ty, Value base, ValueRange indexes) {
    return rewriter.create<GEPOp>(loc, ty, base, indexes);
}

Value MyBuilder::insertLoad(MyBuilder::Location loc, Value addr) {
    return rewriter.create<LoadOp>(loc, addr);
}

Value MyBuilder::insertAddOp(MyBuilder::Location loc, Value lhs, Value rhs) {
    return rewriter.create<AddOp>(loc, lhs, rhs);
}

Value MyBuilder::insertPtrToIntOp(MyBuilder::Location loc, Value ptr) {
    return rewriter.create<PtrToIntOp>(loc, T::i64Ty, ptr);
}

Value MyBuilder::insertIntToPtrOp(MyBuilder::Location loc, Type ty, Value i) {
    return rewriter.create<IntToPtrOp>(loc, ty, i);
}

Value MyBuilder::insertBitCastOp(Location loc, Value x, Type ty) {
    return rewriter.create<BitcastOp>(loc, ty, x);
}

Value MyBuilder::insertFDivOp(Location loc, Value divided, Value by) {
    assert(isFloatingPointType(divided.getType()));
    assert(isFloatingPointType(by.getType()));

    return rewriter.create<mlir::LLVM::FDivOp>(loc, divided, by);
}

Value MyBuilder::insertFRemOp(Location loc, Value a, Value b) {
    assert(isFloatingPointType(a.getType()));
    assert(isFloatingPointType(b.getType()));

    return rewriter.create<mlir::LLVM::FRemOp>(loc, a, b);
}

Value MyBuilder::insertFSubOp(Location loc, Value a, Value b) {
    assert(isFloatingPointType(a.getType()));
    assert(isFloatingPointType(b.getType()));

    return rewriter.create<mlir::LLVM::FSubOp>(loc, a, b);
}
Value MyBuilder::insertFAddOp(Location loc, Value a, Value b) {
    assert(isFloatingPointType(a.getType()));
    assert(isFloatingPointType(b.getType()));

    return rewriter.create<mlir::LLVM::FAddOp>(loc, a, b);
}

Value MyBuilder::insertFMulOp(Location loc, Value a, Value b) {
    assert(isFloatingPointType(a.getType()));
    assert(isFloatingPointType(b.getType()));

    return rewriter.create<mlir::LLVM::FMulOp>(loc, a, b);
}

Value MyBuilder::insertZExtOp(Location loc, Value a, mlir::Type targetType) {
    assert(a.getType().cast<LLVMType>().isIntegerTy());
    assert(targetType.cast<LLVMType>().isIntegerTy());

    return rewriter.create<mlir::LLVM::ZExtOp>(loc, targetType, a);
}

Value MyBuilder::insertZExtOp(Location loc, Value x, size_t targetWidth) {
    assert(x.getType().cast<LLVMType>().isIntegerTy());
    assert(targetWidth > 0 && targetWidth <= 64);

    return insertZExtOp(loc, x, LLVMType::getIntNTy(llvmDialect, targetWidth));
}

Value MyBuilder::insertTruncOp(Location loc, Value x, mlir::Type targetType) {
    assert(x.getType().cast<LLVMType>().isIntegerTy());
    assert(targetType.cast<LLVMType>().isIntegerTy());

    return rewriter.create<mlir::LLVM::TruncOp>(loc, targetType, x);
}

Value MyBuilder::insertTruncOp(Location loc, Value x, size_t targetWidth) {
    assert(x.getType().cast<LLVMType>().isIntegerTy());
    assert(targetWidth > 0 && targetWidth <= 64);

    return insertTruncOp(loc, x, LLVMType::getIntNTy(llvmDialect, targetWidth));
}

Value MyBuilder::insertOrOp(Location loc, Value lhs, Value rhs) {
    return rewriter.create<OrOp>(loc, lhs, rhs);
}

Value MyBuilder::insertOrOp(Location loc, Value lhs, int rhs) {
    auto rightSize = getBitWidth(lhs);
    auto cst = constants(rhs, rightSize);
    return insertOrOp(loc, lhs, cst);
}

Value MyBuilder::insertAndOp(Location loc, Value lhs, Value rhs) {
    return rewriter.create<AndOp>(loc, lhs, rhs);
}

Value MyBuilder::insertAndOp(Location loc, Value lhs, int rhs) {
    auto rightSize = getBitWidth(lhs);
    auto cst = constants(rhs, rightSize);
    return insertAndOp(loc, lhs, cst);
}

void MyBuilder::insertStoreOp(Location loc, Value value, Value addr) {
    auto valueTypeLlvm = value.getType().dyn_cast_or_null<mlir::LLVM::LLVMType>();
    auto addrTypeLlvm = value.getType().dyn_cast_or_null<mlir::LLVM::LLVMType>();
    if (valueTypeLlvm && valueTypeLlvm.isPointerTy() && valueTypeLlvm.getPointerElementTy() == addrTypeLlvm) {
        llvm_unreachable("insertStoreOp: It seems that 'value' and 'addr' arguments have been mismatched.");
    }

    rewriter.create<StoreOp>(loc, value, addr);
}

void MyBuilder::insertStoreOp(Location loc, int x, Value addr) {
    assert(addr.getType().cast<mlir::LLVM::LLVMType>().isPointerTy());
    auto ty = addr.getType().cast<mlir::LLVM::LLVMType>().getPointerElementTy();
    assert(ty.isIntegerTy());
    auto width = getBitWidth(ty);

    auto cst = constants(x, width);
    insertStoreOp(loc, cst, addr);
}

Value MyBuilder::insertSDivOp(Location loc, Value divided, Value by) {
    assert(divided.getType().cast<mlir::LLVM::LLVMType>().isIntegerTy());
    assert(by.getType().cast<mlir::LLVM::LLVMType>().isIntegerTy());

    return rewriter.create<mlir::LLVM::SDivOp>(loc, divided, by);
}

Value MyBuilder::insertMulOp(Location loc, Value a, Value b) {
    assert(a.getType().cast<mlir::LLVM::LLVMType>().isIntegerTy());
    assert(b.getType().cast<mlir::LLVM::LLVMType>().isIntegerTy());

    return rewriter.create<mlir::LLVM::MulOp>(loc, a, b);
}

Value MyBuilder::insertRemOp(Location loc, Value a, Value b) {
    assert(a.getType().cast<mlir::LLVM::LLVMType>().isIntegerTy());
    assert(b.getType().cast<mlir::LLVM::LLVMType>().isIntegerTy());

    return rewriter.create<mlir::LLVM::SDivOp>(loc, a, b);
}

Value MyBuilder::insertSaveStack(Location loc) {
    return rewriter.create<mlir::LLVM::StackSaveOp>(loc, T::i8PtrTy);
}

void MyBuilder::insertRestoreStack(Location loc, Value stackState) {
    rewriter.create<mlir::LLVM::StackRestoreOp>(loc, stackState);
}