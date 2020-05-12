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

using LLVMFuncOp = mlir::LLVM::LLVMFuncOp;
LLVMFuncOp addFunction;
LLVMFuncOp f_progress;
LLVMFuncOp f_printPtr;
LLVMFuncOp f_allocateCursor;
LLVMFuncOp f_sqlite3BtreeCursor;
LLVMFuncOp f_sqlite3BtreeCursorHintFlags;
LLVMFuncOp f_sqlite3VdbeSorterRewind;
LLVMFuncOp f_sqlite3BtreeFirst;
LLVMFuncOp f_sqlite3VdbeCursorMoveto;
LLVMFuncOp f_sqlite3VdbeMemSetNull;
LLVMFuncOp f_sqlite3BtreePayloadSize;
LLVMFuncOp f_sqlite3BtreePayloadFetch;
LLVMFuncOp f_debug;
LLVMFuncOp f_sqlite3GetVarint32;
LLVMFuncOp f_sqlite3VdbeOneByteSerialTypeLen;
LLVMFuncOp f_sqlite3VdbeSerialTypeLen;
LLVMFuncOp f_sqlite3VdbeMemRelease;
// mlir::LLVM::LLVMFuncOp f_assert;

#define GENERATE_SYMBOL(ref_name, f, symbol_name) \
    auto builder = mlir::OpBuilder(m); \
    builder.setInsertionPointToStart(m.getBody()); \
    ref_name = builder.create<LLVMFuncOp>(m.getLoc(), symbol_name, funcTy, Linkage::External); \
    llvm::sys::DynamicLibrary::AddSymbol(symbol_name, reinterpret_cast<void*>(f));

extern "C" {
uint32_t add(uint32_t a, uint32_t b) {
    return a + b;
}

uint64_t printProgress(void *s, uint32_t line) {
    llvm::outs() << "[" << line << "] Msg: " << (char *) s << " (" << (uint64_t) (s) << ")\n";
    llvm::outs().flush();
    return 0;
}

uint64_t printPtr(void *ptr, void *s, uint32_t line) {
    llvm::outs() << "[" << line << "] Ptr: " << (int64_t) (ptr) << " " << (char *) s << "\n";
    llvm::outs().flush();
    return 0;
}

void debug() {
    // This function should not be called but allows me to easily find where
    // a piece of code was translated in IR.
}

}

void Prerequisites::generateNewFunction(ModuleOp m, LLVMDialect *) {
    auto i32Ty = T::i32Ty;
    auto regTy = T::sqlite3_valuePtrTy;

    auto funcTy = LLVMType::getFunctionTy(i32Ty, {regTy}, false);

    auto builder = mlir::OpBuilder(m);
    auto func = builder.create<LLVMFuncOp>(
            builder.getUnknownLoc(),
            "myFunc",
            funcTy,
            Linkage::External
    );
    m.push_back(func);
}

void Prerequisites::generateReferenceToAdd(ModuleOp m, LLVMDialect *) {
    auto funcTy = LLVMType::getFunctionTy(T::i32Ty, {T::i32Ty, T::i32Ty}, false);
    auto builder = mlir::OpBuilder(m);
    builder.setInsertionPointToStart(m.getBody());
    addFunction = builder.create<LLVMFuncOp>(m.getLoc(), "add", funcTy, Linkage::External);
    llvm::sys::DynamicLibrary::AddSymbol("add", reinterpret_cast<void *>(add));
}

