#pragma once

#include <Standalone/AllIncludes.h>

namespace mlir {
    struct Printer {
        using PatternRewriter = mlir::PatternRewriter;
        using MLIRContext = mlir::MLIRContext;
        using Location = mlir::Location;
        using Value = mlir::Value;

        MLIRContext* ctx;
        OpBuilder& rewriter;
        const char* fileName;
        LLVMDialect* d;

        Printer(MLIRContext* ctx, OpBuilder& rewriter, const char* fileName)
                : ctx(ctx), rewriter(rewriter), fileName(fileName), d(ctx->getRegisteredDialect<LLVMDialect>())
        {
        }

        size_t getBitWidth(Value x) const {
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

        void printPtr(Location loc, size_t line, Value ptr, const char* msg, bool loadPtr = true) {
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

        void printString(Location loc, size_t line, const char* msg) {
            rewriter.create<LLVM::CallOp>(loc, f_progress, ValueRange {
                    rewriter.create<mlir::ConstantIntOp>(loc, reinterpret_cast<const uint64_t>(msg), 64),
                    rewriter.create<mlir::ConstantIntOp>(loc, line, 32),
                    rewriter.create<mlir::ConstantIntOp>(loc, reinterpret_cast<const uint64_t>(fileName), 64),
            });
        }

        void printInt(Location loc, size_t line, Value v, const char* msg) {
            auto extended = rewriter.create<ZExtOp>(loc, T::i64Ty, v);
            rewriter.create<mlir::LLVM::CallOp>(loc, f_printPtr, ValueRange {
                    rewriter.create<mlir::LLVM::PtrToIntOp>(loc, T::i64Ty, extended),
                    rewriter.create<mlir::ConstantIntOp>(loc, reinterpret_cast<const uint64_t>(msg), 64),
                    rewriter.create<mlir::ConstantIntOp>(loc, line, 32),
                    rewriter.create<mlir::ConstantIntOp>(loc, reinterpret_cast<const uint64_t>(fileName), 64)
            });
        }

        void operator()(Location loc, size_t line, Value v, const char* msg) {
            auto t = v.getType();
            if (t == T::i1Ty || t == T::i8Ty || t == T::i16Ty || t == T::i32Ty || t == T::i64Ty
                || false) {
                printInt(loc, line, v, msg);
            } else if (t == T::i1Ty.getPointerTo() || t == T::i8PtrTy || t == T::i16PtrTy || t == T::i32PtrTy
                       || t == T::i64PtrTy) {
                printPtr(loc, line, v, msg);
            } else {
                auto tAsLlvm = t.dyn_cast_or_null<mlir::LLVM::LLVMType>();
                if (tAsLlvm && tAsLlvm.isPointerTy()) {
                    printPtr(loc, line, v, msg, false);
                } else {
                    err("Can't work with type " << v.getType())
                    exit(10);
                }
            }
        }

        void operator()(Location loc, size_t line, const char* msg) {
            printString(loc, line, msg);
        }
    };
}
