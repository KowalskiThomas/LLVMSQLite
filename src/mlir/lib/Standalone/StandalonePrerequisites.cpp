#include <llvm/Support/DynamicLibrary.h>
#include <Standalone/Utils.h>
#include "mlir/IR/Types.h"
#include "mlir/IR/TypeSupport.h"
#include "mlir/IR/Dialect.h"

#include "mlir/Target/LLVMIR.h"

#include "Standalone/StandalonePassManager.h"
#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"

using LLVMDialect = mlir::LLVM::LLVMDialect;

mlir::LLVM::LLVMFuncOp addFunction;
mlir::LLVM::LLVMFuncOp mulFunction;
mlir::LLVM::LLVMFuncOp progressFunction;
mlir::LLVM::LLVMFuncOp printPtrFunction;

extern "C" {
uint32_t add(uint32_t a, uint32_t b) {
    // llvm::outs() << "I have been called with " << a << " and " << b << "\n";
    return a + b;
}

uint64_t printProgress(void* s, uint32_t line) {
    llvm::outs() << "[" << line << "] Msg: " << (char*)s << " (" << (uint64_t)(s) << ")\n";
    llvm::outs().flush();
    return 0;
}

uint64_t printPtr(void* ptr, void* s, uint32_t line) {
    llvm::outs() << "[" << line << "] Ptr: " << (int64_t)(ptr) << " " << (char*)s << "\n";
    llvm::outs().flush();
    return 0;
}
}

void Prerequisites::generateTimesFunction(mlir::ModuleOp m, LLVMDialect* dialect) {
    using namespace mlir::LLVM;
    auto* ctx = dialect->getContext();

    auto i32Ty = T::i32Ty;
    auto funcTy = LLVMType::getFunctionTy(i32Ty, { i32Ty, i32Ty }, false);

    auto builder = mlir::OpBuilder(m);
    auto func = builder.create<mlir::LLVM::LLVMFuncOp>(
            builder.getUnknownLoc(),
            "times",
            funcTy,
            mlir::LLVM::Linkage::External);
    mulFunction = func;
    m.push_back(func);

    auto entry = func.addEntryBlock();

    auto args = func.args_begin();
    auto arg1 = args++;
    auto arg2 = args++;

    mlir::Value& val1 = *arg1;
    mlir::Value& val2 = *arg2;

    builder.setInsertionPointToStart(entry);
    mlir::Value result = builder.create<mlir::LLVM::MulOp>(LOCB, val1, val2);
    builder.create<mlir::LLVM::ReturnOp>(LOCB, result);
}

void Prerequisites::generateNewFunction(mlir::ModuleOp m, LLVMDialect*) {
    using namespace mlir::LLVM;

    auto i32Ty = T::i32Ty;
    auto regTy = T::sqlite3_valuePtrTy;

    auto funcTy = LLVMType::getFunctionTy(i32Ty, { regTy }, false);

    auto builder = mlir::OpBuilder(m);
    auto func = builder.create<mlir::LLVM::LLVMFuncOp>(
            builder.getUnknownLoc(),
            "myFunc",
            funcTy,
            mlir::LLVM::Linkage::External
    );
    m.push_back(func);
}

void Prerequisites::generateReferenceToAdd(mlir::ModuleOp m, LLVMDialect* dialect) {
    auto i32Ty = T::i32Ty;
    auto funcTy = LLVMType::getFunctionTy(i32Ty, { i32Ty, i32Ty }, false);
    auto builder = mlir::OpBuilder(m);
    builder.setInsertionPointToStart(m.getBody());
    addFunction = builder.create<LLVMFuncOp>(m.getLoc(), "add", funcTy, mlir::LLVM::Linkage::External);
    llvm::sys::DynamicLibrary::AddSymbol("add", reinterpret_cast<void *>(add));
}

void Prerequisites::generateReferenceToProgress(mlir::ModuleOp m, LLVMDialect* dialect) {
    static bool done = false;
    if (done) {
        return;
    }
    done = true;

    auto i32Ty = T::i32Ty;
    auto i64Ty = T::i64Ty;
    auto funcTy = LLVMType::getFunctionTy(LLVMType::getVoidTy(dialect), { i64Ty, i32Ty }, false);
    auto builder = mlir::OpBuilder(m);
    builder.setInsertionPointToStart(m.getBody());
    progressFunction = builder.create<LLVMFuncOp>(m.getLoc(), "printProgress", funcTy, mlir::LLVM::Linkage::External);
    llvm::sys::DynamicLibrary::AddSymbol("printProgress", reinterpret_cast<void *>(printProgress));

    funcTy = LLVMType::getFunctionTy(LLVMType::getVoidTy(dialect), { i64Ty, i64Ty, i32Ty }, false);
    printPtrFunction = builder.create<LLVMFuncOp>(m.getLoc(), "printPtr", funcTy, mlir::LLVM::Linkage::External);
    llvm::sys::DynamicLibrary::AddSymbol("printPtr", reinterpret_cast<void*>(printPtr));
}

void Prerequisites::runPrerequisites(mlir::ModuleOp m, LLVMDialect* dialect) {
    generateTimesFunction(m, dialect);
    generateNewFunction(m, dialect);
    generateReferenceToAdd(m, dialect);
    generateReferenceToProgress(m, dialect);
}
