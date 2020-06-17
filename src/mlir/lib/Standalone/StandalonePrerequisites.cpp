#include <llvm/Support/DynamicLibrary.h>
#include <mlir/IR/Dialect.h>
#include <mlir/IR/Attributes.h>
#include <mlir/Target/LLVMIR.h>

#include "Standalone/StandalonePassManager.h"
#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"

#ifdef ExternFuncOp
#undef ExternFuncOp
#endif

using LLVMDialect = mlir::LLVM::LLVMDialect;
using LLVMFuncOp = mlir::LLVM::LLVMFuncOp;

LLVMFuncOp f_progress;
LLVMFuncOp f_printInt;
LLVMFuncOp f_printPtrAndValue;
LLVMFuncOp f_printDouble;
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
// LLVMFuncOp f_out2Prerelease;
LLVMFuncOp f_sqlite3VdbeMemInit;
LLVMFuncOp f_sqlite3DbMallocRawNN;
LLVMFuncOp f_sqlite3VdbeMemSetInt64;
LLVMFuncOp f_sqlite3VdbeMemFinalize;
LLVMFuncOp f_sqlite3VdbeChangeEncoding;
LLVMFuncOp f_sqlite3VdbeMemShallowCopy;
LLVMFuncOp f_callXInversePtr;
LLVMFuncOp f_callXSFuncPtr;
LLVMFuncOp f_sqlite3BtreeFakeValidCursor;
LLVMFuncOp f_sqlite3VdbeSorterWrite;
LLVMFuncOp f_sqlite3VdbeMemExpandBlob;
LLVMFuncOp f_sqlite3VdbeSorterRowkey;
LLVMFuncOp f_sqlite3VdbeSorterNext;
LLVMFuncOp f_sqlite3MemCompare;
LLVMFuncOp f_sqlite3VdbeSorterInit;
LLVMFuncOp f_applyAffinity;
LLVMFuncOp f_sqlite3VarintLen;
LLVMFuncOp f_sqlite3VdbeMemClearAndResize;
LLVMFuncOp f_sqlite3PutVarint;
LLVMFuncOp f_sqlite3VdbeSerialPut;
LLVMFuncOp f_sqlite3BtreeCursorIsValid;
LLVMFuncOp f_sqlite3VdbeExec2;
LLVMFuncOp f_sqlite3VdbeMemMove;
LLVMFuncOp f_numericType;
LLVMFuncOp f_sqlite3AddInt64;
LLVMFuncOp f_sqlite3SubInt64;
LLVMFuncOp f_sqlite3MulInt64;
LLVMFuncOp f_sqlite3VdbeRealValue;
LLVMFuncOp f_sqlite3IsNaN;
LLVMFuncOp f_applyNumericAffinity;
LLVMFuncOp f_sqlite3VdbeMemStringify;
LLVMFuncOp f_sqlite3VdbeMemTooBig;
LLVMFuncOp f_sqlite3VdbeBooleanValue;
LLVMFuncOp f_sqlite3_value_text;
LLVMFuncOp f_sqlite3VdbeError;
LLVMFuncOp f_out2PrereleaseWithClear;
LLVMFuncOp f_computeNumericType;
LLVMFuncOp f_sqlite3BtreeClearTable;
LLVMFuncOp f_sqlite3VdbeIncrWriteCounter;
LLVMFuncOp f_sqlite3BtreeIntegerKey;
LLVMFuncOp f_sqlite3BtreeDelete;
LLVMFuncOp f_sqlite3VdbeCursorRestore;
LLVMFuncOp f_sqlite3VdbeIdxRowid;

LLVMFuncOp f_memCpy;

LLVMFuncOp f_debug;
LLVMFuncOp f_assert;

#define DECLARE_FUNCTION(name) static void generateReferenceTo##name(ModuleOp m, LLVMDialect* d);

