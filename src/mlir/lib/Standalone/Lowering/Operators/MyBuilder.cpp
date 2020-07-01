#include "Standalone/Lowering/MyBuilder.h"
#include "Standalone/DebugUtils.h"

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

    LLVMSQLITE_ASSERT(rightSize > 0 && "Couldn't find bit-width of value");
    return rightSize;
}

size_t MyBuilder::getBitWidth(Value v) const {
    return getBitWidth(v.getType());
}


MyBuilder::AllocaOp MyBuilder::insertAllocaOp(Location loc, mlir::Type ty) {
    return rewriter.create<mlir::LLVM::AllocaOp>(loc, ty, constants(1, 32), 0);
}

llvm::Optional<Value> MyBuilder::insertCallOp(Location loc, LLVMFuncOp func, ValueRange range) {
    if (func.getNumFuncResults() == 0) {
        rewriter.create<CallOp>(loc, func, range);
        return llvm::None;
    }
    auto callOp = rewriter.create<CallOp>(loc, func, range);
    Value result = callOp.getResult(0);
    return llvm::Optional<Value>(result);
}

llvm::Optional<Value> MyBuilder::insertCallOp(Location loc, Value func, ValueRange range) {
    if (func.getType().cast<LLVMType>().getPointerElementTy().getFunctionResultType().isVoidTy()) {
        rewriter.create<CallOp>(loc, func, range);
        return llvm::None;
    }
    auto callOp = rewriter.create<CallOp>(loc, func, range);
    Value result = callOp.getResult(0);
    return llvm::Optional<Value>(result);
}

Value MyBuilder::insertICmpOp(Location loc, ICmpPredicate pred, Value lhs, Value rhs) {
    return rewriter.create<ICmpOp>(loc, pred, lhs, rhs);
}

Value MyBuilder::insertICmpOp(Location loc, ICmpPredicate pred, Value lhs, int rhs) {
    Value cst = constants(rhs, getBitWidth(lhs));
    return rewriter.create<ICmpOp>(loc, pred, lhs, cst);
}

