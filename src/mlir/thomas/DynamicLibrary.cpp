#include "llvm/Bitcode/BitcodeReader.h"
#include "llvm/IRReader/IRReader.h"

#include "llvm/ExecutionEngine/MCJIT.h"
#include "llvm/ExecutionEngine/JITLink/JITLink.h"
#include "llvm/ExecutionEngine/ExecutionEngine.h"
#include "llvm/ExecutionEngine/GenericValue.h"
#include "llvm/Transforms/IPO/Inliner.h"
#include "llvm/Transforms/IPO.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/IRBuilder.h"
#include <llvm/IR/LegacyPassManager.h>
#include "llvm/Support/TargetSelect.h"
#include <llvm/Transforms/IPO/PassManagerBuilder.h>
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Verifier.h"
#include "llvm/IR/Type.h"
#include "llvm/Support/ManagedStatic.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Transforms/IPO/FunctionImport.h"
#include "llvm/Transforms/Utils/Cloning.h"
#include "llvm/Support/InitLLVM.h"
#include "llvm/Support/TargetSelect.h"
#include "llvm/Support/raw_ostream.h"
#include "mlir/Pass/PassManager.h"
#include "mlir/IR/Dialect.h"
#include "mlir/IR/MLIRContext.h"
#include "mlir/InitAllDialects.h"
#include "mlir/InitAllPasses.h"
#include "mlir/Pass/Pass.h"
#include "mlir/Support/MlirOptMain.h"
#include "mlir/Target/LLVMIR.h"
#include "mlir/ExecutionEngine/ExecutionEngine.h"
#include "mlir/ExecutionEngine/OptUtils.h"
#include "mlir/IR/Module.h"
extern "C" {
    void* sqlite3VdbeMemGrow(void*);
    void* sqlite3VdbeSorterRewind(void*);
    void* doubleToInt64(void*);
    void* sqlite3VdbeMemFromBtree(void*);
    void* sqlite3BtreeCursor(void*);
    void* sqlite3BtreePayloadFetch(void*);
    void* sqlite3VdbeSerialTypeLen(void*);
    void* sqlite3VdbeMemNulTerminate(void*);
    void* sqlite3VdbeRecordUnpack(void*);
    void* sqlite3VdbeCheckFk(void*);
    void* btreeInitPage(void*);
    void* sqlite3VdbeCloseStatement(void*);
    void* sqlite3DbMallocRawNN(void*);
    void* sqlite3_str_vappendf(void*);
    void* sqlite3PcacheRelease(void*);
    void* mallocWithAlarm(void*);
    void* measureAllocationSize(void*);
    void* my_assert(void*);
    void* sqlite3VdbeMemMakeWriteable(void*);
    void* dbReallocFinish(void*);
    void* sqlite3BtreeNext(void*);
    void* sqlite3BtreeCursorHintFlags(void*);
    void* sqlite3BtreeFirst(void*);
    void* sqlite3VdbeMemShallowCopy(void*);
    void* allocateCursor(void*);
    void* sqlite3Realloc(void*);
    void* sqlite3BtreeMovetoUnpacked(void*);
    void* sqlite3BtreeBeginTrans(void*);
    void* sqlite3VdbeSerialGet(void*);
    void* sqlite3DbFree(void*);
    void* sqlite3AtoF(void*);
    void* sqlite3BtreeCursorIsValid(void*);
    void* sqlite3VdbeCursorMoveto(void*);
    void* vdbeMemClear(void*);
    void* printProgress(void*);
    void* sqlite3GetVarint32(void*);
    void* sqlite3_log(void*);
    void* sqlite3BtreePayloadSize(void*);
    void* sqlite3VdbeHalt(void*);
    void* sqlite3Atoi64(void*);
    void* vdbeMemAddTerminator(void*);
    void* vdbeMemClearExternAndSetNull(void*);
    void* strAccumFinishRealloc(void*);
    void* applyAffinity(void*);
    void* computeNumericType(void*);
}

