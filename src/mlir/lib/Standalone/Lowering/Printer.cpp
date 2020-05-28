#include "Standalone/Lowering/Printer.h"
#include "Standalone/Utils.h"
#include "Standalone/TypeDefinitions.h"

PRINTER_USING
USING_OPS

extern LLVMFuncOp f_printPtrAndValue;
extern LLVMFuncOp f_progress;
extern LLVMFuncOp f_printInt;
extern LLVMFuncOp f_printDouble;

size_t mlir::Printer::getBitWidth(Value x) const {
    static std::vector<size_t> possibleSizes { 1, 8, 16, 32, 64 };
    auto rightSize = 0llu;
    for(auto size : possibleSizes)
        if (x.getType().isInteger(size)
            || x.getType() == LLVMType::getIntNTy(d, size) ) {
            rightSize = size;
            break;
        }

    assert(rightSize > 0);
    return rightSize;
}

void mlir::Printer::printPtr(Location loc, size_t line, Value ptr, const char *msg, bool loadPtr) {
    auto& builder = rewriter;
    auto value = loadPtr ?
                 (mlir::Value)rewriter.create<mlir::LLVM::LoadOp>(loc, ptr) :
                 CONSTANT_INT(0, 64);
    auto extended = rewriter.create<ZExtOp>(loc, T::i64Ty, value);

    rewriter.create<LLVM::CallOp>(loc, f_printPtrAndValue, ValueRange {
            rewriter.create<mlir::LLVM::PtrToIntOp>(loc, T::i64Ty, ptr),
            rewriter.create<mlir::ConstantIntOp>(loc, extended, 64),
            rewriter.create<mlir::ConstantIntOp>(loc, reinterpret_cast<const uint64_t>(msg), 64),
            rewriter.create<mlir::ConstantIntOp>(loc, line, 32),
            rewriter.create<mlir::ConstantIntOp>(loc, reinterpret_cast<const uint64_t>(fileName), 64)
    });
}

void mlir::Printer::printString(Location loc, size_t line, const char *msg) {
    rewriter.create<LLVM::CallOp>(loc, f_progress, ValueRange {
            rewriter.create<mlir::ConstantIntOp>(loc, reinterpret_cast<const uint64_t>(msg), 64),
            rewriter.create<mlir::ConstantIntOp>(loc, line, 32),
            rewriter.create<mlir::ConstantIntOp>(loc, reinterpret_cast<const uint64_t>(fileName), 64),
    });
}

void mlir::Printer::printInt(Location loc, size_t line, Value v, const char *msg) {
    auto extended = rewriter.create<ZExtOp>(loc, T::i64Ty, v);
    rewriter.create<mlir::LLVM::CallOp>(loc, f_printInt, ValueRange {
            rewriter.create<mlir::LLVM::PtrToIntOp>(loc, T::i64Ty, extended),
            rewriter.create<mlir::ConstantIntOp>(loc, reinterpret_cast<const uint64_t>(msg), 64),
            rewriter.create<mlir::ConstantIntOp>(loc, line, 32),
            rewriter.create<mlir::ConstantIntOp>(loc, reinterpret_cast<const uint64_t>(fileName), 64)
    });
}

void mlir::Printer::printDouble(Location loc, size_t line, Value v, const char *msg) {
    rewriter.create<mlir::LLVM::CallOp>(loc, f_printDouble, ValueRange {
            v,
            rewriter.create<mlir::ConstantIntOp>(loc, reinterpret_cast<const uint64_t>(msg), 64),
            rewriter.create<mlir::ConstantIntOp>(loc, line, 32),
            rewriter.create<mlir::ConstantIntOp>(loc, reinterpret_cast<const uint64_t>(fileName), 64)
    });
}

void mlir::Printer::operator()(Location loc, size_t line, Value v, const char *msg) {
    auto t = v.getType();
    if (t == T::i1Ty || t == T::i8Ty || t == T::i16Ty || t == T::i32Ty || t == T::i64Ty
        || false) {
        printInt(loc, line, v, msg);
    } else if (t == T::i1Ty.getPointerTo() || t == T::i8PtrTy || t == T::i16PtrTy || t == T::i32PtrTy
               || t == T::i64PtrTy) {
        printPtr(loc, line, v, msg);
    } else if (t == T::doubleTy) {
        printDouble(loc, line, v, msg);
    } else {
        auto tAsLlvm = t.dyn_cast_or_null<mlir::LLVM::LLVMType>();
        if (tAsLlvm && tAsLlvm.isPointerTy()) {
            printPtr(loc, line, v, msg, false);
        } else {
            err("Cannot work with type " << v.getType())
            exit(10);
        }
    }
}

void mlir::Printer::operator()(Location loc, size_t line, const char *msg) {
    printString(loc, line, msg);
}