void Prerequisites::generateReferenceToProgress(ModuleOp m, LLVMDialect *dialect) {
    static bool done = false;
    if (done) {
        return;
    }
    done = true;

    auto i32Ty = T::i32Ty;
    auto i64Ty = T::i64Ty;
    auto funcTy = LLVMType::getFunctionTy(LLVMType::getVoidTy(dialect), {i64Ty, i32Ty}, false);
    auto builder = mlir::OpBuilder(m);
    builder.setInsertionPointToStart(m.getBody());
    f_progress = builder.create<LLVMFuncOp>(m.getLoc(), "printProgress", funcTy, Linkage::External);
    llvm::sys::DynamicLibrary::AddSymbol("printProgress", reinterpret_cast<void *>(printProgress));

    funcTy = LLVMType::getFunctionTy(LLVMType::getVoidTy(dialect), {i64Ty, i64Ty, i32Ty}, false);
    f_printPtr = builder.create<LLVMFuncOp>(m.getLoc(), "printPtr", funcTy, Linkage::External);
    llvm::sys::DynamicLibrary::AddSymbol("printPtr", reinterpret_cast<void *>(printPtr));
}


void Prerequisites::generateReferenceToAllocateCursor(ModuleOp m, LLVMDialect *dialect) {
    auto funcTy = LLVMType::getFunctionTy(T::VdbeCursorPtrTy,
                                          {T::VdbePtrTy, T::i32Ty, T::i32Ty, T::i32Ty, T::i8Ty},
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

void Prerequisites::generateReferenceToSqlite3BtreeCursorHintFlags(ModuleOp m, LLVMDialect *d) {
    auto funcTy = LLVMType::getFunctionTy(
            LLVMType::getVoidTy(d),
            {
                    T::BtCursorPtrTy,
                    T::i32Ty
            }, false
    );

    GENERATE_SYMBOL(f_sqlite3BtreeCursorHintFlags, sqlite3BtreeCursorHintFlags, "sqlite3BtreeCursorHintFlags")
}

void Prerequisites::generateReferenceTosqlite3VdbeSorterRewind(mlir::ModuleOp m, LLVMDialect *) {
    auto funcTy = LLVMType::getFunctionTy(
            T::i32Ty,
            {
                    T::VdbeCursorPtrTy,
                    T::i32PtrTy
            }, false);

    GENERATE_SYMBOL(f_sqlite3VdbeSorterRewind, sqlite3VdbeSorterRewind, "sqlite3VdbeSorterRewind");
}

void Prerequisites::generateReferenceTosqlite3BtreeFirst(ModuleOp m, LLVMDialect *) {
    auto funcTy = LLVMType::getFunctionTy(
            T::i32Ty,
            {
                    T::BtCursorPtrTy,
                    T::i32PtrTy
            }, false);

    GENERATE_SYMBOL(f_sqlite3BtreeFirst, sqlite3BtreeFirst, "sqlite3BtreeFirst");
}

void Prerequisites::generateReferenceTosqlite3VdbeCursorMoveto(ModuleOp m, LLVMDialect *) {
    auto funcTy = LLVMType::getFunctionTy(
            T::i32Ty,
            {
                    T::VdbeCursorPtrPtrTy,
                    T::i32PtrTy
            }, false);

    GENERATE_SYMBOL(f_sqlite3VdbeCursorMoveto, sqlite3VdbeCursorMoveto, "sqlite3VdbeCursorMoveto");
}

void Prerequisites::generateReferenceToDebug(ModuleOp m, LLVMDialect *d) {
    auto funcTy = LLVMType::getFunctionTy(LLVMType::getVoidTy(d), {}, false);
    GENERATE_SYMBOL(f_debug, debug, "debug");
}

void Prerequisites::generateReferenceTosqlite3VdbeMemSetNull(ModuleOp m, LLVMDialect *d) {
    auto funcTy = LLVMType::getFunctionTy(
            LLVMType::getVoidTy(d),
            {
                    T::sqlite3_valuePtrTy
            }, false);

    GENERATE_SYMBOL(f_sqlite3VdbeMemSetNull, sqlite3VdbeMemSetNull, "sqlite3VdbeMemSetNull")
}

void Prerequisites::generateReferenceTosqlite3BtreePayloadSize(mlir::ModuleOp m, LLVMDialect *) {
    auto funcTy = LLVMType::getFunctionTy(
            T::i32Ty,
            {
                    T::BtCursorPtrTy
            }, false);

    GENERATE_SYMBOL(f_sqlite3BtreePayloadSize, sqlite3BtreePayloadSize, "sqlite3BtreePayloadSize")
}

void Prerequisites::generateReferenceTosqlite3BtreePayloadFetch(mlir::ModuleOp m, LLVMDialect *) {
    auto funcTy = LLVMType::getFunctionTy(
            T::i8PtrTy,
            {
                    T::BtCursorPtrTy,
                    T::i32PtrTy
            }, false);

    GENERATE_SYMBOL(f_sqlite3BtreePayloadFetch, sqlite3BtreePayloadFetch, "sqlite3BtreePayloadFetch")
}

void Prerequisites::generateReferenceTosqlite3GetVarint32(ModuleOp m, LLVMDialect *) {
    auto funcTy = LLVMType::getFunctionTy(
            T::i8Ty,
            {
                T::i8PtrTy,
                T::i32PtrTy
            }, false);

    GENERATE_SYMBOL(f_sqlite3GetVarint32, sqlite3GetVarint32, "sqlite3GetVarint32")
}

void Prerequisites::generateReferenceTosqlite3VdbeOneByteSerialTypeLen(ModuleOp m, LLVMDialect *) {
    auto funcTy = LLVMType::getFunctionTy(
            T::i8Ty,
            {
                T::i8Ty
            }, false);

    GENERATE_SYMBOL(f_sqlite3VdbeOneByteSerialTypeLen, sqlite3VdbeOneByteSerialTypeLen, "sqlite3VdbeOneByteSerialTypeLen")
}

void Prerequisites::generateReferenceTosqlite3VdbeSerialTypeLen(ModuleOp m, LLVMDialect *) {
    auto funcTy = LLVMType::getFunctionTy(
            T::i32Ty,
            {
                T::i32Ty
            }, false);

    GENERATE_SYMBOL(f_sqlite3VdbeSerialTypeLen, sqlite3VdbeSerialTypeLen, "sqlite3VdbeSerialTypeLen")
}

void Prerequisites::generateReferenceTosqlite3VdbeMemRelease(ModuleOp m, LLVMDialect* d) {
    auto funcTy = LLVMType::getFunctionTy(
            LLVMType::getVoidTy(d),
            {
                T::sqlite3_valuePtrTy
            }, false);

    GENERATE_SYMBOL(f_sqlite3VdbeMemRelease, sqlite3VdbeMemRelease, "sqlite3VdbeMemRelease");
}

#define CALL_SYMBOL_GENERATOR(f) generateReferenceTo##f(m, dialect)

void Prerequisites::runPrerequisites(ModuleOp m, LLVMDialect *dialect) {
    generateNewFunction(m, dialect);
    CALL_SYMBOL_GENERATOR(Add);
    CALL_SYMBOL_GENERATOR(Progress);
    CALL_SYMBOL_GENERATOR(AllocateCursor);
    CALL_SYMBOL_GENERATOR(Sqlite3BtreeCursor);
    CALL_SYMBOL_GENERATOR(Sqlite3BtreeCursorHintFlags);
    CALL_SYMBOL_GENERATOR(sqlite3VdbeSorterRewind);
    CALL_SYMBOL_GENERATOR(sqlite3BtreeFirst);
    CALL_SYMBOL_GENERATOR(sqlite3VdbeCursorMoveto);
    CALL_SYMBOL_GENERATOR(Debug);
    CALL_SYMBOL_GENERATOR(sqlite3VdbeMemSetNull);
    CALL_SYMBOL_GENERATOR(sqlite3BtreePayloadSize);
    CALL_SYMBOL_GENERATOR(sqlite3BtreePayloadFetch);
    CALL_SYMBOL_GENERATOR(sqlite3GetVarint32);
    CALL_SYMBOL_GENERATOR(sqlite3VdbeOneByteSerialTypeLen);
    CALL_SYMBOL_GENERATOR(sqlite3VdbeSerialTypeLen);
    CALL_SYMBOL_GENERATOR(sqlite3VdbeMemRelease);
}
