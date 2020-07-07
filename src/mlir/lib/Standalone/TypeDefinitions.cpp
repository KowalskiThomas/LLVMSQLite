#include <unordered_map>
#include <llvm/IRReader/IRReader.h>
#include <src/mlir/include/Standalone/ErrorCodes.h>
#include <src/mlir/include/Standalone/DebugUtils.h>
#include "Standalone/TypeDefinitions.h"
#include "Standalone/Utils.h"
#include "llvm/IR/DerivedTypes.h"
#include "llvm/Support/raw_ostream.h"

std::unique_ptr<llvm::Module> loadedModule;


using mlir::LLVM::LLVMDialect;
using mlir::LLVM::LLVMType;

struct TypeConverter {
    LLVMDialect* d;
    llvm::Module& mod;
    std::unordered_map<llvm::Type*, LLVMType> cache;

    TypeConverter(LLVMDialect* d, llvm::Module& m)
        : d(d), mod(m)
    {
    }

    mlir::LLVM::LLVMType get(llvm::Type* ty) {
        LLVMSQLITE_ASSERT(ty && "Can't convert a NULL type reference!");

        if (cache.find(ty) != cache.cend()) {
            out("Cache hit " << *ty << " " << ty);
            return cache[ty];
        }

        out("Converting " << *ty << " " << ty);
        auto result = getImpl(ty);
        out("Converted " << *ty << " to " << result);
        return result;
    }