struct Prerequisites {
    using LLVMDialect = mlir::LLVM::LLVMDialect;

public:
    DECLARE_FUNCTION(AllocateCursor);
    DECLARE_FUNCTION(Sqlite3BtreeCursor);
    DECLARE_FUNCTION(Sqlite3BtreeCursorHintFlags);
    DECLARE_FUNCTION(sqlite3VdbeSorterRewind);
    DECLARE_FUNCTION(sqlite3BtreeFirst);
    DECLARE_FUNCTION(sqlite3VdbeCursorMoveto);
    DECLARE_FUNCTION(sqlite3VdbeMemSetNull);
    DECLARE_FUNCTION(sqlite3BtreePayloadSize);
    DECLARE_FUNCTION(sqlite3BtreePayloadFetch);
    DECLARE_FUNCTION(sqlite3GetVarint32);
    DECLARE_FUNCTION(sqlite3VdbeOneByteSerialTypeLen);
    DECLARE_FUNCTION(sqlite3VdbeSerialTypeLen);
    DECLARE_FUNCTION(sqlite3VdbeMemRelease);
    DECLARE_FUNCTION(sqlite3VdbeSerialGet);
    DECLARE_FUNCTION(sqlite3VdbeMemGrow);
    DECLARE_FUNCTION(sqlite3VdbeMemFromBtree);
    DECLARE_FUNCTION(sqlite3VdbeCheckFk);
    DECLARE_FUNCTION(sqlite3VdbeCloseStatement);
    DECLARE_FUNCTION(sqlite3VdbeMemMakeWriteable);
    DECLARE_FUNCTION(sqlite3VdbeMemNulTerminate);
    DECLARE_FUNCTION(sqlite3BtreeNext);
    DECLARE_FUNCTION(sqlite3VdbeHalt);
    DECLARE_FUNCTION(sqlite3BtreeBeginTrans);
    DECLARE_FUNCTION(sqlite3VtabSavepoint);
    DECLARE_FUNCTION(sqlite3BtreeBeginStmt);
    DECLARE_FUNCTION(out2Prerelease);
    DECLARE_FUNCTION(out2PrereleaseWithClear);
    DECLARE_FUNCTION(sqlite3VdbeMemInit);
    DECLARE_FUNCTION(sqlite3DbMallocRawNN);
    DECLARE_FUNCTION(sqlite3VdbeMemSetInt64);
    DECLARE_FUNCTION(sqlite3VdbeMemFinalize);
    DECLARE_FUNCTION(sqlite3VdbeChangeEncoding);
    DECLARE_FUNCTION(sqlite3VdbeMemShallowCopy);
    DECLARE_FUNCTION(callXInversePtr);
    DECLARE_FUNCTION(callXSFuncPtr);
    DECLARE_FUNCTION(sqlite3BtreeFakeValidCursor);
    DECLARE_FUNCTION(sqlite3VdbeSorterWrite);
    DECLARE_FUNCTION(sqlite3VdbeMemExpandBlob);
    DECLARE_FUNCTION(sqlite3VdbeSorterRowkey);
    DECLARE_FUNCTION(sqlite3VdbeSorterNext);
    DECLARE_FUNCTION(sqlite3MemCompare);
    DECLARE_FUNCTION(sqlite3VdbeSorterInit);
    DECLARE_FUNCTION(applyAffinity);
    DECLARE_FUNCTION(sqlite3VarintLen);
    DECLARE_FUNCTION(sqlite3VdbeMemClearAndResize);
    DECLARE_FUNCTION(sqlite3PutVarint);
    DECLARE_FUNCTION(sqlite3VdbeSerialPut);
    DECLARE_FUNCTION(sqlite3BtreeCursorIsValid);
    DECLARE_FUNCTION(sqlite3VdbeExec2);
    DECLARE_FUNCTION(sqlite3VdbeMemMove);
    DECLARE_FUNCTION(numericType);
    DECLARE_FUNCTION(sqlite3AddInt64);
    DECLARE_FUNCTION(sqlite3SubInt64);
    DECLARE_FUNCTION(sqlite3MulInt64);
    DECLARE_FUNCTION(sqlite3VdbeRealValue);
    DECLARE_FUNCTION(sqlite3IsNaN);
    DECLARE_FUNCTION(applyNumericAffinity);
    DECLARE_FUNCTION(sqlite3VdbeMemStringify);
    DECLARE_FUNCTION(sqlite3VdbeMemTooBig);
    DECLARE_FUNCTION(sqlite3VdbeBooleanValue);
    DECLARE_FUNCTION(sqlite3VdbeError);
    DECLARE_FUNCTION(sqlite3_value_text);
    DECLARE_FUNCTION(computeNumericType);
    DECLARE_FUNCTION(sqlite3BtreeClearTable);
    DECLARE_FUNCTION(sqlite3VdbeIncrWriteCounter);
    DECLARE_FUNCTION(sqlite3BtreeIntegerKey);
    DECLARE_FUNCTION(sqlite3BtreeDelete);
    DECLARE_FUNCTION(sqlite3VdbeIdxRowid);
    DECLARE_FUNCTION(sqlite3VdbeCursorRestore);

    DECLARE_FUNCTION(memCpy);

    DECLARE_FUNCTION(Debug);
    DECLARE_FUNCTION(Assert);

    DECLARE_FUNCTION(Progress);


    static void runPrerequisites(ModuleOp, LLVMDialect*);
};

#undef DECLARE_FUNCTION

#define GENERATE_SYMBOL_ATTR(ref_name, f, symbol_name, passthroughAttrs) \
    auto builder = mlir::OpBuilder(m); \
    builder.setInsertionPointToStart(m.getBody()); \
    auto ctx = d->getContext(); \
    auto passthrough = llvm::SmallVector<mlir::Attribute, 16>{}; \
    for(auto s : llvm::SmallVector<const char*, 16>(passthroughAttrs)) { \
        passthrough.push_back({mlir::StringAttr::get(s, ctx)}); \
    } \
    auto attrs = llvm::SmallVector<mlir::NamedAttribute, 16>{ \
        mlir::NamedAttribute { \
            mlir::Identifier::get("passthrough", ctx), \
            mlir::ArrayAttr::get(passthrough, ctx) \
        } \
    }; \
    ref_name = builder.create<LLVMFuncOp>(m.getLoc(), symbol_name, funcTy, Linkage::External, attrs); \
    llvm::sys::DynamicLibrary::AddSymbol(symbol_name, reinterpret_cast<void*>(f));

llvm::SmallVector<const char*, 16> DEFAULT_ATTRS = {"uwtable", "nonlazybind", "nonfree", "nounwind", "norecurse", "willreturn"};
#define GENERATE_SYMBOL(ref_name, f, symbol_name) GENERATE_SYMBOL_ATTR(ref_name, f, symbol_name, DEFAULT_ATTRS)

