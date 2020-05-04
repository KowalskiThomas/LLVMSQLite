#pragma once

/**
 * Returns the location for current file and line (to be used in contexts where we have a rewriter)
 */
#define LOC (rewriter.getFileLineColLoc(mlir::Identifier::get(__FILE__, ctx), __LINE__, 0))

/**
 * Returns the location for current file and line (to be used in contexts where we have a builder)
 */
#define LOCB (builder.getFileLineColLoc(mlir::Identifier::get(__FILE__, ctx), __LINE__, 0))

/**
 * Adds code to print a message at JIT run-time (to be used in contexts where we have a rewriter)
 */
#define PROGRESS(msg) { \
    rewriter.create<mlir::LLVM::CallOp>(LOC, progressFunction, mlir::ArrayRef<mlir::Value>{ \
    rewriter.create<mlir::ConstantIntOp>(LOC, reinterpret_cast<const uint64_t>(msg), 64), \
    rewriter.create<mlir::ConstantIntOp>(LOC, __LINE__, 32) \
    }); \
}

/**
 * Adds code to print a message at JIT run-time (to be used in contexts where we have a builder)
 */
#define PROGRESSB(msg) { \
    builder.create<mlir::LLVM::CallOp>(LOCB, progressFunction, mlir::ArrayRef<mlir::Value>{ \
    builder.create<mlir::ConstantIntOp>(LOCB, reinterpret_cast<const uint64_t>(msg), 64), \
    builder.create<mlir::ConstantIntOp>(LOCB, __LINE__, 32) \
    }); \
}

/**
 * Adds code to print a pointer at JIT run-time with a given message
 */
#define PROGRESS_PRINT_PTR(ptr, msg) { \
    builder.create<mlir::LLVM::CallOp>(LOCB, printPtrFunction, mlir::ArrayRef<mlir::Value>{ \
    builder.create<mlir::LLVM::PtrToIntOp>(LOCB, T::i64Ty, ptr), \
    builder.create<mlir::ConstantIntOp>(LOCB, reinterpret_cast<const uint64_t>(msg), 64), \
    builder.create<mlir::ConstantIntOp>(LOCB, __LINE__, 32) \
    }); \
}

/**
 * Adds code to print an integer at JIT run-time with a given message.
 */
#define PROGRESS_PRINT_INT(i, msg) { \
    builder.create<mlir::LLVM::CallOp>(LOCB, printPtrFunction, mlir::ArrayRef<mlir::Value>{ \
    i, \
    builder.create<mlir::ConstantIntOp>(LOCB, reinterpret_cast<const uint64_t>(msg), 64), \
    builder.create<mlir::ConstantIntOp>(LOCB, __LINE__, 32) \
    }); \
}

#define PROGRESS_PRINT_INT_REWRITER(i, msg) { \
    auto& builder = rewriter; \
    PROGRESS_PRINT_INT(i, msg) \
}

/**
 * Prints whatever is fed to it to llvm::outs()
 */
#define out(x) { \
    llvm::outs() << x << "\n"; \
    llvm::outs().flush(); \
}

/**
 * Creates a well-typed in-code pointer to a operation parameter (for operation at PC and parameter PARAMETER)
 */
#define PTR_TO_P1(PC) \
    rewriter.create<mlir::LLVM::IntToPtrOp>(LOC, T::i32PtrTy, \
        rewriter.create<mlir::ConstantIntOp>(LOC, (uint64_t)&vdbe->aOp[PC].p1, 64));

#define PTR_TO_P2(PC) \
    rewriter.create<mlir::LLVM::IntToPtrOp>(LOC, T::i32PtrTy, \
        rewriter.create<mlir::ConstantIntOp>(LOC, (uint64_t)&vdbe->aOp[PC].p2, 64));

#define PTR_TO_P3(PC) \
    rewriter.create<mlir::LLVM::IntToPtrOp>(LOC, T::i32PtrTy, \
        rewriter.create<mlir::ConstantIntOp>(LOC, (uint64_t)&vdbe->aOp[PC].p3, 64));

#define PTR_TO_P4(PC) \
    rewriter.create<mlir::LLVM::IntToPtrOp>(LOC, T::i32PtrTy, \
        rewriter.create<mlir::ConstantIntOp>(LOC, (uint64_t)&vdbe->aOp[PC].p4, 64));

#define PTR_TO_P5(PC) \
    rewriter.create<mlir::LLVM::IntToPtrOp>(LOC, T::i32PtrTy, \
        rewriter.create<mlir::ConstantIntOp>(LOC, (uint64_t)&vdbe->aOp[PC].p5, 64));


/**
 * Creates an well-typed in-code pointer to a register (sqlite3_value)
 */
#define PTR_TO_REGISTER(REG_IDX) \
    builder.create<mlir::LLVM::IntToPtrOp>(LOCB, \
        T::sqlite3_valuePtrTy, \
        builder.create<mlir::ConstantIntOp>(LOCB, \
            (uint64_t)&vdbeCtx->regInstances[REG_IDX], 64));

/**
 * Macro used to define several variables widely used in rewriting passes, namely:
 * - vdbeDialect
 * - vdbe
 * - llvmDialect
 * - parentModule
 * - ctx (the MLIRContext*)
 * - context = *ctx
 */
#define LOWERING_PASS_HEADER \
    auto* vdbeDialect = op->getContext()->getRegisteredDialect<mlir::standalone::StandaloneDialect>(); \
    assert(vdbeDialect && "Expected StandaloneDialect to be registered"); \
    auto* vdbe = vdbeDialect->vdbeContext.vdbe; \
    auto *llvmDialect = op->getContext()->getRegisteredDialect<LLVM::LLVMDialect>(); \
    assert(llvmDialect && "Expected LLVMDialect to be registered"); \
    ModuleOp parentModule = op->getParentOfType<ModuleOp>(); \
    auto *ctx = llvmDialect->getContext(); \
    auto& context = *ctx;