Value MyBuilder::insertICmpOp(Location loc, ICmpPredicate pred, Value lhs, void* rhs) {
    auto llvmType = lhs.getType().cast<LLVMType>();
    LLVMSQLITE_ASSERT(llvmType.isPointerTy() && "Can't use insertICmpOp(..., void*) with non-pointer LHS!");

    auto rhsPointer = rewriter.create<IntToPtrOp>(loc, llvmType, constants((uint64_t)rhs, 64));
    return insertICmpOp(loc, pred, lhs, (Value)rhsPointer);
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

Value MyBuilder::insertIAddOp(MyBuilder::Location loc, Value lhs, Value rhs) {
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
    LLVMSQLITE_ASSERT(isFloatingPointType(divided.getType()));
    LLVMSQLITE_ASSERT(isFloatingPointType(by.getType()));

    return rewriter.create<mlir::LLVM::FDivOp>(loc, divided, by);
}

Value MyBuilder::insertFRemOp(Location loc, Value a, Value b) {
    LLVMSQLITE_ASSERT(isFloatingPointType(a.getType()));
    LLVMSQLITE_ASSERT(isFloatingPointType(b.getType()));

    return rewriter.create<mlir::LLVM::FRemOp>(loc, a, b);
}

Value MyBuilder::insertFSubOp(Location loc, Value a, Value b) {
    LLVMSQLITE_ASSERT(isFloatingPointType(a.getType()));
    LLVMSQLITE_ASSERT(isFloatingPointType(b.getType()));

    return rewriter.create<mlir::LLVM::FSubOp>(loc, a, b);
}

Value MyBuilder::insertFAddOp(Location loc, Value a, Value b) {
    LLVMSQLITE_ASSERT(isFloatingPointType(a.getType()));
    LLVMSQLITE_ASSERT(isFloatingPointType(b.getType()));

    return rewriter.create<mlir::LLVM::FAddOp>(loc, a, b);
}

Value MyBuilder::insertFMulOp(Location loc, Value a, Value b) {
    LLVMSQLITE_ASSERT(isFloatingPointType(a.getType()));
    LLVMSQLITE_ASSERT(isFloatingPointType(b.getType()));

    return rewriter.create<mlir::LLVM::FMulOp>(loc, a, b);
}

Value MyBuilder::insertZExtOp(Location loc, Value a, mlir::Type targetType) {
    LLVMSQLITE_ASSERT(a.getType().cast<LLVMType>().isIntegerTy());
    LLVMSQLITE_ASSERT(targetType.cast<LLVMType>().isIntegerTy());

    return rewriter.create<mlir::LLVM::ZExtOp>(loc, targetType, a);
}

Value MyBuilder::insertZExtOp(Location loc, Value x, size_t targetWidth) {
    LLVMSQLITE_ASSERT(x.getType().cast<LLVMType>().isIntegerTy());
    LLVMSQLITE_ASSERT(targetWidth > 0 && targetWidth <= 64);

    return insertZExtOp(loc, x, LLVMType::getIntNTy(llvmDialect, targetWidth));
}

Value MyBuilder::insertTruncOp(Location loc, Value x, mlir::Type targetType) {
    LLVMSQLITE_ASSERT(x.getType().cast<LLVMType>().isIntegerTy());
    LLVMSQLITE_ASSERT(targetType.cast<LLVMType>().isIntegerTy());

    return rewriter.create<mlir::LLVM::TruncOp>(loc, targetType, x);
}

Value MyBuilder::insertTruncOp(Location loc, Value x, size_t targetWidth) {
    LLVMSQLITE_ASSERT(x.getType().cast<LLVMType>().isIntegerTy());
    LLVMSQLITE_ASSERT(targetWidth > 0 && targetWidth <= 64);

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
    auto addrTypeLlvm = addr.getType().dyn_cast_or_null<mlir::LLVM::LLVMType>();
    if (valueTypeLlvm && valueTypeLlvm.isPointerTy() && valueTypeLlvm.getPointerElementTy() == addrTypeLlvm) {
        llvm_unreachable("insertStoreOp: It seems that 'value' and 'addr' arguments have been mismatched.");
    }
    // Enabling this allows for better MLIR-level type safety / debugging but breaks everything
    // It does not break LLVM-IR-lowered code because all LLVM IR typing is done at the LLVM-IR level and ignores ours
    // err("Value: " << valueTypeLlvm << " addr: " << addrTypeLlvm);
    // LLVMSQLITE_ASSERT(valueTypeLlvm.getPointerTo() == addrTypeLlvm && "insertStoreOp: type(addr) is not type(value)*");

    rewriter.create<StoreOp>(loc, value, addr);
}

void MyBuilder::insertStoreOp(Location loc, int x, Value addr) {
    LLVMSQLITE_ASSERT(addr.getType().cast<mlir::LLVM::LLVMType>().isPointerTy());
    auto ty = addr.getType().cast<mlir::LLVM::LLVMType>().getPointerElementTy();
    LLVMSQLITE_ASSERT(ty.isIntegerTy());
    auto width = getBitWidth(ty);

    auto cst = constants(x, width);
    insertStoreOp(loc, cst, addr);
}

void MyBuilder::insertStoreOp(Location loc, void* ptr, Value addr) {
    LLVMSQLITE_ASSERT(addr.getType().cast<mlir::LLVM::LLVMType>().isPointerTy());
    auto ty = addr.getType().cast<mlir::LLVM::LLVMType>().getPointerElementTy();

    auto value = insertIntToPtrOp(loc, ty, constants((uint64_t)ptr, 64));
    return insertStoreOp(loc, value, addr);
}

Value MyBuilder::insertISDivOp(Location loc, Value divided, Value by) {
    LLVMSQLITE_ASSERT(divided.getType().cast<mlir::LLVM::LLVMType>().isIntegerTy());
    LLVMSQLITE_ASSERT(by.getType().cast<mlir::LLVM::LLVMType>().isIntegerTy());

    return rewriter.create<mlir::LLVM::SDivOp>(loc, divided, by);
}

Value MyBuilder::insertIMulOp(Location loc, Value a, Value b) {
    LLVMSQLITE_ASSERT(a.getType().cast<mlir::LLVM::LLVMType>().isIntegerTy());
    LLVMSQLITE_ASSERT(b.getType().cast<mlir::LLVM::LLVMType>().isIntegerTy());

    return rewriter.create<mlir::LLVM::MulOp>(loc, a, b);
}

Value MyBuilder::insertISRemOp(Location loc, Value a, Value b) {
    LLVMSQLITE_ASSERT(a.getType().cast<mlir::LLVM::LLVMType>().isIntegerTy());
    LLVMSQLITE_ASSERT(b.getType().cast<mlir::LLVM::LLVMType>().isIntegerTy());

    return rewriter.create<mlir::LLVM::SRemOp>(loc, a, b);
}

Value MyBuilder::insertISubOp(Location loc, Value a, Value b) {
    LLVMSQLITE_ASSERT(a.getType().cast<mlir::LLVM::LLVMType>().isIntegerTy());
    LLVMSQLITE_ASSERT(b.getType().cast<mlir::LLVM::LLVMType>().isIntegerTy());

    return rewriter.create<mlir::LLVM::SubOp>(loc, a, b);
}

Value MyBuilder::insertSaveStack(Location loc) {
    return rewriter.create<mlir::LLVM::StackSaveOp>(loc, T::i8PtrTy);
}

void MyBuilder::insertRestoreStack(Location loc, Value stackState) {
    rewriter.create<mlir::LLVM::StackRestoreOp>(loc, stackState);
}

Value MyBuilder::insertAddOp(Location loc, Value a, Value b) {
    auto aTy = a.getType();
    auto bTy = b.getType();
    LLVMSQLITE_ASSERT(aTy == bTy);

    auto aTyLlvm = aTy.cast<LLVMType>();
    auto bTyLlvm = bTy.cast<LLVMType>();

    if (aTyLlvm.isIntegerTy()) {
        return insertIAddOp(loc, a, b);
    } else if (aTyLlvm.isFloatTy()) {
        return insertFAddOp(loc, a, b);
    } else {
        llvm_unreachable("insertAddOp: Couldn't determine what kind of operation to insert!");
    }
}

Value MyBuilder::insertMulOp(Location loc, Value a, Value b) {
    auto aTy = a.getType();
    auto bTy = b.getType();
    LLVMSQLITE_ASSERT(aTy == bTy);

    auto aTyLlvm = aTy.cast<LLVMType>();
    auto bTyLlvm = bTy.cast<LLVMType>();

    if (aTyLlvm.isIntegerTy()) {
        return insertIMulOp(loc, a, b);
    } else if (aTyLlvm.isFloatTy()) {
        return insertFMulOp(loc, a, b);
    } else {
        llvm_unreachable("insertMulOp: Couldn't determine what kind of operation to insert!");
    }
}

Value MyBuilder::insertSubOp(Location loc, Value a, Value b) {
    auto aTy = a.getType();
    auto bTy = b.getType();
    LLVMSQLITE_ASSERT(aTy == bTy);

    auto aTyLlvm = aTy.cast<LLVMType>();
    auto bTyLlvm = bTy.cast<LLVMType>();

    if (aTyLlvm.isIntegerTy()) {
        return insertISubOp(loc, a, b);
    } else if (aTyLlvm.isFloatTy()) {
        return insertFSubOp(loc, a, b);
    } else {
        llvm_unreachable("insertSubOp: Couldn't determine what kind of operation to insert!");
    }
}