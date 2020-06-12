#pragma once

#include <Standalone/AllIncludes.h>

#define PRINTER_USING \
    using LLVMDialect = mlir::LLVM::LLVMDialect; \
    using LLVMType = mlir::LLVM::LLVMType; \
    using MLIRContext = mlir::MLIRContext; \
    using Location = mlir::Location; \
    using Value = mlir::Value;

namespace mlir {
    PRINTER_USING

    struct Printer {
        using PatternRewriter = mlir::PatternRewriter;

        MLIRContext* ctx;
        OpBuilder& rewriter;
        const char* fileName;
        LLVMDialect* d;

        Printer(MLIRContext* ctx, OpBuilder& rewriter, const char* fileName)
                : ctx(ctx), rewriter(rewriter), fileName(fileName), d(ctx->getRegisteredDialect<LLVMDialect>())
        {
        }

        size_t getBitWidth(Value x) const;

        void printPtr(Location loc, size_t line, Value ptr, const char* msg, bool loadPtr = true);

        void printString(Location loc, size_t line, const char* msg);

        void printInt(Location loc, size_t line, Value v, const char* msg);

        void printDouble(Location loc, size_t line, Value v, const char* msg);

        void operator()(Location loc, size_t line, Value v, const char* msg);

        void operator()(Location loc, size_t line, int v, const char* msg);

        void operator()(Location loc, size_t line, size_t v, const char* msg);

        void operator()(Location loc, size_t line, const char* msg);
    };
}
