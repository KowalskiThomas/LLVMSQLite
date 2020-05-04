#pragma once

#include <mlir/Pass/PassManager.h>
#include "mlir/IR/Dialect.h"
#include "mlir/IR/MLIRContext.h"
#include "mlir/InitAllDialects.h"
#include "mlir/InitAllPasses.h"
#include "mlir/Pass/Pass.h"
#include "mlir/Pass/Pass.h"
#include "mlir/Support/FileUtilities.h"
#include "mlir/Support/MlirOptMain.h"
#include "llvm/Support/CommandLine.h"
#include "mlir/Dialect/LLVMIR/LLVMDialect.h"
#include "mlir/Target/LLVMIR.h"
#include "llvm/Support/InitLLVM.h"
#include "llvm/Support/SourceMgr.h"
#include "llvm/Support/ToolOutputFile.h"
#include "mlir/Pass/Pass.h"

#include "Standalone/StandaloneDialect.h"
#include "Standalone/StandaloneOps.h"

namespace mlir {
    namespace LLVM {
        class LLVMDialect;
    } // namespace LLVM
} // namespace mlir

struct VdbeToLLVM : public mlir::PassWrapper<VdbeToLLVM, mlir::OperationPass<mlir::ModuleOp>> {
protected:
    using LLVMDialect = mlir::LLVM::LLVMDialect;

public:
    void runOnOperation() final;
};