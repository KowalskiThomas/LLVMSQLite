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
LLVMFuncOp f_printInt;
LLVMFuncOp f_printPtrAndValue;
LLVMFuncOp f_allocateCursor;
LLVMFuncOp f_sqlite3BtreeCursor;
LLVMFuncOp f_sqlite3BtreeCursorHintFlags;
LLVMFuncOp f_sqlite3VdbeSorterRewind;
LLVMFuncOp f_sqlite3BtreeFirst;
LLVMFuncOp f_sqlite3VdbeCursorMoveto;
LLVMFuncOp f_sqlite3VdbeMemSetNull;
LLVMFuncOp f_sqlite3BtreePayloadSize;
LLVMFuncOp f_sqlite3BtreePayloadFetch;
LLVMFuncOp f_sqlite3GetVarint32;
LLVMFuncOp f_sqlite3VdbeOneByteSerialTypeLen;
LLVMFuncOp f_sqlite3VdbeSerialTypeLen;
LLVMFuncOp f_sqlite3VdbeMemRelease;
LLVMFuncOp f_sqlite3VdbeSerialGet;
LLVMFuncOp f_sqlite3VdbeMemGrow;
LLVMFuncOp f_sqlite3VdbeMemFromBtree;
LLVMFuncOp f_sqlite3VdbeCheckFk;
LLVMFuncOp f_sqlite3VdbeCloseStatement;
LLVMFuncOp f_sqlite3VdbeMemMakeWriteable;
LLVMFuncOp f_sqlite3VdbeMemNulTerminate;
LLVMFuncOp f_sqlite3BtreeNext;
LLVMFuncOp f_sqlite3VdbeHalt;
LLVMFuncOp f_sqlite3BtreeBeginTrans;
LLVMFuncOp f_sqlite3VtabSavepoint;
LLVMFuncOp f_sqlite3BtreeBeginStmt;
LLVMFuncOp f_out2Prerelease;
LLVMFuncOp f_sqlite3VdbeMemInit;
LLVMFuncOp f_sqlite3DbMallocRawNN;
LLVMFuncOp f_sqlite3VdbeMemSetInt64;
LLVMFuncOp f_sqlite3VdbeMemFinalize;
LLVMFuncOp f_sqlite3VdbeChangeEncoding;
LLVMFuncOp f_sqlite3VdbeMemShallowCopy;
LLVMFuncOp f_callXInversePtr;
LLVMFuncOp f_callXSFuncPtr;

LLVMFuncOp f_memCpy;

LLVMFuncOp f_debug;
LLVMFuncOp f_assert;

#define GENERATE_SYMBOL(ref_name, f, symbol_name) \
    auto builder = mlir::OpBuilder(m); \
    builder.setInsertionPointToStart(m.getBody()); \
    ref_name = builder.create<LLVMFuncOp>(m.getLoc(), symbol_name, funcTy, Linkage::External); \
    llvm::sys::DynamicLibrary::AddSymbol(symbol_name, reinterpret_cast<void*>(f));

extern "C" {
uint32_t add(uint32_t a, uint32_t b) {
    return a + b;
}

uint64_t printProgress(void *s, uint32_t line, const char* fileName) {
    llvm::outs() << "[" << fileName << " " << line << "] Msg: " << (char *) s << /* " (" << (uint64_t) (s) << ")" << */ "\n";
    llvm::outs().flush();
    return 0;
}

uint64_t printInt(void *ptr, void *s, uint32_t line, const char* fileName) {
    llvm::outs() << "[" << fileName << " " << line << "] Int: " << (char *) s << " " << (int64_t) (ptr) << " " << "\n";
    llvm::outs().flush();
    return 0;
}

uint64_t printPtrAndValue(void* ptr, void* value, void* msg, uint32_t line, const char* fileName) {
    llvm::outs() << "[" << fileName << " " << line << "] Ptr: " << (const char*)msg
                 << "Value = " << (uint64_t)value << " Ptr = " << (uint64_t)ptr << ", " << "\n";
    llvm::outs().flush();
    return 0;
}

void debug() {
    // This function should not be called but allows me to easily find where
    // a piece of code was translated in IR.
}

void my_assert(bool x, size_t line, const char* fileName) {
    if (!x) {
        llvm::outs() << "Assert false on " << fileName << ":" << line << "\n";
        llvm::outs().flush();
        llvm::outs() << "Assert evaluated to false!";
    }
}

}

