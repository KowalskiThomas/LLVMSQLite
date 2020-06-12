#pragma once

#include "Standalone/AllIncludes.h"
#include <unordered_map>

#include "Utils.h"

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

    // The last result of OP_Compare
    mlir::Value iCompare;

    // The block with all the PC jumps
    mlir::Block* jumpsBlock;

    // The main JITted function
    mlir::FuncOp mainFunction;

    // The main JITted function's entry block
    mlir::Block* entryBlock;

    // The value of p (the VDBE instance)
    mlir::Value p;

    // The value of p->aMem
    mlir::Value aMem;

    // The value of p->aOp
    mlir::Value aOp;

    // The value of p->db
    mlir::Value db;
};
