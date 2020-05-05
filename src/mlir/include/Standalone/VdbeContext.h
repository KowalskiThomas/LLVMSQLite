#pragma once

#include "Standalone/AllIncludes.h"
#include <unordered_map>

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
    std::unordered_map<size_t, mlir::Block*> blocks;
    std::unordered_map<size_t, mlir::BranchOp> outBranches;
};
