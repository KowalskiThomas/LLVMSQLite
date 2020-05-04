#pragma once

#include "mlir/Target/LLVMIR.h"
#include "mlir/IR/Types.h"
#include "mlir/Dialect/LLVMIR/LLVMDialect.h"

using namespace mlir::LLVM;

extern LLVMFuncOp addFunction;
extern LLVMFuncOp progressFunction;
extern LLVMFuncOp printPtrFunction;

void initialiseTypeCache(LLVMDialect*);

struct Prerequisites {
    using LLVMDialect = mlir::LLVM::LLVMDialect;

public:
    static void generateTimesFunction(mlir::ModuleOp, LLVMDialect*);
    static void generateNewFunction(mlir::ModuleOp, LLVMDialect*);
    static void generateReferenceToAdd(mlir::ModuleOp, LLVMDialect*);
    static void generateReferenceToProgress(mlir::ModuleOp, LLVMDialect*);

    static void runPrerequisites(mlir::ModuleOp, LLVMDialect*);
};