void Prerequisites::generateReferenceToProgress(ModuleOp m, LLVMDialect *dialect) {
    auto funcTy = LLVMType::getFunctionTy(LLVMType::getVoidTy(dialect), {T::i64Ty, T::i32Ty, T::i64Ty}, false);
    auto builder = mlir::OpBuilder(m);
    builder.setInsertionPointToStart(m.getBody());
    f_progress = builder.create<LLVMFuncOp>(m.getLoc(), "printProgress", funcTy, Linkage::External);
    llvm::sys::DynamicLibrary::AddSymbol("printProgress", reinterpret_cast<void *>(printProgress));

    funcTy = LLVMType::getFunctionTy(LLVMType::getVoidTy(dialect), {T::i64Ty, T::i64Ty, T::i32Ty, T::i64Ty}, false);
    f_printInt = builder.create<LLVMFuncOp>(m.getLoc(), "printInt", funcTy, Linkage::External);
    llvm::sys::DynamicLibrary::AddSymbol("printInt", reinterpret_cast<void *>(printInt));

    funcTy = LLVMType::getFunctionTy(LLVMType::getVoidTy(dialect), {
            T::i64Ty, // ptr
            T::i64Ty, // value
            T::i64Ty, // message
            T::i32Ty, // line
            T::i64Ty  // filename
    }, false);

    f_printPtrAndValue = builder.create<LLVMFuncOp>(m.getLoc(), "printPtrAndValue", funcTy, Linkage::External);
    llvm::sys::DynamicLibrary::AddSymbol("printPtrAndValue", reinterpret_cast<void*>(printPtrAndValue));
}

void Prerequisites::generateReferenceToAllocateCursor(ModuleOp m, LLVMDialect *dialect) {
    auto funcTy = LLVMType::getFunctionTy(
            T::VdbeCursorPtrTy, {
                T::VdbePtrTy,
                T::i32Ty,
                T::i32Ty,
                T::i32Ty,
                T::i8Ty
            }, false);

    GENERATE_SYMBOL(f_allocateCursor, allocateCursor, "allocateCursor");
}

void Prerequisites::generateReferenceToSqlite3BtreeCursor(ModuleOp m, LLVMDialect *) {
    auto funcTy = LLVMType::getFunctionTy(
            T::i32Ty, {
                T::BtreePtrTy,
                T::i32Ty,
                T::i32Ty,
                T::KeyInfoPtrTy,
                T::BtCursorPtrTy
            }, false);

    GENERATE_SYMBOL(f_sqlite3BtreeCursor, sqlite3BtreeCursor, "sqlite3BtreeCursor")
}

void Prerequisites::generateReferenceToSqlite3BtreeCursorHintFlags(ModuleOp m, LLVMDialect *d) {
    auto funcTy = LLVMType::getFunctionTy(
            LLVMType::getVoidTy(d), {
                T::BtCursorPtrTy,
                T::i32Ty
            }, false);

    GENERATE_SYMBOL(f_sqlite3BtreeCursorHintFlags, sqlite3BtreeCursorHintFlags, "sqlite3BtreeCursorHintFlags")
}

void Prerequisites::generateReferenceTosqlite3VdbeSorterRewind(mlir::ModuleOp m, LLVMDialect *) {
    auto funcTy = LLVMType::getFunctionTy(
            T::i32Ty, {
                T::VdbeCursorPtrTy,
                T::i32PtrTy
            }, false);

    GENERATE_SYMBOL(f_sqlite3VdbeSorterRewind, sqlite3VdbeSorterRewind, "sqlite3VdbeSorterRewind");
}

