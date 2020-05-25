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
void runPrerequisites(ModuleOp, LLVMDialect*);