extern "C" {
uint32_t add(uint32_t a, uint32_t b) {
    return a + b;
}

#define HIDE_OPCODE_START true

uint64_t printProgress(const char* s, uint32_t line, const char* fileName) {
    static const char* huntedMessage = nullptr;
    if (huntedMessage && strstr(s, huntedMessage) != nullptr) {
        out("Found hunted message! " << s);
    }
#if HIDE_OPCODE_START
    if (strstr(s, "-- ") == s)
        return 1;
#endif

    static auto& outs = llvm::outs();
    outs << "[" << fileName << ":" << line << "] " << s << /* " (" << (uint64_t) (s) << ")" << */ "\n";
    outs.flush();

    if(strstr(s, "TODO")) {
        err("Warning: a TODO has been emitted!");
        exit(128);
    }

    return 0;
}

uint64_t printInt(uint64_t i, char *s, uint32_t line, const char* fileName) {
    llvm::outs() << "[" << fileName << ":" << line << "] " << (char *) s << " " << (int64_t) (i) << " " << "\n";
    llvm::outs().flush();
    return 0;
}

uint64_t printDouble(double d, void *s, uint32_t line, const char* fileName) {
    llvm::outs() << "[" << fileName << ":" << line << "] " << (char *) s << " " << (double) (d) << " " << "\n";
    llvm::outs().flush();
    return 0;
}

uint64_t printPtrAndValue(void* ptr, void* value, void* msg, uint32_t line, const char* fileName, bool pointerLoaded) {
    if (pointerLoaded) {
        llvm::outs() << "[" << fileName << ":" << line << "] " << (const char*)msg << " "
                     << "Value = " << (uint64_t)value << " Ptr = " << (uint64_t)ptr << "\n";
    } else {
        llvm::outs() << "[" << fileName << ":" << line << "] " << (const char*)msg << " "
                     << " Ptr = " << (uint64_t)ptr << "\n";
    }
    llvm::outs().flush();
    return 0;
}

void dbg() {
    // This function should not be called but allows me to easily find where
    // a piece of code was translated in IR.
}

void my_assert(bool x, size_t line, const char* fileName) {
    if (!x) {
        llvm::outs() << "Assert false on " << fileName << ":" << line << "\n";
        llvm::outs().flush();
        llvm::outs() << "Assert evaluated to false!\n";
        llvm_unreachable("Assert evaluated to false");
    }
}

}

void Prerequisites::generateReferenceToProgress(ModuleOp m, LLVMDialect *d) {
    auto funcTy = LLVMType::getFunctionTy(T::voidTy, {T::i64Ty, T::i32Ty, T::i64Ty}, false);
    auto builder = mlir::OpBuilder(m);
    builder.setInsertionPointToStart(m.getBody());
    f_progress = builder.create<LLVMFuncOp>(m.getLoc(), "printProgress", funcTy, Linkage::External);
    llvm::sys::DynamicLibrary::AddSymbol("printProgress", reinterpret_cast<void *>(printProgress));

    funcTy = LLVMType::getFunctionTy(T::voidTy, {T::i64Ty, T::i64Ty, T::i32Ty, T::i64Ty}, false);
    f_printInt = builder.create<LLVMFuncOp>(m.getLoc(), "printInt", funcTy, Linkage::External);
    llvm::sys::DynamicLibrary::AddSymbol("printInt", reinterpret_cast<void *>(printInt));

    funcTy = LLVMType::getFunctionTy(T::voidTy, {T::doubleTy, T::i64Ty, T::i32Ty, T::i64Ty}, false);
    f_printDouble = builder.create<LLVMFuncOp>(m.getLoc(), "printDouble", funcTy, Linkage::External);
    llvm::sys::DynamicLibrary::AddSymbol("printDouble", reinterpret_cast<void *>(printDouble));

    funcTy = LLVMType::getFunctionTy(T::voidTy, {
            T::i64Ty, // ptr
            T::i64Ty, // value
            T::i64Ty, // message
            T::i32Ty, // line
            T::i64Ty, // filename
            T::i1Ty,  // whether the value has been loaded
    }, false);

    f_printPtrAndValue = builder.create<LLVMFuncOp>(m.getLoc(), "printPtrAndValue", funcTy, Linkage::External);

    llvm::sys::DynamicLibrary::AddSymbol("printPtrAndValue", reinterpret_cast<void*>(printPtrAndValue));
}

void Prerequisites::generateReferenceToAllocateCursor(ModuleOp m, LLVMDialect *d) {
    auto funcTy = LLVMType::getFunctionTy(
            T::VdbeCursorPtrTy, {
                T::VdbePtrTy,
                T::i32Ty,
                T::i32Ty,
                T::i32Ty,
                T::i8Ty
            }, false);

    GENERATE_SYMBOL_ATTR(f_allocateCursor, allocateCursor, "allocateCursor", DEFAULT_ATTRS);
    llvm::sys::DynamicLibrary::AddSymbol("allocateCursor", reinterpret_cast<void*>(allocateCursor));
}

void Prerequisites::generateReferenceToSqlite3BtreeCursor(ModuleOp m, LLVMDialect* d) {
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
            T::voidTy, {
                T::BtCursorPtrTy,
                T::i32Ty
            }, false);

    GENERATE_SYMBOL(f_sqlite3BtreeCursorHintFlags, sqlite3BtreeCursorHintFlags, "sqlite3BtreeCursorHintFlags")

}

