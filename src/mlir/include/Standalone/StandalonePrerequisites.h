#pragma once

#include "mlir/Target/LLVMIR.h"
#include "mlir/IR/Types.h"
#include "mlir/Dialect/LLVMIR/LLVMDialect.h"

using namespace mlir::LLVM;
using ModuleOp = mlir::ModuleOp;

// TODO: Remove addFunction
extern LLVMFuncOp addFunction;
extern LLVMFuncOp f_progress;
extern LLVMFuncOp f_printPtr;
extern LLVMFuncOp f_allocateCursor;
extern LLVMFuncOp f_sqlite3BtreeCursor;
extern LLVMFuncOp f_sqlite3BtreeCursorHintFlags;
extern LLVMFuncOp f_sqlite3VdbeSorterRewind;
extern LLVMFuncOp f_sqlite3BtreeFirst;

void initialiseTypeCache(LLVMDialect*);

#define DECLARE_FUNCTION(name) static void generateReferenceTo##name(mlir::ModuleOp, LLVMDialect*);

struct Prerequisites {
    using LLVMDialect = mlir::LLVM::LLVMDialect;

public:
    // These are temporary
    static void generateNewFunction(ModuleOp, LLVMDialect*);
    static void generateReferenceToAdd(ModuleOp, LLVMDialect*);

    DECLARE_FUNCTION(Progress);
    DECLARE_FUNCTION(AllocateCursor);
    DECLARE_FUNCTION(Sqlite3BtreeCursor);
    DECLARE_FUNCTION(Sqlite3BtreeCursorHintFlags);
    DECLARE_FUNCTION(sqlite3VdbeSorterRewind);
    DECLARE_FUNCTION(sqlite3BtreeFirst);

    static void runPrerequisites(ModuleOp, LLVMDialect*);
};
