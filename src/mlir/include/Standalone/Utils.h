#pragma once

/**
 * Returns the location for current file and line (to be used in contexts where we have a rewriter)
 */
#define LOC (rewriter.getFileLineColLoc(mlir::Identifier::get(__FILE__, ctx), __LINE__, 0))
#define LOCL LOC, __LINE__

/**
 * Returns the location for current file and line (to be used in contexts where we have a builder)
 */
#define LOCB (builder.getFileLineColLoc(mlir::Identifier::get(__FILE__, ctx), __LINE__, 0))

/**
 * Adds code to print a message at JIT run-time (to be used in contexts where we have a rewriter)
 */
#define PROGRESS(msg) { \
    rewriter.template create<mlir::LLVM::CallOp>(LOC, f_progress, mlir::ArrayRef<mlir::Value>{ \
    rewriter.template create<mlir::ConstantIntOp>(LOC, reinterpret_cast<const uint64_t>(msg), 64), \
    rewriter.template create<mlir::ConstantIntOp>(LOC, __LINE__, 32), \
    rewriter.template create<mlir::ConstantIntOp>(LOC, reinterpret_cast<const uint64_t>(__FILE_NAME__), 64) \
    }); \
}

/**
 * Adds code to print a message at JIT run-time (to be used in contexts where we have a builder)
 */
#define PROGRESSB(msg) { \
    builder.create<mlir::LLVM::CallOp>(LOCB, f_progress, mlir::ArrayRef<mlir::Value>{ \
    builder.create<mlir::ConstantIntOp>(LOCB, reinterpret_cast<const uint64_t>(msg), 64), \
    builder.create<mlir::ConstantIntOp>(LOCB, __LINE__, 32) \
    }); \
}

/**
 * Adds code to print a pointer at JIT run-time with a given message
 */
#define PROGRESS_PRINT_PTR(ptr, msg) { \
    builder.create<mlir::LLVM::CallOp>(LOCB, f_printInt, mlir::ArrayRef<mlir::Value>{ \
    builder.create<mlir::LLVM::PtrToIntOp>(LOCB, T::i64Ty, ptr), \
    builder.create<mlir::ConstantIntOp>(LOCB, reinterpret_cast<const uint64_t>(msg), 64), \
    builder.create<mlir::ConstantIntOp>(LOCB, __LINE__, 32), \
    rewriter.template create<mlir::ConstantIntOp>(LOC, reinterpret_cast<const uint64_t>(__FILE_NAME__), 64) \
    }); \
}

/**
 * Adds code to print an integer at JIT run-time with a given message.
 */
