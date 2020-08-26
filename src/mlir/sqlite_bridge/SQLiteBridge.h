#include "Standalone/Utils.h"

#define DO_NDEBUG false
#ifdef NDEBUG
#undef DO_NDEBUG
#define DO_NDEBUG true
#undef NDEBUG
#endif

#include "llvm/Support/InitLLVM.h"
#include "llvm/Support/TargetSelect.h"
#include "llvm/Support/raw_ostream.h"
#include "mlir/Pass/PassManager.h"
#include "mlir/IR/Dialect.h"
#include "mlir/IR/MLIRContext.h"
#include "mlir/InitAllDialects.h"
#include "mlir/InitAllPasses.h"
#include "mlir/Pass/Pass.h"
#include "mlir/Support/MlirOptMain.h"
#include "mlir/Target/LLVMIR.h"
#include "mlir/ExecutionEngine/ExecutionEngine.h"
#include "mlir/ExecutionEngine/OptUtils.h"
#include "mlir/IR/Module.h"

#if DO_NDEBUG
#define NDEBUG
#endif

class Vdbe;

extern const char* const JIT_MAIN_FN_NAME;
extern unsigned long long functionPreparationTime;
extern unsigned long long functionOptimisationTime;
extern unsigned long long functionCompilationTime;

extern "C" {
    int jitVdbeStep(Vdbe*);
}

void writeFunction(mlir::MLIRContext &context, mlir::LLVM::LLVMDialect *llvmDialect, mlir::ModuleOp &theModule);
int runJit(mlir::ModuleOp module, Vdbe*);
