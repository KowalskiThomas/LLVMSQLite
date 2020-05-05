#pragma once

#include "mlir/Target/LLVMIR.h"
#include "mlir/IR/Types.h"
#include "mlir/Dialect/LLVMIR/LLVMDialect.h"

using namespace mlir::LLVM;

extern LLVMFuncOp addFunction;
extern LLVMFuncOp progressFunction;
extern LLVMFuncOp printPtrFunction;
extern LLVMFuncOp f_allocateCursor;
extern LLVMFuncOp f_sqlite3BtreeCursor;
extern LLVMFuncOp f_sqlite3BtreeCursorHintFlags;

void initialiseTypeCache(LLVMDialect*);

#define DECLARE_FUNCTION(name) static void generateReferenceTo##name(mlir::ModuleOp, LLVMDialect*);

struct Prerequisites {
    using LLVMDialect = mlir::LLVM::LLVMDialect;

public:
    static void generateNewFunction(mlir::ModuleOp, LLVMDialect*);
    static void generateReferenceToAdd(mlir::ModuleOp, LLVMDialect*);
    static void generateReferenceToProgress(mlir::ModuleOp, LLVMDialect*);

    DECLARE_FUNCTION(AllocateCursor);
    DECLARE_FUNCTION(Sqlite3BtreeCursor);
    DECLARE_FUNCTION(Sqlite3BtreeCursorHintFlags);

    static void runPrerequisites(mlir::ModuleOp, LLVMDialect*);
};