    mlir::LLVM::LLVMType getImpl(llvm::Type* ty) {
        if (ty->isVoidTy())
            return cache[ty] = LLVMType::getVoidTy(d);
        if (ty->isIntegerTy())
            return cache[ty] = LLVMType::getIntNTy(d, ty->getIntegerBitWidth());
        else if (ty->isFloatTy())
            return cache[ty] = LLVMType::getFloatTy(d);
        else if (ty->isDoubleTy())
            return cache[ty] = LLVMType::getDoubleTy(d);
        else if (ty->isArrayTy())
            return cache[ty] = LLVMType::getArrayTy(get(ty->getArrayElementType()), ty->getArrayNumElements());
        else if (ty->isFunctionTy()) {
            auto fTy = cast<llvm::FunctionType>(ty);
            llvm::SmallVector<LLVMType, 16> inTypes;
            for(auto i = 0; i < fTy->getNumParams(); i++)
                inTypes.push_back(get(fTy->getParamType(i)));

            return cache[ty] = LLVMType::getFunctionTy(get(fTy->getReturnType()), inTypes, fTy->isVarArg());
        } else if (ty->isPointerTy()) {
            return cache[ty] = get(ty->getPointerElementType()).getPointerTo();
        } else if (ty->isStructTy()) {
            auto llvmSTy = cast<llvm::StructType>(ty);

            LLVMType sTy;
            if (llvmSTy->isLiteral())
                sTy = (cache[ty] = LLVMType::createStructTy(d, mlir::Optional<llvm::StringRef>()));
            else {
                std::string name;
                name += ty->getStructName().str() + "ty";
                sTy = (cache[ty] = LLVMType::createStructTy(d, mlir::Optional<llvm::StringRef>(name.c_str())));
            }

            llvm::SmallVector<LLVMType, 64> aggTypes;
            for (int i = 0; i < ty->getStructNumElements(); i++) {
                aggTypes.push_back(get(ty->getStructElementType(i)));
            }

            sTy.setStructTyBody(sTy, aggTypes, llvmSTy->isPacked());
            return cache[ty] = sTy;
        } else if (ty->isVectorTy()) {
            auto vTy = cast<llvm::VectorType>(ty);
            return LLVMType::getVectorTy(get(vTy->getElementType()), vTy->getNumElements());
        } else {
            err("Incompatible type '" << *ty << "'");
            llvm_unreachable("Can't convert this type.");
        }
    }
};

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

    TypeConverter converter(d, *loadedModule);

    T::Sqlite3ConfigTy = converter.get(loadedModule->getTypeByName("struct.Sqlite3Config"));
    T::DbTy = converter.get(loadedModule->getTypeByName("struct.Db"));
    T::sqlite3_valueTy = converter.get(loadedModule->getTypeByName("struct.sqlite3_value"));
    T::MemValueTy = converter.get(loadedModule->getTypeByName("union.MemValue"));
    T::sqlite3Ty = converter.get(loadedModule->getTypeByName("struct.sqlite3"));
    T::BtreeTy = converter.get(loadedModule->getTypeByName("struct.Btree"));

    // T::sqlite3_mem_methodsTy = converter.get(loadedModule->getTypeByName("struct.sqlite3_mem_methods"));
    // T::sqlite3_mutex_methodsTy = converter.get(loadedModule->getTypeByName("struct.sqlite3_mutex_methods"));
    // T::sqlite3_pcache_methods2Ty = converter.get(loadedModule->getTypeByName("struct.sqlite3_pcache_methods2"));
    // T::sqlite3_pcache_pageTy = converter.get(loadedModule->getTypeByName("sqlite3_pcache_page"));
    T::sqlite3_vfsTy = converter.get(loadedModule->getTypeByName("struct.sqlite3_vfs"));
    T::sqlite3_fileTy = converter.get(loadedModule->getTypeByName("struct.sqlite3_file"));
    T::sqlite3_io_methodsTy = converter.get(loadedModule->getTypeByName("struct.sqlite3_io_methods"));
    T::VdbeTy = converter.get(loadedModule->getTypeByName("struct.Vdbe"));
    T::VdbeCursorTy = converter.get(loadedModule->getTypeByName("struct.VdbeCursor"));
    // T::anon7Ty = converter.get(loadedModule->getTypeByName("anon.7"));
    T::KeyInfoTy = converter.get(loadedModule->getTypeByName("struct.KeyInfo"));
    T::VdbeOpTy = converter.get(loadedModule->getTypeByName("struct.VdbeOp"));
    T::p4unionTy = converter.get(loadedModule->getTypeByName("union.p4union"));
    T::VdbeFrameTy = converter.get(loadedModule->getTypeByName("struct.VdbeFrame"));
    T::SubProgramTy = converter.get(loadedModule->getTypeByName("struct.SubProgram"));
    T::AuxDataTy = converter.get(loadedModule->getTypeByName("struct.AuxData"));
    T::CollSeqTy = converter.get(loadedModule->getTypeByName("struct.CollSeq"));
    T::SchemaTy = converter.get(loadedModule->getTypeByName("struct.Schema"));
    T::TableTy = converter.get(loadedModule->getTypeByName("struct.Table"));
    T::ColumnTy = converter.get(loadedModule->getTypeByName("struct.Column"));
    T::ExprTy = converter.get(loadedModule->getTypeByName("struct.Expr"));
    // T::anonTy = converter.get(loadedModule->getTypeByName("anon."));
    // T::anon0Ty = converter.get(loadedModule->getTypeByName("anon.0"));
    T::AggInfoTy = converter.get(loadedModule->getTypeByName("struct.AggInfo"));
    T::AggInfo_colTy = converter.get(loadedModule->getTypeByName("struct.AggInfo_col"));
    T::AggInfo_funcTy = converter.get(loadedModule->getTypeByName("struct.AggInfo_func"));
    T::FuncDefTy = converter.get(loadedModule->getTypeByName("struct.FuncDef"));
    T::sqlite3_contextTy = converter.get(loadedModule->getTypeByName("struct.sqlite3_context"));
    // T::anon8Ty = converter.get(loadedModule->getTypeByName("anon.8"));
    // T::anon4Ty = converter.get(loadedModule->getTypeByName("anon.4"));
    T::IndexTy = converter.get(loadedModule->getTypeByName("struct.Index"));
    T::SelectTy = converter.get(loadedModule->getTypeByName("struct.Select"));
    T::SrcList_itemTy = converter.get(loadedModule->getTypeByName("struct.SrcList_item"));
    T::SrcListTy = converter.get(loadedModule->getTypeByName("struct.SrcList"));
    // T::anon2Ty = converter.get(loadedModule->getTypeByName("anon.2"));
    // T::IdListTy = converter.get(loadedModule->getTypeByName("IdList"));
    // T::IdList_itemTy = converter.get(loadedModule->getTypeByName("IdList_item"));
    // T::anon3Ty = converter.get(loadedModule->getTypeByName("anon.3"));
    // T::CteTy = converter.get(loadedModule->getTypeByName("Cte"));
    // T::WithTy = converter.get(loadedModule->getTypeByName("With"));
    // T::WindowTy = converter.get(loadedModule->getTypeByName("Window"));
    // T::sColMapTy = converter.get(loadedModule->getTypeByName("sColMap"));
    // T::FKeyTy = converter.get(loadedModule->getTypeByName("FKey"));
    // T::ExprList_itemTy = converter.get(loadedModule->getTypeByName("ExprList_item"));
    // T::ExprListTy = converter.get(loadedModule->getTypeByName("ExprList"));
    // T::anon1Ty = converter.get(loadedModule->getTypeByName("anon.1"));
    // T::TriggerTy = converter.get(loadedModule->getTypeByName("Trigger"));
    // T::TriggerStepTy = converter.get(loadedModule->getTypeByName("TriggerStep"));
    // T::UpsertTy = converter.get(loadedModule->getTypeByName("Upsert"));
    // T::sqlite3InitInfoTy = converter.get(loadedModule->getTypeByName("sqlite3InitInfo"));
    // T::ParseTy = converter.get(loadedModule->getTypeByName("Parse"));
    // T::AutoincInfoTy = converter.get(loadedModule->getTypeByName("AutoincInfo"));
    // T::TokenTy = converter.get(loadedModule->getTypeByName("Token"));
    // T::TriggerPrgTy = converter.get(loadedModule->getTypeByName("TriggerPrg"));
    // T::anon6Ty = converter.get(loadedModule->getTypeByName("anon.6"));
    // T::LookasideTy = converter.get(loadedModule->getTypeByName("Lookaside"));
    // T::LookasideSlotTy = converter.get(loadedModule->getTypeByName("LookasideSlot"));
    T::VTableTy = converter.get(loadedModule->getTypeByName("struct.VTable"));
    // T::ModuleTy = converter.get(loadedModule->getTypeByName("Module"));
    // T::sqlite3_moduleTy = converter.get(loadedModule->getTypeByName("sqlite3_module"));
    // T::sqlite3_index_infoTy = converter.get(loadedModule->getTypeByName("sqlite3_index_info"));
    // T::sqlite3_index_constraintTy = converter.get(loadedModule->getTypeByName("sqlite3_index_constraint"));
    // T::sqlite3_index_orderbyTy = converter.get(loadedModule->getTypeByName("sqlite3_index_orderby"));
    // T::sqlite3_index_constraint_usageTy = converter.get(loadedModule->getTypeByName("sqlite3_index_constraint_usage"));
    T::sqlite3_vtab_cursorTy = converter.get(loadedModule->getTypeByName("struct.sqlite3_vtab_cursor"));
    // T::sqlite3_vtabTy = converter.get(loadedModule->getTypeByName("sqlite3_vtab"));
    // T::HashTy = converter.get(loadedModule->getTypeByName("Hash"));
    // T::HashElemTy = converter.get(loadedModule->getTypeByName("HashElem"));
    // T::_htTy = converter.get(loadedModule->getTypeByName("_ht"));
    // T::BusyHandlerTy = converter.get(loadedModule->getTypeByName("BusyHandler"));
    // T::SavepointTy = converter.get(loadedModule->getTypeByName("Savepoint"));
    T::UnpackedRecordTy = converter.get(loadedModule->getTypeByName("struct.UnpackedRecord"));
    T::UnpackedRecordPtrTy = T::UnpackedRecordTy.getPointerTo();

    T::BtreePayloadTy = converter.get(loadedModule->getTypeByName("struct.BtreePayload"));
    T::BtreePayloadPtrTy = T::BtreePayloadTy.getPointerTo();
    // T::InitDataTy = converter.get(loadedModule->getTypeByName("InitData"));

    T::i1Ty = t::getIntNTy(d, 1);

    T::SchemaPtrTy = T::SchemaTy.getPointerTo();
    // T::ExprPtrTy = T::ExprTy.getPointerTo();
    // T::AggInfoPtrTy = T::AggInfoTy.getPointerTo();
    // T::sqlite3_modulePtrTy = T::sqlite3_moduleTy.getPointerTo();
    // T::Arr_2_DbTy = t::getArrayTy(T::DbTy, 2);
    // T::AuxDataPtrTy = T::AuxDataTy.getPointerTo();
    T::sqlite3_vfsPtrTy = T::sqlite3_vfsTy.getPointerTo();
    // T::sqlite3_vtabPtrTy = T::sqlite3_vtabTy.getPointerTo();
    T::CollSeqPtrTy = T::CollSeqTy.getPointerTo();
    // T::sqlite3_pcache_pagePtrTy = T::sqlite3_pcache_pageTy.getPointerTo();
    // T::LookasideSlotPtrTy = T::LookasideSlotTy.getPointerTo();
    T::BtCursorTy = converter.get(loadedModule->getTypeByName("struct.BtCursor"));
    T::sqlite3_valuePtrTy = T::sqlite3_valueTy.getPointerTo();
    T::sqlite3_vtab_cursorPtrTy = T::sqlite3_vtab_cursorTy.getPointerTo();
    // T::IndexPtrTy = T::IndexTy.getPointerTo();
    // T::IdList_itemPtrTy = T::IdList_itemTy.getPointerTo();
    // T::ModulePtrTy = T::ModuleTy.getPointerTo();
    // T::sqlite3_index_orderbyPtrTy = T::sqlite3_index_orderbyTy.getPointerTo();
    // T::Arr_1_SrcList_itemTy = t::getArrayTy(T::SrcList_itemTy, 1);
    // T::Arr_1_ExprList_itemTy = t::getArrayTy(T::ExprList_itemTy, 1);
    T::TablePtrTy = T::TableTy.getPointerTo();
    // T::UpsertPtrTy = T::UpsertTy.getPointerTo();
    T::VdbeCursorPtrTy = T::VdbeCursorTy.getPointerTo();
    // T::SelectPtrTy = T::SelectTy.getPointerTo();
    // T::SubProgramPtrTy = T::SubProgramTy.getPointerTo();
    // T::sqlite3_index_infoPtrTy = T::sqlite3_index_infoTy.getPointerTo();
    // T::sqlite3_pcacheTy = converter.get(loadedModule->getTypeByName("sqlite3_pcache"));
    // T::PagerTy = converter.get(loadedModule->getTypeByName("Pager"));
    // T::SrcListPtrTy = T::SrcListTy.getPointerTo();
    // T::Arr_1_sColMapTy = t::getArrayTy(T::sColMapTy, 1);
    // T::Arr_1_CteTy = t::getArrayTy(T::CteTy, 1);
    T::VdbePtrTy = T::VdbeTy.getPointerTo();
    T::sqlite3_mutexTy = converter.get(loadedModule->getTypeByName("struct.sqlite3_mutex"));
    T::i64Ty = t::getIntNTy(d, 64);
    // T::sqlite3_io_methodsPtrTy = T::sqlite3_io_methodsTy.getPointerTo();
    T::RowSetTy = converter.get(loadedModule->getTypeByName("struct.RowSet"));
    T::RowSetPtrTy = T::RowSetTy.getPointerTo();
    // T::TriggerPtrTy = T::TriggerTy.getPointerTo();
    // T::SavepointPtrTy = T::SavepointTy.getPointerTo();
    // T::IdListPtrTy = T::IdListTy.getPointerTo();
    // T::TriggerStepPtrTy = T::TriggerStepTy.getPointerTo();
    // T::_htPtrTy = T::_htTy.getPointerTo();
    // T::sqlite3_filePtrTy = T::sqlite3_fileTy.getPointerTo();
    T::VTablePtrTy = T::VTableTy.getPointerTo();
    T::KeyInfoPtrTy = T::KeyInfoTy.getPointerTo();
    T::VoidTy = T::voidTy;
    // T::sqlite3_index_constraintPtrTy = T::sqlite3_index_constraintTy.getPointerTo();
    // T::TriggerPrgPtrTy = T::TriggerPrgTy.getPointerTo();
    T::VdbeFramePtrTy = T::VdbeFrameTy.getPointerTo();
    T::VdbeOpPtrTy = T::VdbeOpTy.getPointerTo();
    T::p4unionPtrTy = T::p4unionTy.getPointerTo();
    // T::AutoincInfoPtrTy = T::AutoincInfoTy.getPointerTo();
    T::TableLockTy = converter.get(loadedModule->getTypeByName("struct.TableLock"));
    T::FuncDefPtrTy = T::FuncDefTy.getPointerTo();
    // T::RenameTokenTy = converter.get(loadedModule->getTypeByName("RenameToken"));
    T::i32Ty = t::getIntNTy(d, 32);
    T::sqlite3PtrTy = T::sqlite3Ty.getPointerTo();
    T::i8Ty = t::getIntNTy(d, 8);
    T::VtabCtxTy = converter.get(loadedModule->getTypeByName("struct.VtabCtx"));
    // T::ParsePtrTy = T::ParseTy.getPointerTo();
    T::sqlite3_contextPtrTy = T::sqlite3_contextTy.getPointerTo();
    T::ColumnPtrTy = T::ColumnTy.getPointerTo();
    // T::FKeyPtrTy = T::FKeyTy.getPointerTo();
    T::DbPtrTy = T::DbTy.getPointerTo();
    // T::WindowPtrTy = T::WindowTy.getPointerTo();
    T::i16Ty = t::getIntNTy(d, 16);
    // T::sqlite3_index_constraint_usagePtrTy = T::sqlite3_index_constraint_usageTy.getPointerTo();
    // T::HashElemPtrTy = T::HashElemTy.getPointerTo();
    // T::WithPtrTy = T::WithTy.getPointerTo();
    // T::AggInfo_colPtrTy = T::AggInfo_colTy.getPointerTo();
    T::VdbeSorterTy = converter.get(loadedModule->getTypeByName("struct.VdbeSorter"));
    // T::AggInfo_funcPtrTy = T::AggInfo_funcTy.getPointerTo();
    T::doubleTy = t::getDoubleTy(d);
    // T::ExprListPtrTy = T::ExprListTy.getPointerTo();
    T::Arr_1_sqlite3_valuePtrTy = t::getArrayTy(T::sqlite3_valueTy.getPointerTo(), 1);
    // T::i32_Of_sqlite3_vtab_cursorPtrTy = t::getFunctionTy(t::getIntNTy(d, 32), {T::sqlite3_vtab_cursorPtrTy}, false);
    // T::Void_Of_VoidTy = t::getFunctionTy(T::voidTy, {}, false);
    T::i64PtrTy = T::i64Ty.getPointerTo();
    // T::Arr_3_i32Ty = t::getArrayTy(t::getIntNTy(d, 32), 3);
    // T::Arr_1_i32Ty = t::getArrayTy(t::getIntNTy(d, 32), 1);
    // T::Arr_2_TriggerPtrTy = t::getArrayTy(T::TriggerTy.getPointerTo(), 2);
    // T::Arr_7_i32Ty = t::getArrayTy(t::getIntNTy(d, 32), 7);
    // T::Arr_8_i32Ty = t::getArrayTy(t::getIntNTy(d, 32), 8);
    // T::RenameTokenPtrTy = T::RenameTokenTy.getPointerTo();
    // T::Void_Of_sqlite3_contextPtrTy = t::getFunctionTy(T::voidTy, {T::sqlite3_contextPtrTy}, false);
    T::BtreePtrTy = T::BtreeTy.getPointerTo();
    T::i32PtrTy = T::i32Ty.getPointerTo();
    // T::i32_Of_sqlite3_filePtr_i32Ty = t::getFunctionTy(t::getIntNTy(d, 32), {T::sqlite3_filePtrTy, T::i32Ty}, false);
    T::TablePtrPtrTy = T::TablePtrTy.getPointerTo();
    // T::i32_Of_VoidTy = t::getFunctionTy(t::getIntNTy(d, 32), {}, false);
    // T::sqlite3_pcachePtrTy = T::sqlite3_pcacheTy.getPointerTo();
    T::sqlite3_vtab_cursorPtrPtrTy = T::sqlite3_vtab_cursorPtrTy.getPointerTo();
    T::i8PtrTy = T::i8Ty.getPointerTo();
    // T::sqlite3_vtabPtrPtrTy = T::sqlite3_vtabPtrTy.getPointerTo();
    T::VtabCtxPtrTy = T::VtabCtxTy.getPointerTo();
    // T::i32_Of_sqlite3_vfsPtr_i32Ty = t::getFunctionTy(t::getIntNTy(d, 32), {T::sqlite3_vfsPtrTy, T::i32Ty}, false);
    // T::i32_Of_sqlite3_filePtr_i64Ty = t::getFunctionTy(t::getIntNTy(d, 32), {T::sqlite3_filePtrTy, T::i64Ty}, false);
    // T::i32_Of_sqlite3_vtabPtrTy = t::getFunctionTy(t::getIntNTy(d, 32), {T::sqlite3_vtabPtrTy}, false);
    // T::i32_Of_sqlite3_vtabPtr_i32Ty = t::getFunctionTy(t::getIntNTy(d, 32), {T::sqlite3_vtabPtrTy, T::i32Ty}, false);
    T::TableLockPtrTy = T::TableLockTy.getPointerTo();
    T::i16PtrTy = T::i16Ty.getPointerTo();
    // T::Void_Of_sqlite3_filePtrTy = t::getFunctionTy(T::voidTy, {T::sqlite3_filePtrTy}, false);
    // T::WindowPtrPtrTy = T::WindowPtrTy.getPointerTo();
    T::VdbeCursorPtrPtrTy = T::VdbeCursorPtrTy.getPointerTo();
    T::Arr_1_CollSeqPtrTy = t::getArrayTy(T::CollSeqTy.getPointerTo(), 1);
    T::Arr_12_i32Ty = t::getArrayTy(t::getIntNTy(d, 32), 12);
    T::Arr_2_i8Ty = t::getArrayTy(t::getIntNTy(d, 8), 2);
    T::i32_Of_sqlite3_vtab_cursorPtr_sqlite3_contextPtr_i32Ty = t::getFunctionTy(t::getIntNTy(d, 32), {T::sqlite3_vtab_cursorPtrTy, T::sqlite3_contextPtrTy, T::i32Ty}, false);
    // T::i32_Of_sqlite3_vtabPtr_sqlite3_index_infoPtrTy = t::getFunctionTy(t::getIntNTy(d, 32), {T::sqlite3_vtabPtrTy, T::sqlite3_index_infoPtrTy}, false);
    // T::i32_Of_i32Ty = t::getFunctionTy(t::getIntNTy(d, 32), {T::i32Ty}, false);
    T::sqlite3_mutexPtrTy = T::sqlite3_mutexTy.getPointerTo();
    // T::Arr_4_i8Ty = t::getArrayTy(t::getIntNTy(d, 8), 4);
    // T::i32_Of_sqlite3_filePtr_i32_i32_i32Ty = t::getFunctionTy(t::getIntNTy(d, 32), {T::sqlite3_filePtrTy, T::i32Ty, T::i32Ty, T::i32Ty}, false);
    T::BtCursorPtrTy = T::BtCursorTy.getPointerTo();
    T::doublePtrTy = T::doubleTy.getPointerTo();
    T::sqlite3_valuePtrPtrTy = T::sqlite3_valuePtrTy.getPointerTo();
    // T::Arr_2_i32Ty = t::getArrayTy(t::getIntNTy(d, 32), 2);
    T::VTablePtrPtrTy = T::VTablePtrTy.getPointerTo();
    // T::i32_Of_sqlite3_filePtrTy = t::getFunctionTy(t::getIntNTy(d, 32), {T::sqlite3_filePtrTy}, false);
    // T::Arr_3_i8Ty = t::getArrayTy(t::getIntNTy(d, 8), 3);
    // T::i32_Of_sqlite3_vtabPtrPtrTy = T::i32_Of_sqlite3_vtabPtrTy.getPointerTo();
    T::i8PtrPtrTy = T::i8PtrTy.getPointerTo();
    // T::Void_Of_Void_Of_Sqlite3_Vfs_i8Ptr_i8PtrTy = t::getFunctionTy(t::getFunctionTy(T::voidTy, {}, false).getPointerTo(), { T::sqlite3_vfsPtrTy, T::i8PtrTy, T::i8PtrTy }, false).getPointerTo();;
    // T::i32_Of_sqlite3_vtab_cursorPtr_i64PtrTy = t::getFunctionTy(t::getIntNTy(d, 32), {T::sqlite3_vtab_cursorPtrTy, T::i64PtrTy}, false);
    // T::i32_Of_sqlite3_vfsPtr_i8Ptr_i32Ty = t::getFunctionTy(t::getIntNTy(d, 32), {T::sqlite3_vfsPtrTy, T::i8PtrTy, T::i32Ty}, false);
    // T::i32_Of_sqlite3_vtab_cursorPtr_i32_i8Ptr_i32_sqlite3_valuePtrPtrTy = t::getFunctionTy(t::getIntNTy(d, 32), {T::sqlite3_vtab_cursorPtrTy, T::i32Ty, T::i8PtrTy, T::i32Ty, T::sqlite3_valuePtrPtrTy}, false);
    // T::Void_Of_sqlite3_pcachePtr_sqlite3_pcache_pagePtr_i32_i32Ty = t::getFunctionTy(T::voidTy, {T::sqlite3_pcachePtrTy, T::sqlite3_pcache_pagePtrTy, T::i32Ty, T::i32Ty}, false);
    // T::Void_Of_sqlite3_pcachePtr_sqlite3_pcache_pagePtr_i32Ty = t::getFunctionTy(T::voidTy, {T::sqlite3_pcachePtrTy, T::sqlite3_pcache_pagePtrTy, T::i32Ty}, false);
    // T::i32_Of_sqlite3_vtabPtr_i32_sqlite3_valuePtrPtr_i64PtrTy = t::getFunctionTy(t::getIntNTy(d, 32), {T::sqlite3_vtabPtrTy, T::i32Ty, T::sqlite3_valuePtrPtrTy, T::i64PtrTy}, false);
    // T::Void_Of_sqlite3_contextPtrPtrTy = T::Void_Of_sqlite3_contextPtrTy.getPointerTo();
    // T::i32_Of_i8PtrTy = t::getFunctionTy(t::getIntNTy(d, 32), {T::i8PtrTy}, false);
    // T::i32_Of_sqlite3_vtab_cursorPtr_sqlite3_contextPtr_i32PtrTy = T::i32_Of_sqlite3_vtab_cursorPtr_sqlite3_contextPtr_i32Ty.getPointerTo();
    // T::Void_Of_i8PtrTy = t::getFunctionTy(T::voidTy, {T::i8PtrTy}, false);
    // T::i32_Of_sqlite3_filePtr_i8Ptr_i32_i64Ty = t::getFunctionTy(t::getIntNTy(d, 32), {T::sqlite3_filePtrTy, T::i8PtrTy, T::i32Ty, T::i64Ty}, false);
    // T::i32_Of_sqlite3_vtabPtr_sqlite3_vtab_cursorPtrPtrTy = t::getFunctionTy(t::getIntNTy(d, 32), {T::sqlite3_vtabPtrTy, T::sqlite3_vtab_cursorPtrPtrTy}, false);
    // T::i8Ptr_Of_i8Ptr_i32Ty = t::getFunctionTy(T::i8Ty.getPointerTo(), {T::i8PtrTy, T::i32Ty}, false);
    // T::sqlite3_mutexPtr_Of_i32Ty = t::getFunctionTy(T::sqlite3_mutexTy.getPointerTo(), {T::i32Ty}, false);
    // T::i32_Of_sqlite3_vtabPtr_sqlite3_index_infoPtrPtrTy = T::i32_Of_sqlite3_vtabPtr_sqlite3_index_infoPtrTy.getPointerTo();
    // T::sqlite3_pcache_pagePtr_Of_sqlite3_pcachePtr_i32_i32Ty = t::getFunctionTy(T::sqlite3_pcache_pageTy.getPointerTo(), {T::sqlite3_pcachePtrTy, T::i32Ty, T::i32Ty}, false);
    // T::i32_Of_sqlite3_pcachePtrTy = t::getFunctionTy(t::getIntNTy(d, 32), {T::sqlite3_pcachePtrTy}, false);
    // T::i32_Of_sqlite3_vfsPtr_i32_i8PtrTy = t::getFunctionTy(t::getIntNTy(d, 32), {T::sqlite3_vfsPtrTy, T::i32Ty, T::i8PtrTy}, false);
    // T::sqlite3_pcachePtr_Of_i32_i32_i32Ty = t::getFunctionTy(T::sqlite3_pcacheTy.getPointerTo(), {T::i32Ty, T::i32Ty, T::i32Ty}, false);
    // T::Void_Of_i8Ptr_i8Ptr_i64Ty = t::getFunctionTy(T::voidTy, {T::i8PtrTy, T::i8PtrTy, T::i64Ty}, false);
    // T::Void_Of_sqlite3_mutexPtrTy = t::getFunctionTy(T::voidTy, {T::sqlite3_mutexPtrTy}, false);
    // T::i32_Of_i8Ptr_sqlite3Ptr_i8Ptr_i32Ty = t::getFunctionTy(t::getIntNTy(d, 32), {T::i8PtrTy, T::sqlite3PtrTy, T::i8PtrTy, T::i32Ty}, false);
    // T::i32_Of_sqlite3_filePtr_i64PtrTy = t::getFunctionTy(t::getIntNTy(d, 32), {T::sqlite3_filePtrTy, T::i64PtrTy}, false);
    // T::Void_Of_VoidPtrTy = T::Void_Of_VoidTy.getPointerTo();
    // T::Void_Of_sqlite3_vfsPtr_i32_i8PtrTy = t::getFunctionTy(T::voidTy, {T::sqlite3_vfsPtrTy, T::i32Ty, T::i8PtrTy}, false);
    // T::i32_Of_sqlite3_filePtr_i32_i32_i32PtrTy = T::i32_Of_sqlite3_filePtr_i32_i32_i32Ty.getPointerTo();
    // T::Void_Of_i8Ptr_i32_i8PtrTy = t::getFunctionTy(T::voidTy, {T::i8PtrTy, T::i32Ty, T::i8PtrTy}, false);
    // T::Void_Of_sqlite3_vfsPtr_i8PtrTy = t::getFunctionTy(T::voidTy, {T::sqlite3_vfsPtrTy, T::i8PtrTy}, false);
    // T::i32_Of_i32_i8Ptr_i8Ptr_i8PtrTy = t::getFunctionTy(t::getIntNTy(d, 32), {T::i32Ty, T::i8PtrTy, T::i8PtrTy, T::i8PtrTy}, false);
    // T::Void_Of_sqlite3_filePtrPtrTy = T::Void_Of_sqlite3_filePtrTy.getPointerTo();
    // T::i32_Of_i32PtrTy = T::i32_Of_i32Ty.getPointerTo();
    // T::i32_Of_i8Ptr_i32_i8Ptr_i8Ptr_i8Ptr_i8PtrTy = t::getFunctionTy(t::getIntNTy(d, 32), {T::i8PtrTy, T::i32Ty, T::i8PtrTy, T::i8PtrTy, T::i8PtrTy, T::i8PtrTy}, false);
    // T::i32_Of_sqlite3_vfsPtr_i8Ptr_i32_i32PtrTy = t::getFunctionTy(t::getIntNTy(d, 32), {T::sqlite3_vfsPtrTy, T::i8PtrTy, T::i32Ty, T::i32PtrTy}, false);
    // T::i32_Of_sqlite3_filePtrPtrTy = T::i32_Of_sqlite3_filePtrTy.getPointerTo();
    // T::i8Ptr_Of_sqlite3_vfsPtr_i8PtrTy = t::getFunctionTy(T::i8Ty.getPointerTo(), {T::sqlite3_vfsPtrTy, T::i8PtrTy}, false);
    // T::i32_Of_sqlite3_vfsPtr_i64PtrTy = t::getFunctionTy(t::getIntNTy(d, 32), {T::sqlite3_vfsPtrTy, T::i64PtrTy}, false);
    // T::i32_Of_VoidPtrTy = T::i32_Of_VoidTy.getPointerTo();
    // T::i32_Of_i8Ptr_i32Ty = t::getFunctionTy(t::getIntNTy(d, 32), {T::i8PtrTy, T::i32Ty}, false);
    // T::i32_Of_i8Ptr_i32_i8Ptr_i32_i8PtrTy = t::getFunctionTy(t::getIntNTy(d, 32), {T::i8PtrTy, T::i32Ty, T::i8PtrTy, T::i32Ty, T::i8PtrTy}, false);
    // T::i32_Of_sqlite3_filePtr_i32_i8PtrTy = t::getFunctionTy(t::getIntNTy(d, 32), {T::sqlite3_filePtrTy, T::i32Ty, T::i8PtrTy}, false);
    // T::i32_Of_sqlite3_mutexPtrTy = t::getFunctionTy(t::getIntNTy(d, 32), {T::sqlite3_mutexPtrTy}, false);
    // T::i32_Of_sqlite3_vtab_cursorPtrPtrTy = T::i32_Of_sqlite3_vtab_cursorPtrTy.getPointerTo();
    // T::Void_Of_i8Ptr_i32_i8Ptr_i8Ptr_i64Ty = t::getFunctionTy(T::voidTy, {T::i8PtrTy, T::i32Ty, T::i8PtrTy, T::i8PtrTy, T::i64Ty}, false);
    // T::i32_Of_sqlite3_vtabPtr_i32PtrTy = T::i32_Of_sqlite3_vtabPtr_i32Ty.getPointerTo();
    // T::i32_Of_sqlite3_vfsPtr_i8Ptr_sqlite3_filePtr_i32_i32PtrTy = t::getFunctionTy(t::getIntNTy(d, 32), {T::sqlite3_vfsPtrTy, T::i8PtrTy, T::sqlite3_filePtrTy, T::i32Ty, T::i32PtrTy}, false);
    // T::PxFunctionPtrTy = t::getFunctionTy(T::i8PtrTy, { T::sqlite3_contextPtrTy, T::i32Ty, T::sqlite3_valuePtrTy }, false).getPointerTo();
    // T::Void_Of_sqlite3_contextPtr_i32_sqlite3_valuePtrPtrTy = t::getFunctionTy(T::voidTy, {T::sqlite3_contextPtrTy, T::i32Ty, T::sqlite3_valuePtrPtrTy}, false);
    // T::i32_Of_sqlite3_vtabPtr_i8PtrTy = t::getFunctionTy(t::getIntNTy(d, 32), {T::sqlite3_vtabPtrTy, T::i8PtrTy}, false);
    // T::Void_Of_sqlite3_pcachePtr_i32Ty = t::getFunctionTy(T::voidTy, {T::sqlite3_pcachePtrTy, T::i32Ty}, false);
    // T::Void_Of_i8Ptr_sqlite3Ptr_i32_i8PtrTy = t::getFunctionTy(T::voidTy, {T::i8PtrTy, T::sqlite3PtrTy, T::i32Ty, T::i8PtrTy}, false);
    // T::Void_Of_Void_Of_Sqlite3_Vfs_i8PtrTy = t::getFunctionTy(t::getFunctionTy(T::voidTy, {}, false).getPointerTo(), { T::sqlite3_vfsPtrTy, T::i8PtrTy }, false).getPointerTo();
    // T::i32_Of_sqlite3_filePtr_i64_i8PtrTy = t::getFunctionTy(t::getIntNTy(d, 32), {T::sqlite3_filePtrTy, T::i64Ty, T::i8PtrTy}, false);
    // T::i32_Of_sqlite3_vfsPtr_i32PtrTy = T::i32_Of_sqlite3_vfsPtr_i32Ty.getPointerTo();
    // T::i32_Of_sqlite3_vfsPtr_i8Ptr_i32_i8PtrTy = t::getFunctionTy(t::getIntNTy(d, 32), {T::sqlite3_vfsPtrTy, T::i8PtrTy, T::i32Ty, T::i8PtrTy}, false);
    // T::i32_Of_sqlite3_vfsPtr_doublePtrTy = t::getFunctionTy(t::getIntNTy(d, 32), {T::sqlite3_vfsPtrTy, T::doublePtrTy}, false);
    // T::Void_Of_sqlite3_pcachePtrTy = t::getFunctionTy(T::voidTy, {T::sqlite3_pcachePtrTy}, false);
    // T::i8Ptr_Of_i32Ty = t::getFunctionTy(T::i8Ty.getPointerTo(), {T::i32Ty}, false);
    // T::i32_Of_sqlite3_filePtr_i32PtrTy = T::i32_Of_sqlite3_filePtr_i32Ty.getPointerTo();
    // T::Void_Of_sqlite3_contextPtr_i32_sqlite3_valuePtrPtrPtrTy = T::Void_Of_sqlite3_contextPtr_i32_sqlite3_valuePtrPtrTy.getPointerTo();
    // T::sqlite3_pcachePtr_Of_i32_i32_i32PtrTy = T::sqlite3_pcachePtr_Of_i32_i32_i32Ty.getPointerTo();
    // T::i32_Of_sqlite3_filePtr_i32_i8PtrPtrTy = T::i32_Of_sqlite3_filePtr_i32_i8PtrTy.getPointerTo();
    // T::i32_Of_sqlite3_filePtr_i64_i32_i8PtrPtrTy = t::getFunctionTy(t::getIntNTy(d, 32), {T::sqlite3_filePtrTy, T::i64Ty, T::i32Ty, T::i8PtrPtrTy}, false);
    // T::i32_Of_sqlite3_vfsPtr_i32_i8PtrPtrTy = T::i32_Of_sqlite3_vfsPtr_i32_i8PtrTy.getPointerTo();
    // T::i32_Of_sqlite3_filePtr_i32_i32_i32_i8PtrPtrTy = t::getFunctionTy(t::getIntNTy(d, 32), {T::sqlite3_filePtrTy, T::i32Ty, T::i32Ty, T::i32Ty, T::i8PtrPtrTy}, false);
    // T::Void_Of_i8Ptr_sqlite3Ptr_i32_i8PtrPtrTy = T::Void_Of_i8Ptr_sqlite3Ptr_i32_i8PtrTy.getPointerTo();
    // T::i32_Of_sqlite3_vfsPtr_i8Ptr_Void_Of_VoidPtrTy = t::getFunctionTy(t::getIntNTy(d, 32), {T::sqlite3_vfsPtrTy, T::i8PtrTy, T::Void_Of_VoidPtrTy}, false);
    // T::i32_Of_sqlite3_vtabPtr_i32_sqlite3_valuePtrPtr_i64PtrPtrTy = T::i32_Of_sqlite3_vtabPtr_i32_sqlite3_valuePtrPtr_i64PtrTy.getPointerTo();
    // T::i32_Of_sqlite3_vtab_cursorPtr_i32_i8Ptr_i32_sqlite3_valuePtrPtrPtrTy = T::i32_Of_sqlite3_vtab_cursorPtr_i32_i8Ptr_i32_sqlite3_valuePtrPtrTy.getPointerTo();
    // T::Void_Of_i8Ptr_i8Ptr_i64PtrTy = T::Void_Of_i8Ptr_i8Ptr_i64Ty.getPointerTo();
    // T::i32_Of_sqlite3_pcachePtrPtrTy = T::i32_Of_sqlite3_pcachePtrTy.getPointerTo();
    // T::i8Ptr_Of_i32PtrTy = T::i8Ptr_Of_i32Ty.getPointerTo();
    // T::Void_Of_i8PtrPtrTy = T::Void_Of_i8PtrTy.getPointerTo();
    // T::i32_Of_sqlite3_filePtr_i64PtrPtrTy = T::i32_Of_sqlite3_filePtr_i64PtrTy.getPointerTo();
    // T::i32_Of_i8Ptr_i32_i8Ptr_i8Ptr_i8Ptr_i8PtrPtrTy = T::i32_Of_i8Ptr_i32_i8Ptr_i8Ptr_i8Ptr_i8PtrTy.getPointerTo();
    // T::i32_Of_sqlite3_filePtr_i32PtrPtrTy = T::i32_Of_sqlite3_filePtr_i32PtrTy.getPointerTo();
    // T::i32_Of_sqlite3_vfsPtr_doublePtrPtrTy = T::i32_Of_sqlite3_vfsPtr_doublePtrTy.getPointerTo();
    // T::i32_Of_i32_i8Ptr_i8Ptr_i8PtrPtrTy = T::i32_Of_i32_i8Ptr_i8Ptr_i8PtrTy.getPointerTo();
    // T::sqlite3_pcache_pagePtr_Of_sqlite3_pcachePtr_i32_i32PtrTy = T::sqlite3_pcache_pagePtr_Of_sqlite3_pcachePtr_i32_i32Ty.getPointerTo();
    // T::Void_Of_sqlite3_pcachePtr_sqlite3_pcache_pagePtr_i32_i32PtrTy = T::Void_Of_sqlite3_pcachePtr_sqlite3_pcache_pagePtr_i32_i32Ty.getPointerTo();
    // T::i32_Of_sqlite3_vtabPtr_i8PtrPtrTy = T::i32_Of_sqlite3_vtabPtr_i8PtrTy.getPointerTo();
    // T::i32_Of_sqlite3_vfsPtr_i8Ptr_sqlite3_filePtr_i32_i32PtrPtrTy = T::i32_Of_sqlite3_vfsPtr_i8Ptr_sqlite3_filePtr_i32_i32PtrTy.getPointerTo();
    // T::i8Ptr_Of_i8Ptr_i32PtrTy = T::i8Ptr_Of_i8Ptr_i32Ty.getPointerTo();
    // T::Void_Of_sqlite3_pcachePtrPtrTy = T::Void_Of_sqlite3_pcachePtrTy.getPointerTo();
    // T::Void_Of_sqlite3_pcachePtr_sqlite3_pcache_pagePtr_i32PtrTy = T::Void_Of_sqlite3_pcachePtr_sqlite3_pcache_pagePtr_i32Ty.getPointerTo();
    // T::i8Ptr_Of_sqlite3_vfsPtr_i8PtrPtrTy = T::i8Ptr_Of_sqlite3_vfsPtr_i8PtrTy.getPointerTo();
    // T::sqlite3_mutexPtr_Of_i32PtrTy = T::sqlite3_mutexPtr_Of_i32Ty.getPointerTo();
    // T::i32_Of_sqlite3_filePtr_i8Ptr_i32_i64PtrTy = T::i32_Of_sqlite3_filePtr_i8Ptr_i32_i64Ty.getPointerTo();
    // T::i32_Of_sqlite3_vtabPtr_i32_i8Ptr_PxFunctionPtr_i8PtrPtrTy = t::getFunctionTy(t::getIntNTy(d, 32), {T::sqlite3_vtabPtrTy, T::i32Ty, T::i8PtrTy, T::PxFunctionPtrTy, T::i8PtrPtrTy}, false);
    // T::Void_Of_sqlite3_vfsPtr_i8PtrPtrTy = T::Void_Of_sqlite3_vfsPtr_i8PtrTy.getPointerTo();
    // T::Void_Of_i8Ptr_i32_i8PtrPtrTy = T::Void_Of_i8Ptr_i32_i8PtrTy.getPointerTo();
    // T::i32_Of_sqlite3_vfsPtr_i8Ptr_i32_i8PtrPtrTy = T::i32_Of_sqlite3_vfsPtr_i8Ptr_i32_i8PtrTy.getPointerTo();
    // T::i32_Of_sqlite3_vfsPtr_i8Ptr_i32_i32PtrPtrTy = T::i32_Of_sqlite3_vfsPtr_i8Ptr_i32_i32PtrTy.getPointerTo();
    // T::i32_Of_sqlite3_filePtr_i64_i8PtrPtrTy = T::i32_Of_sqlite3_filePtr_i64_i8PtrTy.getPointerTo();
    // T::i32_Of_sqlite3Ptr_i8Ptr_i32_i8PtrPtr_sqlite3_vtabPtrPtr_i8PtrPtrTy = t::getFunctionTy(t::getIntNTy(d, 32), {T::sqlite3PtrTy, T::i8PtrTy, T::i32Ty, T::i8PtrPtrTy, T::sqlite3_vtabPtrPtrTy, T::i8PtrPtrTy}, false);
    // T::i32_Of_sqlite3_vtab_cursorPtr_i64PtrPtrTy = T::i32_Of_sqlite3_vtab_cursorPtr_i64PtrTy.getPointerTo();
    // T::i32_Of_i8PtrPtrTy = T::i32_Of_i8PtrTy.getPointerTo();
    // T::Void_Of_i8Ptr_i32_i8Ptr_i8Ptr_i64PtrTy = T::Void_Of_i8Ptr_i32_i8Ptr_i8Ptr_i64Ty.getPointerTo();
    // T::i32_Of_sqlite3_vfsPtr_i64PtrPtrTy = T::i32_Of_sqlite3_vfsPtr_i64PtrTy.getPointerTo();