void Prerequisites::generateReferenceTosqlite3VdbeSorterRewind(mlir::ModuleOp m, LLVMDialect *d) {
    auto funcTy = LLVMType::getFunctionTy(
            T::i32Ty, {
                T::VdbeCursorPtrTy,
                T::i32PtrTy
            }, false);

    GENERATE_SYMBOL(f_sqlite3VdbeSorterRewind, sqlite3VdbeSorterRewind, "sqlite3VdbeSorterRewind");
}

void Prerequisites::generateReferenceTosqlite3BtreeFirst(ModuleOp m, LLVMDialect *d) {
    auto funcTy = LLVMType::getFunctionTy(
            T::i32Ty, {
                T::BtCursorPtrTy,
                T::i32PtrTy
            }, false);

    GENERATE_SYMBOL(f_sqlite3BtreeFirst, sqlite3BtreeFirst, "sqlite3BtreeFirst");
}

void Prerequisites::generateReferenceTosqlite3VdbeCursorMoveto(ModuleOp m, LLVMDialect *d) {
    auto funcTy = LLVMType::getFunctionTy(
            T::i32Ty, {
                T::VdbeCursorPtrPtrTy,
                T::i32PtrTy
            }, false);

    GENERATE_SYMBOL(f_sqlite3VdbeCursorMoveto, sqlite3VdbeCursorMoveto, "sqlite3VdbeCursorMoveto");
}

void Prerequisites::generateReferenceToDebug(ModuleOp m, LLVMDialect *d) {
    auto funcTy = LLVMType::getFunctionTy(T::voidTy, {}, false);
    GENERATE_SYMBOL(f_debug, dbg, "dbg");
}

void Prerequisites::generateReferenceTosqlite3VdbeMemSetNull(ModuleOp m, LLVMDialect *d) {
    auto funcTy = LLVMType::getFunctionTy(
            T::voidTy, {
                T::sqlite3_valuePtrTy
            }, false);

    GENERATE_SYMBOL(f_sqlite3VdbeMemSetNull, sqlite3VdbeMemSetNull, "sqlite3VdbeMemSetNull")
}

void Prerequisites::generateReferenceTosqlite3BtreePayloadSize(mlir::ModuleOp m, LLVMDialect *d) {
    auto funcTy = LLVMType::getFunctionTy(
            T::i32Ty, {
                T::BtCursorPtrTy
            }, false);

    GENERATE_SYMBOL(f_sqlite3BtreePayloadSize, sqlite3BtreePayloadSize, "sqlite3BtreePayloadSize")
}

void Prerequisites::generateReferenceTosqlite3BtreePayloadFetch(mlir::ModuleOp m, LLVMDialect *d) {
    auto funcTy = LLVMType::getFunctionTy(
            T::i8PtrTy, {
                T::BtCursorPtrTy,
                T::i32PtrTy
            }, false);

    GENERATE_SYMBOL(f_sqlite3BtreePayloadFetch, sqlite3BtreePayloadFetch, "sqlite3BtreePayloadFetch")
}

void Prerequisites::generateReferenceTosqlite3GetVarint32(ModuleOp m, LLVMDialect *d) {
    auto funcTy = LLVMType::getFunctionTy(
            T::i8Ty, {
                T::i8PtrTy,
                T::i32PtrTy
            }, false);

    GENERATE_SYMBOL(f_sqlite3GetVarint32, sqlite3GetVarint32, "sqlite3GetVarint32")
}

void Prerequisites::generateReferenceTosqlite3VdbeOneByteSerialTypeLen(ModuleOp m, LLVMDialect *d) {
    auto funcTy = LLVMType::getFunctionTy(
            T::i8Ty, {
                T::i8Ty
            }, false);

    GENERATE_SYMBOL(f_sqlite3VdbeOneByteSerialTypeLen, sqlite3VdbeOneByteSerialTypeLen,
                    "sqlite3VdbeOneByteSerialTypeLen")
}

void Prerequisites::generateReferenceTosqlite3VdbeSerialTypeLen(ModuleOp m, LLVMDialect *d) {
    auto funcTy = LLVMType::getFunctionTy(
            T::i32Ty, {
                T::i32Ty
            }, false);

    GENERATE_SYMBOL(f_sqlite3VdbeSerialTypeLen, sqlite3VdbeSerialTypeLen, "sqlite3VdbeSerialTypeLen")
}

void Prerequisites::generateReferenceTosqlite3VdbeMemRelease(ModuleOp m, LLVMDialect *d) {
    auto funcTy = LLVMType::getFunctionTy(
            T::voidTy, {
                T::sqlite3_valuePtrTy
            }, false);

    GENERATE_SYMBOL(f_sqlite3VdbeMemRelease, sqlite3VdbeMemRelease, "f_sqlite3VdbeMemRelease");
}

void Prerequisites::generateReferenceToAssert(ModuleOp m, LLVMDialect *d) {
    auto funcTy = LLVMType::getFunctionTy(
            T::voidTy, {
                T::i1Ty,
                T::i64Ty,
                T::i8PtrTy
            }, false);

    GENERATE_SYMBOL(f_assert, my_assert, "my_assert");
}

void Prerequisites::generateReferenceTosqlite3VdbeSerialGet(ModuleOp m, LLVMDialect *d) {
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
    Mem *out2PrereleaseWithClear(Vdbe *p, VdbeOp *pOp);
}

