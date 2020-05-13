#pragma once

#include "mlir/Target/LLVMIR.h"
#include "mlir/IR/Types.h"
#include "mlir/Dialect/LLVMIR/LLVMDialect.h"

using namespace mlir::LLVM;
using ModuleOp = mlir::ModuleOp;

// TODO: Remove addFunction
#define ExternFuncOp extern LLVMFuncOp
ExternFuncOp addFunction;
ExternFuncOp f_progress;
ExternFuncOp f_printPtr;
ExternFuncOp f_allocateCursor;
ExternFuncOp f_sqlite3BtreeCursor;
ExternFuncOp f_sqlite3BtreeCursorHintFlags;
ExternFuncOp f_sqlite3VdbeSorterRewind;
ExternFuncOp f_sqlite3BtreeFirst;
ExternFuncOp f_sqlite3VdbeCursorMoveto;
ExternFuncOp f_sqlite3VdbeMemSetNull;
ExternFuncOp f_sqlite3BtreePayloadSize;
ExternFuncOp f_sqlite3BtreePayloadFetch;
ExternFuncOp f_debug;
ExternFuncOp f_assert;
ExternFuncOp f_sqlite3GetVarint32;
ExternFuncOp f_sqlite3VdbeOneByteSerialTypeLen;
ExternFuncOp f_sqlite3VdbeSerialTypeLen;
ExternFuncOp f_sqlite3VdbeMemRelease;
ExternFuncOp f_sqlite3VdbeSerialGet;
ExternFuncOp f_sqlite3VdbeMemGrow;
ExternFuncOp f_sqlite3VdbeMemFromBtree;
ExternFuncOp f_sqlite3VdbeCheckFk;
ExternFuncOp f_sqlite3VdbeCloseStatement;
ExternFuncOp f_memCpy;

void initialiseTypeCache(LLVMDialect*);

#define DECLARE_FUNCTION(name) static void generateReferenceTo##name(mlir::ModuleOp, LLVMDialect*);

struct Prerequisites {
    using LLVMDialect = mlir::LLVM::LLVMDialect;

public:
    // These are temporary
    static void generateNewFunction(ModuleOp, LLVMDialect*);
    static void generateReferenceToAdd(ModuleOp, LLVMDialect*);

    DECLARE_FUNCTION(Progress);
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

    DECLARE_FUNCTION(memCpy);

    DECLARE_FUNCTION(Debug);
    DECLARE_FUNCTION(Assert);

    static void runPrerequisites(ModuleOp, LLVMDialect*);
};
