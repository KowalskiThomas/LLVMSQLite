#include <cmath>
#include <iostream>
#include <memory>
#include <string>
#include <unordered_map>

#include "llvm/ADT/StringRef.h"
#include "llvm/ExecutionEngine/GenericValue.h"
#include "llvm/ExecutionEngine/JITSymbol.h"
#include "llvm/ExecutionEngine/Orc/CompileUtils.h"
#include "llvm/ExecutionEngine/Orc/Core.h"
#include "llvm/ExecutionEngine/Orc/ExecutionUtils.h"
#include "llvm/ExecutionEngine/Orc/IRCompileLayer.h"
#include "llvm/ExecutionEngine/Orc/JITTargetMachineBuilder.h"
#include "llvm/ExecutionEngine/Orc/RTDyldObjectLinkingLayer.h"
#include "llvm/ExecutionEngine/SectionMemoryManager.h"
#include "llvm/IR/DataLayout.h"
#include "llvm/IR/LLVMContext.h"
#include <llvm/ADT/StringRef.h>
#include <llvm/ExecutionEngine/ExecutionEngine.h>
#include <llvm/ExecutionEngine/MCJIT.h>
#include <llvm/IR/Constant.h>
#include <llvm/IR/IRBuilder.h>
#include <llvm/IR/LLVMContext.h>
#include <llvm/IR/Module.h>
#include <llvm/IR/PassManager.h>
#include <llvm/IR/Verifier.h>
#include <llvm/Support/DynamicLibrary.h>
#include <llvm/Support/TargetSelect.h>
#include <llvm/Support/raw_ostream.h>

extern "C" {
#include "sqliteInt.h"
#include "vdbe.h"
#include "vdbeInt.h"
#include "sqlite3.h"
}

using namespace llvm;