void Prerequisites::generateReferenceToout2Prerelease(ModuleOp m, LLVMDialect* d) {
    auto funcTy = LLVMType::getFunctionTy(
            T::sqlite3_valuePtrTy, {
                T::VdbePtrTy,
                T::VdbeOpPtrTy
            }, false);

    // { // Generate f_out2Prerelease
    //     GENERATE_SYMBOL(f_out2Prerelease, out2Prerelease, "out2Prerelease");
    // }

    // Generate f_out2PrereleaseWithClear
    GENERATE_SYMBOL(f_out2PrereleaseWithClear, out2PrereleaseWithClear, "out2PrereleaseWithClear");
}

void Prerequisites::generateReferenceTosqlite3VdbeMemInit(ModuleOp m, LLVMDialect* d) {
    auto funcTy = LLVMType::getFunctionTy(
            T::voidTy, {
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
            T::voidTy, {
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
            T::voidTy, {
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

void Prerequisites::generateReferenceTocallXInversePtr(mlir::ModuleOp m, LLVMDialect *d) {
    static auto calleeType = LLVMType::getFunctionTy(
            T::voidTy, {
                    T::sqlite3_contextPtrTy,
                    T::i32Ty,
                    T::sqlite3_valuePtrPtrTy
            }, false);

    auto funcTy = LLVMType::getFunctionTy(
            T::voidTy, {
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
            T::voidTy, {
                    T::sqlite3_contextPtrTy,
                    T::i32Ty,
                    T::sqlite3_valuePtrPtrTy
            }, false);

    auto funcTy = LLVMType::getFunctionTy(
            T::voidTy, {
                    T::i64Ty,
                    T::sqlite3_contextPtrTy,
                    T::i32Ty,
                    T::sqlite3_valuePtrPtrTy
            }, false);

    GENERATE_SYMBOL(f_callXSFuncPtr, callXSFuncPtr, "callXSFuncPtr");

}

void Prerequisites::generateReferenceTosqlite3BtreeFakeValidCursor(ModuleOp m, LLVMDialect* d) {
    auto funcTy = LLVMType::getFunctionTy(
            T::BtCursorPtrTy, {}, false);

    GENERATE_SYMBOL(f_sqlite3BtreeFakeValidCursor, sqlite3BtreeFakeValidCursor, "sqlite3BtreeFakeValidCursor");
}

void Prerequisites::generateReferenceTosqlite3VdbeSorterWrite(ModuleOp m, LLVMDialect* d) {
    auto funcTy = LLVMType::getFunctionTy(
            T::i32Ty, {
                T::VdbeCursorPtrTy,
                T::sqlite3_valuePtrTy
            }, false);

    GENERATE_SYMBOL(f_sqlite3VdbeSorterWrite, sqlite3VdbeSorterWrite, "sqlite3VdbeSorterWrite");
}

void Prerequisites::generateReferenceTosqlite3VdbeMemExpandBlob(ModuleOp m, LLVMDialect* d) {
    auto funcTy = LLVMType::getFunctionTy(
        T::i32Ty, {
            T::sqlite3_valuePtrTy
        }, false);

    GENERATE_SYMBOL(f_sqlite3VdbeMemExpandBlob, sqlite3VdbeMemExpandBlob, "sqlite3VdbeMemExpandBlob");
}

void Prerequisites::generateReferenceTosqlite3VdbeSorterRowkey(mlir::ModuleOp m, LLVMDialect *d) {
    auto funcTy = LLVMType::getFunctionTy(
            T::i32Ty, {
                T::VdbeCursorPtrTy,
                T::sqlite3_valuePtrTy
            }, false);

    GENERATE_SYMBOL(f_sqlite3VdbeSorterRowkey, sqlite3VdbeSorterRowkey, "sqlite3VdbeSorterRowkey");
}

void Prerequisites::generateReferenceTosqlite3VdbeSorterNext(mlir::ModuleOp m, LLVMDialect *d) {
    auto funcTy = LLVMType::getFunctionTy(
            T::i32Ty, {
                T::sqlite3PtrTy,
                T::VdbeCursorPtrTy
            }, false);

    GENERATE_SYMBOL(f_sqlite3VdbeSorterNext, sqlite3VdbeSorterNext, "sqlite3VdbeSorterNext");
}

void Prerequisites::generateReferenceTosqlite3MemCompare(mlir::ModuleOp m, LLVMDialect *d) {
    auto funcTy = LLVMType::getFunctionTy(
            T::i32Ty, {
                T::sqlite3_valuePtrTy,
                T::sqlite3_valuePtrTy,
                T::CollSeqPtrTy
            }, false);

    GENERATE_SYMBOL(f_sqlite3MemCompare, sqlite3MemCompare, "sqlite3MemCompare");
}

void Prerequisites::generateReferenceTosqlite3VdbeSorterInit(mlir::ModuleOp m, LLVMDialect* d) {
    auto funcTy = LLVMType::getFunctionTy(
            T::i32Ty, {
                T::sqlite3PtrTy,
                T::i32Ty,
                T::VdbeCursorPtrTy
            }, false);

    GENERATE_SYMBOL(f_sqlite3VdbeSorterInit, sqlite3VdbeSorterInit, "sqlite3VdbeSorterInit");
}

extern "C" {
    void applyAffinity(Mem *pRec, char affinity, u8 enc);
}
void Prerequisites::generateReferenceToapplyAffinity(mlir::ModuleOp m, LLVMDialect* d) {
    auto funcTy = LLVMType::getFunctionTy(
            T::voidTy, {
                T::sqlite3_valuePtrTy,
                T::i8Ty,
                T::i8Ty
            }, false);

    GENERATE_SYMBOL(f_applyAffinity, applyAffinity, "applyAffinity");
}

void Prerequisites::generateReferenceTosqlite3VarintLen(ModuleOp m, LLVMDialect* d) {
    auto funcTy = LLVMType::getFunctionTy(
            T::i32Ty, {
                T::i64Ty
            }, false);


    GENERATE_SYMBOL(f_sqlite3VarintLen, sqlite3VarintLen, "sqlite3VarintLen");
}

void Prerequisites::generateReferenceTosqlite3VdbeMemClearAndResize(ModuleOp m, LLVMDialect* d) {
    auto funcTy = LLVMType::getFunctionTy(
        T::i32Ty, {
            T::sqlite3_valuePtrTy,
            T::i32Ty
        }, false);

    GENERATE_SYMBOL(f_sqlite3VdbeMemClearAndResize, sqlite3VdbeMemClearAndResize, "sqlite3VdbeMemClearAndResize");
}

void Prerequisites::generateReferenceTosqlite3PutVarint(ModuleOp m, LLVMDialect *d) {
    auto funcTy = LLVMType::getFunctionTy(
            T::i32Ty, {
               T::i8PtrTy,
               T::i64Ty
            }, false);

    GENERATE_SYMBOL(f_sqlite3PutVarint, sqlite3PutVarint, "sqlite3PutVarint");
}

void Prerequisites::generateReferenceTosqlite3VdbeSerialPut(ModuleOp m, LLVMDialect *d) {
    auto funcTy = LLVMType::getFunctionTy(
        T::i32Ty, {
            T::i8PtrTy,
            T::sqlite3_valuePtrTy,
            T::i32Ty
        }, false);

    GENERATE_SYMBOL(f_sqlite3VdbeSerialPut, sqlite3VdbeSerialPut, "sqlite3VdbeSerialPut");
}

extern "C" {
    int sqlite3BtreeCursorIsValid(BtCursor*);
}

void Prerequisites::generateReferenceTosqlite3BtreeCursorIsValid(ModuleOp m, LLVMDialect* d) {
    auto funcTy = LLVMType::getFunctionTy(
        T::i32Ty, {
            T::BtCursorPtrTy
        }, false);

    GENERATE_SYMBOL(f_sqlite3BtreeCursorIsValid, sqlite3BtreeCursorIsValid, "sqlite3BtreeCursorIsValid");
}

void Prerequisites::generateReferenceTosqlite3VdbeExec2(mlir::ModuleOp m, LLVMDialect *d) {
    auto funcTy = LLVMType::getFunctionTy(
            T::i32Ty, {
                T::VdbePtrTy
            }, false);

    GENERATE_SYMBOL(f_sqlite3VdbeExec2, sqlite3VdbeExec2, "sqlite3VdbeExec2");
}

void Prerequisites::generateReferenceTosqlite3VdbeMemMove(ModuleOp m, LLVMDialect* d) {
    auto funcTy = LLVMType::getFunctionTy(
            T::voidTy, {
                T::sqlite3_valuePtrTy,
                T::sqlite3_valuePtrTy
            }, false);

    GENERATE_SYMBOL(f_sqlite3VdbeMemMove, sqlite3VdbeMemMove, "sqlite3VdbeMemMove");
}

extern "C" {
u16 numericType(Mem *pMem);
}

void Prerequisites::generateReferenceTonumericType(ModuleOp m, LLVMDialect* d) {
    auto funcTy = LLVMType::getFunctionTy(
            T::i16Ty, {
                T::sqlite3_valuePtrTy
            }, false);

    GENERATE_SYMBOL(f_numericType, numericType, "numericType");
}

void Prerequisites::generateReferenceTosqlite3AddInt64(mlir::ModuleOp m, LLVMDialect *d) {
    auto funcTy = LLVMType::getFunctionTy(
            T::i32Ty, {
                T::i64PtrTy,
                T::i64Ty
            }, false);

    GENERATE_SYMBOL(f_sqlite3AddInt64, sqlite3AddInt64, "sqlite3AddInt64");
}

void Prerequisites::generateReferenceTosqlite3SubInt64(mlir::ModuleOp m, LLVMDialect *d) {
    auto funcTy = LLVMType::getFunctionTy(
            T::i32Ty, {
                    T::i64PtrTy,
                    T::i64Ty
            }, false);

    GENERATE_SYMBOL(f_sqlite3SubInt64, sqlite3SubInt64, "sqlite3SubInt64");
}

void Prerequisites::generateReferenceTosqlite3MulInt64(mlir::ModuleOp m, LLVMDialect *d) {
    auto funcTy = LLVMType::getFunctionTy(
            T::i32Ty, {
                    T::i64PtrTy,
                    T::i64Ty
            }, false);

    GENERATE_SYMBOL(f_sqlite3MulInt64, sqlite3MulInt64, "sqlite3MulInt64");
}

void Prerequisites::generateReferenceTosqlite3VdbeRealValue(mlir::ModuleOp m, LLVMDialect *d) {
    auto funcTy = LLVMType::getFunctionTy(
            T::doubleTy, {
                T::sqlite3_valuePtrTy
            }, false);

    GENERATE_SYMBOL(f_sqlite3VdbeRealValue, sqlite3VdbeRealValue, "sqlite3VdbeRealValue");
}

void Prerequisites::generateReferenceTosqlite3IsNaN(mlir::ModuleOp m, LLVMDialect *d) {
    auto funcTy = LLVMType::getFunctionTy(
            T::i32Ty, {
                T::doubleTy
            }, false);

    GENERATE_SYMBOL(f_sqlite3IsNaN, sqlite3IsNaN, "sqlite3IsNaN");
}

extern "C" {
    void applyNumericAffinity(sqlite3_value*, int);
}

void Prerequisites::generateReferenceToapplyNumericAffinity(mlir::ModuleOp m, LLVMDialect* d) {
    auto funcTy = LLVMType::getFunctionTy(
            T::voidTy, {
                T::sqlite3_valuePtrTy,
                T::i32Ty
            }, false);

    GENERATE_SYMBOL(f_applyNumericAffinity, applyNumericAffinity, "applyNumericAffinity");
}

void Prerequisites::generateReferenceTosqlite3VdbeMemStringify(mlir::ModuleOp m, LLVMDialect *d) {
    auto funcTy = LLVMType::getFunctionTy(
            T::i32Ty, {
                T::sqlite3_valuePtrTy,
                T::i8Ty,
                T::i8Ty
            }, false);

    GENERATE_SYMBOL(f_sqlite3VdbeMemStringify, sqlite3VdbeMemStringify, "sqlite3VdbeMemStringify");
}

void Prerequisites::generateReferenceTosqlite3VdbeMemTooBig(ModuleOp m, LLVMDialect *d) {
    auto funcTy = LLVMType::getFunctionTy(
            T::i32Ty, {
                T::sqlite3_valuePtrTy
            }, false);

    GENERATE_SYMBOL(f_sqlite3VdbeMemTooBig, sqlite3VdbeMemTooBig, "sqlite3VdbeMemTooBig");
}

void Prerequisites::generateReferenceTosqlite3VdbeBooleanValue(ModuleOp m, LLVMDialect *d) {
    auto funcTy = LLVMType::getFunctionTy(
            T::i32Ty, {
                T::sqlite3_valuePtrTy,
                T::i32Ty
            }, false);

    GENERATE_SYMBOL(f_sqlite3VdbeBooleanValue, sqlite3VdbeBooleanValue, "sqlite3VdbeBooleanValue");
}

void Prerequisites::generateReferenceTosqlite3VdbeError(ModuleOp m, LLVMDialect *d) {
    auto funcTy = LLVMType::getFunctionTy(
            T::voidTy, {
                T::VdbePtrTy,
                T::i8PtrTy,
                T::i8PtrTy
            }, false);

    GENERATE_SYMBOL(f_sqlite3VdbeError, sqlite3VdbeError, "sqlite3VdbeError");
}

extern "C" {
    // Copy of sqlite3_value_text in vdbeapi.c
    const unsigned char* sqlite3_value_text_internal(sqlite3_value *pVal) {
        return (const unsigned char *)sqlite3ValueText(pVal, SQLITE_UTF8);
    }
}

void Prerequisites::generateReferenceTosqlite3_value_text(ModuleOp m, LLVMDialect *d) {
    auto funcTy = LLVMType::getFunctionTy(
        T::i8PtrTy, {
            T::sqlite3_valuePtrTy
        }, false);

    GENERATE_SYMBOL(f_sqlite3_value_text, sqlite3_value_text_internal, "sqlite3_value_text");
}

extern "C" {
    u16 computeNumericType(Mem*);
}

void Prerequisites::generateReferenceTocomputeNumericType(ModuleOp m, LLVMDialect *d) {
    auto funcTy = LLVMType::getFunctionTy(
            T::i16Ty, {
                T::sqlite3_valuePtrTy
            }, false);

    GENERATE_SYMBOL(f_computeNumericType, computeNumericType, "computeNumericType");
}

void Prerequisites::generateReferenceTosqlite3BtreeClearTable(mlir::ModuleOp m, LLVMDialect* d) {
    auto funcTy = LLVMType::getFunctionTy(
        T::i32Ty, {
            T::BtreePtrTy,
            T::i32Ty,
            T::i32PtrTy
        }, false);

    GENERATE_SYMBOL(f_sqlite3BtreeClearTable, sqlite3BtreeClearTable, "sqlite3BtreeClearTable");
}

void Prerequisites::generateReferenceTosqlite3VdbeIncrWriteCounter(ModuleOp m, LLVMDialect* d) {
    //auto funcTy = LLVMType::getFuncTy(
    //    T::i32Ty

    //false);
}

void Prerequisites::generateReferenceTosqlite3BtreeIntegerKey(ModuleOp m, LLVMDialect* d) {
    auto funcTy = LLVMType::getFunctionTy(
        T::i64Ty, {
            T::BtCursorPtrTy
        }, false);

    GENERATE_SYMBOL(f_sqlite3BtreeIntegerKey, sqlite3BtreeIntegerKey, "sqlite3BtreeIntegerKey");
}

void Prerequisites::generateReferenceTosqlite3BtreeDelete(ModuleOp m, LLVMDialect* d) {
    auto funcTy = LLVMType::getFunctionTy(
            T::i32Ty, {
                T::BtCursorPtrTy,
                T::i8Ty
            }, false);

    GENERATE_SYMBOL(f_sqlite3BtreeDelete, sqlite3BtreeDelete, "sqlite3BtreeDelete");
}

void Prerequisites::generateReferenceTosqlite3VdbeCursorRestore(ModuleOp m, LLVMDialect *d) {
    auto funcTy = LLVMType::getFunctionTy(
            T::i32Ty, {
                T::VdbeCursorPtrTy
            }, false);

    GENERATE_SYMBOL(f_sqlite3VdbeCursorRestore, sqlite3VdbeCursorRestore, "sqlite3VdbeCursorRestore");
}

void Prerequisites::generateReferenceTosqlite3VdbeIdxRowid(ModuleOp m, LLVMDialect *d) {
    auto funcTy = LLVMType::getFunctionTy(
            T::i32Ty, {
                    T::sqlite3PtrTy,
                    T::BtCursorPtrTy,
                    T::i64PtrTy
            }, false);

    GENERATE_SYMBOL(f_sqlite3VdbeIdxRowid, sqlite3VdbeIdxRowid, "sqlite3VdbeIdxRowid");
}

#undef GENERATE_SYMBOL
#define CALL_SYMBOL_GENERATOR(f) generateReferenceTo##f(m, d)

void Prerequisites::runPrerequisites(ModuleOp m, LLVMDialect *d) {
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
    CALL_SYMBOL_GENERATOR(sqlite3BtreeFakeValidCursor);
    CALL_SYMBOL_GENERATOR(sqlite3VdbeSorterWrite);
    CALL_SYMBOL_GENERATOR(sqlite3VdbeMemExpandBlob);
    CALL_SYMBOL_GENERATOR(sqlite3VdbeSorterRowkey);
    CALL_SYMBOL_GENERATOR(sqlite3VdbeSorterNext);
    CALL_SYMBOL_GENERATOR(sqlite3MemCompare);
    CALL_SYMBOL_GENERATOR(sqlite3VdbeSorterInit);
    CALL_SYMBOL_GENERATOR(applyAffinity);
    CALL_SYMBOL_GENERATOR(sqlite3VarintLen);
    CALL_SYMBOL_GENERATOR(sqlite3VdbeMemClearAndResize);
    CALL_SYMBOL_GENERATOR(sqlite3PutVarint);
    CALL_SYMBOL_GENERATOR(sqlite3VdbeSerialPut);
    CALL_SYMBOL_GENERATOR(sqlite3BtreeCursorIsValid);
    CALL_SYMBOL_GENERATOR(sqlite3VdbeExec2);
    CALL_SYMBOL_GENERATOR(sqlite3VdbeMemMove);
    CALL_SYMBOL_GENERATOR(numericType);
    CALL_SYMBOL_GENERATOR(sqlite3AddInt64);
    CALL_SYMBOL_GENERATOR(sqlite3SubInt64);
    CALL_SYMBOL_GENERATOR(sqlite3MulInt64);
    CALL_SYMBOL_GENERATOR(sqlite3VdbeRealValue);
    CALL_SYMBOL_GENERATOR(sqlite3IsNaN);
    CALL_SYMBOL_GENERATOR(applyNumericAffinity);
    CALL_SYMBOL_GENERATOR(sqlite3VdbeMemStringify);
    CALL_SYMBOL_GENERATOR(sqlite3VdbeMemTooBig);
    CALL_SYMBOL_GENERATOR(sqlite3VdbeBooleanValue);
    CALL_SYMBOL_GENERATOR(sqlite3VdbeError);
    CALL_SYMBOL_GENERATOR(sqlite3_value_text);
    CALL_SYMBOL_GENERATOR(computeNumericType);
    CALL_SYMBOL_GENERATOR(sqlite3BtreeClearTable);
    CALL_SYMBOL_GENERATOR(sqlite3VdbeIncrWriteCounter);
    CALL_SYMBOL_GENERATOR(sqlite3BtreeIntegerKey);
    CALL_SYMBOL_GENERATOR(sqlite3BtreeDelete);
    CALL_SYMBOL_GENERATOR(sqlite3VdbeIdxRowid);
    CALL_SYMBOL_GENERATOR(sqlite3VdbeCursorRestore);

    CALL_SYMBOL_GENERATOR(memCpy);

    CALL_SYMBOL_GENERATOR(Debug);
    CALL_SYMBOL_GENERATOR(Assert);

    {
        auto builder = mlir::OpBuilder(m);
        auto& rewriter = builder;
        auto* ctx = rewriter.getContext();
        builder.setInsertionPointToStart(m.getBody());

//        using Type = mlir::LLVM::LLVMType;
//        auto createGlobal = [&](Type ty, const char* name, auto initialValue = 0llu) {
//            auto global = builder.create<mlir::LLVM::GlobalOp>
//                (LOC,
//                    ty,
//                    true,
//                    Linkage::External,
//                    name,
//                    mlir::Attribute()
//                    // 0
//                    // rewriter.getI64IntegerAttr(initialValue)
//                );
//
//            return global;
//        };
//
//        {
//            auto arrayTy = T::sqlite3_valuePtrTy;
//            auto aMem = createGlobal(arrayTy, "vdbeMem", 0);
//        }

//        {
//            auto arrayTy = T::VdbeOpPtrTy;
//            auto aOp = createGlobal(arrayTy, "vdbeOps", 0);
//        }


    }
}

void runPrerequisites(ModuleOp m, LLVMDialect* d) {
    Prerequisites::runPrerequisites(m, d);
}

#undef CALL_SYMBOL_GENERATOR