void addToDynamicLibrary() {
    llvm::sys::DynamicLibrary::AddSymbol("sqlite3VdbeMemGrow", (void*)sqlite3VdbeMemGrow);
    llvm::sys::DynamicLibrary::AddSymbol("sqlite3VdbeSorterRewind", (void*)sqlite3VdbeSorterRewind);
    llvm::sys::DynamicLibrary::AddSymbol("doubleToInt64", (void*)doubleToInt64);
    llvm::sys::DynamicLibrary::AddSymbol("sqlite3VdbeMemFromBtree", (void*)sqlite3VdbeMemFromBtree);
    llvm::sys::DynamicLibrary::AddSymbol("sqlite3BtreeCursor", (void*)sqlite3BtreeCursor);
    llvm::sys::DynamicLibrary::AddSymbol("sqlite3BtreePayloadFetch", (void*)sqlite3BtreePayloadFetch);
    llvm::sys::DynamicLibrary::AddSymbol("sqlite3VdbeSerialTypeLen", (void*)sqlite3VdbeSerialTypeLen);
    llvm::sys::DynamicLibrary::AddSymbol("sqlite3VdbeMemNulTerminate", (void*)sqlite3VdbeMemNulTerminate);
    llvm::sys::DynamicLibrary::AddSymbol("sqlite3VdbeRecordUnpack", (void*)sqlite3VdbeRecordUnpack);
    llvm::sys::DynamicLibrary::AddSymbol("sqlite3VdbeCheckFk", (void*)sqlite3VdbeCheckFk);
    llvm::sys::DynamicLibrary::AddSymbol("btreeInitPage", (void*)btreeInitPage);
    llvm::sys::DynamicLibrary::AddSymbol("sqlite3VdbeCloseStatement", (void*)sqlite3VdbeCloseStatement);
    llvm::sys::DynamicLibrary::AddSymbol("sqlite3DbMallocRawNN", (void*)sqlite3DbMallocRawNN);
    llvm::sys::DynamicLibrary::AddSymbol("sqlite3_str_vappendf", (void*)sqlite3_str_vappendf);
    llvm::sys::DynamicLibrary::AddSymbol("sqlite3PcacheRelease", (void*)sqlite3PcacheRelease);
    llvm::sys::DynamicLibrary::AddSymbol("mallocWithAlarm", (void*)mallocWithAlarm);
    llvm::sys::DynamicLibrary::AddSymbol("measureAllocationSize", (void*)measureAllocationSize);
    llvm::sys::DynamicLibrary::AddSymbol("my_assert", (void*)my_assert);
    llvm::sys::DynamicLibrary::AddSymbol("sqlite3VdbeMemMakeWriteable", (void*)sqlite3VdbeMemMakeWriteable);
    llvm::sys::DynamicLibrary::AddSymbol("dbReallocFinish", (void*)dbReallocFinish);
    llvm::sys::DynamicLibrary::AddSymbol("sqlite3BtreeNext", (void*)sqlite3BtreeNext);
    llvm::sys::DynamicLibrary::AddSymbol("sqlite3BtreeCursorHintFlags", (void*)sqlite3BtreeCursorHintFlags);
    llvm::sys::DynamicLibrary::AddSymbol("sqlite3BtreeFirst", (void*)sqlite3BtreeFirst);
    llvm::sys::DynamicLibrary::AddSymbol("sqlite3VdbeMemShallowCopy", (void*)sqlite3VdbeMemShallowCopy);
    llvm::sys::DynamicLibrary::AddSymbol("allocateCursor", (void*)allocateCursor);
    llvm::sys::DynamicLibrary::AddSymbol("sqlite3Realloc", (void*)sqlite3Realloc);
    llvm::sys::DynamicLibrary::AddSymbol("sqlite3BtreeMovetoUnpacked", (void*)sqlite3BtreeMovetoUnpacked);
    llvm::sys::DynamicLibrary::AddSymbol("sqlite3BtreeBeginTrans", (void*)sqlite3BtreeBeginTrans);
    llvm::sys::DynamicLibrary::AddSymbol("sqlite3VdbeSerialGet", (void*)sqlite3VdbeSerialGet);
    llvm::sys::DynamicLibrary::AddSymbol("sqlite3DbFree", (void*)sqlite3DbFree);
    llvm::sys::DynamicLibrary::AddSymbol("sqlite3AtoF", (void*)sqlite3AtoF);
    llvm::sys::DynamicLibrary::AddSymbol("sqlite3BtreeCursorIsValid", (void*)sqlite3BtreeCursorIsValid);
    llvm::sys::DynamicLibrary::AddSymbol("sqlite3VdbeCursorMoveto", (void*)sqlite3VdbeCursorMoveto);
    llvm::sys::DynamicLibrary::AddSymbol("vdbeMemClear", (void*)vdbeMemClear);
    llvm::sys::DynamicLibrary::AddSymbol("printProgress", (void*)printProgress);
    llvm::sys::DynamicLibrary::AddSymbol("sqlite3GetVarint32", (void*)sqlite3GetVarint32);
    llvm::sys::DynamicLibrary::AddSymbol("sqlite3_log", (void*)sqlite3_log);
    llvm::sys::DynamicLibrary::AddSymbol("sqlite3BtreePayloadSize", (void*)sqlite3BtreePayloadSize);
    llvm::sys::DynamicLibrary::AddSymbol("sqlite3VdbeHalt", (void*)sqlite3VdbeHalt);
    llvm::sys::DynamicLibrary::AddSymbol("sqlite3Atoi64", (void*)sqlite3Atoi64);
    llvm::sys::DynamicLibrary::AddSymbol("vdbeMemAddTerminator", (void*)vdbeMemAddTerminator);
    llvm::sys::DynamicLibrary::AddSymbol("vdbeMemClearExternAndSetNull", (void*)vdbeMemClearExternAndSetNull);
    llvm::sys::DynamicLibrary::AddSymbol("strAccumFinishRealloc", (void*)strAccumFinishRealloc);
    llvm::sys::DynamicLibrary::AddSymbol("applyAffinity", (void*)applyAffinity);
    llvm::sys::DynamicLibrary::AddSymbol("computeNumericType", (void*)computeNumericType);
}
