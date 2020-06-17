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
 * Prints whatever is fed to it to llvm::outs()
 */
#define out(x) { \
    llvm::outs() << x << "\n"; \
    llvm::outs().flush(); \
}

#ifdef DEBUG_MACHINE
    #define debug(x) out(x)
#else
    #define debug(x)
#endif

#define err(x) { \
    llvm::errs() << x << "\n"; \
    llvm::errs().flush(); \
}

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
    using ZExtOp = mlir::LLVM::ZExtOp; \


#define SPLIT_BLOCK rewriter.getBlock()->splitBlock(rewriter.getBlock()->end());
#define GO_BACK_TO(b) rewriter.setInsertionPointToEnd(b);
#define SPLIT_GO_BACK_TO(b) SPLIT_BLOCK; GO_BACK_TO(b);

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

#define ALWAYS_ASSERT(x) if (!(x)) { (*(volatile int*)0) = 0; }
