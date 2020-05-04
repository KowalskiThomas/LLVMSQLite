#pragma once

#include "mlir/IR/Dialect.h"
#include "mlir/Target/LLVMIR.h"
#include "mlir/IR/Types.h"
#include "mlir/Dialect/LLVMIR/LLVMDialect.h"

#include "utils.h"

extern "C" {
    #include "src/sqlite3ext.h"
    #include "src/sqliteInt.h"
    #include "src/vdbe.h"
    #include "src/vdbeInt.h"
}

struct VdbeContext {
    // The VDBE we want to JIT
    Vdbe* vdbe;
    // The addresses of this VDBE's parameters
    // llvm::SmallVector<mlir::LLVM::ConstantOp, 128> registers;
    llvm::SmallVector<Mem*, 128> regInstances;
};
