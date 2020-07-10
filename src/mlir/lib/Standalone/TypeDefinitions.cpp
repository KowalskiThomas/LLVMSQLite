#include <unordered_map>

#include <llvm/IRReader/IRReader.h>
#include <llvm/IR/DerivedTypes.h>
#include <llvm/Support/raw_ostream.h>

#include "Standalone/ErrorCodes.h"
#include "Standalone/DebugUtils.h"
#include "Standalone/TypeDefinitions.h"
#include "Standalone/Utils.h"

std::unique_ptr<llvm::Module> loadedModule;

using mlir::LLVM::LLVMDialect;
using mlir::LLVM::LLVMType;

void load_type_definitions(mlir::LLVM::LLVMDialect* d) {
    using t = T::t;
    using namespace mlir;

    T::voidTy = t::getVoidTy(d);
    
    out("Loading sqlite3.ll");
    llvm::SMDiagnostic diag;
    loadedModule = llvm::parseIRFile("sqlite3.ll", diag, d->getLLVMContext());
    if (!loadedModule) {
        err("Error while loading module: " << diag.getMessage());
        exit(SQLITE_BRIDGE_FAILURE);
    }
    
    T::Sqlite3ConfigTy = LLVMType::get(d->getContext(), loadedModule->getTypeByName("struct.Sqlite3Config"));
    T::DbTy = LLVMType::get(d->getContext(), loadedModule->getTypeByName("struct.Db"));
    T::sqlite3_valueTy = LLVMType::get(d->getContext(), loadedModule->getTypeByName("struct.sqlite3_value"));
    T::MemValueTy = LLVMType::get(d->getContext(), loadedModule->getTypeByName("union.MemValue"));
    T::sqlite3Ty = LLVMType::get(d->getContext(), loadedModule->getTypeByName("struct.sqlite3"));
    T::BtreeTy = LLVMType::get(d->getContext(), loadedModule->getTypeByName("struct.Btree"));

    T::sqlite3_vfsTy = LLVMType::get(d->getContext(), loadedModule->getTypeByName("struct.sqlite3_vfs"));
    T::sqlite3_fileTy = LLVMType::get(d->getContext(), loadedModule->getTypeByName("struct.sqlite3_file"));
    T::sqlite3_io_methodsTy = LLVMType::get(d->getContext(), loadedModule->getTypeByName("struct.sqlite3_io_methods"));
    T::VdbeTy = LLVMType::get(d->getContext(), loadedModule->getTypeByName("struct.Vdbe"));
    T::VdbeCursorTy = LLVMType::get(d->getContext(), loadedModule->getTypeByName("struct.VdbeCursor"));
    T::KeyInfoTy = LLVMType::get(d->getContext(), loadedModule->getTypeByName("struct.KeyInfo"));
    T::VdbeOpTy = LLVMType::get(d->getContext(), loadedModule->getTypeByName("struct.VdbeOp"));
    T::p4unionTy = LLVMType::get(d->getContext(), loadedModule->getTypeByName("union.p4union"));
    T::VdbeFrameTy = LLVMType::get(d->getContext(), loadedModule->getTypeByName("struct.VdbeFrame"));
    T::SubProgramTy = LLVMType::get(d->getContext(), loadedModule->getTypeByName("struct.SubProgram"));
    T::AuxDataTy = LLVMType::get(d->getContext(), loadedModule->getTypeByName("struct.AuxData"));
    T::CollSeqTy = LLVMType::get(d->getContext(), loadedModule->getTypeByName("struct.CollSeq"));
    T::SchemaTy = LLVMType::get(d->getContext(), loadedModule->getTypeByName("struct.Schema"));
    T::TableTy = LLVMType::get(d->getContext(), loadedModule->getTypeByName("struct.Table"));
    T::ColumnTy = LLVMType::get(d->getContext(), loadedModule->getTypeByName("struct.Column"));
    T::ExprTy = LLVMType::get(d->getContext(), loadedModule->getTypeByName("struct.Expr"));
    T::AggInfoTy = LLVMType::get(d->getContext(), loadedModule->getTypeByName("struct.AggInfo"));
    T::AggInfo_colTy = LLVMType::get(d->getContext(), loadedModule->getTypeByName("struct.AggInfo_col"));
    T::AggInfo_funcTy = LLVMType::get(d->getContext(), loadedModule->getTypeByName("struct.AggInfo_func"));
    T::FuncDefTy = LLVMType::get(d->getContext(), loadedModule->getTypeByName("struct.FuncDef"));
    T::sqlite3_contextTy = LLVMType::get(d->getContext(), loadedModule->getTypeByName("struct.sqlite3_context"));
    T::IndexTy = LLVMType::get(d->getContext(), loadedModule->getTypeByName("struct.Index"));
    T::SelectTy = LLVMType::get(d->getContext(), loadedModule->getTypeByName("struct.Select"));
    T::SrcList_itemTy = LLVMType::get(d->getContext(), loadedModule->getTypeByName("struct.SrcList_item"));
    T::SrcListTy = LLVMType::get(d->getContext(), loadedModule->getTypeByName("struct.SrcList"));
    T::VTableTy = LLVMType::get(d->getContext(), loadedModule->getTypeByName("struct.VTable"));
    T::sqlite3_vtab_cursorTy = LLVMType::get(d->getContext(), loadedModule->getTypeByName("struct.sqlite3_vtab_cursor"));
    T::UnpackedRecordTy = LLVMType::get(d->getContext(), loadedModule->getTypeByName("struct.UnpackedRecord"));
    T::UnpackedRecordPtrTy = T::UnpackedRecordTy.getPointerTo();

    T::BtreePayloadTy = LLVMType::get(d->getContext(), loadedModule->getTypeByName("struct.BtreePayload"));
    T::BtreePayloadPtrTy = T::BtreePayloadTy.getPointerTo();

    T::i1Ty = t::getIntNTy(d, 1);

    T::SchemaPtrTy = T::SchemaTy.getPointerTo();
    T::sqlite3_vfsPtrTy = T::sqlite3_vfsTy.getPointerTo();
    T::CollSeqPtrTy = T::CollSeqTy.getPointerTo();
    T::BtCursorTy = LLVMType::get(d->getContext(), loadedModule->getTypeByName("struct.BtCursor"));
    T::sqlite3_valuePtrTy = T::sqlite3_valueTy.getPointerTo();
    T::sqlite3_vtab_cursorPtrTy = T::sqlite3_vtab_cursorTy.getPointerTo();
    T::TablePtrTy = T::TableTy.getPointerTo();
    T::VdbeCursorPtrTy = T::VdbeCursorTy.getPointerTo();
    T::VdbePtrTy = T::VdbeTy.getPointerTo();
    T::sqlite3_mutexTy = LLVMType::get(d->getContext(), loadedModule->getTypeByName("struct.sqlite3_mutex"));
    T::i64Ty = t::getIntNTy(d, 64);
    T::RowSetTy = LLVMType::get(d->getContext(), loadedModule->getTypeByName("struct.RowSet"));
    T::RowSetPtrTy = T::RowSetTy.getPointerTo();
    T::VTablePtrTy = T::VTableTy.getPointerTo();
    T::KeyInfoPtrTy = T::KeyInfoTy.getPointerTo();
    T::VoidTy = T::voidTy;
    T::VdbeFramePtrTy = T::VdbeFrameTy.getPointerTo();
    T::VdbeOpPtrTy = T::VdbeOpTy.getPointerTo();
    T::p4unionPtrTy = T::p4unionTy.getPointerTo();
    T::TableLockTy = LLVMType::get(d->getContext(), loadedModule->getTypeByName("struct.TableLock"));
    T::FuncDefPtrTy = T::FuncDefTy.getPointerTo();
    T::i32Ty = t::getIntNTy(d, 32);
    T::sqlite3PtrTy = T::sqlite3Ty.getPointerTo();
    T::i8Ty = t::getIntNTy(d, 8);
    T::VtabCtxTy = LLVMType::get(d->getContext(), loadedModule->getTypeByName("struct.VtabCtx"));
    T::sqlite3_contextPtrTy = T::sqlite3_contextTy.getPointerTo();
    T::ColumnPtrTy = T::ColumnTy.getPointerTo();
    T::DbPtrTy = T::DbTy.getPointerTo();
    T::i16Ty = t::getIntNTy(d, 16);
    T::VdbeSorterTy = LLVMType::get(d->getContext(), loadedModule->getTypeByName("struct.VdbeSorter"));
    T::doubleTy = t::getDoubleTy(d);
    T::Arr_1_sqlite3_valuePtrTy = t::getArrayTy(T::sqlite3_valueTy.getPointerTo(), 1);
    T::i64PtrTy = T::i64Ty.getPointerTo();
    T::BtreePtrTy = T::BtreeTy.getPointerTo();
    T::i32PtrTy = T::i32Ty.getPointerTo();
    T::TablePtrPtrTy = T::TablePtrTy.getPointerTo();
    T::sqlite3_vtab_cursorPtrPtrTy = T::sqlite3_vtab_cursorPtrTy.getPointerTo();
    T::i8PtrTy = T::i8Ty.getPointerTo();
    T::VtabCtxPtrTy = T::VtabCtxTy.getPointerTo();
    T::TableLockPtrTy = T::TableLockTy.getPointerTo();
    T::i16PtrTy = T::i16Ty.getPointerTo();
    T::VdbeCursorPtrPtrTy = T::VdbeCursorPtrTy.getPointerTo();
    T::Arr_1_CollSeqPtrTy = t::getArrayTy(T::CollSeqTy.getPointerTo(), 1);
    T::Arr_12_i32Ty = t::getArrayTy(t::getIntNTy(d, 32), 12);
    T::Arr_2_i8Ty = t::getArrayTy(t::getIntNTy(d, 8), 2);
    T::i32_Of_sqlite3_vtab_cursorPtr_sqlite3_contextPtr_i32Ty = t::getFunctionTy(t::getIntNTy(d, 32), {T::sqlite3_vtab_cursorPtrTy, T::sqlite3_contextPtrTy, T::i32Ty}, false);
    T::sqlite3_mutexPtrTy = T::sqlite3_mutexTy.getPointerTo();
    T::BtCursorPtrTy = T::BtCursorTy.getPointerTo();
    T::doublePtrTy = T::doubleTy.getPointerTo();
    T::sqlite3_valuePtrPtrTy = T::sqlite3_valuePtrTy.getPointerTo();
    T::VTablePtrPtrTy = T::VTablePtrTy.getPointerTo();
    T::i8PtrPtrTy = T::i8PtrTy.getPointerTo();
}