struct T {
    static inline Type* i32Ty = nullptr;
    static inline Type* i8Ty = nullptr;
    static inline Type* i8PtrTy = nullptr;
    static inline Type* i64Ty = nullptr;
    static inline Type* sqlite3_mutexPtrTy = nullptr;
    static inline Type* VoidTy = nullptr;
    static inline Type* Void_Of_i8Ptr__i32__i8PtrTy = nullptr;
    static inline Type* Void_Of_i8Ptr__i32__i8PtrPtrTy = nullptr;
    static inline Type* i32_Of_i32Ty = nullptr;
    static inline Type* i32_Of_i32PtrTy = nullptr;
    static inline Type* Sqlite3ConfigTy = nullptr;
    static inline Type* Sqlite3ConfigPtrTy = nullptr;
    static inline Type* i8Ptr_Of_i32Ty = nullptr;
    static inline Type* i8Ptr_Of_i32PtrTy = nullptr;
    static inline Type* Void_Of_i8PtrTy = nullptr;
    static inline Type* Void_Of_i8PtrPtrTy = nullptr;
    static inline Type* i8Ptr_Of_i8Ptr__i32Ty = nullptr;
    static inline Type* i8Ptr_Of_i8Ptr__i32PtrTy = nullptr;
    static inline Type* i32_Of_i8PtrTy = nullptr;
    static inline Type* i32_Of_i8PtrPtrTy = nullptr;
    static inline Type* sqlite3_mem_methodsTy = nullptr;
    static inline Type* sqlite3_mem_methodsPtrTy = nullptr;
    static inline Type* i32_Of_VoidTy = nullptr;
    static inline Type* i32_Of_VoidPtrTy = nullptr;
    static inline Type* sqlite3_mutexPtr_Of_i32Ty = nullptr;
    static inline Type* sqlite3_mutexPtr_Of_i32PtrTy = nullptr;
    static inline Type* Void_Of_sqlite3_mutexPtrTy = nullptr;
    static inline Type* Void_Of_sqlite3_mutexPtrPtrTy = nullptr;
    static inline Type* i32_Of_sqlite3_mutexPtrTy = nullptr;
    static inline Type* i32_Of_sqlite3_mutexPtrPtrTy = nullptr;
    static inline Type* sqlite3_mutex_methodsTy = nullptr;
    static inline Type* sqlite3_mutex_methodsPtrTy = nullptr;
    static inline Type* sqlite3_pcachePtrTy = nullptr;
    static inline Type* sqlite3_pcachePtr_Of_i32__i32__i32Ty = nullptr;
    static inline Type* sqlite3_pcachePtr_Of_i32__i32__i32PtrTy = nullptr;
    static inline Type* Void_Of_sqlite3_pcachePtr__i32Ty = nullptr;
    static inline Type* Void_Of_sqlite3_pcachePtr__i32PtrTy = nullptr;
    static inline Type* i32_Of_sqlite3_pcachePtrTy = nullptr;
    static inline Type* i32_Of_sqlite3_pcachePtrPtrTy = nullptr;
    static inline Type* sqlite3_pcache_pagePtrTy = nullptr;
    static inline Type* sqlite3_pcache_pagePtr_Of_sqlite3_pcachePtr__i32__i32Ty = nullptr;
    static inline Type* sqlite3_pcache_pagePtr_Of_sqlite3_pcachePtr__i32__i32PtrTy = nullptr;
    static inline Type* Void_Of_sqlite3_pcachePtr__sqlite3_pcache_pagePtr__i32Ty = nullptr;
    static inline Type* Void_Of_sqlite3_pcachePtr__sqlite3_pcache_pagePtr__i32PtrTy = nullptr;
    static inline Type* Void_Of_sqlite3_pcachePtr__sqlite3_pcache_pagePtr__i32__i32Ty = nullptr;
    static inline Type* Void_Of_sqlite3_pcachePtr__sqlite3_pcache_pagePtr__i32__i32PtrTy = nullptr;
    static inline Type* Void_Of_sqlite3_pcachePtrTy = nullptr;
    static inline Type* Void_Of_sqlite3_pcachePtrPtrTy = nullptr;
    static inline Type* sqlite3_pcache_methods2Ty = nullptr;
    static inline Type* sqlite3_pcache_methods2PtrTy = nullptr;
    static inline Type* sqlite3_pcacheTy = nullptr;
    static inline Type* sqlite3_pcache_pageTy = nullptr;
    static inline Type* sqlite3_mutexTy = nullptr;
    static inline Type* BtreePtrTy = nullptr;
    static inline Type* SchemaPtrTy = nullptr;
    static inline Type* DbTy = nullptr;
    static inline Type* DbPtrTy = nullptr;
    static inline Type* i16Ty = nullptr;
    static inline Type* sqlite3PtrTy = nullptr;
    static inline Type* sqlite3_valueTy = nullptr;
    static inline Type* sqlite3_valuePtrTy = nullptr;
    static inline Type* doubleTy = nullptr;
    static inline Type* MemValueTy = nullptr;
    static inline Type* MemValuePtrTy = nullptr;
    static inline Type* sqlite3_vfsPtrTy = nullptr;
    static inline Type* VdbePtrTy = nullptr;
    static inline Type* CollSeqPtrTy = nullptr;
    static inline Type* Arr_12_i32Ty = nullptr;
    static inline Type* i8PtrPtrTy = nullptr;
    static inline Type* i32_Of_i32__i8Ptr__i8Ptr__i8PtrTy = nullptr;
    static inline Type* i32_Of_i32__i8Ptr__i8Ptr__i8PtrPtrTy = nullptr;
    static inline Type* Void_Of_i8Ptr__i8Ptr__i64Ty = nullptr;
    static inline Type* Void_Of_i8Ptr__i8Ptr__i64PtrTy = nullptr;
    static inline Type* Void_Of_i8Ptr__i32__i8Ptr__i8Ptr__i64Ty = nullptr;
    static inline Type* Void_Of_i8Ptr__i32__i8Ptr__i8Ptr__i64PtrTy = nullptr;
    static inline Type* ParsePtrTy = nullptr;
    static inline Type* i32_Of_i8Ptr__sqlite3Ptr__i8Ptr__i32Ty = nullptr;
    static inline Type* i32_Of_i8Ptr__sqlite3Ptr__i8Ptr__i32PtrTy = nullptr;
    static inline Type* Void_Of_i8Ptr__sqlite3Ptr__i32__i8PtrTy = nullptr;
    static inline Type* Void_Of_i8Ptr__sqlite3Ptr__i32__i8PtrPtrTy = nullptr;
    static inline Type* i32_Of_i8Ptr__i32__i8Ptr__i8Ptr__i8Ptr__i8PtrTy = nullptr;
    static inline Type* i32_Of_i8Ptr__i32__i8Ptr__i8Ptr__i8Ptr__i8PtrPtrTy = nullptr;
    static inline Type* VtabCtxPtrTy = nullptr;
    static inline Type* VTablePtrTy = nullptr;
    static inline Type* VTablePtrPtrTy = nullptr;
    static inline Type* Arr_2_DbTy = nullptr;
    static inline Type* SavepointPtrTy = nullptr;
    static inline Type* i32PtrTy = nullptr;
    static inline Type* sqlite3Ty = nullptr;
    static inline Type* sqlite3_filePtrTy = nullptr;
    static inline Type* i32_Of_sqlite3_vfsPtr__i8Ptr__sqlite3_filePtr__i32__i32PtrTy = nullptr;
    static inline Type* i32_Of_sqlite3_vfsPtr__i8Ptr__sqlite3_filePtr__i32__i32PtrPtrTy = nullptr;
    static inline Type* i32_Of_sqlite3_vfsPtr__i8Ptr__i32Ty = nullptr;
    static inline Type* i32_Of_sqlite3_vfsPtr__i8Ptr__i32PtrTy = nullptr;
    static inline Type* i32_Of_sqlite3_vfsPtr__i8Ptr__i32__i32PtrTy = nullptr;
    static inline Type* i32_Of_sqlite3_vfsPtr__i8Ptr__i32__i32PtrPtrTy = nullptr;
    static inline Type* i32_Of_sqlite3_vfsPtr__i8Ptr__i32__i8PtrTy = nullptr;
    static inline Type* i32_Of_sqlite3_vfsPtr__i8Ptr__i32__i8PtrPtrTy = nullptr;
    static inline Type* i8Ptr_Of_sqlite3_vfsPtr__i8PtrTy = nullptr;
    static inline Type* i8Ptr_Of_sqlite3_vfsPtr__i8PtrPtrTy = nullptr;
    static inline Type* Void_Of_sqlite3_vfsPtr__i32__i8PtrTy = nullptr;
    static inline Type* Void_Of_sqlite3_vfsPtr__i32__i8PtrPtrTy = nullptr;
    static inline Type* Void__Of__Void__Of__Sqlite3_Vfs_i8Ptr_i8PtrTy = nullptr;
    static inline Type* Void_Of_sqlite3_vfsPtr__i8PtrTy = nullptr;
    static inline Type* Void_Of_sqlite3_vfsPtr__i8PtrPtrTy = nullptr;
    static inline Type* i32_Of_sqlite3_vfsPtr__i32__i8PtrTy = nullptr;
    static inline Type* i32_Of_sqlite3_vfsPtr__i32__i8PtrPtrTy = nullptr;
    static inline Type* i32_Of_sqlite3_vfsPtr__i32Ty = nullptr;
    static inline Type* i32_Of_sqlite3_vfsPtr__i32PtrTy = nullptr;
    static inline Type* doublePtrTy = nullptr;
    static inline Type* i32_Of_sqlite3_vfsPtr__doublePtrTy = nullptr;
    static inline Type* i32_Of_sqlite3_vfsPtr__doublePtrPtrTy = nullptr;
    static inline Type* i64PtrTy = nullptr;
    static inline Type* i32_Of_sqlite3_vfsPtr__i64PtrTy = nullptr;
    static inline Type* i32_Of_sqlite3_vfsPtr__i64PtrPtrTy = nullptr;
    static inline Type* Void_Of_VoidTy = nullptr;
    static inline Type* Void_Of_VoidPtrTy = nullptr;
    static inline Type* i32_Of_sqlite3_vfsPtr__i8Ptr__Void_Of_VoidPtrTy = nullptr;
    static inline Type* i32_Of_sqlite3_vfsPtr__i8Ptr__Void_Of_VoidPtrPtrTy = nullptr;
    static inline Type* Void__Of__Void__Of__Sqlite3_Vfs__i8PtrTy = nullptr;
    static inline Type* sqlite3_vfsTy = nullptr;
    static inline Type* sqlite3_io_methodsPtrTy = nullptr;
    static inline Type* sqlite3_fileTy = nullptr;
    static inline Type* i32_Of_sqlite3_filePtrTy = nullptr;
    static inline Type* i32_Of_sqlite3_filePtrPtrTy = nullptr;
    static inline Type* i32_Of_sqlite3_filePtr__i8Ptr__i32__i64Ty = nullptr;
    static inline Type* i32_Of_sqlite3_filePtr__i8Ptr__i32__i64PtrTy = nullptr;
    static inline Type* i32_Of_sqlite3_filePtr__i64Ty = nullptr;
    static inline Type* i32_Of_sqlite3_filePtr__i64PtrTy = nullptr;
    static inline Type* i32_Of_sqlite3_filePtr__i32Ty = nullptr;
    static inline Type* i32_Of_sqlite3_filePtr__i32PtrTy = nullptr;
    static inline Type* i32_Of_sqlite3_filePtr__i64PtrPtrTy = nullptr;
    static inline Type* i32_Of_sqlite3_filePtr__i32PtrPtrTy = nullptr;
    static inline Type* i32_Of_sqlite3_filePtr__i32__i8PtrTy = nullptr;
    static inline Type* i32_Of_sqlite3_filePtr__i32__i8PtrPtrTy = nullptr;
    static inline Type* i32_Of_sqlite3_filePtr__i32__i32__i32__i8PtrPtrTy = nullptr;
    static inline Type* i32_Of_sqlite3_filePtr__i32__i32__i32__i8PtrPtrPtrTy = nullptr;
    static inline Type* i32_Of_sqlite3_filePtr__i32__i32__i32Ty = nullptr;
    static inline Type* i32_Of_sqlite3_filePtr__i32__i32__i32PtrTy = nullptr;
    static inline Type* Void_Of_sqlite3_filePtrTy = nullptr;
    static inline Type* Void_Of_sqlite3_filePtrPtrTy = nullptr;
    static inline Type* i32_Of_sqlite3_filePtr__i64__i32__i8PtrPtrTy = nullptr;
    static inline Type* i32_Of_sqlite3_filePtr__i64__i32__i8PtrPtrPtrTy = nullptr;
    static inline Type* i32_Of_sqlite3_filePtr__i64__i8PtrTy = nullptr;
    static inline Type* i32_Of_sqlite3_filePtr__i64__i8PtrPtrTy = nullptr;
    static inline Type* sqlite3_io_methodsTy = nullptr;
    static inline Type* Arr_2_i8Ty = nullptr;
    static inline Type* Arr_4_i8Ty = nullptr;
    static inline Type* sqlite3_valuePtrPtrTy = nullptr;
    static inline Type* VdbeCursorPtrTy = nullptr;
    static inline Type* VdbeCursorPtrPtrTy = nullptr;
    static inline Type* VdbeOpPtrTy = nullptr;
    static inline Type* Arr_7_i32Ty = nullptr;
    static inline Type* VdbeFramePtrTy = nullptr;
    static inline Type* SubProgramPtrTy = nullptr;
    static inline Type* AuxDataPtrTy = nullptr;
    static inline Type* VdbeTy = nullptr;
    static inline Type* KeyInfoPtrTy = nullptr;
    static inline Type* Arr_1_i32Ty = nullptr;
    static inline Type* VdbeCursorTy = nullptr;
    static inline Type* BtreeTy = nullptr;
    static inline Type* BtCursorPtrTy = nullptr;
    static inline Type* anon7Ty = nullptr;
    static inline Type* anon7PtrTy = nullptr;
    static inline Type* BtCursorTy = nullptr;
    static inline Type* Arr_1_CollSeqPtrTy = nullptr;
    static inline Type* KeyInfoTy = nullptr;
    static inline Type* VdbeOpTy = nullptr;
    static inline Type* p4unionTy = nullptr;
    static inline Type* p4unionPtrTy = nullptr;
    static inline Type* VdbeFrameTy = nullptr;
    static inline Type* SubProgramTy = nullptr;
    static inline Type* AuxDataTy = nullptr;
    static inline Type* i32_Of_i8Ptr__i32__i8Ptr__i32__i8PtrTy = nullptr;
    static inline Type* i32_Of_i8Ptr__i32__i8Ptr__i32__i8PtrPtrTy = nullptr;
    static inline Type* CollSeqTy = nullptr;
    static inline Type* TablePtrTy = nullptr;
    static inline Type* SchemaTy = nullptr;
    static inline Type* ColumnPtrTy = nullptr;
    static inline Type* IndexPtrTy = nullptr;
    static inline Type* SelectPtrTy = nullptr;
    static inline Type* FKeyPtrTy = nullptr;
    static inline Type* ExprListPtrTy = nullptr;
    static inline Type* TriggerPtrTy = nullptr;
    static inline Type* TableTy = nullptr;
    static inline Type* ExprPtrTy = nullptr;
    static inline Type* ColumnTy = nullptr;
    static inline Type* AggInfoPtrTy = nullptr;
    static inline Type* ExprTy = nullptr;
    static inline Type* anonTy = nullptr;
    static inline Type* anonPtrTy = nullptr;
    static inline Type* anon0Ty = nullptr;
    static inline Type* anon0PtrTy = nullptr;
    static inline Type* AggInfo_colPtrTy = nullptr;
    static inline Type* AggInfo_funcPtrTy = nullptr;
    static inline Type* AggInfoTy = nullptr;
    static inline Type* AggInfo_colTy = nullptr;
    static inline Type* FuncDefPtrTy = nullptr;
    static inline Type* AggInfo_funcTy = nullptr;
    static inline Type* sqlite3_contextPtrTy = nullptr;
    static inline Type* Void_Of_sqlite3_contextPtr__i32__sqlite3_valuePtrPtrTy = nullptr;
    static inline Type* Void_Of_sqlite3_contextPtr__i32__sqlite3_valuePtrPtrPtrTy = nullptr;
    static inline Type* Void_Of_sqlite3_contextPtrTy = nullptr;
    static inline Type* Void_Of_sqlite3_contextPtrPtrTy = nullptr;
    static inline Type* FuncDefTy = nullptr;
    static inline Type* Arr_1_sqlite3_valuePtrTy = nullptr;
    static inline Type* sqlite3_contextTy = nullptr;
    static inline Type* anon8Ty = nullptr;
    static inline Type* anon8PtrTy = nullptr;
    static inline Type* anon4Ty = nullptr;
    static inline Type* anon4PtrTy = nullptr;
    static inline Type* i16PtrTy = nullptr;
    static inline Type* Arr_3_i8Ty = nullptr;
    static inline Type* IndexTy = nullptr;
    static inline Type* Arr_2_i32Ty = nullptr;
    static inline Type* SrcListPtrTy = nullptr;
    static inline Type* WithPtrTy = nullptr;
    static inline Type* WindowPtrTy = nullptr;
    static inline Type* SelectTy = nullptr;
    static inline Type* IdListPtrTy = nullptr;
    static inline Type* SrcList_itemTy = nullptr;
    static inline Type* SrcList_itemPtrTy = nullptr;
    static inline Type* Arr_1_SrcList_itemTy = nullptr;
    static inline Type* SrcListTy = nullptr;
    static inline Type* anon2Ty = nullptr;
    static inline Type* anon2PtrTy = nullptr;
    static inline Type* IdList_itemPtrTy = nullptr;
    static inline Type* IdListTy = nullptr;
    static inline Type* IdList_itemTy = nullptr;
    static inline Type* anon3Ty = nullptr;
    static inline Type* anon3PtrTy = nullptr;
    static inline Type* CteTy = nullptr;
    static inline Type* CtePtrTy = nullptr;
    static inline Type* Arr_1_CteTy = nullptr;
    static inline Type* WithTy = nullptr;
    static inline Type* WindowPtrPtrTy = nullptr;
    static inline Type* WindowTy = nullptr;
    static inline Type* sColMapTy = nullptr;
    static inline Type* sColMapPtrTy = nullptr;
    static inline Type* Arr_2_TriggerPtrTy = nullptr;
    static inline Type* Arr_1_sColMapTy = nullptr;
    static inline Type* FKeyTy = nullptr;
    static inline Type* ExprList_itemTy = nullptr;
    static inline Type* ExprList_itemPtrTy = nullptr;
    static inline Type* Arr_1_ExprList_itemTy = nullptr;
    static inline Type* ExprListTy = nullptr;
    static inline Type* anon1Ty = nullptr;
    static inline Type* anon1PtrTy = nullptr;
    static inline Type* TriggerStepPtrTy = nullptr;
    static inline Type* TriggerTy = nullptr;
    static inline Type* UpsertPtrTy = nullptr;
    static inline Type* TriggerStepTy = nullptr;
    static inline Type* UpsertTy = nullptr;
    static inline Type* sqlite3InitInfoTy = nullptr;
    static inline Type* sqlite3InitInfoPtrTy = nullptr;
    static inline Type* TableLockPtrTy = nullptr;
    static inline Type* AutoincInfoPtrTy = nullptr;
    static inline Type* Arr_8_i32Ty = nullptr;
    static inline Type* TablePtrPtrTy = nullptr;
    static inline Type* TriggerPrgPtrTy = nullptr;
    static inline Type* RenameTokenPtrTy = nullptr;
    static inline Type* ParseTy = nullptr;
    static inline Type* TableLockTy = nullptr;
    static inline Type* AutoincInfoTy = nullptr;
    static inline Type* TokenTy = nullptr;
    static inline Type* TokenPtrTy = nullptr;
    static inline Type* TriggerPrgTy = nullptr;
    static inline Type* RenameTokenTy = nullptr;
    static inline Type* anon6Ty = nullptr;
    static inline Type* anon6PtrTy = nullptr;
    static inline Type* Arr_3_i32Ty = nullptr;
    static inline Type* LookasideSlotPtrTy = nullptr;
    static inline Type* LookasideTy = nullptr;
    static inline Type* LookasidePtrTy = nullptr;
    static inline Type* LookasideSlotTy = nullptr;
    static inline Type* VtabCtxTy = nullptr;
    static inline Type* ModulePtrTy = nullptr;
    static inline Type* sqlite3_vtabPtrTy = nullptr;
    static inline Type* VTableTy = nullptr;
    static inline Type* sqlite3_modulePtrTy = nullptr;
    static inline Type* ModuleTy = nullptr;
    static inline Type* sqlite3_vtabPtrPtrTy = nullptr;
    static inline Type* i32_Of_sqlite3Ptr__i8Ptr__i32__i8PtrPtr__sqlite3_vtabPtrPtr__i8PtrPtrTy = nullptr;
    static inline Type* i32_Of_sqlite3Ptr__i8Ptr__i32__i8PtrPtr__sqlite3_vtabPtrPtr__i8PtrPtrPtrTy = nullptr;
    static inline Type* sqlite3_index_infoPtrTy = nullptr;
    static inline Type* i32_Of_sqlite3_vtabPtr__sqlite3_index_infoPtrTy = nullptr;
    static inline Type* i32_Of_sqlite3_vtabPtr__sqlite3_index_infoPtrPtrTy = nullptr;
    static inline Type* i32_Of_sqlite3_vtabPtrTy = nullptr;
    static inline Type* i32_Of_sqlite3_vtabPtrPtrTy = nullptr;
    static inline Type* sqlite3_vtab_cursorPtrTy = nullptr;
    static inline Type* sqlite3_vtab_cursorPtrPtrTy = nullptr;
    static inline Type* i32_Of_sqlite3_vtabPtr__sqlite3_vtab_cursorPtrPtrTy = nullptr;
    static inline Type* i32_Of_sqlite3_vtabPtr__sqlite3_vtab_cursorPtrPtrPtrTy = nullptr;
    static inline Type* i32_Of_sqlite3_vtab_cursorPtrTy = nullptr;
    static inline Type* i32_Of_sqlite3_vtab_cursorPtrPtrTy = nullptr;
    static inline Type* i32_Of_sqlite3_vtab_cursorPtr__i32__i8Ptr__i32__sqlite3_valuePtrPtrTy = nullptr;
    static inline Type* i32_Of_sqlite3_vtab_cursorPtr__i32__i8Ptr__i32__sqlite3_valuePtrPtrPtrTy = nullptr;
    static inline Type* i32_Of_sqlite3_vtab_cursorPtr__sqlite3_contextPtr__i32Ty = nullptr;
    static inline Type* i32_Of_sqlite3_vtab_cursorPtr__sqlite3_contextPtr__i32PtrTy = nullptr;
    static inline Type* i32_Of_sqlite3_vtab_cursorPtr__i64PtrTy = nullptr;
    static inline Type* i32_Of_sqlite3_vtab_cursorPtr__i64PtrPtrTy = nullptr;
    static inline Type* i32_Of_sqlite3_vtabPtr__i32__sqlite3_valuePtrPtr__i64PtrTy = nullptr;
    static inline Type* i32_Of_sqlite3_vtabPtr__i32__sqlite3_valuePtrPtr__i64PtrPtrTy = nullptr;
    static inline Type* EmptyStructPtrPtrTy = nullptr;
    static inline Type* i32_Of_sqlite3_vtabPtr__i32__i8Ptr__EmptyStructPtrPtr__i8PtrPtrTy = nullptr;
    static inline Type* i32_Of_sqlite3_vtabPtr__i32__i8Ptr__EmptyStructPtrPtr__i8PtrPtrPtrTy = nullptr;
    static inline Type* i32_Of_sqlite3_vtabPtr__i8PtrTy = nullptr;
    static inline Type* i32_Of_sqlite3_vtabPtr__i8PtrPtrTy = nullptr;
    static inline Type* i32_Of_sqlite3_vtabPtr__i32Ty = nullptr;
    static inline Type* i32_Of_sqlite3_vtabPtr__i32PtrTy = nullptr;
    static inline Type* sqlite3_moduleTy = nullptr;
    static inline Type* sqlite3_index_constraintPtrTy = nullptr;
    static inline Type* sqlite3_index_orderbyPtrTy = nullptr;
    static inline Type* sqlite3_index_constraint_usagePtrTy = nullptr;
    static inline Type* sqlite3_index_infoTy = nullptr;
    static inline Type* sqlite3_index_constraintTy = nullptr;
    static inline Type* sqlite3_index_orderbyTy = nullptr;
    static inline Type* sqlite3_index_constraint_usageTy = nullptr;
    static inline Type* sqlite3_vtab_cursorTy = nullptr;
    static inline Type* sqlite3_vtabTy = nullptr;
    static inline Type* HashElemPtrTy = nullptr;
    static inline Type* _htPtrTy = nullptr;
    static inline Type* HashTy = nullptr;
    static inline Type* HashPtrTy = nullptr;
    static inline Type* HashElemTy = nullptr;
    static inline Type* _htTy = nullptr;
    static inline Type* i32_Of_i8Ptr__i32Ty = nullptr;
    static inline Type* i32_Of_i8Ptr__i32PtrTy = nullptr;
    static inline Type* BusyHandlerTy = nullptr;
    static inline Type* BusyHandlerPtrTy = nullptr;
    static inline Type* SavepointTy = nullptr;
    static inline Type* UnpackedRecordTy = nullptr;
    static inline Type* UnpackedRecordPtrTy = nullptr;
    static inline Type* BtreePayloadTy = nullptr;
    static inline Type* BtreePayloadPtrTy = nullptr;
    static inline Type* InitDataTy = nullptr;
    static inline Type* InitDataPtrTy = nullptr;
    static inline Type* PagerTy = nullptr;
    static inline Type* PagerPtrTy = nullptr;
    static inline Type* VdbeSorterTy = nullptr;
    static inline Type* VdbeSorterPtrTy = nullptr;
    static inline Type* RowSetTy = nullptr;
    static inline Type* RowSetPtrTy = nullptr;
};