#define PROGRESS_PRINT_INT(i, msg) { \
    Value val = i; \
    if (!val.getType().isInteger(64)) { \
        val = builder.create<mlir::LLVM::ZExtOp>(LOCB, T::i64Ty, val); \
    } \
    builder.create<mlir::LLVM::CallOp>(LOCB, f_printInt, mlir::ArrayRef<mlir::Value>{ \
    val, \
    builder.create<mlir::ConstantIntOp>(LOCB, reinterpret_cast<const uint64_t>(msg), 64), \
    builder.create<mlir::ConstantIntOp>(LOCB, __LINE__, 32), \
    rewriter.template create<mlir::ConstantIntOp>(LOC, reinterpret_cast<const uint64_t>(__FILE_NAME__), 64) \
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


#define err(x) { \
    llvm::errs() << x << "\n"; \
    llvm::errs().flush(); \
}

/**
 * Creates a well-typed in-code pointer to a operation parameter (for operation at PC and parameter PARAMETER)
 */
#define PTR_TO_P1(PC) \
    rewriter.create<mlir::LLVM::IntToPtrOp>(LOC, T::i32PtrTy, \
        rewriter.create<mlir::ConstantIntOp>(LOC, (uint64_t)&vdbe->aOp[PC].p1, 64))

#define PTR_TO_P2(PC) \
    rewriter.create<mlir::LLVM::IntToPtrOp>(LOC, T::i32PtrTy, \
        rewriter.create<mlir::ConstantIntOp>(LOC, (uint64_t)&vdbe->aOp[PC].p2, 64))

#define PTR_TO_P3(PC) \
    rewriter.create<mlir::LLVM::IntToPtrOp>(LOC, T::i32PtrTy, \
        rewriter.create<mlir::ConstantIntOp>(LOC, (uint64_t)&vdbe->aOp[PC].p3, 64))

#define PTR_TO_P4(PC) \
    rewriter.create<mlir::LLVM::IntToPtrOp>(LOC, T::i32PtrTy, \
        rewriter.create<mlir::ConstantIntOp>(LOC, (uint64_t)&vdbe->aOp[PC].p4, 64))

#define PTR_TO_P5(PC) \
    rewriter.create<mlir::LLVM::IntToPtrOp>(LOC, T::i32PtrTy, \
        rewriter.create<mlir::ConstantIntOp>(LOC, (uint64_t)&vdbe->aOp[PC].p5, 64))


/**
 * Creates an well-typed in-code pointer to a register (sqlite3_value)
 */
#define PTR_TO_REGISTER(REG_IDX) \
    builder.create<mlir::LLVM::IntToPtrOp>(LOCB, \
        T::sqlite3_valuePtrTy, \
        builder.create<mlir::ConstantIntOp>(LOCB, \
            (uint64_t)&vdbeCtx->regInstances[REG_IDX], 64))

#define CONSTANT_INT(value, width) \
    builder.create<mlir::ConstantIntOp>(LOCB, (uint64_t)(value), width)

#define LLVM_CONSTANT_INT(ty, width, val) \
    builder.create<mlir::LLVM::ConstantOp>(LOC, ty, builder.getIntegerAttr(builder.getIntegerType(width), val))

#define CONSTANT_PTR(ptr) \
    builder.create<mlir::ConstantIntOp>(LOCB, (uint64_t)ptr, 64)

#define CONSTANT_PTR(ptrType, ptr) \
    rewriter.create<IntToPtrOp>(LOC, ptrType, CONSTANT_INT(ptr, 64));


/**
 * Macro used to define several variables widely used in rewriting passes, namely:
 * - vdbeDialect
 * - vdbeCtx
 * - vdbe
 * - llvmDialect
 * - parentModule
 * - ctx (the MLIRContext*)
 * - context = *ctx
 */
#define LOWERING_PASS_HEADER \
    auto* vdbeDialect = op->getContext()->getRegisteredDialect<mlir::standalone::StandaloneDialect>(); \
    assert(vdbeDialect && "Expected StandaloneDialect to be registered"); \
    auto* vdbeCtx = &vdbeDialect->vdbeContext; \
    auto* vdbe = vdbeCtx->vdbe; \
    auto *llvmDialect = op->getContext()->getRegisteredDialect<LLVM::LLVMDialect>(); \
    assert(llvmDialect && "Expected LLVMDialect to be registered"); \
    ModuleOp parentModule = op->getParentOfType<ModuleOp>(); \
    auto *ctx = llvmDialect->getContext(); \
    auto& context = *ctx;

#define LOWERING_NAMESPACE \
    using namespace mlir::LLVM; \
    using LoadOp = mlir::LLVM::LoadOp; \
    using CallOp = mlir::LLVM::CallOp; \
    using StoreOp = mlir::LLVM::StoreOp; \
    using OrOp = mlir::LLVM::OrOp; \
    using AndOp = mlir::LLVM::AndOp; \
    using AllocaOp = mlir::LLVM::AllocaOp; \
    using BranchOp = mlir::BranchOp; \
    using BitcastOp = mlir::LLVM::BitcastOp; \
    using IntToPtrOp = mlir::LLVM::IntToPtrOp; \
    using PtrToIntOp = mlir::LLVM::PtrToIntOp; \
    using CondBrOp = mlir::LLVM::CondBrOp; \
    using ICmpOp = mlir::LLVM::ICmpOp; \
    using Pred = mlir::LLVM::ICmpPredicate;

#define USING_OPS \
    using MLIRContext = mlir::MLIRContext; \
    using LLVMDialect = mlir::LLVM::LLVMDialect; \
    using Value = mlir::Value; \
    using Type = mlir::Type; \
    using Block = mlir::Block; \
    using Location = mlir::Location; \
    using ValueRange = mlir::ValueRange; \
    using LLVMType = mlir::LLVM::LLVMType; \
     \
    using LoadOp = mlir::LLVM::LoadOp; \
    using CallOp = mlir::LLVM::CallOp; \
    using StoreOp = mlir::LLVM::StoreOp; \
    using OrOp = mlir::LLVM::OrOp; \
    using AndOp = mlir::LLVM::AndOp; \
    using AllocaOp = mlir::LLVM::AllocaOp; \
    using BranchOp = mlir::BranchOp; \
    using LLVMFuncOp = mlir::LLVM::LLVMFuncOp; \
    using ICmpPredicate = mlir::LLVM::ICmpPredicate; \
    using ICmpOp = mlir::LLVM::ICmpOp; \
    using CondBrOp = mlir::LLVM::CondBrOp; \
    using GEPOp = mlir::LLVM::GEPOp; \
    using AddOp = mlir::LLVM::AddOp; \
    using PtrToIntOp = mlir::LLVM::PtrToIntOp; \
    using IntToPtrOp = mlir::LLVM::IntToPtrOp; \
    using BitcastOp = mlir::LLVM::BitcastOp; \




#define WIDTH_TO(target_width, val) \
    builder.create<mlir::LLVM::ZExtOp>(LOC, \
    mlir::LLVM::LLVMType::getIntNTy(llvmDialect, target_width), \
    val)

#define TO_I64(val) WIDTH_TO(64, val)

#define SPLIT_BLOCK rewriter.getBlock()->splitBlock(rewriter.getBlock()->end());
#define GO_BACK_TO(b) rewriter.setInsertionPointToEnd(b)


#define CALL_DEBUG { \
    rewriter.create<CallOp>(LOC, f_debug, mlir::ValueRange{}); \
}

#define EXIT_PASS_EARLY(with_call_to_debug) { \
    if (with_call_to_debug) { \
        CALL_DEBUG \
    } \
    rewriter.eraseOp(colOp); \
    err("QSDQSD EXIT EARLY"); \
    parentModule.dump(); \
    return success(); \
};

#define FIX_AND_EXIT \
    { \
        auto curBlock = rewriter.getBlock(); \
        auto& b = firstBlock; \
        while(b = b->getNextNode()) { \
            if (b == blockColumnEnd) \
                continue; \
            \
            if (b == curBlock) \
                continue; \
            \
            if (b->empty()) { \
                rewriter.setInsertionPointToStart(b); \
                rewriter.create<BranchOp>(LOC, blockColumnEnd); \
            } \
        } \
        rewriter.setInsertionPointToEnd(curBlock); \
        CALL_DEBUG \
        rewriter.create<BranchOp>(LOC, blockColumnEnd); \
        EXIT_PASS_EARLY(false) \
    }