//    T::i32_Of_i8Ptr_sqlite3Ptr_i8Ptr_i32PtrTy = T::i32_Of_i8Ptr_sqlite3Ptr_i8Ptr_i32Ty.getPointerTo();
//    T::i32_Of_sqlite3_vtabPtr_sqlite3_vtab_cursorPtrPtrPtrTy = T::i32_Of_sqlite3_vtabPtr_sqlite3_vtab_cursorPtrPtrTy.getPointerTo();
//    T::i32_Of_sqlite3_mutexPtrPtrTy = T::i32_Of_sqlite3_mutexPtrTy.getPointerTo();
//    T::Void_Of_sqlite3_pcachePtr_i32PtrTy = T::Void_Of_sqlite3_pcachePtr_i32Ty.getPointerTo();
//    T::i32_Of_i8Ptr_i32PtrTy = T::i32_Of_i8Ptr_i32Ty.getPointerTo();
//    T::Void_Of_sqlite3_vfsPtr_i32_i8PtrPtrTy = T::Void_Of_sqlite3_vfsPtr_i32_i8PtrTy.getPointerTo();
//    T::Void_Of_sqlite3_mutexPtrPtrTy = T::Void_Of_sqlite3_mutexPtrTy.getPointerTo();
//    T::i32_Of_i8Ptr_i32_i8Ptr_i32_i8PtrPtrTy = T::i32_Of_i8Ptr_i32_i8Ptr_i32_i8PtrTy.getPointerTo();
//    T::i32_Of_sqlite3_vfsPtr_i8Ptr_i32PtrTy = T::i32_Of_sqlite3_vfsPtr_i8Ptr_i32Ty.getPointerTo();
//    T::i32_Of_sqlite3_vtabPtr_i32_i8Ptr_PxFunctionPtr_i8PtrPtrPtrTy = T::i32_Of_sqlite3_vtabPtr_i32_i8Ptr_PxFunctionPtr_i8PtrPtrTy.getPointerTo();
//    T::i32_Of_sqlite3_vfsPtr_i8Ptr_Void_Of_VoidPtrPtrTy = T::i32_Of_sqlite3_vfsPtr_i8Ptr_Void_Of_VoidPtrTy.getPointerTo();
//    T::i32_Of_sqlite3_filePtr_i64_i32_i8PtrPtrPtrTy = T::i32_Of_sqlite3_filePtr_i64_i32_i8PtrPtrTy.getPointerTo();
//    T::i32_Of_sqlite3Ptr_i8Ptr_i32_i8PtrPtr_sqlite3_vtabPtrPtr_i8PtrPtrPtrTy = T::i32_Of_sqlite3Ptr_i8Ptr_i32_i8PtrPtr_sqlite3_vtabPtrPtr_i8PtrPtrTy.getPointerTo();
//    T::i32_Of_sqlite3_filePtr_i32_i32_i32_i8PtrPtrPtrTy = T::i32_Of_sqlite3_filePtr_i32_i32_i32_i8PtrPtrTy.getPointerTo();



