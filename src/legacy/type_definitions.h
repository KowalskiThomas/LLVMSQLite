#include "vdbe_exec.h"
#define SQLITE_JIT_IR_TYPE static inline llvm::Type*
void load_type_definitions(LLVMContext&);

struct T {
    static inline StructType* Sqlite3ConfigTy = nullptr;
    static inline StructType* sqlite3_mem_methodsTy = nullptr;
    static inline StructType* sqlite3_mutex_methodsTy = nullptr;
    static inline StructType* sqlite3_pcache_methods2Ty = nullptr;
    static inline StructType* sqlite3_pcache_pageTy = nullptr;
    static inline StructType* DbTy = nullptr;
    static inline StructType* sqlite3_valueTy = nullptr;
    static inline StructType* MemValueTy = nullptr;
    static inline StructType* sqlite3Ty = nullptr;
    static inline StructType* sqlite3_vfsTy = nullptr;
    static inline StructType* sqlite3_fileTy = nullptr;
    static inline StructType* sqlite3_io_methodsTy = nullptr;
    static inline StructType* VdbeTy = nullptr;
    static inline StructType* VdbeCursorTy = nullptr;
    static inline StructType* anon7Ty = nullptr;
    static inline StructType* KeyInfoTy = nullptr;
    static inline StructType* VdbeOpTy = nullptr;
    static inline StructType* p4unionTy = nullptr;
    static inline StructType* VdbeFrameTy = nullptr;
    static inline StructType* SubProgramTy = nullptr;
    static inline StructType* AuxDataTy = nullptr;
    static inline StructType* CollSeqTy = nullptr;
    static inline StructType* SchemaTy = nullptr;
    static inline StructType* TableTy = nullptr;
    static inline StructType* ColumnTy = nullptr;
    static inline StructType* ExprTy = nullptr;
    static inline StructType* anonTy = nullptr;
    static inline StructType* anon0Ty = nullptr;
    static inline StructType* AggInfoTy = nullptr;
    static inline StructType* AggInfo_colTy = nullptr;
    static inline StructType* AggInfo_funcTy = nullptr;
    static inline StructType* FuncDefTy = nullptr;
    static inline StructType* sqlite3_contextTy = nullptr;
    static inline StructType* anon8Ty = nullptr;
    static inline StructType* anon4Ty = nullptr;
    static inline StructType* IndexTy = nullptr;
    static inline StructType* SelectTy = nullptr;
    static inline StructType* SrcList_itemTy = nullptr;
    static inline StructType* SrcListTy = nullptr;
    static inline StructType* anon2Ty = nullptr;
    static inline StructType* IdListTy = nullptr;
    static inline StructType* IdList_itemTy = nullptr;
    static inline StructType* anon3Ty = nullptr;
    static inline StructType* CteTy = nullptr;
    static inline StructType* WithTy = nullptr;
    static inline StructType* WindowTy = nullptr;
    static inline StructType* sColMapTy = nullptr;
    static inline StructType* FKeyTy = nullptr;
    static inline StructType* ExprList_itemTy = nullptr;
    static inline StructType* ExprListTy = nullptr;
    static inline StructType* anon1Ty = nullptr;
    static inline StructType* TriggerTy = nullptr;
    static inline StructType* TriggerStepTy = nullptr;
    static inline StructType* UpsertTy = nullptr;
    static inline StructType* sqlite3InitInfoTy = nullptr;
    static inline StructType* ParseTy = nullptr;
    static inline StructType* AutoincInfoTy = nullptr;
    static inline StructType* TokenTy = nullptr;
    static inline StructType* TriggerPrgTy = nullptr;
    static inline StructType* anon6Ty = nullptr;
    static inline StructType* LookasideTy = nullptr;
    static inline StructType* LookasideSlotTy = nullptr;
    static inline StructType* VTableTy = nullptr;
    static inline StructType* ModuleTy = nullptr;
    static inline StructType* sqlite3_moduleTy = nullptr;
    static inline StructType* sqlite3_index_infoTy = nullptr;
    static inline StructType* sqlite3_index_constraintTy = nullptr;
    static inline StructType* sqlite3_index_orderbyTy = nullptr;
    static inline StructType* sqlite3_index_constraint_usageTy = nullptr;
    static inline StructType* sqlite3_vtab_cursorTy = nullptr;
    static inline StructType* sqlite3_vtabTy = nullptr;
    static inline StructType* HashTy = nullptr;
    static inline StructType* HashElemTy = nullptr;
    static inline StructType* _htTy = nullptr;
    static inline StructType* BusyHandlerTy = nullptr;
    static inline StructType* SavepointTy = nullptr;
    static inline StructType* UnpackedRecordTy = nullptr;
    static inline StructType* BtreePayloadTy = nullptr;
    static inline StructType* InitDataTy = nullptr;
    SQLITE_JIT_IR_TYPE i32Ty = nullptr;
    SQLITE_JIT_IR_TYPE i8Ty = nullptr;
    SQLITE_JIT_IR_TYPE i8PtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i64Ty = nullptr;
    SQLITE_JIT_IR_TYPE sqlite3_mutexPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE VoidTy = nullptr;
    SQLITE_JIT_IR_TYPE Void_Of_i8Ptr_i32_i8PtrTy = nullptr;
    SQLITE_JIT_IR_TYPE Void_Of_i8Ptr_i32_i8PtrPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_i32Ty = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_i32PtrTy = nullptr;
    SQLITE_JIT_IR_TYPE Sqlite3ConfigPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i8Ptr_Of_i32Ty = nullptr;
    SQLITE_JIT_IR_TYPE i8Ptr_Of_i32PtrTy = nullptr;
    SQLITE_JIT_IR_TYPE Void_Of_i8PtrTy = nullptr;
    SQLITE_JIT_IR_TYPE Void_Of_i8PtrPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i8Ptr_Of_i8Ptr_i32Ty = nullptr;
    SQLITE_JIT_IR_TYPE i8Ptr_Of_i8Ptr_i32PtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_i8PtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_i8PtrPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE sqlite3_mem_methodsPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_VoidTy = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_VoidPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE sqlite3_mutexPtr_Of_i32Ty = nullptr;
    SQLITE_JIT_IR_TYPE sqlite3_mutexPtr_Of_i32PtrTy = nullptr;
    SQLITE_JIT_IR_TYPE Void_Of_sqlite3_mutexPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE Void_Of_sqlite3_mutexPtrPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_sqlite3_mutexPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_sqlite3_mutexPtrPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE sqlite3_mutex_methodsPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE sqlite3_pcachePtrTy = nullptr;
    SQLITE_JIT_IR_TYPE sqlite3_pcachePtr_Of_i32_i32_i32Ty = nullptr;
    SQLITE_JIT_IR_TYPE sqlite3_pcachePtr_Of_i32_i32_i32PtrTy = nullptr;
    SQLITE_JIT_IR_TYPE Void_Of_sqlite3_pcachePtr_i32Ty = nullptr;
    SQLITE_JIT_IR_TYPE Void_Of_sqlite3_pcachePtr_i32PtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_sqlite3_pcachePtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_sqlite3_pcachePtrPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE sqlite3_pcache_pagePtrTy = nullptr;
    SQLITE_JIT_IR_TYPE sqlite3_pcache_pagePtr_Of_sqlite3_pcachePtr_i32_i32Ty = nullptr;
    SQLITE_JIT_IR_TYPE sqlite3_pcache_pagePtr_Of_sqlite3_pcachePtr_i32_i32PtrTy = nullptr;
    SQLITE_JIT_IR_TYPE Void_Of_sqlite3_pcachePtr_sqlite3_pcache_pagePtr_i32Ty = nullptr;
    SQLITE_JIT_IR_TYPE Void_Of_sqlite3_pcachePtr_sqlite3_pcache_pagePtr_i32PtrTy = nullptr;
    SQLITE_JIT_IR_TYPE Void_Of_sqlite3_pcachePtr_sqlite3_pcache_pagePtr_i32_i32Ty = nullptr;
    SQLITE_JIT_IR_TYPE Void_Of_sqlite3_pcachePtr_sqlite3_pcache_pagePtr_i32_i32PtrTy = nullptr;
    SQLITE_JIT_IR_TYPE Void_Of_sqlite3_pcachePtrTy = nullptr;
    SQLITE_JIT_IR_TYPE Void_Of_sqlite3_pcachePtrPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE sqlite3_pcache_methods2PtrTy = nullptr;
    SQLITE_JIT_IR_TYPE sqlite3_pcacheTy = nullptr;
    SQLITE_JIT_IR_TYPE sqlite3_mutexTy = nullptr;
    SQLITE_JIT_IR_TYPE BtreePtrTy = nullptr;
    SQLITE_JIT_IR_TYPE SchemaPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE DbPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i16Ty = nullptr;
    SQLITE_JIT_IR_TYPE sqlite3PtrTy = nullptr;
    SQLITE_JIT_IR_TYPE sqlite3_valuePtrTy = nullptr;
    SQLITE_JIT_IR_TYPE doubleTy = nullptr;
    SQLITE_JIT_IR_TYPE MemValuePtrTy = nullptr;
    SQLITE_JIT_IR_TYPE sqlite3_vfsPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE VdbePtrTy = nullptr;
    SQLITE_JIT_IR_TYPE CollSeqPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE Arr_12_i32Ty = nullptr;
    SQLITE_JIT_IR_TYPE i8PtrPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_i32_i8Ptr_i8Ptr_i8PtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_i32_i8Ptr_i8Ptr_i8PtrPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE Void_Of_i8Ptr_i8Ptr_i64Ty = nullptr;
    SQLITE_JIT_IR_TYPE Void_Of_i8Ptr_i8Ptr_i64PtrTy = nullptr;
    SQLITE_JIT_IR_TYPE Void_Of_i8Ptr_i32_i8Ptr_i8Ptr_i64Ty = nullptr;
    SQLITE_JIT_IR_TYPE Void_Of_i8Ptr_i32_i8Ptr_i8Ptr_i64PtrTy = nullptr;
    SQLITE_JIT_IR_TYPE ParsePtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_i8Ptr_sqlite3Ptr_i8Ptr_i32Ty = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_i8Ptr_sqlite3Ptr_i8Ptr_i32PtrTy = nullptr;
    SQLITE_JIT_IR_TYPE Void_Of_i8Ptr_sqlite3Ptr_i32_i8PtrTy = nullptr;
    SQLITE_JIT_IR_TYPE Void_Of_i8Ptr_sqlite3Ptr_i32_i8PtrPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_i8Ptr_i32_i8Ptr_i8Ptr_i8Ptr_i8PtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_i8Ptr_i32_i8Ptr_i8Ptr_i8Ptr_i8PtrPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE VtabCtxPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE VTablePtrTy = nullptr;
    SQLITE_JIT_IR_TYPE VTablePtrPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE Arr_2_DbTy = nullptr;
    SQLITE_JIT_IR_TYPE SavepointPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i32PtrTy = nullptr;
    SQLITE_JIT_IR_TYPE sqlite3_filePtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_sqlite3_vfsPtr_i8Ptr_sqlite3_filePtr_i32_i32PtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_sqlite3_vfsPtr_i8Ptr_sqlite3_filePtr_i32_i32PtrPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_sqlite3_vfsPtr_i8Ptr_i32Ty = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_sqlite3_vfsPtr_i8Ptr_i32PtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_sqlite3_vfsPtr_i8Ptr_i32_i32PtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_sqlite3_vfsPtr_i8Ptr_i32_i32PtrPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_sqlite3_vfsPtr_i8Ptr_i32_i8PtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_sqlite3_vfsPtr_i8Ptr_i32_i8PtrPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i8Ptr_Of_sqlite3_vfsPtr_i8PtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i8Ptr_Of_sqlite3_vfsPtr_i8PtrPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE Void_Of_sqlite3_vfsPtr_i32_i8PtrTy = nullptr;
    SQLITE_JIT_IR_TYPE Void_Of_sqlite3_vfsPtr_i32_i8PtrPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE Void_Of_Void_Of_Sqlite3_Vfs_i8Ptr_i8PtrTy = nullptr;
    SQLITE_JIT_IR_TYPE Void_Of_sqlite3_vfsPtr_i8PtrTy = nullptr;
    SQLITE_JIT_IR_TYPE Void_Of_sqlite3_vfsPtr_i8PtrPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_sqlite3_vfsPtr_i32_i8PtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_sqlite3_vfsPtr_i32_i8PtrPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_sqlite3_vfsPtr_i32Ty = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_sqlite3_vfsPtr_i32PtrTy = nullptr;
    SQLITE_JIT_IR_TYPE doublePtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_sqlite3_vfsPtr_doublePtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_sqlite3_vfsPtr_doublePtrPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i64PtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_sqlite3_vfsPtr_i64PtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_sqlite3_vfsPtr_i64PtrPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE Void_Of_VoidTy = nullptr;
    SQLITE_JIT_IR_TYPE Void_Of_VoidPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_sqlite3_vfsPtr_i8Ptr_Void_Of_VoidPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_sqlite3_vfsPtr_i8Ptr_Void_Of_VoidPtrPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE Void_Of_Void_Of_Sqlite3_Vfs_i8PtrTy = nullptr;
    SQLITE_JIT_IR_TYPE sqlite3_io_methodsPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_sqlite3_filePtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_sqlite3_filePtrPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_sqlite3_filePtr_i8Ptr_i32_i64Ty = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_sqlite3_filePtr_i8Ptr_i32_i64PtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_sqlite3_filePtr_i64Ty = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_sqlite3_filePtr_i64PtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_sqlite3_filePtr_i32Ty = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_sqlite3_filePtr_i32PtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_sqlite3_filePtr_i64PtrPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_sqlite3_filePtr_i32PtrPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_sqlite3_filePtr_i32_i8PtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_sqlite3_filePtr_i32_i8PtrPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_sqlite3_filePtr_i32_i32_i32_i8PtrPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_sqlite3_filePtr_i32_i32_i32_i8PtrPtrPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_sqlite3_filePtr_i32_i32_i32Ty = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_sqlite3_filePtr_i32_i32_i32PtrTy = nullptr;
    SQLITE_JIT_IR_TYPE Void_Of_sqlite3_filePtrTy = nullptr;
    SQLITE_JIT_IR_TYPE Void_Of_sqlite3_filePtrPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_sqlite3_filePtr_i64_i32_i8PtrPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_sqlite3_filePtr_i64_i32_i8PtrPtrPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_sqlite3_filePtr_i64_i8PtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_sqlite3_filePtr_i64_i8PtrPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE Arr_2_i8Ty = nullptr;
    SQLITE_JIT_IR_TYPE Arr_4_i8Ty = nullptr;
    SQLITE_JIT_IR_TYPE sqlite3_valuePtrPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE VdbeCursorPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE VdbeCursorPtrPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE VdbeOpPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE Arr_7_i32Ty = nullptr;
    SQLITE_JIT_IR_TYPE VdbeFramePtrTy = nullptr;
    SQLITE_JIT_IR_TYPE SubProgramPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE AuxDataPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE KeyInfoPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE Arr_1_i32Ty = nullptr;
    SQLITE_JIT_IR_TYPE BtreeTy = nullptr;
    SQLITE_JIT_IR_TYPE BtCursorPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE anon7PtrTy = nullptr;
    SQLITE_JIT_IR_TYPE BtCursorTy = nullptr;
    SQLITE_JIT_IR_TYPE Arr_1_CollSeqPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE p4unionPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_i8Ptr_i32_i8Ptr_i32_i8PtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_i8Ptr_i32_i8Ptr_i32_i8PtrPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE TablePtrTy = nullptr;
    SQLITE_JIT_IR_TYPE ColumnPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE IndexPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE SelectPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE FKeyPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE ExprListPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE TriggerPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE ExprPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE AggInfoPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE anonPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE anon0PtrTy = nullptr;
    SQLITE_JIT_IR_TYPE AggInfo_colPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE AggInfo_funcPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE FuncDefPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE sqlite3_contextPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE Void_Of_sqlite3_contextPtr_i32_sqlite3_valuePtrPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE Void_Of_sqlite3_contextPtr_i32_sqlite3_valuePtrPtrPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE Void_Of_sqlite3_contextPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE Void_Of_sqlite3_contextPtrPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE Arr_1_sqlite3_valuePtrTy = nullptr;
    SQLITE_JIT_IR_TYPE anon8PtrTy = nullptr;
    SQLITE_JIT_IR_TYPE anon4PtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i16PtrTy = nullptr;
    SQLITE_JIT_IR_TYPE Arr_3_i8Ty = nullptr;
    SQLITE_JIT_IR_TYPE Arr_2_i32Ty = nullptr;
    SQLITE_JIT_IR_TYPE SrcListPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE WithPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE WindowPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE IdListPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE SrcList_itemPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE Arr_1_SrcList_itemTy = nullptr;
    SQLITE_JIT_IR_TYPE anon2PtrTy = nullptr;
    SQLITE_JIT_IR_TYPE IdList_itemPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE anon3PtrTy = nullptr;
    SQLITE_JIT_IR_TYPE CtePtrTy = nullptr;
    SQLITE_JIT_IR_TYPE Arr_1_CteTy = nullptr;
    SQLITE_JIT_IR_TYPE WindowPtrPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE sColMapPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE Arr_2_TriggerPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE Arr_1_sColMapTy = nullptr;
    SQLITE_JIT_IR_TYPE ExprList_itemPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE Arr_1_ExprList_itemTy = nullptr;
    SQLITE_JIT_IR_TYPE anon1PtrTy = nullptr;
    SQLITE_JIT_IR_TYPE TriggerStepPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE UpsertPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE sqlite3InitInfoPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE TableLockPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE AutoincInfoPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE Arr_8_i32Ty = nullptr;
    SQLITE_JIT_IR_TYPE TablePtrPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE TriggerPrgPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE RenameTokenPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE TableLockTy = nullptr;
    SQLITE_JIT_IR_TYPE TokenPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE RenameTokenTy = nullptr;
    SQLITE_JIT_IR_TYPE anon6PtrTy = nullptr;
    SQLITE_JIT_IR_TYPE Arr_3_i32Ty = nullptr;
    SQLITE_JIT_IR_TYPE LookasideSlotPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE LookasidePtrTy = nullptr;
    SQLITE_JIT_IR_TYPE VtabCtxTy = nullptr;
    SQLITE_JIT_IR_TYPE ModulePtrTy = nullptr;
    SQLITE_JIT_IR_TYPE sqlite3_vtabPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE sqlite3_modulePtrTy = nullptr;
    SQLITE_JIT_IR_TYPE sqlite3_vtabPtrPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_sqlite3Ptr_i8Ptr_i32_i8PtrPtr_sqlite3_vtabPtrPtr_i8PtrPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_sqlite3Ptr_i8Ptr_i32_i8PtrPtr_sqlite3_vtabPtrPtr_i8PtrPtrPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE sqlite3_index_infoPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_sqlite3_vtabPtr_sqlite3_index_infoPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_sqlite3_vtabPtr_sqlite3_index_infoPtrPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_sqlite3_vtabPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_sqlite3_vtabPtrPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE sqlite3_vtab_cursorPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE sqlite3_vtab_cursorPtrPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_sqlite3_vtabPtr_sqlite3_vtab_cursorPtrPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_sqlite3_vtabPtr_sqlite3_vtab_cursorPtrPtrPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_sqlite3_vtab_cursorPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_sqlite3_vtab_cursorPtrPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_sqlite3_vtab_cursorPtr_i32_i8Ptr_i32_sqlite3_valuePtrPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_sqlite3_vtab_cursorPtr_i32_i8Ptr_i32_sqlite3_valuePtrPtrPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_sqlite3_vtab_cursorPtr_sqlite3_contextPtr_i32Ty = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_sqlite3_vtab_cursorPtr_sqlite3_contextPtr_i32PtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_sqlite3_vtab_cursorPtr_i64PtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_sqlite3_vtab_cursorPtr_i64PtrPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_sqlite3_vtabPtr_i32_sqlite3_valuePtrPtr_i64PtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_sqlite3_vtabPtr_i32_sqlite3_valuePtrPtr_i64PtrPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE PxFunctionPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_sqlite3_vtabPtr_i32_i8Ptr_PxFunctionPtr_i8PtrPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_sqlite3_vtabPtr_i32_i8Ptr_PxFunctionPtr_i8PtrPtrPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_sqlite3_vtabPtr_i8PtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_sqlite3_vtabPtr_i8PtrPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_sqlite3_vtabPtr_i32Ty = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_sqlite3_vtabPtr_i32PtrTy = nullptr;
    SQLITE_JIT_IR_TYPE sqlite3_index_constraintPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE sqlite3_index_orderbyPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE sqlite3_index_constraint_usagePtrTy = nullptr;
    SQLITE_JIT_IR_TYPE HashElemPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE _htPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE HashPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_i8Ptr_i32Ty = nullptr;
    SQLITE_JIT_IR_TYPE i32_Of_i8Ptr_i32PtrTy = nullptr;
    SQLITE_JIT_IR_TYPE BusyHandlerPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE UnpackedRecordPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE BtreePayloadPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE InitDataPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE PagerTy = nullptr;
    SQLITE_JIT_IR_TYPE PagerPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE VdbeSorterTy = nullptr;
    SQLITE_JIT_IR_TYPE VdbeSorterPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE RowSetTy = nullptr;
    SQLITE_JIT_IR_TYPE RowSetPtrTy = nullptr;
    SQLITE_JIT_IR_TYPE i1Ty = nullptr;
};
