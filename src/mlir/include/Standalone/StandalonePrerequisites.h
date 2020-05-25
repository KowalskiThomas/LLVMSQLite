#pragma once

#include "mlir/Target/LLVMIR.h"
#include "mlir/IR/Types.h"
#include "mlir/Dialect/LLVMIR/LLVMDialect.h"

using namespace mlir::LLVM;
using ModuleOp = mlir::ModuleOp;

#define ExternFuncOp extern LLVMFuncOp
ExternFuncOp f_progress;
ExternFuncOp f_printInt;
ExternFuncOp f_printPtrAndValue;

ExternFuncOp f_allocateCursor;
ExternFuncOp f_sqlite3BtreeCursor;
ExternFuncOp f_sqlite3BtreeCursorHintFlags;
ExternFuncOp f_sqlite3VdbeSorterRewind;
ExternFuncOp f_sqlite3BtreeFirst;
ExternFuncOp f_sqlite3VdbeCursorMoveto;
ExternFuncOp f_sqlite3VdbeMemSetNull;
ExternFuncOp f_sqlite3BtreePayloadSize;
ExternFuncOp f_sqlite3BtreePayloadFetch;
ExternFuncOp f_sqlite3GetVarint32;
ExternFuncOp f_sqlite3VdbeOneByteSerialTypeLen;
ExternFuncOp f_sqlite3VdbeSerialTypeLen;
ExternFuncOp f_sqlite3VdbeMemRelease;
ExternFuncOp f_sqlite3VdbeSerialGet;
ExternFuncOp f_sqlite3VdbeMemGrow;
ExternFuncOp f_sqlite3VdbeMemFromBtree;
ExternFuncOp f_sqlite3VdbeCheckFk;
ExternFuncOp f_sqlite3VdbeCloseStatement;
ExternFuncOp f_sqlite3VdbeMemMakeWriteable;
ExternFuncOp f_sqlite3VdbeMemNulTerminate;
ExternFuncOp f_sqlite3BtreeNext;
ExternFuncOp f_sqlite3VdbeHalt;
ExternFuncOp f_sqlite3BtreeBeginTrans;
ExternFuncOp f_sqlite3VtabSavepoint;
ExternFuncOp f_sqlite3BtreeBeginStmt;
ExternFuncOp f_out2Prerelease;
ExternFuncOp f_sqlite3VdbeMemInit;
ExternFuncOp f_sqlite3DbMallocRawNN;
ExternFuncOp f_sqlite3VdbeMemSetInt64;
ExternFuncOp f_sqlite3VdbeMemFinalize;
ExternFuncOp f_sqlite3VdbeChangeEncoding;
ExternFuncOp f_sqlite3VdbeMemShallowCopy;
ExternFuncOp f_callXInversePtr;
ExternFuncOp f_callXSFuncPtr;
ExternFuncOp f_sqlite3BtreeFakeValidCursor;
ExternFuncOp f_sqlite3VdbeSorterWrite;
ExternFuncOp f_sqlite3VdbeMemExpandBlob;
ExternFuncOp f_sqlite3VdbeSorterRowkey;
ExternFuncOp f_sqlite3VdbeSorterNext;

ExternFuncOp f_debug;
ExternFuncOp f_assert;
ExternFuncOp f_memCpy;

void initialiseTypeCache(LLVMDialect*);

#define DECLARE_FUNCTION(name) static void generateReferenceTo##name(mlir::ModuleOp, LLVMDialect*);

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

    DECLARE_FUNCTION(memCpy);

    DECLARE_FUNCTION(Debug);
    DECLARE_FUNCTION(Assert);

    DECLARE_FUNCTION(Progress);


    static void runPrerequisites(ModuleOp, LLVMDialect*);
};