void Prerequisites::generateReferenceTosqlite3BtreeFirst(ModuleOp m, LLVMDialect *) {
    auto funcTy = LLVMType::getFunctionTy(
            T::i32Ty, {
                T::BtCursorPtrTy,
                T::i32PtrTy
            }, false);

    GENERATE_SYMBOL(f_sqlite3BtreeFirst, sqlite3BtreeFirst, "sqlite3BtreeFirst");
}

void Prerequisites::generateReferenceTosqlite3VdbeCursorMoveto(ModuleOp m, LLVMDialect *) {
    auto funcTy = LLVMType::getFunctionTy(
            T::i32Ty, {
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
            LLVMType::getVoidTy(d), {
                T::sqlite3_valuePtrTy
            }, false);

    GENERATE_SYMBOL(f_sqlite3VdbeMemSetNull, sqlite3VdbeMemSetNull, "sqlite3VdbeMemSetNull")
}

void Prerequisites::generateReferenceTosqlite3BtreePayloadSize(mlir::ModuleOp m, LLVMDialect *) {
    auto funcTy = LLVMType::getFunctionTy(
            T::i32Ty, {
                T::BtCursorPtrTy
            }, false);

    GENERATE_SYMBOL(f_sqlite3BtreePayloadSize, sqlite3BtreePayloadSize, "sqlite3BtreePayloadSize")
}

void Prerequisites::generateReferenceTosqlite3BtreePayloadFetch(mlir::ModuleOp m, LLVMDialect *) {
    auto funcTy = LLVMType::getFunctionTy(
            T::i8PtrTy, {
                T::BtCursorPtrTy,
                T::i32PtrTy
            }, false);

    GENERATE_SYMBOL(f_sqlite3BtreePayloadFetch, sqlite3BtreePayloadFetch, "sqlite3BtreePayloadFetch")
}

void Prerequisites::generateReferenceTosqlite3GetVarint32(ModuleOp m, LLVMDialect *) {
    auto funcTy = LLVMType::getFunctionTy(
            T::i8Ty, {
                T::i8PtrTy,
                T::i32PtrTy
            }, false);

    GENERATE_SYMBOL(f_sqlite3GetVarint32, sqlite3GetVarint32, "sqlite3GetVarint32")
}

void Prerequisites::generateReferenceTosqlite3VdbeOneByteSerialTypeLen(ModuleOp m, LLVMDialect *) {
    auto funcTy = LLVMType::getFunctionTy(
            T::i8Ty, {
                T::i8Ty
            }, false);

    GENERATE_SYMBOL(f_sqlite3VdbeOneByteSerialTypeLen, sqlite3VdbeOneByteSerialTypeLen,
                    "sqlite3VdbeOneByteSerialTypeLen")
}

void Prerequisites::generateReferenceTosqlite3VdbeSerialTypeLen(ModuleOp m, LLVMDialect *) {
    auto funcTy = LLVMType::getFunctionTy(
            T::i32Ty, {
                T::i32Ty
            }, false);

    GENERATE_SYMBOL(f_sqlite3VdbeSerialTypeLen, sqlite3VdbeSerialTypeLen, "sqlite3VdbeSerialTypeLen")
}

void Prerequisites::generateReferenceTosqlite3VdbeMemRelease(ModuleOp m, LLVMDialect *d) {
    auto funcTy = LLVMType::getFunctionTy(
            LLVMType::getVoidTy(d), {
                T::sqlite3_valuePtrTy
            }, false);

    GENERATE_SYMBOL(f_sqlite3VdbeMemRelease, sqlite3VdbeMemRelease, "f_sqlite3VdbeMemRelease");
}

void Prerequisites::generateReferenceToAssert(ModuleOp m, LLVMDialect *d) {
    auto funcTy = LLVMType::getFunctionTy(
            LLVMType::getVoidTy(d), {
                T::i1Ty,
                T::i64Ty,
                T::i8PtrTy
            }, false);

    GENERATE_SYMBOL(f_assert, my_assert, "my_assert");
}

void Prerequisites::generateReferenceTosqlite3VdbeSerialGet(ModuleOp m, LLVMDialect *) {
    auto funcTy = LLVMType::getFunctionTy(
            T::i32Ty, {
                T::i8PtrTy,
                T::i32Ty,
                T::sqlite3_valuePtrTy
            }, false);

    GENERATE_SYMBOL(f_sqlite3VdbeSerialGet, sqlite3VdbeSerialGet, "sqlite3VdbeSerialGet");
}

void Prerequisites::generateReferenceTosqlite3VdbeMemGrow(ModuleOp m, LLVMDialect *d) {
    auto funcTy = LLVMType::getFunctionTy(
            T::i32Ty, {
                T::sqlite3_valuePtrTy, // pMem
                T::i32Ty, // n
                T::i32Ty  // preserve
            }, false);

    GENERATE_SYMBOL(f_sqlite3VdbeMemGrow, sqlite3VdbeMemGrow, "sqlite3VdbeMemGrow");
}

extern "C" {
    void * my_memcpy(void* dst, const void* src, unsigned int cnt)
    {
        char *pszDest = (char *)dst;
        const char *pszSource =( const char*)src;
        if((pszDest!= NULL) && (pszSource!= NULL))
        {
            while(cnt) //till cnt
            {
                //Copy byte by byte
                auto test = *pszSource;
                *(pszDest++)= *(pszSource++);
                --cnt;
            }
        }
        return dst;
    }
}

void Prerequisites::generateReferenceTomemCpy(ModuleOp m, LLVMDialect *d) {
    auto funcTy = LLVMType::getFunctionTy(
            T::i8PtrTy, {
                T::i8PtrTy, // dest
                T::i8PtrTy, // source
                T::i64Ty    // n
            }, false);

    GENERATE_SYMBOL(f_memCpy, my_memcpy, "my_memcpy");
}

void Prerequisites::generateReferenceTosqlite3VdbeMemFromBtree(ModuleOp m, LLVMDialect *d) {
    auto funcTy = LLVMType::getFunctionTy(
            T::i32Ty, {
                T::BtCursorPtrTy,
                T::i32Ty,
                T::i32Ty,
                T::sqlite3_valuePtrTy
            }, false);

    GENERATE_SYMBOL(f_sqlite3VdbeMemFromBtree, sqlite3VdbeMemFromBtree, "sqlite3VdbeMemFromBtree");
}

void Prerequisites::generateReferenceTosqlite3VdbeCheckFk(ModuleOp m, LLVMDialect *d) {
    auto funcTy = LLVMType::getFunctionTy(
            T::i32Ty, {
                T::VdbePtrTy,
                T::i32Ty,
            }, false);

    GENERATE_SYMBOL(f_sqlite3VdbeCheckFk, sqlite3VdbeCheckFk, "sqlite3VdbeCheckFk");
}

void Prerequisites::generateReferenceTosqlite3VdbeCloseStatement(ModuleOp m, LLVMDialect* d) {
    auto funcTy = LLVMType::getFunctionTy(
            T::i32Ty, {
                T::VdbePtrTy,
                T::i32Ty
            }, false);

    GENERATE_SYMBOL(f_sqlite3VdbeCloseStatement, sqlite3VdbeCloseStatement, "sqlite3VdbeCloseStatement");
}

void Prerequisites::generateReferenceTosqlite3VdbeMemMakeWriteable(ModuleOp m, LLVMDialect* d) {
    auto funcTy = LLVMType::getFunctionTy(
            T::i32Ty, {
                T::sqlite3_valuePtrTy
            }, false);

    GENERATE_SYMBOL(f_sqlite3VdbeMemMakeWriteable, sqlite3VdbeMemMakeWriteable, "sqlite3VdbeMemMakeWriteable");
}

void Prerequisites::generateReferenceTosqlite3VdbeMemNulTerminate(ModuleOp m, LLVMDialect* d) {
    auto funcTy = LLVMType::getFunctionTy(
            T::i32Ty, {
                T::sqlite3_valuePtrTy
            }, false);

    GENERATE_SYMBOL(f_sqlite3VdbeMemNulTerminate, sqlite3VdbeMemNulTerminate, "sqlite3VdbeMemNulTerminate");
}

void Prerequisites::generateReferenceTosqlite3BtreeNext(ModuleOp m, LLVMDialect* d) {
    auto funcTy = LLVMType::getFunctionTy(
            T::i32Ty, {
                T::BtCursorPtrTy,
                T::i32Ty
            }, false);

    GENERATE_SYMBOL(f_sqlite3BtreeNext, sqlite3BtreeNext, "sqlite3BtreeNext");
}

void Prerequisites::generateReferenceTosqlite3VdbeHalt(ModuleOp m, LLVMDialect* d) {
    auto funcTy = LLVMType::getFunctionTy(
            T::i32Ty, {
                T::VdbePtrTy
            }, false);

    GENERATE_SYMBOL(f_sqlite3VdbeHalt, sqlite3VdbeHalt, "sqlite3VdbeHalt");
}

void Prerequisites::generateReferenceTosqlite3BtreeBeginTrans(ModuleOp m, LLVMDialect* d) {
    auto funcTy = LLVMType::getFunctionTy(
            T::i32Ty, {
                T::BtreePtrTy,
                T::i32Ty,
                T::i32PtrTy
            }, false);

    GENERATE_SYMBOL(f_sqlite3BtreeBeginTrans, sqlite3BtreeBeginTrans, "sqlite3BtreeBeginTrans");
}

void Prerequisites::generateReferenceTosqlite3VtabSavepoint(ModuleOp m, LLVMDialect* d) {
    auto funcTy = LLVMType::getFunctionTy(
            T::i32Ty, {
                T::sqlite3PtrTy,
                T::i32Ty,
                T::i32Ty
            }, false);

    GENERATE_SYMBOL(f_sqlite3VtabSavepoint, sqlite3VtabSavepoint, "sqlite3VtabSavepoint");
}

void Prerequisites::generateReferenceTosqlite3BtreeBeginStmt(ModuleOp m, LLVMDialect* d) {
    auto funcTy = LLVMType::getFunctionTy(
            T::i32Ty, {
                T::BtreePtrTy,
                T::i32Ty
            }, false);

    GENERATE_SYMBOL(f_sqlite3BtreeBeginStmt, sqlite3BtreeBeginStmt, "sqlite3BtreeBeginStmt");
}

extern "C" {
    Mem *out2Prerelease(Vdbe *p, VdbeOp *pOp);
}

void Prerequisites::generateReferenceToout2Prerelease(ModuleOp m, LLVMDialect* d) {
    auto funcTy = LLVMType::getFunctionTy(
            T::sqlite3_valuePtrTy, {
                T::VdbePtrTy,
                T::VdbeOpPtrTy
            }, false);

    GENERATE_SYMBOL(f_out2Prerelease, out2Prerelease, "out2Prerelease");
}

void Prerequisites::generateReferenceTosqlite3VdbeMemInit(ModuleOp m, LLVMDialect* d) {
    auto funcTy = LLVMType::getFunctionTy(
            LLVMType::getVoidTy(d), {
                T::sqlite3_valuePtrTy,
                T::sqlite3PtrTy,
                T::i16Ty
            }, false);

    GENERATE_SYMBOL(f_sqlite3VdbeMemInit, sqlite3VdbeMemInit, "sqlite3VdbeMemInit");
}

void Prerequisites::generateReferenceTosqlite3DbMallocRawNN(ModuleOp m, LLVMDialect* d) {
    auto funcTy = LLVMType::getFunctionTy(
            T::i8PtrTy, {
                T::sqlite3PtrTy,
                T::i64Ty
            }, false);

    GENERATE_SYMBOL(f_sqlite3DbMallocRawNN, sqlite3DbMallocRawNN, "sqlite3DbMallocRawNN");
}

void Prerequisites::generateReferenceTosqlite3VdbeMemSetInt64(ModuleOp m, LLVMDialect* d) {
    auto funcTy = LLVMType::getFunctionTy(
            LLVMType::getVoidTy(d), {
                T::sqlite3_valuePtrTy,
                T::i64Ty
            }, false);

    GENERATE_SYMBOL(f_sqlite3VdbeMemSetInt64, sqlite3VdbeMemSetInt64, "sqlite3VdbeMemSetInt64");
}

void Prerequisites::generateReferenceTosqlite3VdbeMemFinalize(ModuleOp m, LLVMDialect* d) {
    auto funcTy = LLVMType::getFunctionTy(
            T::i32Ty, {
                T::sqlite3_valuePtrTy,
                T::FuncDefPtrTy
            }, false);

    GENERATE_SYMBOL(f_sqlite3VdbeMemFinalize, sqlite3VdbeMemFinalize, "sqlite3VdbeMemFinalize");
}

void Prerequisites::generateReferenceTosqlite3VdbeChangeEncoding(ModuleOp m, LLVMDialect* d) {
    auto funcTy = LLVMType::getFunctionTy(
            T::i32Ty, {
                T::sqlite3_valuePtrTy,
                T::i32Ty
            }, false);

    GENERATE_SYMBOL(f_sqlite3VdbeChangeEncoding, sqlite3VdbeChangeEncoding, "sqlite3VdbeChangeEncoding");
}

void Prerequisites::generateReferenceTosqlite3VdbeMemShallowCopy(ModuleOp m, LLVMDialect* d) {
    auto funcTy = LLVMType::getFunctionTy(
            LLVMType::getVoidTy(d), {
                T::sqlite3_valuePtrTy,
                T::sqlite3_valuePtrTy,
                T::i32Ty
            }, false);

    GENERATE_SYMBOL(f_sqlite3VdbeMemShallowCopy, sqlite3VdbeMemShallowCopy, "sqlite3VdbeMemShallowCopy");
}

extern "C" {
    typedef void (*XInversePtr)(sqlite3_context*, int, sqlite3_value**);
    void callXInversePtr(XInversePtr func, sqlite3_context* context, int i, sqlite3_value** value) {
        func(context, i, value);
    }
}

void Prerequisites::generateReferenceTocallXInversePtr(mlir::ModuleOp m, LLVMDialect * d) {
    static auto calleeType = LLVMType::getFunctionTy(
            LLVMType::getVoidTy(d), {
                    T::sqlite3_contextPtrTy,
                    T::i32Ty,
                    T::sqlite3_valuePtrPtrTy
            }, false);

    auto funcTy = LLVMType::getFunctionTy(
            LLVMType::getVoidTy(d), {
                    calleeType.getPointerTo(),
                    T::sqlite3_contextPtrTy,
                    T::i32Ty,
                    T::sqlite3_valuePtrPtrTy
            }, false);

    GENERATE_SYMBOL(f_callXInversePtr, callXInversePtr, "callXInversePtr");
}

extern "C" {
    typedef void (*XSFuncPtr)(sqlite3_context*, int, sqlite3_value**);
    void callXSFuncPtr(XSFuncPtr func, sqlite3_context* ctx, int argc, sqlite3_value** argv) {
        func(ctx, argc, argv);
    }
}

void Prerequisites::generateReferenceTocallXSFuncPtr(mlir::ModuleOp m, LLVMDialect* d) {
    static auto calleeType = LLVMType::getFunctionTy(
            LLVMType::getVoidTy(d), {
                    T::sqlite3_contextPtrTy,
                    T::i32Ty,
                    T::sqlite3_valuePtrPtrTy
            }, false);

    auto funcTy = LLVMType::getFunctionTy(
            LLVMType::getVoidTy(d), {
                    T::i64Ty,
                    T::sqlite3_contextPtrTy,
                    T::i32Ty,
                    T::sqlite3_valuePtrPtrTy
            }, false);

    GENERATE_SYMBOL(f_callXSFuncPtr, callXSFuncPtr, "callXSFuncPtr");

}

#undef GENERATE_SYMBOL
#define CALL_SYMBOL_GENERATOR(f) generateReferenceTo##f(m, dialect)

void Prerequisites::runPrerequisites(ModuleOp m, LLVMDialect *dialect) {
    CALL_SYMBOL_GENERATOR(Progress);
    CALL_SYMBOL_GENERATOR(AllocateCursor);
    CALL_SYMBOL_GENERATOR(Sqlite3BtreeCursor);
    CALL_SYMBOL_GENERATOR(Sqlite3BtreeCursorHintFlags);
    CALL_SYMBOL_GENERATOR(sqlite3VdbeSorterRewind);
    CALL_SYMBOL_GENERATOR(sqlite3BtreeFirst);
    CALL_SYMBOL_GENERATOR(sqlite3VdbeCursorMoveto);
    CALL_SYMBOL_GENERATOR(sqlite3VdbeMemSetNull);
    CALL_SYMBOL_GENERATOR(sqlite3BtreePayloadSize);
    CALL_SYMBOL_GENERATOR(sqlite3BtreePayloadFetch);
    CALL_SYMBOL_GENERATOR(sqlite3GetVarint32);
    CALL_SYMBOL_GENERATOR(sqlite3VdbeOneByteSerialTypeLen);
    CALL_SYMBOL_GENERATOR(sqlite3VdbeSerialTypeLen);
    CALL_SYMBOL_GENERATOR(sqlite3VdbeMemRelease);
    CALL_SYMBOL_GENERATOR(sqlite3VdbeSerialGet);
    CALL_SYMBOL_GENERATOR(sqlite3VdbeMemGrow);
    CALL_SYMBOL_GENERATOR(sqlite3VdbeMemFromBtree);
    CALL_SYMBOL_GENERATOR(sqlite3VdbeCheckFk);
    CALL_SYMBOL_GENERATOR(sqlite3VdbeCloseStatement);
    CALL_SYMBOL_GENERATOR(sqlite3VdbeMemMakeWriteable);
    CALL_SYMBOL_GENERATOR(sqlite3VdbeMemNulTerminate);
    CALL_SYMBOL_GENERATOR(sqlite3BtreeNext);
    CALL_SYMBOL_GENERATOR(sqlite3VdbeHalt);
    CALL_SYMBOL_GENERATOR(sqlite3BtreeBeginTrans);
    CALL_SYMBOL_GENERATOR(sqlite3VtabSavepoint);
    CALL_SYMBOL_GENERATOR(sqlite3BtreeBeginStmt);
    CALL_SYMBOL_GENERATOR(out2Prerelease);
    CALL_SYMBOL_GENERATOR(sqlite3VdbeMemInit);
    CALL_SYMBOL_GENERATOR(sqlite3DbMallocRawNN);
    CALL_SYMBOL_GENERATOR(sqlite3VdbeMemSetInt64);
    CALL_SYMBOL_GENERATOR(sqlite3VdbeMemFinalize);
    CALL_SYMBOL_GENERATOR(sqlite3VdbeChangeEncoding);
    CALL_SYMBOL_GENERATOR(sqlite3VdbeMemShallowCopy);
    CALL_SYMBOL_GENERATOR(callXInversePtr);
    CALL_SYMBOL_GENERATOR(callXSFuncPtr);

    CALL_SYMBOL_GENERATOR(memCpy);

    CALL_SYMBOL_GENERATOR(Debug);
    CALL_SYMBOL_GENERATOR(Assert);
}

#undef CALL_SYMBOL_GENERATOR
