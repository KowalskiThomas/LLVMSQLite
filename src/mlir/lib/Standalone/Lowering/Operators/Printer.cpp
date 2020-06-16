#include "Standalone/Lowering/Printer.h"
#include "Standalone/Utils.h"
#include "Standalone/TypeDefinitions.h"

PRINTER_USING
USING_OPS

#define ENABLE_PRINTER true

using namespace mlir::LLVM;

extern LLVMFuncOp f_printPtrAndValue;
extern LLVMFuncOp f_progress;
extern LLVMFuncOp f_printInt;
extern LLVMFuncOp f_printDouble;

size_t mlir::Printer::getBitWidth(Value x) const {
    static std::vector<size_t> possibleSizes { 1, 8, 16, 32, 64 };
    auto rightSize = 0llu;
    for(auto size : possibleSizes)
        if (x.getType().isInteger(size)
            || x.getType() == LLVMType::getIntNTy(d, size)) {
            rightSize = size;
            break;
        }

    if (rightSize == 0)
        x.dump();

    assert(rightSize > 0 && "Couldn't find bit-width of variable");
    return rightSize;
}

void mlir::Printer::printPtr(Location loc, size_t line, Value ptr, const char *msg, bool loadPtr) {
#if ENABLE_PRINTER
    auto& builder = rewriter;
    auto value = loadPtr ?
                    (Value)rewriter.create<mlir::LLVM::LoadOp>(loc, ptr) :
                    rewriter.create<mlir::LLVM::ConstantOp>(loc, T::i64Ty, rewriter.getI64IntegerAttr(0));
    auto extendedValue = rewriter.create<ZExtOp>(loc, T::i64Ty, value);

    auto msgAttr = rewriter.getI64IntegerAttr(reinterpret_cast<const uint64_t>(msg));
    auto lineAttr = rewriter.getI32IntegerAttr(line);
    auto fileNameAttr = rewriter.getI64IntegerAttr(reinterpret_cast<const uint64_t>(fileName));
    auto loadPtrAttr = rewriter.getIntegerAttr(rewriter.getIntegerType(1), loadPtr ? 1 : 0);

    rewriter.create<LLVM::CallOp>(loc, f_printPtrAndValue, ValueRange {
            rewriter.create<PtrToIntOp>(loc, T::i64Ty, ptr),
            extendedValue,
            rewriter.create<ConstantOp>(loc, T::i64Ty, msgAttr),
            rewriter.create<ConstantOp>(loc, T::i32Ty, lineAttr),
            rewriter.create<ConstantOp>(loc, T::i64Ty, fileNameAttr),
            rewriter.create<ConstantOp>(loc, T::i1Ty, loadPtrAttr)
    });
#endif
}

void mlir::Printer::printString(Location loc, size_t line, const char *msg) {
#if ENABLE_PRINTER
    auto msgAttr = rewriter.getI64IntegerAttr(reinterpret_cast<const uint64_t>(msg));
    auto lineAttr = rewriter.getI32IntegerAttr(line);
    auto fileNameAttr = rewriter.getI64IntegerAttr(reinterpret_cast<const uint64_t>(fileName));

    rewriter.create<LLVM::CallOp>(loc, f_progress, ValueRange {
            rewriter.create<ConstantOp>(loc, T::i64Ty, msgAttr),
            rewriter.create<ConstantOp>(loc, T::i32Ty, lineAttr),
            rewriter.create<ConstantOp>(loc, T::i64Ty, fileNameAttr)
    });
#endif
}

void mlir::Printer::printInt(Location loc, size_t line, Value v, const char *msg) {
#if ENABLE_PRINTER
    auto extended = rewriter.create<ZExtOp>(loc, T::i64Ty, v);
    auto msgAttr = rewriter.getI64IntegerAttr(reinterpret_cast<const uint64_t>(msg));
    auto lineAttr = rewriter.getI32IntegerAttr(line);
    auto fileNameAttr = rewriter.getI64IntegerAttr(reinterpret_cast<const uint64_t>(fileName));

    rewriter.create<LLVM::CallOp>(loc, f_printInt, ValueRange {
            rewriter.create<PtrToIntOp>(loc, T::i64Ty, extended),
            rewriter.create<ConstantOp>(loc, T::i64Ty, msgAttr),
            rewriter.create<ConstantOp>(loc, T::i32Ty, lineAttr),
            rewriter.create<ConstantOp>(loc, T::i64Ty, fileNameAttr)
    });
#endif
}

void mlir::Printer::printDouble(Location loc, size_t line, Value v, const char *msg) {
#if ENABLE_PRINTER
    auto msgAttr = rewriter.getI64IntegerAttr(reinterpret_cast<const uint64_t>(msg));
    auto lineAttr = rewriter.getI32IntegerAttr(line);
    auto fileNameAttr = rewriter.getI64IntegerAttr(reinterpret_cast<const uint64_t>(fileName));

    rewriter.create<mlir::LLVM::CallOp>(loc, f_printDouble, ValueRange {
            v,
            rewriter.create<ConstantOp>(loc, T::i64Ty, msgAttr),
            rewriter.create<ConstantOp>(loc, T::i32Ty, lineAttr),
            rewriter.create<ConstantOp>(loc, T::i64Ty, fileNameAttr)
    });
#endif
}

void mlir::Printer::operator()(Location loc, size_t line, Value v, const char *msg) {
#if ENABLE_PRINTER
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
#endif
}

void mlir::Printer::operator()(Location loc, size_t line, int v, const char* msg) {
    auto attr = rewriter.getI32IntegerAttr(v);
    auto cst = rewriter.create<mlir::LLVM::ConstantOp>(loc, T::i32Ty, attr);
    printInt(loc, line, cst, msg);
}

void mlir::Printer::operator()(Location loc, size_t line, size_t v, const char* msg) {
    auto attr = rewriter.getI64IntegerAttr(v);
    auto cst = rewriter.create<mlir::LLVM::ConstantOp>(loc, T::i64Ty, attr);
    printInt(loc, line, cst, msg);
}

void mlir::Printer::operator()(Location loc, size_t line, const char *msg) {
#if ENABLE_PRINTER
    printString(loc, line, msg);
#endif
}
