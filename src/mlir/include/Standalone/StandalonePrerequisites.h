#pragma once

#include "mlir/Target/LLVMIR.h"
#include "mlir/IR/Types.h"
#include "mlir/Dialect/LLVMIR/LLVMDialect.h"

using namespace mlir::LLVM;
using ModuleOp = mlir::ModuleOp;

// Allows me to define "extern LLVMFuncOp" symbols with a single word.
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

/*
 * For debugging purposes, it is possible to call the default implementation of
 * sqlite3VdbeExec from the JIT for a given number of steps.
 * It is useful for checking whether the implementation of an operation is faulty,
 * by doing everything else in JIT but lowering one operation code to issue a call
 * to the default implementation for (up to) one step.
 * For example, run up to two instructions using the default implementation:
 *      store(pc, &vdbe->pc);
 *      store(2, &maxVdbeSteps);
 *      call(f_sqlite3VdbeExecDefault, vdbe);
 * The original sqlite3VdbeExec has been modified to support that.
 */
// The maximum number of operations to execute in the default implementation
extern int64_t maxVdbeSteps;
ExternFuncOp f_sqlite3VdbeExecDefault;

ExternFuncOp f_debug;
ExternFuncOp f_assert;
ExternFuncOp f_memCpy;

/**
 * Initialises the "type cache" (the fields of the T class) for a given dialect.
 */
void initialiseTypeCache(LLVMDialect*);

/**
 * Generates the references to SQLite stock functions and debugging functions.
 * This should be run AFTER initialiseTypeCache!
 */
void runPrerequisites(ModuleOp, LLVMDialect*);
