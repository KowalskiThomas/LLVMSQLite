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
mlir::LLVM::LLVMFuncOp f_progress;
mlir::LLVM::LLVMFuncOp f_printPtr;
mlir::LLVM::LLVMFuncOp f_allocateCursor;
mlir::LLVM::LLVMFuncOp f_sqlite3BtreeCursor;
mlir::LLVM::LLVMFuncOp f_sqlite3BtreeCursorHintFlags;

#define GENERATE_SYMBOL(ref_name, f, symbol_name) \
    auto builder = mlir::OpBuilder(m); \
    builder.setInsertionPointToStart(m.getBody()); \
    ref_name = builder.create<LLVMFuncOp>(m.getLoc(), symbol_name, funcTy, Linkage::External); \
    llvm::sys::DynamicLibrary::AddSymbol(symbol_name, reinterpret_cast<void*>(f));

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

void Prerequisites::generateNewFunction(ModuleOp m, LLVMDialect*) {
    auto i32Ty = T::i32Ty;
    auto regTy = T::sqlite3_valuePtrTy;

    auto funcTy = LLVMType::getFunctionTy(i32Ty, { regTy }, false);

    auto builder = mlir::OpBuilder(m);
    auto func = builder.create<LLVMFuncOp>(
            builder.getUnknownLoc(),
            "myFunc",
            funcTy,
            Linkage::External
    );
    m.push_back(func);
}

void Prerequisites::generateReferenceToAdd(ModuleOp m, LLVMDialect*) {
    auto funcTy = LLVMType::getFunctionTy(T::i32Ty, { T::i32Ty, T::i32Ty }, false);
    auto builder = mlir::OpBuilder(m);
    builder.setInsertionPointToStart(m.getBody());
    addFunction = builder.create<LLVMFuncOp>(m.getLoc(), "add", funcTy, Linkage::External);
    llvm::sys::DynamicLibrary::AddSymbol("add", reinterpret_cast<void *>(add));
}

void Prerequisites::generateReferenceToProgress(ModuleOp m, LLVMDialect* dialect) {
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
    f_progress = builder.create<LLVMFuncOp>(m.getLoc(), "printProgress", funcTy, Linkage::External);
    llvm::sys::DynamicLibrary::AddSymbol("printProgress", reinterpret_cast<void *>(printProgress));

    funcTy = LLVMType::getFunctionTy(LLVMType::getVoidTy(dialect), { i64Ty, i64Ty, i32Ty }, false);
    f_printPtr = builder.create<LLVMFuncOp>(m.getLoc(), "printPtr", funcTy, Linkage::External);
    llvm::sys::DynamicLibrary::AddSymbol("printPtr", reinterpret_cast<void*>(printPtr));
}



void Prerequisites::generateReferenceToAllocateCursor(ModuleOp m, LLVMDialect* dialect) {
    auto funcTy = LLVMType::getFunctionTy(T::VdbeCursorPtrTy,
            { T::VdbePtrTy, T::i32Ty, T::i32Ty, T::i32Ty, T::i8Ty },
            false);

    GENERATE_SYMBOL(f_allocateCursor, allocateCursor, "allocateCursor");
}

void Prerequisites::generateReferenceToSqlite3BtreeCursor(ModuleOp m, LLVMDialect *) {
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

    GENERATE_SYMBOL(f_sqlite3BtreeCursor, sqlite3BtreeCursor, "sqlite3BtreeCursor")
}

void Prerequisites::generateReferenceToSqlite3BtreeCursorHintFlags(ModuleOp m, LLVMDialect * d) {
    auto funcTy = LLVMType::getFunctionTy(
                LLVMType::getVoidTy(d),
                {
                    T::BtCursorPtrTy,
                    T::i32Ty
                }, false
            );

    GENERATE_SYMBOL(f_sqlite3BtreeCursorHintFlags, sqlite3BtreeCursorHintFlags, "sqlite3BtreeCursorHintFlags")
}

void Prerequisites::runPrerequisites(ModuleOp m, LLVMDialect* dialect) {
    generateNewFunction(m, dialect);
    generateReferenceToAdd(m, dialect);
    generateReferenceToProgress(m, dialect);
    generateReferenceToAllocateCursor(m, dialect);
    generateReferenceToSqlite3BtreeCursor(m, dialect);
    generateReferenceToSqlite3BtreeCursorHintFlags(m, dialect);
}