//    t::setStructTyBody(T::sqlite3_mem_methodsTy, { T::i8Ptr_Of_i32PtrTy, T::Void_Of_i8PtrPtrTy, T::i8Ptr_Of_i8Ptr_i32PtrTy, T::i32_Of_i8PtrPtrTy, T::i32_Of_i32PtrTy, T::i32_Of_i8PtrPtrTy, T::Void_Of_i8PtrPtrTy, T::i8PtrTy }, false);
//    t::setStructTyBody(T::sqlite3_mutex_methodsTy, { T::i32_Of_VoidPtrTy, T::i32_Of_VoidPtrTy, T::sqlite3_mutexPtr_Of_i32PtrTy, T::Void_Of_sqlite3_mutexPtrPtrTy, T::Void_Of_sqlite3_mutexPtrPtrTy, T::i32_Of_sqlite3_mutexPtrPtrTy, T::Void_Of_sqlite3_mutexPtrPtrTy, T::i32_Of_sqlite3_mutexPtrPtrTy, T::i32_Of_sqlite3_mutexPtrPtrTy }, false);
//    t::setStructTyBody(T::sqlite3_pcache_methods2Ty, { T::i32Ty, T::i8PtrTy, T::i32_Of_i8PtrPtrTy, T::Void_Of_i8PtrPtrTy, T::sqlite3_pcachePtr_Of_i32_i32_i32PtrTy, T::Void_Of_sqlite3_pcachePtr_i32PtrTy, T::i32_Of_sqlite3_pcachePtrPtrTy, T::sqlite3_pcache_pagePtr_Of_sqlite3_pcachePtr_i32_i32PtrTy, T::Void_Of_sqlite3_pcachePtr_sqlite3_pcache_pagePtr_i32PtrTy, T::Void_Of_sqlite3_pcachePtr_sqlite3_pcache_pagePtr_i32_i32PtrTy, T::Void_Of_sqlite3_pcachePtr_i32PtrTy, T::Void_Of_sqlite3_pcachePtrPtrTy, T::Void_Of_sqlite3_pcachePtrPtrTy }, false);
//    t::setStructTyBody(T::sqlite3_pcache_pageTy, { T::i8PtrTy, T::i8PtrTy }, false);
//    t::setStructTyBody(T::sqlite3_vfsTy, { T::i32Ty, T::i32Ty, T::i32Ty, T::sqlite3_vfsPtrTy, T::i8PtrTy, T::i8PtrTy, T::i32_Of_sqlite3_vfsPtr_i8Ptr_sqlite3_filePtr_i32_i32PtrPtrTy, T::i32_Of_sqlite3_vfsPtr_i8Ptr_i32PtrTy, T::i32_Of_sqlite3_vfsPtr_i8Ptr_i32_i32PtrPtrTy, T::i32_Of_sqlite3_vfsPtr_i8Ptr_i32_i8PtrPtrTy, T::i8Ptr_Of_sqlite3_vfsPtr_i8PtrPtrTy, T::Void_Of_sqlite3_vfsPtr_i32_i8PtrPtrTy, T::Void_Of_Void_Of_Sqlite3_Vfs_i8Ptr_i8PtrTy, T::Void_Of_sqlite3_vfsPtr_i8PtrPtrTy, T::i32_Of_sqlite3_vfsPtr_i32_i8PtrPtrTy, T::i32_Of_sqlite3_vfsPtr_i32PtrTy, T::i32_Of_sqlite3_vfsPtr_doublePtrPtrTy, T::i32_Of_sqlite3_vfsPtr_i32_i8PtrPtrTy, T::i32_Of_sqlite3_vfsPtr_i64PtrPtrTy, T::i32_Of_sqlite3_vfsPtr_i8Ptr_Void_Of_VoidPtrPtrTy, T::Void_Of_Void_Of_Sqlite3_Vfs_i8PtrTy, T::i8Ptr_Of_sqlite3_vfsPtr_i8PtrPtrTy }, false);
//    t::setStructTyBody(T::sqlite3_fileTy, { T::sqlite3_io_methodsPtrTy }, false);
//    // t::setStructTyBody(T::sqlite3_io_methodsTy, { T::i32Ty, T::i32_Of_sqlite3_filePtrPtrTy, T::i32_Of_sqlite3_filePtr_i8Ptr_i32_i64PtrTy, T::i32_Of_sqlite3_filePtr_i8Ptr_i32_i64PtrTy, T::i32_Of_sqlite3_filePtr_i64PtrTy, T::i32_Of_sqlite3_filePtr_i32PtrTy, T::i32_Of_sqlite3_filePtr_i64PtrPtrTy, T::i32_Of_sqlite3_filePtr_i32PtrTy, T::i32_Of_sqlite3_filePtr_i32PtrTy, T::i32_Of_sqlite3_filePtr_i32PtrPtrTy, T::i32_Of_sqlite3_filePtr_i32_i8PtrPtrTy, T::i32_Of_sqlite3_filePtrPtrTy, T::i32_Of_sqlite3_filePtrPtrTy, T::i32_Of_sqlite3_filePtr_i32_i32_i32_i8PtrPtrPtrTy, T::i32_Of_sqlite3_filePtr_i32_i32_i32PtrTy, T::Void_Of_sqlite3_filePtrPtrTy, T::i32_Of_sqlite3_filePtr_i32PtrTy, T::i32_Of_sqlite3_filePtr_i64_i32_i8PtrPtrPtrTy, T::i32_Of_sqlite3_filePtr_i64_i8PtrPtrTy }, false);
//    t::setStructTyBody(T::VdbeTy, { T::sqlite3PtrTy, T::VdbePtrTy, T::VdbePtrTy, T::ParsePtrTy, T::i16Ty, T::Arr_2_i8Ty, T::i32Ty, T::i32Ty, T::i32Ty, T::i32Ty, T::i32Ty, T::i32Ty, T::i32Ty, T::i32Ty, T::Arr_4_i8Ty, T::i64Ty, T::i64Ty, T::i64Ty, T::i64Ty, T::sqlite3_valuePtrTy, T::sqlite3_valuePtrPtrTy, T::VdbeCursorPtrPtrTy, T::sqlite3_valuePtrTy, T::VdbeOpPtrTy, T::i32Ty, T::i32Ty, T::sqlite3_valuePtrTy, T::sqlite3_valuePtrTy, T::i8PtrTy, T::i32PtrTy, T::i64Ty, T::i16Ty, T::i8Ty, T::i8Ty, T::i8Ty, T::i16Ty, T::i8Ty, T::i32Ty, T::i32Ty, T::Arr_7_i32Ty, T::Arr_4_i8Ty, T::i8PtrTy, T::i8PtrTy, T::VdbeFramePtrTy, T::VdbeFramePtrTy, T::i32Ty, T::i32Ty, T::SubProgramPtrTy, T::AuxDataPtrTy }, true);
//    t::setStructTyBody(T::VdbeCursorTy, { T::i8Ty, T::i8Ty, T::i8Ty, T::i8Ty, T::i8Ty, T::i8Ty, T::BtreePtrTy, T::i64Ty, T::i32PtrTy, T::i32Ty, T::i32Ty, T::VdbeCursorPtrTy, T::anon7Ty, T::KeyInfoPtrTy, T::i32Ty, T::i32Ty, T::i16Ty, T::i16Ty, T::i64Ty, T::i32PtrTy, T::i8PtrTy, T::i32Ty, T::i32Ty, T::Arr_1_i32Ty }, false);
//    t::setStructTyBody(T::anon7Ty, { T::BtCursorPtrTy }, false);
//    t::setStructTyBody(T::KeyInfoTy, { T::i32Ty, T::i8Ty, T::i16Ty, T::i16Ty, T::sqlite3PtrTy, T::i8PtrTy, T::Arr_1_CollSeqPtrTy }, false);
//    t::setStructTyBody(T::VdbeOpTy, { T::i8Ty, T::i8Ty, T::i16Ty, T::i32Ty, T::i32Ty, T::i32Ty, T::p4unionTy }, false);
//    t::setStructTyBody(T::p4unionTy, { T::i8PtrTy }, false);
//    t::setStructTyBody(T::VdbeFrameTy, { T::VdbePtrTy, T::VdbeFramePtrTy, T::VdbeOpPtrTy, T::i64PtrTy, T::sqlite3_valuePtrTy, T::VdbeCursorPtrPtrTy, T::i8PtrTy, T::i8PtrTy, T::i64Ty, T::AuxDataPtrTy, T::i32Ty, T::i32Ty, T::i32Ty, T::i32Ty, T::i32Ty, T::i32Ty, T::i32Ty, T::i32Ty }, false);
//    t::setStructTyBody(T::SubProgramTy, { T::VdbeOpPtrTy, T::i32Ty, T::i32Ty, T::i32Ty, T::i8PtrTy, T::i8PtrTy, T::SubProgramPtrTy }, false);
//    t::setStructTyBody(T::AuxDataTy, { T::i32Ty, T::i32Ty, T::i8PtrTy, T::Void_Of_i8PtrPtrTy, T::AuxDataPtrTy }, false);
//    t::setStructTyBody(T::CollSeqTy, { T::i8PtrTy, T::i8Ty, T::i8PtrTy, T::i32_Of_i8Ptr_i32_i8Ptr_i32_i8PtrPtrTy, T::Void_Of_i8PtrPtrTy }, false);
//    t::setStructTyBody(T::SchemaTy, { T::i32Ty, T::i32Ty, T::HashTy, T::HashTy, T::HashTy, T::HashTy, T::TablePtrTy, T::i8Ty, T::i8Ty, T::i16Ty, T::i32Ty }, false);
//    t::setStructTyBody(T::TableTy, { T::i8PtrTy, T::ColumnPtrTy, T::IndexPtrTy, T::SelectPtrTy, T::FKeyPtrTy, T::i8PtrTy, T::ExprListPtrTy, T::i32Ty, T::i32Ty, T::i32Ty, T::i16Ty, T::i16Ty, T::i16Ty, T::i16Ty, T::i16Ty, T::i8Ty, T::i32Ty, T::i32Ty, T::i8PtrPtrTy, T::VTablePtrTy, T::TriggerPtrTy, T::SchemaPtrTy, T::TablePtrTy }, false);
//    t::setStructTyBody(T::ColumnTy, { T::i8PtrTy, T::ExprPtrTy, T::i8PtrTy, T::i8Ty, T::i8Ty, T::i8Ty, T::i16Ty }, false);
//    t::setStructTyBody(T::ExprTy, { T::i8Ty, T::i8Ty, T::i8Ty, T::i32Ty, T::anonTy, T::ExprPtrTy, T::ExprPtrTy, T::anon0Ty, T::i32Ty, T::i32Ty, T::i16Ty, T::i16Ty, T::i16Ty, T::AggInfoPtrTy, T::anon4Ty }, false);
//    t::setStructTyBody(T::anonTy, { T::i8PtrTy }, false);
//    t::setStructTyBody(T::anon0Ty, { T::ExprListPtrTy }, false);
//    t::setStructTyBody(T::AggInfoTy, { T::i8Ty, T::i8Ty, T::i32Ty, T::i32Ty, T::i32Ty, T::i32Ty, T::i32Ty, T::ExprListPtrTy, T::AggInfo_colPtrTy, T::i32Ty, T::i32Ty, T::AggInfo_funcPtrTy, T::i32Ty }, false);
//    t::setStructTyBody(T::AggInfo_colTy, { T::TablePtrTy, T::i32Ty, T::i32Ty, T::i32Ty, T::i32Ty, T::ExprPtrTy }, false);
//    t::setStructTyBody(T::AggInfo_funcTy, { T::ExprPtrTy, T::FuncDefPtrTy, T::i32Ty, T::i32Ty }, false);
//    t::setStructTyBody(T::FuncDefTy, { T::i8Ty, T::i32Ty, T::i8PtrTy, T::FuncDefPtrTy, T::Void_Of_sqlite3_contextPtr_i32_sqlite3_valuePtrPtrPtrTy, T::Void_Of_sqlite3_contextPtrPtrTy, T::Void_Of_sqlite3_contextPtrPtrTy, T::Void_Of_sqlite3_contextPtr_i32_sqlite3_valuePtrPtrPtrTy, T::i8PtrTy, T::anon8Ty }, false);
//    t::setStructTyBody(T::sqlite3_contextTy, { T::sqlite3_valuePtrTy, T::FuncDefPtrTy, T::sqlite3_valuePtrTy, T::VdbePtrTy, T::i32Ty, T::i32Ty, T::i8Ty, T::i8Ty, T::Arr_1_sqlite3_valuePtrTy }, false);
//    t::setStructTyBody(T::anon8Ty, { T::FuncDefPtrTy }, false);
//    t::setStructTyBody(T::anon4Ty, { T::TablePtrTy }, false);
//    t::setStructTyBody(T::IndexTy, { T::i8PtrTy, T::i16PtrTy, T::i16PtrTy, T::TablePtrTy, T::i8PtrTy, T::IndexPtrTy, T::SchemaPtrTy, T::i8PtrTy, T::i8PtrPtrTy, T::ExprPtrTy, T::ExprListPtrTy, T::i32Ty, T::i16Ty, T::i16Ty, T::i16Ty, T::i8Ty, T::i16Ty, T::Arr_3_i8Ty, T::i64Ty }, true);
//    t::setStructTyBody(T::SelectTy, { T::i8Ty, T::i16Ty, T::i32Ty, T::i32Ty, T::i32Ty, T::i32Ty, T::Arr_2_i32Ty, T::ExprListPtrTy, T::SrcListPtrTy, T::ExprPtrTy, T::ExprListPtrTy, T::ExprPtrTy, T::ExprListPtrTy, T::SelectPtrTy, T::SelectPtrTy, T::ExprPtrTy, T::WithPtrTy, T::WindowPtrTy, T::WindowPtrTy }, false);
//    t::setStructTyBody(T::SrcList_itemTy, { T::SchemaPtrTy, T::i8PtrTy, T::i8PtrTy, T::i8PtrTy, T::TablePtrTy, T::SelectPtrTy, T::i32Ty, T::i32Ty, T::i32Ty, T::anon2Ty, T::i32Ty, T::ExprPtrTy, T::IdListPtrTy, T::i64Ty, T::anon3Ty, T::IndexPtrTy }, false);
//    t::setStructTyBody(T::SrcListTy, { T::i32Ty, T::i32Ty, T::Arr_1_SrcList_itemTy }, false);
//    t::setStructTyBody(T::anon2Ty, { T::i8Ty, T::i8Ty, T::Arr_2_i8Ty }, false);
//    t::setStructTyBody(T::IdListTy, { T::IdList_itemPtrTy, T::i32Ty }, false);
//    t::setStructTyBody(T::IdList_itemTy, { T::i8PtrTy, T::i32Ty }, false);
//    t::setStructTyBody(T::anon3Ty, { T::i8PtrTy }, false);
//    t::setStructTyBody(T::CteTy, { T::i8PtrTy, T::ExprListPtrTy, T::SelectPtrTy, T::i8PtrTy }, false);
//    t::setStructTyBody(T::WithTy, { T::i32Ty, T::WithPtrTy, T::Arr_1_CteTy }, false);
//    t::setStructTyBody(T::WindowTy, { T::i8PtrTy, T::i8PtrTy, T::ExprListPtrTy, T::ExprListPtrTy, T::i8Ty, T::i8Ty, T::i8Ty, T::i8Ty, T::i8Ty, T::ExprPtrTy, T::ExprPtrTy, T::WindowPtrPtrTy, T::WindowPtrTy, T::ExprPtrTy, T::FuncDefPtrTy, T::i32Ty, T::i32Ty, T::i32Ty, T::i32Ty, T::i32Ty, T::i32Ty, T::ExprPtrTy, T::i32Ty, T::i32Ty, T::i32Ty, T::i32Ty, T::i32Ty, T::i8Ty }, false);
//    t::setStructTyBody(T::sColMapTy, { T::i32Ty, T::i8PtrTy }, false);
//    t::setStructTyBody(T::FKeyTy, { T::TablePtrTy, T::FKeyPtrTy, T::i8PtrTy, T::FKeyPtrTy, T::FKeyPtrTy, T::i32Ty, T::i8Ty, T::Arr_2_i8Ty, T::Arr_2_TriggerPtrTy, T::Arr_1_sColMapTy }, false);
//    t::setStructTyBody(T::ExprList_itemTy, { T::ExprPtrTy, T::i8PtrTy, T::i8Ty, T::i8Ty, T::anon1Ty }, false);
//    t::setStructTyBody(T::ExprListTy, { T::i32Ty, T::Arr_1_ExprList_itemTy }, false);
//    t::setStructTyBody(T::anon1Ty, { T::i32Ty }, false);
//    t::setStructTyBody(T::TriggerTy, { T::i8PtrTy, T::i8PtrTy, T::i8Ty, T::i8Ty, T::ExprPtrTy, T::IdListPtrTy, T::SchemaPtrTy, T::SchemaPtrTy, T::TriggerStepPtrTy, T::TriggerPtrTy }, false);
//    t::setStructTyBody(T::TriggerStepTy, { T::i8Ty, T::i8Ty, T::TriggerPtrTy, T::SelectPtrTy, T::i8PtrTy, T::ExprPtrTy, T::ExprListPtrTy, T::IdListPtrTy, T::UpsertPtrTy, T::i8PtrTy, T::TriggerStepPtrTy, T::TriggerStepPtrTy }, false);
//    t::setStructTyBody(T::UpsertTy, { T::ExprListPtrTy, T::ExprPtrTy, T::ExprListPtrTy, T::ExprPtrTy, T::IndexPtrTy, T::SrcListPtrTy, T::i32Ty, T::i32Ty, T::i32Ty }, false);
//    t::setStructTyBody(T::sqlite3InitInfoTy, { T::i32Ty, T::i8Ty, T::i8Ty, T::i8Ty, T::i8PtrPtrTy }, false);
//    t::setStructTyBody(T::ParseTy, { T::sqlite3PtrTy, T::i8PtrTy, T::VdbePtrTy, T::i32Ty, T::i8Ty, T::i8Ty, T::i8Ty, T::i8Ty, T::i8Ty, T::i8Ty, T::i8Ty, T::i8Ty, T::i8Ty, T::i8Ty, T::i32Ty, T::i32Ty, T::i32Ty, T::i32Ty, T::i32Ty, T::i32Ty, T::i32Ty, T::i32Ty, T::i32Ty, T::i32PtrTy, T::ExprListPtrTy, T::TokenTy, T::i32Ty, T::i32Ty, T::i32Ty, T::i32Ty, T::i32Ty, T::i32Ty, T::i32Ty, T::TableLockPtrTy, T::AutoincInfoPtrTy, T::ParsePtrTy, T::TablePtrTy, T::ParsePtrTy, T::i32Ty, T::i32Ty, T::i32Ty, T::i32Ty, T::i8Ty, T::i8Ty, T::i8Ty, T::Arr_8_i32Ty, T::TokenTy, T::TokenTy, T::i16Ty, T::i8Ty, T::i8Ty, T::i8Ty, T::i32Ty, T::i32Ty, T::i32Ty, T::i32PtrTy, T::VdbePtrTy, T::i8PtrTy, T::TablePtrTy, T::IndexPtrTy, T::TriggerPtrTy, T::i8PtrTy, T::TokenTy, T::TablePtrPtrTy, T::TablePtrTy, T::TriggerPrgPtrTy, T::WithPtrTy, T::WithPtrTy, T::RenameTokenPtrTy }, false);
//    t::setStructTyBody(T::AutoincInfoTy, { T::AutoincInfoPtrTy, T::TablePtrTy, T::i32Ty, T::i32Ty }, false);
//    t::setStructTyBody(T::TokenTy, { T::i8PtrTy, T::i32Ty }, false);
//    t::setStructTyBody(T::TriggerPrgTy, { T::TriggerPtrTy, T::TriggerPrgPtrTy, T::SubProgramPtrTy, T::i32Ty, T::Arr_2_i32Ty }, false);
//    t::setStructTyBody(T::anon6Ty, { T::i16Ty, T::i16Ty }, false);
//    t::setStructTyBody(T::LookasideTy, { T::i32Ty, T::i16Ty, T::i16Ty, T::i8Ty, T::i32Ty, T::Arr_3_i32Ty, T::LookasideSlotPtrTy, T::LookasideSlotPtrTy, T::LookasideSlotPtrTy, T::LookasideSlotPtrTy, T::i8PtrTy, T::i8PtrTy, T::i8PtrTy }, false);
//    t::setStructTyBody(T::LookasideSlotTy, { T::LookasideSlotPtrTy }, false);
//    t::setStructTyBody(T::VTableTy, { T::sqlite3PtrTy, T::ModulePtrTy, T::sqlite3_vtabPtrTy, T::i32Ty, T::i8Ty, T::i8Ty, T::i32Ty, T::VTablePtrTy }, false);
//    t::setStructTyBody(T::ModuleTy, { T::sqlite3_modulePtrTy, T::i8PtrTy, T::i32Ty, T::i8PtrTy, T::Void_Of_i8PtrPtrTy, T::TablePtrTy }, false);
//    t::setStructTyBody(T::sqlite3_moduleTy, { T::i32Ty, T::i32_Of_sqlite3Ptr_i8Ptr_i32_i8PtrPtr_sqlite3_vtabPtrPtr_i8PtrPtrPtrTy, T::i32_Of_sqlite3Ptr_i8Ptr_i32_i8PtrPtr_sqlite3_vtabPtrPtr_i8PtrPtrPtrTy, T::i32_Of_sqlite3_vtabPtr_sqlite3_index_infoPtrPtrTy, T::i32_Of_sqlite3_vtabPtrPtrTy, T::i32_Of_sqlite3_vtabPtrPtrTy, T::i32_Of_sqlite3_vtabPtr_sqlite3_vtab_cursorPtrPtrPtrTy, T::i32_Of_sqlite3_vtab_cursorPtrPtrTy, T::i32_Of_sqlite3_vtab_cursorPtr_i32_i8Ptr_i32_sqlite3_valuePtrPtrPtrTy, T::i32_Of_sqlite3_vtab_cursorPtrPtrTy, T::i32_Of_sqlite3_vtab_cursorPtrPtrTy, T::i32_Of_sqlite3_vtab_cursorPtr_sqlite3_contextPtr_i32PtrTy, T::i32_Of_sqlite3_vtab_cursorPtr_i64PtrPtrTy, T::i32_Of_sqlite3_vtabPtr_i32_sqlite3_valuePtrPtr_i64PtrPtrTy, T::i32_Of_sqlite3_vtabPtrPtrTy, T::i32_Of_sqlite3_vtabPtrPtrTy, T::i32_Of_sqlite3_vtabPtrPtrTy, T::i32_Of_sqlite3_vtabPtrPtrTy, T::i32_Of_sqlite3_vtabPtr_i32_i8Ptr_PxFunctionPtr_i8PtrPtrPtrTy, T::i32_Of_sqlite3_vtabPtr_i8PtrPtrTy, T::i32_Of_sqlite3_vtabPtr_i32PtrTy, T::i32_Of_sqlite3_vtabPtr_i32PtrTy, T::i32_Of_sqlite3_vtabPtr_i32PtrTy, T::i32_Of_i8PtrPtrTy }, false);
//    t::setStructTyBody(T::sqlite3_index_infoTy, { T::i32Ty, T::sqlite3_index_constraintPtrTy, T::i32Ty, T::sqlite3_index_orderbyPtrTy, T::sqlite3_index_constraint_usagePtrTy, T::i32Ty, T::i8PtrTy, T::i32Ty, T::i32Ty, T::doubleTy, T::i64Ty, T::i32Ty, T::i64Ty }, false);
//    t::setStructTyBody(T::sqlite3_index_constraintTy, { T::i32Ty, T::i8Ty, T::i8Ty, T::i32Ty }, false);
//    t::setStructTyBody(T::sqlite3_index_orderbyTy, { T::i32Ty, T::i8Ty }, false);
//    t::setStructTyBody(T::sqlite3_index_constraint_usageTy, { T::i32Ty, T::i8Ty }, false);
//    t::setStructTyBody(T::sqlite3_vtab_cursorTy, { T::sqlite3_vtabPtrTy }, false);
//    t::setStructTyBody(T::sqlite3_vtabTy, { T::sqlite3_modulePtrTy, T::i32Ty, T::i8PtrTy }, false);
//    t::setStructTyBody(T::HashTy, { T::i32Ty, T::i32Ty, T::HashElemPtrTy, T::_htPtrTy }, false);
//    t::setStructTyBody(T::HashElemTy, { T::HashElemPtrTy, T::HashElemPtrTy, T::i8PtrTy, T::i8PtrTy }, false);
//    t::setStructTyBody(T::_htTy, { T::i32Ty, T::HashElemPtrTy }, false);
//    t::setStructTyBody(T::BusyHandlerTy, { T::i32_Of_i8Ptr_i32PtrTy, T::i8PtrTy, T::i32Ty, T::i8Ty }, false);
//    t::setStructTyBody(T::SavepointTy, { T::i8PtrTy, T::i64Ty, T::i64Ty, T::SavepointPtrTy }, false);
//    t::setStructTyBody(T::UnpackedRecordTy, { T::KeyInfoPtrTy, T::sqlite3_valuePtrTy, T::i16Ty, T::i8Ty, T::i8Ty, T::i8Ty, T::i8Ty, T::i8Ty }, false);
//    t::setStructTyBody(T::BtreePayloadTy, { T::i8PtrTy, T::i64Ty, T::i8PtrTy, T::sqlite3_valuePtrTy, T::i16Ty, T::i32Ty, T::i32Ty }, false);
//    t::setStructTyBody(T::InitDataTy, { T::sqlite3PtrTy, T::i8PtrPtrTy, T::i32Ty, T::i32Ty, T::i32Ty, T::i32Ty }, false);
}
