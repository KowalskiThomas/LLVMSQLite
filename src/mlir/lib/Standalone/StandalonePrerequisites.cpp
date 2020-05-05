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
mlir::LLVM::LLVMFuncOp progressFunction;
mlir::LLVM::LLVMFuncOp printPtrFunction;
mlir::LLVM::LLVMFuncOp f_allocateCursor;
mlir::LLVM::LLVMFuncOp f_sqlite3BtreeCursor;
mlir::LLVM::LLVMFuncOp f_sqlite3BtreeCursorHintFlags;

extern "C" {
uint32_t add(uint32_t a, uint32_t b) {
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

void Prerequisites::generateReferenceToAllocateCursor(mlir::ModuleOp m, LLVMDialect* dialect) {
    auto funcTy = LLVMType::getFunctionTy(T::VdbeCursorPtrTy,
            { T::VdbePtrTy, T::i32Ty, T::i32Ty, T::i32Ty, T::i8Ty },
            false);
    auto builder = mlir::OpBuilder(m);
    builder.setInsertionPointToStart(m.getBody());
    f_allocateCursor = builder.create<LLVMFuncOp>(m.getLoc(), "allocateCursor", funcTy, mlir::LLVM::Linkage::External);
    llvm::sys::DynamicLibrary::AddSymbol("allocateCursor", reinterpret_cast<void*>(allocateCursor));
}

void Prerequisites::generateReferenceToSqlite3BtreeCursor(mlir::ModuleOp m, LLVMDialect *) {
    auto funcTy = LLVMType::getFunctionTy(
            T::i32Ty,
            {
                T::BtreePtrTy,
                T::i32Ty,
                T::i32Ty,
                T::KeyInfoPtrTy,
                T::BtCursorPtrTy
                },
            false);
    auto builder = mlir::OpBuilder(m);
    builder.setInsertionPointToStart(m.getBody());
    f_sqlite3BtreeCursor = builder.create<LLVMFuncOp>(m.getLoc(), "sqlite3BtreeCursor", funcTy, mlir::LLVM::Linkage::External);
    err("Function type: ")
    funcTy.dump();
    llvm::sys::DynamicLibrary::AddSymbol("sqlite3BtreeCursor", reinterpret_cast<void*>(sqlite3BtreeCursor));
}

void Prerequisites::generateReferenceToSqlite3BtreeCursorHintFlags(mlir::ModuleOp m, LLVMDialect * d) {
    auto funcTy = LLVMType::getFunctionTy(
                mlir::LLVM::LLVMType::getVoidTy(d),
                {
                    T::BtCursorPtrTy,
                    T::i32Ty
                }, false
            );
    auto builder = mlir::OpBuilder(m);
    builder.setInsertionPointToStart(m.getBody());
    f_sqlite3BtreeCursorHintFlags = builder.create<LLVMFuncOp>(m.getLoc(), "sqlite3BtreeCursorHintFlags", funcTy, mlir::LLVM::Linkage::External);
    llvm::sys::DynamicLibrary::AddSymbol("sqlite3BtreeCursorHintFlags", reinterpret_cast<void*>(sqlite3BtreeCursorHintFlags));
}

void Prerequisites::runPrerequisites(mlir::ModuleOp m, LLVMDialect* dialect) {
    generateNewFunction(m, dialect);
    generateReferenceToAdd(m, dialect);
    generateReferenceToProgress(m, dialect);
    generateReferenceToAllocateCursor(m, dialect);
    generateReferenceToSqlite3BtreeCursor(m, dialect);
    generateReferenceToSqlite3BtreeCursorHintFlags(m, dialect);
}
