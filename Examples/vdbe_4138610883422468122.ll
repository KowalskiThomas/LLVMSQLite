; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

%struct.sqlite3StatType = type { [10 x i64], [10 x i64] }
%struct.Sqlite3Config = type { i32, i8, i8, i8, i8, i8, i8, i32, i32, i32, i32, i32, %struct.sqlite3_mem_methods, %struct.sqlite3_mutex_methods, %struct.sqlite3_pcache_methods2, i8*, i32, i32, i32, i64, i64, i8*, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, %struct.sqlite3_mutex*, void (i8*, i32, i8*)*, i8*, i32 (i32)*, i32, i32, i32, i32 }
%struct.sqlite3_mem_methods = type { i8* (i32)*, void (i8*)*, i8* (i8*, i32)*, i32 (i8*)*, i32 (i32)*, i32 (i8*)*, void (i8*)*, i8* }
%struct.sqlite3_mutex_methods = type { i32 ()*, i32 ()*, %struct.sqlite3_mutex* (i32)*, void (%struct.sqlite3_mutex*)*, void (%struct.sqlite3_mutex*)*, i32 (%struct.sqlite3_mutex*)*, void (%struct.sqlite3_mutex*)*, i32 (%struct.sqlite3_mutex*)*, i32 (%struct.sqlite3_mutex*)* }
%struct.sqlite3_pcache_methods2 = type { i32, i8*, i32 (i8*)*, void (i8*)*, %struct.sqlite3_pcache* (i32, i32, i32)*, void (%struct.sqlite3_pcache*, i32)*, i32 (%struct.sqlite3_pcache*)*, %struct.sqlite3_pcache_page* (%struct.sqlite3_pcache*, i32, i32)*, void (%struct.sqlite3_pcache*, %struct.sqlite3_pcache_page*, i32)*, void (%struct.sqlite3_pcache*, %struct.sqlite3_pcache_page*, i32, i32)*, void (%struct.sqlite3_pcache*, i32)*, void (%struct.sqlite3_pcache*)*, void (%struct.sqlite3_pcache*)* }
%struct.sqlite3_pcache = type opaque
%struct.sqlite3_pcache_page = type { i8*, i8* }
%struct.sqlite3_mutex = type { %struct._opaque_pthread_mutex_t }
%struct._opaque_pthread_mutex_t = type { i64, [56 x i8] }
%struct.anon.9 = type { i8, i8, i8*, double, double }
%struct.sqlite3_vfs = type { i32, i32, i32, %struct.sqlite3_vfs*, i8*, i8*, i32 (%struct.sqlite3_vfs*, i8*, %struct.sqlite3_file*, i32, i32*)*, i32 (%struct.sqlite3_vfs*, i8*, i32)*, i32 (%struct.sqlite3_vfs*, i8*, i32, i32*)*, i32 (%struct.sqlite3_vfs*, i8*, i32, i8*)*, i8* (%struct.sqlite3_vfs*, i8*)*, void (%struct.sqlite3_vfs*, i32, i8*)*, void ()* (%struct.sqlite3_vfs*, i8*, i8*)*, void (%struct.sqlite3_vfs*, i8*)*, i32 (%struct.sqlite3_vfs*, i32, i8*)*, i32 (%struct.sqlite3_vfs*, i32)*, i32 (%struct.sqlite3_vfs*, double*)*, i32 (%struct.sqlite3_vfs*, i32, i8*)*, i32 (%struct.sqlite3_vfs*, i64*)*, i32 (%struct.sqlite3_vfs*, i8*, void ()*)*, void ()* (%struct.sqlite3_vfs*, i8*)*, i8* (%struct.sqlite3_vfs*, i8*)* }
%struct.sqlite3_file = type { %struct.sqlite3_io_methods* }
%struct.sqlite3_io_methods = type { i32, i32 (%struct.sqlite3_file*)*, i32 (%struct.sqlite3_file*, i8*, i32, i64)*, i32 (%struct.sqlite3_file*, i8*, i32, i64)*, i32 (%struct.sqlite3_file*, i64)*, i32 (%struct.sqlite3_file*, i32)*, i32 (%struct.sqlite3_file*, i64*)*, i32 (%struct.sqlite3_file*, i32)*, i32 (%struct.sqlite3_file*, i32)*, i32 (%struct.sqlite3_file*, i32*)*, i32 (%struct.sqlite3_file*, i32, i8*)*, i32 (%struct.sqlite3_file*)*, i32 (%struct.sqlite3_file*)*, i32 (%struct.sqlite3_file*, i32, i32, i32, i8**)*, i32 (%struct.sqlite3_file*, i32, i32, i32)*, void (%struct.sqlite3_file*)*, i32 (%struct.sqlite3_file*, i32)*, i32 (%struct.sqlite3_file*, i64, i32, i8**)*, i32 (%struct.sqlite3_file*, i64, i8*)* }
%struct.BenignMallocHooks = type { void ()*, void ()* }
%struct.Mem0Global = type { %struct.sqlite3_mutex*, i64, i64, i32 }
%struct.et_info = type { i8, i8, i8, i8, i8, i8 }
%struct.sqlite3_str = type { %struct.sqlite3*, i8*, i32, i32, i32, i8, i8 }
%struct.sqlite3 = type { %struct.sqlite3_vfs*, %struct.Vdbe*, %struct.CollSeq*, %struct.sqlite3_mutex*, %struct.Db*, i32, i32, i64, i64, i64, i32, i32, i32, i32, i32, i16, i8, i8, i8, i8, i8, i8, i8, i8, i8, i8, i8, i8, i8, i32, i32, i32, i32, [12 x i32], i32, %struct.sqlite3InitInfo, i32, i32, i32, i32, i32, i32, i8**, i32 (i32, i8*, i8*, i8*)*, i8*, void (i8*, i8*, i64)*, i8*, i8*, i32 (i8*)*, i8*, void (i8*)*, i8*, void (i8*, i32, i8*, i8*, i64)*, %struct.Parse*, i32 (i8*, %struct.sqlite3*, i8*, i32)*, i8*, void (i8*, %struct.sqlite3*, i32, i8*)*, void (i8*, %struct.sqlite3*, i32, i8*)*, i8*, %struct.sqlite3_value*, %union.anon.8, %struct.Lookaside, i32 (i8*, i32, i8*, i8*, i8*, i8*)*, i8*, i32 (i8*)*, i8*, i32, %struct.Hash, %struct.Hash, %struct.BusyHandler, [2 x %struct.Db], %struct.Savepoint*, i32, i32, i32, i64, i64, i32* }
%struct.Vdbe = type <{ %struct.sqlite3*, %struct.Vdbe*, %struct.Vdbe*, %struct.Parse*, i16, [2 x i8], i32, i32, i32, i32, i32, i32, i32, i32, [4 x i8], i64, i64, i64, i64, %struct.sqlite3_value*, %struct.sqlite3_value**, %struct.VdbeCursor**, %struct.sqlite3_value*, %struct.VdbeOp*, i32, i32, %struct.sqlite3_value*, %struct.sqlite3_value*, i8*, i32*, i16, i8, i8, i8, i16, i8, i32, i32, [7 x i32], [4 x i8], i8*, i8*, %struct.VdbeFrame*, %struct.VdbeFrame*, i32, i32, %struct.SubProgram*, %struct.AuxData* }>
%struct.VdbeCursor = type { i8, i8, i8, i8, i8, i8, %struct.Btree*, i64, i32*, i32, i32, %struct.VdbeCursor*, %union.anon.7, %struct.KeyInfo*, i32, i32, i16, i16, i64, i32*, i8*, i32, i32, [1 x i32] }
%struct.Btree = type { %struct.sqlite3*, %struct.BtShared*, i8, i8, i8, i8, i32, i32, i32, %struct.Btree*, %struct.Btree*, %struct.BtLock }
%struct.BtShared = type { %struct.Pager*, %struct.sqlite3*, %struct.BtCursor*, %struct.MemPage*, i8, i8, i8, i8, i8, i8, i16, i16, i16, i16, i16, i32, i32, i32, i32, i8*, void (i8*)*, %struct.sqlite3_mutex*, %struct.Bitvec*, i32, %struct.BtShared*, %struct.BtLock*, %struct.Btree*, i8* }
%struct.Pager = type { %struct.sqlite3_vfs*, i8, i8, i8, i8, i8, i8, i8, i8, i8, i8, i8, i8, i8, i8, i8, i8, i8, i8, i8, i8, i32, i32, i32, i32, i32, i32, i32, i32, %struct.Bitvec*, %struct.sqlite3_file*, %struct.sqlite3_file*, %struct.sqlite3_file*, i64, i64, %struct.sqlite3_backup*, %struct.PagerSavepoint*, i32, i32, [16 x i8], i32, i64, %struct.PgHdr*, i16, i16, i32, i32, i32, i32, i64, i8*, i8*, i32 (i8*)*, i8*, [4 x i32], void (%struct.PgHdr*)*, i32 (%struct.Pager*, i32, %struct.PgHdr**, i32)*, i8*, %struct.PCache*, %struct.Wal*, i8* }
%struct.sqlite3_backup = type { %struct.sqlite3*, %struct.Btree*, i32, i32, i32, %struct.sqlite3*, %struct.Btree*, i32, i32, i32, i32, %struct.sqlite3_backup* }
%struct.PagerSavepoint = type { i64, i64, %struct.Bitvec*, i32, i32, [4 x i32] }
%struct.PgHdr = type { %struct.sqlite3_pcache_page*, i8*, i8*, %struct.PCache*, %struct.PgHdr*, %struct.Pager*, i32, i16, i16, %struct.PgHdr*, %struct.PgHdr* }
%struct.PCache = type { %struct.PgHdr*, %struct.PgHdr*, %struct.PgHdr*, i32, i32, i32, i32, i32, i8, i8, i32 (i8*, %struct.PgHdr*)*, i8*, %struct.sqlite3_pcache* }
%struct.Wal = type { %struct.sqlite3_vfs*, %struct.sqlite3_file*, %struct.sqlite3_file*, i32, i64, i32, i32, i32**, i32, i16, i8, i8, i8, i8, i8, i8, i8, i8, i8, %struct.WalIndexHdr, i32, i32, i8*, i32 }
%struct.WalIndexHdr = type { i32, i32, i32, i8, i8, i16, i32, i32, [2 x i32], [2 x i32], [2 x i32] }
%struct.BtCursor = type { i8, i8, i8, i8, i32, %struct.Btree*, i32*, i8*, %struct.BtShared*, %struct.BtCursor*, %struct.CellInfo, i64, i32, i8, i8, i16, [19 x i16], %struct.KeyInfo*, %struct.MemPage*, [19 x %struct.MemPage*] }
%struct.CellInfo = type { i64, i8*, i32, i16, i16 }
%struct.MemPage = type { i8, i8, i8, i8, i32, i8, i8, i8, i8, i8, i16, i16, i16, i32, i16, i16, [4 x i16], [4 x i8*], %struct.BtShared*, i8*, i8*, i8*, i8*, %struct.PgHdr*, i16 (%struct.MemPage*, i8*)*, void (%struct.MemPage*, i8*, %struct.CellInfo*)* }
%struct.Bitvec = type { i32, i32, i32, %union.anon.10 }
%union.anon.10 = type { [62 x %struct.Bitvec*] }
%struct.BtLock = type { %struct.Btree*, i32, i8, %struct.BtLock* }
%union.anon.7 = type { %struct.BtCursor* }
%struct.KeyInfo = type { i32, i8, i16, i16, %struct.sqlite3*, i8*, [1 x %struct.CollSeq*] }
%struct.VdbeOp = type { i8, i8, i16, i32, i32, i32, %union.p4union }
%union.p4union = type { i8* }
%struct.VdbeFrame = type { %struct.Vdbe*, %struct.VdbeFrame*, %struct.VdbeOp*, i64*, %struct.sqlite3_value*, %struct.VdbeCursor**, i8*, i8*, i64, %struct.AuxData*, i32, i32, i32, i32, i32, i32, i32, i32 }
%struct.SubProgram = type { %struct.VdbeOp*, i32, i32, i32, i8*, i8*, %struct.SubProgram* }
%struct.AuxData = type { i32, i32, i8*, void (i8*)*, %struct.AuxData* }
%struct.CollSeq = type { i8*, i8, i8*, i32 (i8*, i32, i8*, i32, i8*)*, void (i8*)* }
%struct.Db = type { i8*, %struct.Btree*, i8, i8, %struct.Schema* }
%struct.Schema = type { i32, i32, %struct.Hash, %struct.Hash, %struct.Hash, %struct.Hash, %struct.Table*, i8, i8, i16, i32 }
%struct.Table = type { i8*, %struct.Column*, %struct.Index*, %struct.Select*, %struct.FKey*, i8*, %struct.ExprList*, i32, i32, i32, i16, i16, i16, i16, i16, i8, i32, %struct.Trigger*, %struct.Schema*, %struct.Table* }
%struct.Column = type { i8*, %struct.Expr*, i8*, i8, i8, i8, i16 }
%struct.Expr = type { i8, i8, i8, i32, %union.anon, %struct.Expr*, %struct.Expr*, %union.anon.0, i32, i32, i16, i16, i16, %struct.AggInfo*, %union.anon.3 }
%union.anon = type { i8* }
%union.anon.0 = type { %struct.ExprList* }
%struct.AggInfo = type { i8, i8, i32, i32, i32, i32, i32, %struct.ExprList*, %struct.AggInfo_col*, i32, i32, %struct.AggInfo_func*, i32 }
%struct.AggInfo_col = type { %struct.Table*, i32, i32, i32, i32, %struct.Expr* }
%struct.AggInfo_func = type { %struct.Expr*, %struct.FuncDef*, i32, i32 }
%struct.FuncDef = type { i8, i32, i8*, %struct.FuncDef*, void (%struct.sqlite3_context*, i32, %struct.sqlite3_value**)*, void (%struct.sqlite3_context*)*, void (%struct.sqlite3_context*)*, void (%struct.sqlite3_context*, i32, %struct.sqlite3_value**)*, i8*, %union.anon.2 }
%struct.sqlite3_context = type { %struct.sqlite3_value*, %struct.FuncDef*, %struct.sqlite3_value*, %struct.Vdbe*, i32, i32, i8, i8, [1 x %struct.sqlite3_value*] }
%union.anon.2 = type { %struct.FuncDef* }
%union.anon.3 = type { %struct.Table* }
%struct.Index = type <{ i8*, i16*, i16*, %struct.Table*, i8*, %struct.Index*, %struct.Schema*, i8*, i8**, %struct.Expr*, %struct.ExprList*, i32, i16, i16, i16, i8, i16, [3 x i8], i64 }>
%struct.Select = type { i8, i16, i32, i32, i32, i32, [2 x i32], %struct.ExprList*, %struct.SrcList*, %struct.Expr*, %struct.ExprList*, %struct.Expr*, %struct.ExprList*, %struct.Select*, %struct.Select*, %struct.Expr*, %struct.With*, %struct.Window*, %struct.Window* }
%struct.SrcList = type { i32, i32, [1 x %struct.SrcList_item] }
%struct.SrcList_item = type { %struct.Schema*, i8*, i8*, i8*, %struct.Table*, %struct.Select*, i32, i32, i32, %struct.anon, i32, %struct.Expr*, %struct.IdList*, i64, %union.anon.1, %struct.Index* }
%struct.anon = type { i8, i8, [2 x i8] }
%struct.IdList = type { %struct.IdList_item*, i32 }
%struct.IdList_item = type { i8*, i32 }
%union.anon.1 = type { i8* }
%struct.With = type { i32, %struct.With*, [1 x %struct.Cte] }
%struct.Cte = type { i8*, %struct.ExprList*, %struct.Select*, i8* }
%struct.Window = type { i8*, i8*, %struct.ExprList*, %struct.ExprList*, i8, i8, i8, i8, i8, %struct.Expr*, %struct.Expr*, %struct.Window**, %struct.Window*, %struct.Expr*, %struct.FuncDef*, i32, i32, i32, i32, i32, i32, %struct.Expr*, i32, i32, i32, i32, i32, i8 }
%struct.FKey = type { %struct.Table*, %struct.FKey*, i8*, %struct.FKey*, %struct.FKey*, i32, i8, [2 x i8], [2 x %struct.Trigger*], [1 x %struct.sColMap] }
%struct.sColMap = type { i32, i8* }
%struct.ExprList = type { i32, [1 x %struct.ExprList_item] }
%struct.ExprList_item = type { %struct.Expr*, i8*, i8, i8, %union.anon.5 }
%union.anon.5 = type { i32 }
%struct.Trigger = type { i8*, i8*, i8, i8, %struct.Expr*, %struct.IdList*, %struct.Schema*, %struct.Schema*, %struct.TriggerStep*, %struct.Trigger* }
%struct.TriggerStep = type { i8, i8, %struct.Trigger*, %struct.Select*, i8*, %struct.Expr*, %struct.ExprList*, %struct.IdList*, %struct.Upsert*, i8*, %struct.TriggerStep*, %struct.TriggerStep* }
%struct.Upsert = type { %struct.ExprList*, %struct.Expr*, %struct.ExprList*, %struct.Expr*, %struct.Index*, %struct.SrcList*, i32, i32, i32 }
%struct.sqlite3InitInfo = type { i32, i8, i8, i8, i8** }
%struct.Parse = type { %struct.sqlite3*, i8*, %struct.Vdbe*, i32, i8, i8, i8, i8, i8, i8, i8, i8, i8, i8, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32*, %struct.ExprList*, %struct.Token, i32, i32, i32, i32, i32, i32, i32, %struct.TableLock*, %struct.AutoincInfo*, %struct.Parse*, %struct.Table*, %struct.Parse*, i32, i32, i32, i32, i8, i8, i8, [8 x i32], %struct.Token, %struct.Token, i16, i8, i8, i8, i32, i32, i32*, %struct.Vdbe*, i8*, %struct.Table*, %struct.Index*, %struct.Trigger*, i8*, %struct.Table*, %struct.TriggerPrg*, %struct.With*, %struct.With*, %struct.RenameToken* }
%struct.TableLock = type { i32, i32, i8, i8* }
%struct.AutoincInfo = type { %struct.AutoincInfo*, %struct.Table*, i32, i32 }
%struct.Token = type { i8*, i32 }
%struct.TriggerPrg = type { %struct.Trigger*, %struct.TriggerPrg*, %struct.SubProgram*, i32, [2 x i32] }
%struct.RenameToken = type { i8*, %struct.Token, %struct.RenameToken* }
%struct.sqlite3_value = type { %union.MemValue, i16, i8, i8, i32, i8*, i8*, i32, i32, %struct.sqlite3*, void (i8*)* }
%union.MemValue = type { double }
%union.anon.8 = type { double }
%struct.Lookaside = type { i32, i16, i16, i8, i32, [3 x i32], %struct.LookasideSlot*, %struct.LookasideSlot*, %struct.LookasideSlot*, %struct.LookasideSlot*, i8*, i8*, i8* }
%struct.LookasideSlot = type { %struct.LookasideSlot* }
%struct.Hash = type { i32, i32, %struct.HashElem*, %struct._ht* }
%struct.HashElem = type { %struct.HashElem*, %struct.HashElem*, i8*, i8* }
%struct._ht = type { i32, %struct.HashElem* }
%struct.BusyHandler = type { i32 (i8*, i32)*, i8*, i32, i8 }
%struct.Savepoint = type { i8*, i64, i64, %struct.Savepoint* }
%struct.sqlite3PrngType = type { i8, i8, i8, [256 x i8] }
%struct.unix_syscall = type { i8*, void ()*, void ()* }
%struct.unixInodeInfo = type { %struct.unixFileId, %struct.sqlite3_mutex*, i32, i32, i8, i8, %struct.UnixUnusedFd*, i32, %struct.unixShmNode*, %struct.unixInodeInfo*, %struct.unixInodeInfo*, i64 }
%struct.unixFileId = type { i32, i64 }
%struct.UnixUnusedFd = type { i32, i32, %struct.UnixUnusedFd* }
%struct.unixShmNode = type { %struct.unixInodeInfo*, %struct.sqlite3_mutex*, i8*, i32, i32, i16, i8, i8, i8**, i32, %struct.unixShm* }
%struct.unixShm = type { %struct.unixShmNode*, %struct.unixShm*, i8, i8, i16, i16 }
%struct.unixFile = type { %struct.sqlite3_io_methods*, %struct.sqlite3_vfs*, %struct.unixInodeInfo*, i32, i8, i16, i32, i8*, %struct.UnixUnusedFd*, i8*, %struct.unixShm*, i32, i32, i64, i64, i64, i8*, i32, i32, i32, i32 }
%struct.Mapping = type { i8*, %struct.sqlite3_io_methods* }
%struct.timespec = type { i64, i64 }
%struct.__sFILE = type { i8*, i32, i32, i16, i16, %struct.__sbuf, i32, i8*, i32 (i8*)*, i32 (i8*, i8*, i32)*, i64 (i8*, i64, i32)*, i32 (i8*, i8*, i32)*, %struct.__sbuf, %struct.__sFILEX*, i32, [3 x i8], [1 x i8], %struct.__sbuf, i32, i64 }
%struct.__sFILEX = type opaque
%struct.__sbuf = type { i8*, i32 }
%struct.PCacheGlobal = type { %struct.PGroup, i32, i32, i32, i32, i32, i32, i8*, i8*, %struct.sqlite3_mutex*, %struct.PgFreeslot*, i32, i32 }
%struct.PGroup = type { %struct.sqlite3_mutex*, i32, i32, i32, i32, %struct.PgHdr1 }
%struct.PgHdr1 = type { %struct.sqlite3_pcache_page, i32, i16, i16, %struct.PgHdr1*, %struct.PCache1*, %struct.PgHdr1*, %struct.PgHdr1* }
%struct.PCache1 = type { %struct.PGroup*, i32*, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, %struct.PgHdr1**, %struct.PgHdr1*, i8* }
%struct.PgFreeslot = type { %struct.PgFreeslot* }
%struct.compareInfo = type { i8, i8, i8, i8 }
%struct.sqlite3AutoExtList = type { i32, void ()** }
%struct.PragmaName = type { i8*, i8, i8, i8, i8, i64 }
%struct.SelectDest = type { i8, i32, i32, i32, i8*, %struct.ExprList* }
%struct.FuncDefHash = type { [23 x %struct.FuncDef*] }
%struct.anon.22 = type { i32, i32 }
%struct._malloc_zone_t = type { i8*, i8*, i64 (%struct._malloc_zone_t*, i8*)*, i8* (%struct._malloc_zone_t*, i64)*, i8* (%struct._malloc_zone_t*, i64, i64)*, i8* (%struct._malloc_zone_t*, i64)*, void (%struct._malloc_zone_t*, i8*)*, i8* (%struct._malloc_zone_t*, i8*, i64)*, void (%struct._malloc_zone_t*)*, i8*, i32 (%struct._malloc_zone_t*, i64, i8**, i32)*, void (%struct._malloc_zone_t*, i8**, i32)*, %struct.malloc_introspection_t*, i32, i8* (%struct._malloc_zone_t*, i64, i64)*, void (%struct._malloc_zone_t*, i8*, i64)*, i64 (%struct._malloc_zone_t*, i64)*, i32 (%struct._malloc_zone_t*, i8*)* }
%struct.malloc_introspection_t = type { i32 (i32, i8*, i32, i64, i32 (i32, i64, i64, i8**)*, void (i32, i8*, i32, %struct.vm_range_t*, i32)*)*, i64 (%struct._malloc_zone_t*, i64)*, i32 (%struct._malloc_zone_t*)*, void (%struct._malloc_zone_t*, i32)*, void (%struct._malloc_zone_t*, i8*)*, void (%struct._malloc_zone_t*)*, void (%struct._malloc_zone_t*)*, void (%struct._malloc_zone_t*, %struct.malloc_statistics_t*)*, i32 (%struct._malloc_zone_t*)*, i32 (%struct._malloc_zone_t*)*, void (%struct._malloc_zone_t*)*, void (%struct._malloc_zone_t*, i8*)*, void (%struct._malloc_zone_t*, void (i8*, i8*)*)*, void (%struct._malloc_zone_t*)*, void (i32, i32, i64, i32 (i32, i64, i64, i8**)*, void (i8*, ...)*)*, void (i32, i64, i32 (i32, i64, i64, i8**)*, %struct.malloc_statistics_t*)* }
%struct.vm_range_t = type { i64, i64 }
%struct.malloc_statistics_t = type { i32, i64, i64, i64 }
%struct.sqlite3_api_routines = type { i8* (%struct.sqlite3_context*, i32)*, i32 (%struct.sqlite3_context*)*, i32 (%struct.sqlite3_stmt*, i32, i8*, i32, void (i8*)*)*, i32 (%struct.sqlite3_stmt*, i32, double)*, i32 (%struct.sqlite3_stmt*, i32, i32)*, i32 (%struct.sqlite3_stmt*, i32, i64)*, i32 (%struct.sqlite3_stmt*, i32)*, i32 (%struct.sqlite3_stmt*)*, i32 (%struct.sqlite3_stmt*, i8*)*, i8* (%struct.sqlite3_stmt*, i32)*, i32 (%struct.sqlite3_stmt*, i32, i8*, i32, void (i8*)*)*, i32 (%struct.sqlite3_stmt*, i32, i8*, i32, void (i8*)*)*, i32 (%struct.sqlite3_stmt*, i32, %struct.sqlite3_value*)*, i32 (%struct.sqlite3*, i32 (i8*, i32)*, i8*)*, i32 (%struct.sqlite3*, i32)*, i32 (%struct.sqlite3*)*, i32 (%struct.sqlite3*)*, i32 (%struct.sqlite3*, i8*, void (i8*, %struct.sqlite3*, i32, i8*)*)*, i32 (%struct.sqlite3*, i8*, void (i8*, %struct.sqlite3*, i32, i8*)*)*, i8* (%struct.sqlite3_stmt*, i32)*, i32 (%struct.sqlite3_stmt*, i32)*, i32 (%struct.sqlite3_stmt*, i32)*, i32 (%struct.sqlite3_stmt*)*, i8* (%struct.sqlite3_stmt*, i32)*, i8* (%struct.sqlite3_stmt*, i32)*, i8* (%struct.sqlite3_stmt*, i32)*, i8* (%struct.sqlite3_stmt*, i32)*, double (%struct.sqlite3_stmt*, i32)*, i32 (%struct.sqlite3_stmt*, i32)*, i64 (%struct.sqlite3_stmt*, i32)*, i8* (%struct.sqlite3_stmt*, i32)*, i8* (%struct.sqlite3_stmt*, i32)*, i8* (%struct.sqlite3_stmt*, i32)*, i8* (%struct.sqlite3_stmt*, i32)*, i8* (%struct.sqlite3_stmt*, i32)*, i8* (%struct.sqlite3_stmt*, i32)*, i8* (%struct.sqlite3_stmt*, i32)*, i8* (%struct.sqlite3_stmt*, i32)*, i32 (%struct.sqlite3_stmt*, i32)*, %struct.sqlite3_value* (%struct.sqlite3_stmt*, i32)*, i8* (%struct.sqlite3*, i32 (i8*)*, i8*)*, i32 (i8*)*, i32 (i8*)*, i32 (%struct.sqlite3*, i8*, i32, i8*, i32 (i8*, i32, i8*, i32, i8*)*)*, i32 (%struct.sqlite3*, i8*, i32, i8*, i32 (i8*, i32, i8*, i32, i8*)*)*, i32 (%struct.sqlite3*, i8*, i32, i32, i8*, void (%struct.sqlite3_context*, i32, %struct.sqlite3_value**)*, void (%struct.sqlite3_context*, i32, %struct.sqlite3_value**)*, void (%struct.sqlite3_context*)*)*, i32 (%struct.sqlite3*, i8*, i32, i32, i8*, void (%struct.sqlite3_context*, i32, %struct.sqlite3_value**)*, void (%struct.sqlite3_context*, i32, %struct.sqlite3_value**)*, void (%struct.sqlite3_context*)*)*, i32 (%struct.sqlite3*, i8*, %struct.sqlite3_module*, i8*)*, i32 (%struct.sqlite3_stmt*)*, %struct.sqlite3* (%struct.sqlite3_stmt*)*, i32 (%struct.sqlite3*, i8*)*, i32 (i32)*, i32 (%struct.sqlite3*)*, i8* (%struct.sqlite3*)*, i8* (%struct.sqlite3*)*, i32 (%struct.sqlite3*, i8*, i32 (i8*, i32, i8**, i8**)*, i8*, i8**)*, i32 (%struct.sqlite3_stmt*)*, i32 (%struct.sqlite3_stmt*)*, void (i8*)*, void (i8**)*, i32 (%struct.sqlite3*)*, i8* (%struct.sqlite3_context*, i32)*, i32 (%struct.sqlite3*, i8*, i8***, i32*, i32*, i8**)*, i32 ()*, void (%struct.sqlite3*)*, i64 (%struct.sqlite3*)*, i8* ()*, i32 ()*, i8* (i32)*, i8* (i8*, ...)*, i32 (i8*, %struct.sqlite3**)*, i32 (i8*, %struct.sqlite3**)*, i32 (%struct.sqlite3*, i8*, i32, %struct.sqlite3_stmt**, i8**)*, i32 (%struct.sqlite3*, i8*, i32, %struct.sqlite3_stmt**, i8**)*, i8* (%struct.sqlite3*, void (i8*, i8*, i64)*, i8*)*, void (%struct.sqlite3*, i32, i32 (i8*)*, i8*)*, i8* (i8*, i32)*, i32 (%struct.sqlite3_stmt*)*, void (%struct.sqlite3_context*, i8*, i32, void (i8*)*)*, void (%struct.sqlite3_context*, double)*, void (%struct.sqlite3_context*, i8*, i32)*, void (%struct.sqlite3_context*, i8*, i32)*, void (%struct.sqlite3_context*, i32)*, void (%struct.sqlite3_context*, i64)*, void (%struct.sqlite3_context*)*, void (%struct.sqlite3_context*, i8*, i32, void (i8*)*)*, void (%struct.sqlite3_context*, i8*, i32, void (i8*)*)*, void (%struct.sqlite3_context*, i8*, i32, void (i8*)*)*, void (%struct.sqlite3_context*, i8*, i32, void (i8*)*)*, void (%struct.sqlite3_context*, %struct.sqlite3_value*)*, i8* (%struct.sqlite3*, void (i8*)*, i8*)*, i32 (%struct.sqlite3*, i32 (i8*, i32, i8*, i8*, i8*, i8*)*, i8*)*, void (%struct.sqlite3_context*, i32, i8*, void (i8*)*)*, i8* (i32, i8*, i8*, ...)*, i32 (%struct.sqlite3_stmt*)*, i32 (%struct.sqlite3*, i8*, i8*, i8*, i8**, i8**, i32*, i32*, i32*)*, void ()*, i32 (%struct.sqlite3*)*, i8* (%struct.sqlite3*, void (i8*, i8*)*, i8*)*, i32 (%struct.sqlite3_stmt*, %struct.sqlite3_stmt*)*, i8* (%struct.sqlite3*, void (i8*, i32, i8*, i8*, i64)*, i8*)*, i8* (%struct.sqlite3_context*)*, i8* (%struct.sqlite3_value*)*, i32 (%struct.sqlite3_value*)*, i32 (%struct.sqlite3_value*)*, double (%struct.sqlite3_value*)*, i32 (%struct.sqlite3_value*)*, i64 (%struct.sqlite3_value*)*, i32 (%struct.sqlite3_value*)*, i8* (%struct.sqlite3_value*)*, i8* (%struct.sqlite3_value*)*, i8* (%struct.sqlite3_value*)*, i8* (%struct.sqlite3_value*)*, i32 (%struct.sqlite3_value*)*, i8* (i8*, %struct.__va_list_tag*)*, i32 (%struct.sqlite3*, i8*, i32)*, i32 (%struct.sqlite3*, i8*, i32, %struct.sqlite3_stmt**, i8**)*, i32 (%struct.sqlite3*, i8*, i32, %struct.sqlite3_stmt**, i8**)*, i32 (%struct.sqlite3_stmt*)*, i32 (%struct.sqlite3*, i8*, %struct.sqlite3_module*, i8*, void (i8*)*)*, i32 (%struct.sqlite3_stmt*, i32, i32)*, i32 (%struct.sqlite3_blob*)*, i32 (%struct.sqlite3_blob*)*, i32 (%struct.sqlite3*, i8*, i8*, i8*, i64, i32, %struct.sqlite3_blob**)*, i32 (%struct.sqlite3_blob*, i8*, i32, i32)*, i32 (%struct.sqlite3_blob*, i8*, i32, i32)*, i32 (%struct.sqlite3*, i8*, i32, i8*, i32 (i8*, i32, i8*, i32, i8*)*, void (i8*)*)*, i32 (%struct.sqlite3*, i8*, i32, i8*)*, i64 (i32)*, i64 ()*, %struct.sqlite3_mutex* (i32)*, void (%struct.sqlite3_mutex*)*, void (%struct.sqlite3_mutex*)*, void (%struct.sqlite3_mutex*)*, i32 (%struct.sqlite3_mutex*)*, i32 (i8*, %struct.sqlite3**, i32, i8*)*, i32 (i32)*, void (%struct.sqlite3_context*)*, void (%struct.sqlite3_context*)*, i32 (i32)*, void (i32)*, %struct.sqlite3_vfs* (i8*)*, i32 (%struct.sqlite3_vfs*, i32)*, i32 (%struct.sqlite3_vfs*)*, i32 ()*, void (%struct.sqlite3_context*, i32)*, void (%struct.sqlite3_context*, i32)*, i32 (i32, ...)*, void (i32, i8*)*, %struct.sqlite3* (%struct.sqlite3_context*)*, i32 (%struct.sqlite3*, i32)*, i32 (%struct.sqlite3*, i32, i32)*, %struct.sqlite3_stmt* (%struct.sqlite3*, %struct.sqlite3_stmt*)*, i8* (%struct.sqlite3_stmt*)*, i32 (i32, i32*, i32*, i32)*, i32 (%struct.sqlite3_backup*)*, %struct.sqlite3_backup* (%struct.sqlite3*, i8*, %struct.sqlite3*, i8*)*, i32 (%struct.sqlite3_backup*)*, i32 (%struct.sqlite3_backup*)*, i32 (%struct.sqlite3_backup*, i32)*, i8* (i32)*, i32 (i8*)*, i32 (%struct.sqlite3*, i8*, i32, i32, i8*, void (%struct.sqlite3_context*, i32, %struct.sqlite3_value**)*, void (%struct.sqlite3_context*, i32, %struct.sqlite3_value**)*, void (%struct.sqlite3_context*)*, void (i8*)*)*, i32 (%struct.sqlite3*, i32, ...)*, %struct.sqlite3_mutex* (%struct.sqlite3*)*, i32 (%struct.sqlite3*, i32, i32*, i32*, i32)*, i32 (%struct.sqlite3*)*, void (i32, i8*, ...)*, i64 (i64)*, i8* ()*, i32 (%struct.sqlite3_stmt*, i32, i32)*, i32 (i8*, i8*, i32)*, i32 (%struct.sqlite3*, void (i8**, i32)*, i8*)*, i32 (%struct.sqlite3*, i32)*, i32 (%struct.sqlite3*, i8*)*, i8* (%struct.sqlite3*, i32 (i8*, %struct.sqlite3*, i8*, i32)*, i8*)*, i32 (%struct.sqlite3_blob*, i64)*, i32 (%struct.sqlite3*, i32, ...)*, i32 (%struct.sqlite3*)*, i32 (%struct.sqlite3*)*, i8* (%struct.sqlite3*, i8*)*, i32 (%struct.sqlite3*, i8*)*, i32 (%struct.sqlite3*)*, i8* (i32)*, i32 (%struct.sqlite3_stmt*)*, i32 (%struct.sqlite3_stmt*)*, i32 (i8*, i8*)*, i32 (i8*, i8*, i32)*, i64 (i8*, i8*, i64)*, i8* (i8*, i8*)*, i8* (i32, i8*, i8*, %struct.__va_list_tag*)*, i32 (%struct.sqlite3*, i8*, i32, i32*, i32*)*, i32 (void ()*)*, i32 (%struct.sqlite3_stmt*, i32, i8*, i64, void (i8*)*)*, i32 (%struct.sqlite3_stmt*, i32, i8*, i64, void (i8*)*, i8)*, i32 (void ()*)*, i32 (%struct.sqlite3*, i8*, i8*, i8**)*, i8* (i64)*, i64 (i8*)*, i8* (i8*, i64)*, void ()*, void (%struct.sqlite3_context*, i8*, i64, void (i8*)*)*, void (%struct.sqlite3_context*, i8*, i64, void (i8*)*, i8)*, i32 (i8*, i8*)*, %struct.sqlite3_value* (%struct.sqlite3_value*)*, void (%struct.sqlite3_value*)*, i32 (%struct.sqlite3_context*, i64)*, i32 (%struct.sqlite3_stmt*, i32, i64)*, i32 (%struct.sqlite3_value*)*, void (%struct.sqlite3_context*, i32)*, i32 (i32, i64*, i64*, i32)*, i32 (i8*, i8*, i32)*, i32 (%struct.sqlite3*)*, i32 (%struct.sqlite3*)*, i32 (%struct.sqlite3*, i32, i32 (i32, i8*, i8*, i8*)*, i8*)*, i8* (%struct.sqlite3_stmt*)*, void (%struct.sqlite3*, i64)*, i32 (%struct.sqlite3*, i8*, i32, i32, %struct.sqlite3_stmt**, i8**)*, i32 (%struct.sqlite3*, i8*, i32, i32, %struct.sqlite3_stmt**, i8**)*, i32 (%struct.sqlite3_stmt*, i32, i8*, i8*, void (i8*)*)*, void (%struct.sqlite3_context*, i8*, i8*, void (i8*)*)*, i8* (%struct.sqlite3_value*, i8*)*, i32 (%struct.sqlite3_context*)*, i32 (%struct.sqlite3_value*)*, i8* (%struct.sqlite3_index_info*, i32)*, i32 ()*, i32 (i32, i8**, i32*)*, i32 (i8*, i32)*, %struct.sqlite3_str* (%struct.sqlite3*)*, i8* (%struct.sqlite3_str*)*, void (%struct.sqlite3_str*, i8*, ...)*, void (%struct.sqlite3_str*, i8*, %struct.__va_list_tag*)*, void (%struct.sqlite3_str*, i8*, i32)*, void (%struct.sqlite3_str*, i8*)*, void (%struct.sqlite3_str*, i32, i8)*, void (%struct.sqlite3_str*)*, i32 (%struct.sqlite3_str*)*, i32 (%struct.sqlite3_str*)*, i8* (%struct.sqlite3_str*)*, i32 (%struct.sqlite3*, i8*, i32, i32, i8*, void (%struct.sqlite3_context*, i32, %struct.sqlite3_value**)*, void (%struct.sqlite3_context*)*, void (%struct.sqlite3_context*)*, void (%struct.sqlite3_context*, i32, %struct.sqlite3_value**)*, void (i8*)*)*, i8* (%struct.sqlite3_stmt*)*, i32 (%struct.sqlite3_stmt*)*, i32 (%struct.sqlite3_value*)*, i32 (%struct.sqlite3*, i8**)*, i64 (i64)*, i8* (i8*, i32)*, i8* (i8*)*, i8* (i8*)*, i8* (i8*)*, i8* (i8*, i8*, i8*, i32, i8**)*, void (i8*)* }
%struct.sqlite3_stmt = type opaque
%struct.sqlite3_module = type { i32, i32 (%struct.sqlite3*, i8*, i32, i8**, %struct.sqlite3_vtab**, i8**)*, i32 (%struct.sqlite3*, i8*, i32, i8**, %struct.sqlite3_vtab**, i8**)*, i32 (%struct.sqlite3_vtab*, %struct.sqlite3_index_info*)*, i32 (%struct.sqlite3_vtab*)*, i32 (%struct.sqlite3_vtab*)*, i32 (%struct.sqlite3_vtab*, %struct.sqlite3_vtab_cursor**)*, i32 (%struct.sqlite3_vtab_cursor*)*, i32 (%struct.sqlite3_vtab_cursor*, i32, i8*, i32, %struct.sqlite3_value**)*, i32 (%struct.sqlite3_vtab_cursor*)*, i32 (%struct.sqlite3_vtab_cursor*)*, i32 (%struct.sqlite3_vtab_cursor*, %struct.sqlite3_context*, i32)*, i32 (%struct.sqlite3_vtab_cursor*, i64*)*, i32 (%struct.sqlite3_vtab*, i32, %struct.sqlite3_value**, i64*)*, i32 (%struct.sqlite3_vtab*)*, i32 (%struct.sqlite3_vtab*)*, i32 (%struct.sqlite3_vtab*)*, i32 (%struct.sqlite3_vtab*)*, i32 (%struct.sqlite3_vtab*, i32, i8*, void (%struct.sqlite3_context*, i32, %struct.sqlite3_value**)**, i8**)*, i32 (%struct.sqlite3_vtab*, i8*)*, i32 (%struct.sqlite3_vtab*, i32)*, i32 (%struct.sqlite3_vtab*, i32)*, i32 (%struct.sqlite3_vtab*, i32)*, i32 (i8*)* }
%struct.sqlite3_vtab = type { %struct.sqlite3_module*, i32, i8* }
%struct.sqlite3_index_info = type { i32, %struct.sqlite3_index_constraint*, i32, %struct.sqlite3_index_orderby*, %struct.sqlite3_index_constraint_usage*, i32, i8*, i32, i32, double, i64, i32, i64 }
%struct.sqlite3_index_constraint = type { i32, i8, i8, i32 }
%struct.sqlite3_index_orderby = type { i32, i8 }
%struct.sqlite3_index_constraint_usage = type { i32, i8 }
%struct.sqlite3_vtab_cursor = type { %struct.sqlite3_vtab* }
%struct.__va_list_tag = type { i32, i32, i8*, i8* }
%struct.sqlite3_blob = type opaque
%struct.WindowUpdate = type { i8*, i32, i32, i32 }
%struct.anon.23 = type { i8, i8, i8 }
%struct.EncName = type { i8*, i8 }
%struct.OpenMode = type { i8*, i32 }
%struct.RowSet = type { %struct.RowSetChunk*, %struct.sqlite3*, %struct.RowSetEntry*, %struct.RowSetEntry*, %struct.RowSetEntry*, %struct.RowSetEntry*, i16, i16, i32 }
%struct.RowSetChunk = type { %struct.RowSetChunk*, [42 x %struct.RowSetEntry] }
%struct.RowSetEntry = type { i64, %struct.RowSetEntry*, %struct.RowSetEntry* }
%struct.UnpackedRecord = type { %struct.KeyInfo*, %struct.sqlite3_value*, i16, i8, i8, i8, i8, i8 }
%struct.BtreePayload = type { i8*, i64, i8*, %struct.sqlite3_value*, i16, i32, i32 }
%struct.DateTime = type { i64, i32, i32, i32, i32, i32, i32, double, i8, i8, i8, i8, i8, i8, i8 }
%struct.tm = type { i32, i32, i32, i32, i32, i32, i32, i32, i32, i64, i8* }
%struct._opaque_pthread_mutexattr_t = type { i64, [8 x i8] }
%struct.PrintfArguments = type { i32, i32, %struct.sqlite3_value** }
%struct.stat = type { i32, i16, i16, i64, i32, i32, i32, %struct.timespec, %struct.timespec, %struct.timespec, %struct.timespec, i64, i64, i32, i32, i32, i32, [2 x i64] }
%struct.flock = type { i64, i64, i32, i16, i16 }
%struct.timeval = type { i64, i32 }
%struct.statfs = type { i32, i32, i64, i64, i64, i64, i64, %struct.fsid, i32, i32, i32, i32, [16 x i8], [1024 x i8], [1024 x i8], i32, [7 x i32] }
%struct.fsid = type { [2 x i32] }
%struct.WalCkptInfo = type { i32, [5 x i32], [8 x i8], i32, i32 }
%struct.WalHashLoc = type { i16*, i32*, i32 }
%struct.WalIterator = type { i32, i32, [1 x %struct.WalSegment] }
%struct.WalSegment = type { i32, i16*, i32*, i32, i32 }
%struct.WalWriter = type { %struct.Wal*, %struct.sqlite3_file*, i64, i32, i32 }
%struct.CellArray = type { i32, %struct.MemPage*, i8**, i16*, [6 x i8*], [6 x i32] }
%struct.IntegrityCk = type { %struct.BtShared*, %struct.Pager*, i8*, i32, i32, i32, i32, i8*, i32, i32, %struct.sqlite3_str, i32*, %struct.sqlite3* }
%struct.ValueNewStat4Ctx = type { %struct.Parse*, %struct.Index*, %struct.UnpackedRecord**, i32 }
%struct.ReusableSpace = type { i8*, i64, i64 }
%struct.Incrblob = type { i32, i32, i16, %struct.BtCursor*, %struct.sqlite3_stmt*, %struct.sqlite3*, i8*, %struct.Table* }
%struct.PmaReader = type { i64, i64, i32, i32, %struct.sqlite3_file*, i8*, i8*, i8*, i32, i8*, %struct.IncrMerger* }
%struct.IncrMerger = type { %struct.SortSubtask*, %struct.MergeEngine*, i64, i32, i32, i32, [2 x %struct.SorterFile] }
%struct.SortSubtask = type { %struct.SQLiteThread*, i32, %struct.VdbeSorter*, %struct.UnpackedRecord*, %struct.SorterList, i32, i32 (%struct.SortSubtask*, i32*, i8*, i32, i8*, i32)*, %struct.SorterFile, %struct.SorterFile }
%struct.SQLiteThread = type { %struct._opaque_pthread_t*, i32, i8*, i8* (i8*)*, i8* }
%struct._opaque_pthread_t = type { i64, %struct.__darwin_pthread_handler_rec*, [8176 x i8] }
%struct.__darwin_pthread_handler_rec = type { void (i8*)*, i8*, %struct.__darwin_pthread_handler_rec* }
%struct.VdbeSorter = type { i32, i32, i32, i32, %struct.PmaReader*, %struct.MergeEngine*, %struct.sqlite3*, %struct.KeyInfo*, %struct.UnpackedRecord*, %struct.SorterList, i32, i32, i8, i8, i8, i8, i8, [1 x %struct.SortSubtask] }
%struct.SorterList = type { %struct.SorterRecord*, i8*, i32 }
%struct.SorterRecord = type { i32, %union.anon.11 }
%union.anon.11 = type { %struct.SorterRecord* }
%struct.SorterFile = type { %struct.sqlite3_file*, i64 }
%struct.MergeEngine = type { i32, %struct.SortSubtask*, i32*, %struct.PmaReader* }
%struct.PmaWriter = type { i32, i8*, i32, i32, i32, i64, %struct.sqlite3_file* }
%struct.MemJournal = type { %struct.sqlite3_io_methods*, i32, i32, i32, %struct.FileChunk*, %struct.FilePoint, %struct.FilePoint, i32, %struct.sqlite3_vfs*, i8* }
%struct.FileChunk = type { %struct.FileChunk*, [8 x i8] }
%struct.FilePoint = type { i64, %struct.FileChunk* }
%struct.Walker = type { %struct.Parse*, i32 (%struct.Walker*, %struct.Expr*)*, i32 (%struct.Walker*, %struct.Select*)*, void (%struct.Walker*, %struct.Select*)*, i32, i16, %union.anon.12 }
%union.anon.12 = type { %struct.NameContext* }
%struct.NameContext = type { %struct.Parse*, %struct.SrcList*, %union.anon.13, %struct.NameContext*, i32, i32, i32, %struct.Select* }
%union.anon.13 = type { %struct.ExprList* }
%struct.RenameCtx = type { %struct.RenameToken*, i32, i32, %struct.Table*, i8* }
%struct.WhereInfo = type { %struct.Parse*, %struct.SrcList*, %struct.ExprList*, %struct.ExprList*, %struct.Expr*, [2 x i32], i32, i32, i32, i16, i16, i8, i8, i8, i8, i8, i16, i32, %struct.WhereLoop*, %struct.WhereExprMod*, i64, %struct.WhereClause, %struct.WhereMaskSet, [1 x %struct.WhereLevel] }
%struct.WhereLoop = type { i64, i64, i8, i8, i16, i16, i16, %union.anon.15, i32, i16, i16, i16, %struct.WhereTerm**, %struct.WhereLoop*, [3 x %struct.WhereTerm*] }
%union.anon.15 = type { %struct.anon.16 }
%struct.anon.16 = type { i16, i16, i16, i16, %struct.Index* }
%struct.WhereTerm = type { %struct.Expr*, %struct.WhereClause*, i16, i16, i16, i8, i8, i32, i32, i32, %union.anon.18, i64, i64 }
%union.anon.18 = type { %struct.WhereOrInfo* }
%struct.WhereOrInfo = type { %struct.WhereClause, i64 }
%struct.WhereExprMod = type { %struct.WhereExprMod*, %struct.Expr*, %struct.Expr }
%struct.WhereClause = type { %struct.WhereInfo*, %struct.WhereClause*, i8, i8, i32, i32, %struct.WhereTerm*, [8 x %struct.WhereTerm] }
%struct.WhereMaskSet = type { i32, i32, [64 x i32] }
%struct.WhereLevel = type { i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i8, i8, i8, i8, i32, i32, %union.anon.19, %struct.WhereLoop*, i64 }
%union.anon.19 = type { %struct.anon.20 }
%struct.anon.20 = type { i32, %struct.InLoop* }
%struct.InLoop = type { i32, i32, i32, i32, i8 }
%struct.InitData = type { %struct.sqlite3*, i8**, i32, i32, i32, i32 }
%struct.RowLoadInfo = type { i32, i8 }
%struct.SortCtx = type { %struct.ExprList*, i32, i32, i32, i32, i32, i32, i32, i8, %struct.RowLoadInfo* }
%struct.DistinctCtx = type { i8, i8, i32, i32 }
%struct.SubstContext = type { %struct.Parse*, i32, i32, i32, %struct.ExprList* }
%struct.WhereConst = type { %struct.Parse*, i32, i32, %struct.Expr** }
%struct.IdxExprTrans = type { %struct.Expr*, i32, i32, i32, i32, %struct.WhereInfo*, %struct.sqlite3* }
%struct.WhereAndInfo = type { %struct.WhereClause }
%struct.WhereOrSet = type { i16, [3 x %struct.WhereOrCost] }
%struct.WhereOrCost = type { i64, i16, i16 }
%struct.WhereScan = type { %struct.WhereClause*, %struct.WhereClause*, i8*, %struct.Expr*, i8, i8, i8, i32, i32, [11 x i32], [11 x i16] }
%struct.WhereLoopBuilder = type { %struct.WhereInfo*, %struct.WhereClause*, %struct.ExprList*, %struct.WhereLoop*, %struct.WhereOrSet*, i8, i8, i32 }
%struct.WherePath = type { i64, i64, i16, i16, i16, i8, %struct.WhereLoop** }
%struct.WindowCodeArg = type { %struct.Parse*, %struct.Window*, %struct.Vdbe*, i32, i32, i32, i32, %struct.WindowCsrAndReg, %struct.WindowCsrAndReg, %struct.WindowCsrAndReg }
%struct.WindowCsrAndReg = type { i32, i32 }
%struct.yyParser = type { %struct.yyStackEntry*, %struct.Parse*, [100 x %struct.yyStackEntry], %struct.yyStackEntry* }
%struct.yyStackEntry = type { i16, i16, %union.YYMINORTYPE }
%union.YYMINORTYPE = type { %struct.Token }
%struct.FuncDestructor = type { i32, void (i8*)*, i8* }
%struct._opaque_pthread_attr_t = type { i64, [56 x i8] }
%struct.DbFixer = type { %struct.Parse*, %struct.Schema*, i8, i8*, i8*, %struct.Token* }

@sqlite3_version = constant [7 x i8] c"3.32.0\00", align 1
@sqlite3Stat = local_unnamed_addr global %struct.sqlite3StatType zeroinitializer, align 8
@statMutex = local_unnamed_addr constant [10 x i8] c"\00\01\01\00\00\00\00\01\00\00", align 1
@sqlite3Config = external dso_local global %struct.Sqlite3Config, align 8
@getDigits.aMx = internal unnamed_addr constant [6 x i16] [i16 12, i16 14, i16 24, i16 31, i16 59, i16 9999], align 2
@sqlite3CtypeMap = internal constant [256 x i8] c"\00\00\00\00\00\00\00\00\00\01\01\01\01\01\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\01\00\80\00@\00\00\80\00\00\00\00\00\00\00\00\0C\0C\0C\0C\0C\0C\0C\0C\0C\0C\00\00\00\00\00\00\00\0A\0A\0A\0A\0A\0A\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\80\00\00\00@\80******\22\22\22\22\22\22\22\22\22\22\22\22\22\22\22\22\22\22\22\22\00\00\00\00\00@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@", align 16
@.str = private unnamed_addr constant [8 x i8] c"20b:20e\00", align 1
@.str.1 = private unnamed_addr constant [8 x i8] c"20c:20e\00", align 1
@.str.2 = private unnamed_addr constant [4 x i8] c"20e\00", align 1
@.str.3 = private unnamed_addr constant [12 x i8] c"40f-21a-21d\00", align 1
@.str.4 = private unnamed_addr constant [4 x i8] c"now\00", align 1
@.str.5 = private unnamed_addr constant [23 x i8] c"local time unavailable\00", align 1
@.str.6 = private unnamed_addr constant [7 x i8] c"second\00", align 1
@.str.7 = private unnamed_addr constant [7 x i8] c"minute\00", align 1
@.str.8 = private unnamed_addr constant [5 x i8] c"hour\00", align 1
@.str.9 = private unnamed_addr constant [4 x i8] c"day\00", align 1
@.str.10 = private unnamed_addr constant [6 x i8] c"month\00", align 1
@.str.11 = private unnamed_addr constant [5 x i8] c"year\00", align 1
@aXformType = local_unnamed_addr constant [6 x %struct.anon.9] [%struct.anon.9 { i8 0, i8 6, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.6, i32 0, i32 0), double 0x425B0625EAB00000, double 1.000000e+03 }, %struct.anon.9 { i8 0, i8 6, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.7, i32 0, i32 0), double 0x41FCD35BA5000000, double 6.000000e+04 }, %struct.anon.9 { i8 0, i8 4, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.8, i32 0, i32 0), double 0x419EBF50B0000000, double 3.600000e+06 }, %struct.anon.9 { i8 0, i8 3, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.9, i32 0, i32 0), double 0x41547F8B40000000, double 8.640000e+07 }, %struct.anon.9 { i8 1, i8 5, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.10, i32 0, i32 0), double 1.765460e+05, double 2.592000e+09 }, %struct.anon.9 { i8 2, i8 4, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.11, i32 0, i32 0), double 1.471300e+04, double 3.153600e+10 }], align 16
@sqlite3UpperToLower = internal unnamed_addr constant [256 x i8] c"\00\01\02\03\04\05\06\07\08\09\0A\0B\0C\0D\0E\0F\10\11\12\13\14\15\16\17\18\19\1A\1B\1C\1D\1E\1F !\22#$%&'()*+,-./0123456789:;<=>?@abcdefghijklmnopqrstuvwxyz[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~\7F\80\81\82\83\84\85\86\87\88\89\8A\8B\8C\8D\8E\8F\90\91\92\93\94\95\96\97\98\99\9A\9B\9C\9D\9E\9F\A0\A1\A2\A3\A4\A5\A6\A7\A8\A9\AA\AB\AC\AD\AE\AF\B0\B1\B2\B3\B4\B5\B6\B7\B8\B9\BA\BB\BC\BD\BE\BF\C0\C1\C2\C3\C4\C5\C6\C7\C8\C9\CA\CB\CC\CD\CE\CF\D0\D1\D2\D3\D4\D5\D6\D7\D8\D9\DA\DB\DC\DD\DE\DF\E0\E1\E2\E3\E4\E5\E6\E7\E8\E9\EA\EB\EC\ED\EE\EF\F0\F1\F2\F3\F4\F5\F6\F7\F8\F9\FA\FB\FC\FD\FE\FF", align 16
@.str.12 = private unnamed_addr constant [10 x i8] c"localtime\00", align 1
@.str.13 = private unnamed_addr constant [10 x i8] c"unixepoch\00", align 1
@.str.14 = private unnamed_addr constant [4 x i8] c"utc\00", align 1
@.str.15 = private unnamed_addr constant [9 x i8] c"weekday \00", align 1
@.str.16 = private unnamed_addr constant [10 x i8] c"start of \00", align 1
@.str.17 = private unnamed_addr constant [30 x i8] c"%04d-%02d-%02d %02d:%02d:%02d\00", align 1
@.str.18 = private unnamed_addr constant [15 x i8] c"%02d:%02d:%02d\00", align 1
@.str.19 = private unnamed_addr constant [15 x i8] c"%04d-%02d-%02d\00", align 1
@.str.20 = private unnamed_addr constant [5 x i8] c"%02d\00", align 1
@.str.21 = private unnamed_addr constant [7 x i8] c"%06.3f\00", align 1
@.str.22 = private unnamed_addr constant [5 x i8] c"%03d\00", align 1
@.str.23 = private unnamed_addr constant [6 x i8] c"%.16g\00", align 1
@.str.24 = private unnamed_addr constant [5 x i8] c"%lld\00", align 1
@.str.25 = private unnamed_addr constant [5 x i8] c"%04d\00", align 1
@vfsList = local_unnamed_addr global %struct.sqlite3_vfs* null, align 8
@sqlite3Hooks = local_unnamed_addr global %struct.BenignMallocHooks zeroinitializer, align 8
@pthreadMutexAlloc.staticMutexes = internal global [12 x %struct.sqlite3_mutex] [%struct.sqlite3_mutex { %struct._opaque_pthread_mutex_t { i64 850045863, [56 x i8] zeroinitializer } }, %struct.sqlite3_mutex { %struct._opaque_pthread_mutex_t { i64 850045863, [56 x i8] zeroinitializer } }, %struct.sqlite3_mutex { %struct._opaque_pthread_mutex_t { i64 850045863, [56 x i8] zeroinitializer } }, %struct.sqlite3_mutex { %struct._opaque_pthread_mutex_t { i64 850045863, [56 x i8] zeroinitializer } }, %struct.sqlite3_mutex { %struct._opaque_pthread_mutex_t { i64 850045863, [56 x i8] zeroinitializer } }, %struct.sqlite3_mutex { %struct._opaque_pthread_mutex_t { i64 850045863, [56 x i8] zeroinitializer } }, %struct.sqlite3_mutex { %struct._opaque_pthread_mutex_t { i64 850045863, [56 x i8] zeroinitializer } }, %struct.sqlite3_mutex { %struct._opaque_pthread_mutex_t { i64 850045863, [56 x i8] zeroinitializer } }, %struct.sqlite3_mutex { %struct._opaque_pthread_mutex_t { i64 850045863, [56 x i8] zeroinitializer } }, %struct.sqlite3_mutex { %struct._opaque_pthread_mutex_t { i64 850045863, [56 x i8] zeroinitializer } }, %struct.sqlite3_mutex { %struct._opaque_pthread_mutex_t { i64 850045863, [56 x i8] zeroinitializer } }, %struct.sqlite3_mutex { %struct._opaque_pthread_mutex_t { i64 850045863, [56 x i8] zeroinitializer } }], align 16
@mem0 = local_unnamed_addr global %struct.Mem0Global zeroinitializer, align 8
@aDigits = local_unnamed_addr constant [33 x i8] c"0123456789ABCDEF0123456789abcdef\00", align 16
@aPrefix = local_unnamed_addr constant [7 x i8] c"-x0\00X0\00", align 1
@fmtinfo = local_unnamed_addr constant [23 x %struct.et_info] [%struct.et_info { i8 100, i8 10, i8 1, i8 16, i8 0, i8 0 }, %struct.et_info { i8 115, i8 0, i8 4, i8 5, i8 0, i8 0 }, %struct.et_info { i8 103, i8 0, i8 1, i8 3, i8 30, i8 0 }, %struct.et_info { i8 122, i8 0, i8 4, i8 6, i8 0, i8 0 }, %struct.et_info { i8 113, i8 0, i8 4, i8 9, i8 0, i8 0 }, %struct.et_info { i8 81, i8 0, i8 4, i8 10, i8 0, i8 0 }, %struct.et_info { i8 119, i8 0, i8 4, i8 14, i8 0, i8 0 }, %struct.et_info { i8 99, i8 0, i8 0, i8 8, i8 0, i8 0 }, %struct.et_info { i8 111, i8 8, i8 0, i8 0, i8 0, i8 2 }, %struct.et_info { i8 117, i8 10, i8 0, i8 16, i8 0, i8 0 }, %struct.et_info { i8 120, i8 16, i8 0, i8 0, i8 16, i8 1 }, %struct.et_info { i8 88, i8 16, i8 0, i8 0, i8 0, i8 4 }, %struct.et_info { i8 102, i8 0, i8 1, i8 1, i8 0, i8 0 }, %struct.et_info { i8 101, i8 0, i8 1, i8 2, i8 30, i8 0 }, %struct.et_info { i8 69, i8 0, i8 1, i8 2, i8 14, i8 0 }, %struct.et_info { i8 71, i8 0, i8 1, i8 3, i8 14, i8 0 }, %struct.et_info { i8 105, i8 10, i8 1, i8 16, i8 0, i8 0 }, %struct.et_info { i8 110, i8 0, i8 0, i8 4, i8 0, i8 0 }, %struct.et_info { i8 37, i8 0, i8 0, i8 7, i8 0, i8 0 }, %struct.et_info { i8 112, i8 16, i8 0, i8 13, i8 0, i8 1 }, %struct.et_info { i8 84, i8 0, i8 0, i8 11, i8 0, i8 0 }, %struct.et_info { i8 83, i8 0, i8 0, i8 12, i8 0, i8 0 }, %struct.et_info { i8 114, i8 10, i8 1, i8 15, i8 0, i8 0 }], align 16
@arRound = local_unnamed_addr constant [10 x double] [double 5.000000e-01, double 5.000000e-02, double 5.000000e-03, double 5.000000e-04, double 5.000000e-05, double 5.000000e-06, double 5.000000e-07, double 5.000000e-08, double 5.000000e-09, double 5.000000e-10], align 16
@.str.26 = private unnamed_addr constant [2 x i8] c"%\00", align 1
@sqlite3_str_vappendf.zOrd = internal unnamed_addr constant [9 x i8] c"thstndrd\00", align 1
@.str.27 = private unnamed_addr constant [4 x i8] c"NaN\00", align 1
@.str.29 = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@.str.30 = private unnamed_addr constant [5 x i8] c"NULL\00", align 1
@.str.31 = private unnamed_addr constant [7 x i8] c"(NULL)\00", align 1
@.str.32 = private unnamed_addr constant [2 x i8] c".\00", align 1
@sqlite3OomStr = internal global %struct.sqlite3_str { %struct.sqlite3* null, i8* null, i32 0, i32 0, i32 0, i8 7, i8 0 }, align 8
@sqlite3Prng = local_unnamed_addr global %struct.sqlite3PrngType zeroinitializer, align 1
@.str.33 = private unnamed_addr constant [19 x i8] c"922337203685477580\00", align 1
@.str.34 = private unnamed_addr constant [45 x i8] c"API call with %s database connection pointer\00", align 1
@findElementWithHash.nullElement = internal global %struct.HashElem zeroinitializer, align 8
@randomnessPid = global i32 0, align 4
@.str.35 = private unnamed_addr constant [5 x i8] c"open\00", align 1
@.str.36 = private unnamed_addr constant [6 x i8] c"close\00", align 1
@.str.37 = private unnamed_addr constant [7 x i8] c"access\00", align 1
@.str.38 = private unnamed_addr constant [7 x i8] c"getcwd\00", align 1
@.str.39 = private unnamed_addr constant [5 x i8] c"stat\00", align 1
@.str.40 = private unnamed_addr constant [6 x i8] c"fstat\00", align 1
@.str.41 = private unnamed_addr constant [10 x i8] c"ftruncate\00", align 1
@.str.42 = private unnamed_addr constant [6 x i8] c"fcntl\00", align 1
@.str.43 = private unnamed_addr constant [5 x i8] c"read\00", align 1
@.str.44 = private unnamed_addr constant [6 x i8] c"pread\00", align 1
@.str.45 = private unnamed_addr constant [8 x i8] c"pread64\00", align 1
@.str.46 = private unnamed_addr constant [6 x i8] c"write\00", align 1
@.str.47 = private unnamed_addr constant [7 x i8] c"pwrite\00", align 1
@.str.48 = private unnamed_addr constant [9 x i8] c"pwrite64\00", align 1
@.str.49 = private unnamed_addr constant [7 x i8] c"fchmod\00", align 1
@.str.50 = private unnamed_addr constant [10 x i8] c"fallocate\00", align 1
@.str.51 = private unnamed_addr constant [7 x i8] c"unlink\00", align 1
@.str.52 = private unnamed_addr constant [14 x i8] c"openDirectory\00", align 1
@.str.53 = private unnamed_addr constant [6 x i8] c"mkdir\00", align 1
@.str.54 = private unnamed_addr constant [6 x i8] c"rmdir\00", align 1
@.str.55 = private unnamed_addr constant [7 x i8] c"fchown\00", align 1
@.str.56 = private unnamed_addr constant [8 x i8] c"geteuid\00", align 1
@.str.57 = private unnamed_addr constant [5 x i8] c"mmap\00", align 1
@.str.58 = private unnamed_addr constant [7 x i8] c"munmap\00", align 1
@.str.59 = private unnamed_addr constant [7 x i8] c"mremap\00", align 1
@.str.60 = private unnamed_addr constant [12 x i8] c"getpagesize\00", align 1
@.str.61 = private unnamed_addr constant [9 x i8] c"readlink\00", align 1
@.str.62 = private unnamed_addr constant [6 x i8] c"lstat\00", align 1
@.str.63 = private unnamed_addr constant [6 x i8] c"ioctl\00", align 1
@aSyscall = external local_unnamed_addr global [29 x %struct.unix_syscall], align 16
@.str.64 = private unnamed_addr constant [43 x i8] c"attempt to open \22%s\22 as file descriptor %d\00", align 1
@.str.65 = private unnamed_addr constant [10 x i8] c"/dev/null\00", align 1
@unixBigLock = local_unnamed_addr global %struct.sqlite3_mutex* null, align 8
@inodeList = local_unnamed_addr global %struct.unixInodeInfo* null, align 8
@.str.66 = private unnamed_addr constant [31 x i8] c"os_unix.c:%d: (%d) %s(%s) - %s\00", align 1
@.str.67 = private unnamed_addr constant [2 x i8] c"S\00", align 1
@.str.68 = private unnamed_addr constant [24 x i8] c"cannot fstat db file %s\00", align 1
@.str.69 = private unnamed_addr constant [29 x i8] c"file unlinked while open: %s\00", align 1
@.str.70 = private unnamed_addr constant [27 x i8] c"multiple links to file: %s\00", align 1
@.str.71 = private unnamed_addr constant [28 x i8] c"file renamed while open: %s\00", align 1
@sqlite3PendingByte = internal unnamed_addr global i32 1073741824, align 4
@.str.72 = private unnamed_addr constant [3 x i8] c"%s\00", align 1
@.str.73 = private unnamed_addr constant [11 x i8] c"full_fsync\00", align 1
@.str.74 = private unnamed_addr constant [7 x i8] c"%s-shm\00", align 1
@.str.75 = private unnamed_addr constant [13 x i8] c"readonly_shm\00", align 1
@posixIoMethods = external constant %struct.sqlite3_io_methods, align 8
@posixIoFinder = external constant %struct.sqlite3_io_methods* (i8*, %struct.unixFile*)*, align 8
@nolockIoMethods = external constant %struct.sqlite3_io_methods, align 8
@nolockIoFinder = external constant %struct.sqlite3_io_methods* (i8*, %struct.unixFile*)*, align 8
@dotlockIoMethods = external constant %struct.sqlite3_io_methods, align 8
@dotlockIoFinder = external constant %struct.sqlite3_io_methods* (i8*, %struct.unixFile*)*, align 8
@flockIoMethods = external constant %struct.sqlite3_io_methods, align 8
@flockIoFinder = external constant %struct.sqlite3_io_methods* (i8*, %struct.unixFile*)*, align 8
@afpIoMethods = external constant %struct.sqlite3_io_methods, align 8
@afpIoFinder = external constant %struct.sqlite3_io_methods* (i8*, %struct.unixFile*)*, align 8
@proxyIoMethods = external constant %struct.sqlite3_io_methods, align 8
@proxyIoFinder = external constant %struct.sqlite3_io_methods* (i8*, %struct.unixFile*)*, align 8
@nfsIoMethods = external constant %struct.sqlite3_io_methods, align 8
@nfsIoFinder = external constant %struct.sqlite3_io_methods* (i8*, %struct.unixFile*)*, align 8
@autolockIoFinderImpl.aMap = internal unnamed_addr constant [6 x %struct.Mapping] [%struct.Mapping { i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.76, i32 0, i32 0), %struct.sqlite3_io_methods* @posixIoMethods }, %struct.Mapping { i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.77, i32 0, i32 0), %struct.sqlite3_io_methods* @posixIoMethods }, %struct.Mapping { i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.78, i32 0, i32 0), %struct.sqlite3_io_methods* @afpIoMethods }, %struct.Mapping { i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.79, i32 0, i32 0), %struct.sqlite3_io_methods* @afpIoMethods }, %struct.Mapping { i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.80, i32 0, i32 0), %struct.sqlite3_io_methods* @nolockIoMethods }, %struct.Mapping zeroinitializer], align 16
@.str.76 = private unnamed_addr constant [4 x i8] c"hfs\00", align 1
@.str.77 = private unnamed_addr constant [4 x i8] c"ufs\00", align 1
@.str.78 = private unnamed_addr constant [6 x i8] c"afpfs\00", align 1
@.str.79 = private unnamed_addr constant [6 x i8] c"smbfs\00", align 1
@.str.80 = private unnamed_addr constant [7 x i8] c"webdav\00", align 1
@autolockIoFinder = external constant %struct.sqlite3_io_methods* (i8*, %struct.unixFile*)*, align 8
@.str.82 = private unnamed_addr constant [5 x i8] c"psow\00", align 1
@.str.83 = private unnamed_addr constant [10 x i8] c"unix-excl\00", align 1
@.str.84 = private unnamed_addr constant [8 x i8] c"%s.lock\00", align 1
@unixTempFileDir.azDirs = internal unnamed_addr global [6 x i8*] [i8* null, i8* null, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.85, i32 0, i32 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.86, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.87, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.32, i32 0, i32 0)], align 16
@.str.85 = private unnamed_addr constant [9 x i8] c"/var/tmp\00", align 1
@.str.86 = private unnamed_addr constant [9 x i8] c"/usr/tmp\00", align 1
@.str.87 = private unnamed_addr constant [5 x i8] c"/tmp\00", align 1
@sqlite3_temp_directory = local_unnamed_addr global i8* null, align 8
@.str.88 = private unnamed_addr constant [14 x i8] c"SQLITE_TMPDIR\00", align 1
@.str.89 = private unnamed_addr constant [7 x i8] c"TMPDIR\00", align 1
@.str.90 = private unnamed_addr constant [17 x i8] c"%s/etilqs_%llx%c\00", align 1
@.str.91 = private unnamed_addr constant [7 x i8] c"modeof\00", align 1
@.str.92 = private unnamed_addr constant [6 x i8] c"msdos\00", align 1
@.str.93 = private unnamed_addr constant [6 x i8] c"exfat\00", align 1
@.str.94 = private unnamed_addr constant [27 x i8] c"SQLITE_FORCE_PROXY_LOCKING\00", align 1
@.str.95 = private unnamed_addr constant [7 x i8] c":auto:\00", align 1
@.str.96 = private unnamed_addr constant [6 x i8] c"fsync\00", align 1
@.str.97 = private unnamed_addr constant [13 x i8] c"/dev/urandom\00", align 1
@.str.98 = private unnamed_addr constant [13 x i8] c"sqliteplocks\00", align 1
@.str.99 = private unnamed_addr constant [2 x i8] c"/\00", align 1
@.str.100 = private unnamed_addr constant [6 x i8] c"dummy\00", align 1
@__const.proxyGetHostID.timeout = private unnamed_addr constant %struct.timespec { i64 1, i64 0 }, align 8
@.str.101 = private unnamed_addr constant [6 x i8] c"break\00", align 1
@.str.102 = private unnamed_addr constant [20 x i8] c"path error (len %d)\00", align 1
@.str.103 = private unnamed_addr constant [20 x i8] c"read error (len %d)\00", align 1
@.str.104 = private unnamed_addr constant [19 x i8] c"create failed (%d)\00", align 1
@.str.105 = private unnamed_addr constant [18 x i8] c"write failed (%d)\00", align 1
@.str.106 = private unnamed_addr constant [19 x i8] c"rename failed (%d)\00", align 1
@__stderrp = external local_unnamed_addr global %struct.__sFILE*, align 8
@.str.107 = private unnamed_addr constant [24 x i8] c"broke stale lock on %s\0A\00", align 1
@.str.108 = private unnamed_addr constant [38 x i8] c"failed to break stale lock on %s, %s\0A\00", align 1
@.str.109 = private unnamed_addr constant [7 x i8] c"-conch\00", align 1
@.str.110 = private unnamed_addr constant [18 x i8] c":auto: (not held)\00", align 1
@sqlite3_os_init.aVfs = external dso_local global [9 x %struct.sqlite3_vfs], align 16
@.str.111 = private unnamed_addr constant [5 x i8] c"unix\00", align 1
@.str.112 = private unnamed_addr constant [10 x i8] c"unix-none\00", align 1
@.str.113 = private unnamed_addr constant [13 x i8] c"unix-dotfile\00", align 1
@.str.114 = private unnamed_addr constant [11 x i8] c"unix-posix\00", align 1
@.str.115 = private unnamed_addr constant [11 x i8] c"unix-flock\00", align 1
@.str.116 = private unnamed_addr constant [9 x i8] c"unix-afp\00", align 1
@.str.117 = private unnamed_addr constant [9 x i8] c"unix-nfs\00", align 1
@.str.118 = private unnamed_addr constant [11 x i8] c"unix-proxy\00", align 1
@pcache1_g = global %struct.PCacheGlobal zeroinitializer, align 8
@aJournalMagic = constant [8 x i8] c"\D9\D5\05\F9 \A1c\D7", align 1
@zeroJournalHdr.zeroHdr = internal constant [28 x i8] zeroinitializer, align 16
@.str.119 = private unnamed_addr constant [27 x i8] c"recovered %d pages from %s\00", align 1
@syncJournal.zerobyte = internal constant i8 0, align 1
@.str.120 = private unnamed_addr constant [37 x i8] c"recovered %d frames from WAL file %s\00", align 1
@.str.121 = private unnamed_addr constant [26 x i8] c"cannot limit WAL size: %s\00", align 1
@zMagicHeader = constant [16 x i8] c"SQLite format 3\00", align 16
@sqlite3SharedCacheList = internal unnamed_addr global %struct.BtShared* null, align 8
@.str.122 = private unnamed_addr constant [4 x i8] c"@  \00", align 1
@.str.123 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.124 = private unnamed_addr constant [23 x i8] c"invalid page number %d\00", align 1
@.str.125 = private unnamed_addr constant [25 x i8] c"2nd reference to page %d\00", align 1
@.str.126 = private unnamed_addr constant [29 x i8] c"Failed to read ptrmap key=%d\00", align 1
@.str.127 = private unnamed_addr constant [54 x i8] c"Bad ptr map entry key=%d expected=(%d,%d) got=(%d,%d)\00", align 1
@.str.128 = private unnamed_addr constant [22 x i8] c"failed to get page %d\00", align 1
@.str.129 = private unnamed_addr constant [39 x i8] c"freelist leaf count too big on page %d\00", align 1
@.str.130 = private unnamed_addr constant [26 x i8] c"%s is %d but should be %d\00", align 1
@.str.131 = private unnamed_addr constant [5 x i8] c"size\00", align 1
@.str.132 = private unnamed_addr constant [21 x i8] c"overflow list length\00", align 1
@.str.133 = private unnamed_addr constant [10 x i8] c"Page %d: \00", align 1
@.str.134 = private unnamed_addr constant [38 x i8] c"unable to get the page. error code=%d\00", align 1
@.str.135 = private unnamed_addr constant [38 x i8] c"btreeInitPage() returns error code %d\00", align 1
@.str.136 = private unnamed_addr constant [22 x i8] c"free space corruption\00", align 1
@.str.137 = private unnamed_addr constant [26 x i8] c"On tree page %d cell %d: \00", align 1
@.str.138 = private unnamed_addr constant [28 x i8] c"On page %d at right child: \00", align 1
@.str.139 = private unnamed_addr constant [30 x i8] c"Offset %d out of range %d..%d\00", align 1
@.str.140 = private unnamed_addr constant [24 x i8] c"Extends off end of page\00", align 1
@.str.141 = private unnamed_addr constant [24 x i8] c"Rowid %lld out of order\00", align 1
@.str.142 = private unnamed_addr constant [25 x i8] c"Child page depth differs\00", align 1
@.str.143 = private unnamed_addr constant [37 x i8] c"Multiple uses for byte %u of page %d\00", align 1
@.str.144 = private unnamed_addr constant [52 x i8] c"Fragmentation of %d bytes reported as %d on page %d\00", align 1
@.str.145 = private unnamed_addr constant [20 x i8] c"unknown database %s\00", align 1
@.str.146 = private unnamed_addr constant [31 x i8] c"destination database is in use\00", align 1
@.str.147 = private unnamed_addr constant [40 x i8] c"source and destination must be distinct\00", align 1
@.str.148 = private unnamed_addr constant [7 x i8] c"%!.15g\00", align 1
@.str.149 = private unnamed_addr constant [2 x i8] c"-\00", align 1
@.str.150 = private unnamed_addr constant [5 x i8] c"%s%s\00", align 1
@.str.151 = private unnamed_addr constant [5 x i8] c"k(%d\00", align 1
@.str.152 = private constant [7 x i8] c"BINARY\00", align 1
@.str.153 = private unnamed_addr constant [2 x i8] c"B\00", align 1
@.str.154 = private unnamed_addr constant [8 x i8] c",%s%s%s\00", align 1
@.str.155 = private unnamed_addr constant [3 x i8] c"N.\00", align 1
@.str.156 = private unnamed_addr constant [2 x i8] c")\00", align 1
@displayP4.encnames = internal unnamed_addr constant [4 x i8*] [i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.157, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.158, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.159, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.160, i32 0, i32 0)], align 16
@.str.157 = private unnamed_addr constant [2 x i8] c"?\00", align 1
@.str.158 = private unnamed_addr constant [2 x i8] c"8\00", align 1
@.str.159 = private unnamed_addr constant [5 x i8] c"16LE\00", align 1
@.str.160 = private unnamed_addr constant [5 x i8] c"16BE\00", align 1
@.str.161 = private unnamed_addr constant [9 x i8] c"%.18s-%s\00", align 1
@.str.162 = private unnamed_addr constant [7 x i8] c"%s(%d)\00", align 1
@.str.163 = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@.str.164 = private unnamed_addr constant [7 x i8] c"(blob)\00", align 1
@.str.165 = private unnamed_addr constant [4 x i8] c",%d\00", align 1
@.str.166 = private unnamed_addr constant [2 x i8] c"]\00", align 1
@.str.167 = private unnamed_addr constant [8 x i8] c"program\00", align 1
@.str.168 = private unnamed_addr constant [20 x i8] c"%s-mjXXXXXX9XXz%c%c\00", align 1
@.str.169 = private unnamed_addr constant [14 x i8] c"MJ delete: %s\00", align 1
@.str.170 = private unnamed_addr constant [15 x i8] c"MJ collide: %s\00", align 1
@.str.171 = private unnamed_addr constant [13 x i8] c"-mj%06X9%02X\00", align 1
@sqlite3SmallTypeSizes = local_unnamed_addr constant [128 x i8] c"\00\01\02\03\04\06\08\08\00\00\00\00\00\00\01\01\02\02\03\03\04\04\05\05\06\06\07\07\08\08\09\09\0A\0A\0B\0B\0C\0C\0D\0D\0E\0E\0F\0F\10\10\11\11\12\12\13\13\14\14\15\15\16\16\17\17\18\18\19\19\1A\1A\1B\1B\1C\1C\1D\1D\1E\1E\1F\1F  !!\22\22##$$%%&&''(())**++,,--..//00112233445566778899", align 16
@.str.172 = private unnamed_addr constant [45 x i8] c"API called with finalized prepared statement\00", align 1
@.str.173 = private unnamed_addr constant [40 x i8] c"API called with NULL prepared statement\00", align 1
@sqlite3_value_type.aType = internal unnamed_addr constant [64 x i8] c"\04\05\03\05\01\05\01\05\02\05\02\05\01\05\01\05\04\05\03\05\01\05\01\05\02\05\02\05\01\05\01\05\02\05\03\05\02\05\02\05\02\05\02\05\02\05\02\05\04\05\03\05\02\05\02\05\02\05\02\05\02\05\02\05", align 16
@.str.174 = private unnamed_addr constant [23 x i8] c"string or blob too big\00", align 1
@columnNullValue.nullMem = internal constant %struct.sqlite3_value { %union.MemValue zeroinitializer, i16 1, i8 0, i8 0, i32 0, i8* null, i8* null, i32 0, i32 0, %struct.sqlite3* null, void (i8*)* null }, align 8
@.str.175 = private unnamed_addr constant [40 x i8] c"bind on a busy prepared statement: [%s]\00", align 1
@enableJit = local_unnamed_addr global i8 -1, align 1
@Argv = local_unnamed_addr global i8** null, align 8
@Argc = local_unnamed_addr global i32 -1, align 4
@maxVdbeSteps = local_unnamed_addr global i64 -1, align 8
@pcHasBeenSet = local_unnamed_addr global i8 0, align 1
@iCompare = local_unnamed_addr global i32 0, align 4
@.str.176 = private unnamed_addr constant [29 x i8] c"cannot open value of type %s\00", align 1
@.str.177 = private unnamed_addr constant [5 x i8] c"null\00", align 1
@.str.178 = private unnamed_addr constant [5 x i8] c"real\00", align 1
@.str.179 = private unnamed_addr constant [8 x i8] c"integer\00", align 1
@.str.180 = private unnamed_addr constant [20 x i8] c"no such rowid: %lld\00", align 1
@.str.182 = private unnamed_addr constant [36 x i8] c"cannot open table without rowid: %s\00", align 1
@.str.183 = private unnamed_addr constant [21 x i8] c"cannot open view: %s\00", align 1
@.str.184 = private unnamed_addr constant [21 x i8] c"no such column: \22%s\22\00", align 1
@.str.185 = private unnamed_addr constant [12 x i8] c"foreign key\00", align 1
@.str.186 = private unnamed_addr constant [8 x i8] c"indexed\00", align 1
@.str.187 = private unnamed_addr constant [34 x i8] c"cannot open %s column for writing\00", align 1
@vdbeSorterCompareInt.aLen = internal unnamed_addr constant [10 x i8] c"\00\01\02\03\04\06\08\00\00\00", align 1
@MemJournalMethods = external constant %struct.sqlite3_io_methods, align 8
@.str.188 = private unnamed_addr constant [4 x i8] c"new\00", align 1
@.str.189 = private unnamed_addr constant [4 x i8] c"old\00", align 1
@.str.190 = private unnamed_addr constant [9 x i8] c"excluded\00", align 1
@.str.191 = private unnamed_addr constant [31 x i8] c"misuse of aliased aggregate %s\00", align 1
@.str.192 = private unnamed_addr constant [37 x i8] c"misuse of aliased window function %s\00", align 1
@.str.193 = private unnamed_addr constant [18 x i8] c"row value misused\00", align 1
@.str.194 = private unnamed_addr constant [35 x i8] c"double-quoted string literal: \22%w\22\00", align 1
@.str.195 = private unnamed_addr constant [15 x i8] c"no such column\00", align 1
@.str.196 = private unnamed_addr constant [22 x i8] c"ambiguous column name\00", align 1
@.str.197 = private unnamed_addr constant [13 x i8] c"%s: %s.%s.%s\00", align 1
@.str.198 = private unnamed_addr constant [10 x i8] c"%s: %s.%s\00", align 1
@.str.199 = private unnamed_addr constant [7 x i8] c"%s: %s\00", align 1
@.str.200 = private unnamed_addr constant [28 x i8] c"partial index WHERE clauses\00", align 1
@.str.201 = private unnamed_addr constant [18 x i8] c"index expressions\00", align 1
@.str.202 = private unnamed_addr constant [18 x i8] c"CHECK constraints\00", align 1
@.str.203 = private unnamed_addr constant [18 x i8] c"generated columns\00", align 1
@.str.204 = private unnamed_addr constant [20 x i8] c"%s prohibited in %s\00", align 1
@.str.205 = private unnamed_addr constant [17 x i8] c"the \22.\22 operator\00", align 1
@.str.206 = private unnamed_addr constant [71 x i8] c"second argument to likelihood() must be a constant between 0.0 and 1.0\00", align 1
@.str.207 = private unnamed_addr constant [35 x i8] c"not authorized to use function: %s\00", align 1
@.str.208 = private unnamed_addr constant [28 x i8] c"non-deterministic functions\00", align 1
@.str.209 = private unnamed_addr constant [44 x i8] c"%.*s() may not be used as a window function\00", align 1
@.str.210 = private unnamed_addr constant [7 x i8] c"window\00", align 1
@.str.211 = private unnamed_addr constant [10 x i8] c"aggregate\00", align 1
@.str.212 = private unnamed_addr constant [29 x i8] c"misuse of %s function %.*s()\00", align 1
@.str.213 = private unnamed_addr constant [23 x i8] c"no such function: %.*s\00", align 1
@.str.214 = private unnamed_addr constant [45 x i8] c"wrong number of arguments to function %.*s()\00", align 1
@.str.215 = private unnamed_addr constant [49 x i8] c"FILTER may not be used with non-aggregate %.*s()\00", align 1
@.str.216 = private unnamed_addr constant [11 x i8] c"subqueries\00", align 1
@.str.217 = private unnamed_addr constant [11 x i8] c"parameters\00", align 1
@.str.218 = private unnamed_addr constant [56 x i8] c"%r %s BY term out of range - should be between 1 and %d\00", align 1
@.str.219 = private unnamed_addr constant [34 x i8] c"too many terms in ORDER BY clause\00", align 1
@.str.220 = private unnamed_addr constant [6 x i8] c"ORDER\00", align 1
@.str.221 = private unnamed_addr constant [61 x i8] c"%r ORDER BY term does not match any column in the result set\00", align 1
@.str.222 = private unnamed_addr constant [44 x i8] c"a GROUP BY clause is required before HAVING\00", align 1
@.str.223 = private unnamed_addr constant [6 x i8] c"GROUP\00", align 1
@.str.224 = private unnamed_addr constant [59 x i8] c"aggregate functions are not allowed in the GROUP BY clause\00", align 1
@.str.225 = private unnamed_addr constant [3 x i8] c"0x\00", align 1
@.str.226 = private unnamed_addr constant [26 x i8] c"hex literal too big: %s%s\00", align 1
@.str.227 = private unnamed_addr constant [8 x i8] c"sqlite_\00", align 1
@.str.228 = private unnamed_addr constant [28 x i8] c"table %s may not be altered\00", align 1
@.str.229 = private unnamed_addr constant [156 x i8] c"SELECT 1 FROM \22%w\22.%s WHERE name NOT LIKE 'sqliteX_%%' ESCAPE 'X' AND sql NOT LIKE 'create virtual%%' AND sqlite_rename_test(%Q, sql, type, name, %d)=NULL \00", align 1
@.str.230 = private unnamed_addr constant [14 x i8] c"sqlite_master\00", align 1
@.str.231 = private unnamed_addr constant [155 x i8] c"SELECT 1 FROM temp.%s WHERE name NOT LIKE 'sqliteX_%%' ESCAPE 'X' AND sql NOT LIKE 'create virtual%%' AND sqlite_rename_test(%Q, sql, type, name, 1)=NULL \00", align 1
@.str.232 = private unnamed_addr constant [5 x i8] c"view\00", align 1
@.str.233 = private unnamed_addr constant [33 x i8] c"cannot rename columns of %s \22%s\22\00", align 1
@.str.234 = private unnamed_addr constant [21 x i8] c"error in %s %s%s: %s\00", align 1
@.str.235 = private unnamed_addr constant [14 x i8] c" after rename\00", align 1
@.str.236 = private unnamed_addr constant [5 x i8] c"\22%w\22\00", align 1
@.str.237 = private unnamed_addr constant [13 x i8] c"sqlite_stat1\00", align 1
@.str.238 = private unnamed_addr constant [13 x i8] c"tbl,idx,stat\00", align 1
@.str.239 = private unnamed_addr constant [13 x i8] c"sqlite_stat4\00", align 1
@.str.240 = private unnamed_addr constant [13 x i8] c"sqlite_stat3\00", align 1
@.str.241 = private unnamed_addr constant [23 x i8] c"CREATE TABLE %Q.%s(%s)\00", align 1
@.str.242 = private unnamed_addr constant [30 x i8] c"DELETE FROM %Q.%s WHERE %s=%Q\00", align 1
@.str.243 = private unnamed_addr constant [10 x i8] c"stat_init\00", align 1
@statInitFuncdef = external constant %struct.FuncDef, align 8
@.str.244 = private unnamed_addr constant [10 x i8] c"stat_push\00", align 1
@statPushFuncdef = external constant %struct.FuncDef, align 8
@.str.245 = private unnamed_addr constant [5 x i8] c"%llu\00", align 1
@.str.246 = private unnamed_addr constant [6 x i8] c" %llu\00", align 1
@.str.247 = private unnamed_addr constant [9 x i8] c"stat_get\00", align 1
@statGetFuncdef = external constant %struct.FuncDef, align 8
@.str.248 = private unnamed_addr constant [10 x i8] c"sqlite\\_%\00", align 1
@.str.249 = private unnamed_addr constant [4 x i8] c"BBB\00", align 1
@.str.250 = private unnamed_addr constant [4 x i8] c"idx\00", align 1
@.str.251 = private unnamed_addr constant [4 x i8] c"tbl\00", align 1
@.str.252 = private unnamed_addr constant [11 x i8] c"unordered*\00", align 1
@.str.253 = private unnamed_addr constant [10 x i8] c"sz=[0-9]*\00", align 1
@.str.254 = private unnamed_addr constant [12 x i8] c"noskipscan*\00", align 1
@.str.255 = private unnamed_addr constant [37 x i8] c"too many attached databases - max %d\00", align 1
@.str.256 = private unnamed_addr constant [30 x i8] c"database %s is already in use\00", align 1
@.str.257 = private unnamed_addr constant [29 x i8] c"database is already attached\00", align 1
@.str.258 = private unnamed_addr constant [68 x i8] c"attached databases must use the same text encoding as main database\00", align 1
@.str.259 = private unnamed_addr constant [14 x i8] c"out of memory\00", align 1
@.str.260 = private unnamed_addr constant [28 x i8] c"unable to open database: %s\00", align 1
@.str.261 = private unnamed_addr constant [21 x i8] c"no such database: %s\00", align 1
@.str.262 = private unnamed_addr constant [26 x i8] c"cannot detach database %s\00", align 1
@.str.263 = private unnamed_addr constant [22 x i8] c"database %s is locked\00", align 1
@.str.264 = private unnamed_addr constant [23 x i8] c"authorizer malfunction\00", align 1
@.str.265 = private unnamed_addr constant [52 x i8] c"generated columns cannot be part of the PRIMARY KEY\00", align 1
@.str.266 = private unnamed_addr constant [2 x i8] c",\00", align 1
@.str.267 = private unnamed_addr constant [4 x i8] c"\0A  \00", align 1
@.str.268 = private unnamed_addr constant [5 x i8] c",\0A  \00", align 1
@.str.269 = private unnamed_addr constant [3 x i8] c"\0A)\00", align 1
@.str.270 = private unnamed_addr constant [14 x i8] c"CREATE TABLE \00", align 1
@createTableStmt.azType = internal unnamed_addr constant [5 x i8*] [i8* getelementptr inbounds ([1 x i8], [1 x i8]* @.str.29, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.271, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.272, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.273, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.274, i32 0, i32 0)], align 16
@.str.271 = private unnamed_addr constant [6 x i8] c" TEXT\00", align 1
@.str.272 = private unnamed_addr constant [5 x i8] c" NUM\00", align 1
@.str.273 = private unnamed_addr constant [5 x i8] c" INT\00", align 1
@.str.274 = private unnamed_addr constant [6 x i8] c" REAL\00", align 1
@.str.275 = private unnamed_addr constant [15 x i8] c"corrupt schema\00", align 1
@.str.276 = private unnamed_addr constant [56 x i8] c"UPDATE %Q.%s SET rootpage=%d WHERE #%d AND rootpage=#%d\00", align 1
@typeofFunc.azType = internal unnamed_addr constant [5 x i8*] [i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.179, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.178, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.277, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.278, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.177, i32 0, i32 0)], align 16
@.str.277 = private unnamed_addr constant [5 x i8] c"text\00", align 1
@.str.278 = private unnamed_addr constant [5 x i8] c"blob\00", align 1
@.str.279 = private unnamed_addr constant [17 x i8] c"integer overflow\00", align 1
@.str.280 = private unnamed_addr constant [5 x i8] c"%.*f\00", align 1
@globInfo = constant %struct.compareInfo { i8 42, i8 63, i8 91, i8 0 }, align 1
@likeInfoNorm = constant %struct.compareInfo { i8 37, i8 95, i8 0, i8 1 }, align 1
@likeInfoAlt = constant %struct.compareInfo { i8 37, i8 95, i8 0, i8 0 }, align 1
@.str.281 = private unnamed_addr constant [33 x i8] c"LIKE or GLOB pattern too complex\00", align 1
@.str.282 = private unnamed_addr constant [45 x i8] c"ESCAPE expression must be a single character\00", align 1
@hexdigits = local_unnamed_addr constant [16 x i8] c"0123456789ABCDEF", align 16
@.str.283 = private unnamed_addr constant [7 x i8] c"%!.20e\00", align 1
@trimFunc.lenOne = internal unnamed_addr constant [1 x i8] c"\01", align 1
@trimFunc.azOne = internal constant [1 x i8*] [i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.284, i32 0, i32 0)], align 8
@.str.284 = private unnamed_addr constant [2 x i8] c" \00", align 1
@.str.285 = private unnamed_addr constant [15 x i8] c"not authorized\00", align 1
@.str.286 = private unnamed_addr constant [30 x i8] c"FOREIGN KEY constraint failed\00", align 1
@sqlite3Autoext = local_unnamed_addr global %struct.sqlite3AutoExtList zeroinitializer, align 8
@.str.287 = private unnamed_addr constant [3 x i8] c"id\00", align 1
@.str.288 = private unnamed_addr constant [4 x i8] c"seq\00", align 1
@.str.289 = private unnamed_addr constant [6 x i8] c"table\00", align 1
@.str.290 = private unnamed_addr constant [5 x i8] c"from\00", align 1
@.str.291 = private unnamed_addr constant [3 x i8] c"to\00", align 1
@.str.292 = private unnamed_addr constant [10 x i8] c"on_update\00", align 1
@.str.293 = private unnamed_addr constant [10 x i8] c"on_delete\00", align 1
@.str.294 = private unnamed_addr constant [6 x i8] c"match\00", align 1
@.str.295 = private unnamed_addr constant [4 x i8] c"cid\00", align 1
@.str.296 = private unnamed_addr constant [5 x i8] c"name\00", align 1
@.str.297 = private unnamed_addr constant [5 x i8] c"type\00", align 1
@.str.298 = private unnamed_addr constant [8 x i8] c"notnull\00", align 1
@.str.299 = private unnamed_addr constant [11 x i8] c"dflt_value\00", align 1
@.str.300 = private unnamed_addr constant [3 x i8] c"pk\00", align 1
@.str.301 = private unnamed_addr constant [7 x i8] c"hidden\00", align 1
@.str.302 = private unnamed_addr constant [6 x i8] c"seqno\00", align 1
@.str.303 = private unnamed_addr constant [5 x i8] c"desc\00", align 1
@.str.304 = private unnamed_addr constant [5 x i8] c"coll\00", align 1
@.str.305 = private unnamed_addr constant [4 x i8] c"key\00", align 1
@.str.306 = private unnamed_addr constant [8 x i8] c"builtin\00", align 1
@.str.307 = private unnamed_addr constant [4 x i8] c"enc\00", align 1
@.str.308 = private unnamed_addr constant [5 x i8] c"narg\00", align 1
@.str.309 = private unnamed_addr constant [6 x i8] c"flags\00", align 1
@.str.310 = private unnamed_addr constant [5 x i8] c"wdth\00", align 1
@.str.311 = private unnamed_addr constant [5 x i8] c"hght\00", align 1
@.str.312 = private unnamed_addr constant [5 x i8] c"flgs\00", align 1
@.str.313 = private unnamed_addr constant [7 x i8] c"unique\00", align 1
@.str.314 = private unnamed_addr constant [7 x i8] c"origin\00", align 1
@.str.315 = private unnamed_addr constant [8 x i8] c"partial\00", align 1
@.str.316 = private unnamed_addr constant [6 x i8] c"rowid\00", align 1
@.str.317 = private unnamed_addr constant [7 x i8] c"parent\00", align 1
@.str.318 = private unnamed_addr constant [5 x i8] c"fkid\00", align 1
@.str.319 = private unnamed_addr constant [5 x i8] c"file\00", align 1
@.str.320 = private unnamed_addr constant [5 x i8] c"busy\00", align 1
@.str.321 = private unnamed_addr constant [4 x i8] c"log\00", align 1
@.str.322 = private unnamed_addr constant [13 x i8] c"checkpointed\00", align 1
@.str.323 = private unnamed_addr constant [9 x i8] c"database\00", align 1
@.str.324 = private unnamed_addr constant [7 x i8] c"status\00", align 1
@.str.325 = private unnamed_addr constant [11 x i8] c"cache_size\00", align 1
@.str.326 = private unnamed_addr constant [8 x i8] c"timeout\00", align 1
@pragCName = local_unnamed_addr constant [51 x i8*] [i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.287, i32 0, i32 0), i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.288, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.289, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.290, i32 0, i32 0), i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.291, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.292, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.293, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.294, i32 0, i32 0), i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.295, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.296, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.297, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.298, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.299, i32 0, i32 0), i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.300, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.301, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.302, i32 0, i32 0), i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.295, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.296, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.303, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.304, i32 0, i32 0), i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.305, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.296, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.306, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.297, i32 0, i32 0), i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.307, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.308, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.309, i32 0, i32 0), i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.251, i32 0, i32 0), i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.250, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.310, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.311, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.312, i32 0, i32 0), i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.288, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.296, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.313, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.314, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.315, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.289, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.316, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.317, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.318, i32 0, i32 0), i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.288, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.296, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.319, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.320, i32 0, i32 0), i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.321, i32 0, i32 0), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.322, i32 0, i32 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.323, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.324, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.325, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.326, i32 0, i32 0)], align 16
@.str.327 = private unnamed_addr constant [15 x i8] c"application_id\00", align 1
@.str.328 = private unnamed_addr constant [12 x i8] c"auto_vacuum\00", align 1
@.str.329 = private unnamed_addr constant [16 x i8] c"automatic_index\00", align 1
@.str.330 = private unnamed_addr constant [13 x i8] c"busy_timeout\00", align 1
@.str.331 = private unnamed_addr constant [12 x i8] c"cache_spill\00", align 1
@.str.332 = private unnamed_addr constant [20 x i8] c"case_sensitive_like\00", align 1
@.str.333 = private unnamed_addr constant [16 x i8] c"cell_size_check\00", align 1
@.str.334 = private unnamed_addr constant [21 x i8] c"checkpoint_fullfsync\00", align 1
@.str.335 = private unnamed_addr constant [15 x i8] c"collation_list\00", align 1
@.str.336 = private unnamed_addr constant [16 x i8] c"compile_options\00", align 1
@.str.337 = private unnamed_addr constant [14 x i8] c"count_changes\00", align 1
@.str.338 = private unnamed_addr constant [13 x i8] c"data_version\00", align 1
@.str.339 = private unnamed_addr constant [14 x i8] c"database_list\00", align 1
@.str.340 = private unnamed_addr constant [19 x i8] c"default_cache_size\00", align 1
@.str.341 = private unnamed_addr constant [19 x i8] c"defer_foreign_keys\00", align 1
@.str.342 = private unnamed_addr constant [23 x i8] c"empty_result_callbacks\00", align 1
@.str.343 = private unnamed_addr constant [9 x i8] c"encoding\00", align 1
@.str.344 = private unnamed_addr constant [18 x i8] c"foreign_key_check\00", align 1
@.str.345 = private unnamed_addr constant [17 x i8] c"foreign_key_list\00", align 1
@.str.346 = private unnamed_addr constant [13 x i8] c"foreign_keys\00", align 1
@.str.347 = private unnamed_addr constant [15 x i8] c"freelist_count\00", align 1
@.str.348 = private unnamed_addr constant [18 x i8] c"full_column_names\00", align 1
@.str.349 = private unnamed_addr constant [10 x i8] c"fullfsync\00", align 1
@.str.350 = private unnamed_addr constant [14 x i8] c"function_list\00", align 1
@.str.351 = private unnamed_addr constant [16 x i8] c"hard_heap_limit\00", align 1
@.str.352 = private unnamed_addr constant [25 x i8] c"ignore_check_constraints\00", align 1
@.str.353 = private unnamed_addr constant [19 x i8] c"incremental_vacuum\00", align 1
@.str.354 = private unnamed_addr constant [11 x i8] c"index_info\00", align 1
@.str.355 = private unnamed_addr constant [11 x i8] c"index_list\00", align 1
@.str.356 = private unnamed_addr constant [12 x i8] c"index_xinfo\00", align 1
@.str.357 = private unnamed_addr constant [16 x i8] c"integrity_check\00", align 1
@.str.358 = private unnamed_addr constant [13 x i8] c"journal_mode\00", align 1
@.str.359 = private unnamed_addr constant [19 x i8] c"journal_size_limit\00", align 1
@.str.360 = private unnamed_addr constant [19 x i8] c"legacy_alter_table\00", align 1
@.str.361 = private unnamed_addr constant [16 x i8] c"lock_proxy_file\00", align 1
@.str.362 = private unnamed_addr constant [13 x i8] c"locking_mode\00", align 1
@.str.363 = private unnamed_addr constant [15 x i8] c"max_page_count\00", align 1
@.str.364 = private unnamed_addr constant [10 x i8] c"mmap_size\00", align 1
@.str.365 = private unnamed_addr constant [9 x i8] c"optimize\00", align 1
@.str.366 = private unnamed_addr constant [11 x i8] c"page_count\00", align 1
@.str.367 = private unnamed_addr constant [10 x i8] c"page_size\00", align 1
@.str.368 = private unnamed_addr constant [12 x i8] c"pragma_list\00", align 1
@.str.369 = private unnamed_addr constant [11 x i8] c"query_only\00", align 1
@.str.370 = private unnamed_addr constant [12 x i8] c"quick_check\00", align 1
@.str.371 = private unnamed_addr constant [17 x i8] c"read_uncommitted\00", align 1
@.str.372 = private unnamed_addr constant [19 x i8] c"recursive_triggers\00", align 1
@.str.373 = private unnamed_addr constant [26 x i8] c"reverse_unordered_selects\00", align 1
@.str.374 = private unnamed_addr constant [15 x i8] c"schema_version\00", align 1
@.str.375 = private unnamed_addr constant [14 x i8] c"secure_delete\00", align 1
@.str.376 = private unnamed_addr constant [19 x i8] c"short_column_names\00", align 1
@.str.377 = private unnamed_addr constant [14 x i8] c"shrink_memory\00", align 1
@.str.378 = private unnamed_addr constant [16 x i8] c"soft_heap_limit\00", align 1
@.str.379 = private unnamed_addr constant [12 x i8] c"synchronous\00", align 1
@.str.380 = private unnamed_addr constant [11 x i8] c"table_info\00", align 1
@.str.381 = private unnamed_addr constant [12 x i8] c"table_xinfo\00", align 1
@.str.382 = private unnamed_addr constant [11 x i8] c"temp_store\00", align 1
@.str.383 = private unnamed_addr constant [21 x i8] c"temp_store_directory\00", align 1
@.str.384 = private unnamed_addr constant [8 x i8] c"threads\00", align 1
@.str.385 = private unnamed_addr constant [15 x i8] c"trusted_schema\00", align 1
@.str.386 = private unnamed_addr constant [13 x i8] c"user_version\00", align 1
@.str.387 = private unnamed_addr constant [19 x i8] c"wal_autocheckpoint\00", align 1
@.str.388 = private unnamed_addr constant [15 x i8] c"wal_checkpoint\00", align 1
@.str.389 = private unnamed_addr constant [16 x i8] c"writable_schema\00", align 1
@aPragmaName = constant [64 x %struct.PragmaName] [%struct.PragmaName { i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.str.327, i32 0, i32 0), i8 1, i8 20, i8 0, i8 0, i64 8 }, %struct.PragmaName { i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.328, i32 0, i32 0), i8 2, i8 -107, i8 0, i8 0, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.329, i32 0, i32 0), i8 3, i8 20, i8 0, i8 0, i64 32768 }, %struct.PragmaName { i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.330, i32 0, i32 0), i8 4, i8 16, i8 50, i8 1, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.325, i32 0, i32 0), i8 5, i8 -107, i8 0, i8 0, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.331, i32 0, i32 0), i8 6, i8 -108, i8 0, i8 0, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([20 x i8], [20 x i8]* @.str.332, i32 0, i32 0), i8 7, i8 2, i8 0, i8 0, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.333, i32 0, i32 0), i8 3, i8 20, i8 0, i8 0, i64 2097152 }, %struct.PragmaName { i8* getelementptr inbounds ([21 x i8], [21 x i8]* @.str.334, i32 0, i32 0), i8 3, i8 20, i8 0, i8 0, i64 16 }, %struct.PragmaName { i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.str.335, i32 0, i32 0), i8 8, i8 16, i8 32, i8 2, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.336, i32 0, i32 0), i8 9, i8 16, i8 0, i8 0, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.337, i32 0, i32 0), i8 3, i8 20, i8 0, i8 0, i64 4294967296 }, %struct.PragmaName { i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.338, i32 0, i32 0), i8 1, i8 24, i8 0, i8 0, i64 15 }, %struct.PragmaName { i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.339, i32 0, i32 0), i8 11, i8 17, i8 41, i8 3, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.340, i32 0, i32 0), i8 12, i8 -107, i8 49, i8 1, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.341, i32 0, i32 0), i8 3, i8 20, i8 0, i8 0, i64 524288 }, %struct.PragmaName { i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.342, i32 0, i32 0), i8 3, i8 20, i8 0, i8 0, i64 256 }, %struct.PragmaName { i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.343, i32 0, i32 0), i8 13, i8 20, i8 0, i8 0, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.344, i32 0, i32 0), i8 14, i8 17, i8 37, i8 4, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.345, i32 0, i32 0), i8 15, i8 97, i8 0, i8 8, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.346, i32 0, i32 0), i8 3, i8 20, i8 0, i8 0, i64 16384 }, %struct.PragmaName { i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.str.347, i32 0, i32 0), i8 1, i8 24, i8 0, i8 0, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.348, i32 0, i32 0), i8 3, i8 20, i8 0, i8 0, i64 4 }, %struct.PragmaName { i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.349, i32 0, i32 0), i8 3, i8 20, i8 0, i8 0, i64 8 }, %struct.PragmaName { i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.350, i32 0, i32 0), i8 16, i8 16, i8 21, i8 6, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.351, i32 0, i32 0), i8 17, i8 16, i8 0, i8 0, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([25 x i8], [25 x i8]* @.str.352, i32 0, i32 0), i8 3, i8 20, i8 0, i8 0, i64 512 }, %struct.PragmaName { i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.353, i32 0, i32 0), i8 18, i8 3, i8 0, i8 0, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.354, i32 0, i32 0), i8 19, i8 97, i8 15, i8 3, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.355, i32 0, i32 0), i8 20, i8 97, i8 32, i8 5, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.356, i32 0, i32 0), i8 19, i8 97, i8 15, i8 6, i64 1 }, %struct.PragmaName { i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.357, i32 0, i32 0), i8 21, i8 49, i8 0, i8 0, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.358, i32 0, i32 0), i8 22, i8 -111, i8 0, i8 0, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.359, i32 0, i32 0), i8 23, i8 -112, i8 0, i8 0, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.360, i32 0, i32 0), i8 3, i8 20, i8 0, i8 0, i64 67108864 }, %struct.PragmaName { i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.361, i32 0, i32 0), i8 24, i8 4, i8 0, i8 0, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.362, i32 0, i32 0), i8 25, i8 -112, i8 0, i8 0, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.str.363, i32 0, i32 0), i8 26, i8 -111, i8 0, i8 0, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.364, i32 0, i32 0), i8 27, i8 0, i8 0, i8 0, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.365, i32 0, i32 0), i8 29, i8 33, i8 0, i8 0, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.366, i32 0, i32 0), i8 26, i8 -111, i8 0, i8 0, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.367, i32 0, i32 0), i8 30, i8 -108, i8 0, i8 0, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.368, i32 0, i32 0), i8 31, i8 16, i8 9, i8 1, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.369, i32 0, i32 0), i8 3, i8 20, i8 0, i8 0, i64 1048576 }, %struct.PragmaName { i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.370, i32 0, i32 0), i8 21, i8 49, i8 0, i8 0, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.371, i32 0, i32 0), i8 3, i8 20, i8 0, i8 0, i64 1024 }, %struct.PragmaName { i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.372, i32 0, i32 0), i8 3, i8 20, i8 0, i8 0, i64 8192 }, %struct.PragmaName { i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.373, i32 0, i32 0), i8 3, i8 20, i8 0, i8 0, i64 4096 }, %struct.PragmaName { i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.str.374, i32 0, i32 0), i8 1, i8 20, i8 0, i8 0, i64 1 }, %struct.PragmaName { i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.375, i32 0, i32 0), i8 32, i8 16, i8 0, i8 0, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.376, i32 0, i32 0), i8 3, i8 20, i8 0, i8 0, i64 64 }, %struct.PragmaName { i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.377, i32 0, i32 0), i8 33, i8 2, i8 0, i8 0, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.378, i32 0, i32 0), i8 34, i8 16, i8 0, i8 0, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.379, i32 0, i32 0), i8 35, i8 -107, i8 0, i8 0, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.380, i32 0, i32 0), i8 36, i8 97, i8 8, i8 6, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.381, i32 0, i32 0), i8 36, i8 97, i8 8, i8 7, i64 1 }, %struct.PragmaName { i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.382, i32 0, i32 0), i8 37, i8 20, i8 0, i8 0, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([21 x i8], [21 x i8]* @.str.383, i32 0, i32 0), i8 38, i8 4, i8 0, i8 0, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.384, i32 0, i32 0), i8 39, i8 16, i8 0, i8 0, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.str.385, i32 0, i32 0), i8 3, i8 20, i8 0, i8 0, i64 128 }, %struct.PragmaName { i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.386, i32 0, i32 0), i8 1, i8 20, i8 0, i8 0, i64 6 }, %struct.PragmaName { i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.387, i32 0, i32 0), i8 40, i8 0, i8 0, i8 0, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.str.388, i32 0, i32 0), i8 41, i8 1, i8 44, i8 3, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.389, i32 0, i32 0), i8 3, i8 20, i8 0, i8 0, i64 134217729 }], align 16
@getSafetyLevel.zText = internal unnamed_addr constant [25 x i8] c"onoffalseyestruextrafull\00", align 16
@getSafetyLevel.iValue = internal unnamed_addr constant [8 x i8] c"\01\00\00\00\01\01\03\02", align 1
@.str.390 = private unnamed_addr constant [10 x i8] c"exclusive\00", align 1
@.str.391 = private unnamed_addr constant [7 x i8] c"normal\00", align 1
@.str.392 = private unnamed_addr constant [5 x i8] c"none\00", align 1
@.str.393 = private unnamed_addr constant [5 x i8] c"full\00", align 1
@.str.394 = private unnamed_addr constant [12 x i8] c"incremental\00", align 1
@.str.395 = private unnamed_addr constant [7 x i8] c"memory\00", align 1
@.str.396 = private unnamed_addr constant [62 x i8] c"temporary storage cannot be changed from within a transaction\00", align 1
@.str.397 = private unnamed_addr constant [9 x i8] c"SET NULL\00", align 1
@.str.398 = private unnamed_addr constant [12 x i8] c"SET DEFAULT\00", align 1
@.str.399 = private unnamed_addr constant [8 x i8] c"CASCADE\00", align 1
@.str.400 = private unnamed_addr constant [9 x i8] c"RESTRICT\00", align 1
@.str.401 = private unnamed_addr constant [10 x i8] c"NO ACTION\00", align 1
@pragmaFunclistLine.azEnc = internal unnamed_addr constant [4 x i8*] [i8* null, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.402, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.403, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.404, i32 0, i32 0)], align 16
@.str.402 = private unnamed_addr constant [5 x i8] c"utf8\00", align 1
@.str.403 = private unnamed_addr constant [8 x i8] c"utf16le\00", align 1
@.str.404 = private unnamed_addr constant [8 x i8] c"utf16be\00", align 1
@.str.405 = private unnamed_addr constant [2 x i8] c"w\00", align 1
@.str.406 = private unnamed_addr constant [2 x i8] c"a\00", align 1
@.str.407 = private unnamed_addr constant [2 x i8] c"s\00", align 1
@.str.408 = private unnamed_addr constant [7 x i8] c"sissii\00", align 1
@.str.409 = private unnamed_addr constant [31 x i8] c"malformed database schema (%s)\00", align 1
@.str.410 = private unnamed_addr constant [8 x i8] c"%z - %s\00", align 1
@.str.411 = private unnamed_addr constant [50 x i8] c"a NATURAL join may not have an ON or USING clause\00", align 1
@.str.412 = private unnamed_addr constant [55 x i8] c"cannot have both ON and USING clauses in the same join\00", align 1
@.str.413 = private unnamed_addr constant [64 x i8] c"cannot join using column %s - column not present in both tables\00", align 1
@.str.414 = private unnamed_addr constant [10 x i8] c"UNION ALL\00", align 1
@.str.415 = private unnamed_addr constant [10 x i8] c"INTERSECT\00", align 1
@.str.416 = private unnamed_addr constant [7 x i8] c"EXCEPT\00", align 1
@.str.417 = private unnamed_addr constant [6 x i8] c"UNION\00", align 1
@.str.418 = private unnamed_addr constant [23 x i8] c"USE TEMP B-TREE FOR %s\00", align 1
@.str.419 = private unnamed_addr constant [8 x i8] c"INTEGER\00", align 1
@.str.420 = private unnamed_addr constant [6 x i8] c"%s.%s\00", align 1
@.str.421 = private unnamed_addr constant [9 x i8] c"column%d\00", align 1
@.str.422 = private unnamed_addr constant [49 x i8] c"cannot use window functions in recursive queries\00", align 1
@.str.423 = private unnamed_addr constant [6 x i8] c"SETUP\00", align 1
@.str.424 = private unnamed_addr constant [42 x i8] c"recursive aggregate queries not supported\00", align 1
@.str.425 = private unnamed_addr constant [15 x i8] c"RECURSIVE STEP\00", align 1
@.str.426 = private unnamed_addr constant [23 x i8] c"SCAN %d CONSTANT ROW%s\00", align 1
@.str.427 = private unnamed_addr constant [42 x i8] c"%s clause should come after %s not before\00", align 1
@.str.428 = private unnamed_addr constant [9 x i8] c"ORDER BY\00", align 1
@.str.429 = private unnamed_addr constant [6 x i8] c"LIMIT\00", align 1
@.str.430 = private unnamed_addr constant [15 x i8] c"COMPOUND QUERY\00", align 1
@.str.431 = private unnamed_addr constant [19 x i8] c"LEFT-MOST SUBQUERY\00", align 1
@.str.432 = private unnamed_addr constant [21 x i8] c"%s USING TEMP B-TREE\00", align 1
@.str.433 = private unnamed_addr constant [11 x i8] c"MERGE (%s)\00", align 1
@.str.434 = private unnamed_addr constant [5 x i8] c"LEFT\00", align 1
@.str.435 = private unnamed_addr constant [6 x i8] c"RIGHT\00", align 1
@.str.436 = private unnamed_addr constant [4 x i8] c"min\00", align 1
@.str.437 = private unnamed_addr constant [4 x i8] c"max\00", align 1
@.str.438 = private unnamed_addr constant [23 x i8] c"'%s' is not a function\00", align 1
@.str.439 = private unnamed_addr constant [43 x i8] c"multiple references to recursive table: %s\00", align 1
@.str.440 = private unnamed_addr constant [23 x i8] c"circular reference: %s\00", align 1
@.str.441 = private unnamed_addr constant [38 x i8] c"table %s has %d values for %d columns\00", align 1
@.str.442 = private unnamed_addr constant [34 x i8] c"multiple recursive references: %s\00", align 1
@.str.443 = private unnamed_addr constant [38 x i8] c"recursive reference in a subquery: %s\00", align 1
@.str.444 = private unnamed_addr constant [39 x i8] c"too many references to \22%s\22: max 65535\00", align 1
@.str.445 = private unnamed_addr constant [31 x i8] c"access to view \22%s\22 prohibited\00", align 1
@.str.446 = private unnamed_addr constant [2 x i8] c"*\00", align 1
@.str.447 = private unnamed_addr constant [9 x i8] c"%s.%s.%s\00", align 1
@.str.448 = private unnamed_addr constant [18 x i8] c"no such table: %s\00", align 1
@.str.449 = private unnamed_addr constant [20 x i8] c"no tables specified\00", align 1
@.str.450 = private unnamed_addr constant [31 x i8] c"too many columns in result set\00", align 1
@.str.451 = private unnamed_addr constant [51 x i8] c"DISTINCT aggregates must have exactly one argument\00", align 1
@.str.452 = private unnamed_addr constant [18 x i8] c"SCAN TABLE %s%s%s\00", align 1
@.str.453 = private unnamed_addr constant [23 x i8] c" USING COVERING INDEX \00", align 1
@.str.454 = private unnamed_addr constant [2 x i8] c"1\00", align 1
@.str.455 = private unnamed_addr constant [65 x i8] c"sqlite3_get_table() called with two or more incompatible queries\00", align 1
@.str.456 = private unnamed_addr constant [4 x i8] c"CRE\00", align 1
@.str.457 = private unnamed_addr constant [4 x i8] c"INS\00", align 1
@.str.458 = private unnamed_addr constant [7 x i8] c"<expr>\00", align 1
@.str.459 = private unnamed_addr constant [6 x i8] c" AND \00", align 1
@.str.460 = private unnamed_addr constant [2 x i8] c"(\00", align 1
@.str.461 = private unnamed_addr constant [3 x i8] c" (\00", align 1
@.str.462 = private unnamed_addr constant [5 x i8] c"%s=?\00", align 1
@.str.463 = private unnamed_addr constant [8 x i8] c"ANY(%s)\00", align 1
@.str.464 = private unnamed_addr constant [2 x i8] c">\00", align 1
@.str.465 = private unnamed_addr constant [2 x i8] c"<\00", align 1
@.str.466 = private unnamed_addr constant [41 x i8] c"ON clause references tables to its right\00", align 1
@.str.467 = private unnamed_addr constant [7 x i8] c"NOCASE\00", align 1
@.str.468 = private unnamed_addr constant [26 x i8] c"automatic index on %s(%s)\00", align 1
@.str.469 = private unnamed_addr constant [11 x i8] c"auto-index\00", align 1
@.str.470 = private unnamed_addr constant [35 x i8] c"abbreviated query algorithm search\00", align 1
@.str.471 = private unnamed_addr constant [18 x i8] c"no query solution\00", align 1
@.str.472 = private unnamed_addr constant [56 x i8] c"second argument to nth_value must be a positive integer\00", align 1
@.str.473 = private unnamed_addr constant [45 x i8] c"argument of ntile must be a positive integer\00", align 1
@row_numberName = constant [11 x i8] c"row_number\00", align 1
@dense_rankName = constant [11 x i8] c"dense_rank\00", align 1
@rankName = constant [5 x i8] c"rank\00", align 1
@percent_rankName = constant [13 x i8] c"percent_rank\00", align 1
@cume_distName = constant [10 x i8] c"cume_dist\00", align 1
@ntileName = constant [6 x i8] c"ntile\00", align 1
@last_valueName = constant [11 x i8] c"last_value\00", align 1
@nth_valueName = constant [10 x i8] c"nth_value\00", align 1
@first_valueName = constant [12 x i8] c"first_value\00", align 1
@leadName = constant [5 x i8] c"lead\00", align 1
@lagName = constant [4 x i8] c"lag\00", align 1
@.str.474 = private unnamed_addr constant [19 x i8] c"no such window: %s\00", align 1
@windowCheckValue.azErr = internal unnamed_addr constant [5 x i8*] [i8* getelementptr inbounds ([53 x i8], [53 x i8]* @.str.475, i32 0, i32 0), i8* getelementptr inbounds ([51 x i8], [51 x i8]* @.str.476, i32 0, i32 0), i8* getelementptr inbounds ([56 x i8], [56 x i8]* @.str.472, i32 0, i32 0), i8* getelementptr inbounds ([52 x i8], [52 x i8]* @.str.477, i32 0, i32 0), i8* getelementptr inbounds ([50 x i8], [50 x i8]* @.str.478, i32 0, i32 0)], align 16
@.str.475 = private unnamed_addr constant [53 x i8] c"frame starting offset must be a non-negative integer\00", align 1
@.str.476 = private unnamed_addr constant [51 x i8] c"frame ending offset must be a non-negative integer\00", align 1
@.str.477 = private unnamed_addr constant [52 x i8] c"frame starting offset must be a non-negative number\00", align 1
@.str.478 = private unnamed_addr constant [50 x i8] c"frame ending offset must be a non-negative number\00", align 1
@windowCheckValue.aOp = internal unnamed_addr constant [5 x i32] [i32 57, i32 57, i32 54, i32 57, i32 57], align 16
@yy_action = local_unnamed_addr constant [1924 x i16] [i16 528, i16 1183, i16 528, i16 114, i16 111, i16 208, i16 114, i16 111, i16 208, i16 192, i16 1186, i16 528, i16 418, i16 528, i16 450, i16 528, i16 1447, i16 362, i16 528, i16 380, i16 6, i16 373, i16 70, i16 70, i16 42, i16 42, i16 476, i16 1423, i16 485, i16 418, i16 417, i16 911, i16 505, i16 42, i16 42, i16 71, i16 71, i16 51, i16 51, i16 912, i16 71, i16 71, i16 484, i16 121, i16 122, i16 112, i16 1132, i16 1132, i16 980, i16 983, i16 973, i16 973, i16 119, i16 119, i16 120, i16 120, i16 120, i16 120, i16 415, i16 380, i16 261, i16 261, i16 261, i16 261, i16 16, i16 16, i16 970, i16 970, i16 981, i16 984, i16 1226, i16 1226, i16 510, i16 525, i16 477, i16 525, i16 528, i16 491, i16 350, i16 236, i16 205, i16 486, i16 356, i16 121, i16 122, i16 112, i16 1132, i16 1132, i16 980, i16 983, i16 973, i16 973, i16 119, i16 119, i16 120, i16 120, i16 120, i16 120, i16 42, i16 42, i16 418, i16 118, i16 118, i16 118, i16 118, i16 117, i16 117, i16 116, i16 116, i16 116, i16 115, i16 409, i16 1452, i16 349, i16 413, i16 1150, i16 1, i16 1, i16 534, i16 3, i16 1154, i16 1454, i16 1185, i16 348, i16 940, i16 286, i16 1081, i16 143, i16 1081, i16 380, i16 940, i16 114, i16 111, i16 208, i16 1234, i16 1440, i16 98, i16 370, i16 164, i16 974, i16 409, i16 118, i16 118, i16 118, i16 118, i16 117, i16 117, i16 116, i16 116, i16 116, i16 115, i16 409, i16 1109, i16 121, i16 122, i16 112, i16 1132, i16 1132, i16 980, i16 983, i16 973, i16 973, i16 119, i16 119, i16 120, i16 120, i16 120, i16 120, i16 261, i16 261, i16 228, i16 261, i16 261, i16 463, i16 460, i16 459, i16 306, i16 423, i16 296, i16 123, i16 435, i16 525, i16 306, i16 458, i16 525, i16 177, i16 1452, i16 499, i16 116, i16 116, i16 116, i16 115, i16 409, i16 285, i16 519, i16 218, i16 1221, i16 335, i16 1200, i16 380, i16 431, i16 120, i16 120, i16 120, i16 120, i16 113, i16 1221, i16 1109, i16 1110, i16 1111, i16 794, i16 118, i16 118, i16 118, i16 118, i16 117, i16 117, i16 116, i16 116, i16 116, i16 115, i16 409, i16 1109, i16 121, i16 122, i16 112, i16 1132, i16 1132, i16 980, i16 983, i16 973, i16 973, i16 119, i16 119, i16 120, i16 120, i16 120, i16 120, i16 380, i16 351, i16 12, i16 83, i16 1109, i16 81, i16 142, i16 256, i16 1109, i16 80, i16 118, i16 118, i16 118, i16 118, i16 117, i16 117, i16 116, i16 116, i16 116, i16 115, i16 409, i16 169, i16 426, i16 307, i16 121, i16 122, i16 112, i16 1132, i16 1132, i16 980, i16 983, i16 973, i16 973, i16 119, i16 119, i16 120, i16 120, i16 120, i16 120, i16 1109, i16 1110, i16 1111, i16 1497, i16 118, i16 118, i16 118, i16 118, i16 117, i16 117, i16 116, i16 116, i16 116, i16 115, i16 409, i16 114, i16 111, i16 208, i16 528, i16 1109, i16 1109, i16 1110, i16 1111, i16 1491, i16 1109, i16 1110, i16 1111, i16 114, i16 111, i16 208, i16 380, i16 1193, i16 183, i16 1003, i16 321, i16 120, i16 120, i16 120, i16 120, i16 440, i16 71, i16 71, i16 487, i16 118, i16 118, i16 118, i16 118, i16 117, i16 117, i16 116, i16 116, i16 116, i16 115, i16 409, i16 121, i16 122, i16 112, i16 1132, i16 1132, i16 980, i16 983, i16 973, i16 973, i16 119, i16 119, i16 120, i16 120, i16 120, i16 120, i16 380, i16 1379, i16 1468, i16 1109, i16 464, i16 1109, i16 1110, i16 1111, i16 281, i16 522, i16 522, i16 522, i16 97, i16 118, i16 118, i16 118, i16 118, i16 117, i16 117, i16 116, i16 116, i16 116, i16 115, i16 409, i16 121, i16 122, i16 112, i16 1132, i16 1132, i16 980, i16 983, i16 973, i16 973, i16 119, i16 119, i16 120, i16 120, i16 120, i16 120, i16 1392, i16 1334, i16 203, i16 473, i16 118, i16 118, i16 118, i16 118, i16 117, i16 117, i16 116, i16 116, i16 116, i16 115, i16 409, i16 164, i16 12, i16 1392, i16 1394, i16 1109, i16 1110, i16 1111, i16 228, i16 1076, i16 215, i16 463, i16 460, i16 459, i16 319, i16 488, i16 380, i16 334, i16 1465, i16 399, i16 816, i16 458, i16 1076, i16 239, i16 325, i16 1076, i16 407, i16 407, i16 407, i16 118, i16 118, i16 118, i16 118, i16 117, i16 117, i16 116, i16 116, i16 116, i16 115, i16 409, i16 121, i16 122, i16 112, i16 1132, i16 1132, i16 980, i16 983, i16 973, i16 973, i16 119, i16 119, i16 120, i16 120, i16 120, i16 120, i16 380, i16 285, i16 519, i16 1130, i16 809, i16 164, i16 235, i16 118, i16 118, i16 118, i16 118, i16 117, i16 117, i16 116, i16 116, i16 116, i16 115, i16 409, i16 189, i16 1392, i16 314, i16 178, i16 317, i16 425, i16 121, i16 122, i16 112, i16 1132, i16 1132, i16 980, i16 983, i16 973, i16 973, i16 119, i16 119, i16 120, i16 120, i16 120, i16 120, i16 382, i16 466, i16 1076, i16 419, i16 118, i16 118, i16 118, i16 118, i16 117, i16 117, i16 116, i16 116, i16 116, i16 115, i16 409, i16 1076, i16 527, i16 396, i16 1076, i16 1109, i16 1130, i16 285, i16 519, i16 247, i16 264, i16 333, i16 469, i16 328, i16 468, i16 233, i16 380, i16 217, i16 812, i16 336, i16 1094, i16 324, i16 117, i16 117, i16 116, i16 116, i16 116, i16 115, i16 409, i16 118, i16 118, i16 118, i16 118, i16 117, i16 117, i16 116, i16 116, i16 116, i16 115, i16 409, i16 121, i16 122, i16 112, i16 1132, i16 1132, i16 980, i16 983, i16 973, i16 973, i16 119, i16 119, i16 120, i16 120, i16 120, i16 120, i16 380, i16 1076, i16 394, i16 960, i16 961, i16 1109, i16 1110, i16 1111, i16 285, i16 519, i16 1109, i16 444, i16 495, i16 163, i16 1076, i16 441, i16 347, i16 1076, i16 812, i16 951, i16 450, i16 505, i16 163, i16 950, i16 121, i16 122, i16 112, i16 1132, i16 1132, i16 980, i16 983, i16 973, i16 973, i16 119, i16 119, i16 120, i16 120, i16 120, i16 120, i16 528, i16 1333, i16 1224, i16 1224, i16 118, i16 118, i16 118, i16 118, i16 117, i16 117, i16 116, i16 116, i16 116, i16 115, i16 409, i16 950, i16 950, i16 952, i16 528, i16 877, i16 115, i16 409, i16 13, i16 13, i16 293, i16 1422, i16 1109, i16 1110, i16 1111, i16 494, i16 380, i16 334, i16 1465, i16 526, i16 945, i16 866, i16 866, i16 388, i16 439, i16 32, i16 71, i16 71, i16 490, i16 118, i16 118, i16 118, i16 118, i16 117, i16 117, i16 116, i16 116, i16 116, i16 115, i16 409, i16 121, i16 122, i16 112, i16 1132, i16 1132, i16 980, i16 983, i16 973, i16 973, i16 119, i16 119, i16 120, i16 120, i16 120, i16 120, i16 380, i16 433, i16 284, i16 1471, i16 534, i16 3, i16 1154, i16 1109, i16 510, i16 474, i16 1446, i16 286, i16 378, i16 143, i16 6, i16 506, i16 1439, i16 509, i16 503, i16 1446, i16 1234, i16 508, i16 336, i16 6, i16 121, i16 122, i16 112, i16 1132, i16 1132, i16 980, i16 983, i16 973, i16 973, i16 119, i16 119, i16 120, i16 120, i16 120, i16 120, i16 137, i16 5, i16 206, i16 1387, i16 118, i16 118, i16 118, i16 118, i16 117, i16 117, i16 116, i16 116, i16 116, i16 115, i16 409, i16 261, i16 261, i16 528, i16 255, i16 255, i16 533, i16 401, i16 1154, i16 1109, i16 1110, i16 1111, i16 270, i16 286, i16 525, i16 143, i16 380, i16 525, i16 406, i16 405, i16 335, i16 267, i16 1234, i16 335, i16 1109, i16 71, i16 71, i16 832, i16 218, i16 118, i16 118, i16 118, i16 118, i16 117, i16 117, i16 116, i16 116, i16 116, i16 115, i16 409, i16 121, i16 122, i16 112, i16 1132, i16 1132, i16 980, i16 983, i16 973, i16 973, i16 119, i16 119, i16 120, i16 120, i16 120, i16 120, i16 528, i16 261, i16 261, i16 467, i16 380, i16 355, i16 1023, i16 510, i16 1139, i16 192, i16 1139, i16 833, i16 145, i16 450, i16 525, i16 141, i16 475, i16 258, i16 1109, i16 1434, i16 896, i16 368, i16 71, i16 71, i16 1109, i16 1110, i16 1111, i16 1109, i16 218, i16 100, i16 112, i16 1132, i16 1132, i16 980, i16 983, i16 973, i16 973, i16 119, i16 119, i16 120, i16 120, i16 120, i16 120, i16 118, i16 118, i16 118, i16 118, i16 117, i16 117, i16 116, i16 116, i16 116, i16 115, i16 409, i16 211, i16 1044, i16 528, i16 1386, i16 433, i16 282, i16 960, i16 1028, i16 1028, i16 447, i16 386, i16 397, i16 1319, i16 511, i16 1444, i16 357, i16 1045, i16 353, i16 6, i16 1109, i16 1110, i16 1111, i16 951, i16 414, i16 71, i16 71, i16 950, i16 528, i16 1109, i16 1110, i16 1111, i16 1046, i16 118, i16 118, i16 118, i16 118, i16 117, i16 117, i16 116, i16 116, i16 116, i16 115, i16 409, i16 125, i16 103, i16 1147, i16 898, i16 261, i16 261, i16 71, i16 71, i16 192, i16 852, i16 528, i16 386, i16 897, i16 207, i16 950, i16 950, i16 952, i16 525, i16 510, i16 853, i16 379, i16 380, i16 262, i16 262, i16 426, i16 307, i16 193, i16 512, i16 782, i16 783, i16 784, i16 386, i16 55, i16 55, i16 271, i16 525, i16 295, i16 450, i16 896, i16 390, i16 528, i16 380, i16 275, i16 404, i16 275, i16 121, i16 122, i16 112, i16 1132, i16 1132, i16 980, i16 983, i16 973, i16 973, i16 119, i16 119, i16 120, i16 120, i16 120, i16 120, i16 1445, i16 380, i16 56, i16 56, i16 6, i16 121, i16 122, i16 112, i16 1132, i16 1132, i16 980, i16 983, i16 973, i16 973, i16 119, i16 119, i16 120, i16 120, i16 120, i16 120, i16 268, i16 1233, i16 2, i16 377, i16 376, i16 121, i16 110, i16 112, i16 1132, i16 1132, i16 980, i16 983, i16 973, i16 973, i16 119, i16 119, i16 120, i16 120, i16 120, i16 120, i16 269, i16 285, i16 519, i16 118, i16 118, i16 118, i16 118, i16 117, i16 117, i16 116, i16 116, i16 116, i16 115, i16 409, i16 1109, i16 528, i16 439, i16 528, i16 9, i16 1109, i16 239, i16 1113, i16 450, i16 118, i16 118, i16 118, i16 118, i16 117, i16 117, i16 116, i16 116, i16 116, i16 115, i16 409, i16 528, i16 420, i16 528, i16 15, i16 15, i16 13, i16 13, i16 471, i16 528, i16 118, i16 118, i16 118, i16 118, i16 117, i16 117, i16 116, i16 116, i16 116, i16 115, i16 409, i16 393, i16 1130, i16 44, i16 44, i16 57, i16 57, i16 406, i16 405, i16 1431, i16 380, i16 13, i16 13, i16 1229, i16 872, i16 1136, i16 1109, i16 1110, i16 1111, i16 871, i16 1138, i16 1109, i16 1110, i16 1111, i16 1113, i16 439, i16 395, i16 294, i16 1137, i16 450, i16 455, i16 335, i16 104, i16 528, i16 102, i16 122, i16 112, i16 1132, i16 1132, i16 980, i16 983, i16 973, i16 973, i16 119, i16 119, i16 120, i16 120, i16 120, i16 120, i16 528, i16 433, i16 1109, i16 1139, i16 528, i16 1139, i16 13, i16 13, i16 232, i16 1130, i16 305, i16 109, i16 261, i16 261, i16 107, i16 520, i16 140, i16 4, i16 38, i16 1076, i16 1319, i16 274, i16 13, i16 13, i16 312, i16 525, i16 13, i16 13, i16 1319, i16 144, i16 502, i16 523, i16 1076, i16 528, i16 911, i16 1076, i16 288, i16 186, i16 528, i16 896, i16 528, i16 187, i16 912, i16 118, i16 118, i16 118, i16 118, i16 117, i16 117, i16 116, i16 116, i16 116, i16 115, i16 409, i16 410, i16 13, i16 13, i16 1109, i16 1110, i16 1111, i16 71, i16 71, i16 58, i16 58, i16 107, i16 520, i16 517, i16 4, i16 304, i16 289, i16 507, i16 1232, i16 273, i16 528, i16 272, i16 383, i16 164, i16 437, i16 1172, i16 1443, i16 501, i16 523, i16 1496, i16 6, i16 1025, i16 841, i16 493, i16 478, i16 1025, i16 481, i16 391, i16 324, i16 513, i16 8, i16 960, i16 59, i16 59, i16 408, i16 392, i16 500, i16 105, i16 105, i16 261, i16 261, i16 410, i16 261, i16 261, i16 106, i16 1087, i16 410, i16 530, i16 529, i16 261, i16 261, i16 950, i16 525, i16 517, i16 301, i16 525, i16 528, i16 445, i16 261, i16 261, i16 261, i16 261, i16 525, i16 261, i16 261, i16 508, i16 207, i16 497, i16 285, i16 519, i16 528, i16 525, i16 496, i16 525, i16 260, i16 205, i16 525, i16 528, i16 60, i16 60, i16 528, i16 960, i16 950, i16 950, i16 952, i16 953, i16 27, i16 105, i16 105, i16 528, i16 1319, i16 896, i16 61, i16 61, i16 106, i16 1087, i16 410, i16 530, i16 529, i16 62, i16 62, i16 950, i16 45, i16 45, i16 107, i16 520, i16 528, i16 4, i16 528, i16 438, i16 1044, i16 46, i16 46, i16 1175, i16 384, i16 298, i16 292, i16 300, i16 231, i16 230, i16 229, i16 523, i16 1442, i16 528, i16 1270, i16 1045, i16 6, i16 30, i16 47, i16 47, i16 49, i16 49, i16 950, i16 950, i16 952, i16 953, i16 27, i16 1470, i16 1098, i16 412, i16 1046, i16 528, i16 265, i16 1238, i16 410, i16 50, i16 50, i16 366, i16 366, i16 365, i16 250, i16 363, i16 97, i16 1319, i16 791, i16 525, i16 517, i16 528, i16 31, i16 528, i16 446, i16 516, i16 1129, i16 63, i16 63, i16 528, i16 232, i16 212, i16 872, i16 291, i16 497, i16 428, i16 528, i16 871, i16 1022, i16 498, i16 1022, i16 290, i16 201, i16 64, i16 64, i16 65, i16 65, i16 528, i16 960, i16 1459, i16 528, i16 14, i16 14, i16 1269, i16 105, i16 105, i16 139, i16 937, i16 66, i16 66, i16 299, i16 106, i16 528, i16 410, i16 530, i16 529, i16 528, i16 422, i16 950, i16 127, i16 127, i16 214, i16 67, i16 67, i16 303, i16 107, i16 520, i16 97, i16 4, i16 156, i16 1411, i16 17, i16 158, i16 528, i16 52, i16 52, i16 528, i16 402, i16 68, i16 68, i16 528, i16 1204, i16 523, i16 804, i16 528, i16 819, i16 528, i16 383, i16 213, i16 950, i16 950, i16 952, i16 953, i16 27, i16 1410, i16 69, i16 69, i16 528, i16 53, i16 53, i16 831, i16 830, i16 151, i16 151, i16 823, i16 410, i16 152, i16 152, i16 76, i16 76, i16 427, i16 528, i16 521, i16 384, i16 1010, i16 528, i16 1021, i16 517, i16 1021, i16 54, i16 54, i16 528, i16 381, i16 442, i16 528, i16 309, i16 528, i16 285, i16 519, i16 1266, i16 196, i16 497, i16 528, i16 72, i16 72, i16 954, i16 496, i16 128, i16 128, i16 804, i16 263, i16 819, i16 313, i16 73, i16 73, i16 960, i16 129, i16 129, i16 130, i16 130, i16 416, i16 105, i16 105, i16 95, i16 126, i16 126, i16 838, i16 839, i16 106, i16 528, i16 410, i16 530, i16 529, i16 1098, i16 412, i16 950, i16 316, i16 265, i16 942, i16 1203, i16 1010, i16 238, i16 366, i16 366, i16 365, i16 250, i16 363, i16 432, i16 318, i16 791, i16 238, i16 150, i16 150, i16 528, i16 107, i16 520, i16 528, i16 4, i16 528, i16 320, i16 528, i16 954, i16 212, i16 1217, i16 291, i16 1257, i16 950, i16 950, i16 952, i16 953, i16 27, i16 523, i16 290, i16 528, i16 1202, i16 149, i16 149, i16 528, i16 134, i16 134, i16 133, i16 133, i16 131, i16 131, i16 107, i16 520, i16 528, i16 4, i16 332, i16 528, i16 914, i16 915, i16 1201, i16 528, i16 410, i16 132, i16 132, i16 528, i16 331, i16 75, i16 75, i16 523, i16 214, i16 327, i16 434, i16 280, i16 517, i16 238, i16 77, i16 77, i16 156, i16 74, i16 74, i16 158, i16 869, i16 43, i16 43, i16 109, i16 308, i16 48, i16 48, i16 97, i16 337, i16 456, i16 410, i16 322, i16 234, i16 1484, i16 97, i16 213, i16 1006, i16 338, i16 905, i16 234, i16 960, i16 238, i16 517, i16 1278, i16 1318, i16 1253, i16 105, i16 105, i16 876, i16 802, i16 1264, i16 870, i16 138, i16 106, i16 109, i16 410, i16 530, i16 529, i16 514, i16 515, i16 950, i16 1324, i16 99, i16 520, i16 451, i16 4, i16 1182, i16 1174, i16 1163, i16 381, i16 960, i16 1162, i16 1164, i16 1478, i16 285, i16 519, i16 105, i16 105, i16 253, i16 523, i16 195, i16 210, i16 1250, i16 106, i16 340, i16 410, i16 530, i16 529, i16 342, i16 11, i16 950, i16 950, i16 950, i16 952, i16 953, i16 27, i16 344, i16 416, i16 198, i16 367, i16 1303, i16 421, i16 410, i16 297, i16 302, i16 1311, i16 372, i16 436, i16 461, i16 202, i16 1200, i16 330, i16 1383, i16 1382, i16 517, i16 190, i16 346, i16 191, i16 518, i16 197, i16 360, i16 950, i16 950, i16 952, i16 953, i16 27, i16 1481, i16 1147, i16 242, i16 1430, i16 165, i16 1428, i16 1144, i16 385, i16 83, i16 430, i16 1388, i16 79, i16 175, i16 1308, i16 82, i16 161, i16 960, i16 167, i16 1300, i16 95, i16 424, i16 170, i16 105, i16 105, i16 35, i16 171, i16 172, i16 371, i16 173, i16 106, i16 36, i16 410, i16 530, i16 529, i16 1314, i16 179, i16 950, i16 265, i16 369, i16 429, i16 443, i16 1377, i16 366, i16 366, i16 365, i16 250, i16 363, i16 454, i16 222, i16 791, i16 88, i16 449, i16 1399, i16 254, i16 224, i16 184, i16 311, i16 452, i16 315, i16 225, i16 470, i16 1165, i16 212, i16 226, i16 291, i16 374, i16 90, i16 950, i16 950, i16 952, i16 953, i16 27, i16 290, i16 398, i16 1211, i16 1495, i16 823, i16 1494, i16 203, i16 1220, i16 1219, i16 1464, i16 1218, i16 1261, i16 400, i16 278, i16 375, i16 1190, i16 1189, i16 329, i16 489, i16 1188, i16 1493, i16 279, i16 94, i16 339, i16 241, i16 480, i16 1262, i16 1210, i16 483, i16 341, i16 214, i16 1260, i16 1259, i16 343, i16 345, i16 240, i16 403, i16 124, i16 156, i16 10, i16 508, i16 158, i16 1285, i16 1450, i16 1449, i16 354, i16 492, i16 101, i16 96, i16 248, i16 1171, i16 34, i16 531, i16 1363, i16 1104, i16 249, i16 251, i16 213, i16 1243, i16 252, i16 352, i16 359, i16 194, i16 1242, i16 358, i16 532, i16 1160, i16 1155, i16 1415, i16 153, i16 1416, i16 1284, i16 1414, i16 154, i16 136, i16 276, i16 1413, i16 778, i16 411, i16 199, i16 287, i16 200, i16 78, i16 155, i16 209, i16 266, i16 283, i16 135, i16 1020, i16 1018, i16 934, i16 381, i16 166, i16 157, i16 216, i16 168, i16 285, i16 519, i16 855, i16 1034, i16 938, i16 159, i16 174, i16 387, i16 389, i16 84, i16 176, i16 85, i16 86, i16 87, i16 160, i16 1037, i16 1033, i16 219, i16 220, i16 146, i16 18, i16 221, i16 1026, i16 416, i16 1141, i16 310, i16 238, i16 448, i16 223, i16 180, i16 181, i16 37, i16 793, i16 331, i16 227, i16 453, i16 323, i16 465, i16 834, i16 182, i16 89, i16 19, i16 20, i16 457, i16 821, i16 462, i16 326, i16 91, i16 277, i16 147, i16 92, i16 472, i16 479, i16 1092, i16 148, i16 986, i16 904, i16 1062, i16 162, i16 93, i16 39, i16 482, i16 1063, i16 40, i16 204, i16 257, i16 259, i16 185, i16 899, i16 237, i16 109, i16 1082, i16 1078, i16 1080, i16 21, i16 1066, i16 1086, i16 33, i16 504, i16 188, i16 22, i16 23, i16 24, i16 1085, i16 25, i16 97, i16 1001, i16 987, i16 985, i16 989, i16 26, i16 1043, i16 244, i16 7, i16 1042, i16 243, i16 990, i16 28, i16 41, i16 524, i16 955, i16 803, i16 108, i16 29, i16 245, i16 865, i16 246, i16 1486, i16 364, i16 361, i16 1100, i16 1099, i16 1151, i16 1151, i16 1151, i16 1151, i16 1151, i16 1151, i16 1151, i16 1485], align 16
@yy_lookahead = local_unnamed_addr constant [2105 x i16] [i16 189, i16 211, i16 189, i16 267, i16 268, i16 269, i16 267, i16 268, i16 269, i16 189, i16 211, i16 189, i16 189, i16 189, i16 189, i16 189, i16 294, i16 197, i16 189, i16 19, i16 298, i16 201, i16 211, i16 212, i16 211, i16 212, i16 200, i16 288, i16 200, i16 206, i16 207, i16 31, i16 189, i16 211, i16 212, i16 211, i16 212, i16 211, i16 212, i16 39, i16 211, i16 212, i16 189, i16 43, i16 44, i16 45, i16 46, i16 47, i16 48, i16 49, i16 50, i16 51, i16 52, i16 53, i16 54, i16 55, i16 56, i16 57, i16 233, i16 19, i16 234, i16 235, i16 234, i16 235, i16 211, i16 212, i16 46, i16 47, i16 48, i16 49, i16 230, i16 231, i16 248, i16 247, i16 248, i16 247, i16 189, i16 248, i16 214, i16 251, i16 252, i16 257, i16 271, i16 43, i16 44, i16 45, i16 46, i16 47, i16 48, i16 49, i16 50, i16 51, i16 52, i16 53, i16 54, i16 55, i16 56, i16 57, i16 211, i16 212, i16 277, i16 101, i16 102, i16 103, i16 104, i16 105, i16 106, i16 107, i16 108, i16 109, i16 110, i16 111, i16 299, i16 300, i16 289, i16 181, i16 182, i16 183, i16 184, i16 185, i16 186, i16 299, i16 211, i16 301, i16 73, i16 191, i16 86, i16 193, i16 88, i16 19, i16 73, i16 267, i16 268, i16 269, i16 200, i16 292, i16 26, i16 200, i16 81, i16 119, i16 111, i16 101, i16 102, i16 103, i16 104, i16 105, i16 106, i16 107, i16 108, i16 109, i16 110, i16 111, i16 59, i16 43, i16 44, i16 45, i16 46, i16 47, i16 48, i16 49, i16 50, i16 51, i16 52, i16 53, i16 54, i16 55, i16 56, i16 57, i16 234, i16 235, i16 117, i16 234, i16 235, i16 120, i16 121, i16 122, i16 125, i16 126, i16 127, i16 69, i16 189, i16 247, i16 125, i16 130, i16 247, i16 22, i16 299, i16 300, i16 107, i16 108, i16 109, i16 110, i16 111, i16 136, i16 137, i16 261, i16 218, i16 189, i16 220, i16 19, i16 263, i16 54, i16 55, i16 56, i16 57, i16 58, i16 228, i16 114, i16 115, i16 116, i16 21, i16 101, i16 102, i16 103, i16 104, i16 105, i16 106, i16 107, i16 108, i16 109, i16 110, i16 111, i16 59, i16 43, i16 44, i16 45, i16 46, i16 47, i16 48, i16 49, i16 50, i16 51, i16 52, i16 53, i16 54, i16 55, i16 56, i16 57, i16 19, i16 214, i16 208, i16 148, i16 59, i16 24, i16 236, i16 208, i16 59, i16 67, i16 101, i16 102, i16 103, i16 104, i16 105, i16 106, i16 107, i16 108, i16 109, i16 110, i16 111, i16 72, i16 126, i16 127, i16 43, i16 44, i16 45, i16 46, i16 47, i16 48, i16 49, i16 50, i16 51, i16 52, i16 53, i16 54, i16 55, i16 56, i16 57, i16 114, i16 115, i16 116, i16 225, i16 101, i16 102, i16 103, i16 104, i16 105, i16 106, i16 107, i16 108, i16 109, i16 110, i16 111, i16 267, i16 268, i16 269, i16 189, i16 59, i16 114, i16 115, i16 116, i16 210, i16 114, i16 115, i16 116, i16 267, i16 268, i16 269, i16 19, i16 218, i16 72, i16 121, i16 23, i16 54, i16 55, i16 56, i16 57, i16 284, i16 211, i16 212, i16 19, i16 101, i16 102, i16 103, i16 104, i16 105, i16 106, i16 107, i16 108, i16 109, i16 110, i16 111, i16 43, i16 44, i16 45, i16 46, i16 47, i16 48, i16 49, i16 50, i16 51, i16 52, i16 53, i16 54, i16 55, i16 56, i16 57, i16 19, i16 158, i16 189, i16 59, i16 23, i16 114, i16 115, i16 116, i16 248, i16 205, i16 206, i16 207, i16 26, i16 101, i16 102, i16 103, i16 104, i16 105, i16 106, i16 107, i16 108, i16 109, i16 110, i16 111, i16 43, i16 44, i16 45, i16 46, i16 47, i16 48, i16 49, i16 50, i16 51, i16 52, i16 53, i16 54, i16 55, i16 56, i16 57, i16 189, i16 266, i16 162, i16 163, i16 101, i16 102, i16 103, i16 104, i16 105, i16 106, i16 107, i16 108, i16 109, i16 110, i16 111, i16 81, i16 208, i16 206, i16 207, i16 114, i16 115, i16 116, i16 117, i16 76, i16 24, i16 120, i16 121, i16 122, i16 16, i16 114, i16 19, i16 296, i16 297, i16 19, i16 23, i16 130, i16 89, i16 24, i16 24, i16 92, i16 205, i16 206, i16 207, i16 101, i16 102, i16 103, i16 104, i16 105, i16 106, i16 107, i16 108, i16 109, i16 110, i16 111, i16 43, i16 44, i16 45, i16 46, i16 47, i16 48, i16 49, i16 50, i16 51, i16 52, i16 53, i16 54, i16 55, i16 56, i16 57, i16 19, i16 136, i16 137, i16 59, i16 23, i16 81, i16 26, i16 101, i16 102, i16 103, i16 104, i16 105, i16 106, i16 107, i16 108, i16 109, i16 110, i16 111, i16 279, i16 277, i16 77, i16 22, i16 79, i16 284, i16 43, i16 44, i16 45, i16 46, i16 47, i16 48, i16 49, i16 50, i16 51, i16 52, i16 53, i16 54, i16 55, i16 56, i16 57, i16 194, i16 95, i16 76, i16 118, i16 101, i16 102, i16 103, i16 104, i16 105, i16 106, i16 107, i16 108, i16 109, i16 110, i16 111, i16 89, i16 189, i16 111, i16 92, i16 59, i16 115, i16 136, i16 137, i16 117, i16 118, i16 119, i16 120, i16 121, i16 122, i16 123, i16 19, i16 139, i16 59, i16 189, i16 23, i16 129, i16 105, i16 106, i16 107, i16 108, i16 109, i16 110, i16 111, i16 101, i16 102, i16 103, i16 104, i16 105, i16 106, i16 107, i16 108, i16 109, i16 110, i16 111, i16 43, i16 44, i16 45, i16 46, i16 47, i16 48, i16 49, i16 50, i16 51, i16 52, i16 53, i16 54, i16 55, i16 56, i16 57, i16 19, i16 76, i16 227, i16 99, i16 23, i16 114, i16 115, i16 116, i16 136, i16 137, i16 59, i16 274, i16 87, i16 189, i16 89, i16 278, i16 189, i16 92, i16 114, i16 115, i16 189, i16 189, i16 189, i16 119, i16 43, i16 44, i16 45, i16 46, i16 47, i16 48, i16 49, i16 50, i16 51, i16 52, i16 53, i16 54, i16 55, i16 56, i16 57, i16 189, i16 266, i16 230, i16 231, i16 101, i16 102, i16 103, i16 104, i16 105, i16 106, i16 107, i16 108, i16 109, i16 110, i16 111, i16 150, i16 151, i16 152, i16 189, i16 107, i16 110, i16 111, i16 211, i16 212, i16 189, i16 233, i16 114, i16 115, i16 116, i16 143, i16 19, i16 296, i16 297, i16 132, i16 23, i16 134, i16 135, i16 226, i16 189, i16 22, i16 211, i16 212, i16 189, i16 101, i16 102, i16 103, i16 104, i16 105, i16 106, i16 107, i16 108, i16 109, i16 110, i16 111, i16 43, i16 44, i16 45, i16 46, i16 47, i16 48, i16 49, i16 50, i16 51, i16 52, i16 53, i16 54, i16 55, i16 56, i16 57, i16 19, i16 189, i16 239, i16 183, i16 184, i16 185, i16 186, i16 59, i16 248, i16 293, i16 294, i16 191, i16 249, i16 193, i16 298, i16 291, i16 292, i16 257, i16 293, i16 294, i16 200, i16 143, i16 189, i16 298, i16 43, i16 44, i16 45, i16 46, i16 47, i16 48, i16 49, i16 50, i16 51, i16 52, i16 53, i16 54, i16 55, i16 56, i16 57, i16 161, i16 22, i16 189, i16 276, i16 101, i16 102, i16 103, i16 104, i16 105, i16 106, i16 107, i16 108, i16 109, i16 110, i16 111, i16 234, i16 235, i16 189, i16 234, i16 235, i16 184, i16 227, i16 186, i16 114, i16 115, i16 116, i16 285, i16 191, i16 247, i16 193, i16 19, i16 247, i16 105, i16 106, i16 189, i16 262, i16 200, i16 189, i16 59, i16 211, i16 212, i16 35, i16 261, i16 101, i16 102, i16 103, i16 104, i16 105, i16 106, i16 107, i16 108, i16 109, i16 110, i16 111, i16 43, i16 44, i16 45, i16 46, i16 47, i16 48, i16 49, i16 50, i16 51, i16 52, i16 53, i16 54, i16 55, i16 56, i16 57, i16 189, i16 234, i16 235, i16 66, i16 19, i16 189, i16 11, i16 248, i16 150, i16 189, i16 152, i16 74, i16 236, i16 189, i16 247, i16 236, i16 257, i16 23, i16 59, i16 189, i16 26, i16 201, i16 211, i16 212, i16 114, i16 115, i16 116, i16 59, i16 261, i16 156, i16 45, i16 46, i16 47, i16 48, i16 49, i16 50, i16 51, i16 52, i16 53, i16 54, i16 55, i16 56, i16 57, i16 101, i16 102, i16 103, i16 104, i16 105, i16 106, i16 107, i16 108, i16 109, i16 110, i16 111, i16 15, i16 12, i16 189, i16 233, i16 189, i16 248, i16 99, i16 125, i16 126, i16 127, i16 189, i16 128, i16 189, i16 200, i16 294, i16 244, i16 27, i16 246, i16 298, i16 114, i16 115, i16 116, i16 115, i16 189, i16 211, i16 212, i16 119, i16 189, i16 114, i16 115, i16 116, i16 42, i16 101, i16 102, i16 103, i16 104, i16 105, i16 106, i16 107, i16 108, i16 109, i16 110, i16 111, i16 22, i16 156, i16 60, i16 141, i16 234, i16 235, i16 211, i16 212, i16 189, i16 63, i16 189, i16 189, i16 141, i16 116, i16 150, i16 151, i16 152, i16 247, i16 248, i16 73, i16 201, i16 19, i16 234, i16 235, i16 126, i16 127, i16 24, i16 257, i16 7, i16 8, i16 9, i16 189, i16 211, i16 212, i16 262, i16 247, i16 258, i16 189, i16 141, i16 259, i16 189, i16 19, i16 223, i16 248, i16 225, i16 43, i16 44, i16 45, i16 46, i16 47, i16 48, i16 49, i16 50, i16 51, i16 52, i16 53, i16 54, i16 55, i16 56, i16 57, i16 294, i16 19, i16 211, i16 212, i16 298, i16 43, i16 44, i16 45, i16 46, i16 47, i16 48, i16 49, i16 50, i16 51, i16 52, i16 53, i16 54, i16 55, i16 56, i16 57, i16 258, i16 233, i16 22, i16 105, i16 106, i16 43, i16 44, i16 45, i16 46, i16 47, i16 48, i16 49, i16 50, i16 51, i16 52, i16 53, i16 54, i16 55, i16 56, i16 57, i16 258, i16 136, i16 137, i16 101, i16 102, i16 103, i16 104, i16 105, i16 106, i16 107, i16 108, i16 109, i16 110, i16 111, i16 59, i16 189, i16 189, i16 189, i16 22, i16 59, i16 24, i16 59, i16 189, i16 101, i16 102, i16 103, i16 104, i16 105, i16 106, i16 107, i16 108, i16 109, i16 110, i16 111, i16 189, i16 263, i16 189, i16 211, i16 212, i16 211, i16 212, i16 107, i16 189, i16 101, i16 102, i16 103, i16 104, i16 105, i16 106, i16 107, i16 108, i16 109, i16 110, i16 111, i16 226, i16 59, i16 211, i16 212, i16 211, i16 212, i16 105, i16 106, i16 189, i16 19, i16 211, i16 212, i16 233, i16 133, i16 113, i16 114, i16 115, i16 116, i16 138, i16 118, i16 114, i16 115, i16 116, i16 115, i16 189, i16 226, i16 200, i16 126, i16 189, i16 19, i16 189, i16 155, i16 189, i16 157, i16 44, i16 45, i16 46, i16 47, i16 48, i16 49, i16 50, i16 51, i16 52, i16 53, i16 54, i16 55, i16 56, i16 57, i16 189, i16 189, i16 59, i16 150, i16 189, i16 152, i16 211, i16 212, i16 46, i16 115, i16 285, i16 26, i16 234, i16 235, i16 19, i16 20, i16 22, i16 22, i16 24, i16 76, i16 189, i16 226, i16 211, i16 212, i16 233, i16 247, i16 211, i16 212, i16 189, i16 236, i16 87, i16 36, i16 89, i16 189, i16 31, i16 92, i16 189, i16 226, i16 189, i16 26, i16 189, i16 226, i16 39, i16 101, i16 102, i16 103, i16 104, i16 105, i16 106, i16 107, i16 108, i16 109, i16 110, i16 111, i16 59, i16 211, i16 212, i16 114, i16 115, i16 116, i16 211, i16 212, i16 211, i16 212, i16 19, i16 20, i16 71, i16 22, i16 200, i16 189, i16 226, i16 200, i16 285, i16 189, i16 262, i16 113, i16 81, i16 19, i16 200, i16 294, i16 66, i16 36, i16 23, i16 298, i16 29, i16 26, i16 143, i16 200, i16 33, i16 200, i16 259, i16 129, i16 200, i16 48, i16 99, i16 211, i16 212, i16 248, i16 259, i16 85, i16 105, i16 106, i16 234, i16 235, i16 59, i16 234, i16 235, i16 112, i16 94, i16 114, i16 115, i16 116, i16 234, i16 235, i16 119, i16 247, i16 71, i16 16, i16 247, i16 189, i16 65, i16 234, i16 235, i16 234, i16 235, i16 247, i16 234, i16 235, i16 143, i16 116, i16 85, i16 136, i16 137, i16 189, i16 247, i16 90, i16 247, i16 251, i16 252, i16 247, i16 189, i16 211, i16 212, i16 189, i16 99, i16 150, i16 151, i16 152, i16 153, i16 154, i16 105, i16 106, i16 189, i16 189, i16 141, i16 211, i16 212, i16 112, i16 144, i16 114, i16 115, i16 116, i16 211, i16 212, i16 119, i16 211, i16 212, i16 19, i16 20, i16 189, i16 22, i16 189, i16 114, i16 12, i16 211, i16 212, i16 203, i16 204, i16 77, i16 189, i16 79, i16 125, i16 126, i16 127, i16 36, i16 294, i16 189, i16 189, i16 27, i16 298, i16 22, i16 211, i16 212, i16 211, i16 212, i16 150, i16 151, i16 152, i16 153, i16 154, i16 0, i16 1, i16 2, i16 42, i16 189, i16 5, i16 235, i16 59, i16 211, i16 212, i16 10, i16 11, i16 12, i16 13, i16 14, i16 26, i16 189, i16 17, i16 247, i16 71, i16 189, i16 53, i16 189, i16 259, i16 63, i16 26, i16 211, i16 212, i16 189, i16 46, i16 30, i16 133, i16 32, i16 85, i16 127, i16 189, i16 138, i16 150, i16 90, i16 152, i16 40, i16 26, i16 211, i16 212, i16 211, i16 212, i16 189, i16 99, i16 303, i16 189, i16 211, i16 212, i16 189, i16 105, i16 106, i16 22, i16 149, i16 211, i16 212, i16 158, i16 112, i16 189, i16 114, i16 115, i16 116, i16 189, i16 189, i16 119, i16 211, i16 212, i16 70, i16 211, i16 212, i16 23, i16 19, i16 20, i16 26, i16 22, i16 78, i16 189, i16 22, i16 81, i16 189, i16 211, i16 212, i16 189, i16 259, i16 211, i16 212, i16 189, i16 221, i16 36, i16 59, i16 189, i16 59, i16 189, i16 113, i16 97, i16 150, i16 151, i16 152, i16 153, i16 154, i16 189, i16 211, i16 212, i16 189, i16 211, i16 212, i16 118, i16 119, i16 211, i16 212, i16 124, i16 59, i16 211, i16 212, i16 211, i16 212, i16 61, i16 189, i16 203, i16 204, i16 59, i16 189, i16 150, i16 71, i16 152, i16 211, i16 212, i16 189, i16 131, i16 189, i16 189, i16 189, i16 189, i16 136, i16 137, i16 189, i16 140, i16 85, i16 189, i16 211, i16 212, i16 59, i16 90, i16 211, i16 212, i16 115, i16 22, i16 115, i16 189, i16 211, i16 212, i16 99, i16 211, i16 212, i16 211, i16 212, i16 159, i16 105, i16 106, i16 147, i16 211, i16 212, i16 7, i16 8, i16 112, i16 189, i16 114, i16 115, i16 116, i16 1, i16 2, i16 119, i16 189, i16 5, i16 23, i16 221, i16 115, i16 26, i16 10, i16 11, i16 12, i16 13, i16 14, i16 23, i16 189, i16 17, i16 26, i16 211, i16 212, i16 189, i16 19, i16 20, i16 189, i16 22, i16 189, i16 189, i16 189, i16 115, i16 30, i16 189, i16 32, i16 253, i16 150, i16 151, i16 152, i16 153, i16 154, i16 36, i16 40, i16 189, i16 221, i16 211, i16 212, i16 189, i16 211, i16 212, i16 211, i16 212, i16 211, i16 212, i16 19, i16 20, i16 189, i16 22, i16 119, i16 189, i16 83, i16 84, i16 189, i16 189, i16 59, i16 211, i16 212, i16 189, i16 129, i16 211, i16 212, i16 36, i16 70, i16 189, i16 23, i16 250, i16 71, i16 26, i16 211, i16 212, i16 78, i16 211, i16 212, i16 81, i16 23, i16 211, i16 212, i16 26, i16 23, i16 211, i16 212, i16 26, i16 189, i16 23, i16 59, i16 23, i16 26, i16 139, i16 26, i16 97, i16 23, i16 189, i16 23, i16 26, i16 99, i16 26, i16 71, i16 189, i16 189, i16 189, i16 105, i16 106, i16 107, i16 23, i16 189, i16 23, i16 26, i16 112, i16 26, i16 114, i16 115, i16 116, i16 189, i16 231, i16 119, i16 189, i16 19, i16 20, i16 281, i16 22, i16 189, i16 189, i16 189, i16 131, i16 99, i16 189, i16 189, i16 189, i16 136, i16 137, i16 105, i16 106, i16 280, i16 36, i16 237, i16 290, i16 250, i16 112, i16 250, i16 114, i16 115, i16 116, i16 250, i16 238, i16 119, i16 150, i16 151, i16 152, i16 153, i16 154, i16 250, i16 159, i16 209, i16 187, i16 241, i16 254, i16 59, i16 254, i16 286, i16 241, i16 241, i16 286, i16 215, i16 224, i16 220, i16 214, i16 214, i16 214, i16 71, i16 244, i16 254, i16 244, i16 273, i16 238, i16 240, i16 150, i16 151, i16 152, i16 153, i16 154, i16 192, i16 60, i16 139, i16 196, i16 290, i16 196, i16 38, i16 196, i16 148, i16 113, i16 276, i16 287, i16 22, i16 265, i16 287, i16 43, i16 99, i16 229, i16 241, i16 147, i16 18, i16 232, i16 105, i16 106, i16 264, i16 232, i16 232, i16 265, i16 232, i16 112, i16 264, i16 114, i16 115, i16 116, i16 229, i16 229, i16 119, i16 5, i16 241, i16 241, i16 196, i16 241, i16 10, i16 11, i16 12, i16 13, i16 14, i16 18, i16 195, i16 17, i16 155, i16 62, i16 283, i16 196, i16 195, i16 22, i16 282, i16 216, i16 196, i16 195, i16 113, i16 196, i16 30, i16 195, i16 32, i16 216, i16 22, i16 150, i16 151, i16 152, i16 153, i16 154, i16 40, i16 64, i16 222, i16 219, i16 124, i16 219, i16 162, i16 213, i16 213, i16 297, i16 213, i16 256, i16 111, i16 275, i16 216, i16 213, i16 215, i16 213, i16 142, i16 213, i16 213, i16 275, i16 113, i16 255, i16 91, i16 216, i16 256, i16 222, i16 216, i16 255, i16 70, i16 256, i16 256, i16 255, i16 255, i16 196, i16 82, i16 146, i16 78, i16 22, i16 143, i16 81, i16 260, i16 302, i16 302, i16 196, i16 144, i16 155, i16 145, i16 25, i16 199, i16 26, i16 198, i16 270, i16 13, i16 190, i16 190, i16 97, i16 245, i16 6, i16 244, i16 241, i16 243, i16 245, i16 242, i16 188, i16 188, i16 188, i16 208, i16 202, i16 208, i16 260, i16 208, i16 202, i16 217, i16 217, i16 208, i16 4, i16 3, i16 209, i16 160, i16 209, i16 208, i16 202, i16 15, i16 98, i16 272, i16 16, i16 23, i16 23, i16 137, i16 131, i16 148, i16 128, i16 24, i16 140, i16 136, i16 137, i16 20, i16 1, i16 149, i16 128, i16 140, i16 61, i16 37, i16 53, i16 148, i16 53, i16 53, i16 53, i16 128, i16 114, i16 1, i16 34, i16 139, i16 5, i16 22, i16 113, i16 68, i16 159, i16 75, i16 158, i16 26, i16 41, i16 139, i16 68, i16 113, i16 24, i16 20, i16 129, i16 123, i16 19, i16 23, i16 96, i16 28, i16 22, i16 22, i16 22, i16 22, i16 67, i16 59, i16 67, i16 24, i16 22, i16 67, i16 23, i16 147, i16 22, i16 24, i16 23, i16 23, i16 23, i16 114, i16 23, i16 37, i16 26, i16 22, i16 24, i16 23, i16 22, i16 139, i16 23, i16 23, i16 22, i16 141, i16 34, i16 26, i16 75, i16 88, i16 86, i16 34, i16 23, i16 75, i16 22, i16 24, i16 26, i16 34, i16 34, i16 34, i16 93, i16 34, i16 26, i16 23, i16 23, i16 23, i16 23, i16 34, i16 23, i16 22, i16 44, i16 23, i16 26, i16 11, i16 22, i16 22, i16 26, i16 23, i16 23, i16 22, i16 22, i16 139, i16 133, i16 139, i16 139, i16 15, i16 23, i16 1, i16 1, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 139, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304], align 16
@yy_shift_ofst = local_unnamed_addr constant [535 x i16] [i16 1448, i16 1277, i16 1072, i16 1668, i16 1072, i16 319, i16 1122, i16 1225, i16 1332, i16 1481, i16 1481, i16 1481, i16 57, i16 0, i16 0, i16 180, i16 897, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 930, i16 930, i16 1020, i16 1020, i16 290, i16 378, i16 319, i16 319, i16 319, i16 319, i16 319, i16 319, i16 40, i16 110, i16 219, i16 288, i16 327, i16 396, i16 435, i16 504, i16 543, i16 612, i16 651, i16 720, i16 877, i16 897, i16 897, i16 897, i16 897, i16 897, i16 897, i16 897, i16 897, i16 897, i16 897, i16 897, i16 897, i16 897, i16 897, i16 897, i16 897, i16 897, i16 897, i16 917, i16 897, i16 1019, i16 763, i16 763, i16 1451, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1553, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 147, i16 258, i16 258, i16 258, i16 258, i16 258, i16 360, i16 424, i16 81, i16 183, i16 1039, i16 183, i16 636, i16 636, i16 183, i16 434, i16 434, i16 189, i16 434, i16 434, i16 134, i16 225, i16 225, i16 511, i16 29, i16 1924, i16 1924, i16 399, i16 399, i16 399, i16 93, i16 163, i16 187, i16 163, i16 163, i16 821, i16 821, i16 487, i16 237, i16 183, i16 183, i16 183, i16 183, i16 183, i16 183, i16 183, i16 183, i16 183, i16 183, i16 183, i16 183, i16 183, i16 183, i16 183, i16 183, i16 183, i16 183, i16 183, i16 183, i16 183, i16 332, i16 332, i16 183, i16 773, i16 419, i16 419, i16 937, i16 937, i16 548, i16 840, i16 1924, i16 1924, i16 466, i16 739, i16 739, i16 453, i16 53, i16 618, i16 513, i16 688, i16 737, i16 746, i16 935, i16 183, i16 183, i16 183, i16 183, i16 183, i16 183, i16 183, i16 183, i16 183, i16 51, i16 183, i16 183, i16 183, i16 183, i16 183, i16 183, i16 183, i16 183, i16 183, i16 183, i16 715, i16 715, i16 715, i16 183, i16 183, i16 183, i16 183, i16 772, i16 183, i16 183, i16 183, i16 971, i16 1091, i16 183, i16 183, i16 1238, i16 183, i16 183, i16 183, i16 183, i16 183, i16 183, i16 183, i16 183, i16 714, i16 1132, i16 502, i16 398, i16 398, i16 398, i16 398, i16 1090, i16 502, i16 502, i16 909, i16 853, i16 896, i16 817, i16 1292, i16 300, i16 300, i16 1135, i16 1292, i16 1292, i16 1135, i16 1266, i16 1136, i16 1260, i16 1080, i16 1080, i16 1080, i16 300, i16 1062, i16 1062, i16 905, i16 1276, i16 1175, i16 1071, i16 1577, i16 1499, i16 1499, i16 1604, i16 1604, i16 1499, i16 1496, i16 1532, i16 1626, i16 1608, i16 1508, i16 1638, i16 1638, i16 1638, i16 1638, i16 1508, i16 1508, i16 1532, i16 1626, i16 1608, i16 1608, i16 1508, i16 1499, i16 1665, i16 1531, i16 1625, i16 1499, i16 1665, i16 1669, i16 1499, i16 1665, i16 1499, i16 1665, i16 1669, i16 1583, i16 1583, i16 1583, i16 1645, i16 1680, i16 1680, i16 1669, i16 1583, i16 1588, i16 1583, i16 1645, i16 1583, i16 1583, i16 1552, i16 1669, i16 1609, i16 1609, i16 1669, i16 1584, i16 1617, i16 1584, i16 1617, i16 1584, i16 1617, i16 1584, i16 1617, i16 1499, i16 1641, i16 1641, i16 1662, i16 1662, i16 1599, i16 1605, i16 1725, i16 1499, i16 1600, i16 1599, i16 1611, i16 1610, i16 1508, i16 1732, i16 1733, i16 1749, i16 1749, i16 1761, i16 1761, i16 1761, i16 1924, i16 1924, i16 1924, i16 1924, i16 1924, i16 1924, i16 1924, i16 1924, i16 1924, i16 1924, i16 1924, i16 1924, i16 20, i16 1178, i16 397, i16 1133, i16 1310, i16 1245, i16 385, i16 1184, i16 1327, i16 1335, i16 1431, i16 1440, i16 1497, i16 1511, i16 1516, i16 1518, i16 1312, i16 1268, i16 1435, i16 1385, i16 1341, i16 1523, i16 1525, i16 1423, i16 1507, i16 1164, i16 1252, i16 1536, i16 1538, i16 1362, i16 1404, i16 1781, i16 1783, i16 1628, i16 1777, i16 1695, i16 1779, i16 1773, i16 1774, i16 1661, i16 1652, i16 1673, i16 1778, i16 1663, i16 1786, i16 1806, i16 1670, i16 1659, i16 1681, i16 1750, i16 1775, i16 1666, i16 1760, i16 1762, i16 1763, i16 1764, i16 1690, i16 1705, i16 1787, i16 1683, i16 1819, i16 1818, i16 1802, i16 1712, i16 1671, i16 1758, i16 1804, i16 1765, i16 1753, i16 1790, i16 1693, i16 1721, i16 1811, i16 1816, i16 1820, i16 1708, i16 1715, i16 1821, i16 1780, i16 1822, i16 1823, i16 1817, i16 1824, i16 1782, i16 1789, i16 1826, i16 1745, i16 1814, i16 1829, i16 1785, i16 1825, i16 1830, i16 1707, i16 1833, i16 1834, i16 1835, i16 1836, i16 1837, i16 1838, i16 1842, i16 1832, i16 1843, i16 1845, i16 1841, i16 1729, i16 1846, i16 1847, i16 1746, i16 1839, i16 1849, i16 1731, i16 1848, i16 1844, i16 1850, i16 1851, i16 1852, i16 1788, i16 1800, i16 1791, i16 1853, i16 1805, i16 1794, i16 1854, i16 1856, i16 1859, i16 1858, i16 1857, i16 1863, i16 1860, i16 1867, i16 1848, i16 1868, i16 1869, i16 1870, i16 1872, i16 1873, i16 1875, i16 1874, i16 1889, i16 1879, i16 1880, i16 1881, i16 1882, i16 1884, i16 1885, i16 1877, i16 1776, i16 1769, i16 1771, i16 1772, i16 1784, i16 1890, i16 1897, i16 1913, i16 1914], align 16
@yy_reduce_ofst = local_unnamed_addr constant [380 x i16] [i16 -66, i16 490, i16 645, i16 545, i16 -174, i16 -172, i16 -187, i16 -178, i16 -113, i16 -176, i16 430, i16 537, i16 -63, i16 -136, i16 25, i16 -261, i16 37, i16 412, i16 803, i16 828, i16 872, i16 -171, i16 888, i16 892, i16 106, i16 589, i16 921, i16 -189, i16 670, i16 926, i16 -177, i16 196, i16 386, i16 395, i16 694, i16 855, i16 945, i16 948, i16 955, i16 964, i16 966, i16 969, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -147, i16 696, i16 726, i16 801, i16 820, i16 822, i16 928, i16 961, i16 1007, i16 1021, i16 1028, i16 1031, i16 1040, i16 1057, i16 1059, i16 1074, i16 1092, i16 1108, i16 1110, i16 1116, i16 1123, i16 1134, i16 1137, i16 1149, i16 1153, i16 1170, i16 1173, i16 1177, i16 1181, i16 1183, i16 1194, i16 1208, i16 1212, i16 1218, i16 1221, i16 1223, i16 1229, i16 1256, i16 1280, i16 1283, i16 1285, i16 1287, i16 1300, i16 1304, i16 1313, i16 1316, i16 1320, i16 1324, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -175, i16 -22, i16 394, i16 150, i16 220, i16 -180, i16 493, i16 663, i16 299, i16 493, i16 663, i16 193, i16 120, i16 336, i16 -264, i16 -264, i16 -264, i16 -264, i16 90, i16 90, i16 90, i16 436, i16 482, i16 8, i16 647, i16 889, i16 -160, i16 373, i16 -278, i16 554, i16 598, i16 653, i16 697, i16 717, i16 557, i16 393, i16 602, i16 723, i16 808, i16 450, i16 655, i16 802, i16 908, i16 916, i16 864, i16 1041, i16 868, i16 337, i16 870, i16 503, i16 1104, i16 552, i16 641, i16 -157, i16 32, i16 862, i16 968, i16 1050, i16 1195, i16 603, i16 1048, i16 963, i16 433, i16 -210, i16 -201, i16 -89, i16 -9, i16 55, i16 159, i16 320, i16 389, i16 454, i16 522, i16 594, i16 608, i16 666, i16 848, i16 924, i16 957, i16 1067, i16 1075, i16 1140, i16 1154, i16 747, i16 1167, i16 1191, i16 1220, i16 1222, i16 1226, i16 1239, i16 1263, i16 1275, i16 1286, i16 1290, i16 1146, i16 1234, i16 1269, i16 1319, i16 1330, i16 1349, i16 1358, i16 1228, i16 1364, i16 1365, i16 1366, i16 1271, i16 1022, i16 1371, i16 1379, i16 1338, i16 1382, i16 320, i16 1387, i16 1388, i16 1389, i16 1392, i16 1393, i16 1394, i16 1293, i16 1308, i16 1353, i16 1342, i16 1344, i16 1348, i16 1356, i16 1228, i16 1353, i16 1353, i16 1361, i16 1399, i16 1422, i16 1301, i16 1369, i16 1357, i16 1359, i16 1328, i16 1374, i16 1375, i16 1331, i16 1403, i16 1395, i16 1400, i16 1407, i16 1408, i16 1409, i16 1372, i16 1381, i16 1383, i16 1355, i16 1390, i16 1391, i16 1444, i16 1350, i16 1443, i16 1445, i16 1360, i16 1363, i16 1447, i16 1370, i16 1384, i16 1396, i16 1424, i16 1413, i16 1425, i16 1429, i16 1430, i16 1432, i16 1433, i16 1434, i16 1398, i16 1402, i16 1441, i16 1442, i16 1436, i16 1480, i16 1489, i16 1405, i16 1410, i16 1493, i16 1495, i16 1477, i16 1498, i16 1500, i16 1501, i16 1504, i16 1485, i16 1502, i16 1503, i16 1505, i16 1488, i16 1492, i16 1494, i16 1506, i16 1510, i16 1509, i16 1512, i16 1513, i16 1514, i16 1515, i16 1420, i16 1517, i16 1446, i16 1454, i16 1520, i16 1463, i16 1476, i16 1478, i16 1482, i16 1483, i16 1486, i16 1484, i16 1487, i16 1547, i16 1449, i16 1450, i16 1490, i16 1519, i16 1521, i16 1524, i16 1491, i16 1557, i16 1522, i16 1526, i16 1527, i16 1530, i16 1528, i16 1559, i16 1562, i16 1573, i16 1574, i16 1585, i16 1586, i16 1587, i16 1575, i16 1568, i16 1570, i16 1572, i16 1576, i16 1579, i16 1565, i16 1566, i16 1578, i16 1580, i16 1582, i16 1589], align 16
@yy_default = local_unnamed_addr constant [535 x i16] [i16 1523, i16 1523, i16 1372, i16 1523, i16 1149, i16 1258, i16 1149, i16 1149, i16 1149, i16 1372, i16 1372, i16 1372, i16 1149, i16 1288, i16 1288, i16 1425, i16 1180, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1371, i16 1149, i16 1149, i16 1149, i16 1149, i16 1448, i16 1448, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1297, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1373, i16 1374, i16 1149, i16 1149, i16 1149, i16 1424, i16 1426, i16 1389, i16 1307, i16 1306, i16 1305, i16 1304, i16 1407, i16 1275, i16 1302, i16 1295, i16 1299, i16 1367, i16 1368, i16 1366, i16 1370, i16 1374, i16 1373, i16 1149, i16 1298, i16 1338, i16 1352, i16 1337, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1346, i16 1351, i16 1357, i16 1350, i16 1347, i16 1340, i16 1339, i16 1341, i16 1342, i16 1149, i16 1222, i16 1149, i16 1149, i16 1149, i16 1149, i16 1436, i16 1435, i16 1170, i16 1149, i16 1149, i16 1180, i16 1332, i16 1331, i16 1343, i16 1344, i16 1354, i16 1353, i16 1432, i16 1483, i16 1482, i16 1390, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1448, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1448, i16 1448, i16 1149, i16 1180, i16 1448, i16 1448, i16 1176, i16 1176, i16 1282, i16 1149, i16 1258, i16 1249, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1429, i16 1427, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1254, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1477, i16 1149, i16 1402, i16 1236, i16 1254, i16 1254, i16 1254, i16 1254, i16 1256, i16 1237, i16 1235, i16 1248, i16 1181, i16 1156, i16 1521, i16 1301, i16 1277, i16 1277, i16 1518, i16 1301, i16 1301, i16 1518, i16 1197, i16 1499, i16 1192, i16 1288, i16 1288, i16 1288, i16 1277, i16 1282, i16 1282, i16 1369, i16 1255, i16 1248, i16 1149, i16 1521, i16 1263, i16 1263, i16 1520, i16 1520, i16 1263, i16 1390, i16 1310, i16 1316, i16 1225, i16 1301, i16 1231, i16 1231, i16 1231, i16 1231, i16 1301, i16 1301, i16 1310, i16 1316, i16 1225, i16 1225, i16 1301, i16 1263, i16 1167, i16 1406, i16 1515, i16 1263, i16 1167, i16 1380, i16 1263, i16 1167, i16 1263, i16 1167, i16 1380, i16 1223, i16 1223, i16 1223, i16 1212, i16 1149, i16 1149, i16 1380, i16 1223, i16 1197, i16 1223, i16 1212, i16 1223, i16 1223, i16 1466, i16 1380, i16 1384, i16 1384, i16 1380, i16 1281, i16 1276, i16 1281, i16 1276, i16 1281, i16 1276, i16 1281, i16 1276, i16 1263, i16 1458, i16 1458, i16 1291, i16 1291, i16 1296, i16 1282, i16 1375, i16 1263, i16 1149, i16 1296, i16 1294, i16 1292, i16 1301, i16 1173, i16 1215, i16 1480, i16 1480, i16 1476, i16 1476, i16 1476, i16 1492, i16 1180, i16 1180, i16 1180, i16 1180, i16 1492, i16 1199, i16 1199, i16 1181, i16 1181, i16 1180, i16 1492, i16 1149, i16 1149, i16 1149, i16 1149, i16 1487, i16 1391, i16 1267, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1321, i16 1149, i16 1152, i16 1149, i16 1149, i16 1433, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1268, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1517, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1405, i16 1404, i16 1149, i16 1149, i16 1265, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1195, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1293, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1463, i16 1283, i16 1149, i16 1149, i16 1508, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1503, i16 1239, i16 1323, i16 1149, i16 1322, i16 1326, i16 1149, i16 1161, i16 1149, i16 1149], align 16
@yyFallback = local_unnamed_addr constant <{ [100 x i16], [81 x i16] }> <{ [100 x i16] [i16 0, i16 0, i16 59, i16 59, i16 59, i16 59, i16 0, i16 59, i16 59, i16 59, i16 0, i16 59, i16 59, i16 59, i16 59, i16 0, i16 0, i16 0, i16 59, i16 0, i16 0, i16 59, i16 0, i16 0, i16 0, i16 59, i16 0, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 0, i16 0, i16 0, i16 59, i16 59, i16 0, i16 0, i16 0, i16 0, i16 0, i16 0, i16 0, i16 0, i16 0, i16 0, i16 0, i16 0, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59], [81 x i16] zeroinitializer }>, align 16
@.str.479 = private unnamed_addr constant [22 x i8] c"parser stack overflow\00", align 1
@yyRuleInfoLhs = local_unnamed_addr constant [372 x i16] [i16 185, i16 185, i16 184, i16 186, i16 187, i16 187, i16 187, i16 187, i16 186, i16 186, i16 186, i16 186, i16 186, i16 191, i16 193, i16 195, i16 195, i16 194, i16 194, i16 192, i16 192, i16 199, i16 199, i16 201, i16 203, i16 203, i16 203, i16 204, i16 208, i16 209, i16 210, i16 210, i16 210, i16 210, i16 210, i16 210, i16 210, i16 210, i16 210, i16 210, i16 210, i16 210, i16 210, i16 219, i16 219, i16 215, i16 215, i16 217, i16 217, i16 220, i16 220, i16 220, i16 220, i16 221, i16 221, i16 221, i16 221, i16 221, i16 218, i16 218, i16 222, i16 222, i16 222, i16 198, i16 224, i16 225, i16 225, i16 225, i16 225, i16 225, i16 228, i16 213, i16 213, i16 229, i16 229, i16 230, i16 230, i16 186, i16 232, i16 232, i16 186, i16 186, i16 186, i16 200, i16 200, i16 200, i16 234, i16 237, i16 237, i16 237, i16 235, i16 235, i16 247, i16 247, i16 238, i16 238, i16 238, i16 249, i16 239, i16 239, i16 239, i16 250, i16 250, i16 240, i16 240, i16 252, i16 252, i16 251, i16 251, i16 251, i16 251, i16 196, i16 196, i16 233, i16 233, i16 258, i16 258, i16 258, i16 258, i16 253, i16 253, i16 253, i16 253, i16 255, i16 255, i16 254, i16 254, i16 254, i16 256, i16 256, i16 244, i16 244, i16 226, i16 226, i16 214, i16 214, i16 214, i16 260, i16 260, i16 260, i16 242, i16 242, i16 243, i16 243, i16 245, i16 245, i16 245, i16 245, i16 186, i16 241, i16 241, i16 186, i16 262, i16 262, i16 262, i16 262, i16 186, i16 186, i16 265, i16 265, i16 265, i16 265, i16 263, i16 263, i16 264, i16 264, i16 259, i16 259, i16 212, i16 212, i16 212, i16 212, i16 212, i16 211, i16 211, i16 211, i16 212, i16 212, i16 212, i16 212, i16 212, i16 212, i16 212, i16 211, i16 212, i16 212, i16 212, i16 212, i16 212, i16 212, i16 212, i16 212, i16 212, i16 267, i16 212, i16 212, i16 212, i16 212, i16 212, i16 212, i16 212, i16 212, i16 212, i16 268, i16 268, i16 212, i16 269, i16 269, i16 212, i16 212, i16 212, i16 212, i16 212, i16 212, i16 272, i16 272, i16 273, i16 273, i16 271, i16 271, i16 257, i16 248, i16 248, i16 270, i16 270, i16 186, i16 274, i16 274, i16 216, i16 216, i16 227, i16 227, i16 275, i16 275, i16 186, i16 186, i16 186, i16 276, i16 276, i16 186, i16 186, i16 186, i16 186, i16 186, i16 206, i16 207, i16 186, i16 278, i16 280, i16 280, i16 280, i16 281, i16 281, i16 281, i16 283, i16 283, i16 279, i16 279, i16 285, i16 286, i16 286, i16 284, i16 284, i16 284, i16 284, i16 212, i16 212, i16 231, i16 231, i16 231, i16 186, i16 186, i16 186, i16 288, i16 288, i16 186, i16 186, i16 186, i16 186, i16 186, i16 186, i16 289, i16 186, i16 261, i16 261, i16 236, i16 236, i16 291, i16 291, i16 292, i16 293, i16 293, i16 293, i16 293, i16 293, i16 293, i16 294, i16 294, i16 294, i16 298, i16 300, i16 300, i16 301, i16 301, i16 299, i16 299, i16 302, i16 302, i16 303, i16 303, i16 303, i16 246, i16 266, i16 266, i16 266, i16 297, i16 297, i16 296, i16 181, i16 182, i16 182, i16 183, i16 183, i16 183, i16 188, i16 188, i16 188, i16 190, i16 190, i16 186, i16 197, i16 197, i16 189, i16 189, i16 189, i16 203, i16 204, i16 205, i16 205, i16 202, i16 202, i16 210, i16 210, i16 210, i16 198, i16 223, i16 223, i16 224, i16 228, i16 230, i16 234, i16 235, i16 249, i16 250, i16 212, i16 267, i16 257, i16 277, i16 277, i16 277, i16 277, i16 277, i16 206, i16 282, i16 282, i16 285, i16 286, i16 287, i16 287, i16 290, i16 290, i16 261], align 16
@yyRuleInfoNRhs = local_unnamed_addr constant [372 x i8] c"\FF\FD\FF\FD\00\FF\FF\FF\FE\FE\FE\FD\FB\FA\FF\00\FD\FF\00\FB\FE\00\FE\FE\00\FC\FA\FE\00\00\FE\FD\FC\FC\FC\FD\FD\FB\FE\FC\FC\FF\FE\FD\FC\00\FF\00\FE\FE\FD\FD\FD\FE\FE\FF\FF\FE\FD\FE\00\FE\FE\00\FF\FE\F9\FB\FB\F6\00\00\FD\00\FE\FF\FF\FC\FE\00\F7\FC\FF\FD\FC\FF\FD\FF\FE\FF\F7\F6\FC\FB\FF\FF\00\00\FB\FD\FB\FE\00\00\FE\FE\00\F9\F7\F9\F9\00\FE\FF\FD\FF\FD\FB\FD\FF\FE\FD\FC\FE\00\00\FD\FE\FC\00\00\FD\FB\FD\FF\FF\00\FE\FE\00\00\FD\00\FE\00\FE\FC\FC\FA\00\FE\F8\FB\F9\FD\FB\F9\F9\00\F5\F8\FC\FE\FF\00\FD\FD\FF\FD\FF\FF\FD\FB\FF\FF\FF\FF\FD\FA\FB\FC\FA\FB\FF\FB\FD\FD\FD\FD\FD\FD\FD\FD\FE\FD\FB\FE\FD\FD\FC\FE\FE\FE\FF\FE\FB\FF\FE\FB\FD\FB\FB\FC\FB\FB\FC\FE\00\FF\00\00\FD\FF\00\FD\F4\FF\00\00\FD\FB\FD\00\FE\FC\FE\FD\FE\00\FD\FB\FA\FB\FA\FE\FE\FB\F5\FF\FE\00\FF\FF\FD\00\FE\FD\FE\FD\FD\FE\F8\F8\FA\FD\FC\FA\FF\FF\FF\FC\FA\FD\00\FE\FF\FD\FF\FD\FA\F9\FF\F8\FE\FD\FA\F8\FF\FD\FB\FB\FA\FC\FB\FF\FE\00\FD\FA\FF\FF\FE\FF\FE\FE\FE\00\FE\FE\FE\FF\FE\FE\FF\FF\FC\FE\FB\FF\FE\FF\FF\FE\FD\00\FF\FE\FF\00\FE\FC\FE\FF\FF\FF\FF\FF\FF\FF\FE\00\FE\FC\FE\FE\FD\FF\00\FF\FF\FF\FF\FE\FF\FF\FF\FF\FF\FF\FF\FF\FF\FF\00\FD\FF\00\FF\00\00\FF\00", align 16
@.str.480 = private unnamed_addr constant [27 x i8] c"unknown table option: %.*s\00", align 1
@__const.yy_reduce.dest = private unnamed_addr constant %struct.SelectDest { i8 9, i32 0, i32 0, i32 0, i8* null, %struct.ExprList* null }, align 8
@.str.481 = private unnamed_addr constant [9 x i8] c"set list\00", align 1
@.str.482 = private unnamed_addr constant [24 x i8] c"near \22%T\22: syntax error\00", align 1
@.str.483 = private unnamed_addr constant [2 x i8] c"0\00", align 1
@.str.484 = private unnamed_addr constant [95 x i8] c"qualified table names are not allowed on INSERT, UPDATE, and DELETE statements within triggers\00", align 1
@.str.485 = private unnamed_addr constant [84 x i8] c"the INDEXED BY clause is not allowed on UPDATE or DELETE statements within triggers\00", align 1
@.str.486 = private unnamed_addr constant [85 x i8] c"the NOT INDEXED clause is not allowed on UPDATE or DELETE statements within triggers\00", align 1
@.str.487 = private unnamed_addr constant [17 x i8] c"incomplete input\00", align 1
@aiClass = local_unnamed_addr constant [256 x i8] c"\1C\1B\1B\1B\1B\1B\1B\1B\1B\07\07\1B\07\07\1B\1B\1B\1B\1B\1B\1B\1B\1B\1B\1B\1B\1B\1B\1B\1B\1B\1B\07\0F\08\05\04\16\18\08\11\12\15\14\17\0B\1A\10\03\03\03\03\03\03\03\03\03\03\05\13\0C\0E\0D\06\05\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\00\01\01\09\1B\1B\1B\01\08\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\00\01\01\1B\0A\1B\19\1B\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02", align 16
@zKWText = constant [647 x i8] c"REINDEXEDESCAPEACHECKEYBEFOREIGNOREGEXPLAINSTEADDATABASELECTABLEFTHENDEFERRABLELSEXCLUDELETEMPORARYISNULLSAVEPOINTERSECTIESNOTNULLIKEXCEPTRANSACTIONATURALTERAISEXCLUSIVEXISTSCONSTRAINTOFFSETRIGGERANGENERATEDETACHAVINGLOBEGINNEREFERENCESUNIQUERYWITHOUTERELEASEATTACHBETWEENOTHINGROUPSCASCADEFAULTCASECOLLATECREATECURRENT_DATEIMMEDIATEJOINSERTMATCHPLANALYZEPRAGMABORTUPDATEVALUESVIRTUALWAYSWHENWHERECURSIVEAFTERENAMEANDEFERREDISTINCTAUTOINCREMENTCASTCOLUMNCOMMITCONFLICTCROSSCURRENT_TIMESTAMPARTITIONDROPRECEDINGFAILASTFILTEREPLACEFIRSTFOLLOWINGFROMFULLIMITIFORDERESTRICTOTHERSOVERIGHTROLLBACKROWSUNBOUNDEDUNIONUSINGVACUUMVIEWINDOWBYINITIALLYPRIMARY", align 16
@aKWHash = local_unnamed_addr constant [127 x i8] c"Tf\84Rr\1D\00\00[\00UH\005#V\0F\00*^6~\85\13\00\00\8A\00(\80\00\16h\00\09\00\00zP\00N\06\00Ac\91\00\86p\00\000\00d\18\00\11\00\1BF\17\1A\05<\8Cky\00IeG\8F=wJ\001\00\0B)\00n\00\00\00j\0Alq|\0E2{\00Y\00\12x\8E8\81\89XS%\1E}\00\00i3\82\7F\00\22\00\00,\00_&'\00\14-tZ", align 16
@aKWNext = local_unnamed_addr constant [145 x i8] c"\00\00\00\00\04\00+\00\00go\00\00\00\02\00\00\8D\00\00\00\0D\00\00\00\00\8B\00\00v4\00\00\87\0C\00\00>\00\88\00\83\00\00$\00\00\1CM\00\00\00\00;\00/\00\00\00\00\00\00\00\00\00\00E\00\00\00\00\00\90\03\00:\00\01K\00\00\00\1F\00\00\00\00\00\00@B?\00\00\00\00.\00\10\00s\00\00\00\00\00\00\00\00\00\00Qa\00\08\00m\15\07C\00O]u\00\00D\00\00`\007\00L\00\\ !9\19\00b\00\00W", align 16
@aKWLen = local_unnamed_addr constant [145 x i8] c"\07\07\05\04\06\04\05\03\06\07\03\06\06\07\07\03\08\02\06\05\04\04\03\0A\04\07\06\09\04\02\06\05\09\09\04\07\03\02\04\04\06\0B\06\02\07\05\05\09\06\0A\04\06\02\03\07\05\09\06\06\04\05\05\0A\06\05\07\04\05\07\06\07\07\06\05\07\03\07\04\07\06\0C\09\04\06\05\04\07\06\05\06\06\07\06\04\05\09\05\06\03\08\08\02\0D\02\02\04\06\06\08\05\11\0C\07\09\04\09\04\04\06\07\05\09\04\04\05\02\05\08\06\04\05\08\04\03\09\05\05\06\04\06\02\02\09\03\07", align 16
@aKWOffset = local_unnamed_addr constant [145 x i16] [i16 0, i16 2, i16 2, i16 8, i16 9, i16 14, i16 16, i16 20, i16 23, i16 25, i16 25, i16 29, i16 33, i16 36, i16 41, i16 46, i16 48, i16 53, i16 54, i16 59, i16 62, i16 65, i16 67, i16 69, i16 78, i16 81, i16 86, i16 90, i16 90, i16 94, i16 99, i16 101, i16 105, i16 111, i16 119, i16 123, i16 123, i16 123, i16 126, i16 129, i16 132, i16 137, i16 142, i16 146, i16 147, i16 152, i16 156, i16 160, i16 168, i16 174, i16 181, i16 184, i16 184, i16 187, i16 189, i16 195, i16 198, i16 206, i16 211, i16 216, i16 219, i16 222, i16 226, i16 236, i16 239, i16 244, i16 244, i16 248, i16 252, i16 259, i16 265, i16 271, i16 277, i16 277, i16 283, i16 284, i16 288, i16 295, i16 299, i16 306, i16 312, i16 324, i16 333, i16 335, i16 341, i16 346, i16 348, i16 355, i16 360, i16 365, i16 371, i16 377, i16 382, i16 388, i16 392, i16 395, i16 404, i16 408, i16 414, i16 416, i16 423, i16 424, i16 431, i16 433, i16 435, i16 444, i16 448, i16 454, i16 460, i16 468, i16 473, i16 473, i16 473, i16 489, i16 498, i16 501, i16 510, i16 513, i16 517, i16 522, i16 529, i16 534, i16 543, i16 547, i16 550, i16 555, i16 557, i16 561, i16 569, i16 575, i16 578, i16 583, i16 591, i16 591, i16 595, i16 604, i16 609, i16 614, i16 620, i16 623, i16 626, i16 629, i16 631, i16 636, i16 640], align 16
@aKWCode = local_unnamed_addr constant [145 x i8] c"ar\9E':)zC!\82>?/\02A\A0&\18\88\10t\9C\0B\81\9D[~\15\15+2R\0D\87^3\13Bw/\86\06\1Cqt\9FG\09\14u\94ED\80MY_(\91/\05t{y\03\19Qt\0E 0\95\\\90#\1Fv\9Ao\11c\08\8D}.\04\1EF\1B\7F\89P`\9B\93H\1Db,\07\8A-|\0F1$<\0A%tccUW\83X*T\A3ISV\8Ct\92\12\8FJ]\A2t\0CLKZ\84\8ENO\A1=\22@\85x", align 16
@sqlite3_complete.trans = internal unnamed_addr constant [8 x [8 x i8]] [[8 x i8] c"\01\00\02\03\04\02\02\02", [8 x i8] c"\01\01\02\03\04\02\02\02", [8 x i8] c"\01\02\02\02\02\02\02\02", [8 x i8] c"\01\03\03\02\04\02\02\02", [8 x i8] c"\01\04\02\02\02\04\05\02", [8 x i8] c"\06\05\05\05\05\05\05\05", [8 x i8] c"\06\06\05\05\05\05\05\07", [8 x i8] c"\01\07\05\05\05\05\05\05"], align 16
@.str.488 = private unnamed_addr constant [7 x i8] c"create\00", align 1
@.str.489 = private unnamed_addr constant [8 x i8] c"trigger\00", align 1
@.str.490 = private unnamed_addr constant [5 x i8] c"temp\00", align 1
@.str.491 = private unnamed_addr constant [10 x i8] c"temporary\00", align 1
@.str.492 = private unnamed_addr constant [4 x i8] c"end\00", align 1
@.str.493 = private unnamed_addr constant [8 x i8] c"explain\00", align 1
@sqlite3_data_directory = local_unnamed_addr global i8* null, align 8
@sqlite3BuiltinFunctions = internal unnamed_addr global %struct.FuncDefHash zeroinitializer, align 8
@sqlite3_db_config.aFlagOp = internal unnamed_addr constant [16 x %struct.anon.22] [%struct.anon.22 { i32 1002, i32 16384 }, %struct.anon.22 { i32 1003, i32 262144 }, %struct.anon.22 { i32 1015, i32 -2147483648 }, %struct.anon.22 { i32 1004, i32 4194304 }, %struct.anon.22 { i32 1005, i32 65536 }, %struct.anon.22 { i32 1006, i32 2048 }, %struct.anon.22 { i32 1007, i32 8388608 }, %struct.anon.22 { i32 1008, i32 16777216 }, %struct.anon.22 { i32 1009, i32 33554432 }, %struct.anon.22 { i32 1010, i32 268435456 }, %struct.anon.22 { i32 1011, i32 134217729 }, %struct.anon.22 { i32 1012, i32 67108864 }, %struct.anon.22 { i32 1014, i32 536870912 }, %struct.anon.22 { i32 1013, i32 1073741824 }, %struct.anon.22 { i32 1016, i32 2 }, %struct.anon.22 { i32 1017, i32 128 }], align 16
@.str.494 = private unnamed_addr constant [21 x i8] c"unknown database: %s\00", align 1
@sqlite3_errmsg16.outOfMem = internal constant [14 x i16] [i16 111, i16 117, i16 116, i16 32, i16 111, i16 102, i16 32, i16 109, i16 101, i16 109, i16 111, i16 114, i16 121, i16 0], align 16
@sqlite3_errmsg16.misuse = internal constant [34 x i16] [i16 98, i16 97, i16 100, i16 32, i16 112, i16 97, i16 114, i16 97, i16 109, i16 101, i16 116, i16 101, i16 114, i16 32, i16 111, i16 114, i16 32, i16 111, i16 116, i16 104, i16 101, i16 114, i16 32, i16 65, i16 80, i16 73, i16 32, i16 109, i16 105, i16 115, i16 117, i16 115, i16 101, i16 0], align 16
@.str.495 = private unnamed_addr constant [68 x i8] c"unable to delete/modify collation sequence due to active statements\00", align 1
@aHardLimit = constant [12 x i32] [i32 1000000000, i32 1000000000, i32 2000, i32 1000, i32 500, i32 250000000, i32 127, i32 10, i32 50000, i32 32766, i32 1000, i32 8], align 16
@.str.496 = private unnamed_addr constant [6 x i8] c"RTRIM\00", align 1
@.str.497 = private unnamed_addr constant [5 x i8] c"main\00", align 1
@.str.498 = private unnamed_addr constant [3 x i8] zeroinitializer, align 1
@.str.499 = private unnamed_addr constant [28 x i8] c"no such table column: %s.%s\00", align 1
@.str.500 = private unnamed_addr constant [8 x i8] c"SQLITE_\00", align 1
@.str.501 = private unnamed_addr constant [85 x i8] c"2020-03-11 19:56:26 c5f96a085db9688a09793f52ce1ecf033c2e6e2e5873a19fe0fb374b242balt1\00", align 1
@_sqliteZone_ = local_unnamed_addr global %struct._malloc_zone_t* null, align 8
@top_of_stack = local_unnamed_addr global i64 0, align 8
@sqlite3Utf8Trans1 = internal unnamed_addr constant [64 x i8] c"\00\01\02\03\04\05\06\07\08\09\0A\0B\0C\0D\0E\0F\10\11\12\13\14\15\16\17\18\19\1A\1B\1C\1D\1E\1F\00\01\02\03\04\05\06\07\08\09\0A\0B\0C\0D\0E\0F\00\01\02\03\04\05\06\07\00\01\02\03\00\01\00\00", align 16
@sqlite3PagerFilename.zFake = internal constant [8 x i8] zeroinitializer, align 1
@sqlite3VdbeSerialGet.aFlag = internal unnamed_addr constant [2 x i16] [i16 4112, i16 4098], align 2
@.str.502 = private unnamed_addr constant [19 x i8] c"a CHECK constraint\00", align 1
@.str.503 = private unnamed_addr constant [19 x i8] c"a generated column\00", align 1
@.str.504 = private unnamed_addr constant [9 x i8] c"an index\00", align 1
@.str.505 = private unnamed_addr constant [36 x i8] c"non-deterministic use of %s() in %s\00", align 1
@.str.506 = private unnamed_addr constant [35 x i8] c"sqlite3VdbeRealValue: NO FLAG SET\0A\00", align 1
@.str.507 = private unnamed_addr constant [5 x i8] c"%.2x\00", align 1
@sqlite3OpcodeName.azName = internal unnamed_addr constant [176 x i8*] [i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.508, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.509, i32 0, i32 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.510, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.511, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.512, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.513, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.514, i32 0, i32 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.515, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.516, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.517, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.518, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.519, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.520, i32 0, i32 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.521, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.522, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.523, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.524, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.525, i32 0, i32 0), i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.526, i32 0, i32 0), i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.527, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.528, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.529, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.530, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.531, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.532, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.533, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.534, i32 0, i32 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.535, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.536, i32 0, i32 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.537, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.538, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.539, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.540, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.541, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.542, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.543, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.544, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.545, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.546, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.547, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.548, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.549, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.550, i32 0, i32 0), i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.551, i32 0, i32 0), i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.552, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.553, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.554, i32 0, i32 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.555, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.556, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.557, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.558, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.559, i32 0, i32 0), i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.560, i32 0, i32 0), i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.561, i32 0, i32 0), i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.562, i32 0, i32 0), i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.563, i32 0, i32 0), i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.564, i32 0, i32 0), i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.565, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.566, i32 0, i32 0), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.567, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.568, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.569, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.570, i32 0, i32 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.571, i32 0, i32 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.572, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.573, i32 0, i32 0), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.574, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.575, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.576, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.577, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.578, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.579, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.580, i32 0, i32 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.581, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.582, i32 0, i32 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.583, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.584, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.585, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.586, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.587, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.588, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.589, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.590, i32 0, i32 0), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.591, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.592, i32 0, i32 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.593, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.594, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.595, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.596, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.597, i32 0, i32 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.598, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.599, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.600, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.601, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.602, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.603, i32 0, i32 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.604, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.605, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.606, i32 0, i32 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.607, i32 0, i32 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.608, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.609, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.610, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.611, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.612, i32 0, i32 0), i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.613, i32 0, i32 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.614, i32 0, i32 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.615, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.616, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.617, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.618, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.619, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.620, i32 0, i32 0), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.621, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.622, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.623, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.624, i32 0, i32 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.625, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.626, i32 0, i32 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.627, i32 0, i32 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.628, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.629, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.630, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.631, i32 0, i32 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.632, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.633, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.634, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.635, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.636, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.637, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.638, i32 0, i32 0), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.639, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.640, i32 0, i32 0), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.641, i32 0, i32 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.642, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.643, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.644, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.645, i32 0, i32 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.646, i32 0, i32 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.647, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.648, i32 0, i32 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.649, i32 0, i32 0), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.650, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.651, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.652, i32 0, i32 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.653, i32 0, i32 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.654, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.655, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.656, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.657, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.658, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.659, i32 0, i32 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.660, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.661, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.662, i32 0, i32 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.663, i32 0, i32 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.664, i32 0, i32 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.665, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.666, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.667, i32 0, i32 0), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.668, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.669, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.670, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.671, i32 0, i32 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.672, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.673, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.674, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.675, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.676, i32 0, i32 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.677, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.678, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.679, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.680, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.681, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.682, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.683, i32 0, i32 0)], align 16
@.str.508 = private unnamed_addr constant [10 x i8] c"Savepoint\00", align 1
@.str.509 = private unnamed_addr constant [11 x i8] c"AutoCommit\00", align 1
@.str.510 = private unnamed_addr constant [12 x i8] c"Transaction\00", align 1
@.str.511 = private unnamed_addr constant [11 x i8] c"SorterNext\00", align 1
@.str.512 = private unnamed_addr constant [5 x i8] c"Prev\00", align 1
@.str.513 = private unnamed_addr constant [5 x i8] c"Next\00", align 1
@.str.514 = private unnamed_addr constant [11 x i8] c"Checkpoint\00", align 1
@.str.515 = private unnamed_addr constant [12 x i8] c"JournalMode\00", align 1
@.str.516 = private unnamed_addr constant [7 x i8] c"Vacuum\00", align 1
@.str.517 = private unnamed_addr constant [8 x i8] c"VFilter\00", align 1
@.str.518 = private unnamed_addr constant [8 x i8] c"VUpdate\00", align 1
@.str.519 = private unnamed_addr constant [5 x i8] c"Goto\00", align 1
@.str.520 = private unnamed_addr constant [6 x i8] c"Gosub\00", align 1
@.str.521 = private unnamed_addr constant [14 x i8] c"InitCoroutine\00", align 1
@.str.522 = private unnamed_addr constant [6 x i8] c"Yield\00", align 1
@.str.523 = private unnamed_addr constant [10 x i8] c"MustBeInt\00", align 1
@.str.524 = private unnamed_addr constant [5 x i8] c"Jump\00", align 1
@.str.525 = private unnamed_addr constant [5 x i8] c"Once\00", align 1
@.str.526 = private unnamed_addr constant [3 x i8] c"If\00", align 1
@.str.527 = private unnamed_addr constant [4 x i8] c"Not\00", align 1
@.str.528 = private unnamed_addr constant [6 x i8] c"IfNot\00", align 1
@.str.529 = private unnamed_addr constant [10 x i8] c"IfNullRow\00", align 1
@.str.530 = private unnamed_addr constant [7 x i8] c"SeekLT\00", align 1
@.str.531 = private unnamed_addr constant [7 x i8] c"SeekLE\00", align 1
@.str.532 = private unnamed_addr constant [7 x i8] c"SeekGE\00", align 1
@.str.533 = private unnamed_addr constant [7 x i8] c"SeekGT\00", align 1
@.str.534 = private unnamed_addr constant [10 x i8] c"IfNotOpen\00", align 1
@.str.535 = private unnamed_addr constant [9 x i8] c"IfNoHope\00", align 1
@.str.536 = private unnamed_addr constant [11 x i8] c"NoConflict\00", align 1
@.str.537 = private unnamed_addr constant [9 x i8] c"NotFound\00", align 1
@.str.538 = private unnamed_addr constant [6 x i8] c"Found\00", align 1
@.str.539 = private unnamed_addr constant [10 x i8] c"SeekRowid\00", align 1
@.str.540 = private unnamed_addr constant [10 x i8] c"NotExists\00", align 1
@.str.541 = private unnamed_addr constant [5 x i8] c"Last\00", align 1
@.str.542 = private unnamed_addr constant [10 x i8] c"IfSmaller\00", align 1
@.str.543 = private unnamed_addr constant [11 x i8] c"SorterSort\00", align 1
@.str.544 = private unnamed_addr constant [5 x i8] c"Sort\00", align 1
@.str.545 = private unnamed_addr constant [7 x i8] c"Rewind\00", align 1
@.str.546 = private unnamed_addr constant [6 x i8] c"IdxLE\00", align 1
@.str.547 = private unnamed_addr constant [6 x i8] c"IdxGT\00", align 1
@.str.548 = private unnamed_addr constant [6 x i8] c"IdxLT\00", align 1
@.str.549 = private unnamed_addr constant [6 x i8] c"IdxGE\00", align 1
@.str.550 = private unnamed_addr constant [11 x i8] c"RowSetRead\00", align 1
@.str.551 = private unnamed_addr constant [3 x i8] c"Or\00", align 1
@.str.552 = private unnamed_addr constant [4 x i8] c"And\00", align 1
@.str.553 = private unnamed_addr constant [11 x i8] c"RowSetTest\00", align 1
@.str.554 = private unnamed_addr constant [8 x i8] c"Program\00", align 1
@.str.555 = private unnamed_addr constant [9 x i8] c"FkIfZero\00", align 1
@.str.556 = private unnamed_addr constant [6 x i8] c"IfPos\00", align 1
@.str.557 = private unnamed_addr constant [10 x i8] c"IfNotZero\00", align 1
@.str.558 = private unnamed_addr constant [7 x i8] c"IsNull\00", align 1
@.str.559 = private unnamed_addr constant [8 x i8] c"NotNull\00", align 1
@.str.560 = private unnamed_addr constant [3 x i8] c"Ne\00", align 1
@.str.561 = private unnamed_addr constant [3 x i8] c"Eq\00", align 1
@.str.562 = private unnamed_addr constant [3 x i8] c"Gt\00", align 1
@.str.563 = private unnamed_addr constant [3 x i8] c"Le\00", align 1
@.str.564 = private unnamed_addr constant [3 x i8] c"Lt\00", align 1
@.str.565 = private unnamed_addr constant [3 x i8] c"Ge\00", align 1
@.str.566 = private unnamed_addr constant [10 x i8] c"ElseNotEq\00", align 1
@.str.567 = private unnamed_addr constant [13 x i8] c"DecrJumpZero\00", align 1
@.str.568 = private unnamed_addr constant [11 x i8] c"IncrVacuum\00", align 1
@.str.569 = private unnamed_addr constant [6 x i8] c"VNext\00", align 1
@.str.570 = private unnamed_addr constant [5 x i8] c"Init\00", align 1
@.str.571 = private unnamed_addr constant [9 x i8] c"PureFunc\00", align 1
@.str.572 = private unnamed_addr constant [9 x i8] c"Function\00", align 1
@.str.573 = private unnamed_addr constant [7 x i8] c"Return\00", align 1
@.str.574 = private unnamed_addr constant [13 x i8] c"EndCoroutine\00", align 1
@.str.575 = private unnamed_addr constant [11 x i8] c"HaltIfNull\00", align 1
@.str.576 = private unnamed_addr constant [5 x i8] c"Halt\00", align 1
@.str.577 = private unnamed_addr constant [8 x i8] c"Integer\00", align 1
@.str.578 = private unnamed_addr constant [6 x i8] c"Int64\00", align 1
@.str.579 = private unnamed_addr constant [7 x i8] c"String\00", align 1
@.str.580 = private unnamed_addr constant [5 x i8] c"Null\00", align 1
@.str.581 = private unnamed_addr constant [9 x i8] c"SoftNull\00", align 1
@.str.582 = private unnamed_addr constant [5 x i8] c"Blob\00", align 1
@.str.583 = private unnamed_addr constant [9 x i8] c"Variable\00", align 1
@.str.584 = private unnamed_addr constant [5 x i8] c"Move\00", align 1
@.str.585 = private unnamed_addr constant [5 x i8] c"Copy\00", align 1
@.str.586 = private unnamed_addr constant [6 x i8] c"SCopy\00", align 1
@.str.587 = private unnamed_addr constant [8 x i8] c"IntCopy\00", align 1
@.str.588 = private unnamed_addr constant [10 x i8] c"ResultRow\00", align 1
@.str.589 = private unnamed_addr constant [8 x i8] c"CollSeq\00", align 1
@.str.590 = private unnamed_addr constant [7 x i8] c"AddImm\00", align 1
@.str.591 = private unnamed_addr constant [13 x i8] c"RealAffinity\00", align 1
@.str.592 = private unnamed_addr constant [5 x i8] c"Cast\00", align 1
@.str.593 = private unnamed_addr constant [12 x i8] c"Permutation\00", align 1
@.str.594 = private unnamed_addr constant [8 x i8] c"Compare\00", align 1
@.str.595 = private unnamed_addr constant [7 x i8] c"IsTrue\00", align 1
@.str.596 = private unnamed_addr constant [7 x i8] c"Offset\00", align 1
@.str.597 = private unnamed_addr constant [7 x i8] c"Column\00", align 1
@.str.598 = private unnamed_addr constant [9 x i8] c"Affinity\00", align 1
@.str.599 = private unnamed_addr constant [11 x i8] c"MakeRecord\00", align 1
@.str.600 = private unnamed_addr constant [6 x i8] c"Count\00", align 1
@.str.601 = private unnamed_addr constant [11 x i8] c"ReadCookie\00", align 1
@.str.602 = private unnamed_addr constant [10 x i8] c"SetCookie\00", align 1
@.str.603 = private unnamed_addr constant [10 x i8] c"ReopenIdx\00", align 1
@.str.604 = private unnamed_addr constant [9 x i8] c"OpenRead\00", align 1
@.str.605 = private unnamed_addr constant [10 x i8] c"OpenWrite\00", align 1
@.str.606 = private unnamed_addr constant [8 x i8] c"OpenDup\00", align 1
@.str.607 = private unnamed_addr constant [14 x i8] c"OpenAutoindex\00", align 1
@.str.608 = private unnamed_addr constant [14 x i8] c"OpenEphemeral\00", align 1
@.str.609 = private unnamed_addr constant [7 x i8] c"BitAnd\00", align 1
@.str.610 = private unnamed_addr constant [6 x i8] c"BitOr\00", align 1
@.str.611 = private unnamed_addr constant [10 x i8] c"ShiftLeft\00", align 1
@.str.612 = private unnamed_addr constant [11 x i8] c"ShiftRight\00", align 1
@.str.613 = private unnamed_addr constant [4 x i8] c"Add\00", align 1
@.str.614 = private unnamed_addr constant [9 x i8] c"Subtract\00", align 1
@.str.615 = private unnamed_addr constant [9 x i8] c"Multiply\00", align 1
@.str.616 = private unnamed_addr constant [7 x i8] c"Divide\00", align 1
@.str.617 = private unnamed_addr constant [10 x i8] c"Remainder\00", align 1
@.str.618 = private unnamed_addr constant [7 x i8] c"Concat\00", align 1
@.str.619 = private unnamed_addr constant [11 x i8] c"SorterOpen\00", align 1
@.str.620 = private unnamed_addr constant [7 x i8] c"BitNot\00", align 1
@.str.621 = private unnamed_addr constant [13 x i8] c"SequenceTest\00", align 1
@.str.622 = private unnamed_addr constant [11 x i8] c"OpenPseudo\00", align 1
@.str.623 = private unnamed_addr constant [8 x i8] c"String8\00", align 1
@.str.624 = private unnamed_addr constant [6 x i8] c"Close\00", align 1
@.str.625 = private unnamed_addr constant [12 x i8] c"ColumnsUsed\00", align 1
@.str.626 = private unnamed_addr constant [8 x i8] c"SeekHit\00", align 1
@.str.627 = private unnamed_addr constant [9 x i8] c"Sequence\00", align 1
@.str.628 = private unnamed_addr constant [9 x i8] c"NewRowid\00", align 1
@.str.629 = private unnamed_addr constant [7 x i8] c"Insert\00", align 1
@.str.630 = private unnamed_addr constant [7 x i8] c"Delete\00", align 1
@.str.631 = private unnamed_addr constant [11 x i8] c"ResetCount\00", align 1
@.str.632 = private unnamed_addr constant [14 x i8] c"SorterCompare\00", align 1
@.str.633 = private unnamed_addr constant [11 x i8] c"SorterData\00", align 1
@.str.634 = private unnamed_addr constant [8 x i8] c"RowData\00", align 1
@.str.635 = private unnamed_addr constant [6 x i8] c"Rowid\00", align 1
@.str.636 = private unnamed_addr constant [8 x i8] c"NullRow\00", align 1
@.str.637 = private unnamed_addr constant [8 x i8] c"SeekEnd\00", align 1
@.str.638 = private unnamed_addr constant [10 x i8] c"IdxInsert\00", align 1
@.str.639 = private unnamed_addr constant [13 x i8] c"SorterInsert\00", align 1
@.str.640 = private unnamed_addr constant [10 x i8] c"IdxDelete\00", align 1
@.str.641 = private unnamed_addr constant [13 x i8] c"DeferredSeek\00", align 1
@.str.642 = private unnamed_addr constant [9 x i8] c"IdxRowid\00", align 1
@.str.643 = private unnamed_addr constant [11 x i8] c"FinishSeek\00", align 1
@.str.644 = private unnamed_addr constant [8 x i8] c"Destroy\00", align 1
@.str.645 = private unnamed_addr constant [6 x i8] c"Clear\00", align 1
@.str.646 = private unnamed_addr constant [12 x i8] c"ResetSorter\00", align 1
@.str.647 = private unnamed_addr constant [12 x i8] c"CreateBtree\00", align 1
@.str.648 = private unnamed_addr constant [8 x i8] c"SqlExec\00", align 1
@.str.649 = private unnamed_addr constant [12 x i8] c"ParseSchema\00", align 1
@.str.650 = private unnamed_addr constant [13 x i8] c"LoadAnalysis\00", align 1
@.str.651 = private unnamed_addr constant [10 x i8] c"DropTable\00", align 1
@.str.652 = private unnamed_addr constant [10 x i8] c"DropIndex\00", align 1
@.str.653 = private unnamed_addr constant [12 x i8] c"DropTrigger\00", align 1
@.str.654 = private unnamed_addr constant [12 x i8] c"IntegrityCk\00", align 1
@.str.655 = private unnamed_addr constant [10 x i8] c"RowSetAdd\00", align 1
@.str.656 = private unnamed_addr constant [6 x i8] c"Param\00", align 1
@.str.657 = private unnamed_addr constant [10 x i8] c"FkCounter\00", align 1
@.str.658 = private unnamed_addr constant [5 x i8] c"Real\00", align 1
@.str.659 = private unnamed_addr constant [7 x i8] c"MemMax\00", align 1
@.str.660 = private unnamed_addr constant [12 x i8] c"OffsetLimit\00", align 1
@.str.661 = private unnamed_addr constant [11 x i8] c"AggInverse\00", align 1
@.str.662 = private unnamed_addr constant [8 x i8] c"AggStep\00", align 1
@.str.663 = private unnamed_addr constant [9 x i8] c"AggStep1\00", align 1
@.str.664 = private unnamed_addr constant [9 x i8] c"AggValue\00", align 1
@.str.665 = private unnamed_addr constant [9 x i8] c"AggFinal\00", align 1
@.str.666 = private unnamed_addr constant [7 x i8] c"Expire\00", align 1
@.str.667 = private unnamed_addr constant [11 x i8] c"CursorLock\00", align 1
@.str.668 = private unnamed_addr constant [13 x i8] c"CursorUnlock\00", align 1
@.str.669 = private unnamed_addr constant [10 x i8] c"TableLock\00", align 1
@.str.670 = private unnamed_addr constant [7 x i8] c"VBegin\00", align 1
@.str.671 = private unnamed_addr constant [8 x i8] c"VCreate\00", align 1
@.str.672 = private unnamed_addr constant [9 x i8] c"VDestroy\00", align 1
@.str.673 = private unnamed_addr constant [6 x i8] c"VOpen\00", align 1
@.str.674 = private unnamed_addr constant [8 x i8] c"VColumn\00", align 1
@.str.675 = private unnamed_addr constant [8 x i8] c"VRename\00", align 1
@.str.676 = private unnamed_addr constant [10 x i8] c"Pagecount\00", align 1
@.str.677 = private unnamed_addr constant [9 x i8] c"MaxPgcnt\00", align 1
@.str.678 = private unnamed_addr constant [6 x i8] c"Trace\00", align 1
@.str.679 = private unnamed_addr constant [11 x i8] c"CursorHint\00", align 1
@.str.680 = private unnamed_addr constant [11 x i8] c"ReleaseReg\00", align 1
@.str.681 = private unnamed_addr constant [5 x i8] c"Noop\00", align 1
@.str.682 = private unnamed_addr constant [8 x i8] c"Explain\00", align 1
@.str.683 = private unnamed_addr constant [10 x i8] c"Abortable\00", align 1
@sqlite3VdbeExec.azType = internal unnamed_addr constant [4 x i8*] [i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.684, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.685, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.686, i32 0, i32 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.687, i32 0, i32 0)], align 16
@.str.684 = private unnamed_addr constant [9 x i8] c"NOT NULL\00", align 1
@.str.685 = private unnamed_addr constant [7 x i8] c"UNIQUE\00", align 1
@.str.686 = private unnamed_addr constant [6 x i8] c"CHECK\00", align 1
@.str.687 = private unnamed_addr constant [12 x i8] c"FOREIGN KEY\00", align 1
@.str.688 = private unnamed_addr constant [21 x i8] c"%s constraint failed\00", align 1
@.str.689 = private unnamed_addr constant [7 x i8] c"%z: %s\00", align 1
@.str.690 = private unnamed_addr constant [24 x i8] c"abort at %d in [%s]: %s\00", align 1
@sqlite3VdbeExec.aLTb = internal unnamed_addr constant [6 x i8] c"\01\00\00\01\01\00", align 1
@sqlite3VdbeExec.aEQb = internal unnamed_addr constant [6 x i8] c"\00\01\00\01\00\01", align 1
@sqlite3VdbeExec.aGTb = internal unnamed_addr constant [6 x i8] c"\01\00\01\00\00\01", align 1
@sqlite3VdbeExec.and_logic = internal unnamed_addr constant [9 x i8] c"\00\00\00\00\01\02\00\02\02", align 1
@sqlite3VdbeExec.or_logic = internal unnamed_addr constant [9 x i8] c"\00\01\02\01\01\01\02\01\02", align 1
@sqlite3VdbeExec.aFlag = internal unnamed_addr constant [2 x i16] [i16 16, i16 514], align 2
@.str.691 = private unnamed_addr constant [51 x i8] c"cannot open savepoint - SQL statements in progress\00", align 1
@.str.692 = private unnamed_addr constant [22 x i8] c"no such savepoint: %s\00", align 1
@.str.693 = private unnamed_addr constant [54 x i8] c"cannot release savepoint - SQL statements in progress\00", align 1
@.str.694 = private unnamed_addr constant [55 x i8] c"cannot commit transaction - SQL statements in progress\00", align 1
@.str.695 = private unnamed_addr constant [48 x i8] c"cannot start a transaction within a transaction\00", align 1
@.str.696 = private unnamed_addr constant [43 x i8] c"cannot rollback - no transaction is active\00", align 1
@.str.697 = private unnamed_addr constant [41 x i8] c"cannot commit - no transaction is active\00", align 1
@.str.698 = private unnamed_addr constant [28 x i8] c"database schema has changed\00", align 1
@.str.699 = private unnamed_addr constant [43 x i8] c"SELECT*FROM\22%w\22.%s WHERE %s ORDER BY rowid\00", align 1
@.str.700 = private unnamed_addr constant [37 x i8] c"too many levels of trigger recursion\00", align 1
@.str.701 = private unnamed_addr constant [52 x i8] c"cannot change %s wal mode from within a transaction\00", align 1
@.str.702 = private unnamed_addr constant [5 x i8] c"into\00", align 1
@.str.703 = private unnamed_addr constant [7 x i8] c"out of\00", align 1
@.str.704 = private unnamed_addr constant [29 x i8] c"database table is locked: %s\00", align 1
@.str.705 = private unnamed_addr constant [32 x i8] c"statement aborts at %d: [%s] %s\00", align 1
@sqlite3BtreeFakeValidCursor.fakeCursor = internal global i8 0, align 1
@.str.706 = private unnamed_addr constant [19 x i8] c"sqlite_temp_master\00", align 1
@.str.707 = private unnamed_addr constant [72 x i8] c"CREATE TABLE x(type text,name text,tbl_name text,rootpage int,sql text)\00", align 1
@.str.708 = private unnamed_addr constant [24 x i8] c"unsupported file format\00", align 1
@.str.709 = private unnamed_addr constant [34 x i8] c"SELECT*FROM\22%w\22.%s ORDER BY rowid\00", align 1
@.str.710 = private unnamed_addr constant [8 x i8] c"create \00", align 1
@.str.711 = private unnamed_addr constant [17 x i8] c"invalid rootpage\00", align 1
@.str.712 = private unnamed_addr constant [13 x i8] c"orphan index\00", align 1
@.str.713 = private unnamed_addr constant [30 x i8] c"database schema is locked: %s\00", align 1
@.str.714 = private unnamed_addr constant [19 x i8] c"statement too long\00", align 1
@.str.715 = private unnamed_addr constant [41 x i8] c"SELECT tbl,idx,stat FROM %Q.sqlite_stat1\00", align 1
@__const.sqlite3DefaultRowEst.aVal = private unnamed_addr constant [5 x i16] [i16 33, i16 32, i16 30, i16 28, i16 26], align 2
@.str.716 = private unnamed_addr constant [16 x i8] c"Main freelist: \00", align 1
@.str.717 = private unnamed_addr constant [45 x i8] c"max rootpage (%d) disagrees with header (%d)\00", align 1
@.str.718 = private unnamed_addr constant [55 x i8] c"incremental_vacuum enabled with a max rootpage of zero\00", align 1
@.str.719 = private unnamed_addr constant [22 x i8] c"Page %d is never used\00", align 1
@.str.720 = private unnamed_addr constant [34 x i8] c"Pointer map page %d is referenced\00", align 1
@sqlite3JournalModename.azModeName = internal unnamed_addr constant [6 x i8*] [i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.721, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.722, i32 0, i32 0), i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.723, i32 0, i32 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.724, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.395, i32 0, i32 0), i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.725, i32 0, i32 0)], align 16
@.str.721 = private unnamed_addr constant [7 x i8] c"delete\00", align 1
@.str.722 = private unnamed_addr constant [8 x i8] c"persist\00", align 1
@.str.723 = private unnamed_addr constant [4 x i8] c"off\00", align 1
@.str.724 = private unnamed_addr constant [9 x i8] c"truncate\00", align 1
@.str.725 = private unnamed_addr constant [4 x i8] c"wal\00", align 1
@.str.726 = private unnamed_addr constant [40 x i8] c"cannot VACUUM from within a transaction\00", align 1
@.str.727 = private unnamed_addr constant [43 x i8] c"cannot VACUUM - SQL statements in progress\00", align 1
@.str.728 = private unnamed_addr constant [18 x i8] c"non-text filename\00", align 1
@.str.729 = private unnamed_addr constant [23 x i8] c"ATTACH %Q AS vacuum_db\00", align 1
@.str.730 = private unnamed_addr constant [27 x i8] c"output file already exists\00", align 1
@.str.731 = private unnamed_addr constant [6 x i8] c"BEGIN\00", align 1
@.str.732 = private unnamed_addr constant [108 x i8] c"SELECT sql FROM \22%w\22.sqlite_master WHERE type='table'AND name<>'sqlite_sequence' AND coalesce(rootpage,1)>0\00", align 1
@.str.733 = private unnamed_addr constant [54 x i8] c"SELECT sql FROM \22%w\22.sqlite_master WHERE type='index'\00", align 1
@.str.734 = private unnamed_addr constant [151 x i8] c"SELECT'INSERT INTO vacuum_db.'||quote(name)||' SELECT*FROM\22%w\22.'||quote(name)FROM vacuum_db.sqlite_master WHERE type='table'AND coalesce(rootpage,1)>0\00", align 1
@.str.735 = private unnamed_addr constant [130 x i8] c"INSERT INTO vacuum_db.sqlite_master SELECT*FROM \22%w\22.sqlite_master WHERE type IN('view','trigger') OR(type='table'AND rootpage=0)\00", align 1
@sqlite3RunVacuum.aCopy = internal unnamed_addr constant [10 x i8] c"\01\01\03\00\05\00\06\00\08\00", align 1
@sqlite3OpcodeProperty = internal unnamed_addr constant [176 x i8] c"\00\00\00\01\01\01\00\10\00\01\00\01\01\01\03\03\01\01\03\12\03\01\09\09\09\09\01\09\09\09\09\09\09\01\01\01\01\01\01\01\01\01#&&\0B\01\01\03\03\03\03\0B\0B\0B\0B\0B\0B\01\03\01\01\01\00\00\02\02\08\00\10\10\10\10\00\10\10\00\00\10\10\00\00\02\02\02\00\00\12 \00\00\00\10\10\00\00\00\00\00\00\00&&&&&&&&&&\00\12\00\00\10\00\00\00\10\10\00\00\00\00\00\00\10\00\00\04\04\00\00\10\00\10\00\00\10\00\00\00\00\00\00\00\06\10\00\10\04\1A\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\10\10\00\00\00\00\00\00", align 16
@sqlite3VdbeMakeReady.azColName = internal unnamed_addr constant [12 x i8*] [i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.736, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.737, i32 0, i32 0), i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.738, i32 0, i32 0), i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.739, i32 0, i32 0), i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.740, i32 0, i32 0), i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.741, i32 0, i32 0), i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.742, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.743, i32 0, i32 0), i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.287, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.317, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.744, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.745, i32 0, i32 0)], align 16
@.str.736 = private unnamed_addr constant [5 x i8] c"addr\00", align 1
@.str.737 = private unnamed_addr constant [7 x i8] c"opcode\00", align 1
@.str.738 = private unnamed_addr constant [3 x i8] c"p1\00", align 1
@.str.739 = private unnamed_addr constant [3 x i8] c"p2\00", align 1
@.str.740 = private unnamed_addr constant [3 x i8] c"p3\00", align 1
@.str.741 = private unnamed_addr constant [3 x i8] c"p4\00", align 1
@.str.742 = private unnamed_addr constant [3 x i8] c"p5\00", align 1
@.str.743 = private unnamed_addr constant [8 x i8] c"comment\00", align 1
@.str.744 = private unnamed_addr constant [8 x i8] c"notused\00", align 1
@.str.745 = private unnamed_addr constant [7 x i8] c"detail\00", align 1
@.str.746 = private unnamed_addr constant [31 x i8] c"too many terms in %s BY clause\00", align 1
@.str.747 = private unnamed_addr constant [48 x i8] c"Expression tree is too large (maximum depth %d)\00", align 1
@.str.748 = private unnamed_addr constant [19 x i8] c"unsafe use of %s()\00", align 1
@.str.749 = private unnamed_addr constant [5 x i8] c"true\00", align 1
@.str.750 = private unnamed_addr constant [6 x i8] c"false\00", align 1
@.str.751 = private unnamed_addr constant [8 x i8] c"_ROWID_\00", align 1
@.str.752 = private unnamed_addr constant [6 x i8] c"ROWID\00", align 1
@.str.753 = private unnamed_addr constant [4 x i8] c"OID\00", align 1
@.str.754 = private unnamed_addr constant [18 x i8] c"REUSE SUBQUERY %d\00", align 1
@.str.755 = private unnamed_addr constant [21 x i8] c"%sSCALAR SUBQUERY %d\00", align 1
@.str.756 = private unnamed_addr constant [12 x i8] c"CORRELATED \00", align 1
@sqlite3VdbeGetOp.dummy = internal global %struct.VdbeOp zeroinitializer, align 8
@sqlite3ExprCodeTarget.zAff = internal constant [8 x i8] c"B\00C\00D\00E\00", align 1
@.str.757 = private unnamed_addr constant [30 x i8] c"generated column loop on \22%s\22\00", align 1
@.str.758 = private unnamed_addr constant [26 x i8] c"misuse of aggregate: %s()\00", align 1
@.str.759 = private unnamed_addr constant [23 x i8] c"unknown function: %s()\00", align 1
@.str.760 = private unnamed_addr constant [30 x i8] c"%d columns assigned %d values\00", align 1
@.str.761 = private unnamed_addr constant [50 x i8] c"RAISE() may only be used within a trigger-program\00", align 1
@.str.762 = private unnamed_addr constant [44 x i8] c"sub-select returns %d columns - expected %d\00", align 1
@.str.763 = private unnamed_addr constant [2 x i8] c"E\00", align 1
@sqlite3LogEst.a = internal unnamed_addr constant [8 x i16] [i16 0, i16 2, i16 3, i16 5, i16 6, i16 7, i16 8, i16 9], align 16
@.str.764 = private unnamed_addr constant [9 x i8] c":memory:\00", align 1
@.str.767 = private unnamed_addr constant [7 x i8] c"nolock\00", align 1
@.str.768 = private unnamed_addr constant [10 x i8] c"immutable\00", align 1
@.str.769 = private unnamed_addr constant [6 x i8] c"%s.%z\00", align 1
@.str.770 = private unnamed_addr constant [27 x i8] c"access to %z is prohibited\00", align 1
@.str.771 = private unnamed_addr constant [13 x i8] c"no such view\00", align 1
@.str.772 = private unnamed_addr constant [14 x i8] c"no such table\00", align 1
@.str.773 = private unnamed_addr constant [30 x i8] c"view %s is circularly defined\00", align 1
@.str.774 = private unnamed_addr constant [6 x i8] c"index\00", align 1
@.str.775 = private unnamed_addr constant [50 x i8] c"cannot create a TEMP index on non-TEMP table \22%s\22\00", align 1
@.str.776 = private unnamed_addr constant [28 x i8] c"table %s may not be indexed\00", align 1
@.str.777 = private unnamed_addr constant [25 x i8] c"views may not be indexed\00", align 1
@.str.778 = private unnamed_addr constant [34 x i8] c"there is already a table named %s\00", align 1
@.str.779 = private unnamed_addr constant [24 x i8] c"index %s already exists\00", align 1
@.str.780 = private unnamed_addr constant [23 x i8] c"sqlite_autoindex_%s_%d\00", align 1
@.str.781 = private unnamed_addr constant [61 x i8] c"expressions prohibited in PRIMARY KEY and UNIQUE constraints\00", align 1
@.str.782 = private unnamed_addr constant [42 x i8] c"conflicting ON CONFLICT clauses specified\00", align 1
@.str.783 = private unnamed_addr constant [20 x i8] c"CREATE%s INDEX %.*s\00", align 1
@.str.784 = private unnamed_addr constant [8 x i8] c" UNIQUE\00", align 1
@.str.785 = private unnamed_addr constant [48 x i8] c"INSERT INTO %Q.%s VALUES('index',%Q,%Q,#%d,%Q);\00", align 1
@.str.786 = private unnamed_addr constant [27 x i8] c"name='%q' AND type='index'\00", align 1
@.str.787 = private unnamed_addr constant [28 x i8] c"unsupported use of NULLS %s\00", align 1
@.str.788 = private unnamed_addr constant [6 x i8] c"FIRST\00", align 1
@.str.789 = private unnamed_addr constant [5 x i8] c"LAST\00", align 1
@.str.790 = private unnamed_addr constant [17 x i8] c"corrupt database\00", align 1
@.str.791 = private unnamed_addr constant [20 x i8] c"unknown database %T\00", align 1
@.str.792 = private unnamed_addr constant [46 x i8] c"%s %T cannot reference objects in database %s\00", align 1
@.str.793 = private unnamed_addr constant [24 x i8] c"%s cannot use variables\00", align 1
@.str.794 = private unnamed_addr constant [42 x i8] c"object name reserved for internal use: %s\00", align 1
@.str.795 = private unnamed_addr constant [70 x i8] c"unable to open a temporary database file for storing temporary tables\00", align 1
@.str.796 = private unnamed_addr constant [11 x i8] c"index '%q'\00", align 1
@.str.797 = private unnamed_addr constant [3 x i8] c", \00", align 1
@.str.798 = private unnamed_addr constant [31 x i8] c"no such collation sequence: %s\00", align 1
@.str.799 = private unnamed_addr constant [45 x i8] c"foreign key mismatch - \22%w\22 referencing \22%w\22\00", align 1
@.str.800 = private unnamed_addr constant [9 x i8] c"%s.rowid\00", align 1
@.str.801 = private unnamed_addr constant [9 x i8] c"unopened\00", align 1
@.str.802 = private unnamed_addr constant [6 x i8] c"dylib\00", align 1
@.str.803 = private unnamed_addr constant [23 x i8] c"sqlite3_extension_init\00", align 1
@.str.804 = private unnamed_addr constant [35 x i8] c"unable to open shared library [%s]\00", align 1
@.str.806 = private unnamed_addr constant [4 x i8] c"lib\00", align 1
@.str.807 = private unnamed_addr constant [6 x i8] c"_init\00", align 1
@.str.808 = private unnamed_addr constant [43 x i8] c"no entry point [%s] in shared library [%s]\00", align 1
@sqlite3Apis = external dso_local constant %struct.sqlite3_api_routines, align 8
@.str.809 = private unnamed_addr constant [32 x i8] c"error during initialization: %s\00", align 1
@sqlite3LogEstAdd.x = internal unnamed_addr constant [32 x i8] c"\0A\0A\09\09\08\08\07\07\07\06\06\06\05\05\05\04\04\04\04\03\03\03\03\03\03\02\02\02\02\02\02\02", align 16
@.str.810 = private unnamed_addr constant [46 x i8] c"all VALUES must have the same number of terms\00", align 1
@.str.811 = private unnamed_addr constant [82 x i8] c"SELECTs to the left and right of %s do not have the same number of result columns\00", align 1
@.str.812 = private unnamed_addr constant [36 x i8] c"too many FROM clause terms, max: %d\00", align 1
@.str.813 = private unnamed_addr constant [36 x i8] c"a JOIN clause is required before %s\00", align 1
@.str.814 = private unnamed_addr constant [3 x i8] c"ON\00", align 1
@.str.815 = private unnamed_addr constant [6 x i8] c"USING\00", align 1
@.str.816 = private unnamed_addr constant [8 x i8] c"%.*z:%u\00", align 1
@.str.817 = private unnamed_addr constant [12 x i8] c"subquery_%u\00", align 1
@.str.818 = private unnamed_addr constant [18 x i8] c"no such index: %s\00", align 1
@.str.819 = private unnamed_addr constant [40 x i8] c"expected %d columns for '%s' but got %d\00", align 1
@.str.820 = private unnamed_addr constant [14 x i8] c"CO-ROUTINE %u\00", align 1
@.str.821 = private unnamed_addr constant [15 x i8] c"MATERIALIZE %u\00", align 1
@.str.822 = private unnamed_addr constant [9 x i8] c"DISTINCT\00", align 1
@.str.823 = private unnamed_addr constant [9 x i8] c"GROUP BY\00", align 1
@.str.824 = private unnamed_addr constant [23 x i8] c"RIGHT PART OF ORDER BY\00", align 1
@.str.825 = private unnamed_addr constant [41 x i8] c"cannot INSERT into generated column \22%s\22\00", align 1
@.str.826 = private unnamed_addr constant [32 x i8] c"table %S has no column named %s\00", align 1
@.str.827 = private unnamed_addr constant [52 x i8] c"table %S has %d columns but %d values were supplied\00", align 1
@.str.828 = private unnamed_addr constant [25 x i8] c"%d values for %d columns\00", align 1
@.str.829 = private unnamed_addr constant [21 x i8] c"cannot UPSERT a view\00", align 1
@.str.830 = private unnamed_addr constant [14 x i8] c"rows inserted\00", align 1
@.str.831 = private unnamed_addr constant [29 x i8] c"table %s may not be modified\00", align 1
@.str.832 = private unnamed_addr constant [38 x i8] c"cannot modify %s because it is a view\00", align 1
@.str.833 = private unnamed_addr constant [71 x i8] c"ON CONFLICT clause does not match any PRIMARY KEY or UNIQUE constraint\00", align 1
@.str.834 = private unnamed_addr constant [13 x i8] c"rows deleted\00", align 1
@.str.835 = private unnamed_addr constant [36 x i8] c"cannot UPDATE generated column \22%s\22\00", align 1
@.str.836 = private unnamed_addr constant [19 x i8] c"no such column: %s\00", align 1
@.str.837 = private unnamed_addr constant [13 x i8] c"rows updated\00", align 1
@.str.838 = private unnamed_addr constant [47 x i8] c"USING ROWID SEARCH ON TABLE %s FOR IN-OPERATOR\00", align 1
@.str.839 = private unnamed_addr constant [31 x i8] c"USING INDEX %s FOR IN-OPERATOR\00", align 1
@.str.840 = private unnamed_addr constant [23 x i8] c"REUSE LIST SUBQUERY %d\00", align 1
@.str.841 = private unnamed_addr constant [19 x i8] c"%sLIST SUBQUERY %d\00", align 1
@.str.842 = private unnamed_addr constant [28 x i8] c"at most %d tables in a join\00", align 1
@.str.843 = private unnamed_addr constant [18 x i8] c"SCAN CONSTANT ROW\00", align 1
@.str.844 = private unnamed_addr constant [36 x i8] c"too many arguments on %s() - max %d\00", align 1
@.str.845 = private unnamed_addr constant [7 x i8] c"SEARCH\00", align 1
@.str.846 = private unnamed_addr constant [5 x i8] c"SCAN\00", align 1
@.str.847 = private unnamed_addr constant [13 x i8] c" SUBQUERY %u\00", align 1
@.str.848 = private unnamed_addr constant [10 x i8] c" TABLE %s\00", align 1
@.str.849 = private unnamed_addr constant [7 x i8] c" AS %s\00", align 1
@.str.850 = private unnamed_addr constant [12 x i8] c"PRIMARY KEY\00", align 1
@.str.851 = private unnamed_addr constant [33 x i8] c"AUTOMATIC PARTIAL COVERING INDEX\00", align 1
@.str.852 = private unnamed_addr constant [25 x i8] c"AUTOMATIC COVERING INDEX\00", align 1
@.str.853 = private unnamed_addr constant [18 x i8] c"COVERING INDEX %s\00", align 1
@.str.854 = private unnamed_addr constant [9 x i8] c"INDEX %s\00", align 1
@.str.855 = private unnamed_addr constant [8 x i8] c" USING \00", align 1
@.str.856 = private unnamed_addr constant [2 x i8] c"=\00", align 1
@.str.857 = private unnamed_addr constant [14 x i8] c">? AND rowid<\00", align 1
@.str.858 = private unnamed_addr constant [38 x i8] c" USING INTEGER PRIMARY KEY (rowid%s?)\00", align 1
@__const.sqlite3WhereCodeOneLoopStart.aMoveOp = private unnamed_addr constant [4 x i8] c"\19\17\16\18", align 1
@sqlite3WhereCodeOneLoopStart.aStartOp = internal unnamed_addr constant [8 x i8] c"\00\00%!\19\16\18\17", align 1
@sqlite3WhereCodeOneLoopStart.aEndOp = internal unnamed_addr constant [4 x i8] c")'&(", align 1
@.str.859 = private unnamed_addr constant [15 x i8] c"MULTI-INDEX OR\00", align 1
@.str.860 = private unnamed_addr constant [9 x i8] c"INDEX %d\00", align 1
@sqlite3WhereCodeOneLoopStart.aStep = internal unnamed_addr constant [2 x i8] c"\05\04", align 1
@sqlite3WhereCodeOneLoopStart.aStart = internal unnamed_addr constant [2 x i8] c"%!", align 1
@.str.861 = private unnamed_addr constant [71 x i8] c"RANGE with offset PRECEDING/FOLLOWING requires one ORDER BY expression\00", align 1
@.str.862 = private unnamed_addr constant [63 x i8] c"FILTER clause may only be used with aggregate window functions\00", align 1
@__const.sqlite3WindowUpdate.aUp = private unnamed_addr constant [8 x %struct.WindowUpdate] [%struct.WindowUpdate { i8* getelementptr inbounds ([11 x i8], [11 x i8]* @row_numberName, i32 0, i32 0), i32 76, i32 90, i32 85 }, %struct.WindowUpdate { i8* getelementptr inbounds ([11 x i8], [11 x i8]* @dense_rankName, i32 0, i32 0), i32 89, i32 90, i32 85 }, %struct.WindowUpdate { i8* getelementptr inbounds ([5 x i8], [5 x i8]* @rankName, i32 0, i32 0), i32 89, i32 90, i32 85 }, %struct.WindowUpdate { i8* getelementptr inbounds ([13 x i8], [13 x i8]* @percent_rankName, i32 0, i32 0), i32 92, i32 85, i32 90 }, %struct.WindowUpdate { i8* getelementptr inbounds ([10 x i8], [10 x i8]* @cume_distName, i32 0, i32 0), i32 92, i32 86, i32 90 }, %struct.WindowUpdate { i8* getelementptr inbounds ([6 x i8], [6 x i8]* @ntileName, i32 0, i32 0), i32 76, i32 85, i32 90 }, %struct.WindowUpdate { i8* getelementptr inbounds ([5 x i8], [5 x i8]* @leadName, i32 0, i32 0), i32 76, i32 90, i32 90 }, %struct.WindowUpdate { i8* getelementptr inbounds ([4 x i8], [4 x i8]* @lagName, i32 0, i32 0), i32 76, i32 90, i32 85 }], align 16
@.str.863 = private unnamed_addr constant [9 x i8] c"ROLLBACK\00", align 1
@.str.864 = private unnamed_addr constant [7 x i8] c"COMMIT\00", align 1
@.str.865 = private unnamed_addr constant [8 x i8] c"RELEASE\00", align 1
@.str.866 = private unnamed_addr constant [41 x i8] c"temporary table name must be unqualified\00", align 1
@sqlite3StartTable.aCode = internal unnamed_addr constant [4 x i8] c"\02\04\08\06", align 1
@.str.867 = private unnamed_addr constant [24 x i8] c"table %T already exists\00", align 1
@.str.868 = private unnamed_addr constant [35 x i8] c"there is already an index named %s\00", align 1
@.str.869 = private unnamed_addr constant [16 x i8] c"sqlite_sequence\00", align 1
@sqlite3StartTable.nullRow = internal constant [6 x i8] c"\06\00\00\00\00\00", align 1
@.str.870 = private unnamed_addr constant [50 x i8] c"AUTOINCREMENT not allowed on WITHOUT ROWID tables\00", align 1
@.str.871 = private unnamed_addr constant [32 x i8] c"PRIMARY KEY missing on table %s\00", align 1
@.str.872 = private unnamed_addr constant [44 x i8] c"must have at least one non-generated column\00", align 1
@.str.873 = private unnamed_addr constant [6 x i8] c"TABLE\00", align 1
@.str.874 = private unnamed_addr constant [5 x i8] c"VIEW\00", align 1
@.str.875 = private unnamed_addr constant [15 x i8] c"CREATE %s %.*s\00", align 1
@.str.876 = private unnamed_addr constant [87 x i8] c"UPDATE %Q.%s SET type='%s', name=%Q, tbl_name=%Q, rootpage=#%d, sql=%Q WHERE rowid=#%d\00", align 1
@.str.877 = private unnamed_addr constant [42 x i8] c"CREATE TABLE %Q.sqlite_sequence(name,seq)\00", align 1
@.str.878 = private unnamed_addr constant [34 x i8] c"tbl_name='%q' AND type!='trigger'\00", align 1
@.str.879 = private unnamed_addr constant [23 x i8] c"too many columns on %s\00", align 1
@.str.880 = private unnamed_addr constant [26 x i8] c"duplicate column name: %s\00", align 1
@.str.881 = private unnamed_addr constant [45 x i8] c"default value of column [%s] is not constant\00", align 1
@.str.882 = private unnamed_addr constant [41 x i8] c"cannot use DEFAULT on a generated column\00", align 1
@.str.883 = private unnamed_addr constant [41 x i8] c"table \22%s\22 has more than one primary key\00", align 1
@.str.884 = private unnamed_addr constant [56 x i8] c"AUTOINCREMENT is only allowed on an INTEGER PRIMARY KEY\00", align 1
@.str.885 = private unnamed_addr constant [63 x i8] c"foreign key on %s should reference only one column of table %T\00", align 1
@.str.886 = private unnamed_addr constant [94 x i8] c"number of columns in foreign key does not match the number of columns in the referenced table\00", align 1
@.str.887 = private unnamed_addr constant [46 x i8] c"unknown column \22%s\22 in foreign key definition\00", align 1
@.str.890 = private unnamed_addr constant [31 x i8] c"error in generated column \22%s\22\00", align 1
@.str.891 = private unnamed_addr constant [28 x i8] c"table %s may not be dropped\00", align 1
@.str.892 = private unnamed_addr constant [34 x i8] c"use DROP TABLE to delete table %s\00", align 1
@.str.893 = private unnamed_addr constant [32 x i8] c"use DROP VIEW to delete view %s\00", align 1
@.str.894 = private unnamed_addr constant [14 x i8] c"sqlite_stat%d\00", align 1
@.str.895 = private unnamed_addr constant [45 x i8] c"DELETE FROM %Q.sqlite_sequence WHERE name=%Q\00", align 1
@.str.896 = private unnamed_addr constant [56 x i8] c"DELETE FROM %Q.%s WHERE tbl_name=%Q and type!='trigger'\00", align 1
@.str.897 = private unnamed_addr constant [51 x i8] c"DELETE FROM %Q.%s WHERE name=%Q AND type='trigger'\00", align 1
@.str.898 = private unnamed_addr constant [36 x i8] c"parameters are not allowed in views\00", align 1
@.str.899 = private unnamed_addr constant [34 x i8] c"too many terms in compound SELECT\00", align 1
@sqlite3JoinType.zKeyText = internal unnamed_addr constant [34 x i8] c"naturaleftouterightfullinnercross\00", align 16
@sqlite3JoinType.aKeyword = internal unnamed_addr constant [7 x %struct.anon.23] [%struct.anon.23 { i8 0, i8 7, i8 4 }, %struct.anon.23 { i8 6, i8 4, i8 40 }, %struct.anon.23 { i8 10, i8 5, i8 32 }, %struct.anon.23 { i8 14, i8 5, i8 48 }, %struct.anon.23 { i8 19, i8 4, i8 56 }, %struct.anon.23 { i8 23, i8 5, i8 1 }, %struct.anon.23 { i8 28, i8 5, i8 3 }], align 16
@.str.900 = private unnamed_addr constant [44 x i8] c"unknown or unsupported join type: %T %T%s%T\00", align 1
@.str.901 = private unnamed_addr constant [55 x i8] c"RIGHT and FULL OUTER JOINs are not currently supported\00", align 1
@.str.902 = private unnamed_addr constant [23 x i8] c"too many columns in %s\00", align 1
@.str.903 = private unnamed_addr constant [43 x i8] c"variable number must be between ?1 and ?%d\00", align 1
@.str.904 = private unnamed_addr constant [23 x i8] c"too many SQL variables\00", align 1
@.str.905 = private unnamed_addr constant [34 x i8] c"too many arguments on function %T\00", align 1
@.str.906 = private unnamed_addr constant [47 x i8] c"DISTINCT is not supported for window functions\00", align 1
@.str.907 = private unnamed_addr constant [38 x i8] c"syntax error after column name \22%.*s\22\00", align 1
@.str.908 = private unnamed_addr constant [18 x i8] c"no such index: %S\00", align 1
@.str.909 = private unnamed_addr constant [73 x i8] c"index associated with UNIQUE or PRIMARY KEY constraint cannot be dropped\00", align 1
@.str.910 = private unnamed_addr constant [49 x i8] c"DELETE FROM %Q.%s WHERE name=%Q AND type='index'\00", align 1
@.str.911 = private unnamed_addr constant [4 x i8] c"-%T\00", align 1
@.str.912 = private unnamed_addr constant [5 x i8] c"fast\00", align 1
@.str.914 = private unnamed_addr constant [25 x i8] c"not a writable directory\00", align 1
@.str.915 = private unnamed_addr constant [30 x i8] c"failed to set lock proxy file\00", align 1
@.str.916 = private unnamed_addr constant [53 x i8] c"Safety level may not be changed inside a transaction\00", align 1
@.str.917 = private unnamed_addr constant [8 x i8] c"issisii\00", align 1
@.str.918 = private unnamed_addr constant [7 x i8] c"issisi\00", align 1
@.str.919 = private unnamed_addr constant [5 x i8] c"iisX\00", align 1
@.str.920 = private unnamed_addr constant [5 x i8] c"isiX\00", align 1
@.str.921 = private unnamed_addr constant [2 x i8] c"c\00", align 1
@.str.922 = private unnamed_addr constant [2 x i8] c"u\00", align 1
@__const.sqlite3Pragma.azOrigin = private unnamed_addr constant [3 x i8*] [i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.921, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.922, i32 0, i32 0), i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.300, i32 0, i32 0)], align 16
@.str.923 = private unnamed_addr constant [6 x i8] c"isisi\00", align 1
@.str.924 = private unnamed_addr constant [4 x i8] c"iss\00", align 1
@.str.925 = private unnamed_addr constant [3 x i8] c"is\00", align 1
@.str.926 = private unnamed_addr constant [9 x i8] c"iissssss\00", align 1
@.str.927 = private unnamed_addr constant [5 x i8] c"NONE\00", align 1
@.str.928 = private unnamed_addr constant [4 x i8] c"siX\00", align 1
@.str.929 = private unnamed_addr constant [24 x i8] c"*** in database %s ***\0A\00", align 1
@.str.930 = private unnamed_addr constant [20 x i8] c"NULL value in %s.%s\00", align 1
@.str.931 = private unnamed_addr constant [30 x i8] c"CHECK constraint failed in %s\00", align 1
@.str.932 = private unnamed_addr constant [5 x i8] c"row \00", align 1
@.str.933 = private unnamed_addr constant [21 x i8] c" missing from index \00", align 1
@.str.934 = private unnamed_addr constant [27 x i8] c"non-unique entry in index \00", align 1
@.str.935 = private unnamed_addr constant [29 x i8] c"wrong # of entries in index \00", align 1
@.str.937 = private unnamed_addr constant [3 x i8] c"ok\00", align 1
@sqlite3Pragma.encnames = internal unnamed_addr constant [9 x %struct.EncName] [%struct.EncName { i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.938, i32 0, i32 0), i8 1 }, %struct.EncName { i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.939, i32 0, i32 0), i8 1 }, %struct.EncName { i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.940, i32 0, i32 0), i8 2 }, %struct.EncName { i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.941, i32 0, i32 0), i8 3 }, %struct.EncName { i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.942, i32 0, i32 0), i8 2 }, %struct.EncName { i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.943, i32 0, i32 0), i8 3 }, %struct.EncName { i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.944, i32 0, i32 0), i8 0 }, %struct.EncName { i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.945, i32 0, i32 0), i8 0 }, %struct.EncName zeroinitializer], align 16
@.str.938 = private unnamed_addr constant [5 x i8] c"UTF8\00", align 1
@.str.939 = private unnamed_addr constant [6 x i8] c"UTF-8\00", align 1
@.str.940 = private unnamed_addr constant [9 x i8] c"UTF-16le\00", align 1
@.str.941 = private unnamed_addr constant [9 x i8] c"UTF-16be\00", align 1
@.str.942 = private unnamed_addr constant [8 x i8] c"UTF16le\00", align 1
@.str.943 = private unnamed_addr constant [8 x i8] c"UTF16be\00", align 1
@.str.944 = private unnamed_addr constant [7 x i8] c"UTF-16\00", align 1
@.str.945 = private unnamed_addr constant [6 x i8] c"UTF16\00", align 1
@.str.946 = private unnamed_addr constant [25 x i8] c"unsupported encoding: %s\00", align 1
@.str.947 = private unnamed_addr constant [8 x i8] c"restart\00", align 1
@.str.948 = private unnamed_addr constant [18 x i8] c"ANALYZE \22%w\22.\22%w\22\00", align 1
@.str.949 = private unnamed_addr constant [5 x i8] c"like\00", align 1
@.str.950 = private unnamed_addr constant [64 x i8] c"INSERT INTO %Q.%s VALUES('trigger',%Q,%Q,0,'CREATE TRIGGER %q')\00", align 1
@.str.951 = private unnamed_addr constant [29 x i8] c"type='trigger' AND name='%q'\00", align 1
@.str.952 = private unnamed_addr constant [46 x i8] c"temporary trigger may not have qualified name\00", align 1
@.str.953 = private unnamed_addr constant [26 x i8] c"trigger %T already exists\00", align 1
@.str.954 = private unnamed_addr constant [38 x i8] c"cannot create trigger on system table\00", align 1
@.str.955 = private unnamed_addr constant [37 x i8] c"cannot create %s trigger on view: %S\00", align 1
@.str.956 = private unnamed_addr constant [7 x i8] c"BEFORE\00", align 1
@.str.957 = private unnamed_addr constant [6 x i8] c"AFTER\00", align 1
@.str.958 = private unnamed_addr constant [46 x i8] c"cannot create INSTEAD OF trigger on table: %S\00", align 1
@.str.959 = private unnamed_addr constant [20 x i8] c"no such trigger: %S\00", align 1
@sqlite3Attach.attach_func = external dso_local constant %struct.FuncDef, align 8
@.str.960 = private unnamed_addr constant [14 x i8] c"sqlite_attach\00", align 1
@sqlite3Detach.detach_func = external dso_local constant %struct.FuncDef, align 8
@.str.961 = private unnamed_addr constant [14 x i8] c"sqlite_detach\00", align 1
@.str.962 = private unnamed_addr constant [46 x i8] c"unable to identify the object to be reindexed\00", align 1
@.str.963 = private unnamed_addr constant [59 x i8] c"there is already another table or index with this name: %s\00", align 1
@.str.964 = private unnamed_addr constant [27 x i8] c"view %s may not be altered\00", align 1
@.str.965 = private unnamed_addr constant [173 x i8] c"UPDATE \22%w\22.%s SET sql = sqlite_rename_table(%Q, type, name, sql, %Q, %Q, %d) WHERE (type!='index' OR tbl_name=%Q COLLATE nocase)AND   name NOT LIKE 'sqliteX_%%' ESCAPE 'X'\00", align 1
@.str.966 = private unnamed_addr constant [294 x i8] c"UPDATE %Q.%s SET tbl_name = %Q, name = CASE WHEN type='table' THEN %Q WHEN name LIKE 'sqliteX_autoindex%%' ESCAPE 'X'      AND type='index' THEN 'sqlite_autoindex_' || %Q || substr(name,%d+18) ELSE name END WHERE tbl_name=%Q COLLATE nocase AND (type='table' OR type='index' OR type='trigger');\00", align 1
@.str.967 = private unnamed_addr constant [58 x i8] c"UPDATE \22%w\22.sqlite_sequence set name = %Q WHERE name = %Q\00", align 1
@.str.968 = private unnamed_addr constant [254 x i8] c"UPDATE sqlite_temp_master SET sql = sqlite_rename_table(%Q, type, name, sql, %Q, %Q, 1), tbl_name = CASE WHEN tbl_name=%Q COLLATE nocase AND           sqlite_rename_test(%Q, sql, type, name, 1) THEN %Q ELSE tbl_name END WHERE type IN ('view', 'trigger')\00", align 1
@.str.969 = private unnamed_addr constant [32 x i8] c"Cannot add a PRIMARY KEY column\00", align 1
@.str.970 = private unnamed_addr constant [27 x i8] c"Cannot add a UNIQUE column\00", align 1
@.str.971 = private unnamed_addr constant [59 x i8] c"Cannot add a REFERENCES column with non-NULL default value\00", align 1
@.str.972 = private unnamed_addr constant [53 x i8] c"Cannot add a NOT NULL column with default value NULL\00", align 1
@.str.973 = private unnamed_addr constant [46 x i8] c"Cannot add a column with non-constant default\00", align 1
@.str.974 = private unnamed_addr constant [27 x i8] c"cannot add a STORED column\00", align 1
@.str.975 = private unnamed_addr constant [109 x i8] c"UPDATE \22%w\22.%s SET sql = substr(sql,1,%d) || ', ' || %Q || substr(sql,%d) WHERE type = 'table' AND name = %Q\00", align 1
@.str.976 = private unnamed_addr constant [30 x i8] c"Cannot add a column to a view\00", align 1
@.str.977 = private unnamed_addr constant [19 x i8] c"sqlite_altertab_%s\00", align 1
@.str.978 = private unnamed_addr constant [207 x i8] c"UPDATE \22%w\22.%s SET sql = sqlite_rename_column(sql, type, name, %Q, %Q, %d, %Q, %d, %d) WHERE name NOT LIKE 'sqliteX_%%' ESCAPE 'X'  AND (type != 'index' OR tbl_name = %Q) AND sql NOT LIKE 'create virtual%%'\00", align 1
@.str.979 = private unnamed_addr constant [120 x i8] c"UPDATE temp.%s SET sql = sqlite_rename_column(sql, type, name, %Q, %Q, %d, %Q, %d, 1) WHERE type IN ('trigger', 'view')\00", align 1
@.str.980 = private unnamed_addr constant [30 x i8] c"duplicate WITH table name: %s\00", align 1
@.str.981 = private unnamed_addr constant [17 x i8] c"PARTITION clause\00", align 1
@.str.982 = private unnamed_addr constant [16 x i8] c"ORDER BY clause\00", align 1
@.str.983 = private unnamed_addr constant [20 x i8] c"frame specification\00", align 1
@.str.984 = private unnamed_addr constant [33 x i8] c"cannot override %s of window: %s\00", align 1
@.str.985 = private unnamed_addr constant [32 x i8] c"unsupported frame specification\00", align 1
@.str.986 = private unnamed_addr constant [27 x i8] c"unrecognized token: \22%.*s\22\00", align 1
@.str.987 = private unnamed_addr constant [11 x i8] c"%s in \22%s\22\00", align 1
@sqlite3RegisterBuiltinFunctions.aBuiltinFunc = external dso_local global [62 x %struct.FuncDef], align 16
@.str.988 = private unnamed_addr constant [20 x i8] c"implies_nonnull_row\00", align 1
@.str.989 = private unnamed_addr constant [13 x i8] c"expr_compare\00", align 1
@.str.990 = private unnamed_addr constant [18 x i8] c"expr_implies_expr\00", align 1
@.str.991 = private unnamed_addr constant [15 x i8] c"load_extension\00", align 1
@.str.992 = private unnamed_addr constant [26 x i8] c"sqlite_compileoption_used\00", align 1
@.str.993 = private unnamed_addr constant [25 x i8] c"sqlite_compileoption_get\00", align 1
@.str.994 = private unnamed_addr constant [9 x i8] c"unlikely\00", align 1
@.str.995 = private unnamed_addr constant [11 x i8] c"likelihood\00", align 1
@.str.996 = private unnamed_addr constant [7 x i8] c"likely\00", align 1
@.str.997 = private unnamed_addr constant [6 x i8] c"ltrim\00", align 1
@.str.998 = private unnamed_addr constant [6 x i8] c"rtrim\00", align 1
@.str.999 = private unnamed_addr constant [5 x i8] c"trim\00", align 1
@.str.1000 = private unnamed_addr constant [7 x i8] c"typeof\00", align 1
@.str.1001 = private unnamed_addr constant [7 x i8] c"length\00", align 1
@.str.1002 = private unnamed_addr constant [6 x i8] c"instr\00", align 1
@.str.1003 = private unnamed_addr constant [7 x i8] c"printf\00", align 1
@.str.1004 = private unnamed_addr constant [8 x i8] c"unicode\00", align 1
@.str.1005 = private unnamed_addr constant [5 x i8] c"char\00", align 1
@.str.1006 = private unnamed_addr constant [4 x i8] c"abs\00", align 1
@.str.1007 = private unnamed_addr constant [6 x i8] c"round\00", align 1
@.str.1008 = private unnamed_addr constant [6 x i8] c"upper\00", align 1
@.str.1009 = private unnamed_addr constant [6 x i8] c"lower\00", align 1
@.str.1010 = private unnamed_addr constant [4 x i8] c"hex\00", align 1
@.str.1011 = private unnamed_addr constant [7 x i8] c"ifnull\00", align 1
@.str.1012 = private unnamed_addr constant [7 x i8] c"random\00", align 1
@.str.1013 = private unnamed_addr constant [11 x i8] c"randomblob\00", align 1
@.str.1014 = private unnamed_addr constant [7 x i8] c"nullif\00", align 1
@.str.1015 = private unnamed_addr constant [15 x i8] c"sqlite_version\00", align 1
@.str.1016 = private unnamed_addr constant [17 x i8] c"sqlite_source_id\00", align 1
@.str.1017 = private unnamed_addr constant [11 x i8] c"sqlite_log\00", align 1
@.str.1018 = private unnamed_addr constant [6 x i8] c"quote\00", align 1
@.str.1019 = private unnamed_addr constant [18 x i8] c"last_insert_rowid\00", align 1
@.str.1020 = private unnamed_addr constant [8 x i8] c"changes\00", align 1
@.str.1021 = private unnamed_addr constant [14 x i8] c"total_changes\00", align 1
@.str.1022 = private unnamed_addr constant [8 x i8] c"replace\00", align 1
@.str.1023 = private unnamed_addr constant [9 x i8] c"zeroblob\00", align 1
@.str.1024 = private unnamed_addr constant [7 x i8] c"substr\00", align 1
@.str.1025 = private unnamed_addr constant [4 x i8] c"sum\00", align 1
@.str.1026 = private unnamed_addr constant [6 x i8] c"total\00", align 1
@.str.1027 = private unnamed_addr constant [4 x i8] c"avg\00", align 1
@.str.1028 = private unnamed_addr constant [6 x i8] c"count\00", align 1
@.str.1029 = private unnamed_addr constant [13 x i8] c"group_concat\00", align 1
@.str.1030 = private unnamed_addr constant [5 x i8] c"glob\00", align 1
@.str.1031 = private unnamed_addr constant [9 x i8] c"coalesce\00", align 1
@sqlite3AlterFunctions.aAlterTableFuncs = external dso_local global [3 x %struct.FuncDef], align 16
@.str.1032 = private unnamed_addr constant [21 x i8] c"sqlite_rename_column\00", align 1
@.str.1033 = private unnamed_addr constant [20 x i8] c"sqlite_rename_table\00", align 1
@.str.1034 = private unnamed_addr constant [19 x i8] c"sqlite_rename_test\00", align 1
@sqlite3WindowFunctions.aWindowFuncs = external dso_local global [15 x %struct.FuncDef], align 16
@sqlite3RegisterDateTimeFunctions_aDateTimeFuncs = external dso_local global [8 x %struct.FuncDef], align 16
@.str.1035 = private unnamed_addr constant [10 x i8] c"julianday\00", align 1
@.str.1036 = private unnamed_addr constant [5 x i8] c"date\00", align 1
@.str.1037 = private unnamed_addr constant [5 x i8] c"time\00", align 1
@.str.1038 = private unnamed_addr constant [9 x i8] c"datetime\00", align 1
@.str.1039 = private unnamed_addr constant [9 x i8] c"strftime\00", align 1
@.str.1040 = private unnamed_addr constant [13 x i8] c"current_time\00", align 1
@.str.1041 = private unnamed_addr constant [18 x i8] c"current_timestamp\00", align 1
@.str.1042 = private unnamed_addr constant [13 x i8] c"current_date\00", align 1
@sqlite3MemSetDefault_defaultMethods = external dso_local constant %struct.sqlite3_mem_methods, align 8
@.str.1043 = private unnamed_addr constant [38 x i8] c"failed to allocate %u bytes of memory\00", align 1
@.str.1044 = private unnamed_addr constant [36 x i8] c"failed memory resize %u to %u bytes\00", align 1
@.str.1045 = private unnamed_addr constant [8 x i8] c"hw.ncpu\00", align 1
@.str.1046 = private unnamed_addr constant [12 x i8] c"Sqlite_Heap\00", align 1
@sqlite3PCacheSetDefault_defaultMethods = external dso_local constant %struct.sqlite3_pcache_methods2, align 8
@.str.1047 = private unnamed_addr constant [68 x i8] c"unable to close due to unfinalized statements or unfinished backups\00", align 1
@sqlite3ErrStr.aMsg = internal unnamed_addr constant [29 x i8*] [i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.1048, i32 0, i32 0), i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.1049, i32 0, i32 0), i8* null, i8* getelementptr inbounds ([25 x i8], [25 x i8]* @.str.1050, i32 0, i32 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1051, i32 0, i32 0), i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.1052, i32 0, i32 0), i8* getelementptr inbounds ([25 x i8], [25 x i8]* @.str.1053, i32 0, i32 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.259, i32 0, i32 0), i8* getelementptr inbounds ([37 x i8], [37 x i8]* @.str.1054, i32 0, i32 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.1055, i32 0, i32 0), i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.str.1056, i32 0, i32 0), i8* getelementptr inbounds ([33 x i8], [33 x i8]* @.str.1057, i32 0, i32 0), i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.1058, i32 0, i32 0), i8* getelementptr inbounds ([25 x i8], [25 x i8]* @.str.1059, i32 0, i32 0), i8* getelementptr inbounds ([29 x i8], [29 x i8]* @.str.1060, i32 0, i32 0), i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.1061, i32 0, i32 0), i8* null, i8* getelementptr inbounds ([28 x i8], [28 x i8]* @.str.698, i32 0, i32 0), i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.174, i32 0, i32 0), i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.1062, i32 0, i32 0), i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.1063, i32 0, i32 0), i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.str.1064, i32 0, i32 0), i8* null, i8* getelementptr inbounds ([21 x i8], [21 x i8]* @.str.1065, i32 0, i32 0), i8* null, i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.1066, i32 0, i32 0), i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.1067, i32 0, i32 0), i8* getelementptr inbounds ([21 x i8], [21 x i8]* @.str.1068, i32 0, i32 0), i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.1069, i32 0, i32 0)], align 16
@.str.1048 = private unnamed_addr constant [13 x i8] c"not an error\00", align 1
@.str.1049 = private unnamed_addr constant [16 x i8] c"SQL logic error\00", align 1
@.str.1050 = private unnamed_addr constant [25 x i8] c"access permission denied\00", align 1
@.str.1051 = private unnamed_addr constant [14 x i8] c"query aborted\00", align 1
@.str.1052 = private unnamed_addr constant [19 x i8] c"database is locked\00", align 1
@.str.1053 = private unnamed_addr constant [25 x i8] c"database table is locked\00", align 1
@.str.1054 = private unnamed_addr constant [37 x i8] c"attempt to write a readonly database\00", align 1
@.str.1055 = private unnamed_addr constant [12 x i8] c"interrupted\00", align 1
@.str.1056 = private unnamed_addr constant [15 x i8] c"disk I/O error\00", align 1
@.str.1057 = private unnamed_addr constant [33 x i8] c"database disk image is malformed\00", align 1
@.str.1058 = private unnamed_addr constant [18 x i8] c"unknown operation\00", align 1
@.str.1059 = private unnamed_addr constant [25 x i8] c"database or disk is full\00", align 1
@.str.1060 = private unnamed_addr constant [29 x i8] c"unable to open database file\00", align 1
@.str.1061 = private unnamed_addr constant [17 x i8] c"locking protocol\00", align 1
@.str.1062 = private unnamed_addr constant [18 x i8] c"constraint failed\00", align 1
@.str.1063 = private unnamed_addr constant [18 x i8] c"datatype mismatch\00", align 1
@.str.1064 = private unnamed_addr constant [34 x i8] c"bad parameter or other API misuse\00", align 1
@.str.1065 = private unnamed_addr constant [21 x i8] c"authorization denied\00", align 1
@.str.1066 = private unnamed_addr constant [26 x i8] c"column index out of range\00", align 1
@.str.1067 = private unnamed_addr constant [23 x i8] c"file is not a database\00", align 1
@.str.1068 = private unnamed_addr constant [21 x i8] c"notification message\00", align 1
@.str.1069 = private unnamed_addr constant [16 x i8] c"warning message\00", align 1
@.str.1070 = private unnamed_addr constant [14 x i8] c"unknown error\00", align 1
@.str.1071 = private unnamed_addr constant [22 x i8] c"abort due to ROLLBACK\00", align 1
@.str.1072 = private unnamed_addr constant [22 x i8] c"another row available\00", align 1
@.str.1073 = private unnamed_addr constant [23 x i8] c"no more rows available\00", align 1
@.str.1074 = private unnamed_addr constant [63 x i8] c"unable to delete/modify user-function due to active statements\00", align 1
@.str.1075 = private unnamed_addr constant [51 x i8] c"unable to use function %s in the requested context\00", align 1
@.str.1076 = private unnamed_addr constant [8 x i8] c"invalid\00", align 1
@.str.1077 = private unnamed_addr constant [6 x i8] c"file:\00", align 1
@.str.1078 = private unnamed_addr constant [10 x i8] c"localhost\00", align 1
@.str.1079 = private unnamed_addr constant [28 x i8] c"invalid uri authority: %.*s\00", align 1
@.str.1080 = private unnamed_addr constant [4 x i8] c"vfs\00", align 1
@.str.1081 = private unnamed_addr constant [6 x i8] c"cache\00", align 1
@sqlite3ParseUri.aCacheMode = internal unnamed_addr constant [3 x %struct.OpenMode] [%struct.OpenMode { i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.1082, i32 0, i32 0), i32 131072 }, %struct.OpenMode { i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.1083, i32 0, i32 0), i32 262144 }, %struct.OpenMode zeroinitializer], align 16
@.str.1082 = private unnamed_addr constant [7 x i8] c"shared\00", align 1
@.str.1083 = private unnamed_addr constant [8 x i8] c"private\00", align 1
@.str.1084 = private unnamed_addr constant [5 x i8] c"mode\00", align 1
@sqlite3ParseUri.aOpenMode = internal unnamed_addr constant [5 x %struct.OpenMode] [%struct.OpenMode { i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.1085, i32 0, i32 0), i32 1 }, %struct.OpenMode { i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.1086, i32 0, i32 0), i32 2 }, %struct.OpenMode { i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.1087, i32 0, i32 0), i32 6 }, %struct.OpenMode { i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.395, i32 0, i32 0), i32 128 }, %struct.OpenMode zeroinitializer], align 16
@.str.1085 = private unnamed_addr constant [3 x i8] c"ro\00", align 1
@.str.1086 = private unnamed_addr constant [3 x i8] c"rw\00", align 1
@.str.1087 = private unnamed_addr constant [4 x i8] c"rwc\00", align 1
@.str.1088 = private unnamed_addr constant [20 x i8] c"no such %s mode: %s\00", align 1
@.str.1089 = private unnamed_addr constant [24 x i8] c"%s mode not allowed: %s\00", align 1
@.str.1090 = private unnamed_addr constant [16 x i8] c"no such vfs: %s\00", align 1
@.str.1091 = private unnamed_addr constant [6 x i8] c"MATCH\00", align 1
@.str.1092 = private unnamed_addr constant [39 x i8] c"automatic extension loading failed: %s\00", align 1
@.str.1093 = private unnamed_addr constant [20 x i8] c"database corruption\00", align 1
@.str.1094 = private unnamed_addr constant [25 x i8] c"%s at line %d of [%.10s]\00", align 1
@.str.1095 = private unnamed_addr constant [7 x i8] c"misuse\00", align 1
@.str.1096 = private unnamed_addr constant [17 x i8] c"cannot open file\00", align 1
@sqlite3SavedPrng = internal unnamed_addr global %struct.sqlite3PrngType zeroinitializer, align 1
@sqlite3azCompileOpt = internal unnamed_addr constant [4 x i8*] [i8* getelementptr inbounds ([22 x i8], [22 x i8]* @.str.1097, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.1098, i32 0, i32 0), i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.1099, i32 0, i32 0), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.1100, i32 0, i32 0)], align 16
@.str.1097 = private unnamed_addr constant [22 x i8] c"COMPILER=clang-11.0.0\00", align 1
@.str.1098 = private unnamed_addr constant [11 x i8] c"OMIT_TRACE\00", align 1
@.str.1099 = private unnamed_addr constant [18 x i8] c"OMIT_VIRTUALTABLE\00", align 1
@.str.1100 = private unnamed_addr constant [13 x i8] c"THREADSAFE=1\00", align 1
@switch.table.multiSelectOrderBy = private unnamed_addr constant [3 x i8*] [i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.414, i64 0, i64 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.416, i64 0, i64 0), i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.415, i64 0, i64 0)], align 8
@switch.table.sqlite3Pragma.1201 = private unnamed_addr constant [4 x i8*] [i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.400, i64 0, i64 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.397, i64 0, i64 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.398, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.399, i64 0, i64 0)], align 8

declare i8* @malloc(i64)

declare void @free(i8*)

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare void @my_assert(i1, i64, i8*) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare void @dbg() #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare void @sqlite3VdbeMemRealify(%struct.sqlite3_value*) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare void @printTypeOf(i8*, i32, %struct.Vdbe*, %struct.sqlite3_value*) #0

; Function Attrs: noinline nounwind ssp uwtable
declare void @vdbeMemClearExternAndSetNull(%struct.sqlite3_value*) local_unnamed_addr #1

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare void @sqlite3VdbeIntegerAffinity(%struct.sqlite3_value*) #0

; Function Attrs: alwaysinline nofree norecurse nounwind ssp uwtable
define dso_local i32 @sqlite3AtoF(i8* readonly %z, double* nocapture %pResult, i32 %length, i8 zeroext %enc) unnamed_addr #2 {
entry:
  store double 0.000000e+00, double* %pResult, align 8, !tbaa !6
  %cmp = icmp eq i32 %length, 0
  br i1 %cmp, label %cleanup, label %if.end

if.end:                                           ; preds = %entry
  %conv = zext i8 %enc to i32
  %cmp1 = icmp eq i8 %enc, 1
  br i1 %cmp1, label %if.end20, label %if.else

if.else:                                          ; preds = %if.end
  %and = and i32 %length, -2
  %sub = sub nsw i32 3, %conv
  %cmp5540 = icmp slt i32 %sub, %and
  br i1 %cmp5540, label %land.rhs.preheader, label %for.end

land.rhs.preheader:                               ; preds = %if.else
  %0 = sext i32 %sub to i64
  %1 = sext i32 %and to i64
  br label %land.rhs

land.rhs:                                         ; preds = %for.inc, %land.rhs.preheader
  %indvars.iv = phi i64 [ %0, %land.rhs.preheader ], [ %indvars.iv.next, %for.inc ]
  %i.0541 = phi i32 [ %sub, %land.rhs.preheader ], [ %add, %for.inc ]
  %arrayidx = getelementptr inbounds i8, i8* %z, i64 %indvars.iv
  %2 = load i8, i8* %arrayidx, align 1, !tbaa !10
  %cmp8 = icmp eq i8 %2, 0
  br i1 %cmp8, label %for.inc, label %for.end.loopexit.split.loop.exit

for.inc:                                          ; preds = %land.rhs
  %indvars.iv.next = add i64 %indvars.iv, 2
  %add = add nsw i32 %i.0541, 2
  %cmp5 = icmp slt i64 %indvars.iv.next, %1
  br i1 %cmp5, label %land.rhs, label %for.end

for.end.loopexit.split.loop.exit:                 ; preds = %land.rhs
  %3 = trunc i64 %indvars.iv to i32
  br label %for.end

for.end:                                          ; preds = %for.end.loopexit.split.loop.exit, %for.inc, %if.else
  %i.0.lcssa563 = phi i32 [ %sub, %if.else ], [ %3, %for.end.loopexit.split.loop.exit ], [ %add, %for.inc ]
  %4 = phi i32 [ 1, %if.else ], [ -100, %for.end.loopexit.split.loop.exit ], [ 1, %for.inc ]
  %xor = xor i32 %i.0.lcssa563, 1
  %and17 = and i32 %conv, 1
  %idx.ext18 = zext i32 %and17 to i64
  %add.ptr19 = getelementptr inbounds i8, i8* %z, i64 %idx.ext18
  br label %if.end20

if.end20:                                         ; preds = %for.end, %if.end
  %idx.ext.pn.in = phi i32 [ %xor, %for.end ], [ %length, %if.end ]
  %eType.1 = phi i32 [ %4, %for.end ], [ 1, %if.end ]
  %incr.0 = phi i64 [ 2, %for.end ], [ 1, %if.end ]
  %z.addr.0 = phi i8* [ %add.ptr19, %for.end ], [ %z, %if.end ]
  %idx.ext.pn = sext i32 %idx.ext.pn.in to i64
  %zEnd.0 = getelementptr inbounds i8, i8* %z, i64 %idx.ext.pn
  %cmp21538 = icmp ult i8* %z.addr.0, %zEnd.0
  br i1 %cmp21538, label %land.rhs23, label %cleanup

land.rhs23:                                       ; preds = %while.body, %if.end20
  %z.addr.1539 = phi i8* [ %add.ptr30, %while.body ], [ %z.addr.0, %if.end20 ]
  %5 = load i8, i8* %z.addr.1539, align 1, !tbaa !10
  %idxprom24 = zext i8 %5 to i64
  %arrayidx25 = getelementptr inbounds [256 x i8], [256 x i8]* @sqlite3CtypeMap, i64 0, i64 %idxprom24
  %6 = load i8, i8* %arrayidx25, align 1, !tbaa !10
  %7 = and i8 %6, 1
  %tobool = icmp eq i8 %7, 0
  br i1 %tobool, label %if.end34, label %while.body

while.body:                                       ; preds = %land.rhs23
  %add.ptr30 = getelementptr inbounds i8, i8* %z.addr.1539, i64 %incr.0
  %cmp21 = icmp ult i8* %add.ptr30, %zEnd.0
  br i1 %cmp21, label %land.rhs23, label %cleanup

if.end34:                                         ; preds = %land.rhs23
  switch i8 %5, label %if.end49 [
    i8 45, label %if.then38
    i8 43, label %if.then45
  ]

if.then38:                                        ; preds = %if.end34
  %add.ptr40 = getelementptr inbounds i8, i8* %z.addr.1539, i64 %incr.0
  br label %if.end49

if.then45:                                        ; preds = %if.end34
  %add.ptr47 = getelementptr inbounds i8, i8* %z.addr.1539, i64 %incr.0
  br label %if.end49

if.end49:                                         ; preds = %if.then45, %if.then38, %if.end34
  %sign.0 = phi i32 [ -1, %if.then38 ], [ 1, %if.then45 ], [ 1, %if.end34 ]
  %z.addr.2 = phi i8* [ %add.ptr40, %if.then38 ], [ %add.ptr47, %if.then45 ], [ %z.addr.1539, %if.end34 ]
  %cmp51529 = icmp ult i8* %z.addr.2, %zEnd.0
  br i1 %cmp51529, label %land.rhs53, label %if.then201

land.rhs53:                                       ; preds = %if.end85, %if.end49
  %z.addr.3533 = phi i8* [ %z.addr.5, %if.end85 ], [ %z.addr.2, %if.end49 ]
  %nDigit.0532 = phi i32 [ %inc, %if.end85 ], [ 0, %if.end49 ]
  %d.0531 = phi i32 [ %d.2, %if.end85 ], [ 0, %if.end49 ]
  %s.0530 = phi i64 [ %add64, %if.end85 ], [ 0, %if.end49 ]
  %8 = load i8, i8* %z.addr.3533, align 1, !tbaa !10
  %idxprom54 = zext i8 %8 to i64
  %9 = add nsw i64 %idxprom54, -48
  %tobool58 = icmp ult i64 %9, 10
  br i1 %tobool58, label %while.body60, label %if.end90

while.body60:                                     ; preds = %land.rhs53
  %mul = mul nsw i64 %s.0530, 10
  %conv61 = sext i8 %8 to i64
  %sub62 = add i64 %mul, -48
  %add64 = add i64 %sub62, %conv61
  %add.ptr66 = getelementptr inbounds i8, i8* %z.addr.3533, i64 %incr.0
  %inc = add nuw nsw i32 %nDigit.0532, 1
  %cmp67 = icmp sgt i64 %add64, 922337203685477578
  %cmp71522 = icmp ult i8* %add.ptr66, %zEnd.0
  %or.cond547 = and i1 %cmp67, %cmp71522
  br i1 %or.cond547, label %land.rhs73, label %if.end85

land.rhs73:                                       ; preds = %while.body80, %while.body60
  %z.addr.4524 = phi i8* [ %add.ptr82, %while.body80 ], [ %add.ptr66, %while.body60 ]
  %d.1523 = phi i32 [ %inc83, %while.body80 ], [ %d.0531, %while.body60 ]
  %10 = load i8, i8* %z.addr.4524, align 1, !tbaa !10
  %idxprom74 = zext i8 %10 to i64
  %11 = add nsw i64 %idxprom74, -48
  %tobool78 = icmp ult i64 %11, 10
  br i1 %tobool78, label %while.body80, label %if.end85

while.body80:                                     ; preds = %land.rhs73
  %add.ptr82 = getelementptr inbounds i8, i8* %z.addr.4524, i64 %incr.0
  %inc83 = add nsw i32 %d.1523, 1
  %cmp71 = icmp ult i8* %add.ptr82, %zEnd.0
  br i1 %cmp71, label %land.rhs73, label %if.end85

if.end85:                                         ; preds = %while.body80, %land.rhs73, %while.body60
  %d.2 = phi i32 [ %d.0531, %while.body60 ], [ %inc83, %while.body80 ], [ %d.1523, %land.rhs73 ]
  %z.addr.5 = phi i8* [ %add.ptr66, %while.body60 ], [ %add.ptr82, %while.body80 ], [ %z.addr.4524, %land.rhs73 ]
  %cmp51 = icmp ult i8* %z.addr.5, %zEnd.0
  br i1 %cmp51, label %land.rhs53, label %do_atof_calc

if.end90:                                         ; preds = %land.rhs53
  %cmp92 = icmp eq i8 %8, 46
  br i1 %cmp92, label %if.then94, label %if.end122

if.then94:                                        ; preds = %if.end90
  %inc97 = add nuw nsw i32 %eType.1, 1
  %z.addr.6508 = getelementptr inbounds i8, i8* %z.addr.3533, i64 %incr.0
  %cmp99509 = icmp ult i8* %z.addr.6508, %zEnd.0
  br i1 %cmp99509, label %land.rhs101, label %if.end122

land.rhs101:                                      ; preds = %if.end118, %if.then94
  %z.addr.6513 = phi i8* [ %z.addr.6, %if.end118 ], [ %z.addr.6508, %if.then94 ]
  %nDigit.1512 = phi i32 [ %nDigit.2, %if.end118 ], [ %nDigit.0532, %if.then94 ]
  %d.3511 = phi i32 [ %d.4, %if.end118 ], [ %d.0531, %if.then94 ]
  %s.1510 = phi i64 [ %s.2, %if.end118 ], [ %s.0530, %if.then94 ]
  %12 = load i8, i8* %z.addr.6513, align 1, !tbaa !10
  %idxprom102 = zext i8 %12 to i64
  %13 = add nsw i64 %idxprom102, -48
  %tobool106 = icmp ult i64 %13, 10
  br i1 %tobool106, label %while.body108, label %if.end122

while.body108:                                    ; preds = %land.rhs101
  %cmp109 = icmp slt i64 %s.1510, 922337203685477579
  br i1 %cmp109, label %if.then111, label %if.end118

if.then111:                                       ; preds = %while.body108
  %mul112 = mul nsw i64 %s.1510, 10
  %conv113 = sext i8 %12 to i64
  %sub114 = add i64 %mul112, -48
  %add116 = add i64 %sub114, %conv113
  %dec = add nsw i32 %d.3511, -1
  %inc117 = add nsw i32 %nDigit.1512, 1
  br label %if.end118

if.end118:                                        ; preds = %if.then111, %while.body108
  %s.2 = phi i64 [ %add116, %if.then111 ], [ %s.1510, %while.body108 ]
  %d.4 = phi i32 [ %dec, %if.then111 ], [ %d.3511, %while.body108 ]
  %nDigit.2 = phi i32 [ %inc117, %if.then111 ], [ %nDigit.1512, %while.body108 ]
  %z.addr.6 = getelementptr inbounds i8, i8* %z.addr.6513, i64 %incr.0
  %cmp99 = icmp ult i8* %z.addr.6, %zEnd.0
  br i1 %cmp99, label %land.rhs101, label %if.end122

if.end122:                                        ; preds = %if.end118, %land.rhs101, %if.then94, %if.end90
  %s.3 = phi i64 [ %s.0530, %if.end90 ], [ %s.0530, %if.then94 ], [ %s.2, %if.end118 ], [ %s.1510, %land.rhs101 ]
  %d.5 = phi i32 [ %d.0531, %if.end90 ], [ %d.0531, %if.then94 ], [ %d.4, %if.end118 ], [ %d.3511, %land.rhs101 ]
  %nDigit.3 = phi i32 [ %nDigit.0532, %if.end90 ], [ %nDigit.0532, %if.then94 ], [ %nDigit.2, %if.end118 ], [ %nDigit.1512, %land.rhs101 ]
  %eType.2 = phi i32 [ %eType.1, %if.end90 ], [ %inc97, %if.then94 ], [ %inc97, %land.rhs101 ], [ %inc97, %if.end118 ]
  %z.addr.7 = phi i8* [ %z.addr.3533, %if.end90 ], [ %z.addr.6508, %if.then94 ], [ %z.addr.6, %if.end118 ], [ %z.addr.6513, %land.rhs101 ]
  %cmp123 = icmp ult i8* %z.addr.7, %zEnd.0
  br i1 %cmp123, label %if.end126, label %do_atof_calc

if.end126:                                        ; preds = %if.end122
  %14 = load i8, i8* %z.addr.7, align 1, !tbaa !10
  switch i8 %14, label %if.end176 [
    i8 101, label %if.then133
    i8 69, label %if.then133
  ]

if.then133:                                       ; preds = %if.end126, %if.end126
  %add.ptr135 = getelementptr inbounds i8, i8* %z.addr.7, i64 %incr.0
  %inc136 = add nsw i32 %eType.2, 1
  %cmp137 = icmp ult i8* %add.ptr135, %zEnd.0
  br i1 %cmp137, label %if.end140, label %do_atof_calc

if.end140:                                        ; preds = %if.then133
  %15 = load i8, i8* %add.ptr135, align 1, !tbaa !10
  switch i8 %15, label %if.end155 [
    i8 45, label %if.then144
    i8 43, label %if.then151
  ]

if.then144:                                       ; preds = %if.end140
  %add.ptr146 = getelementptr inbounds i8, i8* %add.ptr135, i64 %incr.0
  br label %if.end155

if.then151:                                       ; preds = %if.end140
  %add.ptr153 = getelementptr inbounds i8, i8* %add.ptr135, i64 %incr.0
  br label %if.end155

if.end155:                                        ; preds = %if.then151, %if.then144, %if.end140
  %esign.0 = phi i32 [ -1, %if.then144 ], [ 1, %if.then151 ], [ 1, %if.end140 ]
  %z.addr.8 = phi i8* [ %add.ptr146, %if.then144 ], [ %add.ptr153, %if.then151 ], [ %add.ptr135, %if.end140 ]
  %cmp157498 = icmp ult i8* %z.addr.8, %zEnd.0
  br i1 %cmp157498, label %land.rhs159.preheader, label %if.end176

land.rhs159.preheader:                            ; preds = %if.end155
  %16 = load i8, i8* %z.addr.8, align 1, !tbaa !10
  %idxprom160622 = zext i8 %16 to i64
  %17 = add nsw i64 %idxprom160622, -48
  %tobool164623 = icmp ult i64 %17, 10
  br i1 %tobool164623, label %while.body166, label %if.end176

land.rhs159:                                      ; preds = %while.body166
  %18 = load i8, i8* %add.ptr174, align 1, !tbaa !10
  %idxprom160 = zext i8 %18 to i64
  %19 = add nsw i64 %idxprom160, -48
  %tobool164 = icmp ult i64 %19, 10
  br i1 %tobool164, label %while.body166, label %if.end176

while.body166:                                    ; preds = %land.rhs159, %land.rhs159.preheader
  %20 = phi i8 [ %18, %land.rhs159 ], [ %16, %land.rhs159.preheader ]
  %e.0499625 = phi i32 [ %cond, %land.rhs159 ], [ 0, %land.rhs159.preheader ]
  %z.addr.9501624 = phi i8* [ %add.ptr174, %land.rhs159 ], [ %z.addr.8, %land.rhs159.preheader ]
  %cmp167 = icmp slt i32 %e.0499625, 10000
  %mul169 = mul nsw i32 %e.0499625, 10
  %conv170 = sext i8 %20 to i32
  %sub171 = add i32 %mul169, -48
  %add172 = add i32 %sub171, %conv170
  %cond = select i1 %cmp167, i32 %add172, i32 10000
  %add.ptr174 = getelementptr inbounds i8, i8* %z.addr.9501624, i64 %incr.0
  %cmp157 = icmp ult i8* %add.ptr174, %zEnd.0
  br i1 %cmp157, label %land.rhs159, label %if.end176

if.end176:                                        ; preds = %while.body166, %land.rhs159, %land.rhs159.preheader, %if.end155, %if.end126
  %esign.1 = phi i32 [ 1, %if.end126 ], [ %esign.0, %if.end155 ], [ %esign.0, %land.rhs159.preheader ], [ %esign.0, %while.body166 ], [ %esign.0, %land.rhs159 ]
  %e.1 = phi i32 [ 0, %if.end126 ], [ 0, %if.end155 ], [ 0, %land.rhs159.preheader ], [ %cond, %while.body166 ], [ %cond, %land.rhs159 ]
  %eValid.1 = phi i32 [ 1, %if.end126 ], [ 0, %if.end155 ], [ 0, %land.rhs159.preheader ], [ 1, %while.body166 ], [ 1, %land.rhs159 ]
  %eType.3 = phi i32 [ %eType.2, %if.end126 ], [ %inc136, %if.end155 ], [ %inc136, %land.rhs159.preheader ], [ %inc136, %while.body166 ], [ %inc136, %land.rhs159 ]
  %z.addr.10 = phi i8* [ %z.addr.7, %if.end126 ], [ %z.addr.8, %if.end155 ], [ %z.addr.8, %land.rhs159.preheader ], [ %add.ptr174, %while.body166 ], [ %add.ptr174, %land.rhs159 ]
  %cmp178494 = icmp ult i8* %z.addr.10, %zEnd.0
  br i1 %cmp178494, label %land.rhs180, label %do_atof_calc

land.rhs180:                                      ; preds = %while.body187, %if.end176
  %z.addr.11495 = phi i8* [ %add.ptr189, %while.body187 ], [ %z.addr.10, %if.end176 ]
  %21 = load i8, i8* %z.addr.11495, align 1, !tbaa !10
  %idxprom181 = zext i8 %21 to i64
  %arrayidx182 = getelementptr inbounds [256 x i8], [256 x i8]* @sqlite3CtypeMap, i64 0, i64 %idxprom181
  %22 = load i8, i8* %arrayidx182, align 1, !tbaa !10
  %23 = and i8 %22, 1
  %tobool185 = icmp eq i8 %23, 0
  br i1 %tobool185, label %do_atof_calc, label %while.body187

while.body187:                                    ; preds = %land.rhs180
  %add.ptr189 = getelementptr inbounds i8, i8* %z.addr.11495, i64 %incr.0
  %cmp178 = icmp ult i8* %add.ptr189, %zEnd.0
  br i1 %cmp178, label %land.rhs180, label %do_atof_calc

do_atof_calc:                                     ; preds = %while.body187, %land.rhs180, %if.end176, %if.then133, %if.end122, %if.end85
  %s.4 = phi i64 [ %s.3, %if.end122 ], [ %s.3, %if.then133 ], [ %s.3, %if.end176 ], [ %s.3, %land.rhs180 ], [ %s.3, %while.body187 ], [ %add64, %if.end85 ]
  %d.6 = phi i32 [ %d.5, %if.end122 ], [ %d.5, %if.then133 ], [ %d.5, %if.end176 ], [ %d.5, %land.rhs180 ], [ %d.5, %while.body187 ], [ %d.2, %if.end85 ]
  %esign.2 = phi i32 [ 1, %if.end122 ], [ 1, %if.then133 ], [ %esign.1, %if.end176 ], [ %esign.1, %land.rhs180 ], [ %esign.1, %while.body187 ], [ 1, %if.end85 ]
  %e.2 = phi i32 [ 0, %if.end122 ], [ 0, %if.then133 ], [ %e.1, %if.end176 ], [ %e.1, %land.rhs180 ], [ %e.1, %while.body187 ], [ 0, %if.end85 ]
  %eValid.2 = phi i32 [ 1, %if.end122 ], [ 0, %if.then133 ], [ %eValid.1, %if.end176 ], [ %eValid.1, %land.rhs180 ], [ %eValid.1, %while.body187 ], [ 1, %if.end85 ]
  %nDigit.4 = phi i32 [ %nDigit.3, %if.end122 ], [ %nDigit.3, %if.then133 ], [ %nDigit.3, %if.end176 ], [ %nDigit.3, %land.rhs180 ], [ %nDigit.3, %while.body187 ], [ %inc, %if.end85 ]
  %eType.4 = phi i32 [ %eType.2, %if.end122 ], [ %inc136, %if.then133 ], [ %eType.3, %if.end176 ], [ %eType.3, %land.rhs180 ], [ %eType.3, %while.body187 ], [ %eType.1, %if.end85 ]
  %z.addr.12 = phi i8* [ %z.addr.7, %if.end122 ], [ %add.ptr135, %if.then133 ], [ %z.addr.10, %if.end176 ], [ %add.ptr189, %while.body187 ], [ %z.addr.11495, %land.rhs180 ], [ %z.addr.5, %if.end85 ]
  %mul191 = mul nsw i32 %e.2, %esign.2
  %add192 = add nsw i32 %mul191, %d.6
  %cmp193 = icmp slt i32 %add192, 0
  %mul196 = sub nsw i32 0, %add192
  %e.3 = select i1 %cmp193, i32 %mul196, i32 %add192
  %cmp199 = icmp eq i64 %s.4, 0
  br i1 %cmp199, label %if.then201, label %while.cond206.preheader

while.cond206.preheader:                          ; preds = %do_atof_calc
  %cmp207489 = icmp sgt i32 %e.3, 0
  br i1 %cmp207489, label %while.body209.lr.ph, label %while.end225

while.body209.lr.ph:                              ; preds = %while.cond206.preheader
  br i1 %cmp193, label %while.body209.us, label %while.body209

while.body209.us:                                 ; preds = %if.end222.us, %while.body209.lr.ph
  %e.4491.us = phi i32 [ %dec224.us, %if.end222.us ], [ %mul196, %while.body209.lr.ph ]
  %s.5490.us = phi i64 [ %div.us, %if.end222.us ], [ %s.4, %while.body209.lr.ph ]
  %rem.us = srem i64 %s.5490.us, 10
  %div.us = sdiv i64 %s.5490.us, 10
  %cmp219.us = icmp eq i64 %rem.us, 0
  br i1 %cmp219.us, label %if.end222.us, label %if.else237

if.end222.us:                                     ; preds = %while.body209.us
  %dec224.us = add nsw i32 %e.4491.us, -1
  %cmp207.us = icmp sgt i32 %e.4491.us, 1
  br i1 %cmp207.us, label %while.body209.us, label %while.end225

if.then201:                                       ; preds = %do_atof_calc, %if.end49
  %z.addr.12585 = phi i8* [ %z.addr.12, %do_atof_calc ], [ %z.addr.2, %if.end49 ]
  %eType.4583 = phi i32 [ %eType.4, %do_atof_calc ], [ %eType.1, %if.end49 ]
  %nDigit.4581 = phi i32 [ %nDigit.4, %do_atof_calc ], [ 0, %if.end49 ]
  %eValid.2579 = phi i32 [ %eValid.2, %do_atof_calc ], [ 1, %if.end49 ]
  %cmp202 = icmp slt i32 %sign.0, 0
  %cond204 = select i1 %cmp202, double -0.000000e+00, double 0.000000e+00
  br label %if.end286

while.body209:                                    ; preds = %if.end216, %while.body209.lr.ph
  %e.4491 = phi i32 [ %dec224, %if.end216 ], [ %add192, %while.body209.lr.ph ]
  %s.5490 = phi i64 [ %mul217, %if.end216 ], [ %s.4, %while.body209.lr.ph ]
  %cmp213 = icmp sgt i64 %s.5490, 922337203685477579
  br i1 %cmp213, label %if.else237, label %if.end216

if.end216:                                        ; preds = %while.body209
  %mul217 = mul nsw i64 %s.5490, 10
  %dec224 = add nsw i32 %e.4491, -1
  %cmp207 = icmp sgt i32 %e.4491, 1
  br i1 %cmp207, label %while.body209, label %while.end225

while.end225:                                     ; preds = %if.end216, %if.end222.us, %while.cond206.preheader
  %s.5.lcssa = phi i64 [ %s.4, %while.cond206.preheader ], [ %div.us, %if.end222.us ], [ %mul217, %if.end216 ]
  %e.4.lcssa = phi i32 [ %e.3, %while.cond206.preheader ], [ 0, %if.end222.us ], [ 0, %if.end216 ]
  %cmp226 = icmp slt i32 %sign.0, 0
  %sub229 = sub nsw i64 0, %s.5.lcssa
  %cond232 = select i1 %cmp226, i64 %sub229, i64 %s.5.lcssa
  %cmp233 = icmp eq i32 %e.4.lcssa, 0
  br i1 %cmp233, label %if.then235, label %if.else270

if.then235:                                       ; preds = %while.end225
  %conv236 = sitofp i64 %cond232 to double
  br label %if.end286

if.else237:                                       ; preds = %while.body209, %while.body209.us
  %s.5.lcssa483 = phi i64 [ %s.5490.us, %while.body209.us ], [ %s.5490, %while.body209 ]
  %e.4.lcssa481 = phi i32 [ %e.4491.us, %while.body209.us ], [ %e.4491, %while.body209 ]
  %cmp226472 = icmp slt i32 %sign.0, 0
  %sub229473 = sub nsw i64 0, %s.5.lcssa483
  %cond232474 = select i1 %cmp226472, i64 %sub229473, i64 %s.5.lcssa483
  %cmp238 = icmp sgt i32 %e.4.lcssa481, 307
  br i1 %cmp238, label %if.then240, label %if.else270

if.then240:                                       ; preds = %if.else237
  %cmp241 = icmp slt i32 %e.4.lcssa481, 342
  br i1 %cmp241, label %if.then243, label %if.else258

if.then243:                                       ; preds = %if.then240
  %sub244 = add nsw i32 %e.4.lcssa481, -308
  %and13.i = and i32 %sub244, 1
  %tobool14.i = icmp eq i32 %and13.i, 0
  %spec.select15.i = select i1 %tobool14.i, x86_fp80 0xK3FFF8000000000000000, x86_fp80 0xK4002A000000000000000
  %shr16.i = ashr i32 %sub244, 1
  %cmp17.i = icmp eq i32 %shr16.i, 0
  br i1 %cmp17.i, label %sqlite3Pow10.exit, label %if.end2.i

if.end2.i:                                        ; preds = %if.end2.i, %if.then243
  %shr20.i = phi i32 [ %shr.i, %if.end2.i ], [ %shr16.i, %if.then243 ]
  %spec.select19.i = phi x86_fp80 [ %spec.select.i, %if.end2.i ], [ %spec.select15.i, %if.then243 ]
  %x.018.i = phi x86_fp80 [ %mul3.i, %if.end2.i ], [ 0xK4002A000000000000000, %if.then243 ]
  %mul3.i = fmul x86_fp80 %x.018.i, %x.018.i
  %and.i = and i32 %shr20.i, 1
  %tobool.i = icmp eq i32 %and.i, 0
  %mul.i = fmul x86_fp80 %spec.select19.i, %mul3.i
  %spec.select.i = select i1 %tobool.i, x86_fp80 %spec.select19.i, x86_fp80 %mul.i
  %shr.i = ashr i32 %shr20.i, 1
  %cmp.i = icmp eq i32 %shr.i, 0
  br i1 %cmp.i, label %sqlite3Pow10.exit, label %if.end2.i

sqlite3Pow10.exit:                                ; preds = %if.end2.i, %if.then243
  %spec.select.lcssa.i = phi x86_fp80 [ %spec.select15.i, %if.then243 ], [ %spec.select.i, %if.end2.i ]
  %conv248 = sitofp i64 %cond232474 to x86_fp80
  br i1 %cmp193, label %if.then247, label %if.else252

if.then247:                                       ; preds = %sqlite3Pow10.exit
  %div249 = fdiv x86_fp80 %conv248, %spec.select.lcssa.i
  %conv250 = fptrunc x86_fp80 %div249 to double
  %div251 = fdiv double %conv250, 1.000000e+308
  br label %if.end286

if.else252:                                       ; preds = %sqlite3Pow10.exit
  %mul254 = fmul x86_fp80 %spec.select.lcssa.i, %conv248
  %conv255 = fptrunc x86_fp80 %mul254 to double
  %mul256 = fmul double %conv255, 1.000000e+308
  br label %if.end286

if.else258:                                       ; preds = %if.then240
  br i1 %cmp193, label %if.then261, label %if.else264

if.then261:                                       ; preds = %if.else258
  %conv262 = sitofp i64 %cond232474 to double
  %mul263 = fmul double %conv262, 0.000000e+00
  br label %if.end286

if.else264:                                       ; preds = %if.else258
  %conv265 = sitofp i64 %cond232474 to float
  %mul266 = fmul float %conv265, 0x7FF0000000000000
  %conv267 = fpext float %mul266 to double
  br label %if.end286

if.else270:                                       ; preds = %if.else237, %while.end225
  %e.4482 = phi i32 [ %e.4.lcssa481, %if.else237 ], [ %e.4.lcssa, %while.end225 ]
  %cond232476479 = phi i64 [ %cond232474, %if.else237 ], [ %cond232, %while.end225 ]
  %and13.i454 = and i32 %e.4482, 1
  %tobool14.i455 = icmp eq i32 %and13.i454, 0
  %spec.select15.i456 = select i1 %tobool14.i455, x86_fp80 0xK3FFF8000000000000000, x86_fp80 0xK4002A000000000000000
  %shr16.i457 = ashr i32 %e.4482, 1
  %cmp17.i458 = icmp eq i32 %shr16.i457, 0
  br i1 %cmp17.i458, label %sqlite3Pow10.exit471, label %if.end2.i469

if.end2.i469:                                     ; preds = %if.end2.i469, %if.else270
  %shr20.i459 = phi i32 [ %shr.i467, %if.end2.i469 ], [ %shr16.i457, %if.else270 ]
  %spec.select19.i460 = phi x86_fp80 [ %spec.select.i466, %if.end2.i469 ], [ %spec.select15.i456, %if.else270 ]
  %x.018.i461 = phi x86_fp80 [ %mul3.i462, %if.end2.i469 ], [ 0xK4002A000000000000000, %if.else270 ]
  %mul3.i462 = fmul x86_fp80 %x.018.i461, %x.018.i461
  %and.i463 = and i32 %shr20.i459, 1
  %tobool.i464 = icmp eq i32 %and.i463, 0
  %mul.i465 = fmul x86_fp80 %spec.select19.i460, %mul3.i462
  %spec.select.i466 = select i1 %tobool.i464, x86_fp80 %spec.select19.i460, x86_fp80 %mul.i465
  %shr.i467 = ashr i32 %shr20.i459, 1
  %cmp.i468 = icmp eq i32 %shr.i467, 0
  br i1 %cmp.i468, label %sqlite3Pow10.exit471, label %if.end2.i469

sqlite3Pow10.exit471:                             ; preds = %if.end2.i469, %if.else270
  %spec.select.lcssa.i470 = phi x86_fp80 [ %spec.select15.i456, %if.else270 ], [ %spec.select.i466, %if.end2.i469 ]
  %conv276 = sitofp i64 %cond232476479 to x86_fp80
  br i1 %cmp193, label %if.then275, label %if.else279

if.then275:                                       ; preds = %sqlite3Pow10.exit471
  %div277 = fdiv x86_fp80 %conv276, %spec.select.lcssa.i470
  br label %if.end283

if.else279:                                       ; preds = %sqlite3Pow10.exit471
  %mul281 = fmul x86_fp80 %spec.select.lcssa.i470, %conv276
  br label %if.end283

if.end283:                                        ; preds = %if.else279, %if.then275
  %result.1.in = phi x86_fp80 [ %div277, %if.then275 ], [ %mul281, %if.else279 ]
  %result.1 = fptrunc x86_fp80 %result.1.in to double
  br label %if.end286

if.end286:                                        ; preds = %if.end283, %if.else264, %if.then261, %if.else252, %if.then247, %if.then235, %if.then201
  %z.addr.12584 = phi i8* [ %z.addr.12585, %if.then201 ], [ %z.addr.12, %if.then235 ], [ %z.addr.12, %if.then261 ], [ %z.addr.12, %if.else264 ], [ %z.addr.12, %if.end283 ], [ %z.addr.12, %if.then247 ], [ %z.addr.12, %if.else252 ]
  %eType.4582 = phi i32 [ %eType.4583, %if.then201 ], [ %eType.4, %if.then235 ], [ %eType.4, %if.then261 ], [ %eType.4, %if.else264 ], [ %eType.4, %if.end283 ], [ %eType.4, %if.then247 ], [ %eType.4, %if.else252 ]
  %nDigit.4580 = phi i32 [ %nDigit.4581, %if.then201 ], [ %nDigit.4, %if.then235 ], [ %nDigit.4, %if.then261 ], [ %nDigit.4, %if.else264 ], [ %nDigit.4, %if.end283 ], [ %nDigit.4, %if.then247 ], [ %nDigit.4, %if.else252 ]
  %eValid.2578 = phi i32 [ %eValid.2579, %if.then201 ], [ %eValid.2, %if.then235 ], [ %eValid.2, %if.then261 ], [ %eValid.2, %if.else264 ], [ %eValid.2, %if.end283 ], [ %eValid.2, %if.then247 ], [ %eValid.2, %if.else252 ]
  %result.2 = phi double [ %cond204, %if.then201 ], [ %conv236, %if.then235 ], [ %mul263, %if.then261 ], [ %conv267, %if.else264 ], [ %result.1, %if.end283 ], [ %div251, %if.then247 ], [ %mul256, %if.else252 ]
  store double %result.2, double* %pResult, align 8, !tbaa !6
  %cmp287 = icmp eq i8* %z.addr.12584, %zEnd.0
  %cmp289 = icmp sgt i32 %nDigit.4580, 0
  %or.cond = and i1 %cmp289, %cmp287
  %tobool292 = icmp ne i32 %eValid.2578, 0
  %or.cond320 = and i1 %tobool292, %or.cond
  %cmp294 = icmp sgt i32 %eType.4582, 0
  %or.cond321 = and i1 %cmp294, %or.cond320
  br i1 %or.cond321, label %cleanup, label %if.else297

if.else297:                                       ; preds = %if.end286
  %cmp298 = icmp sgt i32 %eType.4582, 1
  br i1 %cmp298, label %land.lhs.true300, label %if.else309

land.lhs.true300:                                 ; preds = %if.else297
  %cmp301 = icmp eq i32 %eType.4582, 3
  %or.cond322 = or i1 %tobool292, %cmp301
  %or.cond323 = and i1 %cmp289, %or.cond322
  br i1 %or.cond323, label %cleanup, label %if.else309

if.else309:                                       ; preds = %land.lhs.true300, %if.else297
  br label %cleanup

cleanup:                                          ; preds = %if.else309, %land.lhs.true300, %if.end286, %while.body, %if.end20, %entry
  %retval.0 = phi i32 [ 0, %if.else309 ], [ 0, %entry ], [ %eType.4582, %if.end286 ], [ -1, %land.lhs.true300 ], [ 0, %if.end20 ], [ 0, %while.body ]
  ret i32 %retval.0
}

; Function Attrs: nounwind ssp uwtable
declare void @sqlite3_randomness(i32, i8*) #3

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare void @sqlite3VdbeMemIntegerify(%struct.sqlite3_value*) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare void @sqlite3UnlinkAndDeleteTable(%struct.sqlite3*, i32, i8*) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare void @sqlite3ExpirePreparedStatements(%struct.sqlite3*, i32) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i32 @sqlite3BtreeUpdateMeta(%struct.Btree*, i32, i32) #0

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3VdbeFreeCursor(%struct.Vdbe* nocapture readonly, %struct.VdbeCursor*) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3VdbeMemSetStr(%struct.sqlite3_value*, i8*, i32, i8 zeroext, void (i8*)*) unnamed_addr #3

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare void @sqlite3BtreeGetMeta(%struct.Btree*, i32, i32*) #0

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3VdbeMemCast(%struct.sqlite3_value*, i8 zeroext, i8 zeroext) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3BtreePrevious(%struct.BtCursor*, i32) #3

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i32 @sqlite3BtreeEof(%struct.BtCursor*) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i32 @sqlite3BtreeCursorHasHint(%struct.BtCursor*) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare void @sqlite3BtreeClearCursor(%struct.BtCursor*) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i64 @sqlite3VdbeIntValue(%struct.sqlite3_value*) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare void @sqlite3RowSetInsert(%struct.RowSet*, i64) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i32 @sqlite3RowSetTest(%struct.RowSet*, i32, i64) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i32 @sqlite3VdbeMemSetRowSet(%struct.sqlite3_value*) #0

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3DbFreeNN(%struct.sqlite3*, i8*) unnamed_addr #3

; Function Attrs: alwaysinline nounwind ssp uwtable
define dso_local void @sqlite3VdbeRecordUnpack(%struct.KeyInfo* nocapture readonly %pKeyInfo, i32 %nKey, i8* %pKey, %struct.UnpackedRecord* nocapture %p) unnamed_addr #4 {
entry:
  %v64.i71 = alloca i64, align 8
  %v64.i = alloca i64, align 8
  %aMem = getelementptr inbounds %struct.UnpackedRecord, %struct.UnpackedRecord* %p, i64 0, i32 1
  %0 = load %struct.sqlite3_value*, %struct.sqlite3_value** %aMem, align 8, !tbaa !11
  %default_rc = getelementptr inbounds %struct.UnpackedRecord, %struct.UnpackedRecord* %p, i64 0, i32 3
  store i8 0, i8* %default_rc, align 2, !tbaa !15
  %1 = load i8, i8* %pKey, align 1, !tbaa !10
  %cmp = icmp sgt i8 %1, -1
  %conv = zext i8 %1 to i32
  br i1 %cmp, label %cond.end, label %cond.false

cond.false:                                       ; preds = %entry
  %incdec.ptr.i = getelementptr inbounds i8, i8* %pKey, i64 1
  %2 = load i8, i8* %incdec.ptr.i, align 1, !tbaa !10
  %conv1.i = zext i8 %2 to i32
  %tobool.i = icmp slt i8 %2, 0
  br i1 %tobool.i, label %if.end.i, label %if.then.i

if.then.i:                                        ; preds = %cond.false
  %and2.i = shl nuw nsw i32 %conv, 7
  %shl.i = and i32 %and2.i, 16256
  %or.i = or i32 %shl.i, %conv1.i
  br label %cond.end

if.end.i:                                         ; preds = %cond.false
  %incdec.ptr3.i = getelementptr inbounds i8, i8* %pKey, i64 2
  %3 = load i8, i8* %incdec.ptr3.i, align 1, !tbaa !10
  %tobool8.i = icmp slt i8 %3, 0
  br i1 %tobool8.i, label %if.end14.i, label %if.then9.i

if.then9.i:                                       ; preds = %if.end.i
  %conv5.i = zext i8 %3 to i32
  %shl4.i = shl nuw nsw i32 %conv, 14
  %or6.i = or i32 %shl4.i, %conv5.i
  %and10.i = and i32 %or6.i, 2080895
  %and11.i = shl nuw nsw i32 %conv1.i, 7
  %shl12.i = and i32 %and11.i, 16256
  %or13.i = or i32 %and10.i, %shl12.i
  br label %cond.end

if.end14.i:                                       ; preds = %if.end.i
  %4 = bitcast i64* %v64.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %4) #5
  %call.i = call zeroext i8 @sqlite3GetVarint(i8* nonnull %pKey, i64* nonnull %v64.i) #5
  %5 = load i64, i64* %v64.i, align 8, !tbaa !16
  %6 = icmp ult i64 %5, 4294967295
  %storemerge43.i = select i1 %6, i64 %5, i64 4294967295
  %7 = trunc i64 %storemerge43.i to i32
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %4) #5
  %phitmp101 = zext i8 %call.i to i32
  br label %cond.end

cond.end:                                         ; preds = %if.end14.i, %if.then9.i, %if.then.i, %entry
  %szHdr.1 = phi i32 [ %conv, %entry ], [ %7, %if.end14.i ], [ %or13.i, %if.then9.i ], [ %or.i, %if.then.i ]
  %cond = phi i32 [ 1, %entry ], [ %phitmp101, %if.end14.i ], [ 3, %if.then9.i ], [ 2, %if.then.i ]
  %8 = bitcast i64* %v64.i71 to i8*
  %enc = getelementptr inbounds %struct.KeyInfo, %struct.KeyInfo* %pKeyInfo, i64 0, i32 1
  %db = getelementptr inbounds %struct.KeyInfo, %struct.KeyInfo* %pKeyInfo, i64 0, i32 4
  %9 = bitcast %struct.sqlite3** %db to i64*
  %nField = getelementptr inbounds %struct.UnpackedRecord, %struct.UnpackedRecord* %p, i64 0, i32 2
  br label %while.cond

while.cond:                                       ; preds = %cond.end22, %cond.end
  %d.0 = phi i32 [ %szHdr.1, %cond.end ], [ %add31, %cond.end22 ]
  %idx.0 = phi i32 [ %cond, %cond.end ], [ %add, %cond.end22 ]
  %u.0 = phi i16 [ 0, %cond.end ], [ %inc, %cond.end22 ]
  %pMem.0 = phi %struct.sqlite3_value* [ %0, %cond.end ], [ %incdec.ptr, %cond.end22 ]
  %cmp6 = icmp ult i32 %idx.0, %szHdr.1
  %cmp8 = icmp ule i32 %d.0, %nKey
  %10 = and i1 %cmp8, %cmp6
  br i1 %10, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  %idxprom = zext i32 %idx.0 to i64
  %arrayidx = getelementptr inbounds i8, i8* %pKey, i64 %idxprom
  %11 = load i8, i8* %arrayidx, align 1, !tbaa !10
  %cmp11 = icmp sgt i8 %11, -1
  %conv10 = zext i8 %11 to i32
  br i1 %cmp11, label %cond.end22, label %cond.false17

cond.false17:                                     ; preds = %while.body
  %incdec.ptr.i73 = getelementptr inbounds i8, i8* %arrayidx, i64 1
  %12 = load i8, i8* %incdec.ptr.i73, align 1, !tbaa !10
  %conv1.i74 = zext i8 %12 to i32
  %tobool.i75 = icmp slt i8 %12, 0
  br i1 %tobool.i75, label %if.end.i82, label %if.then.i79

if.then.i79:                                      ; preds = %cond.false17
  %and2.i76 = shl nuw nsw i32 %conv10, 7
  %shl.i77 = and i32 %and2.i76, 16256
  %or.i78 = or i32 %shl.i77, %conv1.i74
  br label %cond.end22

if.end.i82:                                       ; preds = %cond.false17
  %incdec.ptr3.i80 = getelementptr inbounds i8, i8* %arrayidx, i64 2
  %13 = load i8, i8* %incdec.ptr3.i80, align 1, !tbaa !10
  %tobool8.i81 = icmp slt i8 %13, 0
  br i1 %tobool8.i81, label %if.end14.i93, label %if.then9.i90

if.then9.i90:                                     ; preds = %if.end.i82
  %conv5.i83 = zext i8 %13 to i32
  %shl4.i84 = shl nuw nsw i32 %conv10, 14
  %or6.i85 = or i32 %shl4.i84, %conv5.i83
  %and10.i86 = and i32 %or6.i85, 2080895
  %and11.i87 = shl nuw nsw i32 %conv1.i74, 7
  %shl12.i88 = and i32 %and11.i87, 16256
  %or13.i89 = or i32 %and10.i86, %shl12.i88
  br label %cond.end22

if.end14.i93:                                     ; preds = %if.end.i82
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %8) #5
  %call.i91 = call zeroext i8 @sqlite3GetVarint(i8* nonnull %arrayidx, i64* nonnull %v64.i71) #5
  %14 = load i64, i64* %v64.i71, align 8, !tbaa !16
  %15 = icmp ult i64 %14, 4294967295
  %storemerge43.i92 = select i1 %15, i64 %14, i64 4294967295
  %16 = trunc i64 %storemerge43.i92 to i32
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %8) #5
  br label %cond.end22

cond.end22:                                       ; preds = %if.end14.i93, %if.then9.i90, %if.then.i79, %while.body
  %serial_type.1 = phi i32 [ %16, %if.end14.i93 ], [ %or13.i89, %if.then9.i90 ], [ %or.i78, %if.then.i79 ], [ %conv10, %while.body ]
  %cond23 = phi i8 [ %call.i91, %if.end14.i93 ], [ 3, %if.then9.i90 ], [ 2, %if.then.i79 ], [ 1, %while.body ]
  %conv25 = zext i8 %cond23 to i32
  %add = add i32 %idx.0, %conv25
  %17 = load i8, i8* %enc, align 4, !tbaa !18
  %enc26 = getelementptr inbounds %struct.sqlite3_value, %struct.sqlite3_value* %pMem.0, i64 0, i32 2
  store i8 %17, i8* %enc26, align 2, !tbaa !21
  %18 = load i64, i64* %9, align 8, !tbaa !23
  %db27 = getelementptr inbounds %struct.sqlite3_value, %struct.sqlite3_value* %pMem.0, i64 0, i32 9
  %19 = bitcast %struct.sqlite3** %db27 to i64*
  store i64 %18, i64* %19, align 8, !tbaa !24
  %szMalloc = getelementptr inbounds %struct.sqlite3_value, %struct.sqlite3_value* %pMem.0, i64 0, i32 7
  store i32 0, i32* %szMalloc, align 8, !tbaa !25
  %z = getelementptr inbounds %struct.sqlite3_value, %struct.sqlite3_value* %pMem.0, i64 0, i32 5
  store i8* null, i8** %z, align 8, !tbaa !26
  %idxprom28 = zext i32 %d.0 to i64
  %arrayidx29 = getelementptr inbounds i8, i8* %pKey, i64 %idxprom28
  %call30 = call i32 @sqlite3VdbeSerialGet(i8* nonnull %arrayidx29, i32 %serial_type.1, %struct.sqlite3_value* %pMem.0)
  %add31 = add i32 %call30, %d.0
  %incdec.ptr = getelementptr inbounds %struct.sqlite3_value, %struct.sqlite3_value* %pMem.0, i64 1
  %inc = add nuw i16 %u.0, 1
  %20 = load i16, i16* %nField, align 8, !tbaa !27
  %cmp34 = icmp ult i16 %inc, %20
  br i1 %cmp34, label %while.cond, label %while.end

while.end:                                        ; preds = %cond.end22, %while.cond
  %d.1 = phi i32 [ %add31, %cond.end22 ], [ %d.0, %while.cond ]
  %u.1 = phi i16 [ %inc, %cond.end22 ], [ %u.0, %while.cond ]
  %pMem.1 = phi %struct.sqlite3_value* [ %incdec.ptr, %cond.end22 ], [ %pMem.0, %while.cond ]
  %cmp36 = icmp ule i32 %d.1, %nKey
  %tobool = icmp eq i16 %u.1, 0
  %or.cond = or i1 %cmp36, %tobool
  br i1 %or.cond, label %if.end40, label %if.then39

if.then39:                                        ; preds = %while.end
  %flags.i = getelementptr inbounds %struct.sqlite3_value, %struct.sqlite3_value* %pMem.1, i64 -1, i32 1
  %21 = load i16, i16* %flags.i, align 8, !tbaa !28
  %22 = and i16 %21, 9216
  %cmp.i = icmp eq i16 %22, 0
  br i1 %cmp.i, label %if.else.i, label %if.then.i96

if.then.i96:                                      ; preds = %if.then39
  %add.ptr = getelementptr inbounds %struct.sqlite3_value, %struct.sqlite3_value* %pMem.1, i64 -1
  call void @vdbeMemClearExternAndSetNull(%struct.sqlite3_value* nonnull %add.ptr) #5
  br label %if.end40

if.else.i:                                        ; preds = %if.then39
  store i16 1, i16* %flags.i, align 8, !tbaa !28
  br label %if.end40

if.end40:                                         ; preds = %if.else.i, %if.then.i96, %while.end
  store i16 %u.1, i16* %nField, align 8, !tbaa !27
  ret void
}

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare %struct.UnpackedRecord* @sqlite3VdbeAllocUnpackedRecord(%struct.KeyInfo*) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i32 @sqlite3BtreeCreateTable(%struct.Btree*, i32*, i32) #0

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3BtreeOpen(%struct.sqlite3_vfs*, i8*, %struct.sqlite3*, %struct.Btree** nocapture, i32, i32) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3BtreeMovetoUnpacked(%struct.BtCursor*, %struct.UnpackedRecord*, i64, i32, i32* nocapture) unnamed_addr #3

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i32 @sqlite3BtreeLast(%struct.BtCursor*, i32*) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i32 @sqlite3BtreeCursorIsValidNN(%struct.BtCursor*) #0

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3BtreeInsert(%struct.BtCursor*, %struct.BtreePayload* nocapture readonly, i32, i32) unnamed_addr #3

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i32 @sqlite3VdbeIdxKeyCompare(%struct.sqlite3*, %struct.VdbeCursor*, %struct.UnpackedRecord*, i32*) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i32 @sqlite3VdbeCursorRestore(%struct.VdbeCursor*) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i32 @sqlite3VdbeIdxRowid(%struct.sqlite3*, %struct.BtCursor*, i64*) #0

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3BtreeDelete(%struct.BtCursor*, i8 zeroext) unnamed_addr #3

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i64 @sqlite3BtreeIntegerKey(%struct.BtCursor*) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i32 @sqlite3BtreeClearTable(%struct.Btree*, i32, i32*) #0

; Function Attrs: noinline nounwind ssp uwtable
declare zeroext i16 @computeNumericType(%struct.sqlite3_value*) local_unnamed_addr #1

; Function Attrs: nounwind ssp uwtable
declare i8* @sqlite3_value_text(%struct.sqlite3_value*) #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3VdbeError(%struct.Vdbe* nocapture, i8*, ...) unnamed_addr #3

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i32 @sqlite3VdbeBooleanValue(%struct.sqlite3_value*, i32) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i32 @sqlite3VdbeMemTooBig(%struct.sqlite3_value*) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i32 @sqlite3VdbeMemStringify(%struct.sqlite3_value*, i8, i8) #0

; Function Attrs: alwaysinline nounwind ssp uwtable
define void @applyNumericAffinity(%struct.sqlite3_value* nocapture %pRec, i32 %bTryForInt) local_unnamed_addr #4 {
entry:
  %rValue = alloca double, align 8
  %0 = bitcast double* %rValue to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %0) #5
  %enc1 = getelementptr inbounds %struct.sqlite3_value, %struct.sqlite3_value* %pRec, i64 0, i32 2
  %1 = load i8, i8* %enc1, align 2, !tbaa !21
  %z = getelementptr inbounds %struct.sqlite3_value, %struct.sqlite3_value* %pRec, i64 0, i32 5
  %2 = load i8*, i8** %z, align 8, !tbaa !26
  %n = getelementptr inbounds %struct.sqlite3_value, %struct.sqlite3_value* %pRec, i64 0, i32 4
  %3 = load i32, i32* %n, align 4, !tbaa !29
  %call = call i32 @sqlite3AtoF(i8* %2, double* nonnull %rValue, i32 %3, i8 zeroext %1)
  %cmp = icmp slt i32 %call, 1
  br i1 %cmp, label %cleanup, label %if.end

if.end:                                           ; preds = %entry
  %cmp2 = icmp eq i32 %call, 1
  %4 = load double, double* %rValue, align 8, !tbaa !6
  %i = bitcast %struct.sqlite3_value* %pRec to i64*
  br i1 %cmp2, label %land.lhs.true, label %if.else

land.lhs.true:                                    ; preds = %if.end
  %conv.i = fptosi double %4 to i64
  %cmp.i.i = fcmp oeq double %4, 0.000000e+00
  br i1 %cmp.i.i, label %alsoAnInt.exit.thread, label %lor.rhs.i.i

lor.rhs.i.i:                                      ; preds = %land.lhs.true
  %5 = bitcast double %4 to i64
  %conv.i.i = sitofp i64 %conv.i to double
  %6 = bitcast double %conv.i.i to i64
  %7 = icmp ne i64 %5, %6
  %conv.off.i = add i64 %conv.i, 2251799813685248
  %8 = icmp ugt i64 %conv.off.i, 4503599627370495
  %9 = or i1 %8, %7
  br i1 %9, label %alsoAnInt.exit, label %alsoAnInt.exit.thread

alsoAnInt.exit.thread:                            ; preds = %lor.rhs.i.i, %land.lhs.true
  store i64 %conv.i, i64* %i, align 8, !tbaa !16
  br label %if.then4

alsoAnInt.exit:                                   ; preds = %lor.rhs.i.i
  %10 = load i8*, i8** %z, align 8, !tbaa !26
  %11 = load i32, i32* %n, align 4, !tbaa !29
  %12 = load i8, i8* %enc1, align 2, !tbaa !21
  %call1.i = call i32 @sqlite3Atoi64(i8* %10, i64* %i, i32 %11, i8 zeroext %12) #5
  %cmp.i = icmp eq i32 %call1.i, 0
  br i1 %cmp.i, label %if.then4, label %if.else

if.then4:                                         ; preds = %alsoAnInt.exit, %alsoAnInt.exit.thread
  %flags = getelementptr inbounds %struct.sqlite3_value, %struct.sqlite3_value* %pRec, i64 0, i32 1
  %13 = load i16, i16* %flags, align 8, !tbaa !28
  %14 = or i16 %13, 4
  store i16 %14, i16* %flags, align 8, !tbaa !28
  br label %if.end14

if.else:                                          ; preds = %alsoAnInt.exit, %if.end
  %15 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %pRec, i64 0, i32 0, i32 0
  store double %4, double* %15, align 8, !tbaa !10
  %flags7 = getelementptr inbounds %struct.sqlite3_value, %struct.sqlite3_value* %pRec, i64 0, i32 1
  %16 = load i16, i16* %flags7, align 8, !tbaa !28
  %17 = or i16 %16, 8
  store i16 %17, i16* %flags7, align 8, !tbaa !28
  %tobool11 = icmp eq i32 %bTryForInt, 0
  br i1 %tobool11, label %if.end14, label %if.then12

if.then12:                                        ; preds = %if.else
  %call.i = call i64 @doubleToInt64(double %4) #5
  %conv.i31 = sitofp i64 %call.i to double
  %cmp.i32 = fcmp oeq double %4, %conv.i31
  %18 = add i64 %call.i, -9223372036854775807
  %19 = icmp ugt i64 %18, 1
  %20 = and i1 %19, %cmp.i32
  br i1 %20, label %if.then.i33, label %if.end14

if.then.i33:                                      ; preds = %if.then12
  store i64 %call.i, i64* %i, align 8, !tbaa !10
  %21 = and i16 %16, 15936
  %22 = or i16 %21, 4
  store i16 %22, i16* %flags7, align 8, !tbaa !28
  br label %if.end14

if.end14:                                         ; preds = %if.then.i33, %if.then12, %if.else, %if.then4
  %23 = phi i16 [ %22, %if.then.i33 ], [ %17, %if.then12 ], [ %17, %if.else ], [ %14, %if.then4 ]
  %flags15 = getelementptr inbounds %struct.sqlite3_value, %struct.sqlite3_value* %pRec, i64 0, i32 1
  %24 = and i16 %23, -3
  store i16 %24, i16* %flags15, align 8, !tbaa !28
  br label %cleanup

cleanup:                                          ; preds = %if.end14, %entry
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %0) #5
  ret void
}

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i32 @sqlite3IsNaN(double) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare double @sqlite3VdbeRealValue(%struct.sqlite3_value*) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i32 @sqlite3MulInt64(i64*, i64) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i32 @sqlite3SubInt64(i64*, i64) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i32 @sqlite3AddInt64(i64*, i64) #0

; Function Attrs: alwaysinline nounwind ssp uwtable
define zeroext i16 @numericType(%struct.sqlite3_value* %pMem) local_unnamed_addr #4 {
entry:
  %flags = getelementptr inbounds %struct.sqlite3_value, %struct.sqlite3_value* %pMem, i64 0, i32 1
  %0 = load i16, i16* %flags, align 8, !tbaa !28
  %conv = zext i16 %0 to i32
  %and = and i32 %conv, 44
  %tobool = icmp eq i32 %and, 0
  br i1 %tobool, label %if.end, label %if.then

if.then:                                          ; preds = %entry
  %conv4 = trunc i32 %and to i16
  br label %return

if.end:                                           ; preds = %entry
  %and7 = and i32 %conv, 18
  %tobool8 = icmp eq i32 %and7, 0
  br i1 %tobool8, label %return, label %if.then9

if.then9:                                         ; preds = %if.end
  %call = call zeroext i16 @computeNumericType(%struct.sqlite3_value* nonnull %pMem)
  br label %return

return:                                           ; preds = %if.then9, %if.end, %if.then
  %retval.0 = phi i16 [ %conv4, %if.then ], [ %call, %if.then9 ], [ 0, %if.end ]
  ret i16 %retval.0
}

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare void @sqlite3VdbeMemMove(%struct.sqlite3_value*, %struct.sqlite3_value*) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i32 @"#VDBE_EXEC_NAME"(%struct.Vdbe*) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i32 @sqlite3BtreeCursorIsValid(%struct.BtCursor*) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i32 @sqlite3VdbeSerialPut(i8*, %struct.sqlite3_value*, i32) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i32 @sqlite3PutVarint(i8*, i64) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i32 @sqlite3VdbeMemClearAndResize(%struct.sqlite3_value*, i32) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i32 @sqlite3VarintLen(i64) #0

; Function Attrs: alwaysinline nounwind ssp uwtable
define void @applyAffinity(%struct.sqlite3_value* %pRec, i8 signext %affinity, i8 zeroext %enc) local_unnamed_addr #4 {
entry:
  %acc.i = alloca %struct.sqlite3_str, align 8
  %cmp = icmp sgt i8 %affinity, 66
  br i1 %cmp, label %if.then, label %if.else18

if.then:                                          ; preds = %entry
  %flags = getelementptr inbounds %struct.sqlite3_value, %struct.sqlite3_value* %pRec, i64 0, i32 1
  %0 = load i16, i16* %flags, align 8, !tbaa !28
  %conv2 = zext i16 %0 to i32
  %and = and i32 %conv2, 4
  %cmp3 = icmp eq i32 %and, 0
  br i1 %cmp3, label %if.then5, label %if.end41

if.then5:                                         ; preds = %if.then
  %and8 = and i32 %conv2, 8
  %cmp9 = icmp eq i32 %and8, 0
  br i1 %cmp9, label %if.then11, label %if.else

if.then11:                                        ; preds = %if.then5
  %and14 = and i32 %conv2, 2
  %tobool = icmp eq i32 %and14, 0
  br i1 %tobool, label %if.end41, label %if.then15

if.then15:                                        ; preds = %if.then11
  call void @applyNumericAffinity(%struct.sqlite3_value* nonnull %pRec, i32 1)
  br label %if.end41

if.else:                                          ; preds = %if.then5
  %r.i = getelementptr inbounds %struct.sqlite3_value, %struct.sqlite3_value* %pRec, i64 0, i32 0, i32 0
  %1 = load double, double* %r.i, align 8, !tbaa !10
  %call.i = call i64 @doubleToInt64(double %1) #5
  %conv.i = sitofp i64 %call.i to double
  %cmp.i = fcmp oeq double %1, %conv.i
  %2 = add i64 %call.i, -9223372036854775807
  %3 = icmp ugt i64 %2, 1
  %4 = and i1 %3, %cmp.i
  br i1 %4, label %if.then.i, label %if.end41

if.then.i:                                        ; preds = %if.else
  %i.i = bitcast %struct.sqlite3_value* %pRec to i64*
  store i64 %call.i, i64* %i.i, align 8, !tbaa !10
  %5 = and i16 %0, 15936
  %6 = or i16 %5, 4
  store i16 %6, i16* %flags, align 8, !tbaa !28
  br label %if.end41

if.else18:                                        ; preds = %entry
  %cmp20 = icmp eq i8 %affinity, 66
  br i1 %cmp20, label %if.then22, label %if.end41

if.then22:                                        ; preds = %if.else18
  %flags23 = getelementptr inbounds %struct.sqlite3_value, %struct.sqlite3_value* %pRec, i64 0, i32 1
  %7 = load i16, i16* %flags23, align 8, !tbaa !28
  %conv24 = zext i16 %7 to i32
  %and25 = and i32 %conv24, 2
  %cmp26 = icmp ne i32 %and25, 0
  %and31 = and i32 %conv24, 44
  %tobool32 = icmp eq i32 %and31, 0
  %or.cond = or i1 %cmp26, %tobool32
  br i1 %or.cond, label %if.end35, label %if.then33

if.then33:                                        ; preds = %if.then22
  %szMalloc.i = getelementptr inbounds %struct.sqlite3_value, %struct.sqlite3_value* %pRec, i64 0, i32 7
  %8 = load i32, i32* %szMalloc.i, align 8, !tbaa !25
  %cmp.i54 = icmp slt i32 %8, 32
  br i1 %cmp.i54, label %sqlite3VdbeMemClearAndResize.exit, label %sqlite3VdbeMemClearAndResize.exit.thread

sqlite3VdbeMemClearAndResize.exit.thread:         ; preds = %if.then33
  %zMalloc.i = getelementptr inbounds %struct.sqlite3_value, %struct.sqlite3_value* %pRec, i64 0, i32 6
  %9 = bitcast i8** %zMalloc.i to i64*
  %10 = load i64, i64* %9, align 8, !tbaa !30
  %z.i57 = getelementptr inbounds %struct.sqlite3_value, %struct.sqlite3_value* %pRec, i64 0, i32 5
  %11 = bitcast i8** %z.i57 to i64*
  store i64 %10, i64* %11, align 8, !tbaa !26
  %12 = and i16 %7, 45
  store i16 %12, i16* %flags23, align 8, !tbaa !28
  %13 = inttoptr i64 %10 to i8*
  br label %lor.lhs.false.i.i

sqlite3VdbeMemClearAndResize.exit:                ; preds = %if.then33
  %call.i55 = call i32 @sqlite3VdbeMemGrow(%struct.sqlite3_value* nonnull %pRec, i32 32, i32 0) #5
  %tobool.i = icmp eq i32 %call.i55, 0
  br i1 %tobool.i, label %sqlite3VdbeMemClearAndResize.exit.lor.lhs.false.i.i_crit_edge, label %if.then.i51

sqlite3VdbeMemClearAndResize.exit.lor.lhs.false.i.i_crit_edge: ; preds = %sqlite3VdbeMemClearAndResize.exit
  %z.i.phi.trans.insert = getelementptr inbounds %struct.sqlite3_value, %struct.sqlite3_value* %pRec, i64 0, i32 5
  %.pre = load i8*, i8** %z.i.phi.trans.insert, align 8, !tbaa !26
  %.pre68 = load i16, i16* %flags23, align 8, !tbaa !28
  br label %lor.lhs.false.i.i

if.then.i51:                                      ; preds = %sqlite3VdbeMemClearAndResize.exit
  %enc1.i = getelementptr inbounds %struct.sqlite3_value, %struct.sqlite3_value* %pRec, i64 0, i32 2
  store i8 0, i8* %enc1.i, align 2, !tbaa !21
  br label %if.end35

lor.lhs.false.i.i:                                ; preds = %sqlite3VdbeMemClearAndResize.exit.lor.lhs.false.i.i_crit_edge, %sqlite3VdbeMemClearAndResize.exit.thread
  %14 = phi i16 [ %.pre68, %sqlite3VdbeMemClearAndResize.exit.lor.lhs.false.i.i_crit_edge ], [ %12, %sqlite3VdbeMemClearAndResize.exit.thread ]
  %15 = phi i8* [ %.pre, %sqlite3VdbeMemClearAndResize.exit.lor.lhs.false.i.i_crit_edge ], [ %13, %sqlite3VdbeMemClearAndResize.exit.thread ]
  %z.i = getelementptr inbounds %struct.sqlite3_value, %struct.sqlite3_value* %pRec, i64 0, i32 5
  %16 = bitcast %struct.sqlite3_str* %acc.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 32, i8* nonnull %16) #5
  %zText.i.i = getelementptr inbounds %struct.sqlite3_str, %struct.sqlite3_str* %acc.i, i64 0, i32 1
  store i8* %15, i8** %zText.i.i, align 8, !tbaa !31
  %db1.i.i = getelementptr inbounds %struct.sqlite3_str, %struct.sqlite3_str* %acc.i, i64 0, i32 0
  store %struct.sqlite3* null, %struct.sqlite3** %db1.i.i, align 8, !tbaa !33
  %nAlloc.i.i = getelementptr inbounds %struct.sqlite3_str, %struct.sqlite3_str* %acc.i, i64 0, i32 2
  store i32 32, i32* %nAlloc.i.i, align 8, !tbaa !34
  %mxAlloc.i.i = getelementptr inbounds %struct.sqlite3_str, %struct.sqlite3_str* %acc.i, i64 0, i32 3
  %nChar.i.i = getelementptr inbounds %struct.sqlite3_str, %struct.sqlite3_str* %acc.i, i64 0, i32 4
  %17 = bitcast i32* %mxAlloc.i.i to i8*
  call void @llvm.memset.p0i8.i64(i8* nonnull align 4 dereferenceable(10) %17, i8 0, i64 10, i1 false) #5
  %conv.i61 = zext i16 %14 to i32
  %and.i = and i32 %conv.i61, 4
  %tobool.i62 = icmp eq i32 %and.i, 0
  br i1 %tobool.i62, label %if.else.i, label %if.then.i64

if.then.i64:                                      ; preds = %lor.lhs.false.i.i
  %i.i63 = bitcast %struct.sqlite3_value* %pRec to i64*
  %18 = load i64, i64* %i.i63, align 8, !tbaa !10
  call void (%struct.sqlite3_str*, i8*, ...) @sqlite3_str_appendf(%struct.sqlite3_str* nonnull %acc.i, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.24, i64 0, i64 0), i64 %18) #5
  br label %vdbeMemRenderNum.exit

if.else.i:                                        ; preds = %lor.lhs.false.i.i
  %and3.i = and i32 %conv.i61, 32
  %tobool4.i = icmp eq i32 %and3.i, 0
  br i1 %tobool4.i, label %if.else9.i, label %if.then5.i

if.then5.i:                                       ; preds = %if.else.i
  %i7.i = bitcast %struct.sqlite3_value* %pRec to i64*
  %19 = load i64, i64* %i7.i, align 8, !tbaa !10
  %conv8.i = sitofp i64 %19 to double
  call void (%struct.sqlite3_str*, i8*, ...) @sqlite3_str_appendf(%struct.sqlite3_str* nonnull %acc.i, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.148, i64 0, i64 0), double %conv8.i) #5
  br label %vdbeMemRenderNum.exit

if.else9.i:                                       ; preds = %if.else.i
  %r.i65 = getelementptr inbounds %struct.sqlite3_value, %struct.sqlite3_value* %pRec, i64 0, i32 0, i32 0
  %20 = load double, double* %r.i65, align 8, !tbaa !10
  call void (%struct.sqlite3_str*, i8*, ...) @sqlite3_str_appendf(%struct.sqlite3_str* nonnull %acc.i, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.148, i64 0, i64 0), double %20) #5
  br label %vdbeMemRenderNum.exit

vdbeMemRenderNum.exit:                            ; preds = %if.else9.i, %if.then5.i, %if.then.i64
  %21 = load i32, i32* %nChar.i.i, align 8, !tbaa !35
  %idxprom.i = zext i32 %21 to i64
  %arrayidx.i = getelementptr inbounds i8, i8* %15, i64 %idxprom.i
  store i8 0, i8* %arrayidx.i, align 1, !tbaa !10
  call void @llvm.lifetime.end.p0i8(i64 32, i8* nonnull %16) #5
  %22 = load i8*, i8** %z.i, align 8, !tbaa !26
  %call3.i = call i64 @strlen(i8* nonnull dereferenceable(1) %22) #5
  %23 = trunc i64 %call3.i to i32
  %conv.i52 = and i32 %23, 1073741823
  %n.i = getelementptr inbounds %struct.sqlite3_value, %struct.sqlite3_value* %pRec, i64 0, i32 4
  store i32 %conv.i52, i32* %n.i, align 4, !tbaa !29
  %enc4.i = getelementptr inbounds %struct.sqlite3_value, %struct.sqlite3_value* %pRec, i64 0, i32 2
  store i8 1, i8* %enc4.i, align 2, !tbaa !21
  %24 = load i16, i16* %flags23, align 8, !tbaa !28
  %25 = and i16 %24, -559
  %26 = or i16 %25, 514
  store i16 %26, i16* %flags23, align 8, !tbaa !28
  %cmp.i.i = icmp eq i8 %enc, 1
  br i1 %cmp.i.i, label %if.end35, label %if.end.i.i

if.end.i.i:                                       ; preds = %vdbeMemRenderNum.exit
  %call.i.i = call i32 @sqlite3VdbeMemTranslate(%struct.sqlite3_value* nonnull %pRec, i8 zeroext %enc) #5
  br label %if.end35

if.end35:                                         ; preds = %if.end.i.i, %vdbeMemRenderNum.exit, %if.then.i51, %if.then22
  %27 = load i16, i16* %flags23, align 8, !tbaa !28
  %28 = and i16 %27, -45
  store i16 %28, i16* %flags23, align 8, !tbaa !28
  br label %if.end41

if.end41:                                         ; preds = %if.end35, %if.else18, %if.then.i, %if.else, %if.then15, %if.then11, %if.then
  ret void
}

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i32 @sqlite3VdbeSorterInit(%struct.sqlite3*, i32, %struct.VdbeCursor*) #0

; Function Attrs: alwaysinline nounwind ssp uwtable
define dso_local i32 @sqlite3MemCompare(%struct.sqlite3_value* %pMem1, %struct.sqlite3_value* %pMem2, %struct.CollSeq* readonly %pColl) unnamed_addr #4 {
entry:
  %flags = getelementptr inbounds %struct.sqlite3_value, %struct.sqlite3_value* %pMem1, i64 0, i32 1
  %0 = load i16, i16* %flags, align 8, !tbaa !28
  %conv = zext i16 %0 to i32
  %flags1 = getelementptr inbounds %struct.sqlite3_value, %struct.sqlite3_value* %pMem2, i64 0, i32 1
  %1 = load i16, i16* %flags1, align 8, !tbaa !28
  %conv2 = zext i16 %1 to i32
  %or164 = or i16 %1, %0
  %or = zext i16 %or164 to i32
  %and = and i32 %or, 1
  %tobool = icmp eq i32 %and, 0
  br i1 %tobool, label %if.end, label %if.then

if.then:                                          ; preds = %entry
  %and3 = and i32 %conv2, 1
  %and4 = and i32 %conv, 1
  %sub = sub nsw i32 %and3, %and4
  br label %cleanup

if.end:                                           ; preds = %entry
  %and5 = and i32 %or, 44
  %tobool6 = icmp eq i32 %and5, 0
  br i1 %tobool6, label %if.end98, label %if.then7

if.then7:                                         ; preds = %if.end
  %and8165 = and i16 %1, %0
  %and8 = zext i16 %and8165 to i32
  %and9 = and i32 %and8, 36
  %cmp = icmp eq i32 %and9, 0
  br i1 %cmp, label %if.end26, label %if.then11

if.then11:                                        ; preds = %if.then7
  %i = bitcast %struct.sqlite3_value* %pMem1 to i64*
  %2 = load i64, i64* %i, align 8, !tbaa !10
  %i13 = bitcast %struct.sqlite3_value* %pMem2 to i64*
  %3 = load i64, i64* %i13, align 8, !tbaa !10
  %cmp14 = icmp slt i64 %2, %3
  br i1 %cmp14, label %cleanup, label %if.end17

if.end17:                                         ; preds = %if.then11
  %cmp22 = icmp sgt i64 %2, %3
  %. = zext i1 %cmp22 to i32
  br label %cleanup

if.end26:                                         ; preds = %if.then7
  %and28 = and i32 %and8, 8
  %cmp29 = icmp eq i32 %and28, 0
  br i1 %cmp29, label %if.end47, label %if.then31

if.then31:                                        ; preds = %if.end26
  %r = getelementptr inbounds %struct.sqlite3_value, %struct.sqlite3_value* %pMem1, i64 0, i32 0, i32 0
  %4 = load double, double* %r, align 8, !tbaa !10
  %r34 = getelementptr inbounds %struct.sqlite3_value, %struct.sqlite3_value* %pMem2, i64 0, i32 0, i32 0
  %5 = load double, double* %r34, align 8, !tbaa !10
  %cmp35 = fcmp olt double %4, %5
  br i1 %cmp35, label %cleanup, label %if.end38

if.end38:                                         ; preds = %if.then31
  %cmp43 = fcmp ogt double %4, %5
  %.166 = zext i1 %cmp43 to i32
  br label %cleanup

if.end47:                                         ; preds = %if.end26
  %and48 = and i32 %conv, 36
  %cmp49 = icmp eq i32 %and48, 0
  br i1 %cmp49, label %if.end81, label %if.then51

if.then51:                                        ; preds = %if.end47
  %and52 = and i32 %conv2, 8
  %cmp53 = icmp eq i32 %and52, 0
  br i1 %cmp53, label %if.else, label %if.then55

if.then55:                                        ; preds = %if.then51
  %i57 = bitcast %struct.sqlite3_value* %pMem1 to i64*
  %6 = load i64, i64* %i57, align 8, !tbaa !10
  %r59 = getelementptr inbounds %struct.sqlite3_value, %struct.sqlite3_value* %pMem2, i64 0, i32 0, i32 0
  %7 = load double, double* %r59, align 8, !tbaa !10
  %conv.i = sitofp i64 %6 to x86_fp80
  %conv1.i = fpext double %7 to x86_fp80
  %cmp.i = fcmp olt x86_fp80 %conv.i, %conv1.i
  %cmp4.i = fcmp ogt x86_fp80 %conv.i, %conv1.i
  %..i = zext i1 %cmp4.i to i32
  %retval.0.i = select i1 %cmp.i, i32 -1, i32 %..i
  br label %cleanup

if.else:                                          ; preds = %if.then51
  %and60 = and i32 %conv2, 36
  %cmp61 = icmp eq i32 %and60, 0
  br i1 %cmp61, label %cleanup, label %if.then63

if.then63:                                        ; preds = %if.else
  %i65 = bitcast %struct.sqlite3_value* %pMem1 to i64*
  %8 = load i64, i64* %i65, align 8, !tbaa !10
  %i67 = bitcast %struct.sqlite3_value* %pMem2 to i64*
  %9 = load i64, i64* %i67, align 8, !tbaa !10
  %cmp68 = icmp slt i64 %8, %9
  br i1 %cmp68, label %cleanup, label %if.end71

if.end71:                                         ; preds = %if.then63
  %cmp76 = icmp sgt i64 %8, %9
  %.167 = zext i1 %cmp76 to i32
  br label %cleanup

if.end81:                                         ; preds = %if.end47
  %and82 = and i32 %conv, 8
  %cmp83 = icmp eq i32 %and82, 0
  br i1 %cmp83, label %cleanup, label %if.then85

if.then85:                                        ; preds = %if.end81
  %and86 = and i32 %conv2, 36
  %cmp87 = icmp eq i32 %and86, 0
  br i1 %cmp87, label %cleanup, label %if.then89

if.then89:                                        ; preds = %if.then85
  %i91 = bitcast %struct.sqlite3_value* %pMem2 to i64*
  %10 = load i64, i64* %i91, align 8, !tbaa !10
  %r93 = getelementptr inbounds %struct.sqlite3_value, %struct.sqlite3_value* %pMem1, i64 0, i32 0, i32 0
  %11 = load double, double* %r93, align 8, !tbaa !10
  %conv.i168 = sitofp i64 %10 to x86_fp80
  %conv1.i169 = fpext double %11 to x86_fp80
  %cmp.i170 = fcmp olt x86_fp80 %conv.i168, %conv1.i169
  %cmp4.i171 = fcmp ogt x86_fp80 %conv.i168, %conv1.i169
  %..i172.neg = sext i1 %cmp4.i171 to i32
  %sub95 = select i1 %cmp.i170, i32 1, i32 %..i172.neg
  br label %cleanup

if.end98:                                         ; preds = %if.end
  %and99 = and i32 %or, 2
  %tobool100 = icmp eq i32 %and99, 0
  br i1 %tobool100, label %if.end116, label %if.then101

if.then101:                                       ; preds = %if.end98
  %and102 = and i32 %conv, 2
  %cmp103 = icmp eq i32 %and102, 0
  br i1 %cmp103, label %cleanup, label %if.end106

if.end106:                                        ; preds = %if.then101
  %and107 = and i32 %conv2, 2
  %cmp108 = icmp eq i32 %and107, 0
  br i1 %cmp108, label %cleanup, label %if.end111

if.end111:                                        ; preds = %if.end106
  %tobool112 = icmp eq %struct.CollSeq* %pColl, null
  br i1 %tobool112, label %if.end116, label %if.then113

if.then113:                                       ; preds = %if.end111
  %call114 = call i32 @vdbeCompareMemString(%struct.sqlite3_value* nonnull %pMem1, %struct.sqlite3_value* nonnull %pMem2, %struct.CollSeq* nonnull %pColl, i8* null)
  br label %cleanup

if.end116:                                        ; preds = %if.end111, %if.end98
  %call117 = call i32 @sqlite3BlobCompare(%struct.sqlite3_value* nonnull %pMem1, %struct.sqlite3_value* nonnull %pMem2)
  br label %cleanup

cleanup:                                          ; preds = %if.end116, %if.then113, %if.end106, %if.then101, %if.then89, %if.then85, %if.end81, %if.end71, %if.then63, %if.else, %if.then55, %if.end38, %if.then31, %if.end17, %if.then11, %if.then
  %retval.0 = phi i32 [ %sub, %if.then ], [ %retval.0.i, %if.then55 ], [ %sub95, %if.then89 ], [ %call114, %if.then113 ], [ %call117, %if.end116 ], [ -1, %if.then11 ], [ %., %if.end17 ], [ -1, %if.then31 ], [ %.166, %if.end38 ], [ -1, %if.then63 ], [ %.167, %if.end71 ], [ -1, %if.else ], [ -1, %if.then85 ], [ 1, %if.end81 ], [ 1, %if.then101 ], [ -1, %if.end106 ]
  ret i32 %retval.0
}

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i32 @sqlite3VdbeSorterNext(%struct.sqlite3*, %struct.VdbeCursor*) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i32 @sqlite3VdbeSorterRowkey(%struct.VdbeCursor*, %struct.sqlite3_value*) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i32 @sqlite3VdbeMemExpandBlob(%struct.sqlite3_value*) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i32 @sqlite3VdbeSorterWrite(%struct.VdbeCursor*, %struct.sqlite3_value*) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare %struct.BtCursor* @sqlite3BtreeFakeValidCursor() #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare void @callXSFuncPtr(i64, %struct.sqlite3_context*, i32, %struct.sqlite3_value**) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare void @callXInversePtr(i64, %struct.sqlite3_context*, i32, %struct.sqlite3_value**) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare void @sqlite3VdbeMemShallowCopy(%struct.sqlite3_value*, %struct.sqlite3_value*, i32) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i32 @sqlite3VdbeChangeEncoding(%struct.sqlite3_value*, i32) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i32 @sqlite3VdbeMemFinalize(%struct.sqlite3_value*, %struct.FuncDef*) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare void @sqlite3VdbeMemSetInt64(%struct.sqlite3_value*, i64) #0

; Function Attrs: nounwind ssp uwtable
declare dso_local i8* @sqlite3DbMallocRawNN(%struct.sqlite3*, i64) unnamed_addr #3

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare void @sqlite3VdbeMemInit(%struct.sqlite3_value*, %struct.sqlite3*, i16) #0

; Function Attrs: noinline nounwind ssp uwtable
declare %struct.sqlite3_value* @out2PrereleaseWithClear(%struct.sqlite3_value* returned) local_unnamed_addr #1

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i32 @sqlite3BtreeBeginStmt(%struct.Btree*, i32) #0

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3BtreeBeginTrans(%struct.Btree*, i32, i32*) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3VdbeHalt(%struct.Vdbe*) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3BtreeNext(%struct.BtCursor*, i32) #3

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare void @sqlite3VdbeMemNulTerminate(%struct.sqlite3_value*) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i32 @sqlite3VdbeMemMakeWriteable(%struct.sqlite3_value*) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i32 @sqlite3VdbeCloseStatement(%struct.Vdbe*, i32) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i32 @sqlite3VdbeCheckFk(%struct.Vdbe*, i32) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i32 @sqlite3VdbeMemFromBtree(%struct.BtCursor*, i32, i32, %struct.sqlite3_value*) #0

; Function Attrs: noinline nounwind ssp uwtable
declare dso_local i32 @sqlite3VdbeMemGrow(%struct.sqlite3_value*, i32, i32) unnamed_addr #1

; Function Attrs: alwaysinline nounwind ssp uwtable
define dso_local i32 @sqlite3VdbeSerialGet(i8* %buf, i32 %serial_type, %struct.sqlite3_value* %pMem) unnamed_addr #4 {
entry:
  switch i32 %serial_type, label %sw.default [
    i32 10, label %sw.bb
    i32 11, label %sw.bb1
    i32 0, label %sw.bb1
    i32 1, label %sw.bb3
    i32 2, label %sw.bb6
    i32 3, label %sw.bb15
    i32 4, label %sw.bb29
    i32 5, label %sw.bb48
    i32 6, label %sw.bb78
    i32 7, label %sw.bb78
    i32 8, label %sw.bb79
    i32 9, label %sw.bb79
  ]

sw.bb:                                            ; preds = %entry
  %flags = getelementptr inbounds %struct.sqlite3_value, %struct.sqlite3_value* %pMem, i64 0, i32 1
  store i16 16385, i16* %flags, align 8, !tbaa !28
  %n = getelementptr inbounds %struct.sqlite3_value, %struct.sqlite3_value* %pMem, i64 0, i32 4
  store i32 0, i32* %n, align 4, !tbaa !29
  %nZero = bitcast %struct.sqlite3_value* %pMem to i32*
  store i32 0, i32* %nZero, align 8, !tbaa !10
  br label %return

sw.bb1:                                           ; preds = %entry, %entry
  %flags2 = getelementptr inbounds %struct.sqlite3_value, %struct.sqlite3_value* %pMem, i64 0, i32 1
  store i16 1, i16* %flags2, align 8, !tbaa !28
  br label %return

sw.bb3:                                           ; preds = %entry
  %0 = load i8, i8* %buf, align 1, !tbaa !10
  %conv = sext i8 %0 to i64
  %i = bitcast %struct.sqlite3_value* %pMem to i64*
  store i64 %conv, i64* %i, align 8, !tbaa !10
  %flags5 = getelementptr inbounds %struct.sqlite3_value, %struct.sqlite3_value* %pMem, i64 0, i32 1
  store i16 4, i16* %flags5, align 8, !tbaa !28
  br label %return

sw.bb6:                                           ; preds = %entry
  %1 = load i8, i8* %buf, align 1, !tbaa !10
  %conv8 = sext i8 %1 to i32
  %mul = shl nsw i32 %conv8, 8
  %arrayidx9 = getelementptr inbounds i8, i8* %buf, i64 1
  %2 = load i8, i8* %arrayidx9, align 1, !tbaa !10
  %conv10 = zext i8 %2 to i32
  %or = or i32 %mul, %conv10
  %conv11 = sext i32 %or to i64
  %i13 = bitcast %struct.sqlite3_value* %pMem to i64*
  store i64 %conv11, i64* %i13, align 8, !tbaa !10
  %flags14 = getelementptr inbounds %struct.sqlite3_value, %struct.sqlite3_value* %pMem, i64 0, i32 1
  store i16 4, i16* %flags14, align 8, !tbaa !28
  br label %return

sw.bb15:                                          ; preds = %entry
  %3 = load i8, i8* %buf, align 1, !tbaa !10
  %conv17 = sext i8 %3 to i32
  %mul18 = shl nsw i32 %conv17, 16
  %arrayidx19 = getelementptr inbounds i8, i8* %buf, i64 1
  %4 = load i8, i8* %arrayidx19, align 1, !tbaa !10
  %conv20 = zext i8 %4 to i32
  %shl = shl nuw nsw i32 %conv20, 8
  %or21 = or i32 %shl, %mul18
  %arrayidx22 = getelementptr inbounds i8, i8* %buf, i64 2
  %5 = load i8, i8* %arrayidx22, align 1, !tbaa !10
  %conv23 = zext i8 %5 to i32
  %or24 = or i32 %or21, %conv23
  %conv25 = sext i32 %or24 to i64
  %i27 = bitcast %struct.sqlite3_value* %pMem to i64*
  store i64 %conv25, i64* %i27, align 8, !tbaa !10
  %flags28 = getelementptr inbounds %struct.sqlite3_value, %struct.sqlite3_value* %pMem, i64 0, i32 1
  store i16 4, i16* %flags28, align 8, !tbaa !28
  br label %return

sw.bb29:                                          ; preds = %entry
  %6 = load i8, i8* %buf, align 1, !tbaa !10
  %conv31 = sext i8 %6 to i32
  %mul32 = shl nsw i32 %conv31, 24
  %arrayidx33 = getelementptr inbounds i8, i8* %buf, i64 1
  %7 = load i8, i8* %arrayidx33, align 1, !tbaa !10
  %conv34 = zext i8 %7 to i32
  %shl35 = shl nuw nsw i32 %conv34, 16
  %or36 = or i32 %shl35, %mul32
  %arrayidx37 = getelementptr inbounds i8, i8* %buf, i64 2
  %8 = load i8, i8* %arrayidx37, align 1, !tbaa !10
  %conv38 = zext i8 %8 to i32
  %shl39 = shl nuw nsw i32 %conv38, 8
  %or40 = or i32 %or36, %shl39
  %arrayidx41 = getelementptr inbounds i8, i8* %buf, i64 3
  %9 = load i8, i8* %arrayidx41, align 1, !tbaa !10
  %conv42 = zext i8 %9 to i32
  %or43 = or i32 %or40, %conv42
  %conv44 = sext i32 %or43 to i64
  %i46 = bitcast %struct.sqlite3_value* %pMem to i64*
  store i64 %conv44, i64* %i46, align 8, !tbaa !10
  %flags47 = getelementptr inbounds %struct.sqlite3_value, %struct.sqlite3_value* %pMem, i64 0, i32 1
  store i16 4, i16* %flags47, align 8, !tbaa !28
  br label %return

sw.bb48:                                          ; preds = %entry
  %add.ptr = getelementptr inbounds i8, i8* %buf, i64 2
  %10 = load i8, i8* %add.ptr, align 1, !tbaa !10
  %conv50 = zext i8 %10 to i64
  %shl51 = shl nuw nsw i64 %conv50, 24
  %arrayidx53 = getelementptr inbounds i8, i8* %buf, i64 3
  %11 = load i8, i8* %arrayidx53, align 1, !tbaa !10
  %conv54 = zext i8 %11 to i64
  %shl55 = shl nuw nsw i64 %conv54, 16
  %or56 = or i64 %shl55, %shl51
  %arrayidx58 = getelementptr inbounds i8, i8* %buf, i64 4
  %12 = load i8, i8* %arrayidx58, align 1, !tbaa !10
  %conv59 = zext i8 %12 to i64
  %shl60 = shl nuw nsw i64 %conv59, 8
  %or61 = or i64 %or56, %shl60
  %arrayidx63 = getelementptr inbounds i8, i8* %buf, i64 5
  %13 = load i8, i8* %arrayidx63, align 1, !tbaa !10
  %conv64 = zext i8 %13 to i64
  %or65 = or i64 %or61, %conv64
  %14 = load i8, i8* %buf, align 1, !tbaa !10
  %conv68 = sext i8 %14 to i32
  %mul69 = shl nsw i32 %conv68, 8
  %arrayidx70 = getelementptr inbounds i8, i8* %buf, i64 1
  %15 = load i8, i8* %arrayidx70, align 1, !tbaa !10
  %conv71 = zext i8 %15 to i32
  %or72 = or i32 %mul69, %conv71
  %conv73 = sext i32 %or72 to i64
  %mul74 = shl nsw i64 %conv73, 32
  %add = or i64 %or65, %mul74
  %i76 = bitcast %struct.sqlite3_value* %pMem to i64*
  store i64 %add, i64* %i76, align 8, !tbaa !10
  %flags77 = getelementptr inbounds %struct.sqlite3_value, %struct.sqlite3_value* %pMem, i64 0, i32 1
  store i16 4, i16* %flags77, align 8, !tbaa !28
  br label %return

sw.bb78:                                          ; preds = %entry, %entry
  %16 = load i8, i8* %buf, align 1, !tbaa !10
  %conv.i = zext i8 %16 to i64
  %shl.i = shl nuw nsw i64 %conv.i, 24
  %arrayidx1.i = getelementptr inbounds i8, i8* %buf, i64 1
  %17 = load i8, i8* %arrayidx1.i, align 1, !tbaa !10
  %conv2.i = zext i8 %17 to i64
  %shl3.i = shl nuw nsw i64 %conv2.i, 16
  %or.i = or i64 %shl3.i, %shl.i
  %arrayidx4.i = getelementptr inbounds i8, i8* %buf, i64 2
  %18 = load i8, i8* %arrayidx4.i, align 1, !tbaa !10
  %conv5.i = zext i8 %18 to i64
  %shl6.i = shl nuw nsw i64 %conv5.i, 8
  %or7.i = or i64 %or.i, %shl6.i
  %arrayidx8.i = getelementptr inbounds i8, i8* %buf, i64 3
  %19 = load i8, i8* %arrayidx8.i, align 1, !tbaa !10
  %conv9.i = zext i8 %19 to i64
  %or10.i = or i64 %or7.i, %conv9.i
  %add.ptr.i = getelementptr inbounds i8, i8* %buf, i64 4
  %20 = load i8, i8* %add.ptr.i, align 1, !tbaa !10
  %conv13.i = zext i8 %20 to i64
  %shl14.i = shl nuw nsw i64 %conv13.i, 24
  %arrayidx16.i = getelementptr inbounds i8, i8* %buf, i64 5
  %21 = load i8, i8* %arrayidx16.i, align 1, !tbaa !10
  %conv17.i = zext i8 %21 to i64
  %shl18.i = shl nuw nsw i64 %conv17.i, 16
  %arrayidx21.i = getelementptr inbounds i8, i8* %buf, i64 6
  %22 = load i8, i8* %arrayidx21.i, align 1, !tbaa !10
  %conv22.i = zext i8 %22 to i64
  %shl23.i = shl nuw nsw i64 %conv22.i, 8
  %arrayidx26.i = getelementptr inbounds i8, i8* %buf, i64 7
  %23 = load i8, i8* %arrayidx26.i, align 1, !tbaa !10
  %conv27.i = zext i8 %23 to i64
  %shl29.i = shl nuw i64 %or10.i, 32
  %or19.i = or i64 %shl29.i, %shl14.i
  %or24.i = or i64 %or19.i, %shl18.i
  %or28.i = or i64 %or24.i, %shl23.i
  %add.i = or i64 %or28.i, %conv27.i
  %cmp.i = icmp eq i32 %serial_type, 6
  %i.i = bitcast %struct.sqlite3_value* %pMem to i64*
  br i1 %cmp.i, label %if.then.i, label %if.else.i

if.then.i:                                        ; preds = %sw.bb78
  store i64 %add.i, i64* %i.i, align 8, !tbaa !10
  br label %serialGet.exit

if.else.i:                                        ; preds = %sw.bb78
  store i64 %add.i, i64* %i.i, align 1
  %and.i = and i64 %add.i, 9218868437227405312
  %cmp35.i = icmp eq i64 %and.i, 9218868437227405312
  %and37.i = and i64 %add.i, 4503599627370495
  %cmp38.i = icmp ne i64 %and37.i, 0
  %24 = and i1 %cmp35.i, %cmp38.i
  %conv40.i = select i1 %24, i16 1, i16 8
  br label %serialGet.exit

serialGet.exit:                                   ; preds = %if.else.i, %if.then.i
  %conv40.sink.i = phi i16 [ 4, %if.then.i ], [ %conv40.i, %if.else.i ]
  %25 = getelementptr inbounds %struct.sqlite3_value, %struct.sqlite3_value* %pMem, i64 0, i32 1
  store i16 %conv40.sink.i, i16* %25, align 8
  br label %return

sw.bb79:                                          ; preds = %entry, %entry
  %sub = add nsw i32 %serial_type, -8
  %conv80 = zext i32 %sub to i64
  %i82 = bitcast %struct.sqlite3_value* %pMem to i64*
  store i64 %conv80, i64* %i82, align 8, !tbaa !10
  %flags83 = getelementptr inbounds %struct.sqlite3_value, %struct.sqlite3_value* %pMem, i64 0, i32 1
  store i16 4, i16* %flags83, align 8, !tbaa !28
  br label %return

sw.default:                                       ; preds = %entry
  %z = getelementptr inbounds %struct.sqlite3_value, %struct.sqlite3_value* %pMem, i64 0, i32 5
  store i8* %buf, i8** %z, align 8, !tbaa !26
  %sub84 = add i32 %serial_type, -12
  %div = lshr i32 %sub84, 1
  %n85 = getelementptr inbounds %struct.sqlite3_value, %struct.sqlite3_value* %pMem, i64 0, i32 4
  store i32 %div, i32* %n85, align 4, !tbaa !29
  %and = and i32 %serial_type, 1
  %idxprom = zext i32 %and to i64
  %arrayidx86 = getelementptr inbounds [2 x i16], [2 x i16]* @sqlite3VdbeSerialGet.aFlag, i64 0, i64 %idxprom
  %26 = load i16, i16* %arrayidx86, align 2, !tbaa !36
  %flags87 = getelementptr inbounds %struct.sqlite3_value, %struct.sqlite3_value* %pMem, i64 0, i32 1
  store i16 %26, i16* %flags87, align 8, !tbaa !28
  br label %return

return:                                           ; preds = %sw.default, %sw.bb79, %serialGet.exit, %sw.bb48, %sw.bb29, %sw.bb15, %sw.bb6, %sw.bb3, %sw.bb1, %sw.bb
  %retval.0 = phi i32 [ %div, %sw.default ], [ 0, %sw.bb79 ], [ 8, %serialGet.exit ], [ 6, %sw.bb48 ], [ 4, %sw.bb29 ], [ 3, %sw.bb15 ], [ 2, %sw.bb6 ], [ 1, %sw.bb3 ], [ 0, %sw.bb1 ], [ 0, %sw.bb ]
  ret i32 %retval.0
}

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare void @sqlite3VdbeMemRelease(%struct.sqlite3_value*) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i32 @sqlite3VdbeSerialTypeLen(i32) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i8 @sqlite3VdbeOneByteSerialTypeLen(i8) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i8 @sqlite3GetVarint32(i8*, i32*) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i8* @sqlite3BtreePayloadFetch(%struct.BtCursor*, i32*) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i32 @sqlite3BtreePayloadSize(%struct.BtCursor*) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare void @sqlite3VdbeMemSetNull(%struct.sqlite3_value*) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i32 @sqlite3VdbeCursorMoveto(%struct.VdbeCursor**, i32*) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i32 @sqlite3BtreeFirst(%struct.BtCursor*, i32*) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i32 @sqlite3VdbeSorterRewind(%struct.VdbeCursor*, i32*) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare void @sqlite3BtreeCursorHintFlags(%struct.BtCursor*, i32) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i32 @sqlite3BtreeCursor(%struct.Btree*, i32, i32, %struct.KeyInfo*, %struct.BtCursor*) #0

; Function Attrs: nounwind ssp uwtable
declare %struct.VdbeCursor* @allocateCursor(%struct.Vdbe* nocapture readonly, i32, i32, i32, i8 zeroext) local_unnamed_addr #3

declare void @printProgress(i64, i32, i64)

declare void @printInt(i64, i64, i32, i64)

declare void @printDouble(double, i64, i32, i64)

declare void @printPtrAndValue(i64, i64, i64, i32, i64, i1)

define i32 @jittedFunction(%struct.Vdbe* %0, i8* %1, i32* %2, i8* %3, i8* %4) !dbg !37 {
  %6 = getelementptr %struct.Vdbe, %struct.Vdbe* %0, i32 0, i32 19, !dbg !41
  %7 = load %struct.sqlite3_value*, %struct.sqlite3_value** %6, align 8, !dbg !43
  %8 = getelementptr %struct.Vdbe, %struct.Vdbe* %0, i32 0, i32 21, !dbg !44
  %9 = load %struct.VdbeCursor**, %struct.VdbeCursor*** %8, align 8, !dbg !45
  %10 = getelementptr %struct.Vdbe, %struct.Vdbe* %0, i32 0, i32 23, !dbg !46
  %11 = load %struct.VdbeOp*, %struct.VdbeOp** %10, align 8, !dbg !47
  %12 = getelementptr %struct.Vdbe, %struct.Vdbe* %0, i32 0, i32 0, !dbg !48
  %13 = load %struct.sqlite3*, %struct.sqlite3** %12, align 8, !dbg !49
  %14 = getelementptr %struct.Vdbe, %struct.Vdbe* %0, i32 0, i32 10, !dbg !50
  %15 = load i32, i32* %14, align 4, !dbg !51
  switch i32 %15, label %16 [
    i32 27, label %2380
    i32 31, label %2422
  ], !dbg !52

16:                                               ; preds = %5
  %17 = getelementptr %struct.VdbeOp, %struct.VdbeOp* %11, i32 5, i32 3, !dbg !53
  store i32 0, i32* %17, align 4, !dbg !56
  %18 = getelementptr %struct.VdbeOp, %struct.VdbeOp* %11, i32 10, i32 3, !dbg !53
  store i32 0, i32* %18, align 4, !dbg !56
  %19 = getelementptr %struct.VdbeOp, %struct.VdbeOp* %11, i32 0, i32 3, !dbg !57
  %20 = load i32, i32* %19, align 4, !dbg !58
  %21 = add i32 %20, 1, !dbg !59
  store i32 %21, i32* %19, align 4, !dbg !60
  %22 = call i8* @llvm.stacksave(), !dbg !61
  %23 = getelementptr %struct.sqlite3, %struct.sqlite3* %13, i32 0, i32 4, !dbg !64
  %24 = load %struct.Db*, %struct.Db** %23, align 8, !dbg !65
  %25 = getelementptr %struct.Db, %struct.Db* %24, i32 0, i32 1, !dbg !66
  %26 = load %struct.Btree*, %struct.Btree** %25, align 8, !dbg !67
  %27 = ptrtoint %struct.Btree* %26 to i64, !dbg !68
  %28 = alloca i32, align 8, !dbg !69
  %29 = alloca i32, align 8, !dbg !70
  %30 = icmp ne i64 %27, 0, !dbg !71
  br i1 %30, label %2424, label %2426, !dbg !72

31:                                               ; preds = %2685
  %32 = call %struct.sqlite3_value* @out2PrereleaseWithClear(%struct.sqlite3_value* %2693), !dbg !73
  store %struct.sqlite3_value* %32, %struct.sqlite3_value** %2698, align 8, !dbg !73
  br label %34, !dbg !73

33:                                               ; preds = %2685
  store i16 4, i16* %2694, align 2, !dbg !73
  store %struct.sqlite3_value* %2693, %struct.sqlite3_value** %2698, align 8, !dbg !73
  br label %34, !dbg !73

34:                                               ; preds = %33, %31
  %35 = load %struct.sqlite3_value*, %struct.sqlite3_value** %2698, align 8, !dbg !73
  call void @llvm.stackrestore(i8* %2690), !dbg !73
  %36 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %35, i32 0, i32 1, !dbg !76
  store i16 1, i16* %36, align 2, !dbg !77
  %37 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %35, i32 0, i32 4, !dbg !78
  store i32 0, i32* %37, align 4, !dbg !79
  %38 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %35, i32 1, !dbg !80
  %39 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %38, i32 0, i32 1, !dbg !81
  %40 = load i16, i16* %39, align 2, !dbg !81
  %41 = and i16 %40, 9216, !dbg !81
  %42 = icmp ne i16 %41, 0, !dbg !81
  br i1 %42, label %43, label %44, !dbg !81

43:                                               ; preds = %34
  call void @vdbeMemClearExternAndSetNull(%struct.sqlite3_value* %38), !dbg !81
  br label %45, !dbg !81

44:                                               ; preds = %34
  store i16 1, i16* %39, align 2, !dbg !81
  br label %45, !dbg !81

45:                                               ; preds = %44, %43
  store i16 1, i16* %39, align 2, !dbg !82
  %46 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %38, i32 0, i32 4, !dbg !83
  store i32 0, i32* %46, align 4, !dbg !84
  %47 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %38, i32 1, !dbg !80
  %48 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %47, i32 0, i32 1, !dbg !81
  %49 = load i16, i16* %48, align 2, !dbg !81
  %50 = and i16 %49, 9216, !dbg !81
  %51 = icmp ne i16 %50, 0, !dbg !81
  br i1 %51, label %52, label %53, !dbg !81

52:                                               ; preds = %45
  call void @vdbeMemClearExternAndSetNull(%struct.sqlite3_value* %47), !dbg !81
  br label %54, !dbg !81

53:                                               ; preds = %45
  store i16 1, i16* %48, align 2, !dbg !81
  br label %54, !dbg !81

54:                                               ; preds = %53, %52
  store i16 1, i16* %48, align 2, !dbg !82
  %55 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %47, i32 0, i32 4, !dbg !83
  store i32 0, i32* %55, align 4, !dbg !84
  %56 = load %struct.sqlite3*, %struct.sqlite3** %12, align 8, !dbg !85
  %57 = getelementptr %struct.sqlite3, %struct.sqlite3* %56, i32 0, i32 4, !dbg !88
  %58 = load %struct.Db*, %struct.Db** %57, align 8, !dbg !89
  %59 = getelementptr %struct.Db, %struct.Db* %58, i32 0, i32 1, !dbg !90
  %60 = load %struct.Btree*, %struct.Btree** %59, align 8, !dbg !91
  %61 = call %struct.VdbeCursor* @allocateCursor(%struct.Vdbe* %0, i32 0, i32 11, i32 0, i8 0), !dbg !92
  %62 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %61, i32 0, i32 2, !dbg !93
  store i8 1, i8* %62, align 1, !dbg !94
  %63 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %61, i32 0, i32 5, !dbg !95
  %64 = load i8, i8* %63, align 1, !dbg !96
  %65 = or i8 %64, 4, !dbg !97
  store i8 %65, i8* %63, align 1, !dbg !98
  %66 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %61, i32 0, i32 15, !dbg !99
  store i32 10, i32* %66, align 4, !dbg !100
  %67 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %61, i32 0, i32 12, i32 0, !dbg !101
  %68 = load %struct.BtCursor*, %struct.BtCursor** %67, align 8, !dbg !102
  %69 = call i32 @sqlite3BtreeCursor(%struct.Btree* %60, i32 10, i32 0, %struct.KeyInfo* null, %struct.BtCursor* %68), !dbg !103
  %70 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %61, i32 0, i32 13, !dbg !104
  store %struct.KeyInfo* null, %struct.KeyInfo** %70, align 8, !dbg !105
  %71 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %61, i32 0, i32 4, !dbg !106
  store i8 1, i8* %71, align 1, !dbg !107
  call void @sqlite3BtreeCursorHintFlags(%struct.BtCursor* %68, i32 0), !dbg !108
  %72 = call i8* @llvm.stacksave(), !dbg !109
  %73 = load %struct.VdbeCursor**, %struct.VdbeCursor*** %8, align 8, !dbg !112
  %74 = load %struct.VdbeCursor*, %struct.VdbeCursor** %73, align 8, !dbg !113
  %75 = alloca i32, align 4, !dbg !114
  store i32 1, i32* %75, align 4, !dbg !115
  %76 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %74, i32 0, i32 0, !dbg !116
  %77 = load i8, i8* %76, align 1, !dbg !117
  %78 = icmp eq i8 %77, 1, !dbg !118
  %79 = alloca i32, align 4, !dbg !119
  store i32 0, i32* %79, align 4, !dbg !120
  br i1 %78, label %80, label %82, !dbg !121

80:                                               ; preds = %54
  %81 = call i32 @sqlite3VdbeSorterRewind(%struct.VdbeCursor* %74, i32* %75), !dbg !122
  store i32 %81, i32* %79, align 4, !dbg !123
  br label %88, !dbg !124

82:                                               ; preds = %54
  %83 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %74, i32 0, i32 12, i32 0, !dbg !125
  %84 = load %struct.BtCursor*, %struct.BtCursor** %83, align 8, !dbg !126
  %85 = call i32 @sqlite3BtreeFirst(%struct.BtCursor* %84, i32* %75), !dbg !127
  store i32 %85, i32* %79, align 4, !dbg !128
  %86 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %74, i32 0, i32 3, !dbg !129
  store i8 0, i8* %86, align 1, !dbg !130
  %87 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %74, i32 0, i32 9, !dbg !131
  store i32 0, i32* %87, align 4, !dbg !132
  br label %88, !dbg !133

88:                                               ; preds = %82, %80
  %89 = load i32, i32* %79, align 4, !dbg !134
  %90 = load i32, i32* %75, align 4, !dbg !135
  %91 = trunc i32 %90 to i8, !dbg !136
  %92 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %74, i32 0, i32 2, !dbg !137
  store i8 %91, i8* %92, align 1, !dbg !138
  call void @llvm.stackrestore(i8* %72), !dbg !139
  %93 = icmp ne i32 %90, 0, !dbg !140
  br i1 %93, label %2391, label %94, !dbg !141

94:                                               ; preds = %2389, %88
  %95 = call i8* @llvm.stacksave(), !dbg !142
  %96 = getelementptr %struct.sqlite3, %struct.sqlite3* %13, i32 0, i32 16, !dbg !145
  %97 = load i8, i8* %96, align 1, !dbg !146
  %98 = alloca i32, align 4, !dbg !147
  store i32 0, i32* %98, align 4, !dbg !148
  %99 = alloca %struct.VdbeCursor*, align 8, !dbg !149
  %100 = load %struct.VdbeCursor*, %struct.VdbeCursor** %9, align 8, !dbg !150
  store %struct.VdbeCursor* %100, %struct.VdbeCursor** %99, align 8, !dbg !151
  %101 = alloca i8*, align 8, !dbg !152
  %102 = alloca i32, align 4, !dbg !153
  %103 = call i32 @sqlite3VdbeCursorMoveto(%struct.VdbeCursor** %99, i32* %98), !dbg !154
  %104 = load %struct.VdbeCursor*, %struct.VdbeCursor** %99, align 8, !dbg !155
  %105 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %7, i32 4, !dbg !156
  %106 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %104, i32 0, i32 16, !dbg !157
  %107 = load i16, i16* %106, align 2, !dbg !158
  %108 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %104, i32 0, i32 19, !dbg !159
  %109 = load i32*, i32** %108, align 8, !dbg !160
  %110 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %104, i32 0, i32 0, !dbg !161
  %111 = load i8, i8* %110, align 1, !dbg !162
  %112 = icmp ne i8 %111, 3, !dbg !163
  %113 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %104, i32 0, i32 2, !dbg !164
  %114 = load i8, i8* %113, align 1, !dbg !165
  %115 = icmp ne i8 %114, 0, !dbg !166
  %116 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %104, i32 0, i32 14, !dbg !167
  %117 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %104, i32 0, i32 21, !dbg !168
  %118 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %104, i32 0, i32 22, !dbg !169
  %119 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %104, i32 0, i32 20, !dbg !170
  %120 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %104, i32 0, i32 17, !dbg !171
  %121 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %104, i32 0, i32 9, !dbg !172
  %122 = load i32, i32* %121, align 4, !dbg !173
  %123 = getelementptr %struct.Vdbe, %struct.Vdbe* %0, i32 0, i32 9, !dbg !174
  %124 = load i32, i32* %123, align 4, !dbg !175
  %125 = icmp ne i32 %122, %124, !dbg !176
  br i1 %125, label %126, label %168, !dbg !177

126:                                              ; preds = %94
  br i1 %115, label %148, label %143, !dbg !178

127:                                              ; preds = %143, %150
  %128 = load i32, i32* %123, align 4, !dbg !179
  store i32 %128, i32* %121, align 4, !dbg !180
  %129 = load i8*, i8** %119, align 8, !dbg !181
  %130 = load i8, i8* %129, align 1, !dbg !182
  %131 = icmp sgt i8 %130, -1, !dbg !185
  br i1 %131, label %132, label %134, !dbg !186

132:                                              ; preds = %127
  %133 = zext i8 %130 to i32, !dbg !187
  store i32 %133, i32* %109, align 4, !dbg !188
  store i32 1, i32* %116, align 4, !dbg !189
  br label %137, !dbg !190

134:                                              ; preds = %127
  %135 = call i8 @sqlite3GetVarint32(i8* %129, i32* %109), !dbg !191
  %136 = zext i8 %135 to i32, !dbg !192
  store i32 %136, i32* %116, align 4, !dbg !193
  br label %137, !dbg !194

137:                                              ; preds = %134, %132
  store i16 0, i16* %120, align 2, !dbg !195
  %138 = load i32, i32* %118, align 4, !dbg !196
  %139 = load i32, i32* %109, align 4, !dbg !197
  %140 = icmp ult i32 %138, %139, !dbg !198
  br i1 %140, label %142, label %141, !dbg !199

141:                                              ; preds = %137
  store i8* %129, i8** %101, align 8, !dbg !200
  br label %261, !dbg !201

142:                                              ; preds = %137
  store i8* null, i8** %119, align 8, !dbg !202
  store i32 0, i32* %118, align 4, !dbg !203
  br label %168, !dbg !204

143:                                              ; preds = %126
  %144 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %104, i32 0, i32 12, i32 0, !dbg !205
  %145 = load %struct.BtCursor*, %struct.BtCursor** %144, align 8, !dbg !206
  %146 = call i32 @sqlite3BtreePayloadSize(%struct.BtCursor* %145), !dbg !207
  store i32 %146, i32* %117, align 4, !dbg !208
  %147 = call i8* @sqlite3BtreePayloadFetch(%struct.BtCursor* %145, i32* %118), !dbg !209
  store i8* %147, i8** %119, align 8, !dbg !210
  br label %127, !dbg !211

148:                                              ; preds = %126
  %149 = icmp eq i8 %111, 3, !dbg !212
  br i1 %149, label %150, label %161, !dbg !213

150:                                              ; preds = %148
  %151 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %104, i32 0, i32 10, !dbg !214
  %152 = load i32, i32* %151, align 4, !dbg !215
  %153 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %7, i32 %152, !dbg !216
  %154 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %153, i32 0, i32 1, !dbg !217
  %155 = load i16, i16* %154, align 2, !dbg !218
  %156 = and i16 %155, 16, !dbg !219
  %157 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %153, i32 0, i32 4, !dbg !220
  %158 = load i32, i32* %157, align 4, !dbg !221
  store i32 %158, i32* %117, align 4, !dbg !222
  store i32 %158, i32* %118, align 4, !dbg !223
  %159 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %153, i32 0, i32 5, !dbg !224
  %160 = load i8*, i8** %159, align 8, !dbg !225
  store i8* %160, i8** %119, align 8, !dbg !226
  br label %127, !dbg !227

161:                                              ; preds = %148
  %162 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %105, i32 0, i32 1, !dbg !228
  %163 = load i16, i16* %162, align 2, !dbg !228
  %164 = and i16 %163, 9216, !dbg !228
  %165 = icmp ne i16 %164, 0, !dbg !228
  br i1 %165, label %166, label %167, !dbg !228

166:                                              ; preds = %161
  call void @vdbeMemClearExternAndSetNull(%struct.sqlite3_value* %105), !dbg !228
  br label %349, !dbg !228

167:                                              ; preds = %161
  store i16 1, i16* %162, align 2, !dbg !228
  br label %349, !dbg !228

168:                                              ; preds = %142, %94
  %169 = load i16, i16* %120, align 2, !dbg !229
  %170 = icmp ule i16 %169, 10, !dbg !230
  br i1 %170, label %253, label %250, !dbg !231

171:                                              ; preds = %250, %339
  %172 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %105, i32 0, i32 1, !dbg !232
  %173 = load i16, i16* %172, align 2, !dbg !233
  %174 = and i16 9216, %173, !dbg !234
  %175 = icmp eq i16 0, %174, !dbg !235
  br i1 %175, label %176, label %180, !dbg !236

176:                                              ; preds = %171
  %177 = icmp ne i16 %174, 0, !dbg !237
  br i1 %177, label %178, label %179, !dbg !237

178:                                              ; preds = %176
  call void @vdbeMemClearExternAndSetNull(%struct.sqlite3_value* %105), !dbg !237
  br label %180, !dbg !237

179:                                              ; preds = %176
  store i16 1, i16* %172, align 2, !dbg !237
  br label %180, !dbg !237

180:                                              ; preds = %178, %179, %171
  %181 = load i32, i32* %102, align 4, !dbg !238
  %182 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %104, i32 0, i32 23, i32 10, !dbg !239
  %183 = load i32, i32* %182, align 4, !dbg !240
  %184 = load i32, i32* %118, align 4, !dbg !241
  %185 = getelementptr i32, i32* %109, i32 11, !dbg !242
  %186 = load i32, i32* %185, align 4, !dbg !243
  %187 = icmp sge i32 %184, %186, !dbg !244
  br i1 %187, label %188, label %228, !dbg !245

188:                                              ; preds = %180
  %189 = load i8*, i8** %119, align 8, !dbg !246
  %190 = ptrtoint i8* %189 to i64, !dbg !247
  %191 = getelementptr i32, i32* %109, i32 10, !dbg !248
  %192 = load i32, i32* %191, align 4, !dbg !249
  %193 = zext i32 %192 to i64, !dbg !250
  %194 = add i64 %190, %193, !dbg !251
  %195 = inttoptr i64 %194 to i8*, !dbg !252
  store i8* %195, i8** %101, align 8, !dbg !253
  %196 = load i32, i32* %102, align 4, !dbg !254
  %197 = icmp ult i32 %196, 12, !dbg !255
  br i1 %197, label %198, label %200, !dbg !256

198:                                              ; preds = %188
  %199 = call i32 @sqlite3VdbeSerialGet(i8* %195, i32 %196, %struct.sqlite3_value* %105), !dbg !257
  br label %349, !dbg !258

200:                                              ; preds = %188
  %201 = alloca i16, i32 2, align 2, !dbg !259
  store i16 16, i16* %201, align 2, !dbg !260
  %202 = getelementptr i16, i16* %201, i32 1, !dbg !261
  store i16 514, i16* %202, align 2, !dbg !262
  %203 = load i32, i32* %102, align 4, !dbg !263
  %204 = sub i32 %203, 12, !dbg !264
  %205 = lshr i32 %204, 1, !dbg !265
  %206 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %105, i32 0, i32 4, !dbg !266
  store i32 %205, i32* %206, align 4, !dbg !267
  %207 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %105, i32 0, i32 2, !dbg !268
  store i8 %97, i8* %207, align 1, !dbg !269
  %208 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %105, i32 0, i32 5, !dbg !270
  %209 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %105, i32 0, i32 7, !dbg !271
  %210 = load i32, i32* %209, align 4, !dbg !272
  %211 = add i32 %205, 2, !dbg !273
  %212 = icmp slt i32 %210, %211, !dbg !274
  br i1 %212, label %213, label %215, !dbg !275

213:                                              ; preds = %200
  store i16 1, i16* %172, align 2, !dbg !276
  %214 = call i32 @sqlite3VdbeMemGrow(%struct.sqlite3_value* %105, i32 %211, i32 0), !dbg !277
  br label %218, !dbg !278

215:                                              ; preds = %200
  %216 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %105, i32 0, i32 6, !dbg !279
  %217 = load i8*, i8** %216, align 8, !dbg !280
  store i8* %217, i8** %208, align 8, !dbg !281
  br label %218, !dbg !282

218:                                              ; preds = %215, %213
  %219 = zext i32 %205 to i64, !dbg !283
  %220 = load i8*, i8** %208, align 8, !dbg !284
  %221 = load i8*, i8** %101, align 8, !dbg !285
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %220, i8* %221, i64 %219, i1 false), !dbg !286
  %222 = getelementptr i8, i8* %220, i32 %205, !dbg !287
  store i8 0, i8* %222, align 1, !dbg !288
  %223 = add i32 %205, 1, !dbg !289
  %224 = getelementptr i8, i8* %220, i32 %223, !dbg !290
  store i8 0, i8* %224, align 1, !dbg !291
  %225 = and i32 %203, 1, !dbg !292
  %226 = getelementptr i16, i16* %201, i32 %225, !dbg !293
  %227 = load i16, i16* %226, align 2, !dbg !294
  store i16 %227, i16* %172, align 2, !dbg !295
  br label %349, !dbg !296

228:                                              ; preds = %180
  %229 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %105, i32 0, i32 2, !dbg !297
  store i8 %97, i8* %229, align 1, !dbg !298
  %230 = load i32, i32* %102, align 4, !dbg !299
  %231 = and i32 %230, 1, !dbg !300
  %232 = icmp eq i32 %231, 0, !dbg !301
  %233 = icmp sge i32 %230, 12, !dbg !302
  %234 = and i1 %233, %232, !dbg !303
  %235 = call i32 @sqlite3VdbeSerialTypeLen(i32 %230), !dbg !304
  %236 = icmp eq i32 %235, 0, !dbg !305
  br i1 %236, label %248, label %237, !dbg !306

237:                                              ; preds = %228
  %238 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %104, i32 0, i32 12, i32 0, !dbg !307
  %239 = load %struct.BtCursor*, %struct.BtCursor** %238, align 8, !dbg !308
  %240 = getelementptr i32, i32* %109, i32 10, !dbg !309
  %241 = load i32, i32* %240, align 4, !dbg !310
  %242 = call i32 @sqlite3VdbeMemFromBtree(%struct.BtCursor* %239, i32 %241, i32 %235, %struct.sqlite3_value* %105), !dbg !311
  %243 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %105, i32 0, i32 5, !dbg !312
  %244 = load i8*, i8** %243, align 8, !dbg !313
  %245 = call i32 @sqlite3VdbeSerialGet(i8* %244, i32 %230, %struct.sqlite3_value* %105), !dbg !314
  %246 = load i16, i16* %172, align 2, !dbg !315
  %247 = and i16 %246, -4097, !dbg !316
  store i16 %247, i16* %172, align 2, !dbg !317
  br label %349, !dbg !318

248:                                              ; preds = %228
  %249 = call i32 @sqlite3VdbeSerialGet(i8* %1, i32 %230, %struct.sqlite3_value* %105), !dbg !319
  br label %349, !dbg !320

250:                                              ; preds = %168
  %251 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %104, i32 0, i32 23, i32 10, !dbg !321
  %252 = load i32, i32* %251, align 4, !dbg !322
  store i32 %252, i32* %102, align 4, !dbg !323
  br label %171, !dbg !324

253:                                              ; preds = %168
  %254 = load i32, i32* %116, align 4, !dbg !325
  %255 = load i32, i32* %109, align 4, !dbg !326
  %256 = icmp ult i32 %254, %255, !dbg !327
  br i1 %256, label %257, label %338, !dbg !328

257:                                              ; preds = %253
  %258 = load i8*, i8** %119, align 8, !dbg !329
  %259 = icmp eq i8* %258, null, !dbg !330
  br i1 %259, label %261, label %260, !dbg !331

260:                                              ; preds = %257
  store i8* %258, i8** %101, align 8, !dbg !332
  br label %261, !dbg !333

261:                                              ; preds = %260, %257, %141
  %262 = alloca i32, align 4, !dbg !334
  %263 = load i16, i16* %120, align 2, !dbg !335
  %264 = zext i16 %263 to i32, !dbg !336
  store i32 %264, i32* %262, align 4, !dbg !337
  %265 = alloca i64, align 8, !dbg !338
  %266 = getelementptr i32, i32* %109, i32 %264, !dbg !339
  %267 = load i32, i32* %266, align 4, !dbg !340
  %268 = zext i32 %267 to i64, !dbg !341
  store i64 %268, i64* %265, align 4, !dbg !342
  %269 = load i8*, i8** %101, align 8, !dbg !343
  %270 = load i32, i32* %116, align 4, !dbg !344
  %271 = alloca i8*, align 8, !dbg !345
  %272 = getelementptr i8, i8* %269, i32 %270, !dbg !346
  store i8* %272, i8** %271, align 8, !dbg !347
  %273 = load i32, i32* %109, align 4, !dbg !348
  %274 = getelementptr i8, i8* %269, i32 %273, !dbg !349
  br label %275, !dbg !350

275:                                              ; preds = %282, %261
  %276 = load i32, i32* %262, align 4, !dbg !351
  %277 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %104, i32 0, i32 23, i32 %276, !dbg !352
  %278 = load i8*, i8** %271, align 8, !dbg !353
  %279 = load i8, i8* %278, align 1, !dbg !354
  %280 = zext i8 %279 to i32, !dbg !355
  store i32 %280, i32* %102, align 4, !dbg !356
  store i32 %280, i32* %277, align 4, !dbg !357
  %281 = icmp sgt i8 %279, -1, !dbg !358
  br i1 %281, label %305, label %296, !dbg !359

282:                                              ; preds = %296, %305
  %283 = load i32, i32* %262, align 4, !dbg !360
  %284 = add i32 %283, 1, !dbg !361
  store i32 %284, i32* %262, align 4, !dbg !362
  %285 = load i64, i64* %265, align 4, !dbg !363
  %286 = and i64 4294967295, %285, !dbg !364
  %287 = trunc i64 %286 to i32, !dbg !365
  %288 = getelementptr i32, i32* %109, i32 %284, !dbg !366
  store i32 %287, i32* %288, align 4, !dbg !367
  %289 = load i32, i32* %262, align 4, !dbg !368
  %290 = icmp sle i32 %289, 10, !dbg !369
  %291 = load i8*, i8** %271, align 8, !dbg !370
  %292 = ptrtoint i8* %291 to i64, !dbg !371
  %293 = ptrtoint i8* %274 to i64, !dbg !372
  %294 = icmp ult i64 %292, %293, !dbg !373
  %295 = and i1 %290, %294, !dbg !374
  br i1 %295, label %275, label %314, !dbg !375

296:                                              ; preds = %275
  %297 = load i8*, i8** %271, align 8, !dbg !376
  %298 = call i8 @sqlite3GetVarint32(i8* %297, i32* %102), !dbg !377
  %299 = getelementptr i8, i8* %297, i8 %298, !dbg !378
  store i8* %299, i8** %271, align 8, !dbg !379
  %300 = load i32, i32* %102, align 4, !dbg !380
  store i32 %300, i32* %277, align 4, !dbg !381
  %301 = load i64, i64* %265, align 4, !dbg !382
  %302 = call i32 @sqlite3VdbeSerialTypeLen(i32 %300), !dbg !383
  %303 = zext i32 %302 to i64, !dbg !384
  %304 = add i64 %301, %303, !dbg !385
  store i64 %304, i64* %265, align 4, !dbg !386
  br label %282, !dbg !387

305:                                              ; preds = %275
  %306 = getelementptr i8, i8* %278, i32 1, !dbg !388
  store i8* %306, i8** %271, align 8, !dbg !389
  %307 = load i32, i32* %102, align 4, !dbg !390
  %308 = trunc i32 %307 to i8, !dbg !391
  %309 = getelementptr i8, i8* %4, i8 %308, !dbg !392
  %310 = load i8, i8* %309, align 1, !dbg !393
  %311 = zext i8 %310 to i64, !dbg !394
  %312 = load i64, i64* %265, align 4, !dbg !395
  %313 = add i64 %312, %311, !dbg !396
  store i64 %313, i64* %265, align 4, !dbg !397
  br label %282, !dbg !398

314:                                              ; preds = %282
  %315 = load i64, i64* %265, align 4, !dbg !399
  %316 = load i32, i32* %117, align 4, !dbg !400
  %317 = zext i32 %316 to i64, !dbg !401
  %318 = icmp uge i64 %292, %293, !dbg !402
  %319 = icmp ugt i64 %292, %293, !dbg !403
  %320 = icmp ne i64 %315, %317, !dbg !404
  %321 = icmp ugt i64 %315, %317, !dbg !405
  %322 = or i1 %319, %320, !dbg !406
  %323 = and i1 %318, %322, !dbg !407
  %324 = or i1 %323, %321, !dbg !408
  br i1 %324, label %325, label %329, !dbg !409

325:                                              ; preds = %314
  %326 = load i32, i32* %109, align 4, !dbg !410
  %327 = icmp eq i32 %326, 0, !dbg !411
  br i1 %327, label %328, label %329, !dbg !412

328:                                              ; preds = %325
  store i32 0, i32* %262, align 4, !dbg !413
  store i8* %274, i8** %271, align 8, !dbg !414
  br label %329, !dbg !415

329:                                              ; preds = %328, %325, %314
  %330 = load i32, i32* %262, align 4, !dbg !416
  %331 = trunc i32 %330 to i16, !dbg !417
  store i16 %331, i16* %120, align 2, !dbg !418
  %332 = load i8*, i8** %271, align 8, !dbg !419
  %333 = ptrtoint i8* %332 to i64, !dbg !420
  %334 = load i8*, i8** %101, align 8, !dbg !421
  %335 = ptrtoint i8* %334 to i64, !dbg !422
  %336 = sub i64 %333, %335, !dbg !423
  %337 = trunc i64 %336 to i32, !dbg !424
  store i32 %337, i32* %116, align 4, !dbg !425
  br label %339, !dbg !426

338:                                              ; preds = %253
  store i32 0, i32* %102, align 4, !dbg !427
  br label %339, !dbg !428

339:                                              ; preds = %329, %338
  %340 = load i16, i16* %120, align 2, !dbg !429
  %341 = icmp sle i16 %340, 10, !dbg !430
  br i1 %341, label %342, label %171, !dbg !431

342:                                              ; preds = %339
  %343 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %105, i32 0, i32 1, !dbg !432
  %344 = load i16, i16* %343, align 2, !dbg !432
  %345 = and i16 %344, 9216, !dbg !432
  %346 = icmp ne i16 %345, 0, !dbg !432
  br i1 %346, label %347, label %348, !dbg !432

347:                                              ; preds = %342
  call void @vdbeMemClearExternAndSetNull(%struct.sqlite3_value* %105), !dbg !432
  br label %349, !dbg !432

348:                                              ; preds = %342
  store i16 1, i16* %343, align 2, !dbg !432
  br label %349, !dbg !432

349:                                              ; preds = %347, %348, %218, %198, %237, %248, %166, %167
  call void @llvm.stackrestore(i8* %95), !dbg !433
  %350 = getelementptr %struct.Vdbe, %struct.Vdbe* %0, i32 0, i32 43, !dbg !434
  %351 = load %struct.VdbeFrame*, %struct.VdbeFrame** %350, align 8, !dbg !437
  %352 = ptrtoint %struct.VdbeFrame* %351 to i64, !dbg !438
  %353 = getelementptr %struct.VdbeOp, %struct.VdbeOp* %11, i32 0, i32 3, !dbg !439
  %354 = load i32, i32* %353, align 4, !dbg !440
  %355 = getelementptr %struct.VdbeOp, %struct.VdbeOp* %11, i32 5, i32 3, !dbg !441
  %356 = icmp ne i64 %352, 0, !dbg !442
  br i1 %356, label %357, label %361, !dbg !443

357:                                              ; preds = %349
  %358 = getelementptr %struct.VdbeFrame, %struct.VdbeFrame* %351, i32 0, i32 6, !dbg !444
  %359 = load i8*, i8** %358, align 8, !dbg !445
  %360 = load i8, i8* %359, align 1, !dbg !446
  br label %364, !dbg !447

361:                                              ; preds = %349
  %362 = load i32, i32* %355, align 4, !dbg !448
  %363 = icmp eq i32 %362, %354, !dbg !449
  br i1 %363, label %428, label %364, !dbg !450

364:                                              ; preds = %361, %357
  store i32 %354, i32* %355, align 4, !dbg !451
  %365 = getelementptr %struct.VdbeOp, %struct.VdbeOp* %11, i32 6, !dbg !452
  %366 = call i8* @llvm.stacksave(), !dbg !455
  %367 = getelementptr %struct.VdbeOp, %struct.VdbeOp* %365, i32 0, i32 4, !dbg !456
  %368 = load i32, i32* %367, align 4, !dbg !459
  %369 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %7, i32 %368, !dbg !460
  %370 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %369, i32 0, i32 1, !dbg !455
  %371 = load i16, i16* %370, align 2, !dbg !455
  %372 = and i16 %371, 9216, !dbg !455
  %373 = icmp ne i16 %372, 0, !dbg !455
  %374 = alloca %struct.sqlite3_value*, align 8, !dbg !455
  br i1 %373, label %375, label %377, !dbg !455

375:                                              ; preds = %364
  %376 = call %struct.sqlite3_value* @out2PrereleaseWithClear(%struct.sqlite3_value* %369), !dbg !455
  store %struct.sqlite3_value* %376, %struct.sqlite3_value** %374, align 8, !dbg !455
  br label %378, !dbg !455

377:                                              ; preds = %364
  store i16 4, i16* %370, align 2, !dbg !455
  store %struct.sqlite3_value* %369, %struct.sqlite3_value** %374, align 8, !dbg !455
  br label %378, !dbg !455

378:                                              ; preds = %377, %375
  %379 = load %struct.sqlite3_value*, %struct.sqlite3_value** %374, align 8, !dbg !455
  call void @llvm.stackrestore(i8* %366), !dbg !455
  %380 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %379, i32 0, i32 1, !dbg !461
  %381 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %379, i32 0, i32 2, !dbg !462
  %382 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %379, i32 0, i32 4, !dbg !463
  %383 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %379, i32 0, i32 5, !dbg !464
  store i16 2562, i16* %380, align 2, !dbg !465
  %384 = getelementptr %struct.VdbeOp, %struct.VdbeOp* %365, i32 0, i32 6, !dbg !466
  %385 = bitcast %union.p4union* %384 to i8**, !dbg !467
  %386 = load i8*, i8** %385, align 8, !dbg !468
  store i8* %386, i8** %383, align 8, !dbg !469
  store i32 10, i32* %382, align 4, !dbg !470
  store i8 1, i8* %381, align 1, !dbg !471
  %387 = getelementptr %struct.Vdbe, %struct.Vdbe* %0, i32 0, i32 17, !dbg !472
  %388 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %7, i32 5, !dbg !475
  %389 = getelementptr %struct.VdbeOp, %struct.VdbeOp* %11, i32 7, !dbg !476
  %390 = getelementptr %struct.VdbeOp, %struct.VdbeOp* %389, i32 0, i32 6, !dbg !477
  %391 = bitcast %union.p4union* %390 to %struct.sqlite3_context**, !dbg !478
  %392 = load %struct.sqlite3_context*, %struct.sqlite3_context** %391, align 8, !dbg !479
  %393 = getelementptr %struct.sqlite3_context, %struct.sqlite3_context* %392, i32 0, i32 0, !dbg !480
  %394 = load %struct.sqlite3_value*, %struct.sqlite3_value** %393, align 8, !dbg !481
  %395 = getelementptr %struct.sqlite3_context, %struct.sqlite3_context* %392, i32 0, i32 1, !dbg !482
  %396 = getelementptr %struct.sqlite3_context, %struct.sqlite3_context* %392, i32 0, i32 7, !dbg !483
  %397 = load i8, i8* %396, align 1, !dbg !484
  %398 = zext i8 %397 to i32, !dbg !485
  %399 = getelementptr %struct.sqlite3_context, %struct.sqlite3_context* %392, i32 0, i32 8, !dbg !486
  %400 = bitcast [1 x %struct.sqlite3_value*]* %399 to %struct.sqlite3_value**, !dbg !487
  %401 = ptrtoint %struct.sqlite3_value* %394 to i64, !dbg !488
  %402 = ptrtoint %struct.sqlite3_value* %388 to i64, !dbg !489
  %403 = icmp ne i64 %401, %402, !dbg !490
  br i1 %403, label %404, label %407, !dbg !491

404:                                              ; preds = %378
  %405 = getelementptr %struct.sqlite3_context, %struct.sqlite3_context* %392, i32 0, i32 3, !dbg !492
  store %struct.Vdbe* %0, %struct.Vdbe** %405, align 8, !dbg !493
  store %struct.sqlite3_value* %388, %struct.sqlite3_value** %393, align 8, !dbg !494
  %406 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %7, i32 6, !dbg !495
  store %struct.sqlite3_value* %406, %struct.sqlite3_value** %400, align 8, !dbg !496
  br label %407, !dbg !497

407:                                              ; preds = %378, %404
  %408 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %388, i32 0, i32 1, !dbg !498
  %409 = load i16, i16* %408, align 2, !dbg !499
  %410 = and i16 %409, 15936, !dbg !499
  %411 = or i16 %410, 1, !dbg !499
  store i16 %411, i16* %408, align 2, !dbg !499
  %412 = load %struct.FuncDef*, %struct.FuncDef** %395, align 8, !dbg !500
  %413 = getelementptr %struct.FuncDef, %struct.FuncDef* %412, i32 0, i32 4, !dbg !501
  %414 = load void (%struct.sqlite3_context*, i32, %struct.sqlite3_value**)*, void (%struct.sqlite3_context*, i32, %struct.sqlite3_value**)** %413, align 8, !dbg !502
  call void %414(%struct.sqlite3_context* %392, i32 %398, %struct.sqlite3_value** %400), !dbg !503
  %415 = getelementptr %struct.sqlite3_context, %struct.sqlite3_context* %392, i32 0, i32 5, !dbg !504
  %416 = load i32, i32* %415, align 4, !dbg !505
  %417 = icmp ne i32 %416, 0, !dbg !506
  %418 = icmp sgt i32 %416, 0, !dbg !507
  br i1 %418, label %419, label %421, !dbg !508

419:                                              ; preds = %407
  %420 = call i8* @sqlite3_value_text(%struct.sqlite3_value* %388), !dbg !509
  call void (%struct.Vdbe*, i8*, ...) @sqlite3VdbeError(%struct.Vdbe* %0, i8* %3, i8* %420), !dbg !510
  br label %421, !dbg !511

421:                                              ; preds = %419, %407
  %422 = load i16, i16* %408, align 2, !dbg !512
  %423 = and i16 %422, 18, !dbg !513
  %424 = icmp ne i16 %423, 0, !dbg !514
  br i1 %424, label %425, label %428, !dbg !515

425:                                              ; preds = %421
  %426 = call i32 @sqlite3VdbeChangeEncoding(%struct.sqlite3_value* %388, i32 1), !dbg !516
  %427 = call i32 @sqlite3VdbeMemTooBig(%struct.sqlite3_value* %388), !dbg !517
  br label %428, !dbg !518

428:                                              ; preds = %425, %421, %361
  %429 = call i8* @llvm.stacksave(), !dbg !519
  %430 = alloca i32, align 8, !dbg !522
  %431 = alloca i32, align 8, !dbg !523
  %432 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %7, i32 5, !dbg !524
  %433 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %432, i32 0, i32 1, !dbg !525
  %434 = load i16, i16* %433, align 2, !dbg !526
  %435 = alloca i16, align 8, !dbg !527
  store i16 %434, i16* %435, align 2, !dbg !528
  %436 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %105, i32 0, i32 1, !dbg !529
  %437 = load i16, i16* %436, align 2, !dbg !530
  %438 = alloca i16, align 8, !dbg !531
  store i16 %437, i16* %438, align 2, !dbg !532
  %439 = or i16 %434, %437, !dbg !533
  %440 = and i16 %439, 1, !dbg !534
  %441 = icmp ne i16 %440, 0, !dbg !535
  br i1 %441, label %442, label %443, !dbg !536

442:                                              ; preds = %428
  call void @llvm.stackrestore(i8* %429), !dbg !537
  br label %2380, !dbg !538

443:                                              ; preds = %428
  %444 = and i16 %434, 2, !dbg !539
  %445 = and i16 %434, 44, !dbg !540
  %446 = icmp eq i16 %444, 0, !dbg !541
  %447 = icmp ne i16 %445, 0, !dbg !542
  %448 = and i16 %437, 2, !dbg !543
  %449 = and i16 %437, 44, !dbg !544
  %450 = icmp eq i16 %448, 0, !dbg !545
  %451 = icmp ne i16 %449, 0, !dbg !546
  %452 = and i1 %446, %447, !dbg !547
  br i1 %452, label %453, label %459, !dbg !548

453:                                              ; preds = %443
  %454 = call i32 @sqlite3VdbeMemStringify(%struct.sqlite3_value* %432, i8 1, i8 1), !dbg !549
  %455 = load i16, i16* %433, align 2, !dbg !550
  %456 = and i16 %455, 15936, !dbg !550
  %457 = and i16 %434, -15937, !dbg !551
  %458 = or i16 %456, %457, !dbg !552
  store i16 %458, i16* %435, align 2, !dbg !553
  br label %459, !dbg !554

459:                                              ; preds = %453, %443
  %460 = and i1 %450, %451, !dbg !555
  br i1 %460, label %461, label %467, !dbg !556

461:                                              ; preds = %459
  %462 = call i32 @sqlite3VdbeMemStringify(%struct.sqlite3_value* %105, i8 1, i8 1), !dbg !557
  %463 = load i16, i16* %436, align 2, !dbg !558
  %464 = and i16 %463, 15936, !dbg !558
  %465 = and i16 %437, -15937, !dbg !559
  %466 = or i16 %464, %465, !dbg !560
  store i16 %466, i16* %438, align 2, !dbg !561
  br label %467, !dbg !562

467:                                              ; preds = %461, %459
  %468 = getelementptr %struct.VdbeOp, %struct.VdbeOp* %11, i32 8, !dbg !563
  %469 = getelementptr %struct.VdbeOp, %struct.VdbeOp* %468, i32 0, i32 6, !dbg !564
  %470 = bitcast %union.p4union* %469 to %struct.CollSeq**, !dbg !565
  %471 = load %struct.CollSeq*, %struct.CollSeq** %470, align 8, !dbg !566
  %472 = call i32 @sqlite3MemCompare(%struct.sqlite3_value* %105, %struct.sqlite3_value* %432, %struct.CollSeq* %471), !dbg !567
  store i32 %472, i32* %430, align 4, !dbg !568
  %473 = icmp slt i32 %472, 0, !dbg !569
  br i1 %473, label %474, label %475, !dbg !570

474:                                              ; preds = %467
  store i32 1, i32* %431, align 4, !dbg !571
  br label %476, !dbg !572

475:                                              ; preds = %467
  store i32 0, i32* %431, align 4, !dbg !573
  br label %476, !dbg !573

476:                                              ; preds = %475, %474
  store i16 %437, i16* %438, align 2, !dbg !574
  store i16 %434, i16* %435, align 2, !dbg !575
  %477 = load i32, i32* %431, align 4, !dbg !576
  %478 = icmp ne i32 %477, 0, !dbg !577
  call void @llvm.stackrestore(i8* %429), !dbg !578
  br i1 %478, label %2380, label %479, !dbg !579

479:                                              ; preds = %476
  %480 = call i8* @llvm.stacksave(), !dbg !142
  %481 = load i8, i8* %96, align 1, !dbg !146
  %482 = alloca i32, align 4, !dbg !147
  store i32 0, i32* %482, align 4, !dbg !148
  %483 = alloca %struct.VdbeCursor*, align 8, !dbg !149
  %484 = load %struct.VdbeCursor*, %struct.VdbeCursor** %9, align 8, !dbg !150
  store %struct.VdbeCursor* %484, %struct.VdbeCursor** %483, align 8, !dbg !151
  %485 = alloca i8*, align 8, !dbg !152
  %486 = alloca i32, align 4, !dbg !153
  %487 = call i32 @sqlite3VdbeCursorMoveto(%struct.VdbeCursor** %483, i32* %482), !dbg !154
  %488 = load %struct.VdbeCursor*, %struct.VdbeCursor** %483, align 8, !dbg !155
  %489 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %488, i32 0, i32 16, !dbg !157
  %490 = load i16, i16* %489, align 2, !dbg !158
  %491 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %488, i32 0, i32 19, !dbg !159
  %492 = load i32*, i32** %491, align 8, !dbg !160
  %493 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %488, i32 0, i32 0, !dbg !161
  %494 = load i8, i8* %493, align 1, !dbg !162
  %495 = icmp ne i8 %494, 3, !dbg !163
  %496 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %488, i32 0, i32 2, !dbg !164
  %497 = load i8, i8* %496, align 1, !dbg !165
  %498 = icmp ne i8 %497, 0, !dbg !166
  %499 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %488, i32 0, i32 14, !dbg !167
  %500 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %488, i32 0, i32 21, !dbg !168
  %501 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %488, i32 0, i32 22, !dbg !169
  %502 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %488, i32 0, i32 20, !dbg !170
  %503 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %488, i32 0, i32 17, !dbg !171
  %504 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %488, i32 0, i32 9, !dbg !172
  %505 = load i32, i32* %504, align 4, !dbg !173
  %506 = load i32, i32* %123, align 4, !dbg !175
  %507 = icmp ne i32 %505, %506, !dbg !176
  br i1 %507, label %508, label %549, !dbg !177

508:                                              ; preds = %479
  br i1 %498, label %530, label %525, !dbg !178

509:                                              ; preds = %525, %532
  %510 = load i32, i32* %123, align 4, !dbg !179
  store i32 %510, i32* %504, align 4, !dbg !180
  %511 = load i8*, i8** %502, align 8, !dbg !181
  %512 = load i8, i8* %511, align 1, !dbg !182
  %513 = icmp sgt i8 %512, -1, !dbg !185
  br i1 %513, label %514, label %516, !dbg !186

514:                                              ; preds = %509
  %515 = zext i8 %512 to i32, !dbg !187
  store i32 %515, i32* %492, align 4, !dbg !188
  store i32 1, i32* %499, align 4, !dbg !189
  br label %519, !dbg !190

516:                                              ; preds = %509
  %517 = call i8 @sqlite3GetVarint32(i8* %511, i32* %492), !dbg !191
  %518 = zext i8 %517 to i32, !dbg !192
  store i32 %518, i32* %499, align 4, !dbg !193
  br label %519, !dbg !194

519:                                              ; preds = %516, %514
  store i16 0, i16* %503, align 2, !dbg !195
  %520 = load i32, i32* %501, align 4, !dbg !196
  %521 = load i32, i32* %492, align 4, !dbg !197
  %522 = icmp ult i32 %520, %521, !dbg !198
  br i1 %522, label %524, label %523, !dbg !199

523:                                              ; preds = %519
  store i8* %511, i8** %485, align 8, !dbg !200
  br label %641, !dbg !201

524:                                              ; preds = %519
  store i8* null, i8** %502, align 8, !dbg !202
  store i32 0, i32* %501, align 4, !dbg !203
  br label %549, !dbg !204

525:                                              ; preds = %508
  %526 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %488, i32 0, i32 12, i32 0, !dbg !205
  %527 = load %struct.BtCursor*, %struct.BtCursor** %526, align 8, !dbg !206
  %528 = call i32 @sqlite3BtreePayloadSize(%struct.BtCursor* %527), !dbg !207
  store i32 %528, i32* %500, align 4, !dbg !208
  %529 = call i8* @sqlite3BtreePayloadFetch(%struct.BtCursor* %527, i32* %501), !dbg !209
  store i8* %529, i8** %502, align 8, !dbg !210
  br label %509, !dbg !211

530:                                              ; preds = %508
  %531 = icmp eq i8 %494, 3, !dbg !212
  br i1 %531, label %532, label %543, !dbg !213

532:                                              ; preds = %530
  %533 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %488, i32 0, i32 10, !dbg !214
  %534 = load i32, i32* %533, align 4, !dbg !215
  %535 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %7, i32 %534, !dbg !216
  %536 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %535, i32 0, i32 1, !dbg !217
  %537 = load i16, i16* %536, align 2, !dbg !218
  %538 = and i16 %537, 16, !dbg !219
  %539 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %535, i32 0, i32 4, !dbg !220
  %540 = load i32, i32* %539, align 4, !dbg !221
  store i32 %540, i32* %500, align 4, !dbg !222
  store i32 %540, i32* %501, align 4, !dbg !223
  %541 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %535, i32 0, i32 5, !dbg !224
  %542 = load i8*, i8** %541, align 8, !dbg !225
  store i8* %542, i8** %502, align 8, !dbg !226
  br label %509, !dbg !227

543:                                              ; preds = %530
  %544 = load i16, i16* %436, align 2, !dbg !228
  %545 = and i16 %544, 9216, !dbg !228
  %546 = icmp ne i16 %545, 0, !dbg !228
  br i1 %546, label %547, label %548, !dbg !228

547:                                              ; preds = %543
  call void @vdbeMemClearExternAndSetNull(%struct.sqlite3_value* %105), !dbg !228
  br label %728, !dbg !228

548:                                              ; preds = %543
  store i16 1, i16* %436, align 2, !dbg !228
  br label %728, !dbg !228

549:                                              ; preds = %524, %479
  %550 = load i16, i16* %503, align 2, !dbg !229
  %551 = icmp ule i16 %550, 10, !dbg !230
  br i1 %551, label %633, label %630, !dbg !231

552:                                              ; preds = %630, %719
  %553 = load i16, i16* %436, align 2, !dbg !233
  %554 = and i16 9216, %553, !dbg !234
  %555 = icmp eq i16 0, %554, !dbg !235
  br i1 %555, label %556, label %560, !dbg !236

556:                                              ; preds = %552
  %557 = icmp ne i16 %554, 0, !dbg !237
  br i1 %557, label %558, label %559, !dbg !237

558:                                              ; preds = %556
  call void @vdbeMemClearExternAndSetNull(%struct.sqlite3_value* %105), !dbg !237
  br label %560, !dbg !237

559:                                              ; preds = %556
  store i16 1, i16* %436, align 2, !dbg !237
  br label %560, !dbg !237

560:                                              ; preds = %558, %559, %552
  %561 = load i32, i32* %486, align 4, !dbg !238
  %562 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %488, i32 0, i32 23, i32 10, !dbg !239
  %563 = load i32, i32* %562, align 4, !dbg !240
  %564 = load i32, i32* %501, align 4, !dbg !241
  %565 = getelementptr i32, i32* %492, i32 11, !dbg !242
  %566 = load i32, i32* %565, align 4, !dbg !243
  %567 = icmp sge i32 %564, %566, !dbg !244
  br i1 %567, label %568, label %608, !dbg !245

568:                                              ; preds = %560
  %569 = load i8*, i8** %502, align 8, !dbg !246
  %570 = ptrtoint i8* %569 to i64, !dbg !247
  %571 = getelementptr i32, i32* %492, i32 10, !dbg !248
  %572 = load i32, i32* %571, align 4, !dbg !249
  %573 = zext i32 %572 to i64, !dbg !250
  %574 = add i64 %570, %573, !dbg !251
  %575 = inttoptr i64 %574 to i8*, !dbg !252
  store i8* %575, i8** %485, align 8, !dbg !253
  %576 = load i32, i32* %486, align 4, !dbg !254
  %577 = icmp ult i32 %576, 12, !dbg !255
  br i1 %577, label %578, label %580, !dbg !256

578:                                              ; preds = %568
  %579 = call i32 @sqlite3VdbeSerialGet(i8* %575, i32 %576, %struct.sqlite3_value* %105), !dbg !257
  br label %728, !dbg !258

580:                                              ; preds = %568
  %581 = alloca i16, i32 2, align 2, !dbg !259
  store i16 16, i16* %581, align 2, !dbg !260
  %582 = getelementptr i16, i16* %581, i32 1, !dbg !261
  store i16 514, i16* %582, align 2, !dbg !262
  %583 = load i32, i32* %486, align 4, !dbg !263
  %584 = sub i32 %583, 12, !dbg !264
  %585 = lshr i32 %584, 1, !dbg !265
  %586 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %105, i32 0, i32 4, !dbg !266
  store i32 %585, i32* %586, align 4, !dbg !267
  %587 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %105, i32 0, i32 2, !dbg !268
  store i8 %481, i8* %587, align 1, !dbg !269
  %588 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %105, i32 0, i32 5, !dbg !270
  %589 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %105, i32 0, i32 7, !dbg !271
  %590 = load i32, i32* %589, align 4, !dbg !272
  %591 = add i32 %585, 2, !dbg !273
  %592 = icmp slt i32 %590, %591, !dbg !274
  br i1 %592, label %593, label %595, !dbg !275

593:                                              ; preds = %580
  store i16 1, i16* %436, align 2, !dbg !276
  %594 = call i32 @sqlite3VdbeMemGrow(%struct.sqlite3_value* %105, i32 %591, i32 0), !dbg !277
  br label %598, !dbg !278

595:                                              ; preds = %580
  %596 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %105, i32 0, i32 6, !dbg !279
  %597 = load i8*, i8** %596, align 8, !dbg !280
  store i8* %597, i8** %588, align 8, !dbg !281
  br label %598, !dbg !282

598:                                              ; preds = %595, %593
  %599 = zext i32 %585 to i64, !dbg !283
  %600 = load i8*, i8** %588, align 8, !dbg !284
  %601 = load i8*, i8** %485, align 8, !dbg !285
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %600, i8* %601, i64 %599, i1 false), !dbg !286
  %602 = getelementptr i8, i8* %600, i32 %585, !dbg !287
  store i8 0, i8* %602, align 1, !dbg !288
  %603 = add i32 %585, 1, !dbg !289
  %604 = getelementptr i8, i8* %600, i32 %603, !dbg !290
  store i8 0, i8* %604, align 1, !dbg !291
  %605 = and i32 %583, 1, !dbg !292
  %606 = getelementptr i16, i16* %581, i32 %605, !dbg !293
  %607 = load i16, i16* %606, align 2, !dbg !294
  store i16 %607, i16* %436, align 2, !dbg !295
  br label %728, !dbg !296

608:                                              ; preds = %560
  %609 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %105, i32 0, i32 2, !dbg !297
  store i8 %481, i8* %609, align 1, !dbg !298
  %610 = load i32, i32* %486, align 4, !dbg !299
  %611 = and i32 %610, 1, !dbg !300
  %612 = icmp eq i32 %611, 0, !dbg !301
  %613 = icmp sge i32 %610, 12, !dbg !302
  %614 = and i1 %613, %612, !dbg !303
  %615 = call i32 @sqlite3VdbeSerialTypeLen(i32 %610), !dbg !304
  %616 = icmp eq i32 %615, 0, !dbg !305
  br i1 %616, label %628, label %617, !dbg !306

617:                                              ; preds = %608
  %618 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %488, i32 0, i32 12, i32 0, !dbg !307
  %619 = load %struct.BtCursor*, %struct.BtCursor** %618, align 8, !dbg !308
  %620 = getelementptr i32, i32* %492, i32 10, !dbg !309
  %621 = load i32, i32* %620, align 4, !dbg !310
  %622 = call i32 @sqlite3VdbeMemFromBtree(%struct.BtCursor* %619, i32 %621, i32 %615, %struct.sqlite3_value* %105), !dbg !311
  %623 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %105, i32 0, i32 5, !dbg !312
  %624 = load i8*, i8** %623, align 8, !dbg !313
  %625 = call i32 @sqlite3VdbeSerialGet(i8* %624, i32 %610, %struct.sqlite3_value* %105), !dbg !314
  %626 = load i16, i16* %436, align 2, !dbg !315
  %627 = and i16 %626, -4097, !dbg !316
  store i16 %627, i16* %436, align 2, !dbg !317
  br label %728, !dbg !318

628:                                              ; preds = %608
  %629 = call i32 @sqlite3VdbeSerialGet(i8* %1, i32 %610, %struct.sqlite3_value* %105), !dbg !319
  br label %728, !dbg !320

630:                                              ; preds = %549
  %631 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %488, i32 0, i32 23, i32 10, !dbg !321
  %632 = load i32, i32* %631, align 4, !dbg !322
  store i32 %632, i32* %486, align 4, !dbg !323
  br label %552, !dbg !324

633:                                              ; preds = %549
  %634 = load i32, i32* %499, align 4, !dbg !325
  %635 = load i32, i32* %492, align 4, !dbg !326
  %636 = icmp ult i32 %634, %635, !dbg !327
  br i1 %636, label %637, label %718, !dbg !328

637:                                              ; preds = %633
  %638 = load i8*, i8** %502, align 8, !dbg !329
  %639 = icmp eq i8* %638, null, !dbg !330
  br i1 %639, label %641, label %640, !dbg !331

640:                                              ; preds = %637
  store i8* %638, i8** %485, align 8, !dbg !332
  br label %641, !dbg !333

641:                                              ; preds = %640, %637, %523
  %642 = alloca i32, align 4, !dbg !334
  %643 = load i16, i16* %503, align 2, !dbg !335
  %644 = zext i16 %643 to i32, !dbg !336
  store i32 %644, i32* %642, align 4, !dbg !337
  %645 = alloca i64, align 8, !dbg !338
  %646 = getelementptr i32, i32* %492, i32 %644, !dbg !339
  %647 = load i32, i32* %646, align 4, !dbg !340
  %648 = zext i32 %647 to i64, !dbg !341
  store i64 %648, i64* %645, align 4, !dbg !342
  %649 = load i8*, i8** %485, align 8, !dbg !343
  %650 = load i32, i32* %499, align 4, !dbg !344
  %651 = alloca i8*, align 8, !dbg !345
  %652 = getelementptr i8, i8* %649, i32 %650, !dbg !346
  store i8* %652, i8** %651, align 8, !dbg !347
  %653 = load i32, i32* %492, align 4, !dbg !348
  %654 = getelementptr i8, i8* %649, i32 %653, !dbg !349
  br label %655, !dbg !350

655:                                              ; preds = %662, %641
  %656 = load i32, i32* %642, align 4, !dbg !351
  %657 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %488, i32 0, i32 23, i32 %656, !dbg !352
  %658 = load i8*, i8** %651, align 8, !dbg !353
  %659 = load i8, i8* %658, align 1, !dbg !354
  %660 = zext i8 %659 to i32, !dbg !355
  store i32 %660, i32* %486, align 4, !dbg !356
  store i32 %660, i32* %657, align 4, !dbg !357
  %661 = icmp sgt i8 %659, -1, !dbg !358
  br i1 %661, label %685, label %676, !dbg !359

662:                                              ; preds = %676, %685
  %663 = load i32, i32* %642, align 4, !dbg !360
  %664 = add i32 %663, 1, !dbg !361
  store i32 %664, i32* %642, align 4, !dbg !362
  %665 = load i64, i64* %645, align 4, !dbg !363
  %666 = and i64 4294967295, %665, !dbg !364
  %667 = trunc i64 %666 to i32, !dbg !365
  %668 = getelementptr i32, i32* %492, i32 %664, !dbg !366
  store i32 %667, i32* %668, align 4, !dbg !367
  %669 = load i32, i32* %642, align 4, !dbg !368
  %670 = icmp sle i32 %669, 10, !dbg !369
  %671 = load i8*, i8** %651, align 8, !dbg !370
  %672 = ptrtoint i8* %671 to i64, !dbg !371
  %673 = ptrtoint i8* %654 to i64, !dbg !372
  %674 = icmp ult i64 %672, %673, !dbg !373
  %675 = and i1 %670, %674, !dbg !374
  br i1 %675, label %655, label %694, !dbg !375

676:                                              ; preds = %655
  %677 = load i8*, i8** %651, align 8, !dbg !376
  %678 = call i8 @sqlite3GetVarint32(i8* %677, i32* %486), !dbg !377
  %679 = getelementptr i8, i8* %677, i8 %678, !dbg !378
  store i8* %679, i8** %651, align 8, !dbg !379
  %680 = load i32, i32* %486, align 4, !dbg !380
  store i32 %680, i32* %657, align 4, !dbg !381
  %681 = load i64, i64* %645, align 4, !dbg !382
  %682 = call i32 @sqlite3VdbeSerialTypeLen(i32 %680), !dbg !383
  %683 = zext i32 %682 to i64, !dbg !384
  %684 = add i64 %681, %683, !dbg !385
  store i64 %684, i64* %645, align 4, !dbg !386
  br label %662, !dbg !387

685:                                              ; preds = %655
  %686 = getelementptr i8, i8* %658, i32 1, !dbg !388
  store i8* %686, i8** %651, align 8, !dbg !389
  %687 = load i32, i32* %486, align 4, !dbg !390
  %688 = trunc i32 %687 to i8, !dbg !391
  %689 = getelementptr i8, i8* %4, i8 %688, !dbg !392
  %690 = load i8, i8* %689, align 1, !dbg !393
  %691 = zext i8 %690 to i64, !dbg !394
  %692 = load i64, i64* %645, align 4, !dbg !395
  %693 = add i64 %692, %691, !dbg !396
  store i64 %693, i64* %645, align 4, !dbg !397
  br label %662, !dbg !398

694:                                              ; preds = %662
  %695 = load i64, i64* %645, align 4, !dbg !399
  %696 = load i32, i32* %500, align 4, !dbg !400
  %697 = zext i32 %696 to i64, !dbg !401
  %698 = icmp uge i64 %672, %673, !dbg !402
  %699 = icmp ugt i64 %672, %673, !dbg !403
  %700 = icmp ne i64 %695, %697, !dbg !404
  %701 = icmp ugt i64 %695, %697, !dbg !405
  %702 = or i1 %699, %700, !dbg !406
  %703 = and i1 %698, %702, !dbg !407
  %704 = or i1 %703, %701, !dbg !408
  br i1 %704, label %705, label %709, !dbg !409

705:                                              ; preds = %694
  %706 = load i32, i32* %492, align 4, !dbg !410
  %707 = icmp eq i32 %706, 0, !dbg !411
  br i1 %707, label %708, label %709, !dbg !412

708:                                              ; preds = %705
  store i32 0, i32* %642, align 4, !dbg !413
  store i8* %654, i8** %651, align 8, !dbg !414
  br label %709, !dbg !415

709:                                              ; preds = %708, %705, %694
  %710 = load i32, i32* %642, align 4, !dbg !416
  %711 = trunc i32 %710 to i16, !dbg !417
  store i16 %711, i16* %503, align 2, !dbg !418
  %712 = load i8*, i8** %651, align 8, !dbg !419
  %713 = ptrtoint i8* %712 to i64, !dbg !420
  %714 = load i8*, i8** %485, align 8, !dbg !421
  %715 = ptrtoint i8* %714 to i64, !dbg !422
  %716 = sub i64 %713, %715, !dbg !423
  %717 = trunc i64 %716 to i32, !dbg !424
  store i32 %717, i32* %499, align 4, !dbg !425
  br label %719, !dbg !426

718:                                              ; preds = %633
  store i32 0, i32* %486, align 4, !dbg !427
  br label %719, !dbg !428

719:                                              ; preds = %709, %718
  %720 = load i16, i16* %503, align 2, !dbg !429
  %721 = icmp sle i16 %720, 10, !dbg !430
  br i1 %721, label %722, label %552, !dbg !431

722:                                              ; preds = %719
  %723 = load i16, i16* %436, align 2, !dbg !432
  %724 = and i16 %723, 9216, !dbg !432
  %725 = icmp ne i16 %724, 0, !dbg !432
  br i1 %725, label %726, label %727, !dbg !432

726:                                              ; preds = %722
  call void @vdbeMemClearExternAndSetNull(%struct.sqlite3_value* %105), !dbg !432
  br label %728, !dbg !432

727:                                              ; preds = %722
  store i16 1, i16* %436, align 2, !dbg !432
  br label %728, !dbg !432

728:                                              ; preds = %726, %727, %598, %578, %617, %628, %547, %548
  call void @llvm.stackrestore(i8* %480), !dbg !433
  %729 = load %struct.VdbeFrame*, %struct.VdbeFrame** %350, align 8, !dbg !437
  %730 = ptrtoint %struct.VdbeFrame* %729 to i64, !dbg !438
  %731 = load i32, i32* %353, align 4, !dbg !440
  %732 = getelementptr %struct.VdbeOp, %struct.VdbeOp* %11, i32 10, i32 3, !dbg !441
  %733 = icmp ne i64 %730, 0, !dbg !442
  br i1 %733, label %734, label %739, !dbg !443

734:                                              ; preds = %728
  %735 = getelementptr %struct.VdbeFrame, %struct.VdbeFrame* %729, i32 0, i32 6, !dbg !444
  %736 = load i8*, i8** %735, align 8, !dbg !445
  %737 = getelementptr i8, i8* %736, i32 1, !dbg !580
  %738 = load i8, i8* %737, align 1, !dbg !446
  br label %742, !dbg !447

739:                                              ; preds = %728
  %740 = load i32, i32* %732, align 4, !dbg !448
  %741 = icmp eq i32 %740, %731, !dbg !449
  br i1 %741, label %830, label %742, !dbg !450

742:                                              ; preds = %739, %734
  store i32 %731, i32* %732, align 4, !dbg !451
  %743 = getelementptr %struct.VdbeOp, %struct.VdbeOp* %11, i32 11, !dbg !452
  %744 = call i8* @llvm.stacksave(), !dbg !455
  %745 = getelementptr %struct.VdbeOp, %struct.VdbeOp* %743, i32 0, i32 4, !dbg !456
  %746 = load i32, i32* %745, align 4, !dbg !459
  %747 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %7, i32 %746, !dbg !460
  %748 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %747, i32 0, i32 1, !dbg !455
  %749 = load i16, i16* %748, align 2, !dbg !455
  %750 = and i16 %749, 9216, !dbg !455
  %751 = icmp ne i16 %750, 0, !dbg !455
  %752 = alloca %struct.sqlite3_value*, align 8, !dbg !455
  br i1 %751, label %753, label %755, !dbg !455

753:                                              ; preds = %742
  %754 = call %struct.sqlite3_value* @out2PrereleaseWithClear(%struct.sqlite3_value* %747), !dbg !455
  store %struct.sqlite3_value* %754, %struct.sqlite3_value** %752, align 8, !dbg !455
  br label %756, !dbg !455

755:                                              ; preds = %742
  store i16 4, i16* %748, align 2, !dbg !455
  store %struct.sqlite3_value* %747, %struct.sqlite3_value** %752, align 8, !dbg !455
  br label %756, !dbg !455

756:                                              ; preds = %755, %753
  %757 = load %struct.sqlite3_value*, %struct.sqlite3_value** %752, align 8, !dbg !455
  call void @llvm.stackrestore(i8* %744), !dbg !455
  %758 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %757, i32 0, i32 1, !dbg !461
  %759 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %757, i32 0, i32 2, !dbg !462
  %760 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %757, i32 0, i32 4, !dbg !463
  %761 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %757, i32 0, i32 5, !dbg !464
  store i16 2562, i16* %758, align 2, !dbg !465
  %762 = getelementptr %struct.VdbeOp, %struct.VdbeOp* %743, i32 0, i32 6, !dbg !466
  %763 = bitcast %union.p4union* %762 to i8**, !dbg !467
  %764 = load i8*, i8** %763, align 8, !dbg !468
  store i8* %764, i8** %761, align 8, !dbg !469
  store i32 10, i32* %760, align 4, !dbg !470
  store i8 1, i8* %759, align 1, !dbg !471
  %765 = getelementptr %struct.VdbeOp, %struct.VdbeOp* %11, i32 12, !dbg !452
  %766 = call i8* @llvm.stacksave(), !dbg !455
  %767 = getelementptr %struct.VdbeOp, %struct.VdbeOp* %765, i32 0, i32 4, !dbg !456
  %768 = load i32, i32* %767, align 4, !dbg !459
  %769 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %7, i32 %768, !dbg !460
  %770 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %769, i32 0, i32 1, !dbg !455
  %771 = load i16, i16* %770, align 2, !dbg !455
  %772 = and i16 %771, 9216, !dbg !455
  %773 = icmp ne i16 %772, 0, !dbg !455
  %774 = alloca %struct.sqlite3_value*, align 8, !dbg !455
  br i1 %773, label %775, label %777, !dbg !455

775:                                              ; preds = %756
  %776 = call %struct.sqlite3_value* @out2PrereleaseWithClear(%struct.sqlite3_value* %769), !dbg !455
  store %struct.sqlite3_value* %776, %struct.sqlite3_value** %774, align 8, !dbg !455
  br label %778, !dbg !455

777:                                              ; preds = %756
  store i16 4, i16* %770, align 2, !dbg !455
  store %struct.sqlite3_value* %769, %struct.sqlite3_value** %774, align 8, !dbg !455
  br label %778, !dbg !455

778:                                              ; preds = %777, %775
  %779 = load %struct.sqlite3_value*, %struct.sqlite3_value** %774, align 8, !dbg !455
  call void @llvm.stackrestore(i8* %766), !dbg !455
  %780 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %779, i32 0, i32 1, !dbg !461
  %781 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %779, i32 0, i32 2, !dbg !462
  %782 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %779, i32 0, i32 4, !dbg !463
  %783 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %779, i32 0, i32 5, !dbg !464
  store i16 2562, i16* %780, align 2, !dbg !465
  %784 = getelementptr %struct.VdbeOp, %struct.VdbeOp* %765, i32 0, i32 6, !dbg !466
  %785 = bitcast %union.p4union* %784 to i8**, !dbg !467
  %786 = load i8*, i8** %785, align 8, !dbg !468
  store i8* %786, i8** %783, align 8, !dbg !469
  store i32 7, i32* %782, align 4, !dbg !470
  store i8 1, i8* %781, align 1, !dbg !471
  %787 = getelementptr %struct.Vdbe, %struct.Vdbe* %0, i32 0, i32 17, !dbg !472
  %788 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %7, i32 7, !dbg !475
  %789 = getelementptr %struct.VdbeOp, %struct.VdbeOp* %11, i32 13, !dbg !476
  %790 = getelementptr %struct.VdbeOp, %struct.VdbeOp* %789, i32 0, i32 6, !dbg !477
  %791 = bitcast %union.p4union* %790 to %struct.sqlite3_context**, !dbg !478
  %792 = load %struct.sqlite3_context*, %struct.sqlite3_context** %791, align 8, !dbg !479
  %793 = getelementptr %struct.sqlite3_context, %struct.sqlite3_context* %792, i32 0, i32 0, !dbg !480
  %794 = load %struct.sqlite3_value*, %struct.sqlite3_value** %793, align 8, !dbg !481
  %795 = getelementptr %struct.sqlite3_context, %struct.sqlite3_context* %792, i32 0, i32 1, !dbg !482
  %796 = getelementptr %struct.sqlite3_context, %struct.sqlite3_context* %792, i32 0, i32 7, !dbg !483
  %797 = load i8, i8* %796, align 1, !dbg !484
  %798 = zext i8 %797 to i32, !dbg !485
  %799 = getelementptr %struct.sqlite3_context, %struct.sqlite3_context* %792, i32 0, i32 8, !dbg !486
  %800 = bitcast [1 x %struct.sqlite3_value*]* %799 to %struct.sqlite3_value**, !dbg !487
  %801 = ptrtoint %struct.sqlite3_value* %794 to i64, !dbg !488
  %802 = ptrtoint %struct.sqlite3_value* %788 to i64, !dbg !489
  %803 = icmp ne i64 %801, %802, !dbg !490
  br i1 %803, label %804, label %809, !dbg !491

804:                                              ; preds = %778
  %805 = getelementptr %struct.sqlite3_context, %struct.sqlite3_context* %792, i32 0, i32 3, !dbg !492
  store %struct.Vdbe* %0, %struct.Vdbe** %805, align 8, !dbg !493
  store %struct.sqlite3_value* %788, %struct.sqlite3_value** %793, align 8, !dbg !494
  %806 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %7, i32 9, !dbg !495
  %807 = getelementptr %struct.sqlite3_value*, %struct.sqlite3_value** %800, i32 1, !dbg !581
  store %struct.sqlite3_value* %806, %struct.sqlite3_value** %807, align 8, !dbg !496
  %808 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %7, i32 8, !dbg !495
  store %struct.sqlite3_value* %808, %struct.sqlite3_value** %800, align 8, !dbg !496
  br label %809, !dbg !497

809:                                              ; preds = %778, %804
  %810 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %788, i32 0, i32 1, !dbg !498
  %811 = load i16, i16* %810, align 2, !dbg !499
  %812 = and i16 %811, 15936, !dbg !499
  %813 = or i16 %812, 1, !dbg !499
  store i16 %813, i16* %810, align 2, !dbg !499
  %814 = load %struct.FuncDef*, %struct.FuncDef** %795, align 8, !dbg !500
  %815 = getelementptr %struct.FuncDef, %struct.FuncDef* %814, i32 0, i32 4, !dbg !501
  %816 = load void (%struct.sqlite3_context*, i32, %struct.sqlite3_value**)*, void (%struct.sqlite3_context*, i32, %struct.sqlite3_value**)** %815, align 8, !dbg !502
  call void %816(%struct.sqlite3_context* %792, i32 %798, %struct.sqlite3_value** %800), !dbg !503
  %817 = getelementptr %struct.sqlite3_context, %struct.sqlite3_context* %792, i32 0, i32 5, !dbg !504
  %818 = load i32, i32* %817, align 4, !dbg !505
  %819 = icmp ne i32 %818, 0, !dbg !506
  %820 = icmp sgt i32 %818, 0, !dbg !507
  br i1 %820, label %821, label %823, !dbg !508

821:                                              ; preds = %809
  %822 = call i8* @sqlite3_value_text(%struct.sqlite3_value* %788), !dbg !509
  call void (%struct.Vdbe*, i8*, ...) @sqlite3VdbeError(%struct.Vdbe* %0, i8* %3, i8* %822), !dbg !510
  br label %823, !dbg !511

823:                                              ; preds = %821, %809
  %824 = load i16, i16* %810, align 2, !dbg !512
  %825 = and i16 %824, 18, !dbg !513
  %826 = icmp ne i16 %825, 0, !dbg !514
  br i1 %826, label %827, label %830, !dbg !515

827:                                              ; preds = %823
  %828 = call i32 @sqlite3VdbeChangeEncoding(%struct.sqlite3_value* %788, i32 1), !dbg !516
  %829 = call i32 @sqlite3VdbeMemTooBig(%struct.sqlite3_value* %788), !dbg !517
  br label %830, !dbg !518

830:                                              ; preds = %827, %823, %739
  %831 = call i8* @llvm.stacksave(), !dbg !519
  %832 = alloca i32, align 8, !dbg !522
  %833 = alloca i32, align 8, !dbg !523
  %834 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %7, i32 7, !dbg !524
  %835 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %834, i32 0, i32 1, !dbg !525
  %836 = load i16, i16* %835, align 2, !dbg !526
  %837 = alloca i16, align 8, !dbg !527
  store i16 %836, i16* %837, align 2, !dbg !528
  %838 = load i16, i16* %436, align 2, !dbg !530
  %839 = alloca i16, align 8, !dbg !531
  store i16 %838, i16* %839, align 2, !dbg !532
  %840 = or i16 %836, %838, !dbg !533
  %841 = and i16 %840, 1, !dbg !534
  %842 = icmp ne i16 %841, 0, !dbg !535
  br i1 %842, label %843, label %844, !dbg !536

843:                                              ; preds = %830
  call void @llvm.stackrestore(i8* %831), !dbg !537
  br label %2380, !dbg !538

844:                                              ; preds = %830
  %845 = and i16 %836, 2, !dbg !539
  %846 = and i16 %836, 44, !dbg !540
  %847 = icmp eq i16 %845, 0, !dbg !541
  %848 = icmp ne i16 %846, 0, !dbg !542
  %849 = and i16 %838, 2, !dbg !543
  %850 = and i16 %838, 44, !dbg !544
  %851 = icmp eq i16 %849, 0, !dbg !545
  %852 = icmp ne i16 %850, 0, !dbg !546
  %853 = and i1 %847, %848, !dbg !547
  br i1 %853, label %854, label %860, !dbg !548

854:                                              ; preds = %844
  %855 = call i32 @sqlite3VdbeMemStringify(%struct.sqlite3_value* %834, i8 1, i8 1), !dbg !549
  %856 = load i16, i16* %835, align 2, !dbg !550
  %857 = and i16 %856, 15936, !dbg !550
  %858 = and i16 %836, -15937, !dbg !551
  %859 = or i16 %857, %858, !dbg !552
  store i16 %859, i16* %837, align 2, !dbg !553
  br label %860, !dbg !554

860:                                              ; preds = %854, %844
  %861 = and i1 %851, %852, !dbg !555
  br i1 %861, label %862, label %868, !dbg !556

862:                                              ; preds = %860
  %863 = call i32 @sqlite3VdbeMemStringify(%struct.sqlite3_value* %105, i8 1, i8 1), !dbg !557
  %864 = load i16, i16* %436, align 2, !dbg !558
  %865 = and i16 %864, 15936, !dbg !558
  %866 = and i16 %838, -15937, !dbg !559
  %867 = or i16 %865, %866, !dbg !560
  store i16 %867, i16* %839, align 2, !dbg !561
  br label %868, !dbg !562

868:                                              ; preds = %862, %860
  %869 = getelementptr %struct.VdbeOp, %struct.VdbeOp* %11, i32 14, !dbg !563
  %870 = getelementptr %struct.VdbeOp, %struct.VdbeOp* %869, i32 0, i32 6, !dbg !564
  %871 = bitcast %union.p4union* %870 to %struct.CollSeq**, !dbg !565
  %872 = load %struct.CollSeq*, %struct.CollSeq** %871, align 8, !dbg !566
  %873 = call i32 @sqlite3MemCompare(%struct.sqlite3_value* %105, %struct.sqlite3_value* %834, %struct.CollSeq* %872), !dbg !567
  store i32 %873, i32* %832, align 4, !dbg !568
  %874 = icmp slt i32 %873, 0, !dbg !569
  br i1 %874, label %875, label %876, !dbg !570

875:                                              ; preds = %868
  store i32 0, i32* %833, align 4, !dbg !571
  br label %877, !dbg !572

876:                                              ; preds = %868
  store i32 1, i32* %833, align 4, !dbg !573
  br label %877, !dbg !573

877:                                              ; preds = %876, %875
  store i16 %838, i16* %839, align 2, !dbg !574
  store i16 %836, i16* %837, align 2, !dbg !575
  %878 = load i32, i32* %833, align 4, !dbg !576
  %879 = icmp ne i32 %878, 0, !dbg !577
  call void @llvm.stackrestore(i8* %831), !dbg !578
  br i1 %879, label %2380, label %880, !dbg !579

880:                                              ; preds = %877
  %881 = call i8* @llvm.stacksave(), !dbg !142
  %882 = load i8, i8* %96, align 1, !dbg !146
  %883 = alloca i32, align 4, !dbg !147
  store i32 0, i32* %883, align 4, !dbg !148
  %884 = alloca %struct.VdbeCursor*, align 8, !dbg !149
  %885 = load %struct.VdbeCursor*, %struct.VdbeCursor** %9, align 8, !dbg !150
  store %struct.VdbeCursor* %885, %struct.VdbeCursor** %884, align 8, !dbg !151
  %886 = alloca i8*, align 8, !dbg !152
  %887 = alloca i32, align 4, !dbg !153
  %888 = call i32 @sqlite3VdbeCursorMoveto(%struct.VdbeCursor** %884, i32* %883), !dbg !154
  %889 = load %struct.VdbeCursor*, %struct.VdbeCursor** %884, align 8, !dbg !155
  %890 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %889, i32 0, i32 16, !dbg !157
  %891 = load i16, i16* %890, align 2, !dbg !158
  %892 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %889, i32 0, i32 19, !dbg !159
  %893 = load i32*, i32** %892, align 8, !dbg !160
  %894 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %889, i32 0, i32 0, !dbg !161
  %895 = load i8, i8* %894, align 1, !dbg !162
  %896 = icmp ne i8 %895, 3, !dbg !163
  %897 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %889, i32 0, i32 2, !dbg !164
  %898 = load i8, i8* %897, align 1, !dbg !165
  %899 = icmp ne i8 %898, 0, !dbg !166
  %900 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %889, i32 0, i32 14, !dbg !167
  %901 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %889, i32 0, i32 21, !dbg !168
  %902 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %889, i32 0, i32 22, !dbg !169
  %903 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %889, i32 0, i32 20, !dbg !170
  %904 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %889, i32 0, i32 17, !dbg !171
  %905 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %889, i32 0, i32 9, !dbg !172
  %906 = load i32, i32* %905, align 4, !dbg !173
  %907 = load i32, i32* %123, align 4, !dbg !175
  %908 = icmp ne i32 %906, %907, !dbg !176
  br i1 %908, label %909, label %950, !dbg !177

909:                                              ; preds = %880
  br i1 %899, label %931, label %926, !dbg !178

910:                                              ; preds = %926, %933
  %911 = load i32, i32* %123, align 4, !dbg !179
  store i32 %911, i32* %905, align 4, !dbg !180
  %912 = load i8*, i8** %903, align 8, !dbg !181
  %913 = load i8, i8* %912, align 1, !dbg !182
  %914 = icmp sgt i8 %913, -1, !dbg !185
  br i1 %914, label %915, label %917, !dbg !186

915:                                              ; preds = %910
  %916 = zext i8 %913 to i32, !dbg !187
  store i32 %916, i32* %893, align 4, !dbg !188
  store i32 1, i32* %900, align 4, !dbg !189
  br label %920, !dbg !190

917:                                              ; preds = %910
  %918 = call i8 @sqlite3GetVarint32(i8* %912, i32* %893), !dbg !191
  %919 = zext i8 %918 to i32, !dbg !192
  store i32 %919, i32* %900, align 4, !dbg !193
  br label %920, !dbg !194

920:                                              ; preds = %917, %915
  store i16 0, i16* %904, align 2, !dbg !195
  %921 = load i32, i32* %902, align 4, !dbg !196
  %922 = load i32, i32* %893, align 4, !dbg !197
  %923 = icmp ult i32 %921, %922, !dbg !198
  br i1 %923, label %925, label %924, !dbg !199

924:                                              ; preds = %920
  store i8* %912, i8** %886, align 8, !dbg !200
  br label %1042, !dbg !201

925:                                              ; preds = %920
  store i8* null, i8** %903, align 8, !dbg !202
  store i32 0, i32* %902, align 4, !dbg !203
  br label %950, !dbg !204

926:                                              ; preds = %909
  %927 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %889, i32 0, i32 12, i32 0, !dbg !205
  %928 = load %struct.BtCursor*, %struct.BtCursor** %927, align 8, !dbg !206
  %929 = call i32 @sqlite3BtreePayloadSize(%struct.BtCursor* %928), !dbg !207
  store i32 %929, i32* %901, align 4, !dbg !208
  %930 = call i8* @sqlite3BtreePayloadFetch(%struct.BtCursor* %928, i32* %902), !dbg !209
  store i8* %930, i8** %903, align 8, !dbg !210
  br label %910, !dbg !211

931:                                              ; preds = %909
  %932 = icmp eq i8 %895, 3, !dbg !212
  br i1 %932, label %933, label %944, !dbg !213

933:                                              ; preds = %931
  %934 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %889, i32 0, i32 10, !dbg !214
  %935 = load i32, i32* %934, align 4, !dbg !215
  %936 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %7, i32 %935, !dbg !216
  %937 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %936, i32 0, i32 1, !dbg !217
  %938 = load i16, i16* %937, align 2, !dbg !218
  %939 = and i16 %938, 16, !dbg !219
  %940 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %936, i32 0, i32 4, !dbg !220
  %941 = load i32, i32* %940, align 4, !dbg !221
  store i32 %941, i32* %901, align 4, !dbg !222
  store i32 %941, i32* %902, align 4, !dbg !223
  %942 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %936, i32 0, i32 5, !dbg !224
  %943 = load i8*, i8** %942, align 8, !dbg !225
  store i8* %943, i8** %903, align 8, !dbg !226
  br label %910, !dbg !227

944:                                              ; preds = %931
  %945 = load i16, i16* %436, align 2, !dbg !228
  %946 = and i16 %945, 9216, !dbg !228
  %947 = icmp ne i16 %946, 0, !dbg !228
  br i1 %947, label %948, label %949, !dbg !228

948:                                              ; preds = %944
  call void @vdbeMemClearExternAndSetNull(%struct.sqlite3_value* %105), !dbg !228
  br label %1129, !dbg !228

949:                                              ; preds = %944
  store i16 1, i16* %436, align 2, !dbg !228
  br label %1129, !dbg !228

950:                                              ; preds = %925, %880
  %951 = load i16, i16* %904, align 2, !dbg !229
  %952 = icmp ule i16 %951, 6, !dbg !230
  br i1 %952, label %1034, label %1031, !dbg !231

953:                                              ; preds = %1031, %1120
  %954 = load i16, i16* %436, align 2, !dbg !233
  %955 = and i16 9216, %954, !dbg !234
  %956 = icmp eq i16 0, %955, !dbg !235
  br i1 %956, label %957, label %961, !dbg !236

957:                                              ; preds = %953
  %958 = icmp ne i16 %955, 0, !dbg !237
  br i1 %958, label %959, label %960, !dbg !237

959:                                              ; preds = %957
  call void @vdbeMemClearExternAndSetNull(%struct.sqlite3_value* %105), !dbg !237
  br label %961, !dbg !237

960:                                              ; preds = %957
  store i16 1, i16* %436, align 2, !dbg !237
  br label %961, !dbg !237

961:                                              ; preds = %959, %960, %953
  %962 = load i32, i32* %887, align 4, !dbg !238
  %963 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %889, i32 0, i32 23, i32 6, !dbg !239
  %964 = load i32, i32* %963, align 4, !dbg !240
  %965 = load i32, i32* %902, align 4, !dbg !241
  %966 = getelementptr i32, i32* %893, i32 7, !dbg !242
  %967 = load i32, i32* %966, align 4, !dbg !243
  %968 = icmp sge i32 %965, %967, !dbg !244
  br i1 %968, label %969, label %1009, !dbg !245

969:                                              ; preds = %961
  %970 = load i8*, i8** %903, align 8, !dbg !246
  %971 = ptrtoint i8* %970 to i64, !dbg !247
  %972 = getelementptr i32, i32* %893, i32 6, !dbg !248
  %973 = load i32, i32* %972, align 4, !dbg !249
  %974 = zext i32 %973 to i64, !dbg !250
  %975 = add i64 %971, %974, !dbg !251
  %976 = inttoptr i64 %975 to i8*, !dbg !252
  store i8* %976, i8** %886, align 8, !dbg !253
  %977 = load i32, i32* %887, align 4, !dbg !254
  %978 = icmp ult i32 %977, 12, !dbg !255
  br i1 %978, label %979, label %981, !dbg !256

979:                                              ; preds = %969
  %980 = call i32 @sqlite3VdbeSerialGet(i8* %976, i32 %977, %struct.sqlite3_value* %105), !dbg !257
  br label %1129, !dbg !258

981:                                              ; preds = %969
  %982 = alloca i16, i32 2, align 2, !dbg !259
  store i16 16, i16* %982, align 2, !dbg !260
  %983 = getelementptr i16, i16* %982, i32 1, !dbg !261
  store i16 514, i16* %983, align 2, !dbg !262
  %984 = load i32, i32* %887, align 4, !dbg !263
  %985 = sub i32 %984, 12, !dbg !264
  %986 = lshr i32 %985, 1, !dbg !265
  %987 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %105, i32 0, i32 4, !dbg !266
  store i32 %986, i32* %987, align 4, !dbg !267
  %988 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %105, i32 0, i32 2, !dbg !268
  store i8 %882, i8* %988, align 1, !dbg !269
  %989 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %105, i32 0, i32 5, !dbg !270
  %990 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %105, i32 0, i32 7, !dbg !271
  %991 = load i32, i32* %990, align 4, !dbg !272
  %992 = add i32 %986, 2, !dbg !273
  %993 = icmp slt i32 %991, %992, !dbg !274
  br i1 %993, label %994, label %996, !dbg !275

994:                                              ; preds = %981
  store i16 1, i16* %436, align 2, !dbg !276
  %995 = call i32 @sqlite3VdbeMemGrow(%struct.sqlite3_value* %105, i32 %992, i32 0), !dbg !277
  br label %999, !dbg !278

996:                                              ; preds = %981
  %997 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %105, i32 0, i32 6, !dbg !279
  %998 = load i8*, i8** %997, align 8, !dbg !280
  store i8* %998, i8** %989, align 8, !dbg !281
  br label %999, !dbg !282

999:                                              ; preds = %996, %994
  %1000 = zext i32 %986 to i64, !dbg !283
  %1001 = load i8*, i8** %989, align 8, !dbg !284
  %1002 = load i8*, i8** %886, align 8, !dbg !285
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %1001, i8* %1002, i64 %1000, i1 false), !dbg !286
  %1003 = getelementptr i8, i8* %1001, i32 %986, !dbg !287
  store i8 0, i8* %1003, align 1, !dbg !288
  %1004 = add i32 %986, 1, !dbg !289
  %1005 = getelementptr i8, i8* %1001, i32 %1004, !dbg !290
  store i8 0, i8* %1005, align 1, !dbg !291
  %1006 = and i32 %984, 1, !dbg !292
  %1007 = getelementptr i16, i16* %982, i32 %1006, !dbg !293
  %1008 = load i16, i16* %1007, align 2, !dbg !294
  store i16 %1008, i16* %436, align 2, !dbg !295
  br label %1129, !dbg !296

1009:                                             ; preds = %961
  %1010 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %105, i32 0, i32 2, !dbg !297
  store i8 %882, i8* %1010, align 1, !dbg !298
  %1011 = load i32, i32* %887, align 4, !dbg !299
  %1012 = and i32 %1011, 1, !dbg !300
  %1013 = icmp eq i32 %1012, 0, !dbg !301
  %1014 = icmp sge i32 %1011, 12, !dbg !302
  %1015 = and i1 %1014, %1013, !dbg !303
  %1016 = call i32 @sqlite3VdbeSerialTypeLen(i32 %1011), !dbg !304
  %1017 = icmp eq i32 %1016, 0, !dbg !305
  br i1 %1017, label %1029, label %1018, !dbg !306

1018:                                             ; preds = %1009
  %1019 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %889, i32 0, i32 12, i32 0, !dbg !307
  %1020 = load %struct.BtCursor*, %struct.BtCursor** %1019, align 8, !dbg !308
  %1021 = getelementptr i32, i32* %893, i32 6, !dbg !309
  %1022 = load i32, i32* %1021, align 4, !dbg !310
  %1023 = call i32 @sqlite3VdbeMemFromBtree(%struct.BtCursor* %1020, i32 %1022, i32 %1016, %struct.sqlite3_value* %105), !dbg !311
  %1024 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %105, i32 0, i32 5, !dbg !312
  %1025 = load i8*, i8** %1024, align 8, !dbg !313
  %1026 = call i32 @sqlite3VdbeSerialGet(i8* %1025, i32 %1011, %struct.sqlite3_value* %105), !dbg !314
  %1027 = load i16, i16* %436, align 2, !dbg !315
  %1028 = and i16 %1027, -4097, !dbg !316
  store i16 %1028, i16* %436, align 2, !dbg !317
  br label %1129, !dbg !318

1029:                                             ; preds = %1009
  %1030 = call i32 @sqlite3VdbeSerialGet(i8* %1, i32 %1011, %struct.sqlite3_value* %105), !dbg !319
  br label %1129, !dbg !320

1031:                                             ; preds = %950
  %1032 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %889, i32 0, i32 23, i32 6, !dbg !321
  %1033 = load i32, i32* %1032, align 4, !dbg !322
  store i32 %1033, i32* %887, align 4, !dbg !323
  br label %953, !dbg !324

1034:                                             ; preds = %950
  %1035 = load i32, i32* %900, align 4, !dbg !325
  %1036 = load i32, i32* %893, align 4, !dbg !326
  %1037 = icmp ult i32 %1035, %1036, !dbg !327
  br i1 %1037, label %1038, label %1119, !dbg !328

1038:                                             ; preds = %1034
  %1039 = load i8*, i8** %903, align 8, !dbg !329
  %1040 = icmp eq i8* %1039, null, !dbg !330
  br i1 %1040, label %1042, label %1041, !dbg !331

1041:                                             ; preds = %1038
  store i8* %1039, i8** %886, align 8, !dbg !332
  br label %1042, !dbg !333

1042:                                             ; preds = %1041, %1038, %924
  %1043 = alloca i32, align 4, !dbg !334
  %1044 = load i16, i16* %904, align 2, !dbg !335
  %1045 = zext i16 %1044 to i32, !dbg !336
  store i32 %1045, i32* %1043, align 4, !dbg !337
  %1046 = alloca i64, align 8, !dbg !338
  %1047 = getelementptr i32, i32* %893, i32 %1045, !dbg !339
  %1048 = load i32, i32* %1047, align 4, !dbg !340
  %1049 = zext i32 %1048 to i64, !dbg !341
  store i64 %1049, i64* %1046, align 4, !dbg !342
  %1050 = load i8*, i8** %886, align 8, !dbg !343
  %1051 = load i32, i32* %900, align 4, !dbg !344
  %1052 = alloca i8*, align 8, !dbg !345
  %1053 = getelementptr i8, i8* %1050, i32 %1051, !dbg !346
  store i8* %1053, i8** %1052, align 8, !dbg !347
  %1054 = load i32, i32* %893, align 4, !dbg !348
  %1055 = getelementptr i8, i8* %1050, i32 %1054, !dbg !349
  br label %1056, !dbg !350

1056:                                             ; preds = %1063, %1042
  %1057 = load i32, i32* %1043, align 4, !dbg !351
  %1058 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %889, i32 0, i32 23, i32 %1057, !dbg !352
  %1059 = load i8*, i8** %1052, align 8, !dbg !353
  %1060 = load i8, i8* %1059, align 1, !dbg !354
  %1061 = zext i8 %1060 to i32, !dbg !355
  store i32 %1061, i32* %887, align 4, !dbg !356
  store i32 %1061, i32* %1058, align 4, !dbg !357
  %1062 = icmp sgt i8 %1060, -1, !dbg !358
  br i1 %1062, label %1086, label %1077, !dbg !359

1063:                                             ; preds = %1077, %1086
  %1064 = load i32, i32* %1043, align 4, !dbg !360
  %1065 = add i32 %1064, 1, !dbg !361
  store i32 %1065, i32* %1043, align 4, !dbg !362
  %1066 = load i64, i64* %1046, align 4, !dbg !363
  %1067 = and i64 4294967295, %1066, !dbg !364
  %1068 = trunc i64 %1067 to i32, !dbg !365
  %1069 = getelementptr i32, i32* %893, i32 %1065, !dbg !366
  store i32 %1068, i32* %1069, align 4, !dbg !367
  %1070 = load i32, i32* %1043, align 4, !dbg !368
  %1071 = icmp sle i32 %1070, 6, !dbg !369
  %1072 = load i8*, i8** %1052, align 8, !dbg !370
  %1073 = ptrtoint i8* %1072 to i64, !dbg !371
  %1074 = ptrtoint i8* %1055 to i64, !dbg !372
  %1075 = icmp ult i64 %1073, %1074, !dbg !373
  %1076 = and i1 %1071, %1075, !dbg !374
  br i1 %1076, label %1056, label %1095, !dbg !375

1077:                                             ; preds = %1056
  %1078 = load i8*, i8** %1052, align 8, !dbg !376
  %1079 = call i8 @sqlite3GetVarint32(i8* %1078, i32* %887), !dbg !377
  %1080 = getelementptr i8, i8* %1078, i8 %1079, !dbg !378
  store i8* %1080, i8** %1052, align 8, !dbg !379
  %1081 = load i32, i32* %887, align 4, !dbg !380
  store i32 %1081, i32* %1058, align 4, !dbg !381
  %1082 = load i64, i64* %1046, align 4, !dbg !382
  %1083 = call i32 @sqlite3VdbeSerialTypeLen(i32 %1081), !dbg !383
  %1084 = zext i32 %1083 to i64, !dbg !384
  %1085 = add i64 %1082, %1084, !dbg !385
  store i64 %1085, i64* %1046, align 4, !dbg !386
  br label %1063, !dbg !387

1086:                                             ; preds = %1056
  %1087 = getelementptr i8, i8* %1059, i32 1, !dbg !388
  store i8* %1087, i8** %1052, align 8, !dbg !389
  %1088 = load i32, i32* %887, align 4, !dbg !390
  %1089 = trunc i32 %1088 to i8, !dbg !391
  %1090 = getelementptr i8, i8* %4, i8 %1089, !dbg !392
  %1091 = load i8, i8* %1090, align 1, !dbg !393
  %1092 = zext i8 %1091 to i64, !dbg !394
  %1093 = load i64, i64* %1046, align 4, !dbg !395
  %1094 = add i64 %1093, %1092, !dbg !396
  store i64 %1094, i64* %1046, align 4, !dbg !397
  br label %1063, !dbg !398

1095:                                             ; preds = %1063
  %1096 = load i64, i64* %1046, align 4, !dbg !399
  %1097 = load i32, i32* %901, align 4, !dbg !400
  %1098 = zext i32 %1097 to i64, !dbg !401
  %1099 = icmp uge i64 %1073, %1074, !dbg !402
  %1100 = icmp ugt i64 %1073, %1074, !dbg !403
  %1101 = icmp ne i64 %1096, %1098, !dbg !404
  %1102 = icmp ugt i64 %1096, %1098, !dbg !405
  %1103 = or i1 %1100, %1101, !dbg !406
  %1104 = and i1 %1099, %1103, !dbg !407
  %1105 = or i1 %1104, %1102, !dbg !408
  br i1 %1105, label %1106, label %1110, !dbg !409

1106:                                             ; preds = %1095
  %1107 = load i32, i32* %893, align 4, !dbg !410
  %1108 = icmp eq i32 %1107, 0, !dbg !411
  br i1 %1108, label %1109, label %1110, !dbg !412

1109:                                             ; preds = %1106
  store i32 0, i32* %1043, align 4, !dbg !413
  store i8* %1055, i8** %1052, align 8, !dbg !414
  br label %1110, !dbg !415

1110:                                             ; preds = %1109, %1106, %1095
  %1111 = load i32, i32* %1043, align 4, !dbg !416
  %1112 = trunc i32 %1111 to i16, !dbg !417
  store i16 %1112, i16* %904, align 2, !dbg !418
  %1113 = load i8*, i8** %1052, align 8, !dbg !419
  %1114 = ptrtoint i8* %1113 to i64, !dbg !420
  %1115 = load i8*, i8** %886, align 8, !dbg !421
  %1116 = ptrtoint i8* %1115 to i64, !dbg !422
  %1117 = sub i64 %1114, %1116, !dbg !423
  %1118 = trunc i64 %1117 to i32, !dbg !424
  store i32 %1118, i32* %900, align 4, !dbg !425
  br label %1120, !dbg !426

1119:                                             ; preds = %1034
  store i32 0, i32* %887, align 4, !dbg !427
  br label %1120, !dbg !428

1120:                                             ; preds = %1110, %1119
  %1121 = load i16, i16* %904, align 2, !dbg !429
  %1122 = icmp sle i16 %1121, 6, !dbg !430
  br i1 %1122, label %1123, label %953, !dbg !431

1123:                                             ; preds = %1120
  %1124 = load i16, i16* %436, align 2, !dbg !432
  %1125 = and i16 %1124, 9216, !dbg !432
  %1126 = icmp ne i16 %1125, 0, !dbg !432
  br i1 %1126, label %1127, label %1128, !dbg !432

1127:                                             ; preds = %1123
  call void @vdbeMemClearExternAndSetNull(%struct.sqlite3_value* %105), !dbg !432
  br label %1129, !dbg !432

1128:                                             ; preds = %1123
  store i16 1, i16* %436, align 2, !dbg !432
  br label %1129, !dbg !432

1129:                                             ; preds = %1127, %1128, %999, %979, %1018, %1029, %948, %949
  call void @llvm.stackrestore(i8* %881), !dbg !433
  %1130 = load i16, i16* %436, align 2, !dbg !582
  %1131 = and i16 %1130, 36, !dbg !585
  %1132 = icmp ne i16 %1131, 0, !dbg !586
  br i1 %1132, label %1133, label %1134, !dbg !587

1133:                                             ; preds = %1129
  call void @sqlite3VdbeMemRealify(%struct.sqlite3_value* %105), !dbg !588
  br label %1134, !dbg !589

1134:                                             ; preds = %1133, %1129
  %1135 = call i8* @llvm.stacksave(), !dbg !519
  %1136 = alloca i32, align 8, !dbg !522
  %1137 = alloca i32, align 8, !dbg !523
  %1138 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %7, i32 11, !dbg !524
  %1139 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %1138, i32 0, i32 1, !dbg !525
  %1140 = load i16, i16* %1139, align 2, !dbg !526
  %1141 = alloca i16, align 8, !dbg !527
  store i16 %1140, i16* %1141, align 2, !dbg !528
  %1142 = load i16, i16* %436, align 2, !dbg !530
  %1143 = alloca i16, align 8, !dbg !531
  store i16 %1142, i16* %1143, align 2, !dbg !532
  %1144 = or i16 %1140, %1142, !dbg !533
  %1145 = and i16 %1144, 1, !dbg !534
  %1146 = icmp ne i16 %1145, 0, !dbg !535
  br i1 %1146, label %1147, label %1148, !dbg !536

1147:                                             ; preds = %1134
  call void @llvm.stackrestore(i8* %1135), !dbg !537
  br label %2380, !dbg !538

1148:                                             ; preds = %1134
  %1149 = and i16 %1144, 2, !dbg !590
  %1150 = icmp ne i16 %1149, 0, !dbg !591
  br i1 %1150, label %1151, label %1208, !dbg !592

1151:                                             ; preds = %1148
  %1152 = and i16 %1140, 46, !dbg !593
  %1153 = icmp eq i16 %1152, 2, !dbg !594
  br i1 %1153, label %1154, label %1180, !dbg !595

1154:                                             ; preds = %1151
  %1155 = call i8* @llvm.stacksave(), !dbg !596
  %1156 = alloca double, align 8, !dbg !597
  %1157 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %1138, i32 0, i32 0, i32 0, !dbg !596
  %1158 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %1138, i32 0, i32 2, !dbg !596
  %1159 = load i8, i8* %1158, align 1, !dbg !596
  %1160 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %1138, i32 0, i32 5, !dbg !596
  %1161 = load i8*, i8** %1160, align 8, !dbg !596
  %1162 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %1138, i32 0, i32 4, !dbg !596
  %1163 = load i32, i32* %1162, align 4, !dbg !596
  %1164 = call i32 @sqlite3AtoF(i8* %1161, double* %1156, i32 %1163, i8 %1159), !dbg !596
  %1165 = icmp sle i32 %1164, 0, !dbg !596
  br i1 %1165, label %1178, label %1166, !dbg !596

1166:                                             ; preds = %1154
  %1167 = icmp eq i32 %1164, 1, !dbg !596
  %1168 = load double, double* %1156, align 8, !dbg !596
  br i1 %1167, label %1169, label %1172, !dbg !596

1169:                                             ; preds = %1166
  %1170 = load i16, i16* %1139, align 2, !dbg !596
  %1171 = or i16 %1170, 4, !dbg !596
  store i16 %1171, i16* %1139, align 2, !dbg !596
  br label %1175, !dbg !596

1172:                                             ; preds = %1166
  store double %1168, double* %1157, align 8, !dbg !596
  %1173 = load i16, i16* %1139, align 2, !dbg !596
  %1174 = or i16 %1173, 8, !dbg !596
  store i16 %1174, i16* %1139, align 2, !dbg !596
  br label %1175, !dbg !596

1175:                                             ; preds = %1172, %1169
  %1176 = load i16, i16* %1139, align 2, !dbg !596
  %1177 = and i16 %1176, -3, !dbg !596
  store i16 %1177, i16* %1139, align 2, !dbg !596
  br label %1178, !dbg !596

1178:                                             ; preds = %1175, %1154
  call void @llvm.stackrestore(i8* %1155), !dbg !596
  %1179 = load i16, i16* %436, align 2, !dbg !600
  store i16 %1179, i16* %1143, align 2, !dbg !601
  br label %1180, !dbg !602

1180:                                             ; preds = %1178, %1151
  %1181 = and i16 %1142, 46, !dbg !603
  %1182 = icmp eq i16 %1181, 2, !dbg !604
  br i1 %1182, label %1183, label %1208, !dbg !605

1183:                                             ; preds = %1180
  %1184 = call i8* @llvm.stacksave(), !dbg !606
  %1185 = alloca double, align 8, !dbg !597
  %1186 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %105, i32 0, i32 0, i32 0, !dbg !606
  %1187 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %105, i32 0, i32 2, !dbg !606
  %1188 = load i8, i8* %1187, align 1, !dbg !606
  %1189 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %105, i32 0, i32 5, !dbg !606
  %1190 = load i8*, i8** %1189, align 8, !dbg !606
  %1191 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %105, i32 0, i32 4, !dbg !606
  %1192 = load i32, i32* %1191, align 4, !dbg !606
  %1193 = call i32 @sqlite3AtoF(i8* %1190, double* %1185, i32 %1192, i8 %1188), !dbg !606
  %1194 = icmp sle i32 %1193, 0, !dbg !606
  br i1 %1194, label %1207, label %1195, !dbg !606

1195:                                             ; preds = %1183
  %1196 = icmp eq i32 %1193, 1, !dbg !606
  %1197 = load double, double* %1185, align 8, !dbg !606
  br i1 %1196, label %1198, label %1201, !dbg !606

1198:                                             ; preds = %1195
  %1199 = load i16, i16* %436, align 2, !dbg !606
  %1200 = or i16 %1199, 4, !dbg !606
  store i16 %1200, i16* %436, align 2, !dbg !606
  br label %1204, !dbg !606

1201:                                             ; preds = %1195
  store double %1197, double* %1186, align 8, !dbg !606
  %1202 = load i16, i16* %436, align 2, !dbg !606
  %1203 = or i16 %1202, 8, !dbg !606
  store i16 %1203, i16* %436, align 2, !dbg !606
  br label %1204, !dbg !606

1204:                                             ; preds = %1201, %1198
  %1205 = load i16, i16* %436, align 2, !dbg !606
  %1206 = and i16 %1205, -3, !dbg !606
  store i16 %1206, i16* %436, align 2, !dbg !606
  br label %1207, !dbg !606

1207:                                             ; preds = %1204, %1183
  call void @llvm.stackrestore(i8* %1184), !dbg !606
  br label %1208, !dbg !607

1208:                                             ; preds = %1180, %1207, %1148
  %1209 = load i16, i16* %1139, align 2, !dbg !608
  %1210 = load i16, i16* %436, align 2, !dbg !609
  %1211 = and i16 %1209, %1210, !dbg !610
  %1212 = and i16 %1211, 4, !dbg !611
  %1213 = icmp ne i16 %1212, 0, !dbg !612
  br i1 %1213, label %1214, label %1227, !dbg !613

1214:                                             ; preds = %1208
  %1215 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %1138, i32 0, i32 0, !dbg !614
  %1216 = bitcast %union.MemValue* %1215 to i64*, !dbg !615
  %1217 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %105, i32 0, i32 0, !dbg !616
  %1218 = bitcast %union.MemValue* %1217 to i64*, !dbg !617
  %1219 = load i64, i64* %1216, align 4, !dbg !618
  %1220 = load i64, i64* %1218, align 4, !dbg !619
  %1221 = icmp sgt i64 %1220, %1219, !dbg !620
  br i1 %1221, label %1222, label %1223, !dbg !621

1222:                                             ; preds = %1214
  store i32 1, i32* %1136, align 4, !dbg !622
  br label %1233, !dbg !623

1223:                                             ; preds = %1214
  %1224 = icmp slt i64 %1220, %1219, !dbg !624
  br i1 %1224, label %1225, label %1226, !dbg !625

1225:                                             ; preds = %1223
  store i32 -1, i32* %1136, align 4, !dbg !626
  br label %1233, !dbg !627

1226:                                             ; preds = %1223
  store i32 0, i32* %1136, align 4, !dbg !628
  br label %1233, !dbg !629

1227:                                             ; preds = %1208
  %1228 = getelementptr %struct.VdbeOp, %struct.VdbeOp* %11, i32 17, !dbg !563
  %1229 = getelementptr %struct.VdbeOp, %struct.VdbeOp* %1228, i32 0, i32 6, !dbg !564
  %1230 = bitcast %union.p4union* %1229 to %struct.CollSeq**, !dbg !565
  %1231 = load %struct.CollSeq*, %struct.CollSeq** %1230, align 8, !dbg !566
  %1232 = call i32 @sqlite3MemCompare(%struct.sqlite3_value* %105, %struct.sqlite3_value* %1138, %struct.CollSeq* %1231), !dbg !567
  store i32 %1232, i32* %1136, align 4, !dbg !568
  br label %1233, !dbg !630

1233:                                             ; preds = %1225, %1226, %1227, %1222
  %1234 = load i32, i32* %1136, align 4, !dbg !631
  %1235 = icmp slt i32 %1234, 0, !dbg !569
  br i1 %1235, label %1236, label %1237, !dbg !570

1236:                                             ; preds = %1233
  store i32 1, i32* %1137, align 4, !dbg !571
  br label %1238, !dbg !572

1237:                                             ; preds = %1233
  store i32 0, i32* %1137, align 4, !dbg !573
  br label %1238, !dbg !573

1238:                                             ; preds = %1237, %1236
  store i16 %1142, i16* %1143, align 2, !dbg !574
  store i16 %1140, i16* %1141, align 2, !dbg !575
  %1239 = load i32, i32* %1137, align 4, !dbg !576
  %1240 = icmp ne i32 %1239, 0, !dbg !577
  call void @llvm.stackrestore(i8* %1135), !dbg !578
  br i1 %1240, label %2380, label %1241, !dbg !579

1241:                                             ; preds = %1238
  %1242 = call i8* @llvm.stacksave(), !dbg !519
  %1243 = alloca i32, align 8, !dbg !522
  %1244 = alloca i32, align 8, !dbg !523
  %1245 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %7, i32 12, !dbg !524
  %1246 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %1245, i32 0, i32 1, !dbg !525
  %1247 = load i16, i16* %1246, align 2, !dbg !526
  %1248 = alloca i16, align 8, !dbg !527
  store i16 %1247, i16* %1248, align 2, !dbg !528
  %1249 = load i16, i16* %436, align 2, !dbg !530
  %1250 = alloca i16, align 8, !dbg !531
  store i16 %1249, i16* %1250, align 2, !dbg !532
  %1251 = or i16 %1247, %1249, !dbg !533
  %1252 = and i16 %1251, 1, !dbg !534
  %1253 = icmp ne i16 %1252, 0, !dbg !535
  br i1 %1253, label %1254, label %1255, !dbg !536

1254:                                             ; preds = %1241
  call void @llvm.stackrestore(i8* %1242), !dbg !537
  br label %2380, !dbg !538

1255:                                             ; preds = %1241
  %1256 = and i16 %1251, 2, !dbg !590
  %1257 = icmp ne i16 %1256, 0, !dbg !591
  br i1 %1257, label %1258, label %1315, !dbg !592

1258:                                             ; preds = %1255
  %1259 = and i16 %1247, 46, !dbg !593
  %1260 = icmp eq i16 %1259, 2, !dbg !594
  br i1 %1260, label %1261, label %1287, !dbg !595

1261:                                             ; preds = %1258
  %1262 = call i8* @llvm.stacksave(), !dbg !596
  %1263 = alloca double, align 8, !dbg !597
  %1264 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %1245, i32 0, i32 0, i32 0, !dbg !596
  %1265 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %1245, i32 0, i32 2, !dbg !596
  %1266 = load i8, i8* %1265, align 1, !dbg !596
  %1267 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %1245, i32 0, i32 5, !dbg !596
  %1268 = load i8*, i8** %1267, align 8, !dbg !596
  %1269 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %1245, i32 0, i32 4, !dbg !596
  %1270 = load i32, i32* %1269, align 4, !dbg !596
  %1271 = call i32 @sqlite3AtoF(i8* %1268, double* %1263, i32 %1270, i8 %1266), !dbg !596
  %1272 = icmp sle i32 %1271, 0, !dbg !596
  br i1 %1272, label %1285, label %1273, !dbg !596

1273:                                             ; preds = %1261
  %1274 = icmp eq i32 %1271, 1, !dbg !596
  %1275 = load double, double* %1263, align 8, !dbg !596
  br i1 %1274, label %1276, label %1279, !dbg !596

1276:                                             ; preds = %1273
  %1277 = load i16, i16* %1246, align 2, !dbg !596
  %1278 = or i16 %1277, 4, !dbg !596
  store i16 %1278, i16* %1246, align 2, !dbg !596
  br label %1282, !dbg !596

1279:                                             ; preds = %1273
  store double %1275, double* %1264, align 8, !dbg !596
  %1280 = load i16, i16* %1246, align 2, !dbg !596
  %1281 = or i16 %1280, 8, !dbg !596
  store i16 %1281, i16* %1246, align 2, !dbg !596
  br label %1282, !dbg !596

1282:                                             ; preds = %1279, %1276
  %1283 = load i16, i16* %1246, align 2, !dbg !596
  %1284 = and i16 %1283, -3, !dbg !596
  store i16 %1284, i16* %1246, align 2, !dbg !596
  br label %1285, !dbg !596

1285:                                             ; preds = %1282, %1261
  call void @llvm.stackrestore(i8* %1262), !dbg !596
  %1286 = load i16, i16* %436, align 2, !dbg !600
  store i16 %1286, i16* %1250, align 2, !dbg !601
  br label %1287, !dbg !602

1287:                                             ; preds = %1285, %1258
  %1288 = and i16 %1249, 46, !dbg !603
  %1289 = icmp eq i16 %1288, 2, !dbg !604
  br i1 %1289, label %1290, label %1315, !dbg !605

1290:                                             ; preds = %1287
  %1291 = call i8* @llvm.stacksave(), !dbg !606
  %1292 = alloca double, align 8, !dbg !597
  %1293 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %105, i32 0, i32 0, i32 0, !dbg !606
  %1294 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %105, i32 0, i32 2, !dbg !606
  %1295 = load i8, i8* %1294, align 1, !dbg !606
  %1296 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %105, i32 0, i32 5, !dbg !606
  %1297 = load i8*, i8** %1296, align 8, !dbg !606
  %1298 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %105, i32 0, i32 4, !dbg !606
  %1299 = load i32, i32* %1298, align 4, !dbg !606
  %1300 = call i32 @sqlite3AtoF(i8* %1297, double* %1292, i32 %1299, i8 %1295), !dbg !606
  %1301 = icmp sle i32 %1300, 0, !dbg !606
  br i1 %1301, label %1314, label %1302, !dbg !606

1302:                                             ; preds = %1290
  %1303 = icmp eq i32 %1300, 1, !dbg !606
  %1304 = load double, double* %1292, align 8, !dbg !606
  br i1 %1303, label %1305, label %1308, !dbg !606

1305:                                             ; preds = %1302
  %1306 = load i16, i16* %436, align 2, !dbg !606
  %1307 = or i16 %1306, 4, !dbg !606
  store i16 %1307, i16* %436, align 2, !dbg !606
  br label %1311, !dbg !606

1308:                                             ; preds = %1302
  store double %1304, double* %1293, align 8, !dbg !606
  %1309 = load i16, i16* %436, align 2, !dbg !606
  %1310 = or i16 %1309, 8, !dbg !606
  store i16 %1310, i16* %436, align 2, !dbg !606
  br label %1311, !dbg !606

1311:                                             ; preds = %1308, %1305
  %1312 = load i16, i16* %436, align 2, !dbg !606
  %1313 = and i16 %1312, -3, !dbg !606
  store i16 %1313, i16* %436, align 2, !dbg !606
  br label %1314, !dbg !606

1314:                                             ; preds = %1311, %1290
  call void @llvm.stackrestore(i8* %1291), !dbg !606
  br label %1315, !dbg !607

1315:                                             ; preds = %1287, %1314, %1255
  %1316 = load i16, i16* %1246, align 2, !dbg !608
  %1317 = load i16, i16* %436, align 2, !dbg !609
  %1318 = and i16 %1316, %1317, !dbg !610
  %1319 = and i16 %1318, 4, !dbg !611
  %1320 = icmp ne i16 %1319, 0, !dbg !612
  br i1 %1320, label %1321, label %1334, !dbg !613

1321:                                             ; preds = %1315
  %1322 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %1245, i32 0, i32 0, !dbg !614
  %1323 = bitcast %union.MemValue* %1322 to i64*, !dbg !615
  %1324 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %105, i32 0, i32 0, !dbg !616
  %1325 = bitcast %union.MemValue* %1324 to i64*, !dbg !617
  %1326 = load i64, i64* %1323, align 4, !dbg !618
  %1327 = load i64, i64* %1325, align 4, !dbg !619
  %1328 = icmp sgt i64 %1327, %1326, !dbg !620
  br i1 %1328, label %1329, label %1330, !dbg !621

1329:                                             ; preds = %1321
  store i32 1, i32* %1243, align 4, !dbg !622
  br label %1340, !dbg !623

1330:                                             ; preds = %1321
  %1331 = icmp slt i64 %1327, %1326, !dbg !624
  br i1 %1331, label %1332, label %1333, !dbg !625

1332:                                             ; preds = %1330
  store i32 -1, i32* %1243, align 4, !dbg !626
  br label %1340, !dbg !627

1333:                                             ; preds = %1330
  store i32 0, i32* %1243, align 4, !dbg !628
  br label %1340, !dbg !629

1334:                                             ; preds = %1315
  %1335 = getelementptr %struct.VdbeOp, %struct.VdbeOp* %11, i32 18, !dbg !563
  %1336 = getelementptr %struct.VdbeOp, %struct.VdbeOp* %1335, i32 0, i32 6, !dbg !564
  %1337 = bitcast %union.p4union* %1336 to %struct.CollSeq**, !dbg !565
  %1338 = load %struct.CollSeq*, %struct.CollSeq** %1337, align 8, !dbg !566
  %1339 = call i32 @sqlite3MemCompare(%struct.sqlite3_value* %105, %struct.sqlite3_value* %1245, %struct.CollSeq* %1338), !dbg !567
  store i32 %1339, i32* %1243, align 4, !dbg !568
  br label %1340, !dbg !630

1340:                                             ; preds = %1332, %1333, %1334, %1329
  %1341 = load i32, i32* %1243, align 4, !dbg !631
  %1342 = icmp slt i32 %1341, 0, !dbg !569
  br i1 %1342, label %1343, label %1344, !dbg !570

1343:                                             ; preds = %1340
  store i32 0, i32* %1244, align 4, !dbg !571
  br label %1348, !dbg !572

1344:                                             ; preds = %1340
  %1345 = icmp eq i32 %1341, 0, !dbg !632
  br i1 %1345, label %1346, label %1347, !dbg !633

1346:                                             ; preds = %1344
  store i32 0, i32* %1244, align 4, !dbg !634
  br label %1348, !dbg !635

1347:                                             ; preds = %1344
  store i32 1, i32* %1244, align 4, !dbg !636
  br label %1348, !dbg !637

1348:                                             ; preds = %1347, %1346, %1343
  store i16 %1249, i16* %1250, align 2, !dbg !574
  store i16 %1247, i16* %1248, align 2, !dbg !575
  %1349 = load i32, i32* %1244, align 4, !dbg !576
  %1350 = icmp ne i32 %1349, 0, !dbg !577
  call void @llvm.stackrestore(i8* %1242), !dbg !578
  br i1 %1350, label %2380, label %1351, !dbg !579

1351:                                             ; preds = %1348
  %1352 = call i8* @llvm.stacksave(), !dbg !142
  %1353 = load i8, i8* %96, align 1, !dbg !146
  %1354 = alloca i32, align 4, !dbg !147
  store i32 0, i32* %1354, align 4, !dbg !148
  %1355 = alloca %struct.VdbeCursor*, align 8, !dbg !149
  %1356 = load %struct.VdbeCursor*, %struct.VdbeCursor** %9, align 8, !dbg !150
  store %struct.VdbeCursor* %1356, %struct.VdbeCursor** %1355, align 8, !dbg !151
  %1357 = alloca i8*, align 8, !dbg !152
  %1358 = alloca i32, align 4, !dbg !153
  %1359 = call i32 @sqlite3VdbeCursorMoveto(%struct.VdbeCursor** %1355, i32* %1354), !dbg !154
  %1360 = load %struct.VdbeCursor*, %struct.VdbeCursor** %1355, align 8, !dbg !155
  %1361 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %1360, i32 0, i32 16, !dbg !157
  %1362 = load i16, i16* %1361, align 2, !dbg !158
  %1363 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %1360, i32 0, i32 19, !dbg !159
  %1364 = load i32*, i32** %1363, align 8, !dbg !160
  %1365 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %1360, i32 0, i32 0, !dbg !161
  %1366 = load i8, i8* %1365, align 1, !dbg !162
  %1367 = icmp ne i8 %1366, 3, !dbg !163
  %1368 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %1360, i32 0, i32 2, !dbg !164
  %1369 = load i8, i8* %1368, align 1, !dbg !165
  %1370 = icmp ne i8 %1369, 0, !dbg !166
  %1371 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %1360, i32 0, i32 14, !dbg !167
  %1372 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %1360, i32 0, i32 21, !dbg !168
  %1373 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %1360, i32 0, i32 22, !dbg !169
  %1374 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %1360, i32 0, i32 20, !dbg !170
  %1375 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %1360, i32 0, i32 17, !dbg !171
  %1376 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %1360, i32 0, i32 9, !dbg !172
  %1377 = load i32, i32* %1376, align 4, !dbg !173
  %1378 = load i32, i32* %123, align 4, !dbg !175
  %1379 = icmp ne i32 %1377, %1378, !dbg !176
  br i1 %1379, label %1380, label %1421, !dbg !177

1380:                                             ; preds = %1351
  br i1 %1370, label %1402, label %1397, !dbg !178

1381:                                             ; preds = %1397, %1404
  %1382 = load i32, i32* %123, align 4, !dbg !179
  store i32 %1382, i32* %1376, align 4, !dbg !180
  %1383 = load i8*, i8** %1374, align 8, !dbg !181
  %1384 = load i8, i8* %1383, align 1, !dbg !182
  %1385 = icmp sgt i8 %1384, -1, !dbg !185
  br i1 %1385, label %1386, label %1388, !dbg !186

1386:                                             ; preds = %1381
  %1387 = zext i8 %1384 to i32, !dbg !187
  store i32 %1387, i32* %1364, align 4, !dbg !188
  store i32 1, i32* %1371, align 4, !dbg !189
  br label %1391, !dbg !190

1388:                                             ; preds = %1381
  %1389 = call i8 @sqlite3GetVarint32(i8* %1383, i32* %1364), !dbg !191
  %1390 = zext i8 %1389 to i32, !dbg !192
  store i32 %1390, i32* %1371, align 4, !dbg !193
  br label %1391, !dbg !194

1391:                                             ; preds = %1388, %1386
  store i16 0, i16* %1375, align 2, !dbg !195
  %1392 = load i32, i32* %1373, align 4, !dbg !196
  %1393 = load i32, i32* %1364, align 4, !dbg !197
  %1394 = icmp ult i32 %1392, %1393, !dbg !198
  br i1 %1394, label %1396, label %1395, !dbg !199

1395:                                             ; preds = %1391
  store i8* %1383, i8** %1357, align 8, !dbg !200
  br label %1513, !dbg !201

1396:                                             ; preds = %1391
  store i8* null, i8** %1374, align 8, !dbg !202
  store i32 0, i32* %1373, align 4, !dbg !203
  br label %1421, !dbg !204

1397:                                             ; preds = %1380
  %1398 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %1360, i32 0, i32 12, i32 0, !dbg !205
  %1399 = load %struct.BtCursor*, %struct.BtCursor** %1398, align 8, !dbg !206
  %1400 = call i32 @sqlite3BtreePayloadSize(%struct.BtCursor* %1399), !dbg !207
  store i32 %1400, i32* %1372, align 4, !dbg !208
  %1401 = call i8* @sqlite3BtreePayloadFetch(%struct.BtCursor* %1399, i32* %1373), !dbg !209
  store i8* %1401, i8** %1374, align 8, !dbg !210
  br label %1381, !dbg !211

1402:                                             ; preds = %1380
  %1403 = icmp eq i8 %1366, 3, !dbg !212
  br i1 %1403, label %1404, label %1415, !dbg !213

1404:                                             ; preds = %1402
  %1405 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %1360, i32 0, i32 10, !dbg !214
  %1406 = load i32, i32* %1405, align 4, !dbg !215
  %1407 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %7, i32 %1406, !dbg !216
  %1408 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %1407, i32 0, i32 1, !dbg !217
  %1409 = load i16, i16* %1408, align 2, !dbg !218
  %1410 = and i16 %1409, 16, !dbg !219
  %1411 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %1407, i32 0, i32 4, !dbg !220
  %1412 = load i32, i32* %1411, align 4, !dbg !221
  store i32 %1412, i32* %1372, align 4, !dbg !222
  store i32 %1412, i32* %1373, align 4, !dbg !223
  %1413 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %1407, i32 0, i32 5, !dbg !224
  %1414 = load i8*, i8** %1413, align 8, !dbg !225
  store i8* %1414, i8** %1374, align 8, !dbg !226
  br label %1381, !dbg !227

1415:                                             ; preds = %1402
  %1416 = load i16, i16* %436, align 2, !dbg !228
  %1417 = and i16 %1416, 9216, !dbg !228
  %1418 = icmp ne i16 %1417, 0, !dbg !228
  br i1 %1418, label %1419, label %1420, !dbg !228

1419:                                             ; preds = %1415
  call void @vdbeMemClearExternAndSetNull(%struct.sqlite3_value* %105), !dbg !228
  br label %1600, !dbg !228

1420:                                             ; preds = %1415
  store i16 1, i16* %436, align 2, !dbg !228
  br label %1600, !dbg !228

1421:                                             ; preds = %1396, %1351
  %1422 = load i16, i16* %1375, align 2, !dbg !229
  %1423 = icmp ule i16 %1422, 4, !dbg !230
  br i1 %1423, label %1505, label %1502, !dbg !231

1424:                                             ; preds = %1502, %1591
  %1425 = load i16, i16* %436, align 2, !dbg !233
  %1426 = and i16 9216, %1425, !dbg !234
  %1427 = icmp eq i16 0, %1426, !dbg !235
  br i1 %1427, label %1428, label %1432, !dbg !236

1428:                                             ; preds = %1424
  %1429 = icmp ne i16 %1426, 0, !dbg !237
  br i1 %1429, label %1430, label %1431, !dbg !237

1430:                                             ; preds = %1428
  call void @vdbeMemClearExternAndSetNull(%struct.sqlite3_value* %105), !dbg !237
  br label %1432, !dbg !237

1431:                                             ; preds = %1428
  store i16 1, i16* %436, align 2, !dbg !237
  br label %1432, !dbg !237

1432:                                             ; preds = %1430, %1431, %1424
  %1433 = load i32, i32* %1358, align 4, !dbg !238
  %1434 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %1360, i32 0, i32 23, i32 4, !dbg !239
  %1435 = load i32, i32* %1434, align 4, !dbg !240
  %1436 = load i32, i32* %1373, align 4, !dbg !241
  %1437 = getelementptr i32, i32* %1364, i32 5, !dbg !242
  %1438 = load i32, i32* %1437, align 4, !dbg !243
  %1439 = icmp sge i32 %1436, %1438, !dbg !244
  br i1 %1439, label %1440, label %1480, !dbg !245

1440:                                             ; preds = %1432
  %1441 = load i8*, i8** %1374, align 8, !dbg !246
  %1442 = ptrtoint i8* %1441 to i64, !dbg !247
  %1443 = getelementptr i32, i32* %1364, i32 4, !dbg !248
  %1444 = load i32, i32* %1443, align 4, !dbg !249
  %1445 = zext i32 %1444 to i64, !dbg !250
  %1446 = add i64 %1442, %1445, !dbg !251
  %1447 = inttoptr i64 %1446 to i8*, !dbg !252
  store i8* %1447, i8** %1357, align 8, !dbg !253
  %1448 = load i32, i32* %1358, align 4, !dbg !254
  %1449 = icmp ult i32 %1448, 12, !dbg !255
  br i1 %1449, label %1450, label %1452, !dbg !256

1450:                                             ; preds = %1440
  %1451 = call i32 @sqlite3VdbeSerialGet(i8* %1447, i32 %1448, %struct.sqlite3_value* %105), !dbg !257
  br label %1600, !dbg !258

1452:                                             ; preds = %1440
  %1453 = alloca i16, i32 2, align 2, !dbg !259
  store i16 16, i16* %1453, align 2, !dbg !260
  %1454 = getelementptr i16, i16* %1453, i32 1, !dbg !261
  store i16 514, i16* %1454, align 2, !dbg !262
  %1455 = load i32, i32* %1358, align 4, !dbg !263
  %1456 = sub i32 %1455, 12, !dbg !264
  %1457 = lshr i32 %1456, 1, !dbg !265
  %1458 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %105, i32 0, i32 4, !dbg !266
  store i32 %1457, i32* %1458, align 4, !dbg !267
  %1459 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %105, i32 0, i32 2, !dbg !268
  store i8 %1353, i8* %1459, align 1, !dbg !269
  %1460 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %105, i32 0, i32 5, !dbg !270
  %1461 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %105, i32 0, i32 7, !dbg !271
  %1462 = load i32, i32* %1461, align 4, !dbg !272
  %1463 = add i32 %1457, 2, !dbg !273
  %1464 = icmp slt i32 %1462, %1463, !dbg !274
  br i1 %1464, label %1465, label %1467, !dbg !275

1465:                                             ; preds = %1452
  store i16 1, i16* %436, align 2, !dbg !276
  %1466 = call i32 @sqlite3VdbeMemGrow(%struct.sqlite3_value* %105, i32 %1463, i32 0), !dbg !277
  br label %1470, !dbg !278

1467:                                             ; preds = %1452
  %1468 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %105, i32 0, i32 6, !dbg !279
  %1469 = load i8*, i8** %1468, align 8, !dbg !280
  store i8* %1469, i8** %1460, align 8, !dbg !281
  br label %1470, !dbg !282

1470:                                             ; preds = %1467, %1465
  %1471 = zext i32 %1457 to i64, !dbg !283
  %1472 = load i8*, i8** %1460, align 8, !dbg !284
  %1473 = load i8*, i8** %1357, align 8, !dbg !285
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %1472, i8* %1473, i64 %1471, i1 false), !dbg !286
  %1474 = getelementptr i8, i8* %1472, i32 %1457, !dbg !287
  store i8 0, i8* %1474, align 1, !dbg !288
  %1475 = add i32 %1457, 1, !dbg !289
  %1476 = getelementptr i8, i8* %1472, i32 %1475, !dbg !290
  store i8 0, i8* %1476, align 1, !dbg !291
  %1477 = and i32 %1455, 1, !dbg !292
  %1478 = getelementptr i16, i16* %1453, i32 %1477, !dbg !293
  %1479 = load i16, i16* %1478, align 2, !dbg !294
  store i16 %1479, i16* %436, align 2, !dbg !295
  br label %1600, !dbg !296

1480:                                             ; preds = %1432
  %1481 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %105, i32 0, i32 2, !dbg !297
  store i8 %1353, i8* %1481, align 1, !dbg !298
  %1482 = load i32, i32* %1358, align 4, !dbg !299
  %1483 = and i32 %1482, 1, !dbg !300
  %1484 = icmp eq i32 %1483, 0, !dbg !301
  %1485 = icmp sge i32 %1482, 12, !dbg !302
  %1486 = and i1 %1485, %1484, !dbg !303
  %1487 = call i32 @sqlite3VdbeSerialTypeLen(i32 %1482), !dbg !304
  %1488 = icmp eq i32 %1487, 0, !dbg !305
  br i1 %1488, label %1500, label %1489, !dbg !306

1489:                                             ; preds = %1480
  %1490 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %1360, i32 0, i32 12, i32 0, !dbg !307
  %1491 = load %struct.BtCursor*, %struct.BtCursor** %1490, align 8, !dbg !308
  %1492 = getelementptr i32, i32* %1364, i32 4, !dbg !309
  %1493 = load i32, i32* %1492, align 4, !dbg !310
  %1494 = call i32 @sqlite3VdbeMemFromBtree(%struct.BtCursor* %1491, i32 %1493, i32 %1487, %struct.sqlite3_value* %105), !dbg !311
  %1495 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %105, i32 0, i32 5, !dbg !312
  %1496 = load i8*, i8** %1495, align 8, !dbg !313
  %1497 = call i32 @sqlite3VdbeSerialGet(i8* %1496, i32 %1482, %struct.sqlite3_value* %105), !dbg !314
  %1498 = load i16, i16* %436, align 2, !dbg !315
  %1499 = and i16 %1498, -4097, !dbg !316
  store i16 %1499, i16* %436, align 2, !dbg !317
  br label %1600, !dbg !318

1500:                                             ; preds = %1480
  %1501 = call i32 @sqlite3VdbeSerialGet(i8* %1, i32 %1482, %struct.sqlite3_value* %105), !dbg !319
  br label %1600, !dbg !320

1502:                                             ; preds = %1421
  %1503 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %1360, i32 0, i32 23, i32 4, !dbg !321
  %1504 = load i32, i32* %1503, align 4, !dbg !322
  store i32 %1504, i32* %1358, align 4, !dbg !323
  br label %1424, !dbg !324

1505:                                             ; preds = %1421
  %1506 = load i32, i32* %1371, align 4, !dbg !325
  %1507 = load i32, i32* %1364, align 4, !dbg !326
  %1508 = icmp ult i32 %1506, %1507, !dbg !327
  br i1 %1508, label %1509, label %1590, !dbg !328

1509:                                             ; preds = %1505
  %1510 = load i8*, i8** %1374, align 8, !dbg !329
  %1511 = icmp eq i8* %1510, null, !dbg !330
  br i1 %1511, label %1513, label %1512, !dbg !331

1512:                                             ; preds = %1509
  store i8* %1510, i8** %1357, align 8, !dbg !332
  br label %1513, !dbg !333

1513:                                             ; preds = %1512, %1509, %1395
  %1514 = alloca i32, align 4, !dbg !334
  %1515 = load i16, i16* %1375, align 2, !dbg !335
  %1516 = zext i16 %1515 to i32, !dbg !336
  store i32 %1516, i32* %1514, align 4, !dbg !337
  %1517 = alloca i64, align 8, !dbg !338
  %1518 = getelementptr i32, i32* %1364, i32 %1516, !dbg !339
  %1519 = load i32, i32* %1518, align 4, !dbg !340
  %1520 = zext i32 %1519 to i64, !dbg !341
  store i64 %1520, i64* %1517, align 4, !dbg !342
  %1521 = load i8*, i8** %1357, align 8, !dbg !343
  %1522 = load i32, i32* %1371, align 4, !dbg !344
  %1523 = alloca i8*, align 8, !dbg !345
  %1524 = getelementptr i8, i8* %1521, i32 %1522, !dbg !346
  store i8* %1524, i8** %1523, align 8, !dbg !347
  %1525 = load i32, i32* %1364, align 4, !dbg !348
  %1526 = getelementptr i8, i8* %1521, i32 %1525, !dbg !349
  br label %1527, !dbg !350

1527:                                             ; preds = %1534, %1513
  %1528 = load i32, i32* %1514, align 4, !dbg !351
  %1529 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %1360, i32 0, i32 23, i32 %1528, !dbg !352
  %1530 = load i8*, i8** %1523, align 8, !dbg !353
  %1531 = load i8, i8* %1530, align 1, !dbg !354
  %1532 = zext i8 %1531 to i32, !dbg !355
  store i32 %1532, i32* %1358, align 4, !dbg !356
  store i32 %1532, i32* %1529, align 4, !dbg !357
  %1533 = icmp sgt i8 %1531, -1, !dbg !358
  br i1 %1533, label %1557, label %1548, !dbg !359

1534:                                             ; preds = %1548, %1557
  %1535 = load i32, i32* %1514, align 4, !dbg !360
  %1536 = add i32 %1535, 1, !dbg !361
  store i32 %1536, i32* %1514, align 4, !dbg !362
  %1537 = load i64, i64* %1517, align 4, !dbg !363
  %1538 = and i64 4294967295, %1537, !dbg !364
  %1539 = trunc i64 %1538 to i32, !dbg !365
  %1540 = getelementptr i32, i32* %1364, i32 %1536, !dbg !366
  store i32 %1539, i32* %1540, align 4, !dbg !367
  %1541 = load i32, i32* %1514, align 4, !dbg !368
  %1542 = icmp sle i32 %1541, 4, !dbg !369
  %1543 = load i8*, i8** %1523, align 8, !dbg !370
  %1544 = ptrtoint i8* %1543 to i64, !dbg !371
  %1545 = ptrtoint i8* %1526 to i64, !dbg !372
  %1546 = icmp ult i64 %1544, %1545, !dbg !373
  %1547 = and i1 %1542, %1546, !dbg !374
  br i1 %1547, label %1527, label %1566, !dbg !375

1548:                                             ; preds = %1527
  %1549 = load i8*, i8** %1523, align 8, !dbg !376
  %1550 = call i8 @sqlite3GetVarint32(i8* %1549, i32* %1358), !dbg !377
  %1551 = getelementptr i8, i8* %1549, i8 %1550, !dbg !378
  store i8* %1551, i8** %1523, align 8, !dbg !379
  %1552 = load i32, i32* %1358, align 4, !dbg !380
  store i32 %1552, i32* %1529, align 4, !dbg !381
  %1553 = load i64, i64* %1517, align 4, !dbg !382
  %1554 = call i32 @sqlite3VdbeSerialTypeLen(i32 %1552), !dbg !383
  %1555 = zext i32 %1554 to i64, !dbg !384
  %1556 = add i64 %1553, %1555, !dbg !385
  store i64 %1556, i64* %1517, align 4, !dbg !386
  br label %1534, !dbg !387

1557:                                             ; preds = %1527
  %1558 = getelementptr i8, i8* %1530, i32 1, !dbg !388
  store i8* %1558, i8** %1523, align 8, !dbg !389
  %1559 = load i32, i32* %1358, align 4, !dbg !390
  %1560 = trunc i32 %1559 to i8, !dbg !391
  %1561 = getelementptr i8, i8* %4, i8 %1560, !dbg !392
  %1562 = load i8, i8* %1561, align 1, !dbg !393
  %1563 = zext i8 %1562 to i64, !dbg !394
  %1564 = load i64, i64* %1517, align 4, !dbg !395
  %1565 = add i64 %1564, %1563, !dbg !396
  store i64 %1565, i64* %1517, align 4, !dbg !397
  br label %1534, !dbg !398

1566:                                             ; preds = %1534
  %1567 = load i64, i64* %1517, align 4, !dbg !399
  %1568 = load i32, i32* %1372, align 4, !dbg !400
  %1569 = zext i32 %1568 to i64, !dbg !401
  %1570 = icmp uge i64 %1544, %1545, !dbg !402
  %1571 = icmp ugt i64 %1544, %1545, !dbg !403
  %1572 = icmp ne i64 %1567, %1569, !dbg !404
  %1573 = icmp ugt i64 %1567, %1569, !dbg !405
  %1574 = or i1 %1571, %1572, !dbg !406
  %1575 = and i1 %1570, %1574, !dbg !407
  %1576 = or i1 %1575, %1573, !dbg !408
  br i1 %1576, label %1577, label %1581, !dbg !409

1577:                                             ; preds = %1566
  %1578 = load i32, i32* %1364, align 4, !dbg !410
  %1579 = icmp eq i32 %1578, 0, !dbg !411
  br i1 %1579, label %1580, label %1581, !dbg !412

1580:                                             ; preds = %1577
  store i32 0, i32* %1514, align 4, !dbg !413
  store i8* %1526, i8** %1523, align 8, !dbg !414
  br label %1581, !dbg !415

1581:                                             ; preds = %1580, %1577, %1566
  %1582 = load i32, i32* %1514, align 4, !dbg !416
  %1583 = trunc i32 %1582 to i16, !dbg !417
  store i16 %1583, i16* %1375, align 2, !dbg !418
  %1584 = load i8*, i8** %1523, align 8, !dbg !419
  %1585 = ptrtoint i8* %1584 to i64, !dbg !420
  %1586 = load i8*, i8** %1357, align 8, !dbg !421
  %1587 = ptrtoint i8* %1586 to i64, !dbg !422
  %1588 = sub i64 %1585, %1587, !dbg !423
  %1589 = trunc i64 %1588 to i32, !dbg !424
  store i32 %1589, i32* %1371, align 4, !dbg !425
  br label %1591, !dbg !426

1590:                                             ; preds = %1505
  store i32 0, i32* %1358, align 4, !dbg !427
  br label %1591, !dbg !428

1591:                                             ; preds = %1581, %1590
  %1592 = load i16, i16* %1375, align 2, !dbg !429
  %1593 = icmp sle i16 %1592, 4, !dbg !430
  br i1 %1593, label %1594, label %1424, !dbg !431

1594:                                             ; preds = %1591
  %1595 = load i16, i16* %436, align 2, !dbg !432
  %1596 = and i16 %1595, 9216, !dbg !432
  %1597 = icmp ne i16 %1596, 0, !dbg !432
  br i1 %1597, label %1598, label %1599, !dbg !432

1598:                                             ; preds = %1594
  call void @vdbeMemClearExternAndSetNull(%struct.sqlite3_value* %105), !dbg !432
  br label %1600, !dbg !432

1599:                                             ; preds = %1594
  store i16 1, i16* %436, align 2, !dbg !432
  br label %1600, !dbg !432

1600:                                             ; preds = %1598, %1599, %1470, %1450, %1489, %1500, %1419, %1420
  call void @llvm.stackrestore(i8* %1352), !dbg !433
  %1601 = call i8* @llvm.stacksave(), !dbg !519
  %1602 = alloca i32, align 8, !dbg !522
  %1603 = alloca i32, align 8, !dbg !523
  %1604 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %7, i32 13, !dbg !524
  %1605 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %1604, i32 0, i32 1, !dbg !525
  %1606 = load i16, i16* %1605, align 2, !dbg !526
  %1607 = alloca i16, align 8, !dbg !527
  store i16 %1606, i16* %1607, align 2, !dbg !528
  %1608 = load i16, i16* %436, align 2, !dbg !530
  %1609 = alloca i16, align 8, !dbg !531
  store i16 %1608, i16* %1609, align 2, !dbg !532
  %1610 = or i16 %1606, %1608, !dbg !533
  %1611 = and i16 %1610, 1, !dbg !534
  %1612 = icmp ne i16 %1611, 0, !dbg !535
  br i1 %1612, label %1613, label %1614, !dbg !536

1613:                                             ; preds = %1600
  call void @llvm.stackrestore(i8* %1601), !dbg !537
  br label %2380, !dbg !538

1614:                                             ; preds = %1600
  %1615 = and i16 %1610, 2, !dbg !590
  %1616 = icmp ne i16 %1615, 0, !dbg !591
  br i1 %1616, label %1617, label %1674, !dbg !592

1617:                                             ; preds = %1614
  %1618 = and i16 %1606, 46, !dbg !593
  %1619 = icmp eq i16 %1618, 2, !dbg !594
  br i1 %1619, label %1620, label %1646, !dbg !595

1620:                                             ; preds = %1617
  %1621 = call i8* @llvm.stacksave(), !dbg !596
  %1622 = alloca double, align 8, !dbg !597
  %1623 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %1604, i32 0, i32 0, i32 0, !dbg !596
  %1624 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %1604, i32 0, i32 2, !dbg !596
  %1625 = load i8, i8* %1624, align 1, !dbg !596
  %1626 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %1604, i32 0, i32 5, !dbg !596
  %1627 = load i8*, i8** %1626, align 8, !dbg !596
  %1628 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %1604, i32 0, i32 4, !dbg !596
  %1629 = load i32, i32* %1628, align 4, !dbg !596
  %1630 = call i32 @sqlite3AtoF(i8* %1627, double* %1622, i32 %1629, i8 %1625), !dbg !596
  %1631 = icmp sle i32 %1630, 0, !dbg !596
  br i1 %1631, label %1644, label %1632, !dbg !596

1632:                                             ; preds = %1620
  %1633 = icmp eq i32 %1630, 1, !dbg !596
  %1634 = load double, double* %1622, align 8, !dbg !596
  br i1 %1633, label %1635, label %1638, !dbg !596

1635:                                             ; preds = %1632
  %1636 = load i16, i16* %1605, align 2, !dbg !596
  %1637 = or i16 %1636, 4, !dbg !596
  store i16 %1637, i16* %1605, align 2, !dbg !596
  br label %1641, !dbg !596

1638:                                             ; preds = %1632
  store double %1634, double* %1623, align 8, !dbg !596
  %1639 = load i16, i16* %1605, align 2, !dbg !596
  %1640 = or i16 %1639, 8, !dbg !596
  store i16 %1640, i16* %1605, align 2, !dbg !596
  br label %1641, !dbg !596

1641:                                             ; preds = %1638, %1635
  %1642 = load i16, i16* %1605, align 2, !dbg !596
  %1643 = and i16 %1642, -3, !dbg !596
  store i16 %1643, i16* %1605, align 2, !dbg !596
  br label %1644, !dbg !596

1644:                                             ; preds = %1641, %1620
  call void @llvm.stackrestore(i8* %1621), !dbg !596
  %1645 = load i16, i16* %436, align 2, !dbg !600
  store i16 %1645, i16* %1609, align 2, !dbg !601
  br label %1646, !dbg !602

1646:                                             ; preds = %1644, %1617
  %1647 = and i16 %1608, 46, !dbg !603
  %1648 = icmp eq i16 %1647, 2, !dbg !604
  br i1 %1648, label %1649, label %1674, !dbg !605

1649:                                             ; preds = %1646
  %1650 = call i8* @llvm.stacksave(), !dbg !606
  %1651 = alloca double, align 8, !dbg !597
  %1652 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %105, i32 0, i32 0, i32 0, !dbg !606
  %1653 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %105, i32 0, i32 2, !dbg !606
  %1654 = load i8, i8* %1653, align 1, !dbg !606
  %1655 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %105, i32 0, i32 5, !dbg !606
  %1656 = load i8*, i8** %1655, align 8, !dbg !606
  %1657 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %105, i32 0, i32 4, !dbg !606
  %1658 = load i32, i32* %1657, align 4, !dbg !606
  %1659 = call i32 @sqlite3AtoF(i8* %1656, double* %1651, i32 %1658, i8 %1654), !dbg !606
  %1660 = icmp sle i32 %1659, 0, !dbg !606
  br i1 %1660, label %1673, label %1661, !dbg !606

1661:                                             ; preds = %1649
  %1662 = icmp eq i32 %1659, 1, !dbg !606
  %1663 = load double, double* %1651, align 8, !dbg !606
  br i1 %1662, label %1664, label %1667, !dbg !606

1664:                                             ; preds = %1661
  %1665 = load i16, i16* %436, align 2, !dbg !606
  %1666 = or i16 %1665, 4, !dbg !606
  store i16 %1666, i16* %436, align 2, !dbg !606
  br label %1670, !dbg !606

1667:                                             ; preds = %1661
  store double %1663, double* %1652, align 8, !dbg !606
  %1668 = load i16, i16* %436, align 2, !dbg !606
  %1669 = or i16 %1668, 8, !dbg !606
  store i16 %1669, i16* %436, align 2, !dbg !606
  br label %1670, !dbg !606

1670:                                             ; preds = %1667, %1664
  %1671 = load i16, i16* %436, align 2, !dbg !606
  %1672 = and i16 %1671, -3, !dbg !606
  store i16 %1672, i16* %436, align 2, !dbg !606
  br label %1673, !dbg !606

1673:                                             ; preds = %1670, %1649
  call void @llvm.stackrestore(i8* %1650), !dbg !606
  br label %1674, !dbg !607

1674:                                             ; preds = %1646, %1673, %1614
  %1675 = load i16, i16* %1605, align 2, !dbg !608
  %1676 = load i16, i16* %436, align 2, !dbg !609
  %1677 = and i16 %1675, %1676, !dbg !610
  %1678 = and i16 %1677, 4, !dbg !611
  %1679 = icmp ne i16 %1678, 0, !dbg !612
  br i1 %1679, label %1680, label %1693, !dbg !613

1680:                                             ; preds = %1674
  %1681 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %1604, i32 0, i32 0, !dbg !614
  %1682 = bitcast %union.MemValue* %1681 to i64*, !dbg !615
  %1683 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %105, i32 0, i32 0, !dbg !616
  %1684 = bitcast %union.MemValue* %1683 to i64*, !dbg !617
  %1685 = load i64, i64* %1682, align 4, !dbg !618
  %1686 = load i64, i64* %1684, align 4, !dbg !619
  %1687 = icmp sgt i64 %1686, %1685, !dbg !620
  br i1 %1687, label %1688, label %1689, !dbg !621

1688:                                             ; preds = %1680
  store i32 1, i32* %1602, align 4, !dbg !622
  br label %1699, !dbg !623

1689:                                             ; preds = %1680
  %1690 = icmp slt i64 %1686, %1685, !dbg !624
  br i1 %1690, label %1691, label %1692, !dbg !625

1691:                                             ; preds = %1689
  store i32 -1, i32* %1602, align 4, !dbg !626
  br label %1699, !dbg !627

1692:                                             ; preds = %1689
  store i32 0, i32* %1602, align 4, !dbg !628
  br label %1699, !dbg !629

1693:                                             ; preds = %1674
  %1694 = getelementptr %struct.VdbeOp, %struct.VdbeOp* %11, i32 20, !dbg !563
  %1695 = getelementptr %struct.VdbeOp, %struct.VdbeOp* %1694, i32 0, i32 6, !dbg !564
  %1696 = bitcast %union.p4union* %1695 to %struct.CollSeq**, !dbg !565
  %1697 = load %struct.CollSeq*, %struct.CollSeq** %1696, align 8, !dbg !566
  %1698 = call i32 @sqlite3MemCompare(%struct.sqlite3_value* %105, %struct.sqlite3_value* %1604, %struct.CollSeq* %1697), !dbg !567
  store i32 %1698, i32* %1602, align 4, !dbg !568
  br label %1699, !dbg !630

1699:                                             ; preds = %1691, %1692, %1693, %1688
  %1700 = load i32, i32* %1602, align 4, !dbg !631
  %1701 = icmp slt i32 %1700, 0, !dbg !569
  br i1 %1701, label %1702, label %1703, !dbg !570

1702:                                             ; preds = %1699
  store i32 0, i32* %1603, align 4, !dbg !571
  br label %1704, !dbg !572

1703:                                             ; preds = %1699
  store i32 1, i32* %1603, align 4, !dbg !573
  br label %1704, !dbg !573

1704:                                             ; preds = %1703, %1702
  store i16 %1608, i16* %1609, align 2, !dbg !574
  store i16 %1606, i16* %1607, align 2, !dbg !575
  %1705 = load i32, i32* %1603, align 4, !dbg !576
  %1706 = icmp ne i32 %1705, 0, !dbg !577
  call void @llvm.stackrestore(i8* %1601), !dbg !578
  br i1 %1706, label %2380, label %1707, !dbg !579

1707:                                             ; preds = %1704
  %1708 = call i8* @llvm.stacksave(), !dbg !142
  %1709 = load i8, i8* %96, align 1, !dbg !146
  %1710 = alloca i32, align 4, !dbg !147
  store i32 0, i32* %1710, align 4, !dbg !148
  %1711 = alloca %struct.VdbeCursor*, align 8, !dbg !149
  %1712 = load %struct.VdbeCursor*, %struct.VdbeCursor** %9, align 8, !dbg !150
  store %struct.VdbeCursor* %1712, %struct.VdbeCursor** %1711, align 8, !dbg !151
  %1713 = alloca i8*, align 8, !dbg !152
  %1714 = alloca i32, align 4, !dbg !153
  %1715 = call i32 @sqlite3VdbeCursorMoveto(%struct.VdbeCursor** %1711, i32* %1710), !dbg !154
  %1716 = load %struct.VdbeCursor*, %struct.VdbeCursor** %1711, align 8, !dbg !155
  %1717 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %7, i32 10, !dbg !156
  %1718 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %1716, i32 0, i32 16, !dbg !157
  %1719 = load i16, i16* %1718, align 2, !dbg !158
  %1720 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %1716, i32 0, i32 19, !dbg !159
  %1721 = load i32*, i32** %1720, align 8, !dbg !160
  %1722 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %1716, i32 0, i32 0, !dbg !161
  %1723 = load i8, i8* %1722, align 1, !dbg !162
  %1724 = icmp ne i8 %1723, 3, !dbg !163
  %1725 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %1716, i32 0, i32 2, !dbg !164
  %1726 = load i8, i8* %1725, align 1, !dbg !165
  %1727 = icmp ne i8 %1726, 0, !dbg !166
  %1728 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %1716, i32 0, i32 14, !dbg !167
  %1729 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %1716, i32 0, i32 21, !dbg !168
  %1730 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %1716, i32 0, i32 22, !dbg !169
  %1731 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %1716, i32 0, i32 20, !dbg !170
  %1732 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %1716, i32 0, i32 17, !dbg !171
  %1733 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %1716, i32 0, i32 9, !dbg !172
  %1734 = load i32, i32* %1733, align 4, !dbg !173
  %1735 = load i32, i32* %123, align 4, !dbg !175
  %1736 = icmp ne i32 %1734, %1735, !dbg !176
  br i1 %1736, label %1737, label %1779, !dbg !177

1737:                                             ; preds = %1707
  br i1 %1727, label %1759, label %1754, !dbg !178

1738:                                             ; preds = %1754, %1761
  %1739 = load i32, i32* %123, align 4, !dbg !179
  store i32 %1739, i32* %1733, align 4, !dbg !180
  %1740 = load i8*, i8** %1731, align 8, !dbg !181
  %1741 = load i8, i8* %1740, align 1, !dbg !182
  %1742 = icmp sgt i8 %1741, -1, !dbg !185
  br i1 %1742, label %1743, label %1745, !dbg !186

1743:                                             ; preds = %1738
  %1744 = zext i8 %1741 to i32, !dbg !187
  store i32 %1744, i32* %1721, align 4, !dbg !188
  store i32 1, i32* %1728, align 4, !dbg !189
  br label %1748, !dbg !190

1745:                                             ; preds = %1738
  %1746 = call i8 @sqlite3GetVarint32(i8* %1740, i32* %1721), !dbg !191
  %1747 = zext i8 %1746 to i32, !dbg !192
  store i32 %1747, i32* %1728, align 4, !dbg !193
  br label %1748, !dbg !194

1748:                                             ; preds = %1745, %1743
  store i16 0, i16* %1732, align 2, !dbg !195
  %1749 = load i32, i32* %1730, align 4, !dbg !196
  %1750 = load i32, i32* %1721, align 4, !dbg !197
  %1751 = icmp ult i32 %1749, %1750, !dbg !198
  br i1 %1751, label %1753, label %1752, !dbg !199

1752:                                             ; preds = %1748
  store i8* %1740, i8** %1713, align 8, !dbg !200
  br label %1872, !dbg !201

1753:                                             ; preds = %1748
  store i8* null, i8** %1731, align 8, !dbg !202
  store i32 0, i32* %1730, align 4, !dbg !203
  br label %1779, !dbg !204

1754:                                             ; preds = %1737
  %1755 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %1716, i32 0, i32 12, i32 0, !dbg !205
  %1756 = load %struct.BtCursor*, %struct.BtCursor** %1755, align 8, !dbg !206
  %1757 = call i32 @sqlite3BtreePayloadSize(%struct.BtCursor* %1756), !dbg !207
  store i32 %1757, i32* %1729, align 4, !dbg !208
  %1758 = call i8* @sqlite3BtreePayloadFetch(%struct.BtCursor* %1756, i32* %1730), !dbg !209
  store i8* %1758, i8** %1731, align 8, !dbg !210
  br label %1738, !dbg !211

1759:                                             ; preds = %1737
  %1760 = icmp eq i8 %1723, 3, !dbg !212
  br i1 %1760, label %1761, label %1772, !dbg !213

1761:                                             ; preds = %1759
  %1762 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %1716, i32 0, i32 10, !dbg !214
  %1763 = load i32, i32* %1762, align 4, !dbg !215
  %1764 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %7, i32 %1763, !dbg !216
  %1765 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %1764, i32 0, i32 1, !dbg !217
  %1766 = load i16, i16* %1765, align 2, !dbg !218
  %1767 = and i16 %1766, 16, !dbg !219
  %1768 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %1764, i32 0, i32 4, !dbg !220
  %1769 = load i32, i32* %1768, align 4, !dbg !221
  store i32 %1769, i32* %1729, align 4, !dbg !222
  store i32 %1769, i32* %1730, align 4, !dbg !223
  %1770 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %1764, i32 0, i32 5, !dbg !224
  %1771 = load i8*, i8** %1770, align 8, !dbg !225
  store i8* %1771, i8** %1731, align 8, !dbg !226
  br label %1738, !dbg !227

1772:                                             ; preds = %1759
  %1773 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %1717, i32 0, i32 1, !dbg !228
  %1774 = load i16, i16* %1773, align 2, !dbg !228
  %1775 = and i16 %1774, 9216, !dbg !228
  %1776 = icmp ne i16 %1775, 0, !dbg !228
  br i1 %1776, label %1777, label %1778, !dbg !228

1777:                                             ; preds = %1772
  call void @vdbeMemClearExternAndSetNull(%struct.sqlite3_value* %1717), !dbg !228
  br label %1960, !dbg !228

1778:                                             ; preds = %1772
  store i16 1, i16* %1773, align 2, !dbg !228
  br label %1960, !dbg !228

1779:                                             ; preds = %1753, %1707
  %1780 = load i16, i16* %1732, align 2, !dbg !229
  %1781 = icmp ule i16 %1780, 5, !dbg !230
  br i1 %1781, label %1864, label %1861, !dbg !231

1782:                                             ; preds = %1861, %1950
  %1783 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %1717, i32 0, i32 1, !dbg !232
  %1784 = load i16, i16* %1783, align 2, !dbg !233
  %1785 = and i16 9216, %1784, !dbg !234
  %1786 = icmp eq i16 0, %1785, !dbg !235
  br i1 %1786, label %1787, label %1791, !dbg !236

1787:                                             ; preds = %1782
  %1788 = icmp ne i16 %1785, 0, !dbg !237
  br i1 %1788, label %1789, label %1790, !dbg !237

1789:                                             ; preds = %1787
  call void @vdbeMemClearExternAndSetNull(%struct.sqlite3_value* %1717), !dbg !237
  br label %1791, !dbg !237

1790:                                             ; preds = %1787
  store i16 1, i16* %1783, align 2, !dbg !237
  br label %1791, !dbg !237

1791:                                             ; preds = %1789, %1790, %1782
  %1792 = load i32, i32* %1714, align 4, !dbg !238
  %1793 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %1716, i32 0, i32 23, i32 5, !dbg !239
  %1794 = load i32, i32* %1793, align 4, !dbg !240
  %1795 = load i32, i32* %1730, align 4, !dbg !241
  %1796 = getelementptr i32, i32* %1721, i32 6, !dbg !242
  %1797 = load i32, i32* %1796, align 4, !dbg !243
  %1798 = icmp sge i32 %1795, %1797, !dbg !244
  br i1 %1798, label %1799, label %1839, !dbg !245

1799:                                             ; preds = %1791
  %1800 = load i8*, i8** %1731, align 8, !dbg !246
  %1801 = ptrtoint i8* %1800 to i64, !dbg !247
  %1802 = getelementptr i32, i32* %1721, i32 5, !dbg !248
  %1803 = load i32, i32* %1802, align 4, !dbg !249
  %1804 = zext i32 %1803 to i64, !dbg !250
  %1805 = add i64 %1801, %1804, !dbg !251
  %1806 = inttoptr i64 %1805 to i8*, !dbg !252
  store i8* %1806, i8** %1713, align 8, !dbg !253
  %1807 = load i32, i32* %1714, align 4, !dbg !254
  %1808 = icmp ult i32 %1807, 12, !dbg !255
  br i1 %1808, label %1809, label %1811, !dbg !256

1809:                                             ; preds = %1799
  %1810 = call i32 @sqlite3VdbeSerialGet(i8* %1806, i32 %1807, %struct.sqlite3_value* %1717), !dbg !257
  br label %1960, !dbg !258

1811:                                             ; preds = %1799
  %1812 = alloca i16, i32 2, align 2, !dbg !259
  store i16 16, i16* %1812, align 2, !dbg !260
  %1813 = getelementptr i16, i16* %1812, i32 1, !dbg !261
  store i16 514, i16* %1813, align 2, !dbg !262
  %1814 = load i32, i32* %1714, align 4, !dbg !263
  %1815 = sub i32 %1814, 12, !dbg !264
  %1816 = lshr i32 %1815, 1, !dbg !265
  %1817 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %1717, i32 0, i32 4, !dbg !266
  store i32 %1816, i32* %1817, align 4, !dbg !267
  %1818 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %1717, i32 0, i32 2, !dbg !268
  store i8 %1709, i8* %1818, align 1, !dbg !269
  %1819 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %1717, i32 0, i32 5, !dbg !270
  %1820 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %1717, i32 0, i32 7, !dbg !271
  %1821 = load i32, i32* %1820, align 4, !dbg !272
  %1822 = add i32 %1816, 2, !dbg !273
  %1823 = icmp slt i32 %1821, %1822, !dbg !274
  br i1 %1823, label %1824, label %1826, !dbg !275

1824:                                             ; preds = %1811
  store i16 1, i16* %1783, align 2, !dbg !276
  %1825 = call i32 @sqlite3VdbeMemGrow(%struct.sqlite3_value* %1717, i32 %1822, i32 0), !dbg !277
  br label %1829, !dbg !278

1826:                                             ; preds = %1811
  %1827 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %1717, i32 0, i32 6, !dbg !279
  %1828 = load i8*, i8** %1827, align 8, !dbg !280
  store i8* %1828, i8** %1819, align 8, !dbg !281
  br label %1829, !dbg !282

1829:                                             ; preds = %1826, %1824
  %1830 = zext i32 %1816 to i64, !dbg !283
  %1831 = load i8*, i8** %1819, align 8, !dbg !284
  %1832 = load i8*, i8** %1713, align 8, !dbg !285
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %1831, i8* %1832, i64 %1830, i1 false), !dbg !286
  %1833 = getelementptr i8, i8* %1831, i32 %1816, !dbg !287
  store i8 0, i8* %1833, align 1, !dbg !288
  %1834 = add i32 %1816, 1, !dbg !289
  %1835 = getelementptr i8, i8* %1831, i32 %1834, !dbg !290
  store i8 0, i8* %1835, align 1, !dbg !291
  %1836 = and i32 %1814, 1, !dbg !292
  %1837 = getelementptr i16, i16* %1812, i32 %1836, !dbg !293
  %1838 = load i16, i16* %1837, align 2, !dbg !294
  store i16 %1838, i16* %1783, align 2, !dbg !295
  br label %1960, !dbg !296

1839:                                             ; preds = %1791
  %1840 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %1717, i32 0, i32 2, !dbg !297
  store i8 %1709, i8* %1840, align 1, !dbg !298
  %1841 = load i32, i32* %1714, align 4, !dbg !299
  %1842 = and i32 %1841, 1, !dbg !300
  %1843 = icmp eq i32 %1842, 0, !dbg !301
  %1844 = icmp sge i32 %1841, 12, !dbg !302
  %1845 = and i1 %1844, %1843, !dbg !303
  %1846 = call i32 @sqlite3VdbeSerialTypeLen(i32 %1841), !dbg !304
  %1847 = icmp eq i32 %1846, 0, !dbg !305
  br i1 %1847, label %1859, label %1848, !dbg !306

1848:                                             ; preds = %1839
  %1849 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %1716, i32 0, i32 12, i32 0, !dbg !307
  %1850 = load %struct.BtCursor*, %struct.BtCursor** %1849, align 8, !dbg !308
  %1851 = getelementptr i32, i32* %1721, i32 5, !dbg !309
  %1852 = load i32, i32* %1851, align 4, !dbg !310
  %1853 = call i32 @sqlite3VdbeMemFromBtree(%struct.BtCursor* %1850, i32 %1852, i32 %1846, %struct.sqlite3_value* %1717), !dbg !311
  %1854 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %1717, i32 0, i32 5, !dbg !312
  %1855 = load i8*, i8** %1854, align 8, !dbg !313
  %1856 = call i32 @sqlite3VdbeSerialGet(i8* %1855, i32 %1841, %struct.sqlite3_value* %1717), !dbg !314
  %1857 = load i16, i16* %1783, align 2, !dbg !315
  %1858 = and i16 %1857, -4097, !dbg !316
  store i16 %1858, i16* %1783, align 2, !dbg !317
  br label %1960, !dbg !318

1859:                                             ; preds = %1839
  %1860 = call i32 @sqlite3VdbeSerialGet(i8* %1, i32 %1841, %struct.sqlite3_value* %1717), !dbg !319
  br label %1960, !dbg !320

1861:                                             ; preds = %1779
  %1862 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %1716, i32 0, i32 23, i32 5, !dbg !321
  %1863 = load i32, i32* %1862, align 4, !dbg !322
  store i32 %1863, i32* %1714, align 4, !dbg !323
  br label %1782, !dbg !324

1864:                                             ; preds = %1779
  %1865 = load i32, i32* %1728, align 4, !dbg !325
  %1866 = load i32, i32* %1721, align 4, !dbg !326
  %1867 = icmp ult i32 %1865, %1866, !dbg !327
  br i1 %1867, label %1868, label %1949, !dbg !328

1868:                                             ; preds = %1864
  %1869 = load i8*, i8** %1731, align 8, !dbg !329
  %1870 = icmp eq i8* %1869, null, !dbg !330
  br i1 %1870, label %1872, label %1871, !dbg !331

1871:                                             ; preds = %1868
  store i8* %1869, i8** %1713, align 8, !dbg !332
  br label %1872, !dbg !333

1872:                                             ; preds = %1871, %1868, %1752
  %1873 = alloca i32, align 4, !dbg !334
  %1874 = load i16, i16* %1732, align 2, !dbg !335
  %1875 = zext i16 %1874 to i32, !dbg !336
  store i32 %1875, i32* %1873, align 4, !dbg !337
  %1876 = alloca i64, align 8, !dbg !338
  %1877 = getelementptr i32, i32* %1721, i32 %1875, !dbg !339
  %1878 = load i32, i32* %1877, align 4, !dbg !340
  %1879 = zext i32 %1878 to i64, !dbg !341
  store i64 %1879, i64* %1876, align 4, !dbg !342
  %1880 = load i8*, i8** %1713, align 8, !dbg !343
  %1881 = load i32, i32* %1728, align 4, !dbg !344
  %1882 = alloca i8*, align 8, !dbg !345
  %1883 = getelementptr i8, i8* %1880, i32 %1881, !dbg !346
  store i8* %1883, i8** %1882, align 8, !dbg !347
  %1884 = load i32, i32* %1721, align 4, !dbg !348
  %1885 = getelementptr i8, i8* %1880, i32 %1884, !dbg !349
  br label %1886, !dbg !350

1886:                                             ; preds = %1893, %1872
  %1887 = load i32, i32* %1873, align 4, !dbg !351
  %1888 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %1716, i32 0, i32 23, i32 %1887, !dbg !352
  %1889 = load i8*, i8** %1882, align 8, !dbg !353
  %1890 = load i8, i8* %1889, align 1, !dbg !354
  %1891 = zext i8 %1890 to i32, !dbg !355
  store i32 %1891, i32* %1714, align 4, !dbg !356
  store i32 %1891, i32* %1888, align 4, !dbg !357
  %1892 = icmp sgt i8 %1890, -1, !dbg !358
  br i1 %1892, label %1916, label %1907, !dbg !359

1893:                                             ; preds = %1907, %1916
  %1894 = load i32, i32* %1873, align 4, !dbg !360
  %1895 = add i32 %1894, 1, !dbg !361
  store i32 %1895, i32* %1873, align 4, !dbg !362
  %1896 = load i64, i64* %1876, align 4, !dbg !363
  %1897 = and i64 4294967295, %1896, !dbg !364
  %1898 = trunc i64 %1897 to i32, !dbg !365
  %1899 = getelementptr i32, i32* %1721, i32 %1895, !dbg !366
  store i32 %1898, i32* %1899, align 4, !dbg !367
  %1900 = load i32, i32* %1873, align 4, !dbg !368
  %1901 = icmp sle i32 %1900, 5, !dbg !369
  %1902 = load i8*, i8** %1882, align 8, !dbg !370
  %1903 = ptrtoint i8* %1902 to i64, !dbg !371
  %1904 = ptrtoint i8* %1885 to i64, !dbg !372
  %1905 = icmp ult i64 %1903, %1904, !dbg !373
  %1906 = and i1 %1901, %1905, !dbg !374
  br i1 %1906, label %1886, label %1925, !dbg !375

1907:                                             ; preds = %1886
  %1908 = load i8*, i8** %1882, align 8, !dbg !376
  %1909 = call i8 @sqlite3GetVarint32(i8* %1908, i32* %1714), !dbg !377
  %1910 = getelementptr i8, i8* %1908, i8 %1909, !dbg !378
  store i8* %1910, i8** %1882, align 8, !dbg !379
  %1911 = load i32, i32* %1714, align 4, !dbg !380
  store i32 %1911, i32* %1888, align 4, !dbg !381
  %1912 = load i64, i64* %1876, align 4, !dbg !382
  %1913 = call i32 @sqlite3VdbeSerialTypeLen(i32 %1911), !dbg !383
  %1914 = zext i32 %1913 to i64, !dbg !384
  %1915 = add i64 %1912, %1914, !dbg !385
  store i64 %1915, i64* %1876, align 4, !dbg !386
  br label %1893, !dbg !387

1916:                                             ; preds = %1886
  %1917 = getelementptr i8, i8* %1889, i32 1, !dbg !388
  store i8* %1917, i8** %1882, align 8, !dbg !389
  %1918 = load i32, i32* %1714, align 4, !dbg !390
  %1919 = trunc i32 %1918 to i8, !dbg !391
  %1920 = getelementptr i8, i8* %4, i8 %1919, !dbg !392
  %1921 = load i8, i8* %1920, align 1, !dbg !393
  %1922 = zext i8 %1921 to i64, !dbg !394
  %1923 = load i64, i64* %1876, align 4, !dbg !395
  %1924 = add i64 %1923, %1922, !dbg !396
  store i64 %1924, i64* %1876, align 4, !dbg !397
  br label %1893, !dbg !398

1925:                                             ; preds = %1893
  %1926 = load i64, i64* %1876, align 4, !dbg !399
  %1927 = load i32, i32* %1729, align 4, !dbg !400
  %1928 = zext i32 %1927 to i64, !dbg !401
  %1929 = icmp uge i64 %1903, %1904, !dbg !402
  %1930 = icmp ugt i64 %1903, %1904, !dbg !403
  %1931 = icmp ne i64 %1926, %1928, !dbg !404
  %1932 = icmp ugt i64 %1926, %1928, !dbg !405
  %1933 = or i1 %1930, %1931, !dbg !406
  %1934 = and i1 %1929, %1933, !dbg !407
  %1935 = or i1 %1934, %1932, !dbg !408
  br i1 %1935, label %1936, label %1940, !dbg !409

1936:                                             ; preds = %1925
  %1937 = load i32, i32* %1721, align 4, !dbg !410
  %1938 = icmp eq i32 %1937, 0, !dbg !411
  br i1 %1938, label %1939, label %1940, !dbg !412

1939:                                             ; preds = %1936
  store i32 0, i32* %1873, align 4, !dbg !413
  store i8* %1885, i8** %1882, align 8, !dbg !414
  br label %1940, !dbg !415

1940:                                             ; preds = %1939, %1936, %1925
  %1941 = load i32, i32* %1873, align 4, !dbg !416
  %1942 = trunc i32 %1941 to i16, !dbg !417
  store i16 %1942, i16* %1732, align 2, !dbg !418
  %1943 = load i8*, i8** %1882, align 8, !dbg !419
  %1944 = ptrtoint i8* %1943 to i64, !dbg !420
  %1945 = load i8*, i8** %1713, align 8, !dbg !421
  %1946 = ptrtoint i8* %1945 to i64, !dbg !422
  %1947 = sub i64 %1944, %1946, !dbg !423
  %1948 = trunc i64 %1947 to i32, !dbg !424
  store i32 %1948, i32* %1728, align 4, !dbg !425
  br label %1950, !dbg !426

1949:                                             ; preds = %1864
  store i32 0, i32* %1714, align 4, !dbg !427
  br label %1950, !dbg !428

1950:                                             ; preds = %1940, %1949
  %1951 = load i16, i16* %1732, align 2, !dbg !429
  %1952 = icmp sle i16 %1951, 5, !dbg !430
  br i1 %1952, label %1953, label %1782, !dbg !431

1953:                                             ; preds = %1950
  %1954 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %1717, i32 0, i32 1, !dbg !432
  %1955 = load i16, i16* %1954, align 2, !dbg !432
  %1956 = and i16 %1955, 9216, !dbg !432
  %1957 = icmp ne i16 %1956, 0, !dbg !432
  br i1 %1957, label %1958, label %1959, !dbg !432

1958:                                             ; preds = %1953
  call void @vdbeMemClearExternAndSetNull(%struct.sqlite3_value* %1717), !dbg !432
  br label %1960, !dbg !432

1959:                                             ; preds = %1953
  store i16 1, i16* %1954, align 2, !dbg !432
  br label %1960, !dbg !432

1960:                                             ; preds = %1958, %1959, %1829, %1809, %1848, %1859, %1777, %1778
  call void @llvm.stackrestore(i8* %1708), !dbg !433
  %1961 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %1717, i32 0, i32 1, !dbg !638
  %1962 = load i16, i16* %1961, align 2, !dbg !582
  %1963 = and i16 %1962, 36, !dbg !585
  %1964 = icmp ne i16 %1963, 0, !dbg !586
  br i1 %1964, label %1965, label %1966, !dbg !587

1965:                                             ; preds = %1960
  call void @sqlite3VdbeMemRealify(%struct.sqlite3_value* %1717), !dbg !588
  br label %1966, !dbg !589

1966:                                             ; preds = %1965, %1960
  %1967 = call i8* @llvm.stacksave(), !dbg !142
  %1968 = load i8, i8* %96, align 1, !dbg !146
  %1969 = alloca i32, align 4, !dbg !147
  store i32 0, i32* %1969, align 4, !dbg !148
  %1970 = alloca %struct.VdbeCursor*, align 8, !dbg !149
  %1971 = load %struct.VdbeCursor*, %struct.VdbeCursor** %9, align 8, !dbg !150
  store %struct.VdbeCursor* %1971, %struct.VdbeCursor** %1970, align 8, !dbg !151
  %1972 = alloca i8*, align 8, !dbg !152
  %1973 = alloca i32, align 4, !dbg !153
  %1974 = call i32 @sqlite3VdbeCursorMoveto(%struct.VdbeCursor** %1970, i32* %1969), !dbg !154
  %1975 = load %struct.VdbeCursor*, %struct.VdbeCursor** %1970, align 8, !dbg !155
  %1976 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %7, i32 14, !dbg !156
  %1977 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %1975, i32 0, i32 16, !dbg !157
  %1978 = load i16, i16* %1977, align 2, !dbg !158
  %1979 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %1975, i32 0, i32 19, !dbg !159
  %1980 = load i32*, i32** %1979, align 8, !dbg !160
  %1981 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %1975, i32 0, i32 0, !dbg !161
  %1982 = load i8, i8* %1981, align 1, !dbg !162
  %1983 = icmp ne i8 %1982, 3, !dbg !163
  %1984 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %1975, i32 0, i32 2, !dbg !164
  %1985 = load i8, i8* %1984, align 1, !dbg !165
  %1986 = icmp ne i8 %1985, 0, !dbg !166
  %1987 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %1975, i32 0, i32 14, !dbg !167
  %1988 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %1975, i32 0, i32 21, !dbg !168
  %1989 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %1975, i32 0, i32 22, !dbg !169
  %1990 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %1975, i32 0, i32 20, !dbg !170
  %1991 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %1975, i32 0, i32 17, !dbg !171
  %1992 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %1975, i32 0, i32 9, !dbg !172
  %1993 = load i32, i32* %1992, align 4, !dbg !173
  %1994 = load i32, i32* %123, align 4, !dbg !175
  %1995 = icmp ne i32 %1993, %1994, !dbg !176
  br i1 %1995, label %1996, label %2038, !dbg !177

1996:                                             ; preds = %1966
  br i1 %1986, label %2018, label %2013, !dbg !178

1997:                                             ; preds = %2013, %2020
  %1998 = load i32, i32* %123, align 4, !dbg !179
  store i32 %1998, i32* %1992, align 4, !dbg !180
  %1999 = load i8*, i8** %1990, align 8, !dbg !181
  %2000 = load i8, i8* %1999, align 1, !dbg !182
  %2001 = icmp sgt i8 %2000, -1, !dbg !185
  br i1 %2001, label %2002, label %2004, !dbg !186

2002:                                             ; preds = %1997
  %2003 = zext i8 %2000 to i32, !dbg !187
  store i32 %2003, i32* %1980, align 4, !dbg !188
  store i32 1, i32* %1987, align 4, !dbg !189
  br label %2007, !dbg !190

2004:                                             ; preds = %1997
  %2005 = call i8 @sqlite3GetVarint32(i8* %1999, i32* %1980), !dbg !191
  %2006 = zext i8 %2005 to i32, !dbg !192
  store i32 %2006, i32* %1987, align 4, !dbg !193
  br label %2007, !dbg !194

2007:                                             ; preds = %2004, %2002
  store i16 0, i16* %1991, align 2, !dbg !195
  %2008 = load i32, i32* %1989, align 4, !dbg !196
  %2009 = load i32, i32* %1980, align 4, !dbg !197
  %2010 = icmp ult i32 %2008, %2009, !dbg !198
  br i1 %2010, label %2012, label %2011, !dbg !199

2011:                                             ; preds = %2007
  store i8* %1999, i8** %1972, align 8, !dbg !200
  br label %2131, !dbg !201

2012:                                             ; preds = %2007
  store i8* null, i8** %1990, align 8, !dbg !202
  store i32 0, i32* %1989, align 4, !dbg !203
  br label %2038, !dbg !204

2013:                                             ; preds = %1996
  %2014 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %1975, i32 0, i32 12, i32 0, !dbg !205
  %2015 = load %struct.BtCursor*, %struct.BtCursor** %2014, align 8, !dbg !206
  %2016 = call i32 @sqlite3BtreePayloadSize(%struct.BtCursor* %2015), !dbg !207
  store i32 %2016, i32* %1988, align 4, !dbg !208
  %2017 = call i8* @sqlite3BtreePayloadFetch(%struct.BtCursor* %2015, i32* %1989), !dbg !209
  store i8* %2017, i8** %1990, align 8, !dbg !210
  br label %1997, !dbg !211

2018:                                             ; preds = %1996
  %2019 = icmp eq i8 %1982, 3, !dbg !212
  br i1 %2019, label %2020, label %2031, !dbg !213

2020:                                             ; preds = %2018
  %2021 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %1975, i32 0, i32 10, !dbg !214
  %2022 = load i32, i32* %2021, align 4, !dbg !215
  %2023 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %7, i32 %2022, !dbg !216
  %2024 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %2023, i32 0, i32 1, !dbg !217
  %2025 = load i16, i16* %2024, align 2, !dbg !218
  %2026 = and i16 %2025, 16, !dbg !219
  %2027 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %2023, i32 0, i32 4, !dbg !220
  %2028 = load i32, i32* %2027, align 4, !dbg !221
  store i32 %2028, i32* %1988, align 4, !dbg !222
  store i32 %2028, i32* %1989, align 4, !dbg !223
  %2029 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %2023, i32 0, i32 5, !dbg !224
  %2030 = load i8*, i8** %2029, align 8, !dbg !225
  store i8* %2030, i8** %1990, align 8, !dbg !226
  br label %1997, !dbg !227

2031:                                             ; preds = %2018
  %2032 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %1976, i32 0, i32 1, !dbg !228
  %2033 = load i16, i16* %2032, align 2, !dbg !228
  %2034 = and i16 %2033, 9216, !dbg !228
  %2035 = icmp ne i16 %2034, 0, !dbg !228
  br i1 %2035, label %2036, label %2037, !dbg !228

2036:                                             ; preds = %2031
  call void @vdbeMemClearExternAndSetNull(%struct.sqlite3_value* %1976), !dbg !228
  br label %2219, !dbg !228

2037:                                             ; preds = %2031
  store i16 1, i16* %2032, align 2, !dbg !228
  br label %2219, !dbg !228

2038:                                             ; preds = %2012, %1966
  %2039 = load i16, i16* %1991, align 2, !dbg !229
  %2040 = icmp ule i16 %2039, 6, !dbg !230
  br i1 %2040, label %2123, label %2120, !dbg !231

2041:                                             ; preds = %2120, %2209
  %2042 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %1976, i32 0, i32 1, !dbg !232
  %2043 = load i16, i16* %2042, align 2, !dbg !233
  %2044 = and i16 9216, %2043, !dbg !234
  %2045 = icmp eq i16 0, %2044, !dbg !235
  br i1 %2045, label %2046, label %2050, !dbg !236

2046:                                             ; preds = %2041
  %2047 = icmp ne i16 %2044, 0, !dbg !237
  br i1 %2047, label %2048, label %2049, !dbg !237

2048:                                             ; preds = %2046
  call void @vdbeMemClearExternAndSetNull(%struct.sqlite3_value* %1976), !dbg !237
  br label %2050, !dbg !237

2049:                                             ; preds = %2046
  store i16 1, i16* %2042, align 2, !dbg !237
  br label %2050, !dbg !237

2050:                                             ; preds = %2048, %2049, %2041
  %2051 = load i32, i32* %1973, align 4, !dbg !238
  %2052 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %1975, i32 0, i32 23, i32 6, !dbg !239
  %2053 = load i32, i32* %2052, align 4, !dbg !240
  %2054 = load i32, i32* %1989, align 4, !dbg !241
  %2055 = getelementptr i32, i32* %1980, i32 7, !dbg !242
  %2056 = load i32, i32* %2055, align 4, !dbg !243
  %2057 = icmp sge i32 %2054, %2056, !dbg !244
  br i1 %2057, label %2058, label %2098, !dbg !245

2058:                                             ; preds = %2050
  %2059 = load i8*, i8** %1990, align 8, !dbg !246
  %2060 = ptrtoint i8* %2059 to i64, !dbg !247
  %2061 = getelementptr i32, i32* %1980, i32 6, !dbg !248
  %2062 = load i32, i32* %2061, align 4, !dbg !249
  %2063 = zext i32 %2062 to i64, !dbg !250
  %2064 = add i64 %2060, %2063, !dbg !251
  %2065 = inttoptr i64 %2064 to i8*, !dbg !252
  store i8* %2065, i8** %1972, align 8, !dbg !253
  %2066 = load i32, i32* %1973, align 4, !dbg !254
  %2067 = icmp ult i32 %2066, 12, !dbg !255
  br i1 %2067, label %2068, label %2070, !dbg !256

2068:                                             ; preds = %2058
  %2069 = call i32 @sqlite3VdbeSerialGet(i8* %2065, i32 %2066, %struct.sqlite3_value* %1976), !dbg !257
  br label %2219, !dbg !258

2070:                                             ; preds = %2058
  %2071 = alloca i16, i32 2, align 2, !dbg !259
  store i16 16, i16* %2071, align 2, !dbg !260
  %2072 = getelementptr i16, i16* %2071, i32 1, !dbg !261
  store i16 514, i16* %2072, align 2, !dbg !262
  %2073 = load i32, i32* %1973, align 4, !dbg !263
  %2074 = sub i32 %2073, 12, !dbg !264
  %2075 = lshr i32 %2074, 1, !dbg !265
  %2076 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %1976, i32 0, i32 4, !dbg !266
  store i32 %2075, i32* %2076, align 4, !dbg !267
  %2077 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %1976, i32 0, i32 2, !dbg !268
  store i8 %1968, i8* %2077, align 1, !dbg !269
  %2078 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %1976, i32 0, i32 5, !dbg !270
  %2079 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %1976, i32 0, i32 7, !dbg !271
  %2080 = load i32, i32* %2079, align 4, !dbg !272
  %2081 = add i32 %2075, 2, !dbg !273
  %2082 = icmp slt i32 %2080, %2081, !dbg !274
  br i1 %2082, label %2083, label %2085, !dbg !275

2083:                                             ; preds = %2070
  store i16 1, i16* %2042, align 2, !dbg !276
  %2084 = call i32 @sqlite3VdbeMemGrow(%struct.sqlite3_value* %1976, i32 %2081, i32 0), !dbg !277
  br label %2088, !dbg !278

2085:                                             ; preds = %2070
  %2086 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %1976, i32 0, i32 6, !dbg !279
  %2087 = load i8*, i8** %2086, align 8, !dbg !280
  store i8* %2087, i8** %2078, align 8, !dbg !281
  br label %2088, !dbg !282

2088:                                             ; preds = %2085, %2083
  %2089 = zext i32 %2075 to i64, !dbg !283
  %2090 = load i8*, i8** %2078, align 8, !dbg !284
  %2091 = load i8*, i8** %1972, align 8, !dbg !285
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %2090, i8* %2091, i64 %2089, i1 false), !dbg !286
  %2092 = getelementptr i8, i8* %2090, i32 %2075, !dbg !287
  store i8 0, i8* %2092, align 1, !dbg !288
  %2093 = add i32 %2075, 1, !dbg !289
  %2094 = getelementptr i8, i8* %2090, i32 %2093, !dbg !290
  store i8 0, i8* %2094, align 1, !dbg !291
  %2095 = and i32 %2073, 1, !dbg !292
  %2096 = getelementptr i16, i16* %2071, i32 %2095, !dbg !293
  %2097 = load i16, i16* %2096, align 2, !dbg !294
  store i16 %2097, i16* %2042, align 2, !dbg !295
  br label %2219, !dbg !296

2098:                                             ; preds = %2050
  %2099 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %1976, i32 0, i32 2, !dbg !297
  store i8 %1968, i8* %2099, align 1, !dbg !298
  %2100 = load i32, i32* %1973, align 4, !dbg !299
  %2101 = and i32 %2100, 1, !dbg !300
  %2102 = icmp eq i32 %2101, 0, !dbg !301
  %2103 = icmp sge i32 %2100, 12, !dbg !302
  %2104 = and i1 %2103, %2102, !dbg !303
  %2105 = call i32 @sqlite3VdbeSerialTypeLen(i32 %2100), !dbg !304
  %2106 = icmp eq i32 %2105, 0, !dbg !305
  br i1 %2106, label %2118, label %2107, !dbg !306

2107:                                             ; preds = %2098
  %2108 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %1975, i32 0, i32 12, i32 0, !dbg !307
  %2109 = load %struct.BtCursor*, %struct.BtCursor** %2108, align 8, !dbg !308
  %2110 = getelementptr i32, i32* %1980, i32 6, !dbg !309
  %2111 = load i32, i32* %2110, align 4, !dbg !310
  %2112 = call i32 @sqlite3VdbeMemFromBtree(%struct.BtCursor* %2109, i32 %2111, i32 %2105, %struct.sqlite3_value* %1976), !dbg !311
  %2113 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %1976, i32 0, i32 5, !dbg !312
  %2114 = load i8*, i8** %2113, align 8, !dbg !313
  %2115 = call i32 @sqlite3VdbeSerialGet(i8* %2114, i32 %2100, %struct.sqlite3_value* %1976), !dbg !314
  %2116 = load i16, i16* %2042, align 2, !dbg !315
  %2117 = and i16 %2116, -4097, !dbg !316
  store i16 %2117, i16* %2042, align 2, !dbg !317
  br label %2219, !dbg !318

2118:                                             ; preds = %2098
  %2119 = call i32 @sqlite3VdbeSerialGet(i8* %1, i32 %2100, %struct.sqlite3_value* %1976), !dbg !319
  br label %2219, !dbg !320

2120:                                             ; preds = %2038
  %2121 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %1975, i32 0, i32 23, i32 6, !dbg !321
  %2122 = load i32, i32* %2121, align 4, !dbg !322
  store i32 %2122, i32* %1973, align 4, !dbg !323
  br label %2041, !dbg !324

2123:                                             ; preds = %2038
  %2124 = load i32, i32* %1987, align 4, !dbg !325
  %2125 = load i32, i32* %1980, align 4, !dbg !326
  %2126 = icmp ult i32 %2124, %2125, !dbg !327
  br i1 %2126, label %2127, label %2208, !dbg !328

2127:                                             ; preds = %2123
  %2128 = load i8*, i8** %1990, align 8, !dbg !329
  %2129 = icmp eq i8* %2128, null, !dbg !330
  br i1 %2129, label %2131, label %2130, !dbg !331

2130:                                             ; preds = %2127
  store i8* %2128, i8** %1972, align 8, !dbg !332
  br label %2131, !dbg !333

2131:                                             ; preds = %2130, %2127, %2011
  %2132 = alloca i32, align 4, !dbg !334
  %2133 = load i16, i16* %1991, align 2, !dbg !335
  %2134 = zext i16 %2133 to i32, !dbg !336
  store i32 %2134, i32* %2132, align 4, !dbg !337
  %2135 = alloca i64, align 8, !dbg !338
  %2136 = getelementptr i32, i32* %1980, i32 %2134, !dbg !339
  %2137 = load i32, i32* %2136, align 4, !dbg !340
  %2138 = zext i32 %2137 to i64, !dbg !341
  store i64 %2138, i64* %2135, align 4, !dbg !342
  %2139 = load i8*, i8** %1972, align 8, !dbg !343
  %2140 = load i32, i32* %1987, align 4, !dbg !344
  %2141 = alloca i8*, align 8, !dbg !345
  %2142 = getelementptr i8, i8* %2139, i32 %2140, !dbg !346
  store i8* %2142, i8** %2141, align 8, !dbg !347
  %2143 = load i32, i32* %1980, align 4, !dbg !348
  %2144 = getelementptr i8, i8* %2139, i32 %2143, !dbg !349
  br label %2145, !dbg !350

2145:                                             ; preds = %2152, %2131
  %2146 = load i32, i32* %2132, align 4, !dbg !351
  %2147 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %1975, i32 0, i32 23, i32 %2146, !dbg !352
  %2148 = load i8*, i8** %2141, align 8, !dbg !353
  %2149 = load i8, i8* %2148, align 1, !dbg !354
  %2150 = zext i8 %2149 to i32, !dbg !355
  store i32 %2150, i32* %1973, align 4, !dbg !356
  store i32 %2150, i32* %2147, align 4, !dbg !357
  %2151 = icmp sgt i8 %2149, -1, !dbg !358
  br i1 %2151, label %2175, label %2166, !dbg !359

2152:                                             ; preds = %2166, %2175
  %2153 = load i32, i32* %2132, align 4, !dbg !360
  %2154 = add i32 %2153, 1, !dbg !361
  store i32 %2154, i32* %2132, align 4, !dbg !362
  %2155 = load i64, i64* %2135, align 4, !dbg !363
  %2156 = and i64 4294967295, %2155, !dbg !364
  %2157 = trunc i64 %2156 to i32, !dbg !365
  %2158 = getelementptr i32, i32* %1980, i32 %2154, !dbg !366
  store i32 %2157, i32* %2158, align 4, !dbg !367
  %2159 = load i32, i32* %2132, align 4, !dbg !368
  %2160 = icmp sle i32 %2159, 6, !dbg !369
  %2161 = load i8*, i8** %2141, align 8, !dbg !370
  %2162 = ptrtoint i8* %2161 to i64, !dbg !371
  %2163 = ptrtoint i8* %2144 to i64, !dbg !372
  %2164 = icmp ult i64 %2162, %2163, !dbg !373
  %2165 = and i1 %2160, %2164, !dbg !374
  br i1 %2165, label %2145, label %2184, !dbg !375

2166:                                             ; preds = %2145
  %2167 = load i8*, i8** %2141, align 8, !dbg !376
  %2168 = call i8 @sqlite3GetVarint32(i8* %2167, i32* %1973), !dbg !377
  %2169 = getelementptr i8, i8* %2167, i8 %2168, !dbg !378
  store i8* %2169, i8** %2141, align 8, !dbg !379
  %2170 = load i32, i32* %1973, align 4, !dbg !380
  store i32 %2170, i32* %2147, align 4, !dbg !381
  %2171 = load i64, i64* %2135, align 4, !dbg !382
  %2172 = call i32 @sqlite3VdbeSerialTypeLen(i32 %2170), !dbg !383
  %2173 = zext i32 %2172 to i64, !dbg !384
  %2174 = add i64 %2171, %2173, !dbg !385
  store i64 %2174, i64* %2135, align 4, !dbg !386
  br label %2152, !dbg !387

2175:                                             ; preds = %2145
  %2176 = getelementptr i8, i8* %2148, i32 1, !dbg !388
  store i8* %2176, i8** %2141, align 8, !dbg !389
  %2177 = load i32, i32* %1973, align 4, !dbg !390
  %2178 = trunc i32 %2177 to i8, !dbg !391
  %2179 = getelementptr i8, i8* %4, i8 %2178, !dbg !392
  %2180 = load i8, i8* %2179, align 1, !dbg !393
  %2181 = zext i8 %2180 to i64, !dbg !394
  %2182 = load i64, i64* %2135, align 4, !dbg !395
  %2183 = add i64 %2182, %2181, !dbg !396
  store i64 %2183, i64* %2135, align 4, !dbg !397
  br label %2152, !dbg !398

2184:                                             ; preds = %2152
  %2185 = load i64, i64* %2135, align 4, !dbg !399
  %2186 = load i32, i32* %1988, align 4, !dbg !400
  %2187 = zext i32 %2186 to i64, !dbg !401
  %2188 = icmp uge i64 %2162, %2163, !dbg !402
  %2189 = icmp ugt i64 %2162, %2163, !dbg !403
  %2190 = icmp ne i64 %2185, %2187, !dbg !404
  %2191 = icmp ugt i64 %2185, %2187, !dbg !405
  %2192 = or i1 %2189, %2190, !dbg !406
  %2193 = and i1 %2188, %2192, !dbg !407
  %2194 = or i1 %2193, %2191, !dbg !408
  br i1 %2194, label %2195, label %2199, !dbg !409

2195:                                             ; preds = %2184
  %2196 = load i32, i32* %1980, align 4, !dbg !410
  %2197 = icmp eq i32 %2196, 0, !dbg !411
  br i1 %2197, label %2198, label %2199, !dbg !412

2198:                                             ; preds = %2195
  store i32 0, i32* %2132, align 4, !dbg !413
  store i8* %2144, i8** %2141, align 8, !dbg !414
  br label %2199, !dbg !415

2199:                                             ; preds = %2198, %2195, %2184
  %2200 = load i32, i32* %2132, align 4, !dbg !416
  %2201 = trunc i32 %2200 to i16, !dbg !417
  store i16 %2201, i16* %1991, align 2, !dbg !418
  %2202 = load i8*, i8** %2141, align 8, !dbg !419
  %2203 = ptrtoint i8* %2202 to i64, !dbg !420
  %2204 = load i8*, i8** %1972, align 8, !dbg !421
  %2205 = ptrtoint i8* %2204 to i64, !dbg !422
  %2206 = sub i64 %2203, %2205, !dbg !423
  %2207 = trunc i64 %2206 to i32, !dbg !424
  store i32 %2207, i32* %1987, align 4, !dbg !425
  br label %2209, !dbg !426

2208:                                             ; preds = %2123
  store i32 0, i32* %1973, align 4, !dbg !427
  br label %2209, !dbg !428

2209:                                             ; preds = %2199, %2208
  %2210 = load i16, i16* %1991, align 2, !dbg !429
  %2211 = icmp sle i16 %2210, 6, !dbg !430
  br i1 %2211, label %2212, label %2041, !dbg !431

2212:                                             ; preds = %2209
  %2213 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %1976, i32 0, i32 1, !dbg !432
  %2214 = load i16, i16* %2213, align 2, !dbg !432
  %2215 = and i16 %2214, 9216, !dbg !432
  %2216 = icmp ne i16 %2215, 0, !dbg !432
  br i1 %2216, label %2217, label %2218, !dbg !432

2217:                                             ; preds = %2212
  call void @vdbeMemClearExternAndSetNull(%struct.sqlite3_value* %1976), !dbg !432
  br label %2219, !dbg !432

2218:                                             ; preds = %2212
  store i16 1, i16* %2213, align 2, !dbg !432
  br label %2219, !dbg !432

2219:                                             ; preds = %2217, %2218, %2088, %2068, %2107, %2118, %2036, %2037
  call void @llvm.stackrestore(i8* %1967), !dbg !433
  %2220 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %1976, i32 0, i32 1, !dbg !638
  %2221 = load i16, i16* %2220, align 2, !dbg !582
  %2222 = and i16 %2221, 36, !dbg !585
  %2223 = icmp ne i16 %2222, 0, !dbg !586
  br i1 %2223, label %2224, label %2225, !dbg !587

2224:                                             ; preds = %2219
  call void @sqlite3VdbeMemRealify(%struct.sqlite3_value* %1976), !dbg !588
  br label %2225, !dbg !589

2225:                                             ; preds = %2224, %2219
  %2226 = call i8* @llvm.stacksave(), !dbg !639
  %2227 = alloca i16, align 2, !dbg !642
  %2228 = load i16, i16* %2220, align 2, !dbg !643
  %2229 = and i16 %2228, 44, !dbg !646
  %2230 = icmp ne i16 %2229, 0, !dbg !647
  br i1 %2230, label %2231, label %2232, !dbg !648

2231:                                             ; preds = %2225
  store i16 %2229, i16* %2227, align 2, !dbg !642
  br label %2238, !dbg !649

2232:                                             ; preds = %2225
  %2233 = and i16 %2228, 18, !dbg !642
  %2234 = icmp ne i16 %2233, 0, !dbg !650
  br i1 %2234, label %2235, label %2237, !dbg !651

2235:                                             ; preds = %2232
  %2236 = call i16 @computeNumericType(%struct.sqlite3_value* %1976), !dbg !652
  br label %2238, !dbg !653

2237:                                             ; preds = %2232
  store i16 0, i16* %2227, align 2, !dbg !642
  br label %2238, !dbg !654

2238:                                             ; preds = %2235, %2237, %2231
  %2239 = load i16, i16* %2227, align 2, !dbg !642
  %2240 = alloca i16, align 2, !dbg !655
  %2241 = load i16, i16* %1961, align 2, !dbg !643
  %2242 = and i16 %2241, 44, !dbg !646
  %2243 = icmp ne i16 %2242, 0, !dbg !647
  br i1 %2243, label %2244, label %2245, !dbg !648

2244:                                             ; preds = %2238
  store i16 %2242, i16* %2240, align 2, !dbg !655
  br label %2251, !dbg !649

2245:                                             ; preds = %2238
  %2246 = and i16 %2241, 18, !dbg !655
  %2247 = icmp ne i16 %2246, 0, !dbg !650
  br i1 %2247, label %2248, label %2250, !dbg !651

2248:                                             ; preds = %2245
  %2249 = call i16 @computeNumericType(%struct.sqlite3_value* %1717), !dbg !652
  br label %2251, !dbg !653

2250:                                             ; preds = %2245
  store i16 0, i16* %2240, align 2, !dbg !655
  br label %2251, !dbg !654

2251:                                             ; preds = %2248, %2250, %2244
  %2252 = load i16, i16* %2240, align 2, !dbg !655
  %2253 = load i16, i16* %2220, align 2, !dbg !656
  %2254 = load i16, i16* %1961, align 2, !dbg !657
  %2255 = or i16 %2253, %2254, !dbg !658
  %2256 = and i16 %2239, %2252, !dbg !659
  %2257 = and i16 %2256, 4, !dbg !660
  %2258 = icmp ne i16 %2257, 0, !dbg !661
  br i1 %2258, label %2259, label %2276, !dbg !662

2259:                                             ; preds = %2251
  %2260 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %1976, i32 0, i32 0, !dbg !663
  %2261 = bitcast %union.MemValue* %2260 to i64*, !dbg !664
  %2262 = load i64, i64* %2261, align 4, !dbg !665
  %2263 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %1717, i32 0, i32 0, !dbg !666
  %2264 = bitcast %union.MemValue* %2263 to i64*, !dbg !667
  %2265 = load i64, i64* %2264, align 4, !dbg !668
  %2266 = alloca i64, align 8, !dbg !669
  store i64 %2265, i64* %2266, align 4, !dbg !670
  %2267 = call i32 @sqlite3MulInt64(i64* %2266, i64 %2262), !dbg !671
  %2268 = icmp eq i32 %2267, 0, !dbg !672
  br i1 %2268, label %2269, label %2279, !dbg !673

2269:                                             ; preds = %2259
  %2270 = load i64, i64* %2266, align 4, !dbg !674
  %2271 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %105, i32 0, i32 0, !dbg !675
  %2272 = bitcast %union.MemValue* %2271 to i64*, !dbg !676
  store i64 %2270, i64* %2272, align 4, !dbg !677
  %2273 = load i16, i16* %436, align 2, !dbg !678
  %2274 = and i16 %2273, 15936, !dbg !678
  %2275 = or i16 %2274, 4, !dbg !678
  store i16 %2275, i16* %436, align 2, !dbg !678
  br label %2297, !dbg !679

2276:                                             ; preds = %2251
  %2277 = and i16 %2255, 1, !dbg !680
  %2278 = icmp ne i16 %2277, 0, !dbg !681
  br i1 %2278, label %2291, label %2279, !dbg !682

2279:                                             ; preds = %2276, %2259
  %2280 = call double @sqlite3VdbeRealValue(%struct.sqlite3_value* %1976), !dbg !683
  %2281 = call double @sqlite3VdbeRealValue(%struct.sqlite3_value* %1717), !dbg !684
  %2282 = fmul double %2281, %2280, !dbg !685
  %2283 = call i32 @sqlite3IsNaN(double %2282), !dbg !686
  %2284 = icmp ne i32 %2283, 0, !dbg !687
  br i1 %2284, label %2291, label %2285, !dbg !688

2285:                                             ; preds = %2279
  %2286 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %105, i32 0, i32 0, !dbg !689
  %2287 = bitcast %union.MemValue* %2286 to double*, !dbg !690
  store double %2282, double* %2287, align 8, !dbg !691
  %2288 = load i16, i16* %436, align 2, !dbg !678
  %2289 = and i16 %2288, 15936, !dbg !678
  %2290 = or i16 %2289, 8, !dbg !678
  store i16 %2290, i16* %436, align 2, !dbg !678
  br label %2297, !dbg !692

2291:                                             ; preds = %2276, %2279
  %2292 = load i16, i16* %436, align 2, !dbg !693
  %2293 = and i16 %2292, 9216, !dbg !693
  %2294 = icmp ne i16 %2293, 0, !dbg !693
  br i1 %2294, label %2295, label %2296, !dbg !693

2295:                                             ; preds = %2291
  call void @vdbeMemClearExternAndSetNull(%struct.sqlite3_value* %105), !dbg !693
  br label %2297, !dbg !693

2296:                                             ; preds = %2291
  store i16 1, i16* %436, align 2, !dbg !693
  br label %2297, !dbg !693

2297:                                             ; preds = %2295, %2296, %2269, %2285
  call void @llvm.stackrestore(i8* %2226), !dbg !694
  %2298 = call i8* @llvm.stacksave(), !dbg !695
  %2299 = alloca i32, align 8, !dbg !698
  store i32 0, i32* %2299, align 4, !dbg !699
  %2300 = getelementptr %struct.VdbeOp, %struct.VdbeOp* %11, i32 26, i32 1, !dbg !700
  %2301 = load i8, i8* %2300, align 1, !dbg !701
  %2302 = icmp eq i8 %2301, -8, !dbg !702
  br i1 %2302, label %2303, label %2325, !dbg !703

2303:                                             ; preds = %2297
  %2304 = alloca %struct.sqlite3_context*, align 8, !dbg !704
  %2305 = call i8* @sqlite3DbMallocRawNN(%struct.sqlite3* %13, i64 112), !dbg !705
  %2306 = bitcast i8* %2305 to %struct.sqlite3_context*, !dbg !706
  store %struct.sqlite3_context* %2306, %struct.sqlite3_context** %2304, align 8, !dbg !707
  %2307 = ptrtoint %struct.sqlite3_context* %2306 to i64, !dbg !708
  %2308 = getelementptr %struct.sqlite3_context, %struct.sqlite3_context* %2306, i32 0, i32 0, !dbg !709
  %2309 = getelementptr %struct.sqlite3_context, %struct.sqlite3_context* %2306, i32 0, i32 1, !dbg !710
  %2310 = getelementptr %struct.sqlite3_context, %struct.sqlite3_context* %2306, i32 0, i32 2, !dbg !711
  %2311 = getelementptr %struct.sqlite3_context, %struct.sqlite3_context* %2306, i32 0, i32 3, !dbg !712
  %2312 = getelementptr %struct.sqlite3_context, %struct.sqlite3_context* %2306, i32 0, i32 4, !dbg !713
  %2313 = getelementptr %struct.sqlite3_context, %struct.sqlite3_context* %2306, i32 0, i32 5, !dbg !714
  %2314 = getelementptr %struct.sqlite3_context, %struct.sqlite3_context* %2306, i32 0, i32 6, !dbg !715
  %2315 = getelementptr %struct.sqlite3_context, %struct.sqlite3_context* %2306, i32 0, i32 7, !dbg !716
  %2316 = getelementptr %struct.sqlite3_context, %struct.sqlite3_context* %2306, i32 0, i32 8, !dbg !717
  %2317 = bitcast [1 x %struct.sqlite3_value*]* %2316 to %struct.sqlite3_value**, !dbg !718
  %2318 = getelementptr %struct.VdbeOp, %struct.VdbeOp* %11, i32 26, i32 6, i32 0, !dbg !719
  %2319 = getelementptr %struct.sqlite3_value*, %struct.sqlite3_value** %2317, i32 1, !dbg !720
  %2320 = bitcast %struct.sqlite3_value** %2319 to %struct.sqlite3_value*, !dbg !721
  call void @sqlite3VdbeMemInit(%struct.sqlite3_value* %2320, %struct.sqlite3* %13, i16 1), !dbg !722
  store %struct.sqlite3_value* null, %struct.sqlite3_value** %2310, align 8, !dbg !723
  store %struct.sqlite3_value* %2320, %struct.sqlite3_value** %2308, align 8, !dbg !724
  %2321 = getelementptr %struct.VdbeOp, %struct.VdbeOp* %11, i32 26, !dbg !725
  %2322 = getelementptr %struct.VdbeOp, %struct.VdbeOp* %2321, i32 0, i32 6, !dbg !726
  %2323 = bitcast %union.p4union* %2322 to %struct.FuncDef**, !dbg !727
  %2324 = load %struct.FuncDef*, %struct.FuncDef** %2323, align 8, !dbg !728
  store %struct.FuncDef* %2324, %struct.FuncDef** %2309, align 8, !dbg !729
  store i32 26, i32* %2312, align 4, !dbg !730
  store %struct.Vdbe* %0, %struct.Vdbe** %2311, align 8, !dbg !731
  store i8 0, i8* %2314, align 1, !dbg !732
  store i32 0, i32* %2313, align 4, !dbg !733
  store i8 1, i8* %2315, align 1, !dbg !734
  store i8 -16, i8* %2300, align 1, !dbg !735
  store i8* %2305, i8** %2318, align 8, !dbg !736
  br label %2325, !dbg !737

2325:                                             ; preds = %2303, %2297
  %2326 = getelementptr %struct.VdbeOp, %struct.VdbeOp* %11, i32 26, i32 6, i32 0, !dbg !738
  %2327 = bitcast i8** %2326 to %struct.sqlite3_context**, !dbg !739
  %2328 = load %struct.sqlite3_context*, %struct.sqlite3_context** %2327, align 8, !dbg !740
  %2329 = getelementptr %struct.sqlite3_context, %struct.sqlite3_context* %2328, i32 0, i32 0, !dbg !741
  %2330 = getelementptr %struct.sqlite3_context, %struct.sqlite3_context* %2328, i32 0, i32 1, !dbg !742
  %2331 = getelementptr %struct.sqlite3_context, %struct.sqlite3_context* %2328, i32 0, i32 5, !dbg !743
  %2332 = getelementptr %struct.sqlite3_context, %struct.sqlite3_context* %2328, i32 0, i32 6, !dbg !744
  %2333 = getelementptr %struct.sqlite3_context, %struct.sqlite3_context* %2328, i32 0, i32 7, !dbg !745
  %2334 = getelementptr %struct.sqlite3_context, %struct.sqlite3_context* %2328, i32 0, i32 8, !dbg !746
  %2335 = bitcast [1 x %struct.sqlite3_value*]* %2334 to %struct.sqlite3_value**, !dbg !747
  %2336 = alloca i32, align 8, !dbg !748
  %2337 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %7, i32 1, !dbg !749
  %2338 = getelementptr %struct.sqlite3_context, %struct.sqlite3_context* %2328, i32 0, i32 2, !dbg !750
  %2339 = load %struct.sqlite3_value*, %struct.sqlite3_value** %2338, align 8, !dbg !751
  %2340 = icmp ne %struct.sqlite3_value* %2339, %2337, !dbg !752
  br i1 %2340, label %2341, label %2354, !dbg !753

2341:                                             ; preds = %2325
  store %struct.sqlite3_value* %2337, %struct.sqlite3_value** %2338, align 8, !dbg !754
  %2342 = load i8, i8* %2333, align 1, !dbg !755
  %2343 = zext i8 %2342 to i32, !dbg !756
  %2344 = add i32 %2343, -1, !dbg !757
  %2345 = alloca i32, align 8, !dbg !758
  store i32 %2344, i32* %2345, align 4, !dbg !759
  br label %2351, !dbg !760

2346:                                             ; preds = %2351
  %2347 = getelementptr %struct.sqlite3_value*, %struct.sqlite3_value** %2335, i32 %2352, !dbg !761
  %2348 = add i32 %2352, 4, !dbg !762
  %2349 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %7, i32 %2348, !dbg !763
  store %struct.sqlite3_value* %2349, %struct.sqlite3_value** %2347, align 8, !dbg !764
  %2350 = add i32 %2352, -1, !dbg !765
  store i32 %2350, i32* %2345, align 4, !dbg !766
  br label %2351, !dbg !767

2351:                                             ; preds = %2346, %2341
  %2352 = load i32, i32* %2345, align 4, !dbg !768
  %2353 = icmp sge i32 %2352, 0, !dbg !769
  br i1 %2353, label %2346, label %2354, !dbg !770

2354:                                             ; preds = %2351, %2325
  %2355 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %2337, i32 0, i32 4, !dbg !771
  %2356 = load i32, i32* %2355, align 4, !dbg !772
  %2357 = add i32 %2356, 1, !dbg !773
  store i32 %2357, i32* %2355, align 4, !dbg !774
  %2358 = load %struct.FuncDef*, %struct.FuncDef** %2330, align 8, !dbg !775
  %2359 = load i8, i8* %2333, align 1, !dbg !776
  %2360 = zext i8 %2359 to i32, !dbg !777
  %2361 = getelementptr %struct.FuncDef, %struct.FuncDef* %2358, i32 0, i32 4, !dbg !778
  %2362 = load void (%struct.sqlite3_context*, i32, %struct.sqlite3_value**)*, void (%struct.sqlite3_context*, i32, %struct.sqlite3_value**)** %2361, align 8, !dbg !779
  call void %2362(%struct.sqlite3_context* %2328, i32 %2360, %struct.sqlite3_value** %2335), !dbg !780
  %2363 = load i32, i32* %2331, align 4, !dbg !781
  %2364 = icmp ne i32 %2363, 0, !dbg !782
  br i1 %2364, label %2365, label %2379, !dbg !783

2365:                                             ; preds = %2354
  %2366 = icmp sgt i32 %2363, 0, !dbg !784
  br i1 %2366, label %2367, label %2371, !dbg !785

2367:                                             ; preds = %2365
  %2368 = load %struct.sqlite3_value*, %struct.sqlite3_value** %2329, align 8, !dbg !786
  %2369 = call i8* @sqlite3_value_text(%struct.sqlite3_value* %2368), !dbg !787
  call void (%struct.Vdbe*, i8*, ...) @sqlite3VdbeError(%struct.Vdbe* %0, i8* %3, i8* %2369), !dbg !788
  %2370 = load i32, i32* %2331, align 4, !dbg !789
  store i32 %2370, i32* %2299, align 4, !dbg !790
  br label %2371, !dbg !791

2371:                                             ; preds = %2367, %2365
  %2372 = load i8, i8* %2332, align 1, !dbg !792
  %2373 = icmp ne i8 %2372, 0, !dbg !793
  br i1 %2373, label %2374, label %2375, !dbg !794

2374:                                             ; preds = %2371
  store i32 14, i32* %2336, align 4, !dbg !795
  call void @sqlite3VdbeMemSetInt64(%struct.sqlite3_value* %1976, i64 1), !dbg !796
  store i8 0, i8* %2332, align 1, !dbg !797
  br label %2375, !dbg !798

2375:                                             ; preds = %2374, %2371
  %2376 = load %struct.sqlite3_value*, %struct.sqlite3_value** %2329, align 8, !dbg !799
  call void @sqlite3VdbeMemRelease(%struct.sqlite3_value* %2376), !dbg !800
  %2377 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %2376, i32 0, i32 1, !dbg !801
  store i16 1, i16* %2377, align 2, !dbg !802
  store i32 0, i32* %2331, align 4, !dbg !803
  %2378 = load i32, i32* %2299, align 4, !dbg !804
  br label %2379, !dbg !805

2379:                                             ; preds = %2354, %2375
  call void @llvm.stackrestore(i8* %2298), !dbg !806
  br label %2380, !dbg !807

2380:                                             ; preds = %2379, %1704, %1613, %1348, %1254, %1238, %1147, %877, %843, %476, %442, %5
  %2381 = load %struct.VdbeCursor*, %struct.VdbeCursor** %9, align 8, !dbg !808
  %2382 = ptrtoint %struct.VdbeCursor* %2381 to i64, !dbg !811
  %2383 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %2381, i32 0, i32 12, i32 0, !dbg !812
  %2384 = load %struct.BtCursor*, %struct.BtCursor** %2383, align 8, !dbg !813
  %2385 = call i32 @sqlite3BtreeNext(%struct.BtCursor* %2384, i32 0), !dbg !814
  %2386 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %2381, i32 0, i32 2, !dbg !815
  %2387 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %2381, i32 0, i32 9, !dbg !816
  store i32 0, i32* %2387, align 4, !dbg !817
  %2388 = icmp eq i32 %2385, 0, !dbg !818
  br i1 %2388, label %2389, label %2390, !dbg !819

2389:                                             ; preds = %2380
  store i8 0, i8* %2386, align 1, !dbg !820
  br label %94, !dbg !821

2390:                                             ; preds = %2380
  store i8 1, i8* %2386, align 1, !dbg !822
  br label %2391, !dbg !823

2391:                                             ; preds = %2390, %88
  %2392 = getelementptr %struct.VdbeOp, %struct.VdbeOp* %11, i32 28, !dbg !824
  %2393 = getelementptr %struct.VdbeOp, %struct.VdbeOp* %2392, i32 0, i32 6, !dbg !827
  %2394 = bitcast %union.p4union* %2393 to %struct.FuncDef**, !dbg !828
  %2395 = load %struct.FuncDef*, %struct.FuncDef** %2394, align 8, !dbg !829
  %2396 = call i8* @llvm.stacksave(), !dbg !830
  %2397 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %7, i32 1, !dbg !831
  %2398 = alloca i32, align 8, !dbg !832
  %2399 = call i32 @sqlite3VdbeMemFinalize(%struct.sqlite3_value* %2397, %struct.FuncDef* %2395), !dbg !833
  store i32 %2399, i32* %2398, align 4, !dbg !834
  %2400 = call i32 @sqlite3VdbeChangeEncoding(%struct.sqlite3_value* %2397, i32 1), !dbg !835
  %2401 = call i32 @sqlite3VdbeMemTooBig(%struct.sqlite3_value* %2397), !dbg !836
  call void @llvm.stackrestore(i8* %2396), !dbg !837
  %2402 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %7, i32 15, !dbg !838
  call void @sqlite3VdbeMemShallowCopy(%struct.sqlite3_value* %2402, %struct.sqlite3_value* %2397, i32 4096), !dbg !841
  %2403 = call i8* @llvm.stacksave(), !dbg !842
  %2404 = call i32 @sqlite3VdbeCheckFk(%struct.Vdbe* %0, i32 0), !dbg !845
  %2405 = call i32 @sqlite3VdbeCloseStatement(%struct.Vdbe* %0, i32 1), !dbg !846
  %2406 = getelementptr %struct.Vdbe, %struct.Vdbe* %0, i32 0, i32 9, !dbg !847
  %2407 = load i32, i32* %2406, align 4, !dbg !848
  %2408 = add i32 %2407, 2, !dbg !849
  %2409 = or i32 %2408, 1, !dbg !850
  store i32 %2409, i32* %2406, align 4, !dbg !851
  %2410 = getelementptr %struct.Vdbe, %struct.Vdbe* %0, i32 0, i32 27, !dbg !852
  store %struct.sqlite3_value* %2402, %struct.sqlite3_value** %2410, align 8, !dbg !853
  %2411 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %2402, i32 1, !dbg !854
  %2412 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %2411, i32 0, i32 1, !dbg !855
  %2413 = load i16, i16* %2412, align 2, !dbg !856
  %2414 = and i16 %2413, 4096, !dbg !857
  %2415 = icmp ne i16 %2414, 0, !dbg !858
  br i1 %2415, label %2416, label %2418, !dbg !859

2416:                                             ; preds = %2391
  %2417 = call i32 @sqlite3VdbeMemMakeWriteable(%struct.sqlite3_value* %2411), !dbg !860
  br label %2418, !dbg !861

2418:                                             ; preds = %2416, %2391
  call void @sqlite3VdbeMemNulTerminate(%struct.sqlite3_value* %2411), !dbg !862
  %2419 = load %struct.sqlite3*, %struct.sqlite3** %12, align 8, !dbg !863
  %2420 = getelementptr %struct.sqlite3, %struct.sqlite3* %2419, i32 0, i32 19, !dbg !864
  %2421 = load i8, i8* %2420, align 1, !dbg !865
  store i32 31, i32* %14, align 4, !dbg !866
  call void @llvm.stackrestore(i8* %2403), !dbg !867
  ret i32 100, !dbg !868

2422:                                             ; preds = %5
  %2423 = call i32 @sqlite3VdbeHalt(%struct.Vdbe* %0), !dbg !869
  ret i32 101, !dbg !872

2424:                                             ; preds = %16
  %2425 = call i32 @sqlite3BtreeBeginTrans(%struct.Btree* %26, i32 0, i32* %28), !dbg !873
  store i32 %2425, i32* %29, align 4, !dbg !874
  br label %2426, !dbg !875

2426:                                             ; preds = %2424, %16
  %2427 = load i32, i32* %28, align 4, !dbg !876
  %2428 = icmp ne i32 %2427, 8, !dbg !877
  %2429 = getelementptr %struct.Db, %struct.Db* %24, i32 0, i32 4, !dbg !878
  %2430 = load %struct.Schema*, %struct.Schema** %2429, align 8, !dbg !879
  %2431 = getelementptr %struct.Schema, %struct.Schema* %2430, i32 0, i32 1, !dbg !880
  %2432 = load i32, i32* %2431, align 4, !dbg !881
  %2433 = icmp ne i32 %2432, 0, !dbg !882
  %2434 = or i1 %2433, %2428, !dbg !883
  %2435 = load i32, i32* %29, align 4, !dbg !884
  call void @llvm.stackrestore(i8* %22), !dbg !885
  %2436 = getelementptr %struct.VdbeOp, %struct.VdbeOp* %11, i32 33, !dbg !886
  %2437 = getelementptr %struct.VdbeOp, %struct.VdbeOp* %2436, i32 0, i32 6, !dbg !889
  %2438 = bitcast %union.p4union* %2437 to double**, !dbg !890
  %2439 = load double*, double** %2438, align 8, !dbg !891
  %2440 = load double, double* %2439, align 8, !dbg !892
  %2441 = call i8* @llvm.stacksave(), !dbg !893
  %2442 = getelementptr %struct.VdbeOp, %struct.VdbeOp* %2436, i32 0, i32 4, !dbg !456
  %2443 = load i32, i32* %2442, align 4, !dbg !459
  %2444 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %7, i32 %2443, !dbg !460
  %2445 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %2444, i32 0, i32 1, !dbg !893
  %2446 = load i16, i16* %2445, align 2, !dbg !893
  %2447 = and i16 %2446, 9216, !dbg !893
  %2448 = icmp ne i16 %2447, 0, !dbg !893
  %2449 = alloca %struct.sqlite3_value*, align 8, !dbg !893
  br i1 %2448, label %2450, label %2452, !dbg !893

2450:                                             ; preds = %2426
  %2451 = call %struct.sqlite3_value* @out2PrereleaseWithClear(%struct.sqlite3_value* %2444), !dbg !893
  store %struct.sqlite3_value* %2451, %struct.sqlite3_value** %2449, align 8, !dbg !893
  br label %2453, !dbg !893

2452:                                             ; preds = %2426
  store i16 4, i16* %2445, align 2, !dbg !893
  store %struct.sqlite3_value* %2444, %struct.sqlite3_value** %2449, align 8, !dbg !893
  br label %2453, !dbg !893

2453:                                             ; preds = %2452, %2450
  %2454 = load %struct.sqlite3_value*, %struct.sqlite3_value** %2449, align 8, !dbg !893
  call void @llvm.stackrestore(i8* %2441), !dbg !893
  %2455 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %2454, i32 0, i32 1, !dbg !894
  store i16 8, i16* %2455, align 2, !dbg !895
  %2456 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %2454, i32 0, i32 0, i32 0, !dbg !896
  store double %2440, double* %2456, align 8, !dbg !897
  %2457 = getelementptr %struct.VdbeOp, %struct.VdbeOp* %11, i32 34, !dbg !886
  %2458 = getelementptr %struct.VdbeOp, %struct.VdbeOp* %2457, i32 0, i32 6, !dbg !889
  %2459 = bitcast %union.p4union* %2458 to double**, !dbg !890
  %2460 = load double*, double** %2459, align 8, !dbg !891
  %2461 = load double, double* %2460, align 8, !dbg !892
  %2462 = call i8* @llvm.stacksave(), !dbg !893
  %2463 = getelementptr %struct.VdbeOp, %struct.VdbeOp* %2457, i32 0, i32 4, !dbg !456
  %2464 = load i32, i32* %2463, align 4, !dbg !459
  %2465 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %7, i32 %2464, !dbg !460
  %2466 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %2465, i32 0, i32 1, !dbg !893
  %2467 = load i16, i16* %2466, align 2, !dbg !893
  %2468 = and i16 %2467, 9216, !dbg !893
  %2469 = icmp ne i16 %2468, 0, !dbg !893
  %2470 = alloca %struct.sqlite3_value*, align 8, !dbg !893
  br i1 %2469, label %2471, label %2473, !dbg !893

2471:                                             ; preds = %2453
  %2472 = call %struct.sqlite3_value* @out2PrereleaseWithClear(%struct.sqlite3_value* %2465), !dbg !893
  store %struct.sqlite3_value* %2472, %struct.sqlite3_value** %2470, align 8, !dbg !893
  br label %2474, !dbg !893

2473:                                             ; preds = %2453
  store i16 4, i16* %2466, align 2, !dbg !893
  store %struct.sqlite3_value* %2465, %struct.sqlite3_value** %2470, align 8, !dbg !893
  br label %2474, !dbg !893

2474:                                             ; preds = %2473, %2471
  %2475 = load %struct.sqlite3_value*, %struct.sqlite3_value** %2470, align 8, !dbg !893
  call void @llvm.stackrestore(i8* %2462), !dbg !893
  %2476 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %2475, i32 0, i32 1, !dbg !894
  store i16 8, i16* %2476, align 2, !dbg !895
  %2477 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %2475, i32 0, i32 0, i32 0, !dbg !896
  store double %2461, double* %2477, align 8, !dbg !897
  %2478 = call i8* @llvm.stacksave(), !dbg !639
  %2479 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %7, i32 14, !dbg !898
  %2480 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %7, i32 4, !dbg !899
  %2481 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %7, i32 11, !dbg !900
  %2482 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %2481, i32 0, i32 1, !dbg !901
  %2483 = alloca i16, align 2, !dbg !642
  %2484 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %2479, i32 0, i32 1, !dbg !902
  %2485 = load i16, i16* %2484, align 2, !dbg !643
  %2486 = and i16 %2485, 44, !dbg !646
  %2487 = icmp ne i16 %2486, 0, !dbg !647
  br i1 %2487, label %2488, label %2489, !dbg !648

2488:                                             ; preds = %2474
  store i16 %2486, i16* %2483, align 2, !dbg !642
  br label %2495, !dbg !649

2489:                                             ; preds = %2474
  %2490 = and i16 %2485, 18, !dbg !642
  %2491 = icmp ne i16 %2490, 0, !dbg !650
  br i1 %2491, label %2492, label %2494, !dbg !651

2492:                                             ; preds = %2489
  %2493 = call i16 @computeNumericType(%struct.sqlite3_value* %2479), !dbg !652
  br label %2495, !dbg !653

2494:                                             ; preds = %2489
  store i16 0, i16* %2483, align 2, !dbg !642
  br label %2495, !dbg !654

2495:                                             ; preds = %2492, %2494, %2488
  %2496 = load i16, i16* %2483, align 2, !dbg !642
  %2497 = alloca i16, align 2, !dbg !655
  %2498 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %2480, i32 0, i32 1, !dbg !902
  %2499 = load i16, i16* %2498, align 2, !dbg !643
  %2500 = and i16 %2499, 44, !dbg !646
  %2501 = icmp ne i16 %2500, 0, !dbg !647
  br i1 %2501, label %2502, label %2503, !dbg !648

2502:                                             ; preds = %2495
  store i16 %2500, i16* %2497, align 2, !dbg !655
  br label %2509, !dbg !649

2503:                                             ; preds = %2495
  %2504 = and i16 %2499, 18, !dbg !655
  %2505 = icmp ne i16 %2504, 0, !dbg !650
  br i1 %2505, label %2506, label %2508, !dbg !651

2506:                                             ; preds = %2503
  %2507 = call i16 @computeNumericType(%struct.sqlite3_value* %2480), !dbg !652
  br label %2509, !dbg !653

2508:                                             ; preds = %2503
  store i16 0, i16* %2497, align 2, !dbg !655
  br label %2509, !dbg !654

2509:                                             ; preds = %2506, %2508, %2502
  %2510 = load i16, i16* %2497, align 2, !dbg !655
  %2511 = load i16, i16* %2484, align 2, !dbg !656
  %2512 = load i16, i16* %2498, align 2, !dbg !657
  %2513 = or i16 %2511, %2512, !dbg !658
  %2514 = and i16 %2496, %2510, !dbg !659
  %2515 = and i16 %2514, 4, !dbg !660
  %2516 = icmp ne i16 %2515, 0, !dbg !661
  br i1 %2516, label %2517, label %2534, !dbg !662

2517:                                             ; preds = %2509
  %2518 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %2479, i32 0, i32 0, !dbg !663
  %2519 = bitcast %union.MemValue* %2518 to i64*, !dbg !664
  %2520 = load i64, i64* %2519, align 4, !dbg !665
  %2521 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %2480, i32 0, i32 0, !dbg !666
  %2522 = bitcast %union.MemValue* %2521 to i64*, !dbg !667
  %2523 = load i64, i64* %2522, align 4, !dbg !668
  %2524 = alloca i64, align 8, !dbg !669
  store i64 %2523, i64* %2524, align 4, !dbg !670
  %2525 = call i32 @sqlite3SubInt64(i64* %2524, i64 %2520), !dbg !903
  %2526 = icmp eq i32 %2525, 0, !dbg !904
  br i1 %2526, label %2527, label %2537, !dbg !905

2527:                                             ; preds = %2517
  %2528 = load i64, i64* %2524, align 4, !dbg !674
  %2529 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %2481, i32 0, i32 0, !dbg !675
  %2530 = bitcast %union.MemValue* %2529 to i64*, !dbg !676
  store i64 %2528, i64* %2530, align 4, !dbg !677
  %2531 = load i16, i16* %2482, align 2, !dbg !678
  %2532 = and i16 %2531, 15936, !dbg !678
  %2533 = or i16 %2532, 4, !dbg !678
  store i16 %2533, i16* %2482, align 2, !dbg !678
  br label %2555, !dbg !679

2534:                                             ; preds = %2509
  %2535 = and i16 %2513, 1, !dbg !680
  %2536 = icmp ne i16 %2535, 0, !dbg !681
  br i1 %2536, label %2549, label %2537, !dbg !682

2537:                                             ; preds = %2534, %2517
  %2538 = call double @sqlite3VdbeRealValue(%struct.sqlite3_value* %2479), !dbg !683
  %2539 = call double @sqlite3VdbeRealValue(%struct.sqlite3_value* %2480), !dbg !684
  %2540 = fsub double %2539, %2538, !dbg !906
  %2541 = call i32 @sqlite3IsNaN(double %2540), !dbg !686
  %2542 = icmp ne i32 %2541, 0, !dbg !687
  br i1 %2542, label %2549, label %2543, !dbg !688

2543:                                             ; preds = %2537
  %2544 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %2481, i32 0, i32 0, !dbg !689
  %2545 = bitcast %union.MemValue* %2544 to double*, !dbg !690
  store double %2540, double* %2545, align 8, !dbg !691
  %2546 = load i16, i16* %2482, align 2, !dbg !678
  %2547 = and i16 %2546, 15936, !dbg !678
  %2548 = or i16 %2547, 8, !dbg !678
  store i16 %2548, i16* %2482, align 2, !dbg !678
  br label %2555, !dbg !692

2549:                                             ; preds = %2534, %2537
  %2550 = load i16, i16* %2482, align 2, !dbg !693
  %2551 = and i16 %2550, 9216, !dbg !693
  %2552 = icmp ne i16 %2551, 0, !dbg !693
  br i1 %2552, label %2553, label %2554, !dbg !693

2553:                                             ; preds = %2549
  call void @vdbeMemClearExternAndSetNull(%struct.sqlite3_value* %2481), !dbg !693
  br label %2555, !dbg !693

2554:                                             ; preds = %2549
  store i16 1, i16* %2482, align 2, !dbg !693
  br label %2555, !dbg !693

2555:                                             ; preds = %2553, %2554, %2527, %2543
  call void @llvm.stackrestore(i8* %2478), !dbg !694
  %2556 = getelementptr %struct.VdbeOp, %struct.VdbeOp* %11, i32 36, !dbg !886
  %2557 = getelementptr %struct.VdbeOp, %struct.VdbeOp* %2556, i32 0, i32 6, !dbg !889
  %2558 = bitcast %union.p4union* %2557 to double**, !dbg !890
  %2559 = load double*, double** %2558, align 8, !dbg !891
  %2560 = load double, double* %2559, align 8, !dbg !892
  %2561 = call i8* @llvm.stacksave(), !dbg !893
  %2562 = getelementptr %struct.VdbeOp, %struct.VdbeOp* %2556, i32 0, i32 4, !dbg !456
  %2563 = load i32, i32* %2562, align 4, !dbg !459
  %2564 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %7, i32 %2563, !dbg !460
  %2565 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %2564, i32 0, i32 1, !dbg !893
  %2566 = load i16, i16* %2565, align 2, !dbg !893
  %2567 = and i16 %2566, 9216, !dbg !893
  %2568 = icmp ne i16 %2567, 0, !dbg !893
  %2569 = alloca %struct.sqlite3_value*, align 8, !dbg !893
  br i1 %2568, label %2570, label %2572, !dbg !893

2570:                                             ; preds = %2555
  %2571 = call %struct.sqlite3_value* @out2PrereleaseWithClear(%struct.sqlite3_value* %2564), !dbg !893
  store %struct.sqlite3_value* %2571, %struct.sqlite3_value** %2569, align 8, !dbg !893
  br label %2573, !dbg !893

2572:                                             ; preds = %2555
  store i16 4, i16* %2565, align 2, !dbg !893
  store %struct.sqlite3_value* %2564, %struct.sqlite3_value** %2569, align 8, !dbg !893
  br label %2573, !dbg !893

2573:                                             ; preds = %2572, %2570
  %2574 = load %struct.sqlite3_value*, %struct.sqlite3_value** %2569, align 8, !dbg !893
  call void @llvm.stackrestore(i8* %2561), !dbg !893
  %2575 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %2574, i32 0, i32 1, !dbg !894
  store i16 8, i16* %2575, align 2, !dbg !895
  %2576 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %2574, i32 0, i32 0, i32 0, !dbg !896
  store double %2560, double* %2576, align 8, !dbg !897
  %2577 = getelementptr %struct.VdbeOp, %struct.VdbeOp* %11, i32 37, !dbg !886
  %2578 = getelementptr %struct.VdbeOp, %struct.VdbeOp* %2577, i32 0, i32 6, !dbg !889
  %2579 = bitcast %union.p4union* %2578 to double**, !dbg !890
  %2580 = load double*, double** %2579, align 8, !dbg !891
  %2581 = load double, double* %2580, align 8, !dbg !892
  %2582 = call i8* @llvm.stacksave(), !dbg !893
  %2583 = getelementptr %struct.VdbeOp, %struct.VdbeOp* %2577, i32 0, i32 4, !dbg !456
  %2584 = load i32, i32* %2583, align 4, !dbg !459
  %2585 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %7, i32 %2584, !dbg !460
  %2586 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %2585, i32 0, i32 1, !dbg !893
  %2587 = load i16, i16* %2586, align 2, !dbg !893
  %2588 = and i16 %2587, 9216, !dbg !893
  %2589 = icmp ne i16 %2588, 0, !dbg !893
  %2590 = alloca %struct.sqlite3_value*, align 8, !dbg !893
  br i1 %2589, label %2591, label %2593, !dbg !893

2591:                                             ; preds = %2573
  %2592 = call %struct.sqlite3_value* @out2PrereleaseWithClear(%struct.sqlite3_value* %2585), !dbg !893
  store %struct.sqlite3_value* %2592, %struct.sqlite3_value** %2590, align 8, !dbg !893
  br label %2594, !dbg !893

2593:                                             ; preds = %2573
  store i16 4, i16* %2586, align 2, !dbg !893
  store %struct.sqlite3_value* %2585, %struct.sqlite3_value** %2590, align 8, !dbg !893
  br label %2594, !dbg !893

2594:                                             ; preds = %2593, %2591
  %2595 = load %struct.sqlite3_value*, %struct.sqlite3_value** %2590, align 8, !dbg !893
  call void @llvm.stackrestore(i8* %2582), !dbg !893
  %2596 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %2595, i32 0, i32 1, !dbg !894
  store i16 8, i16* %2596, align 2, !dbg !895
  %2597 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %2595, i32 0, i32 0, i32 0, !dbg !896
  store double %2581, double* %2597, align 8, !dbg !897
  %2598 = call i8* @llvm.stacksave(), !dbg !639
  %2599 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %7, i32 12, !dbg !900
  %2600 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %2599, i32 0, i32 1, !dbg !901
  %2601 = alloca i16, align 2, !dbg !642
  %2602 = load i16, i16* %2498, align 2, !dbg !643
  %2603 = and i16 %2602, 44, !dbg !646
  %2604 = icmp ne i16 %2603, 0, !dbg !647
  br i1 %2604, label %2605, label %2606, !dbg !648

2605:                                             ; preds = %2594
  store i16 %2603, i16* %2601, align 2, !dbg !642
  br label %2612, !dbg !649

2606:                                             ; preds = %2594
  %2607 = and i16 %2602, 18, !dbg !642
  %2608 = icmp ne i16 %2607, 0, !dbg !650
  br i1 %2608, label %2609, label %2611, !dbg !651

2609:                                             ; preds = %2606
  %2610 = call i16 @computeNumericType(%struct.sqlite3_value* %2480), !dbg !652
  br label %2612, !dbg !653

2611:                                             ; preds = %2606
  store i16 0, i16* %2601, align 2, !dbg !642
  br label %2612, !dbg !654

2612:                                             ; preds = %2609, %2611, %2605
  %2613 = load i16, i16* %2601, align 2, !dbg !642
  %2614 = alloca i16, align 2, !dbg !655
  %2615 = load i16, i16* %2484, align 2, !dbg !643
  %2616 = and i16 %2615, 44, !dbg !646
  %2617 = icmp ne i16 %2616, 0, !dbg !647
  br i1 %2617, label %2618, label %2619, !dbg !648

2618:                                             ; preds = %2612
  store i16 %2616, i16* %2614, align 2, !dbg !655
  br label %2625, !dbg !649

2619:                                             ; preds = %2612
  %2620 = and i16 %2615, 18, !dbg !655
  %2621 = icmp ne i16 %2620, 0, !dbg !650
  br i1 %2621, label %2622, label %2624, !dbg !651

2622:                                             ; preds = %2619
  %2623 = call i16 @computeNumericType(%struct.sqlite3_value* %2479), !dbg !652
  br label %2625, !dbg !653

2624:                                             ; preds = %2619
  store i16 0, i16* %2614, align 2, !dbg !655
  br label %2625, !dbg !654

2625:                                             ; preds = %2622, %2624, %2618
  %2626 = load i16, i16* %2614, align 2, !dbg !655
  %2627 = load i16, i16* %2498, align 2, !dbg !656
  %2628 = load i16, i16* %2484, align 2, !dbg !657
  %2629 = or i16 %2627, %2628, !dbg !658
  %2630 = and i16 %2613, %2626, !dbg !659
  %2631 = and i16 %2630, 4, !dbg !660
  %2632 = icmp ne i16 %2631, 0, !dbg !661
  br i1 %2632, label %2633, label %2650, !dbg !662

2633:                                             ; preds = %2625
  %2634 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %2480, i32 0, i32 0, !dbg !663
  %2635 = bitcast %union.MemValue* %2634 to i64*, !dbg !664
  %2636 = load i64, i64* %2635, align 4, !dbg !665
  %2637 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %2479, i32 0, i32 0, !dbg !666
  %2638 = bitcast %union.MemValue* %2637 to i64*, !dbg !667
  %2639 = load i64, i64* %2638, align 4, !dbg !668
  %2640 = alloca i64, align 8, !dbg !669
  store i64 %2639, i64* %2640, align 4, !dbg !670
  %2641 = call i32 @sqlite3AddInt64(i64* %2640, i64 %2636), !dbg !907
  %2642 = icmp eq i32 %2641, 0, !dbg !908
  br i1 %2642, label %2643, label %2653, !dbg !909

2643:                                             ; preds = %2633
  %2644 = load i64, i64* %2640, align 4, !dbg !674
  %2645 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %2599, i32 0, i32 0, !dbg !675
  %2646 = bitcast %union.MemValue* %2645 to i64*, !dbg !676
  store i64 %2644, i64* %2646, align 4, !dbg !677
  %2647 = load i16, i16* %2600, align 2, !dbg !678
  %2648 = and i16 %2647, 15936, !dbg !678
  %2649 = or i16 %2648, 4, !dbg !678
  store i16 %2649, i16* %2600, align 2, !dbg !678
  br label %2671, !dbg !679

2650:                                             ; preds = %2625
  %2651 = and i16 %2629, 1, !dbg !680
  %2652 = icmp ne i16 %2651, 0, !dbg !681
  br i1 %2652, label %2665, label %2653, !dbg !682

2653:                                             ; preds = %2650, %2633
  %2654 = call double @sqlite3VdbeRealValue(%struct.sqlite3_value* %2480), !dbg !683
  %2655 = call double @sqlite3VdbeRealValue(%struct.sqlite3_value* %2479), !dbg !684
  %2656 = fadd double %2655, %2654, !dbg !910
  %2657 = call i32 @sqlite3IsNaN(double %2656), !dbg !686
  %2658 = icmp ne i32 %2657, 0, !dbg !687
  br i1 %2658, label %2665, label %2659, !dbg !688

2659:                                             ; preds = %2653
  %2660 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %2599, i32 0, i32 0, !dbg !689
  %2661 = bitcast %union.MemValue* %2660 to double*, !dbg !690
  store double %2656, double* %2661, align 8, !dbg !691
  %2662 = load i16, i16* %2600, align 2, !dbg !678
  %2663 = and i16 %2662, 15936, !dbg !678
  %2664 = or i16 %2663, 8, !dbg !678
  store i16 %2664, i16* %2600, align 2, !dbg !678
  br label %2671, !dbg !692

2665:                                             ; preds = %2650, %2653
  %2666 = load i16, i16* %2600, align 2, !dbg !693
  %2667 = and i16 %2666, 9216, !dbg !693
  %2668 = icmp ne i16 %2667, 0, !dbg !693
  br i1 %2668, label %2669, label %2670, !dbg !693

2669:                                             ; preds = %2665
  call void @vdbeMemClearExternAndSetNull(%struct.sqlite3_value* %2599), !dbg !693
  br label %2671, !dbg !693

2670:                                             ; preds = %2665
  store i16 1, i16* %2600, align 2, !dbg !693
  br label %2671, !dbg !693

2671:                                             ; preds = %2669, %2670, %2643, %2659
  call void @llvm.stackrestore(i8* %2598), !dbg !694
  %2672 = getelementptr %struct.VdbeOp, %struct.VdbeOp* %11, i32 39, !dbg !911
  %2673 = call i8* @llvm.stacksave(), !dbg !914
  %2674 = getelementptr %struct.VdbeOp, %struct.VdbeOp* %2672, i32 0, i32 4, !dbg !456
  %2675 = load i32, i32* %2674, align 4, !dbg !459
  %2676 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %7, i32 %2675, !dbg !460
  %2677 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %2676, i32 0, i32 1, !dbg !914
  %2678 = load i16, i16* %2677, align 2, !dbg !914
  %2679 = and i16 %2678, 9216, !dbg !914
  %2680 = icmp ne i16 %2679, 0, !dbg !914
  %2681 = alloca %struct.sqlite3_value*, align 8, !dbg !914
  br i1 %2680, label %2682, label %2684, !dbg !914

2682:                                             ; preds = %2671
  %2683 = call %struct.sqlite3_value* @out2PrereleaseWithClear(%struct.sqlite3_value* %2676), !dbg !914
  store %struct.sqlite3_value* %2683, %struct.sqlite3_value** %2681, align 8, !dbg !914
  br label %2685, !dbg !914

2684:                                             ; preds = %2671
  store i16 4, i16* %2677, align 2, !dbg !914
  store %struct.sqlite3_value* %2676, %struct.sqlite3_value** %2681, align 8, !dbg !914
  br label %2685, !dbg !914

2685:                                             ; preds = %2684, %2682
  %2686 = load %struct.sqlite3_value*, %struct.sqlite3_value** %2681, align 8, !dbg !914
  call void @llvm.stackrestore(i8* %2673), !dbg !914
  %2687 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %2686, i32 0, i32 0, i32 0, !dbg !915
  %2688 = bitcast double* %2687 to i64*, !dbg !916
  store i64 25, i64* %2688, align 4, !dbg !917
  %2689 = getelementptr %struct.VdbeOp, %struct.VdbeOp* %11, i32 1, !dbg !918
  %2690 = call i8* @llvm.stacksave(), !dbg !73
  %2691 = getelementptr %struct.VdbeOp, %struct.VdbeOp* %2689, i32 0, i32 4, !dbg !456
  %2692 = load i32, i32* %2691, align 4, !dbg !459
  %2693 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %7, i32 %2692, !dbg !460
  %2694 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %2693, i32 0, i32 1, !dbg !73
  %2695 = load i16, i16* %2694, align 2, !dbg !73
  %2696 = and i16 %2695, 9216, !dbg !73
  %2697 = icmp ne i16 %2696, 0, !dbg !73
  %2698 = alloca %struct.sqlite3_value*, align 8, !dbg !73
  br i1 %2697, label %31, label %33, !dbg !73
}

; Function Attrs: nounwind
declare i8* @llvm.stacksave() #5

; Function Attrs: nounwind
declare void @llvm.stackrestore(i8*) #5

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #6

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_status64(i32, i64* nocapture, i64* nocapture, i32) #3

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #6

; Function Attrs: nounwind ssp uwtable
declare void @sqlite3_mutex_enter(%struct.sqlite3_mutex*) #3

; Function Attrs: nounwind ssp uwtable
declare void @sqlite3_mutex_leave(%struct.sqlite3_mutex*) #3

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #6

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_status(i32, i32* nocapture, i32* nocapture, i32) #3

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i32 @countLookasideSlots(%struct.LookasideSlot* readonly) local_unnamed_addr #7

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_db_status(%struct.sqlite3*, i32, i32* nocapture, i32*, i32) #3

; Function Attrs: nounwind ssp uwtable
declare i64 @sqlite3_msize(i8*) #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3VdbeClearObject(%struct.sqlite3*, %struct.Vdbe* nocapture readonly) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3DbFree(%struct.sqlite3*, i8*) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @getDigits(i8* nocapture readonly, i8* nocapture readonly, ...) local_unnamed_addr #3

; Function Attrs: nounwind
declare void @llvm.va_start(i8*) #5

; Function Attrs: nounwind
declare void @llvm.va_end(i8*) #5

; Function Attrs: nounwind ssp uwtable
declare i32 @parseTimezone(i8* nocapture readonly, %struct.DateTime* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @parseHhMmSs(i8* nocapture readonly, %struct.DateTime* nocapture) local_unnamed_addr #3

; Function Attrs: nofree nounwind ssp uwtable
declare void @datetimeError(%struct.DateTime*) local_unnamed_addr #8

; Function Attrs: nofree nounwind
declare i8* @__memset_chk(i8*, i32, i64, i64) local_unnamed_addr #9

; Function Attrs: nofree nounwind ssp uwtable
declare void @computeJD(%struct.DateTime*) local_unnamed_addr #8

; Function Attrs: nounwind ssp uwtable
declare i32 @parseYyyyMmDd(i8* nocapture readonly, %struct.DateTime*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @setDateTimeToCurrent(%struct.sqlite3_context* nocapture readonly, %struct.DateTime* nocapture) local_unnamed_addr #3

; Function Attrs: nofree norecurse nounwind ssp uwtable writeonly
declare void @setRawDateNumber(%struct.DateTime* nocapture, double) local_unnamed_addr #10

; Function Attrs: nounwind ssp uwtable
declare i32 @parseDateOrTime(%struct.sqlite3_context* nocapture, i8* readonly, %struct.DateTime*) local_unnamed_addr #3

; Function Attrs: norecurse nounwind readnone ssp uwtable
declare i32 @validJulianDay(i64) local_unnamed_addr #11

; Function Attrs: nofree nounwind ssp uwtable
declare void @computeYMD(%struct.DateTime*) local_unnamed_addr #8

; Function Attrs: nofree nounwind ssp uwtable
declare void @computeHMS(%struct.DateTime*) local_unnamed_addr #8

; Function Attrs: nofree nounwind ssp uwtable
declare void @computeYMD_HMS(%struct.DateTime*) local_unnamed_addr #8

; Function Attrs: nofree norecurse nounwind ssp uwtable writeonly
declare void @clearYMD_HMS_TZ(%struct.DateTime* nocapture) local_unnamed_addr #10

; Function Attrs: nounwind ssp uwtable
declare i32 @osLocaltime(i64*, %struct.tm* nocapture) local_unnamed_addr #3

declare %struct.tm* @localtime(i64*) local_unnamed_addr #12

; Function Attrs: nounwind ssp uwtable
declare i64 @localtimeOffset(%struct.DateTime* nocapture readonly, %struct.sqlite3_context* nocapture, i32* nocapture) local_unnamed_addr #3

; Function Attrs: argmemonly nounwind willreturn writeonly
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1 immarg) #13

; Function Attrs: nounwind ssp uwtable
declare void @sqlite3_result_error(%struct.sqlite3_context* nocapture, i8*, i32) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @parseModifier(%struct.sqlite3_context* nocapture, i8* readonly, i32, %struct.DateTime*) local_unnamed_addr #3

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i32 @sqlite3_stricmp(i8* readonly, i8* readonly) #7

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i32 @sqlite3_strnicmp(i8* readonly, i8* readonly, i32) #7

; Function Attrs: nounwind ssp uwtable
declare i32 @isDate(%struct.sqlite3_context* nocapture, i32, %struct.sqlite3_value** nocapture readonly, %struct.DateTime*) local_unnamed_addr #3

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i32 @sqlite3_value_type(%struct.sqlite3_value* nocapture readonly) #7

; Function Attrs: nounwind ssp uwtable
declare double @sqlite3_value_double(%struct.sqlite3_value* nocapture readonly) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_value_bytes(%struct.sqlite3_value*) #3

; Function Attrs: nounwind ssp uwtable
declare void @juliandayFunc(%struct.sqlite3_context* nocapture, i32, %struct.sqlite3_value** nocapture readonly) #3

; Function Attrs: nounwind ssp uwtable
declare void @sqlite3_result_double(%struct.sqlite3_context* nocapture readonly, double) #3

; Function Attrs: nounwind ssp uwtable
declare void @datetimeFunc(%struct.sqlite3_context* nocapture, i32, %struct.sqlite3_value** nocapture readonly) #3

; Function Attrs: nounwind ssp uwtable
declare i8* @sqlite3_snprintf(i32, i8* returned, i8*, ...) #3

; Function Attrs: nounwind ssp uwtable
declare void @sqlite3_result_text(%struct.sqlite3_context* nocapture, i8*, i32, void (i8*)*) #3

; Function Attrs: nounwind ssp uwtable
declare void @timeFunc(%struct.sqlite3_context* nocapture, i32, %struct.sqlite3_value** nocapture readonly) #3

; Function Attrs: nounwind ssp uwtable
declare void @dateFunc(%struct.sqlite3_context* nocapture, i32, %struct.sqlite3_value** nocapture readonly) #3

; Function Attrs: nounwind ssp uwtable
declare void @strftimeFunc(%struct.sqlite3_context* nocapture, i32, %struct.sqlite3_value** nocapture readonly) #3

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare %struct.sqlite3* @sqlite3_context_db_handle(%struct.sqlite3_context* nocapture readonly) #7

; Function Attrs: nounwind ssp uwtable
declare void @sqlite3_result_error_toobig(%struct.sqlite3_context* nocapture) #3

; Function Attrs: nounwind ssp uwtable
declare void @sqlite3_result_error_nomem(%struct.sqlite3_context* nocapture) #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3MallocSize(i8*) #3

; Function Attrs: nounwind ssp uwtable
declare void @ctimeFunc(%struct.sqlite3_context* nocapture, i32, %struct.sqlite3_value** nocapture readnone) #3

; Function Attrs: nounwind ssp uwtable
declare void @cdateFunc(%struct.sqlite3_context* nocapture, i32, %struct.sqlite3_value** nocapture readnone) #3

; Function Attrs: nounwind ssp uwtable
declare void @ctimestampFunc(%struct.sqlite3_context* nocapture, i32, %struct.sqlite3_value** nocapture readnone) #3

; Function Attrs: nounwind ssp uwtable
declare %struct.sqlite3_vfs* @sqlite3_vfs_find(i8* readonly) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_initialize() local_unnamed_addr #3

; Function Attrs: nofree nounwind readonly
declare i32 @strcmp(i8* nocapture, i8* nocapture) local_unnamed_addr #14

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare void @vfsUnlink(%struct.sqlite3_vfs* readonly) local_unnamed_addr #15

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_vfs_register(%struct.sqlite3_vfs*, i32) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_vfs_unregister(%struct.sqlite3_vfs* readonly) #3

; Function Attrs: nounwind ssp uwtable
declare %struct.sqlite3_mutex* @sqlite3_mutex_alloc(i32) #3

; Function Attrs: nounwind ssp uwtable
declare void @sqlite3_mutex_free(%struct.sqlite3_mutex*) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_mutex_try(%struct.sqlite3_mutex*) #3

; Function Attrs: norecurse nounwind readnone ssp uwtable
declare i32 @noopMutexInit() #11

; Function Attrs: norecurse nounwind readnone ssp uwtable
declare i32 @noopMutexEnd() #11

; Function Attrs: norecurse nounwind readnone ssp uwtable
declare nonnull %struct.sqlite3_mutex* @noopMutexAlloc(i32) #11

; Function Attrs: norecurse nounwind readnone ssp uwtable
declare void @noopMutexFree(%struct.sqlite3_mutex* nocapture) #11

; Function Attrs: norecurse nounwind readnone ssp uwtable
declare void @noopMutexEnter(%struct.sqlite3_mutex* nocapture) #11

; Function Attrs: norecurse nounwind readnone ssp uwtable
declare i32 @noopMutexTry(%struct.sqlite3_mutex* nocapture readnone) #11

; Function Attrs: norecurse nounwind readnone ssp uwtable
declare void @noopMutexLeave(%struct.sqlite3_mutex* nocapture) #11

; Function Attrs: norecurse nounwind readnone ssp uwtable
declare i32 @pthreadMutexInit() #11

; Function Attrs: norecurse nounwind readnone ssp uwtable
declare i32 @pthreadMutexEnd() #11

; Function Attrs: nounwind ssp uwtable
declare %struct.sqlite3_mutex* @pthreadMutexAlloc(i32) #3

declare i32 @pthread_mutexattr_init(%struct._opaque_pthread_mutexattr_t*) local_unnamed_addr #12

declare i32 @pthread_mutexattr_settype(%struct._opaque_pthread_mutexattr_t*, i32) local_unnamed_addr #12

declare i32 @pthread_mutex_init(%struct._opaque_pthread_mutex_t*, %struct._opaque_pthread_mutexattr_t*) local_unnamed_addr #12

declare i32 @"\01_pthread_mutexattr_destroy"(%struct._opaque_pthread_mutexattr_t*) local_unnamed_addr #12

; Function Attrs: nounwind ssp uwtable
declare void @pthreadMutexFree(%struct.sqlite3_mutex*) #3

declare i32 @pthread_mutex_destroy(%struct._opaque_pthread_mutex_t*) local_unnamed_addr #12

; Function Attrs: nounwind ssp uwtable
declare void @sqlite3_free(i8*) #3

; Function Attrs: nounwind ssp uwtable
declare void @pthreadMutexEnter(%struct.sqlite3_mutex*) #3

declare i32 @pthread_mutex_lock(%struct._opaque_pthread_mutex_t*) local_unnamed_addr #12

; Function Attrs: nounwind ssp uwtable
declare i32 @pthreadMutexTry(%struct.sqlite3_mutex*) #3

declare i32 @pthread_mutex_trylock(%struct._opaque_pthread_mutex_t*) local_unnamed_addr #12

; Function Attrs: nounwind ssp uwtable
declare void @pthreadMutexLeave(%struct.sqlite3_mutex*) #3

declare i32 @pthread_mutex_unlock(%struct._opaque_pthread_mutex_t*) local_unnamed_addr #12

; Function Attrs: norecurse nounwind readnone ssp uwtable
declare i32 @sqlite3_release_memory(i32) #11

; Function Attrs: norecurse nounwind readnone ssp uwtable
declare i32 @sqlite3_memory_alarm(void (i8*, i64, i32)* nocapture readnone, i8* nocapture readnone, i64) local_unnamed_addr #11

; Function Attrs: nounwind ssp uwtable
declare i64 @sqlite3_soft_heap_limit64(i64) #3

; Function Attrs: nounwind ssp uwtable
declare i64 @sqlite3_memory_used() #3

; Function Attrs: nounwind ssp uwtable
declare void @sqlite3_soft_heap_limit(i32) #3

; Function Attrs: nounwind ssp uwtable
declare i64 @sqlite3_hard_heap_limit64(i64) #3

; Function Attrs: nounwind ssp uwtable
declare i64 @sqlite3_memory_highwater(i32) #3

; Function Attrs: nounwind ssp uwtable
declare void @mallocWithAlarm(i32, i8** nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i8* @sqlite3_malloc(i32) #3

; Function Attrs: nounwind ssp uwtable
declare i8* @sqlite3_malloc64(i64) #3

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i32 @isLookaside(%struct.sqlite3* nocapture readonly, i8*) local_unnamed_addr #7

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i32 @lookasideMallocSize(%struct.sqlite3* nocapture readonly, i8* readnone) local_unnamed_addr #7

; Function Attrs: noinline nounwind ssp uwtable
declare void @measureAllocationSize(%struct.sqlite3* readonly, i8*) local_unnamed_addr #1

; Function Attrs: nounwind ssp uwtable
declare i8* @sqlite3_realloc(i8*, i32) #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i8* @sqlite3Realloc(i8*, i64) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i8* @sqlite3_realloc64(i8*, i64) #3

; Function Attrs: noinline nounwind ssp uwtable
declare i8* @dbMallocRawFinish(%struct.sqlite3*, i64) local_unnamed_addr #1

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare dso_local void @sqlite3OomFault(%struct.sqlite3*) unnamed_addr #15

; Function Attrs: noinline nounwind ssp uwtable
declare i8* @dbReallocFinish(%struct.sqlite3*, i8*, i64) local_unnamed_addr #1

; Function Attrs: nofree nounwind
declare i8* @__memcpy_chk(i8*, i8*, i64, i64) local_unnamed_addr #9

; Function Attrs: noinline nounwind ssp uwtable
declare i32 @apiOomError(%struct.sqlite3*) local_unnamed_addr #1

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare signext i8 @et_getdigit(x86_fp80* nocapture, i32* nocapture) local_unnamed_addr #15

; Function Attrs: nounwind ssp uwtable
declare void @setStrAccumError(%struct.sqlite3_str* nocapture, i8 zeroext) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @sqlite3_str_reset(%struct.sqlite3_str* nocapture) #3

; Function Attrs: nounwind ssp uwtable
declare i64 @getIntArg(%struct.PrintfArguments* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i64 @sqlite3_value_int64(%struct.sqlite3_value* nocapture readonly) #3

; Function Attrs: nounwind ssp uwtable
declare double @getDoubleArg(%struct.PrintfArguments* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i8* @getTextArg(%struct.PrintfArguments* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i8* @printfTempBuf(%struct.sqlite3_str*, i64) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i8* @sqlite3DbMallocRaw(%struct.sqlite3*, i64) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @sqlite3_str_vappendf(%struct.sqlite3_str*, i8*, %struct.__va_list_tag*) #3

; Function Attrs: nounwind ssp uwtable
declare void @sqlite3_str_append(%struct.sqlite3_str*, i8*, i32) #3

; Function Attrs: nounwind ssp uwtable
declare void @sqlite3_str_appendchar(%struct.sqlite3_str*, i32, i8 signext) #3

; Function Attrs: argmemonly nofree nounwind readonly
declare i64 @strlen(i8* nocapture) local_unnamed_addr #16

; Function Attrs: nounwind ssp uwtable
declare void @sqlite3_str_appendall(%struct.sqlite3_str*, i8*) #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3StrAccumEnlarge(%struct.sqlite3_str*, i32) unnamed_addr #3

; Function Attrs: noinline nounwind ssp uwtable
declare void @enlargeAndAppend(%struct.sqlite3_str*, i8*, i32) local_unnamed_addr #1

; Function Attrs: noinline nounwind ssp uwtable
declare i8* @strAccumFinishRealloc(%struct.sqlite3_str* nocapture) local_unnamed_addr #1

; Function Attrs: nounwind ssp uwtable
declare i8* @sqlite3_str_finish(%struct.sqlite3_str*) #3

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i32 @sqlite3_str_errcode(%struct.sqlite3_str* readonly) #7

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i32 @sqlite3_str_length(%struct.sqlite3_str* readonly) #7

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare i8* @sqlite3_str_value(%struct.sqlite3_str* readonly) #15

; Function Attrs: nounwind ssp uwtable
declare %struct.sqlite3_str* @sqlite3_str_new(%struct.sqlite3* readonly) #3

; Function Attrs: nounwind ssp uwtable
declare i8* @sqlite3_vmprintf(i8*, %struct.__va_list_tag*) #3

; Function Attrs: nounwind ssp uwtable
declare i8* @sqlite3_mprintf(i8*, ...) #3

; Function Attrs: nounwind ssp uwtable
declare i8* @sqlite3_vsnprintf(i32, i8* returned, i8*, %struct.__va_list_tag*) #3

; Function Attrs: nounwind ssp uwtable
declare void @renderLogMsg(i32, i8*, %struct.__va_list_tag*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @sqlite3_log(i32, i8*, ...) #3

; Function Attrs: nounwind ssp uwtable
declare void @sqlite3_str_appendf(%struct.sqlite3_str*, i8*, ...) #3

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i32 @compare2pow63(i8* nocapture readonly, i32) local_unnamed_addr #7

; Function Attrs: noinline nounwind ssp uwtable writeonly
declare i32 @putVarint64(i8* nocapture, i64) local_unnamed_addr #17

; Function Attrs: nounwind ssp uwtable
declare void @logBadConnection(i8*) local_unnamed_addr #3

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i32 @strHash(i8* nocapture readonly) local_unnamed_addr #7

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare void @insertElement(%struct.Hash* nocapture, %struct._ht*, %struct.HashElem*) local_unnamed_addr #15

; Function Attrs: nounwind ssp uwtable
declare i32 @rehash(%struct.Hash* nocapture, i32) local_unnamed_addr #3

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare %struct.HashElem* @findElementWithHash(%struct.Hash* nocapture readonly, i8* nocapture readonly, i32*) local_unnamed_addr #15

; Function Attrs: nounwind ssp uwtable
declare void @removeElementGivenHash(%struct.Hash* nocapture, %struct.HashElem*, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @posixOpen(i8*, i32, i32) #3

declare i32 @"\01_open"(i8*, i32, ...) local_unnamed_addr #12

declare i32 @"\01_close"(i32) #12

; Function Attrs: nofree nounwind
declare i32 @access(i8* nocapture readonly, i32) #9

declare i8* @getcwd(i8*, i64) #12

declare i32 @"\01_stat$INODE64"(i8*, %struct.stat*) #12

declare i32 @"\01_fstat$INODE64"(i32, %struct.stat*) #12

declare i32 @ftruncate(i32, i64) #12

declare i32 @"\01_fcntl"(i32, i32, ...) #12

declare i64 @"\01_read"(i32, i8*, i64) #12

declare i64 @"\01_pread"(i32, i8*, i64, i64) #12

declare i64 @"\01_write"(i32, i8*, i64) #12

declare i64 @"\01_pwrite"(i32, i8*, i64, i64) #12

declare i32 @"\01_fchmod"(i32, i16 zeroext) #12

; Function Attrs: nofree nounwind
declare i32 @unlink(i8* nocapture readonly) #9

; Function Attrs: nounwind ssp uwtable
declare i32 @openDirectory(i8*, i32* nocapture) #3

; Function Attrs: nofree nounwind
declare i32 @mkdir(i8* nocapture readonly, i16 zeroext) #9

; Function Attrs: nofree nounwind
declare i32 @rmdir(i8* nocapture readonly) #9

declare i32 @fchown(i32, i32, i32) #12

declare i32 @geteuid() #12

declare i8* @"\01_mmap"(i8*, i64, i32, i32, i32, i64) #12

declare i32 @"\01_munmap"(i8*, i64) #12

; Function Attrs: nounwind ssp uwtable
declare i32 @unixGetpagesize() #3

; Function Attrs: nofree nounwind
declare i64 @readlink(i8* nocapture readonly, i8* nocapture, i64) #9

declare i32 @"\01_lstat$INODE64"(i8*, %struct.stat*) #12

; Function Attrs: nounwind ssp uwtable
declare i32 @robustFchown(i32, i32, i32) local_unnamed_addr #3

; Function Attrs: nofree nounwind ssp uwtable
declare i32 @unixSetSystemCall(%struct.sqlite3_vfs* nocapture readnone, i8* readonly, void ()*) #8

; Function Attrs: nounwind readonly ssp uwtable
declare void ()* @unixGetSystemCall(%struct.sqlite3_vfs* nocapture readnone, i8* nocapture readonly) #18

; Function Attrs: nounwind readonly ssp uwtable
declare i8* @unixNextSystemCall(%struct.sqlite3_vfs* nocapture readnone, i8* readonly) #18

; Function Attrs: nounwind ssp uwtable
declare i32 @robust_open(i8*, i32, i16 zeroext) local_unnamed_addr #3

declare i32* @__error() local_unnamed_addr #12

; Function Attrs: nounwind ssp uwtable
declare void @unixEnterMutex() local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @unixLeaveMutex() local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @robust_ftruncate(i32, i64) local_unnamed_addr #3

; Function Attrs: norecurse nounwind readnone ssp uwtable
declare i32 @sqliteErrorFromPosixError(i32, i32) local_unnamed_addr #11

; Function Attrs: nounwind ssp uwtable
declare i32 @unixLogErrorAtLine(i32 returned, i8*, i8*, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @robust_close(%struct.unixFile* readonly, i32, i32) local_unnamed_addr #3

; Function Attrs: nofree norecurse nounwind ssp uwtable writeonly
declare void @storeLastErrno(%struct.unixFile* nocapture, i32) local_unnamed_addr #10

; Function Attrs: nounwind ssp uwtable
declare void @closePendingFds(%struct.unixFile* readonly) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @releaseInodeInfo(%struct.unixFile* readonly) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @findInodeInfo(%struct.unixFile* nocapture, %struct.unixInodeInfo** nocapture) local_unnamed_addr #3

; Function Attrs: nofree nounwind readonly
declare i32 @memcmp(i8* nocapture, i8* nocapture, i64) local_unnamed_addr #14

; Function Attrs: nounwind ssp uwtable
declare i32 @fileHasMoved(%struct.unixFile* nocapture readonly) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @verifyDbFile(%struct.unixFile* nocapture readonly) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @unixCheckReservedLock(%struct.sqlite3_file* nocapture, i32* nocapture) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @unixFileLock(%struct.unixFile* nocapture readonly, %struct.flock*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @unixLock(%struct.sqlite3_file* nocapture, i32) #3

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare void @setPendingFd(%struct.unixFile* nocapture) local_unnamed_addr #15

; Function Attrs: nounwind ssp uwtable
declare i32 @posixUnlock(%struct.sqlite3_file*, i32, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @unixUnlock(%struct.sqlite3_file*, i32) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @closeUnixFile(%struct.sqlite3_file*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @unixUnmapfile(%struct.unixFile* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @unixClose(%struct.sqlite3_file*) #3

; Function Attrs: nofree norecurse nounwind ssp uwtable writeonly
declare i32 @nolockCheckReservedLock(%struct.sqlite3_file* nocapture readnone, i32* nocapture) #10

; Function Attrs: norecurse nounwind readnone ssp uwtable
declare i32 @nolockLock(%struct.sqlite3_file* nocapture readnone, i32) #11

; Function Attrs: norecurse nounwind readnone ssp uwtable
declare i32 @nolockUnlock(%struct.sqlite3_file* nocapture readnone, i32) #11

; Function Attrs: nounwind ssp uwtable
declare i32 @nolockClose(%struct.sqlite3_file*) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @dotlockCheckReservedLock(%struct.sqlite3_file* nocapture readonly, i32* nocapture) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @dotlockLock(%struct.sqlite3_file* nocapture, i32) #3

; Function Attrs: nofree nounwind
declare i32 @utimes(i8* nocapture readonly, %struct.timeval* nocapture readonly) local_unnamed_addr #9

; Function Attrs: nounwind ssp uwtable
declare i32 @dotlockUnlock(%struct.sqlite3_file* nocapture, i32) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @dotlockClose(%struct.sqlite3_file*) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @robust_flock(i32, i32) local_unnamed_addr #3

declare i32 @flock(i32, i32) local_unnamed_addr #12

; Function Attrs: nounwind ssp uwtable
declare i32 @flockCheckReservedLock(%struct.sqlite3_file* nocapture, i32* nocapture) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @flockLock(%struct.sqlite3_file* nocapture, i32) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @flockUnlock(%struct.sqlite3_file* nocapture, i32) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @flockClose(%struct.sqlite3_file*) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @afpSetLock(i8*, %struct.unixFile* nocapture, i64, i64, i32) local_unnamed_addr #3

declare i32 @fsctl(i8*, i64, i8*, i32) local_unnamed_addr #12

; Function Attrs: nounwind ssp uwtable
declare i32 @afpCheckReservedLock(%struct.sqlite3_file* nocapture, i32* nocapture) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @afpLock(%struct.sqlite3_file* nocapture, i32) #3

declare i64 @random() local_unnamed_addr #12

; Function Attrs: nounwind ssp uwtable
declare i32 @afpUnlock(%struct.sqlite3_file*, i32) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @afpClose(%struct.sqlite3_file*) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @nfsUnlock(%struct.sqlite3_file*, i32) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @seekAndRead(%struct.unixFile* nocapture, i64, i8*, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @unixRead(%struct.sqlite3_file* nocapture, i8*, i32, i64) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @seekAndWriteFd(i32, i64, i8*, i32, i32* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @seekAndWrite(%struct.unixFile* nocapture, i64, i8*, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @unixWrite(%struct.sqlite3_file* nocapture, i8*, i32, i64) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @full_fsync(i32, i32, i32) local_unnamed_addr #3

declare i32 @"\01_fsync"(i32) local_unnamed_addr #12

; Function Attrs: nounwind ssp uwtable
declare i32 @unixSync(%struct.sqlite3_file*, i32) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @unixTruncate(%struct.sqlite3_file* nocapture, i64) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @unixFileSize(%struct.sqlite3_file* nocapture, i64* nocapture) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @fcntlSizeHint(%struct.unixFile* nocapture, i64) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @unixMapfile(%struct.unixFile* nocapture, i64) local_unnamed_addr #3

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare void @unixModeBit(%struct.unixFile* nocapture, i8 zeroext, i32* nocapture) local_unnamed_addr #15

; Function Attrs: nounwind ssp uwtable
declare i32 @unixFileControl(%struct.sqlite3_file*, i32, i8*) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @unixGetTempname(i32, i8*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @proxyFileControl(%struct.sqlite3_file*, i32, i8*) local_unnamed_addr #3

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare void @setDeviceCharacteristics(%struct.unixFile* nocapture) local_unnamed_addr #15

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare i32 @unixSectorSize(%struct.sqlite3_file* nocapture) #15

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare i32 @unixDeviceCharacteristics(%struct.sqlite3_file* nocapture) #15

declare i64 @sysconf(i32) local_unnamed_addr #12

; Function Attrs: nounwind ssp uwtable
declare i32 @unixShmSystemLock(%struct.unixFile* nocapture readonly, i32, i32, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @unixShmRegionPerMap() local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @unixShmPurge(%struct.unixFile* readonly) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @unixLockSharedMemory(%struct.unixFile* nocapture readonly, %struct.unixShmNode* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @unixOpenSharedMemory(%struct.unixFile*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_uri_boolean(i8* readonly, i8* readonly, i32) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @unixShmMap(%struct.sqlite3_file*, i32, i32, i32, i8** nocapture) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @unixShmLock(%struct.sqlite3_file* nocapture readonly, i32, i32, i32) #3

; Function Attrs: nounwind ssp uwtable
declare void @unixShmBarrier(%struct.sqlite3_file* nocapture readnone) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @unixShmUnmap(%struct.sqlite3_file*, i32) #3

; Function Attrs: nounwind ssp uwtable
declare void @unixRemapfile(%struct.unixFile* nocapture, i64) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @unixFetch(%struct.sqlite3_file* nocapture, i64, i32, i8** nocapture) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @unixUnfetch(%struct.sqlite3_file* nocapture, i64, i8* readnone) #3

; Function Attrs: norecurse nounwind readnone ssp uwtable
declare nonnull %struct.sqlite3_io_methods* @posixIoFinderImpl(i8* nocapture readnone, %struct.unixFile* nocapture readnone) #11

; Function Attrs: norecurse nounwind readnone ssp uwtable
declare nonnull %struct.sqlite3_io_methods* @nolockIoFinderImpl(i8* nocapture readnone, %struct.unixFile* nocapture readnone) #11

; Function Attrs: norecurse nounwind readnone ssp uwtable
declare nonnull %struct.sqlite3_io_methods* @dotlockIoFinderImpl(i8* nocapture readnone, %struct.unixFile* nocapture readnone) #11

; Function Attrs: norecurse nounwind readnone ssp uwtable
declare nonnull %struct.sqlite3_io_methods* @flockIoFinderImpl(i8* nocapture readnone, %struct.unixFile* nocapture readnone) #11

; Function Attrs: norecurse nounwind readnone ssp uwtable
declare nonnull %struct.sqlite3_io_methods* @afpIoFinderImpl(i8* nocapture readnone, %struct.unixFile* nocapture readnone) #11

; Function Attrs: nounwind ssp uwtable
declare i32 @proxyClose(%struct.sqlite3_file*) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @proxyLock(%struct.sqlite3_file*, i32) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @proxyUnlock(%struct.sqlite3_file*, i32) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @proxyCheckReservedLock(%struct.sqlite3_file*, i32*) #3

; Function Attrs: norecurse nounwind readnone ssp uwtable
declare nonnull %struct.sqlite3_io_methods* @proxyIoFinderImpl(i8* nocapture readnone, %struct.unixFile* nocapture readnone) #11

; Function Attrs: norecurse nounwind readnone ssp uwtable
declare nonnull %struct.sqlite3_io_methods* @nfsIoFinderImpl(i8* nocapture readnone, %struct.unixFile* nocapture readnone) #11

; Function Attrs: nounwind ssp uwtable
declare %struct.sqlite3_io_methods* @autolockIoFinderImpl(i8*, %struct.unixFile* nocapture readonly) #3

declare i32 @"\01_statfs$INODE64"(i8*, %struct.statfs*) local_unnamed_addr #12

; Function Attrs: nounwind ssp uwtable
declare i32 @fillInUnixFile(%struct.sqlite3_vfs*, i32, %struct.sqlite3_file*, i8*, i32) local_unnamed_addr #3

declare void @srandomdev() local_unnamed_addr #12

; Function Attrs: nounwind ssp uwtable
declare i8* @unixTempFileDir() local_unnamed_addr #3

; Function Attrs: nofree nounwind readonly
declare i8* @getenv(i8* nocapture) local_unnamed_addr #14

; Function Attrs: nounwind ssp uwtable
declare %struct.UnixUnusedFd* @findReusableFd(i8*, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @getFileMode(i8*, i16* nocapture, i32* nocapture, i32* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @findCreateFileMode(i8*, i32, i16* nocapture, i32* nocapture, i32* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind readonly ssp uwtable
declare i8* @sqlite3_uri_parameter(i8* readonly, i8* readonly) #18

; Function Attrs: nounwind ssp uwtable
declare i32 @unixOpen(%struct.sqlite3_vfs*, i8*, %struct.sqlite3_file*, i32, i32*) #3

declare i32 @getpid() local_unnamed_addr #12

declare i32 @"\01_fstatfs$INODE64"(i32, %struct.statfs*) local_unnamed_addr #12

; Function Attrs: nofree nounwind readonly
declare i32 @strncmp(i8* nocapture, i8* nocapture, i64) local_unnamed_addr #14

; Function Attrs: nofree nounwind readonly
declare i32 @atoi(i8* nocapture) local_unnamed_addr #14

; Function Attrs: nounwind ssp uwtable
declare i32 @proxyTransformUnixFile(%struct.unixFile* nocapture, i8*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @unixDelete(%struct.sqlite3_vfs* nocapture readnone, i8*, i32) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @unixAccess(%struct.sqlite3_vfs* nocapture readnone, i8*, i32, i32* nocapture) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @mkFullPathname(i8*, i8*, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @unixFullPathname(%struct.sqlite3_vfs* nocapture readnone, i8*, i32, i8*) #3

; Function Attrs: nounwind ssp uwtable
declare i8* @unixDlOpen(%struct.sqlite3_vfs* nocapture readnone, i8*) #3

declare i8* @dlopen(i8*, i32) local_unnamed_addr #12

; Function Attrs: nounwind ssp uwtable
declare void @unixDlError(%struct.sqlite3_vfs* nocapture readnone, i32, i8*) #3

declare i8* @dlerror() local_unnamed_addr #12

; Function Attrs: nounwind ssp uwtable
declare void ()* @unixDlSym(%struct.sqlite3_vfs* nocapture readnone, i8*, i8*) #3

declare i8* @dlsym(i8*, i8*) local_unnamed_addr #12

; Function Attrs: nounwind ssp uwtable
declare void @unixDlClose(%struct.sqlite3_vfs* nocapture readnone, i8*) #3

declare i32 @dlclose(i8*) local_unnamed_addr #12

; Function Attrs: nounwind ssp uwtable
declare i32 @unixRandomness(%struct.sqlite3_vfs* nocapture readnone, i32, i8*) #3

declare i64 @time(i64*) local_unnamed_addr #12

; Function Attrs: nounwind ssp uwtable
declare i32 @unixSleep(%struct.sqlite3_vfs* nocapture readnone, i32) #3

declare i32 @"\01_sleep"(i32) local_unnamed_addr #12

; Function Attrs: nounwind ssp uwtable
declare i32 @unixCurrentTimeInt64(%struct.sqlite3_vfs* nocapture readnone, i64* nocapture) #3

; Function Attrs: nofree nounwind
declare i32 @gettimeofday(%struct.timeval* nocapture, i8* nocapture) local_unnamed_addr #9

; Function Attrs: nounwind ssp uwtable
declare i32 @unixCurrentTime(%struct.sqlite3_vfs* nocapture readnone, double* nocapture) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @unixGetLastError(%struct.sqlite3_vfs* nocapture readnone, i32, i8* nocapture readnone) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @proxyGetLockPath(i8* nocapture readonly, i8*, i64) local_unnamed_addr #3

declare i64 @"\01_confstr"(i32, i8*, i64) local_unnamed_addr #12

; Function Attrs: nounwind ssp uwtable
declare i32 @proxyCreateLockPath(i8* nocapture readonly) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @proxyCreateUnixFile(i8*, %struct.unixFile** nocapture, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @proxyGetHostID(i8*, i32*) local_unnamed_addr #3

declare i32 @gethostuuid(i8*, %struct.timespec*) local_unnamed_addr #12

; Function Attrs: nounwind ssp uwtable
declare i32 @proxyBreakConchLock(%struct.unixFile* readonly, i8* nocapture readnone) local_unnamed_addr #3

; Function Attrs: nofree nounwind
declare i64 @__strlcpy_chk(i8*, i8*, i64, i64) local_unnamed_addr #9

; Function Attrs: nofree nounwind
declare i32 @rename(i8* nocapture readonly, i8* nocapture readonly) local_unnamed_addr #9

; Function Attrs: nofree nounwind
declare i32 @fprintf(%struct.__sFILE* nocapture, i8* nocapture readonly, ...) local_unnamed_addr #9

; Function Attrs: nounwind ssp uwtable
declare i32 @proxyConchLock(%struct.unixFile*, i8* nocapture readonly, i32) local_unnamed_addr #3

declare i32 @"\01_usleep"(i32) local_unnamed_addr #12

; Function Attrs: nounwind ssp uwtable
declare i32 @proxyTakeConch(%struct.unixFile*) local_unnamed_addr #3

declare i32 @futimes(i32, %struct.timeval*) local_unnamed_addr #12

; Function Attrs: nounwind ssp uwtable
declare dso_local i8* @sqlite3DbStrDup(%struct.sqlite3*, i8*) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @proxyReleaseConch(%struct.unixFile* nocapture readonly) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @proxyCreateConchPathname(i8*, i8** nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @switchLockProxyPath(%struct.unixFile* nocapture readonly, i8*) local_unnamed_addr #3

; Function Attrs: nofree nounwind ssp uwtable
declare i32 @proxyGetDbPathForUnixFile(%struct.unixFile* nocapture readonly, i8*) local_unnamed_addr #8

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_os_init() local_unnamed_addr #3

; Function Attrs: nofree norecurse nounwind ssp uwtable writeonly
declare i32 @sqlite3_os_end() local_unnamed_addr #10

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare void @pcacheManageDirtyList(%struct.PgHdr*, i8 zeroext) local_unnamed_addr #15

; Function Attrs: nounwind ssp uwtable
declare void @pcacheUnpin(%struct.PgHdr* nocapture readonly) local_unnamed_addr #3

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i32 @numberOfCachePages(%struct.PCache* nocapture readonly) local_unnamed_addr #7

; Function Attrs: nofree noinline nounwind ssp uwtable
declare %struct.PgHdr* @pcacheFetchFinishWithInit(%struct.PCache*, i32, %struct.sqlite3_pcache_page*) local_unnamed_addr #19

; Function Attrs: nounwind ssp uwtable
declare %struct.PgHdr* @pcacheMergeDirtyList(%struct.PgHdr*, %struct.PgHdr*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare %struct.PgHdr* @pcacheSortDirtyList(%struct.PgHdr*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @pcache1InitBulk(%struct.PCache1* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i8* @pcache1Alloc(i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @pcache1Free(i8*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare %struct.PgHdr1* @pcache1AllocPage(%struct.PCache1* nocapture, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @pcache1FreePage(%struct.PgHdr1*) local_unnamed_addr #3

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i32 @pcache1UnderMemoryPressure(%struct.PCache1* nocapture readonly) local_unnamed_addr #7

; Function Attrs: nounwind ssp uwtable
declare void @pcache1ResizeHash(%struct.PCache1* nocapture) local_unnamed_addr #3

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare %struct.PgHdr1* @pcache1PinPage(%struct.PgHdr1* returned) local_unnamed_addr #15

; Function Attrs: nounwind ssp uwtable
declare void @pcache1RemoveFromHash(%struct.PgHdr1*, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @pcache1EnforceMaxPage(%struct.PCache1* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @pcache1TruncateUnsafe(%struct.PCache1* nocapture, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @pcache1Init(i8* nocapture readnone) #3

; Function Attrs: nounwind ssp uwtable writeonly
declare void @pcache1Shutdown(i8* nocapture readnone) #20

; Function Attrs: nounwind ssp uwtable
declare %struct.sqlite3_pcache* @pcache1Create(i32, i32, i32) #3

; Function Attrs: nounwind ssp uwtable
declare void @pcache1Destroy(%struct.sqlite3_pcache*) #3

; Function Attrs: nounwind ssp uwtable
declare void @pcache1Cachesize(%struct.sqlite3_pcache* nocapture, i32) #3

; Function Attrs: nounwind ssp uwtable
declare void @pcache1Shrink(%struct.sqlite3_pcache* nocapture) #3

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i32 @pcache1Pagecount(%struct.sqlite3_pcache* nocapture readonly) #7

; Function Attrs: noinline nounwind ssp uwtable
declare %struct.PgHdr1* @pcache1FetchStage2(%struct.PCache1*, i32, i32) local_unnamed_addr #1

; Function Attrs: nounwind ssp uwtable
declare %struct.PgHdr1* @pcache1FetchNoMutex(%struct.sqlite3_pcache*, i32, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare %struct.sqlite3_pcache_page* @pcache1Fetch(%struct.sqlite3_pcache*, i32, i32) #3

; Function Attrs: nounwind ssp uwtable
declare void @pcache1Unpin(%struct.sqlite3_pcache* nocapture, %struct.sqlite3_pcache_page*, i32) #3

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare void @pcache1Rekey(%struct.sqlite3_pcache* nocapture, %struct.sqlite3_pcache_page*, i32, i32) #15

; Function Attrs: nounwind ssp uwtable
declare void @pcache1Truncate(%struct.sqlite3_pcache* nocapture, i32) #3

; Function Attrs: nounwind ssp uwtable
declare %struct.RowSetEntry* @rowSetEntryAlloc(%struct.RowSet* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare %struct.RowSetEntry* @rowSetEntryMerge(%struct.RowSetEntry*, %struct.RowSetEntry*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare %struct.RowSetEntry* @rowSetEntrySort(%struct.RowSetEntry*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @rowSetTreeToList(%struct.RowSetEntry*, %struct.RowSetEntry** nocapture, %struct.RowSetEntry** nocapture) local_unnamed_addr #3

; Function Attrs: nofree nounwind ssp uwtable
declare %struct.RowSetEntry* @rowSetNDeepTree(%struct.RowSetEntry**, i32) local_unnamed_addr #8

; Function Attrs: nofree nounwind ssp uwtable
declare %struct.RowSetEntry* @rowSetListToTree(%struct.RowSetEntry*) local_unnamed_addr #8

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare void @setGetterMethod(%struct.Pager* nocapture) local_unnamed_addr #15

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare i32 @getPageError(%struct.Pager* nocapture readonly, i32, %struct.PgHdr** nocapture, i32) #15

; Function Attrs: nounwind ssp uwtable
declare i32 @getPageMMap(%struct.Pager*, i32, %struct.PgHdr** nocapture, i32) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @getPageNormal(%struct.Pager*, i32, %struct.PgHdr** nocapture, i32) #3

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i32 @subjRequiresPage(%struct.PgHdr* nocapture readonly) local_unnamed_addr #7

; Function Attrs: nounwind ssp uwtable
declare i32 @read32bits(%struct.sqlite3_file*, i64, i32* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @write32bits(%struct.sqlite3_file*, i64, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @pagerUnlockDb(%struct.Pager* nocapture, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @pagerLockDb(%struct.Pager* nocapture, i32) local_unnamed_addr #3

; Function Attrs: norecurse nounwind readnone ssp uwtable
declare i32 @jrnlBufferSize(%struct.Pager* nocapture readnone) local_unnamed_addr #11

; Function Attrs: nounwind ssp uwtable
declare i32 @readMasterJournal(%struct.sqlite3_file*, i8*, i32) local_unnamed_addr #3

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i64 @journalHdrOffset(%struct.Pager* nocapture readonly) local_unnamed_addr #7

; Function Attrs: nounwind ssp uwtable
declare i32 @zeroJournalHdr(%struct.Pager* nocapture readonly, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @writeJournalHdr(%struct.Pager*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @readJournalHdr(%struct.Pager* nocapture, i32, i64, i32* nocapture, i32* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3PagerSetPagesize(%struct.Pager* nocapture, i32* nocapture, i32) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @writeMasterJournal(%struct.Pager* nocapture, i8*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @pager_reset(%struct.Pager* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @releaseAllSavepoints(%struct.Pager* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3BitvecDestroy(%struct.Bitvec*) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @addToSavepointBitvecs(%struct.Pager* nocapture readonly, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3BitvecSet(%struct.Bitvec*, i32) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @pager_unlock(%struct.Pager*) local_unnamed_addr #3

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare i32 @pager_error(%struct.Pager* nocapture, i32 returned) local_unnamed_addr #15

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i32 @pagerFlushOnCommit(%struct.Pager* nocapture readonly, i32) local_unnamed_addr #7

; Function Attrs: nounwind ssp uwtable
declare i32 @pager_end_transaction(%struct.Pager*, i32, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @pager_truncate(%struct.Pager* nocapture, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @pagerUnlockAndRollback(%struct.Pager*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3PagerRollback(%struct.Pager*) unnamed_addr #3

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i32 @pager_cksum(%struct.Pager* nocapture readonly, i8* nocapture readonly) local_unnamed_addr #7

; Function Attrs: nounwind ssp uwtable
declare i32 @pager_playback_one_page(%struct.Pager*, i64* nocapture, %struct.Bitvec*, i32, i32) local_unnamed_addr #3

; Function Attrs: noinline nounwind ssp uwtable
declare dso_local void @sqlite3PcacheRelease(%struct.PgHdr*) unnamed_addr #1

; Function Attrs: nounwind ssp uwtable
declare i32 @pager_delmaster(%struct.Pager* nocapture readonly, i8*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @setSectorSize(%struct.Pager* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @pager_playback(%struct.Pager*, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @readDbPage(%struct.PgHdr* nocapture readonly) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3WalFindFrame(%struct.Wal* nocapture, i32, i32* nocapture) unnamed_addr #3

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare void @pager_write_changecounter(%struct.PgHdr* nocapture readonly) local_unnamed_addr #15

; Function Attrs: nounwind ssp uwtable
declare i32 @pagerUndoCallback(i8* nocapture readonly, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @pagerRollbackWal(%struct.Pager* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @pagerWalFrames(%struct.Pager* nocapture, %struct.PgHdr*, i32, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @pagerBeginReadTransaction(%struct.Pager* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @pagerPagecount(%struct.Pager* nocapture, i32* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @pagerOpenWalIfPresent(%struct.Pager* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @pagerPlaybackSavepoint(%struct.Pager*, %struct.PagerSavepoint*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @pagerFixMaplimit(%struct.Pager* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @pagerOpentemp(%struct.Pager* nocapture readonly, %struct.sqlite3_file*, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @pager_wait_on_lock(%struct.Pager* nocapture, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @pagerSyncHotJournal(%struct.Pager*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @pagerAcquireMapPage(%struct.Pager*, i32, i8*, %struct.PgHdr** nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @pagerReleaseMapPage(%struct.PgHdr*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @pagerFreeMapHdrs(%struct.Pager* nocapture readonly) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @databaseIsUnmoved(%struct.Pager* nocapture readonly) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @syncJournal(%struct.Pager*, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @pager_write_pagelist(%struct.Pager*, %struct.PgHdr* readonly) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @openSubJournal(%struct.Pager* nocapture readonly) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @subjournalPage(%struct.PgHdr* nocapture readonly) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @subjournalPageIfRequired(%struct.PgHdr* nocapture readonly) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @pagerStress(i8*, %struct.PgHdr*) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @hasHotJournal(%struct.Pager* nocapture, i32* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @pagerUnlockIfUnused(%struct.Pager*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @pager_open_journal(%struct.Pager*) local_unnamed_addr #3

; Function Attrs: noinline nounwind ssp uwtable
declare i32 @pagerAddPageToRollbackJournal(%struct.PgHdr* nocapture) local_unnamed_addr #1

; Function Attrs: nounwind ssp uwtable
declare i32 @pager_write(%struct.PgHdr*) local_unnamed_addr #3

; Function Attrs: noinline nounwind ssp uwtable
declare i32 @pagerWriteLargeSector(%struct.PgHdr* nocapture readonly) local_unnamed_addr #1

; Function Attrs: nounwind ssp uwtable
declare i32 @pager_incr_changecounter(%struct.Pager*, i32) local_unnamed_addr #3

; Function Attrs: noinline nounwind ssp uwtable
declare i32 @pagerOpenSavepoint(%struct.Pager* nocapture, i32) local_unnamed_addr #1

; Function Attrs: nounwind ssp uwtable
declare i32 @pagerExclusiveLock(%struct.Pager* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @pagerOpenWal(%struct.Pager* nocapture) local_unnamed_addr #3

; Function Attrs: noinline nounwind ssp uwtable
declare i32 @walIndexPageRealloc(%struct.Wal* nocapture, i32, i32** nocapture) local_unnamed_addr #1

; Function Attrs: nounwind ssp uwtable
declare i32 @walIndexPage(%struct.Wal* nocapture, i32, i32** nocapture) local_unnamed_addr #3

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare nonnull %struct.WalCkptInfo* @walCkptInfo(%struct.Wal* nocapture readonly) local_unnamed_addr #7

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare %struct.WalIndexHdr* @walIndexHdr(%struct.Wal* nocapture readonly) local_unnamed_addr #7

; Function Attrs: nofree nounwind ssp uwtable
declare void @walChecksumBytes(i32, i8* readonly, i32, i32* readonly, i32* nocapture) local_unnamed_addr #8

; Function Attrs: nounwind ssp uwtable
declare void @walShmBarrier(%struct.Wal* nocapture readonly) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @walIndexWriteHdr(%struct.Wal*) local_unnamed_addr #3

; Function Attrs: nofree nounwind ssp uwtable
declare void @walEncodeFrame(%struct.Wal*, i32, i32, i8* readonly, i8*) local_unnamed_addr #8

; Function Attrs: nofree nounwind ssp uwtable
declare i32 @walDecodeFrame(%struct.Wal* nocapture, i32* nocapture, i32* nocapture, i8* readonly, i8* readonly) local_unnamed_addr #8

; Function Attrs: nounwind ssp uwtable
declare i32 @walLockShared(%struct.Wal* nocapture readonly, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @walUnlockShared(%struct.Wal* nocapture readonly, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @walLockExclusive(%struct.Wal* nocapture readonly, i32, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @walUnlockExclusive(%struct.Wal* nocapture readonly, i32, i32) local_unnamed_addr #3

; Function Attrs: norecurse nounwind readnone ssp uwtable
declare i32 @walHash(i32) local_unnamed_addr #11

; Function Attrs: norecurse nounwind readnone ssp uwtable
declare i32 @walNextHash(i32) local_unnamed_addr #11

; Function Attrs: nounwind ssp uwtable
declare i32 @walHashGet(%struct.Wal* nocapture, i32, %struct.WalHashLoc* nocapture) local_unnamed_addr #3

; Function Attrs: norecurse nounwind readnone ssp uwtable
declare i32 @walFramePage(i32) local_unnamed_addr #11

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare i32 @walFramePgno(%struct.Wal* nocapture readonly, i32) local_unnamed_addr #15

; Function Attrs: nounwind ssp uwtable
declare void @walCleanupHash(%struct.Wal* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @walIndexAppend(%struct.Wal* nocapture, i32, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @walIndexRecover(%struct.Wal*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @walIndexClose(%struct.Wal* nocapture readonly, i32) local_unnamed_addr #3

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare i32 @walIteratorNext(%struct.WalIterator* nocapture, i32* nocapture, i32* nocapture) local_unnamed_addr #15

; Function Attrs: nofree nounwind ssp uwtable
declare void @walMerge(i32* nocapture readonly, i16*, i32, i16** nocapture, i32* nocapture, i16*) local_unnamed_addr #8

; Function Attrs: nounwind ssp uwtable
declare void @walMergesort(i32* nocapture readonly, i16*, i16*, i32* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @walIteratorFree(%struct.WalIterator*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @walIteratorInit(%struct.Wal* nocapture, i32, %struct.WalIterator** nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @walBusyLock(%struct.Wal* nocapture readonly, i32 (i8*)*, i8*, i32, i32) local_unnamed_addr #3

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i32 @walPagesize(%struct.Wal* nocapture readonly) local_unnamed_addr #7

; Function Attrs: nounwind ssp uwtable
declare void @walRestartHdr(%struct.Wal*, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @walCheckpoint(%struct.Wal*, %struct.sqlite3*, i32, i32 (i8*)*, i8*, i32, i8*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @walLimitSize(%struct.Wal* nocapture readonly, i64) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @walIndexTryHdr(%struct.Wal*, i32* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @walIndexReadHdr(%struct.Wal*, i32* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @walBeginShmUnreliable(%struct.Wal*, i32* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @walTryBeginRead(%struct.Wal*, i32* nocapture, i32, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @walRestartLog(%struct.Wal*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @walWriteToLog(%struct.WalWriter* nocapture readonly, i8*, i32, i64) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @walWriteOneFrame(%struct.WalWriter* nocapture readonly, %struct.PgHdr* nocapture readonly, i32, i64) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @walRewriteChecksums(%struct.Wal*, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @lockBtreeMutex(%struct.Btree* nocapture) local_unnamed_addr #3

; Function Attrs: noinline nounwind ssp uwtable
declare void @unlockBtreeMutex(%struct.Btree* nocapture) local_unnamed_addr #1

; Function Attrs: noinline nounwind ssp uwtable
declare void @btreeLockCarefully(%struct.Btree* nocapture) local_unnamed_addr #1

; Function Attrs: noinline nounwind ssp uwtable
declare void @btreeEnterAll(%struct.sqlite3* nocapture) local_unnamed_addr #1

; Function Attrs: noinline nounwind ssp uwtable
declare void @btreeLeaveAll(%struct.sqlite3* nocapture readonly) local_unnamed_addr #1

; Function Attrs: nofree norecurse nounwind ssp uwtable writeonly
declare i32 @sqlite3_enable_shared_cache(i32) #10

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare i32 @querySharedCacheTableLock(%struct.Btree* readonly, i32, i8 zeroext) local_unnamed_addr #15

; Function Attrs: nounwind ssp uwtable
declare i32 @setSharedCacheTableLock(%struct.Btree*, i32, i8 zeroext) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @clearAllSharedCacheTableLocks(%struct.Btree* readonly) local_unnamed_addr #3

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare void @downgradeAllSharedCacheTableLocks(%struct.Btree* readonly) local_unnamed_addr #15

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare void @invalidateAllOverflowCache(%struct.BtShared* nocapture readonly) local_unnamed_addr #15

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare void @invalidateIncrblobCursors(%struct.Btree* nocapture, i32, i64, i32) local_unnamed_addr #15

; Function Attrs: nounwind ssp uwtable
declare i32 @btreeSetHasContent(%struct.BtShared* nocapture, i32) local_unnamed_addr #3

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i32 @btreeGetHasContent(%struct.BtShared* nocapture readonly, i32) local_unnamed_addr #7

; Function Attrs: nounwind ssp uwtable
declare void @btreeClearHasContent(%struct.BtShared* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @btreeReleaseAllCursorPages(%struct.BtCursor* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @releasePageNotNull(%struct.MemPage* nocapture readonly) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @saveCursorKey(%struct.BtCursor*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @saveCursorPosition(%struct.BtCursor*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @saveAllCursors(%struct.BtShared* nocapture readonly, i32, %struct.BtCursor*) local_unnamed_addr #3

; Function Attrs: noinline nounwind ssp uwtable
declare i32 @saveCursorsOnList(%struct.BtCursor*, i32, %struct.BtCursor* readnone) local_unnamed_addr #1

; Function Attrs: nounwind ssp uwtable
declare i32 @btreeMoveto(%struct.BtCursor*, i8*, i64, i32, i32* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @btreeRestoreCursorPosition(%struct.BtCursor*) local_unnamed_addr #3

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i32 @ptrmapPageno(%struct.BtShared* nocapture readonly, i32) local_unnamed_addr #7

; Function Attrs: nounwind ssp uwtable
declare void @ptrmapPut(%struct.BtShared* nocapture readonly, i32, i8 zeroext, i32, i32* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @ptrmapGet(%struct.BtShared* nocapture readonly, i32, i8* nocapture, i32*) local_unnamed_addr #3

; Function Attrs: nofree noinline norecurse nounwind ssp uwtable
declare void @btreeParseCellAdjustSizeForOverflow(%struct.MemPage* nocapture readonly, i8*, %struct.CellInfo* nocapture) local_unnamed_addr #21

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare void @btreeParseCellPtrNoPayload(%struct.MemPage* nocapture readnone, i8* nocapture readonly, %struct.CellInfo* nocapture) #15

; Function Attrs: alwaysinline nofree norecurse nounwind ssp uwtable
define dso_local zeroext i8 @sqlite3GetVarint(i8* nocapture readonly %p, i64* nocapture %v) unnamed_addr #2 {
entry:
  %0 = load i8, i8* %p, align 1, !tbaa !10
  %cmp = icmp sgt i8 %0, -1
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %conv2 = zext i8 %0 to i64
  br label %cleanup

if.end:                                           ; preds = %entry
  %arrayidx3 = getelementptr inbounds i8, i8* %p, i64 1
  %1 = load i8, i8* %arrayidx3, align 1, !tbaa !10
  %cmp5 = icmp sgt i8 %1, -1
  %conv9 = zext i8 %0 to i32
  br i1 %cmp5, label %if.then7, label %if.end13

if.then7:                                         ; preds = %if.end
  %and = shl nuw nsw i32 %conv9, 7
  %shl = and i32 %and, 16256
  %conv11 = zext i8 %1 to i32
  %or = or i32 %shl, %conv11
  %conv12 = zext i32 %or to i64
  br label %cleanup

if.end13:                                         ; preds = %if.end
  %shl16 = shl nuw nsw i32 %conv9, 14
  %conv18 = zext i8 %1 to i32
  %add.ptr = getelementptr inbounds i8, i8* %p, i64 2
  %2 = load i8, i8* %add.ptr, align 1, !tbaa !10
  %conv19 = zext i8 %2 to i32
  %or20 = or i32 %shl16, %conv19
  %tobool = icmp slt i8 %2, 0
  %and29 = and i32 %or20, 2080895
  br i1 %tobool, label %if.end28, label %if.then22

if.then22:                                        ; preds = %if.end13
  %and24 = shl nuw nsw i32 %conv18, 7
  %shl25 = and i32 %and24, 16256
  %or26 = or i32 %and29, %shl25
  %conv27 = zext i32 %or26 to i64
  br label %cleanup

if.end28:                                         ; preds = %if.end13
  %incdec.ptr = getelementptr inbounds i8, i8* %p, i64 3
  %shl30 = shl nuw nsw i32 %conv18, 14
  %3 = load i8, i8* %incdec.ptr, align 1, !tbaa !10
  %conv31 = zext i8 %3 to i32
  %or32 = or i32 %shl30, %conv31
  %tobool34 = icmp slt i8 %3, 0
  %and41 = and i32 %or32, 2080895
  br i1 %tobool34, label %if.end40, label %if.then35

if.then35:                                        ; preds = %if.end28
  %shl37 = shl nuw nsw i32 %and29, 7
  %or38 = or i32 %and41, %shl37
  %conv39 = zext i32 %or38 to i64
  br label %cleanup

if.end40:                                         ; preds = %if.end28
  %incdec.ptr42 = getelementptr inbounds i8, i8* %p, i64 4
  %shl43 = shl i32 %and29, 14
  %4 = load i8, i8* %incdec.ptr42, align 1, !tbaa !10
  %conv44 = zext i8 %4 to i32
  %or45 = or i32 %shl43, %conv44
  %tobool47 = icmp slt i8 %4, 0
  br i1 %tobool47, label %if.end55, label %if.then48

if.then48:                                        ; preds = %if.end40
  %shl49 = shl nuw nsw i32 %and41, 7
  %or50 = or i32 %or45, %shl49
  %shr = lshr i32 %and29, 18
  %conv51 = zext i32 %shr to i64
  %shl52 = shl nuw nsw i64 %conv51, 32
  %conv53 = zext i32 %or50 to i64
  %or54 = or i64 %shl52, %conv53
  br label %cleanup

if.end55:                                         ; preds = %if.end40
  %shl56 = shl nuw nsw i32 %and29, 7
  %or57 = or i32 %and41, %shl56
  %incdec.ptr58 = getelementptr inbounds i8, i8* %p, i64 5
  %shl59 = shl i32 %and41, 14
  %5 = load i8, i8* %incdec.ptr58, align 1, !tbaa !10
  %conv60 = zext i8 %5 to i32
  %or61 = or i32 %shl59, %conv60
  %tobool63 = icmp slt i8 %5, 0
  br i1 %tobool63, label %if.end73, label %if.then64

if.then64:                                        ; preds = %if.end55
  %and65 = shl i32 %or45, 7
  %shl66 = and i32 %and65, 266354560
  %or67 = or i32 %or61, %shl66
  %shr68 = lshr i32 %or57, 18
  %conv69 = zext i32 %shr68 to i64
  %shl70 = shl nuw nsw i64 %conv69, 32
  %conv71 = zext i32 %or67 to i64
  %or72 = or i64 %shl70, %conv71
  br label %cleanup

if.end73:                                         ; preds = %if.end55
  %incdec.ptr74 = getelementptr inbounds i8, i8* %p, i64 6
  %shl75 = shl i32 %or45, 14
  %6 = load i8, i8* %incdec.ptr74, align 1, !tbaa !10
  %conv76 = zext i8 %6 to i32
  %or77 = or i32 %shl75, %conv76
  %tobool79 = icmp slt i8 %6, 0
  br i1 %tobool79, label %if.end90, label %if.then80

if.then80:                                        ; preds = %if.end73
  %and81 = and i32 %or77, -266354561
  %and82 = shl i32 %or61, 7
  %shl83 = and i32 %and82, 266354560
  %or84 = or i32 %and81, %shl83
  %shr85 = lshr i32 %or57, 11
  %conv86 = zext i32 %shr85 to i64
  %shl87 = shl nuw nsw i64 %conv86, 32
  %conv88 = zext i32 %or84 to i64
  %or89 = or i64 %shl87, %conv88
  br label %cleanup

if.end90:                                         ; preds = %if.end73
  %and91 = and i32 %or77, 2080895
  %incdec.ptr92 = getelementptr inbounds i8, i8* %p, i64 7
  %shl93 = shl i32 %or61, 14
  %7 = load i8, i8* %incdec.ptr92, align 1, !tbaa !10
  %conv94 = zext i8 %7 to i32
  %or95 = or i32 %shl93, %conv94
  %tobool97 = icmp slt i8 %7, 0
  br i1 %tobool97, label %if.end107, label %if.then98

if.then98:                                        ; preds = %if.end90
  %and99 = and i32 %or95, -266354561
  %shl100 = shl nuw nsw i32 %and91, 7
  %or101 = or i32 %and99, %shl100
  %shr102 = lshr i32 %or57, 4
  %conv103 = zext i32 %shr102 to i64
  %shl104 = shl nuw nsw i64 %conv103, 32
  %conv105 = zext i32 %or101 to i64
  %or106 = or i64 %shl104, %conv105
  br label %cleanup

if.end107:                                        ; preds = %if.end90
  %incdec.ptr108 = getelementptr inbounds i8, i8* %p, i64 8
  %shl109 = shl i32 %and91, 15
  %8 = load i8, i8* %incdec.ptr108, align 1, !tbaa !10
  %conv110 = zext i8 %8 to i32
  %and112 = shl i32 %or95, 8
  %shl113 = and i32 %and112, 532709120
  %or111 = or i32 %shl113, %shl109
  %or114 = or i32 %or111, %conv110
  %shl115 = shl nuw i32 %or57, 4
  %9 = lshr i8 %4, 3
  %10 = and i8 %9, 15
  %shr119 = zext i8 %10 to i32
  %or120 = or i32 %shl115, %shr119
  %conv121 = zext i32 %or120 to i64
  %shl122 = shl nuw i64 %conv121, 32
  %conv123 = zext i32 %or114 to i64
  %or124 = or i64 %shl122, %conv123
  br label %cleanup

cleanup:                                          ; preds = %if.end107, %if.then98, %if.then80, %if.then64, %if.then48, %if.then35, %if.then22, %if.then7, %if.then
  %or124.sink = phi i64 [ %or124, %if.end107 ], [ %or106, %if.then98 ], [ %or89, %if.then80 ], [ %or72, %if.then64 ], [ %or54, %if.then48 ], [ %conv39, %if.then35 ], [ %conv27, %if.then22 ], [ %conv12, %if.then7 ], [ %conv2, %if.then ]
  %retval.0 = phi i8 [ 9, %if.end107 ], [ 8, %if.then98 ], [ 7, %if.then80 ], [ 6, %if.then64 ], [ 5, %if.then48 ], [ 4, %if.then35 ], [ 3, %if.then22 ], [ 2, %if.then7 ], [ 1, %if.then ]
  store i64 %or124.sink, i64* %v, align 8, !tbaa !16
  ret i8 %retval.0
}

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare void @btreeParseCellPtr(%struct.MemPage* nocapture readonly, i8*, %struct.CellInfo* nocapture) #15

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare void @btreeParseCellPtrIndex(%struct.MemPage* nocapture readonly, i8*, %struct.CellInfo* nocapture) #15

; Function Attrs: nounwind ssp uwtable
declare void @btreeParseCell(%struct.MemPage*, i32, %struct.CellInfo*) local_unnamed_addr #3

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare zeroext i16 @cellSizePtr(%struct.MemPage* nocapture readonly, i8*) #7

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare zeroext i16 @cellSizePtrNoPayload(%struct.MemPage* nocapture readnone, i8* nocapture readonly) #7

; Function Attrs: nounwind ssp uwtable
declare void @ptrmapPutOvflPtr(%struct.MemPage*, %struct.MemPage* nocapture readonly, i8*, i32* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @defragmentPage(%struct.MemPage*, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i8* @pageFindSlot(%struct.MemPage* nocapture readonly, i32, i32* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @allocateSpace(%struct.MemPage*, i32, i32* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @freeSpace(%struct.MemPage* nocapture, i16 zeroext, i16 zeroext) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @decodeFlags(%struct.MemPage* nocapture, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @btreeComputeFreeSpace(%struct.MemPage* nocapture) local_unnamed_addr #3

; Function Attrs: noinline nounwind ssp uwtable
declare i32 @btreeCellSizeCheck(%struct.MemPage*) local_unnamed_addr #1

; Function Attrs: nounwind ssp uwtable
declare i32 @btreeInitPage(%struct.MemPage*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @zeroPage(%struct.MemPage*, i32) local_unnamed_addr #3

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare %struct.MemPage* @btreePageFromDbPage(%struct.PgHdr*, i32, %struct.BtShared*) local_unnamed_addr #15

; Function Attrs: nounwind ssp uwtable
declare i32 @btreeGetPage(%struct.BtShared*, i32, %struct.MemPage** nocapture, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare %struct.MemPage* @btreePageLookup(%struct.BtShared*, i32) local_unnamed_addr #3

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i32 @btreePagecount(%struct.BtShared* nocapture readonly) local_unnamed_addr #7

; Function Attrs: nounwind ssp uwtable
declare i32 @getAndInitPage(%struct.BtShared*, i32, %struct.MemPage** nocapture, %struct.BtCursor*, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @releasePage(%struct.MemPage* readonly) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @releasePageOne(%struct.MemPage* nocapture readonly) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @btreeGetUnusedPage(%struct.BtShared*, i32, %struct.MemPage** nocapture, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @pageReinit(%struct.PgHdr* nocapture readonly) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @btreeInvokeBusyHandler(i8* nocapture readonly) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @removeFromSharingList(%struct.BtShared*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @allocateTempSpace(%struct.BtShared* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @freeTempSpace(%struct.BtShared* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @lockBtree(%struct.BtShared*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3PagerSharedLock(%struct.Pager*) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @unlockBtreeIfUnused(%struct.BtShared* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @newDatabase(%struct.BtShared* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @setChildPtrmaps(%struct.MemPage*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @modifyPagePointer(%struct.MemPage*, i32, i32, i8 zeroext) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @relocatePage(%struct.BtShared*, %struct.MemPage*, i8 zeroext, i32, i32, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @incrVacuumStep(%struct.BtShared*, i32, i32, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @allocateBtreePage(%struct.BtShared*, %struct.MemPage** nocapture, i32* nocapture, i32, i8 zeroext) local_unnamed_addr #3

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i32 @finalDbSize(%struct.BtShared* nocapture readonly, i32, i32) local_unnamed_addr #7

; Function Attrs: nounwind ssp uwtable
declare i32 @autoVacuumCommit(%struct.BtShared*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @btreeEndTransaction(%struct.Btree*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @btreeSetNPage(%struct.BtShared* nocapture, %struct.MemPage* nocapture readonly) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @btreeCursor(%struct.Btree*, i32, i32, %struct.KeyInfo*, %struct.BtCursor*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @btreeCursorWithLock(%struct.Btree*, i32, i32, %struct.KeyInfo*, %struct.BtCursor*) local_unnamed_addr #3

; Function Attrs: noinline nounwind ssp uwtable
declare void @getCellInfo(%struct.BtCursor*) local_unnamed_addr #1

; Function Attrs: nounwind ssp uwtable
declare i32 @getOverflowPage(%struct.BtShared*, i32, %struct.MemPage**, i32* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @copyPayload(i8*, i8*, i32, i32, %struct.PgHdr*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @accessPayload(%struct.BtCursor*, i32, i32, i8*, i32) local_unnamed_addr #3

; Function Attrs: noinline nounwind ssp uwtable
declare i32 @accessPayloadChecked(%struct.BtCursor*, i32, i32, i8*) local_unnamed_addr #1

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare i8* @fetchPayload(%struct.BtCursor* nocapture readonly, i32* nocapture) local_unnamed_addr #15

; Function Attrs: nounwind ssp uwtable
declare i32 @moveToChild(%struct.BtCursor*, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @moveToParent(%struct.BtCursor* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @moveToRoot(%struct.BtCursor*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @moveToLeftmost(%struct.BtCursor*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @moveToRightmost(%struct.BtCursor*) local_unnamed_addr #3

; Function Attrs: noinline nounwind ssp uwtable
declare i32 @btreeNext(%struct.BtCursor*) local_unnamed_addr #1

; Function Attrs: noinline nounwind ssp uwtable
declare i32 @btreePrevious(%struct.BtCursor*) local_unnamed_addr #1

; Function Attrs: nounwind ssp uwtable
declare i32 @freePage2(%struct.BtShared*, %struct.MemPage*, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @freePage(%struct.MemPage*, i32* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @clearCell(%struct.MemPage*, i8*, %struct.CellInfo*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @fillInCell(%struct.MemPage* nocapture readonly, i8*, %struct.BtreePayload* nocapture readonly, i32* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @dropCell(%struct.MemPage* nocapture, i32, i32, i32* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @insertCell(%struct.MemPage*, i32, i8*, i32, i8*, i32, i32* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @populateCellCache(%struct.CellArray* nocapture readonly, i32, i32) local_unnamed_addr #3

; Function Attrs: noinline nounwind ssp uwtable
declare zeroext i16 @computeCellSize(%struct.CellArray* nocapture readonly, i32) local_unnamed_addr #1

; Function Attrs: nounwind ssp uwtable
declare zeroext i16 @cachedCellSize(%struct.CellArray* nocapture readonly, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @rebuildPage(%struct.CellArray* nocapture readonly, i32, i32, %struct.MemPage* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @pageInsertArray(%struct.MemPage* nocapture readonly, i8*, i8** nocapture, i8* nocapture, i32, i32, %struct.CellArray* nocapture readonly) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @pageFreeArray(%struct.MemPage* nocapture, i32, i32, %struct.CellArray* nocapture readonly) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @editPage(%struct.MemPage*, i32, i32, i32, %struct.CellArray* nocapture readonly) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @balance_quick(%struct.MemPage*, %struct.MemPage*, i8*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @copyNodeContent(%struct.MemPage* nocapture readonly, %struct.MemPage*, i32* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @balance_nonroot(%struct.MemPage*, i32, i8*, i32, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @balance_deeper(%struct.MemPage*, %struct.MemPage** nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @anotherValidCursor(%struct.BtCursor* readonly) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @balance(%struct.BtCursor*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @btreeOverwriteContent(%struct.MemPage* nocapture readonly, i8*, %struct.BtreePayload* nocapture readonly, i32, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @btreeOverwriteCell(%struct.BtCursor* nocapture readonly, %struct.BtreePayload* nocapture readonly) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @btreeCreateTable(%struct.Btree* nocapture, i32* nocapture, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @clearDatabasePage(%struct.BtShared*, i32, i32, i32*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @btreeDropTable(%struct.Btree*, i32, i32* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @checkAppendMsg(%struct.IntegrityCk*, i8*, ...) local_unnamed_addr #3

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i32 @getPageReferenced(%struct.IntegrityCk* nocapture readonly, i32) local_unnamed_addr #7

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare void @setPageReferenced(%struct.IntegrityCk* nocapture readonly, i32) local_unnamed_addr #15

; Function Attrs: nounwind ssp uwtable
declare i32 @checkRef(%struct.IntegrityCk*, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @checkPtrmap(%struct.IntegrityCk*, i32, i8 zeroext, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @checkList(%struct.IntegrityCk*, i32, i32, i32) local_unnamed_addr #3

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare void @btreeHeapInsert(i32* nocapture, i32) local_unnamed_addr #15

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare i32 @btreeHeapPull(i32* nocapture, i32* nocapture) local_unnamed_addr #15

; Function Attrs: nounwind ssp uwtable
declare i32 @checkTreePage(%struct.IntegrityCk*, i32, i64* nocapture, i64) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare %struct.Btree* @findBtree(%struct.sqlite3*, %struct.sqlite3*, i8*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3OpenTempDatabase(%struct.Parse* nocapture) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3ErrorWithMsg(%struct.sqlite3*, i32, i8*, ...) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @setDestPgsz(%struct.sqlite3_backup* nocapture readonly) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3BtreeSetPageSize(%struct.Btree* nocapture, i32, i32, i32) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @checkReadTransaction(%struct.sqlite3*, %struct.Btree* nocapture readonly) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare %struct.sqlite3_backup* @sqlite3_backup_init(%struct.sqlite3*, i8*, %struct.sqlite3*, i8*) #3

; Function Attrs: norecurse nounwind readnone ssp uwtable
declare i32 @isFatalError(i32) local_unnamed_addr #11

; Function Attrs: nounwind ssp uwtable
declare i32 @backupOnePage(%struct.sqlite3_backup* nocapture readonly, i32, i8*, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @backupTruncateFile(%struct.sqlite3_file*, i64) local_unnamed_addr #3

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare void @attachBackupObject(%struct.sqlite3_backup*) local_unnamed_addr #15

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_backup_step(%struct.sqlite3_backup*, i32) #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3ResetAllSchemasOfConnection(%struct.sqlite3*) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3PagerCommitPhaseOne(%struct.Pager*, i8*, i32) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3BtreeCommitPhaseTwo(%struct.Btree*, i32) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3BtreeCommitPhaseOne(%struct.Btree* nocapture, i8*) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_backup_finish(%struct.sqlite3_backup*) #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3BtreeRollback(%struct.Btree*, i32, i32) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3LeaveMutexAndCloseZombie(%struct.sqlite3*) unnamed_addr #3

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i32 @sqlite3_backup_remaining(%struct.sqlite3_backup* nocapture readonly) #7

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i32 @sqlite3_backup_pagecount(%struct.sqlite3_backup* nocapture readonly) #7

; Function Attrs: noinline nounwind ssp uwtable
declare void @backupUpdate(%struct.sqlite3_backup* nocapture, i32, i8*) local_unnamed_addr #1

; Function Attrs: nounwind ssp uwtable
declare void @vdbeMemRenderNum(i32, i8*, %struct.sqlite3_value* nocapture readonly) local_unnamed_addr #3

; Function Attrs: noinline nounwind ssp uwtable
declare i32 @vdbeMemAddTerminator(%struct.sqlite3_value*) local_unnamed_addr #1

; Function Attrs: noinline nounwind ssp uwtable
declare void @vdbeMemClear(%struct.sqlite3_value*) local_unnamed_addr #1

; Function Attrs: alwaysinline norecurse nounwind readnone ssp uwtable
define i64 @doubleToInt64(double %r) local_unnamed_addr #22 {
entry:
  %cmp = fcmp ugt double %r, 0xC3E0000000000000
  br i1 %cmp, label %if.else, label %return

if.else:                                          ; preds = %entry
  %cmp1 = fcmp ult double %r, 0x43E0000000000000
  br i1 %cmp1, label %if.else3, label %return

if.else3:                                         ; preds = %if.else
  %conv = fptosi double %r to i64
  br label %return

return:                                           ; preds = %if.else3, %if.else, %entry
  %retval.0 = phi i64 [ %conv, %if.else3 ], [ -9223372036854775808, %entry ], [ 9223372036854775807, %if.else ]
  ret i64 %retval.0
}

; Function Attrs: noinline nounwind ssp uwtable
declare i64 @memIntValue(%struct.sqlite3_value* nocapture readonly) local_unnamed_addr #1

; Function Attrs: alwaysinline nofree norecurse nounwind ssp uwtable
define dso_local i32 @sqlite3Atoi64(i8* readonly %zNum, i64* nocapture %pNum, i32 %length, i8 zeroext %enc) unnamed_addr #2 {
entry:
  %conv = zext i8 %enc to i32
  %cmp = icmp eq i8 %enc, 1
  br i1 %cmp, label %if.end, label %if.else

if.else:                                          ; preds = %entry
  %sub = sub nsw i32 3, %conv
  %cmp3255 = icmp slt i32 %sub, %length
  br i1 %cmp3255, label %land.rhs.preheader, label %for.end

land.rhs.preheader:                               ; preds = %if.else
  %0 = sext i32 %sub to i64
  %1 = sext i32 %length to i64
  br label %land.rhs

land.rhs:                                         ; preds = %for.inc, %land.rhs.preheader
  %indvars.iv266 = phi i64 [ %0, %land.rhs.preheader ], [ %indvars.iv.next267, %for.inc ]
  %i.0256 = phi i32 [ %sub, %land.rhs.preheader ], [ %add, %for.inc ]
  %arrayidx = getelementptr inbounds i8, i8* %zNum, i64 %indvars.iv266
  %2 = load i8, i8* %arrayidx, align 1, !tbaa !10
  %cmp6 = icmp eq i8 %2, 0
  br i1 %cmp6, label %for.inc, label %for.end.loopexit.split.loop.exit295

for.inc:                                          ; preds = %land.rhs
  %indvars.iv.next267 = add i64 %indvars.iv266, 2
  %add = add nsw i32 %i.0256, 2
  %cmp3 = icmp slt i64 %indvars.iv.next267, %1
  br i1 %cmp3, label %land.rhs, label %for.end

for.end.loopexit.split.loop.exit295:              ; preds = %land.rhs
  %3 = trunc i64 %indvars.iv266 to i32
  br label %for.end

for.end:                                          ; preds = %for.end.loopexit.split.loop.exit295, %for.inc, %if.else
  %i.0.lcssa = phi i32 [ %sub, %if.else ], [ %3, %for.end.loopexit.split.loop.exit295 ], [ %add, %for.inc ]
  %cmp3.lcssa = phi i32 [ 0, %if.else ], [ 1, %for.end.loopexit.split.loop.exit295 ], [ 0, %for.inc ]
  %xor = xor i32 %i.0.lcssa, 1
  %and = and i32 %conv, 1
  %idx.ext13 = zext i32 %and to i64
  %add.ptr14 = getelementptr inbounds i8, i8* %zNum, i64 %idx.ext13
  br label %if.end

if.end:                                           ; preds = %for.end, %entry
  %zNum.addr.0 = phi i8* [ %add.ptr14, %for.end ], [ %zNum, %entry ]
  %incr.0 = phi i32 [ 2, %for.end ], [ 1, %entry ]
  %nonNum.0 = phi i32 [ %cmp3.lcssa, %for.end ], [ 0, %entry ]
  %idx.ext.pn.in = phi i32 [ %xor, %for.end ], [ %length, %entry ]
  %idx.ext.pn = sext i32 %idx.ext.pn.in to i64
  %zEnd.0 = getelementptr inbounds i8, i8* %zNum, i64 %idx.ext.pn
  %cmp15252 = icmp ult i8* %zNum.addr.0, %zEnd.0
  br i1 %cmp15252, label %land.rhs17.lr.ph, label %if.end43

land.rhs17.lr.ph:                                 ; preds = %if.end
  %idx.ext23 = zext i32 %incr.0 to i64
  br label %land.rhs17

land.rhs17:                                       ; preds = %while.body, %land.rhs17.lr.ph
  %zNum.addr.1253 = phi i8* [ %zNum.addr.0, %land.rhs17.lr.ph ], [ %add.ptr24, %while.body ]
  %4 = load i8, i8* %zNum.addr.1253, align 1, !tbaa !10
  %idxprom18 = zext i8 %4 to i64
  %arrayidx19 = getelementptr inbounds [256 x i8], [256 x i8]* @sqlite3CtypeMap, i64 0, i64 %idxprom18
  %5 = load i8, i8* %arrayidx19, align 1, !tbaa !10
  %6 = and i8 %5, 1
  %tobool = icmp eq i8 %6, 0
  br i1 %tobool, label %if.then27, label %while.body

while.body:                                       ; preds = %land.rhs17
  %add.ptr24 = getelementptr inbounds i8, i8* %zNum.addr.1253, i64 %idx.ext23
  %cmp15 = icmp ult i8* %add.ptr24, %zEnd.0
  br i1 %cmp15, label %land.rhs17, label %if.end43

if.then27:                                        ; preds = %land.rhs17
  switch i8 %4, label %if.end43 [
    i8 45, label %if.then31
    i8 43, label %if.then38
  ]

if.then31:                                        ; preds = %if.then27
  %add.ptr33 = getelementptr inbounds i8, i8* %zNum.addr.1253, i64 %idx.ext23
  br label %if.end43

if.then38:                                        ; preds = %if.then27
  %add.ptr40 = getelementptr inbounds i8, i8* %zNum.addr.1253, i64 %idx.ext23
  br label %if.end43

if.end43:                                         ; preds = %if.then38, %if.then31, %if.then27, %while.body, %if.end
  %zNum.addr.2 = phi i8* [ %add.ptr33, %if.then31 ], [ %add.ptr40, %if.then38 ], [ %zNum.addr.1253, %if.then27 ], [ %zNum.addr.0, %if.end ], [ %add.ptr24, %while.body ]
  %neg.0 = phi i32 [ 1, %if.then31 ], [ 0, %if.then38 ], [ 0, %if.then27 ], [ 0, %if.end ], [ 0, %while.body ]
  %cmp45248 = icmp ult i8* %zNum.addr.2, %zEnd.0
  br i1 %cmp45248, label %land.rhs47.lr.ph, label %while.end56

land.rhs47.lr.ph:                                 ; preds = %if.end43
  %idx.ext54 = zext i32 %incr.0 to i64
  br label %land.rhs47

land.rhs47:                                       ; preds = %while.body53, %land.rhs47.lr.ph
  %zNum.addr.3249 = phi i8* [ %zNum.addr.2, %land.rhs47.lr.ph ], [ %add.ptr55, %while.body53 ]
  %7 = load i8, i8* %zNum.addr.3249, align 1, !tbaa !10
  %cmp50 = icmp eq i8 %7, 48
  br i1 %cmp50, label %while.body53, label %while.end56

while.body53:                                     ; preds = %land.rhs47
  %add.ptr55 = getelementptr inbounds i8, i8* %zNum.addr.3249, i64 %idx.ext54
  %cmp45 = icmp ult i8* %add.ptr55, %zEnd.0
  br i1 %cmp45, label %land.rhs47, label %while.end56

while.end56:                                      ; preds = %while.body53, %land.rhs47, %if.end43
  %zNum.addr.3.lcssa = phi i8* [ %zNum.addr.2, %if.end43 ], [ %add.ptr55, %while.body53 ], [ %zNum.addr.3249, %land.rhs47 ]
  %cmp60238 = icmp ult i8* %zNum.addr.3.lcssa, %zEnd.0
  br i1 %cmp60238, label %land.end70.preheader, label %for.end77.thread

for.end77.thread:                                 ; preds = %while.end56
  %tobool81272 = icmp eq i32 %neg.0, 0
  br i1 %tobool81272, label %if.end88, label %if.then84

land.end70.preheader:                             ; preds = %while.end56
  %8 = zext i32 %incr.0 to i64
  br label %land.end70

land.end70:                                       ; preds = %for.body71, %land.end70.preheader
  %indvars.iv264 = phi i64 [ 0, %land.end70.preheader ], [ %indvars.iv.next265, %for.body71 ]
  %arrayidx59241 = phi i8* [ %zNum.addr.3.lcssa, %land.end70.preheader ], [ %arrayidx59, %for.body71 ]
  %i.1240 = phi i32 [ 0, %land.end70.preheader ], [ %add76, %for.body71 ]
  %u.0239 = phi i64 [ 0, %land.end70.preheader ], [ %sub74, %for.body71 ]
  %9 = load i8, i8* %arrayidx59241, align 1, !tbaa !10
  %.off = add i8 %9, -48
  %10 = icmp ult i8 %.off, 10
  br i1 %10, label %for.body71, label %for.end77.split.loop.exit

for.body71:                                       ; preds = %land.end70
  %mul = mul i64 %u.0239, 10
  %conv72288 = zext i8 %9 to i64
  %add73 = add i64 %mul, -48
  %sub74 = add i64 %add73, %conv72288
  %indvars.iv.next265 = add i64 %indvars.iv264, %8
  %add76 = add nuw nsw i32 %i.1240, %incr.0
  %arrayidx59 = getelementptr inbounds i8, i8* %zNum.addr.3.lcssa, i64 %indvars.iv.next265
  %cmp60 = icmp ult i8* %arrayidx59, %zEnd.0
  br i1 %cmp60, label %land.end70, label %for.end77

for.end77.split.loop.exit:                        ; preds = %land.end70
  %11 = trunc i64 %indvars.iv264 to i32
  br label %for.end77

for.end77:                                        ; preds = %for.end77.split.loop.exit, %for.body71
  %u.0.lcssa = phi i64 [ %u.0239, %for.end77.split.loop.exit ], [ %sub74, %for.body71 ]
  %i.1.lcssa = phi i32 [ %11, %for.end77.split.loop.exit ], [ %add76, %for.body71 ]
  %cmp60.lcssa = phi i1 [ true, %for.end77.split.loop.exit ], [ false, %for.body71 ]
  %cmp78 = icmp slt i64 %u.0.lcssa, 0
  %tobool81 = icmp ne i32 %neg.0, 0
  br i1 %cmp78, label %if.then80, label %if.else82

if.then80:                                        ; preds = %for.end77
  %cond = select i1 %tobool81, i64 -9223372036854775808, i64 9223372036854775807
  br label %if.end88

if.else82:                                        ; preds = %for.end77
  br i1 %tobool81, label %if.then84, label %if.end88

if.then84:                                        ; preds = %if.else82, %for.end77.thread
  %u.0.lcssa273286 = phi i64 [ 0, %for.end77.thread ], [ %u.0.lcssa, %if.else82 ]
  %i.1.lcssa275284 = phi i32 [ 0, %for.end77.thread ], [ %i.1.lcssa, %if.else82 ]
  %cmp60.lcssa277282 = phi i1 [ false, %for.end77.thread ], [ %cmp60.lcssa, %if.else82 ]
  %sub85 = sub nsw i64 0, %u.0.lcssa273286
  br label %if.end88

if.end88:                                         ; preds = %if.then84, %if.else82, %if.then80, %for.end77.thread
  %sub85.sink = phi i64 [ %sub85, %if.then84 ], [ %cond, %if.then80 ], [ 0, %for.end77.thread ], [ %u.0.lcssa, %if.else82 ]
  %tobool81279 = phi i1 [ true, %if.then84 ], [ %tobool81, %if.then80 ], [ false, %for.end77.thread ], [ false, %if.else82 ]
  %cmp60.lcssa276 = phi i1 [ %cmp60.lcssa277282, %if.then84 ], [ %cmp60.lcssa, %if.then80 ], [ false, %for.end77.thread ], [ %cmp60.lcssa, %if.else82 ]
  %i.1.lcssa274 = phi i32 [ %i.1.lcssa275284, %if.then84 ], [ %i.1.lcssa, %if.then80 ], [ 0, %for.end77.thread ], [ %i.1.lcssa, %if.else82 ]
  store i64 %sub85.sink, i64* %pNum, align 8, !tbaa !16
  %cmp89 = icmp eq i32 %i.1.lcssa274, 0
  %cmp92 = icmp eq i8* %zNum.addr.2, %zNum.addr.3.lcssa
  %or.cond = and i1 %cmp92, %cmp89
  br i1 %or.cond, label %if.end120, label %if.else95

if.else95:                                        ; preds = %if.end88
  %tobool96 = icmp ne i32 %nonNum.0, 0
  %cmp60.not = xor i1 %cmp60.lcssa276, true
  %brmerge = or i1 %tobool96, %cmp60.not
  br i1 %brmerge, label %if.end120, label %do.body.preheader

do.body.preheader:                                ; preds = %if.else95
  %12 = zext i32 %i.1.lcssa274 to i64
  %13 = zext i32 %incr.0 to i64
  br label %do.body

do.body:                                          ; preds = %if.end112, %do.body.preheader
  %indvars.iv = phi i64 [ %12, %do.body.preheader ], [ %indvars.iv.next, %if.end112 ]
  %arrayidx105 = getelementptr inbounds i8, i8* %zNum.addr.3.lcssa, i64 %indvars.iv
  %14 = load i8, i8* %arrayidx105, align 1, !tbaa !10
  %idxprom106 = zext i8 %14 to i64
  %arrayidx107 = getelementptr inbounds [256 x i8], [256 x i8]* @sqlite3CtypeMap, i64 0, i64 %idxprom106
  %15 = load i8, i8* %arrayidx107, align 1, !tbaa !10
  %16 = and i8 %15, 1
  %tobool110 = icmp eq i8 %16, 0
  br i1 %tobool110, label %if.end120, label %if.end112

if.end112:                                        ; preds = %do.body
  %indvars.iv.next = add i64 %indvars.iv, %13
  %arrayidx115 = getelementptr inbounds i8, i8* %zNum.addr.3.lcssa, i64 %indvars.iv.next
  %cmp116 = icmp ult i8* %arrayidx115, %zEnd.0
  br i1 %cmp116, label %do.body, label %if.end120

if.end120:                                        ; preds = %if.end112, %do.body, %if.else95, %if.end88
  %rc.1 = phi i32 [ -1, %if.end88 ], [ %nonNum.0, %if.else95 ], [ 1, %do.body ], [ 0, %if.end112 ]
  %mul121 = mul nuw nsw i32 %incr.0, 19
  %cmp122 = icmp ult i32 %i.1.lcssa274, %mul121
  br i1 %cmp122, label %cleanup, label %if.else125

if.else125:                                       ; preds = %if.end120
  %cmp127 = icmp ugt i32 %i.1.lcssa274, %mul121
  br i1 %cmp127, label %if.else133.thread, label %cond.false

if.else133.thread:                                ; preds = %if.else125
  %cond135233 = select i1 %tobool81279, i64 -9223372036854775808, i64 9223372036854775807
  store i64 %cond135233, i64* %pNum, align 8, !tbaa !16
  br label %cleanup

cond.false:                                       ; preds = %if.else125
  %17 = zext i32 %incr.0 to i64
  br label %for.body.i

for.body.i:                                       ; preds = %for.body.i, %cond.false
  %indvars.iv.i = phi i64 [ 0, %cond.false ], [ %indvars.iv.next.i, %for.body.i ]
  %18 = mul nuw nsw i64 %indvars.iv.i, %17
  %arrayidx.i = getelementptr inbounds i8, i8* %zNum.addr.3.lcssa, i64 %18
  %19 = load i8, i8* %arrayidx.i, align 1, !tbaa !10
  %conv.i = sext i8 %19 to i32
  %arrayidx3.i = getelementptr inbounds [19 x i8], [19 x i8]* @.str.33, i64 0, i64 %indvars.iv.i
  %20 = load i8, i8* %arrayidx3.i, align 1, !tbaa !10
  %conv4.i = sext i8 %20 to i32
  %sub.i = sub nsw i32 %conv.i, %conv4.i
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.i, 1
  %cmp.i = icmp eq i32 %sub.i, 0
  %cmp1.i = icmp ult i64 %indvars.iv.i, 17
  %21 = and i1 %cmp1.i, %cmp.i
  br i1 %21, label %for.body.i, label %for.end.i

for.end.i:                                        ; preds = %for.body.i
  %mul5.i = mul nsw i32 %sub.i, 10
  br i1 %cmp.i, label %if.then.i, label %cond.end

if.then.i:                                        ; preds = %for.end.i
  %mul8.i = mul nuw nsw i32 %incr.0, 18
  %idxprom9.i = zext i32 %mul8.i to i64
  %arrayidx10.i = getelementptr inbounds i8, i8* %zNum.addr.3.lcssa, i64 %idxprom9.i
  %22 = load i8, i8* %arrayidx10.i, align 1, !tbaa !10
  %conv11.i = sext i8 %22 to i32
  %sub12.i = add nsw i32 %conv11.i, -56
  br label %cond.end

cond.end:                                         ; preds = %if.then.i, %for.end.i
  %cond129 = phi i32 [ %sub12.i, %if.then.i ], [ %mul5.i, %for.end.i ]
  %cmp130 = icmp slt i32 %cond129, 0
  br i1 %cmp130, label %cleanup, label %if.else133

if.else133:                                       ; preds = %cond.end
  %cond135 = select i1 %tobool81279, i64 -9223372036854775808, i64 9223372036854775807
  store i64 %cond135, i64* %pNum, align 8, !tbaa !16
  %cmp136 = icmp eq i32 %cond129, 0
  %cond144 = select i1 %tobool81279, i32 %rc.1, i32 3
  %spec.select236 = select i1 %cmp136, i32 %cond144, i32 2
  ret i32 %spec.select236

cleanup:                                          ; preds = %cond.end, %if.else133.thread, %if.end120
  %23 = phi i32 [ 2, %if.else133.thread ], [ %rc.1, %cond.end ], [ %rc.1, %if.end120 ]
  ret i32 %23
}

; Function Attrs: noinline nounwind ssp uwtable
declare double @memRealValue(%struct.sqlite3_value* nocapture readonly) local_unnamed_addr #1

; Function Attrs: noinline nounwind ssp uwtable
declare void @vdbeReleaseAndSetInt64(%struct.sqlite3_value*, i64) local_unnamed_addr #1

; Function Attrs: noinline nounwind ssp uwtable
declare void @vdbeClrCopy(%struct.sqlite3_value*, %struct.sqlite3_value*, i32) local_unnamed_addr #1

; Function Attrs: noinline nounwind ssp uwtable
declare i8* @valueToText(%struct.sqlite3_value*, i8 zeroext) local_unnamed_addr #1

; Function Attrs: nounwind ssp uwtable
declare %struct.sqlite3_value* @valueNew(%struct.sqlite3*, %struct.ValueNewStat4Ctx* nocapture readnone) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @valueFromExpr(%struct.sqlite3*, %struct.Expr* nocapture readonly, i8 zeroext, i8 zeroext, %struct.sqlite3_value** nocapture, %struct.ValueNewStat4Ctx* readnone) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i8* @sqlite3MPrintf(%struct.sqlite3*, i8*, ...) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3VdbeMemNumerify(%struct.sqlite3_value* nocapture) unnamed_addr #3

; Function Attrs: noinline nounwind ssp uwtable
declare i32 @valueBytes(%struct.sqlite3_value*, i8 zeroext) local_unnamed_addr #1

; Function Attrs: nounwind ssp uwtable
declare i32 @growOpArray(%struct.Vdbe* nocapture, i32) local_unnamed_addr #3

; Function Attrs: noinline nounwind ssp uwtable
declare i32 @growOp3(%struct.Vdbe* nocapture, i32, i32, i32, i32) local_unnamed_addr #1

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3VdbeAddOp3(%struct.Vdbe*, i32, i32, i32, i32) unnamed_addr #3

; Function Attrs: noinline nounwind ssp uwtable
declare void @resizeResolveLabel(%struct.Parse* nocapture, %struct.Vdbe* nocapture readonly, i32) local_unnamed_addr #1

; Function Attrs: nounwind ssp uwtable
declare void @resolveP2Values(%struct.Vdbe* nocapture, i32* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @freeEphemeralFunction(%struct.sqlite3*, %struct.FuncDef*) local_unnamed_addr #3

; Function Attrs: noinline nounwind ssp uwtable
declare void @freeP4Mem(%struct.sqlite3*, %struct.sqlite3_value*) local_unnamed_addr #1

; Function Attrs: noinline nounwind ssp uwtable
declare void @freeP4FuncCtx(%struct.sqlite3*, %struct.sqlite3_context*) local_unnamed_addr #1

; Function Attrs: nounwind ssp uwtable
declare void @freeP4(%struct.sqlite3*, i32, i8*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @vdbeFreeOpArray(%struct.sqlite3*, %struct.VdbeOp*, i32) local_unnamed_addr #3

; Function Attrs: noinline nounwind ssp uwtable
declare void @vdbeChangeP4Full(%struct.Vdbe* nocapture readonly, %struct.VdbeOp*, i8*, i32) local_unnamed_addr #1

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3VdbeChangeP4(%struct.Vdbe*, i32, i8*, i32) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i8* @displayP4(%struct.VdbeOp* nocapture readonly, i8*, i32) local_unnamed_addr #3

; Function Attrs: noinline nounwind ssp uwtable
declare void @vdbeLeave(%struct.Vdbe* nocapture readonly) local_unnamed_addr #1

; Function Attrs: nofree norecurse nounwind ssp uwtable writeonly
declare void @initMemArray(%struct.sqlite3_value* nocapture, i32, %struct.sqlite3*, i16 zeroext) local_unnamed_addr #10

; Function Attrs: nounwind ssp uwtable
declare void @releaseMemArray(%struct.sqlite3_value*, i32) local_unnamed_addr #3

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare i8* @allocSpace(%struct.ReusableSpace* nocapture, i8* readnone, i64) local_unnamed_addr #15

; Function Attrs: nounwind ssp uwtable
declare void @closeCursorsInFrame(%struct.Vdbe* nocapture readonly) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @closeAllCursors(%struct.Vdbe* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3VdbeFrameRestore(%struct.VdbeFrame* nocapture) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @vdbeCommit(%struct.sqlite3*, %struct.Vdbe* nocapture readnone) local_unnamed_addr #3

; Function Attrs: noinline nounwind ssp uwtable
declare i32 @vdbeCloseStatement(%struct.Vdbe* nocapture, i32) local_unnamed_addr #1

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3BtreeSavepoint(%struct.Btree*, i32, i32) unnamed_addr #3

; Function Attrs: noinline nounwind ssp uwtable
declare i32 @handleMovedCursor(%struct.VdbeCursor* nocapture) local_unnamed_addr #1

; Function Attrs: nounwind ssp uwtable
declare i32 @serialGet(i8* nocapture readonly, i32, %struct.sqlite3_value*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @vdbeCompareMemString(%struct.sqlite3_value*, %struct.sqlite3_value*, %struct.CollSeq* nocapture readonly, i8*) local_unnamed_addr #3

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i32 @isAllZero(i8* nocapture readonly, i32) local_unnamed_addr #7

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i64 @vdbeRecordDecodeInt(i32, i8* readonly) local_unnamed_addr #7

; Function Attrs: nounwind ssp uwtable
declare i32 @vdbeRecordCompareInt(i32, i8*, %struct.UnpackedRecord*) #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3VdbeRecordCompare(i32, i8*, %struct.UnpackedRecord*) #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3VdbeRecordCompareWithSkip(i32, i8*, %struct.UnpackedRecord*, i32) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @vdbeRecordCompareString(i32, i8*, %struct.UnpackedRecord*) #3

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i32 @sqlite3_expired(%struct.sqlite3_stmt* readonly) #7

; Function Attrs: nounwind ssp uwtable
declare i32 @vdbeSafety(%struct.Vdbe* nocapture readonly) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @vdbeSafetyNotNull(%struct.Vdbe* readonly) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_finalize(%struct.sqlite3_stmt*) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_reset(%struct.sqlite3_stmt*) #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3VdbeReset(%struct.Vdbe*) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_clear_bindings(%struct.sqlite3_stmt* nocapture) #3

; Function Attrs: nounwind ssp uwtable
declare i8* @sqlite3_value_blob(%struct.sqlite3_value*) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_value_bytes16(%struct.sqlite3_value*) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_value_int(%struct.sqlite3_value* nocapture readonly) #3

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i32 @sqlite3_value_subtype(%struct.sqlite3_value* nocapture readonly) #7

; Function Attrs: nounwind readonly ssp uwtable
declare i8* @sqlite3_value_pointer(%struct.sqlite3_value* nocapture readonly, i8* readonly) #18

; Function Attrs: nounwind ssp uwtable
declare i8* @sqlite3_value_text16(%struct.sqlite3_value*) #3

; Function Attrs: nounwind ssp uwtable
declare i8* @sqlite3_value_text16be(%struct.sqlite3_value*) #3

; Function Attrs: nounwind ssp uwtable
declare i8* @sqlite3_value_text16le(%struct.sqlite3_value*) #3

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i32 @sqlite3_value_nochange(%struct.sqlite3_value* nocapture readonly) #7

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i32 @sqlite3_value_frombind(%struct.sqlite3_value* nocapture readonly) #7

; Function Attrs: nounwind ssp uwtable
declare %struct.sqlite3_value* @sqlite3_value_dup(%struct.sqlite3_value*) #3

; Function Attrs: nounwind ssp uwtable
declare void @sqlite3_value_free(%struct.sqlite3_value*) #3

; Function Attrs: nounwind ssp uwtable
declare void @setResultStrOrError(%struct.sqlite3_context* nocapture, i8*, i32, i8 zeroext, void (i8*)*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @invokeValueDestructor(i8*, void (i8*)*, %struct.sqlite3_context*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @sqlite3_result_blob(%struct.sqlite3_context* nocapture, i8*, i32, void (i8*)*) #3

; Function Attrs: nounwind ssp uwtable
declare void @sqlite3_result_blob64(%struct.sqlite3_context*, i8*, i64, void (i8*)*) #3

; Function Attrs: nounwind ssp uwtable
declare void @sqlite3_result_error16(%struct.sqlite3_context* nocapture, i8*, i32) #3

; Function Attrs: nounwind ssp uwtable
declare void @sqlite3_result_int(%struct.sqlite3_context* nocapture readonly, i32) #3

; Function Attrs: nounwind ssp uwtable
declare void @sqlite3_result_int64(%struct.sqlite3_context* nocapture readonly, i64) #3

; Function Attrs: nounwind ssp uwtable
declare void @sqlite3_result_null(%struct.sqlite3_context* nocapture readonly) #3

; Function Attrs: nounwind ssp uwtable
declare void @sqlite3_result_pointer(%struct.sqlite3_context* nocapture readonly, i8*, i8*, void (i8*)*) #3

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare void @sqlite3_result_subtype(%struct.sqlite3_context* nocapture readonly, i32) #15

; Function Attrs: nounwind ssp uwtable
declare void @sqlite3_result_text64(%struct.sqlite3_context*, i8*, i64, void (i8*)*, i8 zeroext) #3

; Function Attrs: nounwind ssp uwtable
declare void @sqlite3_result_text16(%struct.sqlite3_context* nocapture, i8*, i32, void (i8*)*) #3

; Function Attrs: nounwind ssp uwtable
declare void @sqlite3_result_text16be(%struct.sqlite3_context* nocapture, i8*, i32, void (i8*)*) #3

; Function Attrs: nounwind ssp uwtable
declare void @sqlite3_result_text16le(%struct.sqlite3_context* nocapture, i8*, i32, void (i8*)*) #3

; Function Attrs: nounwind ssp uwtable
declare void @sqlite3_result_value(%struct.sqlite3_context* nocapture readonly, %struct.sqlite3_value*) #3

; Function Attrs: nounwind ssp uwtable
declare void @sqlite3_result_zeroblob(%struct.sqlite3_context* nocapture readonly, i32) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_result_zeroblob64(%struct.sqlite3_context* nocapture readonly, i64) #3

; Function Attrs: nounwind ssp uwtable
declare void @sqlite3_result_error_code(%struct.sqlite3_context* nocapture, i32) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @doWalCallbacks(%struct.sqlite3*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_step(%struct.sqlite3_stmt*) #3

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i8* @sqlite3_user_data(%struct.sqlite3_context* nocapture readonly) #7

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i32 @sqlite3_vtab_nochange(%struct.sqlite3_context* nocapture readonly) #7

; Function Attrs: noinline nounwind ssp uwtable
declare i8* @createAggContext(%struct.sqlite3_context* nocapture readonly, i32) local_unnamed_addr #1

; Function Attrs: nounwind ssp uwtable
declare i8* @sqlite3_aggregate_context(%struct.sqlite3_context* nocapture readonly, i32) #3

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i8* @sqlite3_get_auxdata(%struct.sqlite3_context* nocapture readonly, i32) #7

; Function Attrs: nounwind ssp uwtable
declare void @sqlite3_set_auxdata(%struct.sqlite3_context* nocapture, i32, i8*, void (i8*)*) #3

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i32 @sqlite3_aggregate_count(%struct.sqlite3_context* nocapture readonly) #7

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i32 @sqlite3_column_count(%struct.sqlite3_stmt* readonly) #7

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i32 @sqlite3_data_count(%struct.sqlite3_stmt* readonly) #7

; Function Attrs: norecurse nounwind readnone ssp uwtable
declare nonnull %struct.sqlite3_value* @columnNullValue() local_unnamed_addr #11

; Function Attrs: nounwind ssp uwtable
declare %struct.sqlite3_value* @columnMem(%struct.sqlite3_stmt* readonly, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @columnMallocFailure(%struct.sqlite3_stmt*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i8* @sqlite3_column_blob(%struct.sqlite3_stmt*, i32) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_column_bytes(%struct.sqlite3_stmt*, i32) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_column_bytes16(%struct.sqlite3_stmt*, i32) #3

; Function Attrs: nounwind ssp uwtable
declare double @sqlite3_column_double(%struct.sqlite3_stmt*, i32) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_column_int(%struct.sqlite3_stmt*, i32) #3

; Function Attrs: nounwind ssp uwtable
declare i64 @sqlite3_column_int64(%struct.sqlite3_stmt*, i32) #3

; Function Attrs: nounwind ssp uwtable
declare i8* @sqlite3_column_text(%struct.sqlite3_stmt*, i32) #3

; Function Attrs: nounwind ssp uwtable
declare %struct.sqlite3_value* @sqlite3_column_value(%struct.sqlite3_stmt*, i32) #3

; Function Attrs: nounwind ssp uwtable
declare i8* @sqlite3_column_text16(%struct.sqlite3_stmt*, i32) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_column_type(%struct.sqlite3_stmt*, i32) #3

; Function Attrs: nounwind ssp uwtable
declare i8* @columnName(%struct.sqlite3_stmt* readonly, i32, i32, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i8* @sqlite3_column_name(%struct.sqlite3_stmt* readonly, i32) #3

; Function Attrs: nounwind ssp uwtable
declare i8* @sqlite3_column_name16(%struct.sqlite3_stmt* readonly, i32) #3

; Function Attrs: nounwind ssp uwtable
declare i8* @sqlite3_column_decltype(%struct.sqlite3_stmt* readonly, i32) #3

; Function Attrs: nounwind ssp uwtable
declare i8* @sqlite3_column_decltype16(%struct.sqlite3_stmt* readonly, i32) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @vdbeUnbind(%struct.Vdbe*, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @bindText(%struct.sqlite3_stmt*, i32, i8*, i32, void (i8*)*, i8 zeroext) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_bind_blob(%struct.sqlite3_stmt*, i32, i8*, i32, void (i8*)*) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_bind_blob64(%struct.sqlite3_stmt*, i32, i8*, i64, void (i8*)*) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_bind_double(%struct.sqlite3_stmt*, i32, double) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_bind_int(%struct.sqlite3_stmt*, i32, i32) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_bind_int64(%struct.sqlite3_stmt*, i32, i64) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_bind_null(%struct.sqlite3_stmt*, i32) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_bind_pointer(%struct.sqlite3_stmt*, i32, i8*, i8*, void (i8*)*) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_bind_text(%struct.sqlite3_stmt*, i32, i8*, i32, void (i8*)*) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_bind_text64(%struct.sqlite3_stmt*, i32, i8*, i64, void (i8*)*, i8 zeroext) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_bind_text16(%struct.sqlite3_stmt*, i32, i8*, i32, void (i8*)*) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_bind_value(%struct.sqlite3_stmt*, i32, %struct.sqlite3_value* nocapture readonly) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_bind_zeroblob(%struct.sqlite3_stmt*, i32, i32) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_bind_zeroblob64(%struct.sqlite3_stmt*, i32, i64) #3

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i32 @sqlite3_bind_parameter_count(%struct.sqlite3_stmt* readonly) #7

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i8* @sqlite3_bind_parameter_name(%struct.sqlite3_stmt* readonly, i32) #7

; Function Attrs: nounwind readonly ssp uwtable
declare i32 @sqlite3_bind_parameter_index(%struct.sqlite3_stmt* readonly, i8* readonly) #18

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_transfer_bindings(%struct.sqlite3_stmt* nocapture, %struct.sqlite3_stmt* nocapture) #3

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare %struct.sqlite3* @sqlite3_db_handle(%struct.sqlite3_stmt* readonly) #7

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i32 @sqlite3_stmt_readonly(%struct.sqlite3_stmt* readonly) #7

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i32 @sqlite3_stmt_isexplain(%struct.sqlite3_stmt* readonly) #7

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i32 @sqlite3_stmt_busy(%struct.sqlite3_stmt* readonly) #7

; Function Attrs: nounwind ssp uwtable
declare %struct.sqlite3_stmt* @sqlite3_next_stmt(%struct.sqlite3* nocapture readonly, %struct.sqlite3_stmt* readonly) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_stmt_status(%struct.sqlite3_stmt*, i32, i32) #3

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i8* @sqlite3_sql(%struct.sqlite3_stmt* readonly) #7

; Function Attrs: norecurse nounwind readnone ssp uwtable
declare noalias i8* @sqlite3_expanded_sql(%struct.sqlite3_stmt* nocapture readnone) #11

; Function Attrs: alwaysinline nofree norecurse nounwind ssp uwtable
define i32 @alsoAnInt(%struct.sqlite3_value* nocapture readonly %pRec, double %rValue, i64* nocapture %piValue) local_unnamed_addr #2 {
entry:
  %conv = fptosi double %rValue to i64
  %cmp.i = fcmp oeq double %rValue, 0.000000e+00
  br i1 %cmp.i, label %if.then, label %lor.rhs.i

lor.rhs.i:                                        ; preds = %entry
  %conv.i = sitofp i64 %conv to double
  %0 = bitcast double %conv.i to i64
  %1 = bitcast double %rValue to i64
  %2 = icmp ne i64 %1, %0
  %conv.off = add i64 %conv, 2251799813685248
  %3 = icmp ugt i64 %conv.off, 4503599627370495
  %4 = or i1 %3, %2
  br i1 %4, label %if.end, label %if.then

if.then:                                          ; preds = %lor.rhs.i, %entry
  store i64 %conv, i64* %piValue, align 8, !tbaa !16
  br label %cleanup

if.end:                                           ; preds = %lor.rhs.i
  %z = getelementptr inbounds %struct.sqlite3_value, %struct.sqlite3_value* %pRec, i64 0, i32 5
  %5 = load i8*, i8** %z, align 8, !tbaa !26
  %n = getelementptr inbounds %struct.sqlite3_value, %struct.sqlite3_value* %pRec, i64 0, i32 4
  %6 = load i32, i32* %n, align 4, !tbaa !29
  %enc = getelementptr inbounds %struct.sqlite3_value, %struct.sqlite3_value* %pRec, i64 0, i32 2
  %7 = load i8, i8* %enc, align 2, !tbaa !21
  %call1 = call i32 @sqlite3Atoi64(i8* %5, i64* %piValue, i32 %6, i8 zeroext %7)
  %cmp = icmp eq i32 %call1, 0
  %conv2 = zext i1 %cmp to i32
  br label %cleanup

cleanup:                                          ; preds = %if.end, %if.then
  %retval.0 = phi i32 [ 1, %if.then ], [ %conv2, %if.end ]
  ret i32 %retval.0
}

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_value_numeric_type(%struct.sqlite3_value* nocapture) #3

; Function Attrs: nounwind ssp uwtable
declare %struct.sqlite3_value* @out2Prerelease(%struct.Vdbe* nocapture readonly, %struct.VdbeOp* nocapture readonly) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @blobSeekToRow(%struct.Incrblob* nocapture, i64, i8** nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3VdbeExec(%struct.Vdbe*) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i8* @sqlite3_errmsg(%struct.sqlite3* readonly) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_blob_open(%struct.sqlite3*, i8*, i8*, i8*, i64, i32, %struct.sqlite3_blob** nocapture) #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3ErrorMsg(%struct.Parse* nocapture, i8*, ...) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3VdbeMakeReady(%struct.Vdbe*, %struct.Parse* nocapture) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_blob_close(%struct.sqlite3_blob*) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @blobReadWrite(%struct.sqlite3_blob*, i8*, i32, i32, i32 (%struct.BtCursor*, i32, i32, i8*)* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_blob_read(%struct.sqlite3_blob*, i8*, i32, i32) #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3BtreePayloadChecked(%struct.BtCursor*, i32, i32, i8*) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_blob_write(%struct.sqlite3_blob*, i8*, i32, i32) #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3BtreePutData(%struct.BtCursor*, i32, i32, i8*) #3

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i32 @sqlite3_blob_bytes(%struct.sqlite3_blob* readonly) #7

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_blob_reopen(%struct.sqlite3_blob*, i64) #3

; Function Attrs: nounwind ssp uwtable
declare void @vdbePmaReaderClear(%struct.PmaReader*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @vdbeIncrFree(%struct.IncrMerger*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @vdbePmaReadBlob(%struct.PmaReader* nocapture, i32, i8** nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @vdbePmaReadVarint(%struct.PmaReader* nocapture, i64* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @vdbeSorterMapFile(%struct.SortSubtask* nocapture readonly, %struct.SorterFile* nocapture readonly, i8**) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @vdbePmaReaderSeek(%struct.SortSubtask* nocapture readonly, %struct.PmaReader*, %struct.SorterFile* nocapture readonly, i64) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @vdbePmaReaderNext(%struct.PmaReader*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @vdbeIncrSwap(%struct.IncrMerger*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @vdbePmaReaderInit(%struct.SortSubtask* nocapture readonly, %struct.SorterFile* nocapture readonly, i64, %struct.PmaReader*, i64* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @vdbeSorterCompareTail(%struct.SortSubtask* nocapture readonly, i32* nocapture, i8*, i32, i8*, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @vdbeSorterCompare(%struct.SortSubtask* nocapture readonly, i32* nocapture, i8*, i32, i8*, i32) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @vdbeSorterCompareText(%struct.SortSubtask* nocapture readonly, i32* nocapture, i8*, i32, i8*, i32) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @vdbeSorterCompareInt(%struct.SortSubtask* nocapture readonly, i32* nocapture, i8*, i32, i8*, i32) #3

; Function Attrs: nounwind ssp uwtable
declare void @vdbeSorterRecordFree(%struct.sqlite3*, %struct.SorterRecord*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @vdbeSortSubtaskCleanup(%struct.sqlite3*, %struct.SortSubtask*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @vdbeSorterJoinThread(%struct.SortSubtask* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @vdbeSorterCreateThread(%struct.SortSubtask* nocapture, i8* (i8*)*, i8*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @vdbeSorterJoinAll(%struct.VdbeSorter* nocapture, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare %struct.MergeEngine* @vdbeMergeEngineNew(i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @vdbeMergeEngineFree(%struct.MergeEngine*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @vdbeSorterExtendFile(%struct.sqlite3* nocapture readonly, %struct.sqlite3_file*, i64) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @vdbeSorterOpenTempFile(%struct.sqlite3* nocapture readonly, i64, %struct.sqlite3_file** nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @vdbeSortAllocUnpacked(%struct.SortSubtask* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare %struct.SorterRecord* @vdbeSorterMerge(%struct.SortSubtask*, %struct.SorterRecord*, %struct.SorterRecord*) local_unnamed_addr #3

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare nonnull i32 (%struct.SortSubtask*, i32*, i8*, i32, i8*, i32)* @vdbeSorterGetCompare(%struct.VdbeSorter* nocapture readonly) local_unnamed_addr #7

; Function Attrs: nounwind ssp uwtable
declare i32 @vdbeSorterSort(%struct.SortSubtask*, %struct.SorterList* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @vdbePmaWriterInit(%struct.sqlite3_file*, %struct.PmaWriter*, i32, i64) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @vdbePmaWriteBlob(%struct.PmaWriter* nocapture, i8*, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @vdbePmaWriterFinish(%struct.PmaWriter*, i64* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @vdbePmaWriteVarint(%struct.PmaWriter* nocapture, i64) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @vdbeSorterListToPMA(%struct.SortSubtask*, %struct.SorterList* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @vdbeMergeEngineStep(%struct.MergeEngine* nocapture readonly, i32* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i8* @vdbeSorterFlushThread(i8*) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @vdbeSorterFlushPMA(%struct.VdbeSorter*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @vdbeIncrPopulate(%struct.IncrMerger* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i8* @vdbeIncrPopulateThread(i8* nocapture) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @vdbeIncrBgPopulate(%struct.IncrMerger*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @vdbeIncrMergerNew(%struct.SortSubtask*, %struct.MergeEngine*, %struct.IncrMerger** nocapture) local_unnamed_addr #3

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare void @vdbeIncrMergerSetThreads(%struct.IncrMerger* nocapture) local_unnamed_addr #15

; Function Attrs: nounwind ssp uwtable
declare void @vdbeMergeEngineCompare(%struct.MergeEngine* nocapture readonly, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @vdbeMergeEngineInit(%struct.SortSubtask*, %struct.MergeEngine* nocapture, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @vdbePmaReaderIncrInit(%struct.PmaReader*, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @vdbePmaReaderIncrMergeInit(%struct.PmaReader*, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i8* @vdbePmaReaderBgIncrInit(i8*) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @vdbeMergeEngineLevel0(%struct.SortSubtask* nocapture readonly, i32, i64* nocapture, %struct.MergeEngine** nocapture) local_unnamed_addr #3

; Function Attrs: norecurse nounwind readnone ssp uwtable
declare i32 @vdbeSorterTreeDepth(i32) local_unnamed_addr #11

; Function Attrs: nounwind ssp uwtable
declare i32 @vdbeSorterAddToTree(%struct.SortSubtask*, i32, i32, %struct.MergeEngine* nocapture readonly, %struct.MergeEngine*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @vdbeSorterMergeTreeBuild(%struct.VdbeSorter*, %struct.MergeEngine** nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @vdbeSorterSetupMerge(%struct.VdbeSorter*) local_unnamed_addr #3

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare i8* @vdbeSorterRowkey(%struct.VdbeSorter* nocapture readonly, i32* nocapture) local_unnamed_addr #15

; Function Attrs: nofree nounwind ssp uwtable
declare i32 @memjrnlRead(%struct.sqlite3_file* nocapture, i8*, i32, i64) #8

; Function Attrs: nounwind ssp uwtable
declare void @memjrnlFreeChunks(%struct.MemJournal* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @memjrnlCreateFile(%struct.MemJournal*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @memjrnlWrite(%struct.sqlite3_file*, i8*, i32, i64) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @memjrnlTruncate(%struct.sqlite3_file* nocapture, i64) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @memjrnlClose(%struct.sqlite3_file* nocapture) #3

; Function Attrs: norecurse nounwind readnone ssp uwtable
declare i32 @memjrnlSync(%struct.sqlite3_file* nocapture readnone, i32) #11

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare i32 @memjrnlFileSize(%struct.sqlite3_file* nocapture readonly, i64* nocapture) #15

; Function Attrs: nounwind ssp uwtable
declare i32 @walkWindowList(%struct.Walker*, %struct.Window* readonly) local_unnamed_addr #3

; Function Attrs: noinline nounwind ssp uwtable
declare i32 @walkExpr(%struct.Walker*, %struct.Expr*) local_unnamed_addr #1

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3WalkSelect(%struct.Walker*, %struct.Select*) unnamed_addr #3

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare i32 @incrAggDepth(%struct.Walker* nocapture readonly, %struct.Expr* nocapture) #15

; Function Attrs: nounwind ssp uwtable
declare void @incrAggFunctionDepth(%struct.Expr*, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @resolveAlias(%struct.Parse* nocapture readonly, %struct.ExprList* nocapture readonly, i32, %struct.Expr*, i8* nocapture readonly, i32) local_unnamed_addr #3

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i32 @nameInUsingClause(%struct.IdList* readonly, i8* nocapture readonly) local_unnamed_addr #7

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i32 @areDoubleQuotedStringsEnabled(%struct.sqlite3* nocapture readonly, %struct.NameContext* nocapture readonly) local_unnamed_addr #7

; Function Attrs: nounwind ssp uwtable
declare i32 @lookupName(%struct.Parse*, i8*, i8*, i8*, %struct.NameContext*, %struct.Expr*) local_unnamed_addr #3

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare dso_local i32 @sqlite3MatchEName(%struct.ExprList_item* nocapture readonly, i8* readonly, i8* readonly, i8* readonly) unnamed_addr #7

; Function Attrs: nounwind ssp uwtable
declare void @notValidImpl(%struct.Parse* nocapture, %struct.NameContext* nocapture readonly, i8*, %struct.Expr*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @exprProbability(%struct.Expr* nocapture readonly) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @resolveExprStep(%struct.Walker*, %struct.Expr*) #3

; Function Attrs: nounwind ssp uwtable
declare dso_local %struct.FuncDef* @sqlite3FindFunction(%struct.sqlite3*, i8*, i32, i8 zeroext, i8 zeroext) unnamed_addr #3

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i32 @resolveAsName(%struct.Parse* nocapture readnone, %struct.ExprList* nocapture readonly, %struct.Expr* nocapture readonly) local_unnamed_addr #7

; Function Attrs: nounwind ssp uwtable
declare i32 @resolveOrderByTermToExprList(%struct.Parse*, %struct.Select* nocapture readonly, %struct.Expr*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3ExprCompare(%struct.Parse*, %struct.Expr* readonly, %struct.Expr* readonly, i32) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @resolveOutOfRangeError(%struct.Parse* nocapture, i8*, i32, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @resolveCompoundOrderBy(%struct.Parse*, %struct.Select*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3ExprIsInteger(%struct.Expr* readonly, i32* nocapture) unnamed_addr #3

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare i32 @resolveRemoveWindowsCb(%struct.Walker* nocapture readnone, %struct.Expr* nocapture readonly) #15

; Function Attrs: nounwind ssp uwtable
declare void @windowRemoveExprFromSelect(%struct.Select*, %struct.Expr*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @resolveOrderGroupBy(%struct.NameContext*, %struct.Select*, %struct.ExprList*, i8*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3ResolveOrderGroupBy(%struct.Parse* nocapture, %struct.Select* nocapture readonly, %struct.ExprList* readonly, i8*) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @resolveSelectStep(%struct.Walker* nocapture readonly, %struct.Select*) #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3SelectPrep(%struct.Parse*, %struct.Select*, %struct.NameContext*) unnamed_addr #3

; Function Attrs: nounwind readonly ssp uwtable
declare signext i8 @comparisonAffinity(%struct.Expr* nocapture readonly) local_unnamed_addr #18

; Function Attrs: nounwind readonly ssp uwtable
declare dso_local signext i8 @sqlite3ExprAffinity(%struct.Expr* nocapture readonly) unnamed_addr #18

; Function Attrs: nounwind readonly ssp uwtable
declare zeroext i8 @binaryCompareP5(%struct.Expr* nocapture readonly, %struct.Expr* nocapture readonly, i32) local_unnamed_addr #18

; Function Attrs: nounwind ssp uwtable
declare i32 @codeCompare(%struct.Parse* nocapture, %struct.Expr*, %struct.Expr*, i32, i32, i32, i32, i32, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3VdbeAddOp4(%struct.Vdbe*, i32, i32, i32, i32, i8*, i32) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @exprCodeSubselect(%struct.Parse*, %struct.Expr* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3CodeSubselect(%struct.Parse*, %struct.Expr* nocapture) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @exprVectorRegister(%struct.Parse*, %struct.Expr*, i32, i32, %struct.Expr** nocapture, i32*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3ExprCodeTemp(%struct.Parse*, %struct.Expr*, i32* nocapture) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @codeVectorCompare(%struct.Parse*, %struct.Expr* nocapture readonly, i32, i8 zeroext, i8 zeroext) local_unnamed_addr #3

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare void @heightOfExpr(%struct.Expr* readonly, i32* nocapture) local_unnamed_addr #15

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare void @heightOfExprList(%struct.ExprList* readonly, i32* nocapture) local_unnamed_addr #15

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare void @heightOfSelect(%struct.Select* readonly, i32* nocapture) local_unnamed_addr #15

; Function Attrs: nounwind ssp uwtable
declare void @exprSetHeight(%struct.Expr* nocapture) local_unnamed_addr #3

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i32 @exprStructSize(%struct.Expr* nocapture readonly) local_unnamed_addr #7

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i32 @dupedExprStructSize(%struct.Expr* nocapture readonly, i32) local_unnamed_addr #7

; Function Attrs: nounwind readonly ssp uwtable
declare i32 @dupedExprNodeSize(%struct.Expr* nocapture readonly, i32) local_unnamed_addr #18

; Function Attrs: nounwind readonly ssp uwtable
declare i32 @dupedExprSize(%struct.Expr* readonly, i32) local_unnamed_addr #18

; Function Attrs: nounwind ssp uwtable
declare %struct.Expr* @exprDup(%struct.sqlite3*, %struct.Expr*, i32, i8**) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local %struct.Select* @sqlite3SelectDup(%struct.sqlite3*, %struct.Select* readonly, i32) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local %struct.ExprList* @sqlite3ExprListDup(%struct.sqlite3*, %struct.ExprList*, i32) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local %struct.Window* @sqlite3WindowDup(%struct.sqlite3*, %struct.Expr*, %struct.Window* readonly) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare %struct.With* @withDup(%struct.sqlite3*, %struct.With* readonly) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @gatherSelectWindowsCallback(%struct.Walker* nocapture readonly, %struct.Expr* nocapture readonly) #3

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i32 @gatherSelectWindowsSelectCallback(%struct.Walker* nocapture readonly, %struct.Select* readnone) #7

; Function Attrs: nounwind ssp uwtable
declare void @gatherSelectWindows(%struct.Select*) local_unnamed_addr #3

; Function Attrs: noinline nounwind ssp uwtable
declare void @exprListDeleteNN(%struct.sqlite3*, %struct.ExprList*) local_unnamed_addr #1

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare i32 @exprNodeIsConstant(%struct.Walker* nocapture, %struct.Expr* nocapture) #15

; Function Attrs: nounwind ssp uwtable
declare i32 @exprIsConst(%struct.Expr*, i32, i32) local_unnamed_addr #3

; Function Attrs: nofree norecurse nounwind ssp uwtable writeonly
declare dso_local i32 @sqlite3SelectWalkFail(%struct.Walker* nocapture, %struct.Select* nocapture readnone) #10

; Function Attrs: nounwind ssp uwtable
declare i32 @exprNodeIsConstantOrGroupBy(%struct.Walker* nocapture, %struct.Expr*) #3

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare %struct.Select* @isCandidateForInOpt(%struct.Expr* nocapture readonly) local_unnamed_addr #7

; Function Attrs: nounwind ssp uwtable
declare i8* @exprINAffinity(%struct.Parse* nocapture readonly, %struct.Expr* nocapture readonly) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @codeReal(%struct.Vdbe* nocapture, i8* readonly, i32, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @codeInteger(%struct.Parse* nocapture, %struct.Expr* nocapture readonly, i32, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3DecOrHexToI64(i8* readonly, i64*) unnamed_addr #3

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare void @exprToRegister(%struct.Expr*, i32) local_unnamed_addr #15

; Function Attrs: nounwind ssp uwtable
declare i32 @exprCodeVector(%struct.Parse*, %struct.Expr*, i32*) local_unnamed_addr #3

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare void @setDoNotMergeFlagOnCopy(%struct.Vdbe* nocapture readonly) local_unnamed_addr #15

; Function Attrs: nounwind ssp uwtable
declare i32 @exprCodeInlineFunction(%struct.Parse*, %struct.ExprList* nocapture readonly, i32, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3ExprCode(%struct.Parse*, %struct.Expr*, i32) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3ExprCodeTarget(%struct.Parse*, %struct.Expr*, i32) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3ExprImpliesExpr(%struct.Parse*, %struct.Expr* readonly, %struct.Expr* readonly, i32) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3ExprImpliesNonNullRow(%struct.Expr*, i32) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @exprCodeBetween(%struct.Parse*, %struct.Expr* nocapture readonly, i32, void (%struct.Parse*, %struct.Expr*, i32, i32)*, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @exprCompareVariable(%struct.Parse* nocapture readonly, %struct.Expr* nocapture readonly, %struct.Expr* readonly) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @exprImpliesNotNull(%struct.Parse*, %struct.Expr* readonly, %struct.Expr* readonly, i32, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @impliesNotNullRow(%struct.Walker*, %struct.Expr* nocapture readonly) #3

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare i32 @exprIdxCover(%struct.Walker* nocapture, %struct.Expr* nocapture readonly) #15

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare i32 @exprSrcCount(%struct.Walker* nocapture readonly, %struct.Expr* nocapture readonly) #15

; Function Attrs: nounwind ssp uwtable
declare i32 @addAggInfoColumn(%struct.sqlite3*, %struct.AggInfo* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @addAggInfoFunc(%struct.sqlite3*, %struct.AggInfo* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @analyzeAggregate(%struct.Walker* nocapture readonly, %struct.Expr*) #3

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare i32 @analyzeAggregatesInSelect(%struct.Walker* nocapture, %struct.Select* nocapture readnone) #15

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare void @analyzeAggregatesInSelectEnd(%struct.Walker* nocapture, %struct.Select* nocapture readnone) #15

; Function Attrs: nounwind ssp uwtable
declare i32 @isAlterableTable(%struct.Parse* nocapture, %struct.Table* nocapture readonly) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @renameTestSchema(%struct.Parse*, i8*, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3NestedParse(%struct.Parse*, i8*, ...) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @renameReloadSchema(%struct.Parse* nocapture readonly, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @isRealTable(%struct.Parse* nocapture, %struct.Table* nocapture readonly) local_unnamed_addr #3

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare i32 @renameUnmapExprCb(%struct.Walker* nocapture readonly, %struct.Expr* readnone) #15

; Function Attrs: nounwind ssp uwtable
declare void @renameWalkWith(%struct.Walker*, %struct.Select* nocapture readonly) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @renameUnmapSelectCb(%struct.Walker*, %struct.Select* nocapture readonly) #3

; Function Attrs: nounwind ssp uwtable
declare void @renameTokenFree(%struct.sqlite3*, %struct.RenameToken*) local_unnamed_addr #3

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare void @renameTokenFind(%struct.Parse* nocapture, %struct.RenameCtx* nocapture, i8* readnone) local_unnamed_addr #15

; Function Attrs: nounwind ssp uwtable
declare i32 @renameColumnSelectCb(%struct.Walker*, %struct.Select* nocapture readonly) #3

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare i32 @renameColumnExprCb(%struct.Walker* nocapture readonly, %struct.Expr* readonly) #15

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare %struct.RenameToken* @renameColumnTokenNext(%struct.RenameCtx* nocapture) local_unnamed_addr #15

; Function Attrs: nounwind ssp uwtable
declare void @renameColumnParseError(%struct.sqlite3_context* nocapture, i32, %struct.sqlite3_value*, %struct.sqlite3_value*, %struct.Parse* nocapture readonly) local_unnamed_addr #3

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare void @renameColumnElistNames(%struct.Parse* nocapture, %struct.RenameCtx* nocapture, %struct.ExprList* readonly, i8* readonly) local_unnamed_addr #15

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare void @renameColumnIdlistNames(%struct.Parse* nocapture, %struct.RenameCtx* nocapture, %struct.IdList* readonly, i8* readonly) local_unnamed_addr #15

; Function Attrs: nounwind ssp uwtable
declare i32 @renameParseSql(%struct.Parse*, i8* readonly, %struct.sqlite3*, i8*, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3RunParser(%struct.Parse*, i8*, i8** nocapture) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @renameEditSql(%struct.sqlite3_context* nocapture, %struct.RenameCtx* nocapture, i8*, i8*, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @renameResolveTrigger(%struct.Parse*, i8*) local_unnamed_addr #3

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare dso_local %struct.Table* @sqlite3FindTable(%struct.sqlite3* nocapture readonly, i8* nocapture readonly, i8* readonly) unnamed_addr #7

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3ViewGetColumnNames(%struct.Parse*, %struct.Table* nocapture) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @renameWalkTrigger(%struct.Walker*, %struct.Trigger* nocapture readonly) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @renameParseCleanup(%struct.Parse* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @renameColumnFunc(%struct.sqlite3_context* nocapture, i32, %struct.sqlite3_value** nocapture readonly) #3

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare i32 @renameTableExprCb(%struct.Walker* nocapture readonly, %struct.Expr* readonly) #15

; Function Attrs: nounwind ssp uwtable
declare i32 @renameTableSelectCb(%struct.Walker*, %struct.Select* nocapture readonly) #3

; Function Attrs: nounwind ssp uwtable
declare void @renameTableFunc(%struct.sqlite3_context* nocapture, i32, %struct.sqlite3_value** nocapture readonly) #3

; Function Attrs: nounwind ssp uwtable
declare void @renameTableTest(%struct.sqlite3_context* nocapture, i32, %struct.sqlite3_value** nocapture readonly) #3

; Function Attrs: nounwind ssp uwtable
declare void @openStatTable(%struct.Parse*, i32, i32, i8*, i8*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3TableLock(%struct.Parse* nocapture, i32, i32, i8 zeroext, i8*) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @statAccumDestructor(i8*) #3

; Function Attrs: nounwind ssp uwtable
declare void @statInit(%struct.sqlite3_context* nocapture, i32, %struct.sqlite3_value** nocapture readonly) #3

; Function Attrs: nounwind ssp uwtable
declare void @statPush(%struct.sqlite3_context* nocapture readnone, i32, %struct.sqlite3_value** nocapture readonly) #3

; Function Attrs: nounwind ssp uwtable
declare void @statGet(%struct.sqlite3_context* nocapture, i32, %struct.sqlite3_value** nocapture readonly) #3

; Function Attrs: nounwind ssp uwtable
declare void @callStatGet(%struct.Parse* nocapture readonly, i32, i32, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @analyzeOneTable(%struct.Parse*, %struct.Table* readonly, %struct.Index* readnone, i32, i32, i32) local_unnamed_addr #3

; Function Attrs: nounwind readonly ssp uwtable
declare i32 @sqlite3_strlike(i8* readonly, i8* readonly, i32) #18

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3OpenTable(%struct.Parse*, i32, i32, %struct.Table* nocapture readonly, i32) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @loadAnalysis(%struct.Parse*, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @analyzeDatabase(%struct.Parse*, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @analyzeTable(%struct.Parse*, %struct.Table* readonly, %struct.Index* readonly) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @decodeIntArray(i8* readonly, i32, i32* nocapture readnone, i16* nocapture, %struct.Index* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind readonly ssp uwtable
declare i32 @sqlite3_strglob(i8* readonly, i8* readonly) #18

; Function Attrs: nounwind ssp uwtable
declare i32 @analysisLoader(i8* nocapture readonly, i32, i8** readonly, i8** nocapture readnone) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @resolveAttachExpr(%struct.NameContext*, %struct.Expr*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @attachFunc(%struct.sqlite3_context* nocapture, i32, %struct.sqlite3_value** nocapture readonly) #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3ParseUri(i8*, i8*, i32* nocapture, %struct.sqlite3_vfs** nocapture, i8** nocapture, i8** nocapture) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local %struct.Schema* @sqlite3SchemaGet(%struct.sqlite3*, %struct.Btree*) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3BtreeSetPagerFlags(%struct.Btree* nocapture, i32) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @sqlite3_free_filename(i8*) #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3BtreeClose(%struct.Btree*) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @detachFunc(%struct.sqlite3_context* nocapture, i32, %struct.sqlite3_value** nocapture readonly) #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3CollapseDatabaseArray(%struct.sqlite3*) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @codeAttach(%struct.Parse*, i32, %struct.FuncDef*, %struct.Expr* readonly, %struct.Expr*, %struct.Expr*, %struct.Expr*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_set_authorizer(%struct.sqlite3* nocapture, i32 (i8*, i32, i8*, i8*, i8*, i8*)*, i8*) #3

; Function Attrs: nounwind ssp uwtable
declare void @sqliteAuthBadReturnCode(%struct.Parse* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @codeTableLocks(%struct.Parse*) local_unnamed_addr #3

; Function Attrs: noinline nounwind ssp uwtable
declare void @deleteTable(%struct.sqlite3*, %struct.Table*) local_unnamed_addr #1

; Function Attrs: nounwind ssp uwtable
declare dso_local i8* @sqlite3HashInsert(%struct.Hash* nocapture, i8*, i8*) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @makeColumnPartOfPrimaryKey(%struct.Parse* nocapture, %struct.Column* nocapture) local_unnamed_addr #3

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i32 @identLength(i8* nocapture readonly) local_unnamed_addr #7

; Function Attrs: nounwind ssp uwtable
declare void @identPut(i8* nocapture, i32* nocapture, i8* nocapture readonly) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i8* @createTableStmt(%struct.sqlite3*, %struct.Table* nocapture readonly) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @resizeIndexObject(%struct.sqlite3*, %struct.Index* nocapture, i32) local_unnamed_addr #3

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare void @estimateTableWidth(%struct.Table* nocapture) local_unnamed_addr #15

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare void @estimateIndexWidth(%struct.Index* nocapture) local_unnamed_addr #15

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i32 @hasColumn(i16* nocapture readonly, i32, i32) local_unnamed_addr #7

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i32 @isDupColumn(%struct.Index* nocapture readonly, i32, %struct.Index* nocapture readonly, i32) local_unnamed_addr #7

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare void @recomputeColumnsNotIndexed(%struct.Index* nocapture) local_unnamed_addr #15

; Function Attrs: nounwind ssp uwtable
declare void @convertToWithoutRowidTable(%struct.Parse*, %struct.Table*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local %struct.ExprList* @sqlite3ExprListAppend(%struct.sqlite3*, %struct.ExprList*, %struct.Expr*) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local %struct.Expr* @sqlite3ExprAlloc(%struct.sqlite3*, i32, %struct.Token* readonly, i32) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3CreateIndex(%struct.Parse*, %struct.Token*, %struct.Token*, %struct.SrcList*, %struct.ExprList*, i32, %struct.Token* readnone, %struct.Expr*, i32, i32, i8 zeroext) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @sqliteViewResetAll(%struct.sqlite3*, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @destroyRootPage(%struct.Parse*, i32, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @destroyTable(%struct.Parse*, %struct.Table* nocapture readonly) local_unnamed_addr #3

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i32 @tableMayNotBeDropped(%struct.sqlite3* nocapture readnone, %struct.Table* nocapture readonly) local_unnamed_addr #7

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i32 @collationMatch(i8* nocapture readonly, %struct.Index* nocapture readonly) local_unnamed_addr #7

; Function Attrs: nounwind ssp uwtable
declare void @reindexTable(%struct.Parse*, %struct.Table* nocapture readonly, i8* readonly) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3RefillIndex(%struct.Parse*, %struct.Index* nocapture, i32) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @reindexDatabases(%struct.Parse*, i8* readonly) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @callCollNeeded(%struct.sqlite3*, i32, i8*) local_unnamed_addr #3

; Function Attrs: nofree nounwind ssp uwtable
declare i32 @synthCollSeq(%struct.sqlite3* nocapture readonly, %struct.CollSeq*) local_unnamed_addr #8

; Function Attrs: nounwind ssp uwtable
declare %struct.CollSeq* @findCollSeqEntry(%struct.sqlite3*, i8*, i32) local_unnamed_addr #3

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i32 @matchQuality(%struct.FuncDef* nocapture readonly, i32, i8 zeroext) local_unnamed_addr #7

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i32 @tabIsReadOnly(%struct.Parse* nocapture readonly, %struct.Table* nocapture readonly) local_unnamed_addr #7

; Function Attrs: nounwind ssp uwtable
declare void @minmaxFunc(%struct.sqlite3_context* nocapture readonly, i32, %struct.sqlite3_value** nocapture readonly) #3

; Function Attrs: nounwind ssp uwtable
declare void @typeofFunc(%struct.sqlite3_context* nocapture, i32, %struct.sqlite3_value** nocapture readonly) #3

; Function Attrs: nounwind ssp uwtable
declare void @lengthFunc(%struct.sqlite3_context* nocapture readonly, i32, %struct.sqlite3_value** nocapture readonly) #3

; Function Attrs: nounwind ssp uwtable
declare void @absFunc(%struct.sqlite3_context* nocapture, i32, %struct.sqlite3_value** nocapture readonly) #3

; Function Attrs: nounwind ssp uwtable
declare void @instrFunc(%struct.sqlite3_context* nocapture, i32, %struct.sqlite3_value** nocapture readonly) #3

; Function Attrs: nounwind ssp uwtable
declare void @printfFunc(%struct.sqlite3_context* nocapture, i32, %struct.sqlite3_value**) #3

; Function Attrs: nounwind ssp uwtable
declare void @substrFunc(%struct.sqlite3_context*, i32, %struct.sqlite3_value** nocapture readonly) #3

; Function Attrs: nounwind ssp uwtable
declare void @roundFunc(%struct.sqlite3_context* nocapture, i32, %struct.sqlite3_value** nocapture readonly) #3

; Function Attrs: nounwind ssp uwtable
declare i8* @contextMalloc(%struct.sqlite3_context* nocapture, i64) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @upperFunc(%struct.sqlite3_context* nocapture, i32, %struct.sqlite3_value** nocapture readonly) #3

; Function Attrs: nounwind ssp uwtable
declare void @lowerFunc(%struct.sqlite3_context* nocapture, i32, %struct.sqlite3_value** nocapture readonly) #3

; Function Attrs: nounwind ssp uwtable
declare void @randomFunc(%struct.sqlite3_context* nocapture readonly, i32, %struct.sqlite3_value** nocapture readnone) #3

; Function Attrs: nounwind ssp uwtable
declare void @randomBlob(%struct.sqlite3_context* nocapture, i32, %struct.sqlite3_value** nocapture readonly) #3

; Function Attrs: nounwind ssp uwtable
declare void @last_insert_rowid(%struct.sqlite3_context* nocapture readonly, i32, %struct.sqlite3_value** nocapture readnone) #3

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i64 @sqlite3_last_insert_rowid(%struct.sqlite3* nocapture readonly) #7

; Function Attrs: nounwind ssp uwtable
declare void @changes(%struct.sqlite3_context* nocapture readonly, i32, %struct.sqlite3_value** nocapture readnone) #3

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i32 @sqlite3_changes(%struct.sqlite3* nocapture readonly) #7

; Function Attrs: nounwind ssp uwtable
declare void @total_changes(%struct.sqlite3_context* nocapture readonly, i32, %struct.sqlite3_value** nocapture readnone) #3

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i32 @sqlite3_total_changes(%struct.sqlite3* nocapture readonly) #7

; Function Attrs: nounwind readonly ssp uwtable
declare i32 @patternCompare(i8*, i8*, %struct.compareInfo* readonly, i32) local_unnamed_addr #18

; Function Attrs: nofree nounwind readonly
declare i64 @strcspn(i8* nocapture, i8* nocapture) local_unnamed_addr #14

; Function Attrs: nounwind ssp uwtable
declare void @likeFunc(%struct.sqlite3_context* nocapture, i32, %struct.sqlite3_value** nocapture readonly) #3

; Function Attrs: nounwind ssp uwtable
declare void @nullifFunc(%struct.sqlite3_context* nocapture readonly, i32, %struct.sqlite3_value** nocapture readonly) #3

; Function Attrs: nounwind ssp uwtable
declare void @versionFunc(%struct.sqlite3_context* nocapture, i32, %struct.sqlite3_value** nocapture readnone) #3

; Function Attrs: norecurse nounwind readnone ssp uwtable
declare i8* @sqlite3_libversion() #11

; Function Attrs: nounwind ssp uwtable
declare void @sourceidFunc(%struct.sqlite3_context* nocapture, i32, %struct.sqlite3_value** nocapture readnone) #3

; Function Attrs: norecurse nounwind readnone ssp uwtable
declare i8* @sqlite3_sourceid() #11

; Function Attrs: nounwind ssp uwtable
declare void @errlogFunc(%struct.sqlite3_context* nocapture readnone, i32, %struct.sqlite3_value** nocapture readonly) #3

; Function Attrs: nounwind ssp uwtable
declare void @compileoptionusedFunc(%struct.sqlite3_context* nocapture readonly, i32, %struct.sqlite3_value** nocapture readonly) #3

; Function Attrs: nounwind readonly ssp uwtable
declare i32 @sqlite3_compileoption_used(i8* readonly) #18

; Function Attrs: nounwind ssp uwtable
declare void @compileoptiongetFunc(%struct.sqlite3_context* nocapture, i32, %struct.sqlite3_value** nocapture readonly) #3

; Function Attrs: nounwind readnone ssp uwtable
declare i8* @sqlite3_compileoption_get(i32) #23

; Function Attrs: nounwind ssp uwtable
declare void @quoteFunc(%struct.sqlite3_context* nocapture, i32, %struct.sqlite3_value** nocapture readonly) #3

; Function Attrs: nounwind ssp uwtable
declare void @unicodeFunc(%struct.sqlite3_context* nocapture readonly, i32, %struct.sqlite3_value** nocapture readonly) #3

; Function Attrs: nounwind ssp uwtable
declare void @charFunc(%struct.sqlite3_context*, i32, %struct.sqlite3_value** nocapture readonly) #3

; Function Attrs: nounwind ssp uwtable
declare void @hexFunc(%struct.sqlite3_context* nocapture, i32, %struct.sqlite3_value** nocapture readonly) #3

; Function Attrs: nounwind ssp uwtable
declare void @zeroblobFunc(%struct.sqlite3_context* nocapture, i32, %struct.sqlite3_value** nocapture readonly) #3

; Function Attrs: nounwind ssp uwtable
declare void @replaceFunc(%struct.sqlite3_context* nocapture, i32, %struct.sqlite3_value** nocapture readonly) #3

; Function Attrs: nounwind ssp uwtable
declare void @trimFunc(%struct.sqlite3_context* nocapture, i32, %struct.sqlite3_value** nocapture readonly) #3

; Function Attrs: nounwind ssp uwtable
declare void @loadExt(%struct.sqlite3_context* nocapture, i32, %struct.sqlite3_value** nocapture readonly) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_load_extension(%struct.sqlite3*, i8*, i8*, i8**) #3

; Function Attrs: nounwind ssp uwtable
declare void @sumStep(%struct.sqlite3_context* nocapture readonly, i32, %struct.sqlite3_value** nocapture readonly) #3

; Function Attrs: nounwind ssp uwtable
declare void @sumInverse(%struct.sqlite3_context* nocapture readonly, i32, %struct.sqlite3_value** nocapture readonly) #3

; Function Attrs: nounwind ssp uwtable
declare void @sumFinalize(%struct.sqlite3_context* nocapture) #3

; Function Attrs: nounwind ssp uwtable
declare void @avgFinalize(%struct.sqlite3_context* nocapture readonly) #3

; Function Attrs: nounwind ssp uwtable
declare void @totalFinalize(%struct.sqlite3_context* nocapture readonly) #3

; Function Attrs: nounwind ssp uwtable
declare void @countStep(%struct.sqlite3_context* nocapture readonly, i32, %struct.sqlite3_value** nocapture readonly) #3

; Function Attrs: nounwind ssp uwtable
declare void @countFinalize(%struct.sqlite3_context* nocapture readonly) #3

; Function Attrs: nounwind ssp uwtable
declare void @countInverse(%struct.sqlite3_context* nocapture readonly, i32, %struct.sqlite3_value** nocapture readonly) #3

; Function Attrs: nounwind ssp uwtable
declare void @minmaxStep(%struct.sqlite3_context* nocapture, i32, %struct.sqlite3_value** nocapture readonly) #3

; Function Attrs: nounwind ssp uwtable
declare void @minMaxValueFinalize(%struct.sqlite3_context* nocapture readonly, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @minMaxValue(%struct.sqlite3_context* nocapture readonly) #3

; Function Attrs: nounwind ssp uwtable
declare void @minMaxFinalize(%struct.sqlite3_context* nocapture readonly) #3

; Function Attrs: nounwind ssp uwtable
declare void @groupConcatStep(%struct.sqlite3_context* nocapture readonly, i32, %struct.sqlite3_value** nocapture readonly) #3

; Function Attrs: nounwind ssp uwtable
declare void @groupConcatInverse(%struct.sqlite3_context* nocapture readonly, i32, %struct.sqlite3_value** nocapture readonly) #3

; Function Attrs: nounwind ssp uwtable
declare void @groupConcatFinalize(%struct.sqlite3_context* nocapture) #3

; Function Attrs: nounwind ssp uwtable
declare void @groupConcatValue(%struct.sqlite3_context* nocapture) #3

; Function Attrs: nounwind ssp uwtable
declare void @fkLookupParent(%struct.Parse*, i32, %struct.Table* readonly, %struct.Index*, %struct.FKey* nocapture readonly, i32* nocapture readonly, i32, i32, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i8* @sqlite3IndexAffinityStr(%struct.sqlite3*, %struct.Index* nocapture) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare %struct.Expr* @exprTableRegister(%struct.Parse* nocapture readonly, %struct.Table* nocapture readonly, i32, i16 signext) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare %struct.Expr* @exprTableColumn(%struct.sqlite3*, %struct.Table*, i32, i16 signext) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @fkScanChildren(%struct.Parse*, %struct.SrcList*, %struct.Table*, %struct.Index* readonly, %struct.FKey* nocapture readonly, i32* readonly, i32, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local %struct.Expr* @sqlite3PExpr(%struct.Parse* nocapture, i32, %struct.Expr*, %struct.Expr*) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local %struct.WhereInfo* @sqlite3WhereBegin(%struct.Parse*, %struct.SrcList*, %struct.Expr*, %struct.ExprList*, %struct.ExprList*, i16 zeroext, i32) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3WhereEnd(%struct.WhereInfo*) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @fkTriggerDelete(%struct.sqlite3*, %struct.Trigger*) local_unnamed_addr #3

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i32 @fkChildIsModified(%struct.Table* nocapture readonly, %struct.FKey* nocapture readonly, i32* nocapture readonly, i32) local_unnamed_addr #7

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i32 @fkParentIsModified(%struct.Table* nocapture readonly, %struct.FKey* nocapture readonly, i32* nocapture readonly, i32) local_unnamed_addr #7

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i32 @isSetNullAction(%struct.Parse* nocapture readonly, %struct.FKey* nocapture readonly) local_unnamed_addr #7

; Function Attrs: nounwind ssp uwtable
declare %struct.Trigger* @fkActionTrigger(%struct.Parse*, %struct.Table* nocapture readonly, %struct.FKey* nocapture, %struct.ExprList* readnone) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3FkLocateIndex(%struct.Parse* nocapture, %struct.Table* nocapture readonly, %struct.FKey* nocapture readonly, %struct.Index** nocapture, i32**) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local %struct.Select* @sqlite3SelectNew(%struct.Parse* nocapture, %struct.ExprList*, %struct.SrcList*, %struct.Expr*, %struct.ExprList*, %struct.Expr*, %struct.ExprList*, i32, %struct.Expr*) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local %struct.SrcList* @sqlite3SrcListAppend(%struct.Parse* nocapture, %struct.SrcList*, %struct.Token* readonly, %struct.Token* readonly) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @readsTable(%struct.Parse*, i32, %struct.Table* nocapture readonly) local_unnamed_addr #3

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare i32 @exprColumnFlagUnion(%struct.Walker* nocapture, %struct.Expr* nocapture readonly) #15

; Function Attrs: nounwind ssp uwtable
declare i32 @autoIncBegin(%struct.Parse* nocapture, i32, %struct.Table*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @autoIncStep(%struct.Parse* nocapture readonly, i32, i32) local_unnamed_addr #3

; Function Attrs: noinline nounwind ssp uwtable
declare void @autoIncrementEnd(%struct.Parse*) local_unnamed_addr #1

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare i32 @checkConstraintExprNode(%struct.Walker* nocapture, %struct.Expr* nocapture readonly) #15

; Function Attrs: nounwind ssp uwtable
declare i32 @xferCompatibleIndex(%struct.Index* nocapture readonly, %struct.Index* nocapture readonly) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @xferOptimization(%struct.Parse*, %struct.Table*, %struct.Select* readonly, i32, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_exec(%struct.sqlite3*, i8*, i32 (i8*, i32, i8**, i8**)*, i8*, i8**) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_prepare_v2(%struct.sqlite3*, i8*, i32, %struct.sqlite3_stmt** nocapture, i8**) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_enable_load_extension(%struct.sqlite3* nocapture, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_auto_extension(void ()*) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_cancel_auto_extension(void ()* readnone) #3

; Function Attrs: nounwind ssp uwtable
declare void @sqlite3_reset_auto_extension() #3

; Function Attrs: nounwind ssp uwtable
declare zeroext i8 @getSafetyLevel(i8* readonly, i32, i8 zeroext) local_unnamed_addr #3

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i32 @getLockingMode(i8* readonly) local_unnamed_addr #7

; Function Attrs: nounwind ssp uwtable
declare i32 @getAutoVacuum(i8* readonly) local_unnamed_addr #3

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i32 @getTempStore(i8* nocapture readonly) local_unnamed_addr #7

; Function Attrs: nounwind ssp uwtable
declare i32 @invalidateTempStorage(%struct.Parse* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @changeTempStorage(%struct.Parse* nocapture, i8* nocapture readonly) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @setPragmaResultColumnNames(%struct.Vdbe* nocapture, %struct.PragmaName* nocapture readonly) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @returnSingleInt(%struct.Vdbe*, i64) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @returnSingleText(%struct.Vdbe* nocapture, i8*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @setAllPagerFlags(%struct.sqlite3* nocapture readonly) local_unnamed_addr #3

; Function Attrs: norecurse nounwind readnone ssp uwtable
declare i8* @actionName(i8 zeroext) local_unnamed_addr #11

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare %struct.PragmaName* @pragmaLocate(i8* readonly) local_unnamed_addr #7

; Function Attrs: nounwind ssp uwtable
declare void @pragmaFunclistLine(%struct.Vdbe* nocapture, %struct.FuncDef* readonly, i32, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3VdbeMultiLoad(%struct.Vdbe* nocapture, i32, i8* nocapture readonly, ...) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @integrityCheckResultRow(%struct.Vdbe* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @corruptSchema(%struct.InitData* nocapture, i8*, i8*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @schemaIsValid(%struct.Parse* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_prepare(%struct.sqlite3*, i8*, i32, %struct.sqlite3_stmt** nocapture, i8**) #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3LockAndPrepare(%struct.sqlite3*, i8*, i32, i32, %struct.Vdbe*, %struct.sqlite3_stmt** nocapture, i8**) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_prepare_v3(%struct.sqlite3*, i8*, i32, i32, %struct.sqlite3_stmt** nocapture, i8**) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_prepare16(%struct.sqlite3*, i8*, i32, %struct.sqlite3_stmt** nocapture, i8**) #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3Prepare16(%struct.sqlite3*, i8*, i32, i32, %struct.sqlite3_stmt** nocapture, i8**) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_prepare16_v2(%struct.sqlite3*, i8*, i32, %struct.sqlite3_stmt** nocapture, i8**) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_prepare16_v3(%struct.sqlite3*, i8*, i32, i32, %struct.sqlite3_stmt** nocapture, i8**) #3

; Function Attrs: nounwind ssp uwtable
declare void @clearSelect(%struct.sqlite3*, %struct.Select*, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3SrcListDelete(%struct.sqlite3*, %struct.SrcList*) unnamed_addr #3

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare %struct.Select* @findRightmost(%struct.Select* readonly) local_unnamed_addr #7

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i32 @columnIndex(%struct.Table* nocapture readonly, i8* nocapture readonly) local_unnamed_addr #7

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare i32 @tableAndColumnIndex(%struct.SrcList* nocapture readonly, i32, i8* nocapture readonly, i32*, i32* nocapture, i32) local_unnamed_addr #15

; Function Attrs: nounwind ssp uwtable
declare void @addWhereTerm(%struct.Parse* nocapture, %struct.SrcList* nocapture, i32, i32, i32, i32, i32, %struct.Expr** nocapture) local_unnamed_addr #3

; Function Attrs: nofree nounwind ssp uwtable
declare void @unsetJoinExpr(%struct.Expr*, i32) local_unnamed_addr #8

; Function Attrs: nounwind ssp uwtable
declare i32 @sqliteProcessJoin(%struct.Parse* nocapture, %struct.Select* nocapture) local_unnamed_addr #3

; Function Attrs: nofree nounwind ssp uwtable
declare dso_local void @sqlite3SetJoinExpr(%struct.Expr*, i32) unnamed_addr #8

; Function Attrs: nounwind ssp uwtable
declare void @innerLoopLoadRow(%struct.Parse*, %struct.Select* nocapture readonly, %struct.RowLoadInfo* nocapture readonly) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3ExprCodeExprList(%struct.Parse*, %struct.ExprList* nocapture readonly, i32, i32, i8 zeroext) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @makeSorterRecord(%struct.Parse*, %struct.SortCtx* nocapture readonly, %struct.Select* nocapture readonly, i32, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @pushOntoSorter(%struct.Parse*, %struct.SortCtx* nocapture, %struct.Select* nocapture readonly, i32, i32, i32, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @codeOffset(%struct.Vdbe* nocapture, i32, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @codeDistinct(%struct.Parse* nocapture, i32, i32, i32, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @selectInnerLoop(%struct.Parse*, %struct.Select* nocapture readonly, i32, %struct.SortCtx*, %struct.DistinctCtx* readonly, %struct.SelectDest* nocapture, i32, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local %struct.CollSeq* @sqlite3ExprCollSeq(%struct.Parse* nocapture, %struct.Expr* readonly) unnamed_addr #3

; Function Attrs: norecurse nounwind readnone ssp uwtable
declare i8* @selectOpName(i32) local_unnamed_addr #11

; Function Attrs: nounwind ssp uwtable
declare void @explainTempTable(%struct.Parse* nocapture, i8*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3VdbeExplain(%struct.Parse* nocapture, i8 zeroext, i8*, ...) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @generateSortTail(%struct.Parse*, %struct.Select* nocapture readonly, %struct.SortCtx* nocapture readonly, i32, %struct.SelectDest* nocapture readonly) local_unnamed_addr #3

; Function Attrs: nounwind readonly ssp uwtable
declare i8* @columnTypeImpl(%struct.NameContext*, %struct.Expr* nocapture readonly) local_unnamed_addr #18

; Function Attrs: nounwind ssp uwtable
declare void @generateColumnTypes(%struct.Parse*, %struct.SrcList*, %struct.ExprList* nocapture readonly) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @generateColumnNames(%struct.Parse*, %struct.Select* nocapture readonly) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @computeLimitRegisters(%struct.Parse*, %struct.Select* nocapture, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare %struct.CollSeq* @multiSelectCollSeq(%struct.Parse* nocapture, %struct.Select* nocapture readonly, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare %struct.KeyInfo* @multiSelectOrderByKeyInfo(%struct.Parse* nocapture, %struct.Select* nocapture readonly, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @generateWithRecursiveQuery(%struct.Parse*, %struct.Select*, %struct.SelectDest*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3Select(%struct.Parse*, %struct.Select*, %struct.SelectDest* nocapture) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @multiSelectValues(%struct.Parse*, %struct.Select*, %struct.SelectDest* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @multiSelect(%struct.Parse*, %struct.Select*, %struct.SelectDest* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @multiSelectOrderBy(%struct.Parse*, %struct.Select*, %struct.SelectDest* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @generateOutputSubroutine(%struct.Parse*, %struct.Select* nocapture readonly, %struct.SelectDest* nocapture readonly, %struct.SelectDest* nocapture, i32, i32, %struct.KeyInfo*, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare %struct.Expr* @substExpr(%struct.SubstContext* nocapture readonly, %struct.Expr*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @substSelect(%struct.SubstContext* nocapture readonly, %struct.Select*, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @substExprList(%struct.SubstContext*, %struct.ExprList*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @flattenSubquery(%struct.Parse*, %struct.Select*, i32, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local %struct.SrcList* @sqlite3SrcListEnlarge(%struct.Parse* nocapture, %struct.SrcList*, i32, i32) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @constInsert(%struct.WhereConst* nocapture, %struct.Expr*, %struct.Expr*, %struct.Expr* nocapture readonly) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @findConstInWhere(%struct.WhereConst*, %struct.Expr* readonly) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @propagateConstantExprRewrite(%struct.Walker* nocapture readonly, %struct.Expr*) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @propagateConstants(%struct.Parse*, %struct.Select* nocapture readonly) local_unnamed_addr #3

; Function Attrs: norecurse nounwind readnone ssp uwtable
declare dso_local i32 @sqlite3SelectWalkNoop(%struct.Walker* nocapture readnone, %struct.Select* nocapture readnone) #11

; Function Attrs: nounwind ssp uwtable
declare i32 @pushDownWhereTerms(%struct.Parse*, %struct.Select*, %struct.Expr*, i32, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare zeroext i8 @minMaxQuery(%struct.sqlite3*, %struct.Expr* nocapture readonly, %struct.ExprList** nocapture) local_unnamed_addr #3

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare %struct.Table* @isSimpleCount(%struct.Select* nocapture readonly, %struct.AggInfo* nocapture readonly) local_unnamed_addr #7

; Function Attrs: nounwind ssp uwtable
declare i32 @convertCompoundSelectToSubquery(%struct.Walker* nocapture readonly, %struct.Select*) #3

; Function Attrs: nounwind ssp uwtable
declare dso_local %struct.SrcList* @sqlite3SrcListAppendFromTerm(%struct.Parse* nocapture, %struct.SrcList*, %struct.Token*, %struct.Token*, %struct.Token* readonly, %struct.Select*, %struct.Expr*, %struct.IdList*) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @cannotBeFunction(%struct.Parse* nocapture, %struct.SrcList_item* nocapture readonly) local_unnamed_addr #3

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare %struct.Cte* @searchWith(%struct.With*, %struct.SrcList_item* nocapture readonly, %struct.With** nocapture) local_unnamed_addr #15

; Function Attrs: nounwind ssp uwtable
declare i32 @withExpand(%struct.Walker*, %struct.SrcList_item* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3ColumnsFromExprList(%struct.sqlite3*, %struct.ExprList* readonly, i16* nocapture, %struct.Column** nocapture) unnamed_addr #3

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare void @selectPopWith(%struct.Walker* nocapture readonly, %struct.Select* nocapture readonly) #15

; Function Attrs: nounwind ssp uwtable
declare i32 @selectExpander(%struct.Walker*, %struct.Select* nocapture) #3

; Function Attrs: nofree nounwind ssp uwtable
declare dso_local void @sqlite3SrcListAssignCursors(%struct.Parse* nocapture, %struct.SrcList*) unnamed_addr #8

; Function Attrs: nounwind ssp uwtable
declare void @selectAddSubqueryTypeInfo(%struct.Walker* nocapture readonly, %struct.Select* nocapture) #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3SelectAddColumnTypeAndCollation(%struct.Parse* nocapture, %struct.Table* nocapture, %struct.Select* nocapture readonly, i8 signext) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @resetAccumulator(%struct.Parse* nocapture, %struct.AggInfo* nocapture readonly) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @finalizeAggFunctions(%struct.Parse* nocapture readonly, %struct.AggInfo* nocapture readonly) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @updateAccumulator(%struct.Parse*, i32, %struct.AggInfo* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3ExprIfFalse(%struct.Parse*, %struct.Expr*, i32, i32) #3

; Function Attrs: nounwind ssp uwtable
declare void @explainSimpleCount(%struct.Parse* nocapture, %struct.Table* nocapture readonly, %struct.Index* readonly) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @havingToWhereExprCb(%struct.Walker* nocapture, %struct.Expr*) #3

; Function Attrs: nounwind ssp uwtable
declare void @havingToWhere(%struct.Parse*, %struct.Select*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare %struct.SrcList_item* @isSelfJoinView(%struct.SrcList* readonly, %struct.SrcList_item* readonly) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_get_table_cb(i8* nocapture, i32, i8** readonly, i8** nocapture readonly) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_get_table(%struct.sqlite3*, i8*, i8*** nocapture, i32*, i32*, i8**) #3

; Function Attrs: nounwind ssp uwtable
declare void @sqlite3_free_table(i8**) #3

; Function Attrs: nounwind ssp uwtable
declare i8* @triggerSpanDup(%struct.sqlite3*, i8*, i8*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare %struct.TriggerStep* @triggerStepAllocate(%struct.Parse* nocapture, i8 zeroext, %struct.Token* nocapture readonly, i8*, i8*) local_unnamed_addr #3

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare %struct.Table* @tableOfTrigger(%struct.Trigger* nocapture readonly) local_unnamed_addr #7

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i32 @checkColumnOverlap(%struct.IdList* readonly, %struct.ExprList* readonly) local_unnamed_addr #7

; Function Attrs: nounwind ssp uwtable
declare %struct.SrcList* @targetSrcList(%struct.Parse* nocapture readonly, %struct.TriggerStep* nocapture readonly) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @codeTriggerProgram(%struct.Parse*, %struct.TriggerStep* readonly, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3Update(%struct.Parse*, %struct.SrcList*, %struct.ExprList*, %struct.Expr*, i32, %struct.Upsert*) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3Insert(%struct.Parse*, %struct.SrcList*, %struct.Select*, %struct.IdList*, i32, %struct.Upsert*) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local %struct.IdList* @sqlite3IdListDup(%struct.sqlite3*, %struct.IdList* readonly) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3DeleteFrom(%struct.Parse*, %struct.SrcList*, %struct.Expr*) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @transferParseError(%struct.Parse* nocapture, %struct.Parse* nocapture readonly) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare %struct.TriggerPrg* @codeRowTrigger(%struct.Parse*, %struct.Trigger*, %struct.Table*, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3VdbeDelete(%struct.Vdbe*) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare %struct.TriggerPrg* @getRowTrigger(%struct.Parse*, %struct.Trigger*, %struct.Table*, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @indexColumnIsBeingUpdated(%struct.Index* nocapture readonly, i32, i32*, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @indexWhereClauseMightChange(%struct.Index* nocapture readonly, i32*, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @execSql(%struct.sqlite3*, i8** nocapture, i8*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @execSqlF(%struct.sqlite3*, i8** nocapture, i8*, ...) local_unnamed_addr #3

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i8* @explainIndexColumnName(%struct.Index* nocapture readonly, i32) local_unnamed_addr #7

; Function Attrs: nounwind ssp uwtable
declare void @explainAppendTerm(%struct.sqlite3_str*, %struct.Index* nocapture readonly, i32, i32, i32, i8*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @explainIndexRange(%struct.sqlite3_str*, %struct.WhereLoop* nocapture readonly) local_unnamed_addr #3

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare void @disableTerm(%struct.WhereLevel* nocapture readonly, %struct.WhereTerm* nocapture) local_unnamed_addr #15

; Function Attrs: nounwind ssp uwtable
declare void @codeApplyAffinity(%struct.Parse* nocapture readonly, i32, i32, i8*) local_unnamed_addr #3

; Function Attrs: nofree nounwind ssp uwtable
declare void @updateRangeAffinityStr(%struct.Expr* nocapture readonly, i32, i8* nocapture) local_unnamed_addr #8

; Function Attrs: nounwind ssp uwtable
declare %struct.Expr* @removeUnindexableInClauseTerms(%struct.Parse* nocapture readonly, i32, %struct.WhereLoop* nocapture readonly, %struct.Expr*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @codeEqualityTerm(%struct.Parse*, %struct.WhereTerm* nocapture, %struct.WhereLevel* nocapture, i32, i32, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3FindInIndex(%struct.Parse*, %struct.Expr*, i32, i32*, i32*, i32* nocapture) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @codeAllEqualityTerms(%struct.Parse*, %struct.WhereLevel*, i32, i32, i8** nocapture) local_unnamed_addr #3

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare void @whereLikeOptimizationStringFixup(%struct.Vdbe* nocapture readonly, %struct.WhereLevel* nocapture readonly, %struct.WhereTerm* nocapture readonly) local_unnamed_addr #15

; Function Attrs: nounwind ssp uwtable
declare void @codeDeferredSeek(%struct.WhereInfo* nocapture, %struct.Index* nocapture readonly, i32, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @codeExprOrVector(%struct.Parse*, %struct.Expr*, i32, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @preserveExpr(%struct.IdxExprTrans* nocapture readonly, %struct.Expr*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @whereIndexExprTransNode(%struct.Walker* nocapture readonly, %struct.Expr*) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @whereIndexExprTransColumn(%struct.Walker* nocapture readonly, %struct.Expr*) #3

; Function Attrs: nounwind ssp uwtable
declare void @whereIndexExprTrans(%struct.Index* nocapture readonly, i32, i32, %struct.WhereInfo*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @whereApplyPartialIndexConstraints(%struct.Expr* readonly, i32, %struct.WhereClause* nocapture readonly) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @whereOrInfoDelete(%struct.sqlite3*, %struct.WhereOrInfo*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3WhereClauseClear(%struct.WhereClause* readonly) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @whereAndInfoDelete(%struct.sqlite3*, %struct.WhereAndInfo*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @whereClauseInsert(%struct.WhereClause*, %struct.Expr*, i16 zeroext) local_unnamed_addr #3

; Function Attrs: norecurse nounwind readnone ssp uwtable
declare i32 @allowedOp(i32) local_unnamed_addr #11

; Function Attrs: nounwind ssp uwtable
declare zeroext i16 @exprCommute(%struct.Parse* nocapture, %struct.Expr* nocapture) local_unnamed_addr #3

; Function Attrs: norecurse nounwind readnone ssp uwtable
declare zeroext i16 @operatorMask(i32) local_unnamed_addr #11

; Function Attrs: nounwind ssp uwtable
declare i32 @isLikeOrGlob(%struct.Parse*, %struct.Expr* nocapture readonly, %struct.Expr** nocapture, i32* nocapture, i32* nocapture) local_unnamed_addr #3

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare void @transferJoinMarkings(%struct.Expr*, %struct.Expr* nocapture readonly) local_unnamed_addr #15

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare void @markTermAsChild(%struct.WhereClause* nocapture readonly, i32, i32) local_unnamed_addr #15

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare %struct.WhereTerm* @whereNthSubterm(%struct.WhereTerm* readonly, i32) local_unnamed_addr #7

; Function Attrs: nounwind ssp uwtable
declare void @whereCombineDisjuncts(%struct.SrcList* nocapture readonly, %struct.WhereClause*, %struct.WhereTerm* nocapture readonly, %struct.WhereTerm* nocapture readonly) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @exprAnalyze(%struct.SrcList* nocapture readonly, %struct.WhereClause*, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @exprAnalyzeOrTerm(%struct.SrcList* nocapture readonly, %struct.WhereClause*, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3WhereSplit(%struct.WhereClause*, %struct.Expr*, i8 zeroext) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @termIsEquivalence(%struct.Parse* nocapture, %struct.Expr* nocapture readonly) local_unnamed_addr #3

; Function Attrs: nofree nounwind ssp uwtable
declare i64 @exprSelectUsage(%struct.WhereMaskSet* nocapture, %struct.Select* readonly) local_unnamed_addr #8

; Function Attrs: noinline nounwind ssp uwtable
declare i32 @exprMightBeIndexed2(%struct.SrcList* nocapture readonly, i64, i32* nocapture, %struct.Expr* readonly) local_unnamed_addr #1

; Function Attrs: nounwind ssp uwtable
declare i32 @exprMightBeIndexed(%struct.SrcList* nocapture readonly, i64, i32* nocapture, %struct.Expr* readonly, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3ExprCheckIN(%struct.Parse* nocapture, %struct.Expr* nocapture readonly) unnamed_addr #3

; Function Attrs: nofree nounwind ssp uwtable
declare dso_local i64 @sqlite3WhereExprUsageNN(%struct.WhereMaskSet* nocapture, %struct.Expr* nocapture readonly) unnamed_addr #8

; Function Attrs: nofree nounwind ssp uwtable
declare void @whereOrMove(%struct.WhereOrSet*, %struct.WhereOrSet*) local_unnamed_addr #8

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare i32 @whereOrInsert(%struct.WhereOrSet* nocapture, i64, i16 signext, i16 signext) local_unnamed_addr #15

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare void @createMask(%struct.WhereMaskSet* nocapture, i32) local_unnamed_addr #15

; Function Attrs: nounwind ssp uwtable
declare %struct.WhereTerm* @whereScanNext(%struct.WhereScan* nocapture) local_unnamed_addr #3

; Function Attrs: noinline nounwind ssp uwtable
declare %struct.WhereTerm* @whereScanInitIndexExpr(%struct.WhereScan* nocapture) local_unnamed_addr #1

; Function Attrs: nounwind ssp uwtable
declare %struct.WhereTerm* @whereScanInit(%struct.WhereScan* nocapture, %struct.WhereClause*, i32, i32, i32, %struct.Index* readonly) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @findIndexCol(%struct.Parse* nocapture, %struct.ExprList* nocapture readonly, i32, %struct.Index* nocapture readonly, i32) local_unnamed_addr #3

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i32 @indexColumnNotNull(%struct.Index* nocapture readonly, i32) local_unnamed_addr #7

; Function Attrs: nounwind ssp uwtable
declare i32 @isDistinctRedundant(%struct.Parse* nocapture, %struct.SrcList* nocapture readonly, %struct.WhereClause*, %struct.ExprList* nocapture readonly) local_unnamed_addr #3

; Function Attrs: norecurse nounwind readnone ssp uwtable
declare signext i16 @estLog(i16 signext) local_unnamed_addr #11

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare void @translateColumnToCopy(%struct.Parse* nocapture readonly, i32, i32, i32, i32) local_unnamed_addr #15

; Function Attrs: nounwind readonly ssp uwtable
declare i32 @termCanDriveIndex(%struct.WhereTerm* nocapture readonly, %struct.SrcList_item* nocapture readonly, i64) local_unnamed_addr #18

; Function Attrs: nounwind ssp uwtable
declare void @constructAutomaticIndex(%struct.Parse*, %struct.WhereClause* nocapture readonly, %struct.SrcList_item* nocapture readonly, i64, %struct.WhereLevel* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @whereLoopResize(%struct.sqlite3*, %struct.WhereLoop*, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3GenerateIndexKey(%struct.Parse*, %struct.Index* nocapture, i32, i32, i32, i32*, %struct.Index* readonly, i32) unnamed_addr #3

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare signext i16 @whereRangeAdjust(%struct.WhereTerm* readonly, i16 signext) local_unnamed_addr #7

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare i32 @whereRangeScanEst(%struct.Parse* nocapture readnone, %struct.WhereLoopBuilder* nocapture readnone, %struct.WhereTerm* readonly, %struct.WhereTerm* readonly, %struct.WhereLoop* nocapture) local_unnamed_addr #15

; Function Attrs: nofree norecurse nounwind ssp uwtable writeonly
declare void @whereLoopInit(%struct.WhereLoop*) local_unnamed_addr #10

; Function Attrs: nounwind ssp uwtable
declare void @whereLoopClearUnion(%struct.sqlite3*, %struct.WhereLoop* nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @whereLoopClear(%struct.sqlite3*, %struct.WhereLoop*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @whereLoopXfer(%struct.sqlite3*, %struct.WhereLoop*, %struct.WhereLoop*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @whereLoopDelete(%struct.sqlite3*, %struct.WhereLoop*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @whereInfoFree(%struct.sqlite3*, %struct.WhereInfo*) local_unnamed_addr #3

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i32 @whereLoopCheaperProperSubset(%struct.WhereLoop* nocapture readonly, %struct.WhereLoop* nocapture readonly) local_unnamed_addr #7

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare void @whereLoopAdjustCost(%struct.WhereLoop* readonly, %struct.WhereLoop* nocapture) local_unnamed_addr #15

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare %struct.WhereLoop** @whereLoopFindLesser(%struct.WhereLoop** readonly, %struct.WhereLoop* nocapture readonly) local_unnamed_addr #7

; Function Attrs: nounwind ssp uwtable
declare i32 @whereLoopInsert(%struct.WhereLoopBuilder* nocapture, %struct.WhereLoop*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @whereLoopOutputAdjust(%struct.WhereClause* nocapture readonly, %struct.WhereLoop* nocapture, i16 signext) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @whereRangeVectorLen(%struct.Parse* nocapture, i32, %struct.Index* nocapture readonly, i32, %struct.WhereTerm* nocapture readonly) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @whereLoopAddBtreeIndex(%struct.WhereLoopBuilder*, %struct.SrcList_item* readonly, %struct.Index* readonly, i16 signext) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @indexMightHelpWithOrderBy(%struct.WhereLoopBuilder* nocapture readonly, %struct.Index* nocapture readonly, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @whereUsablePartialIndex(i32, i32, %struct.WhereClause* nocapture readonly, %struct.Expr* readonly) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @whereLoopAddBtree(%struct.WhereLoopBuilder*, i64) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @whereLoopAddOr(%struct.WhereLoopBuilder* nocapture, i64, i64) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @whereLoopAddAll(%struct.WhereLoopBuilder*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare signext i8 @wherePathSatisfiesOrderBy(%struct.WhereInfo*, %struct.ExprList* nocapture readonly, %struct.WherePath* nocapture readonly, i16 zeroext, i16 zeroext, %struct.WhereLoop* nocapture, i64* nocapture) local_unnamed_addr #3

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare signext i16 @whereSortingCost(%struct.WhereInfo* nocapture readonly, i16 signext, i32, i32) local_unnamed_addr #7

; Function Attrs: nounwind ssp uwtable
declare i32 @wherePathSolver(%struct.WhereInfo*, i16 signext) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @whereShortCut(%struct.WhereLoopBuilder* nocapture readonly) local_unnamed_addr #3

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare i32 @exprNodeIsDeterministic(%struct.Walker* nocapture, %struct.Expr* nocapture readonly) #15

; Function Attrs: nounwind ssp uwtable
declare i32 @exprIsDeterministic(%struct.Expr*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @row_numberStepFunc(%struct.sqlite3_context* nocapture readonly, i32, %struct.sqlite3_value** nocapture readnone) #3

; Function Attrs: nounwind ssp uwtable
declare void @row_numberValueFunc(%struct.sqlite3_context* nocapture readonly) #3

; Function Attrs: nounwind ssp uwtable
declare void @dense_rankStepFunc(%struct.sqlite3_context* nocapture readonly, i32, %struct.sqlite3_value** nocapture readnone) #3

; Function Attrs: nounwind ssp uwtable
declare void @dense_rankValueFunc(%struct.sqlite3_context* nocapture readonly) #3

; Function Attrs: nounwind ssp uwtable
declare void @nth_valueStepFunc(%struct.sqlite3_context* nocapture, i32, %struct.sqlite3_value** nocapture readonly) #3

; Function Attrs: nounwind ssp uwtable
declare void @nth_valueFinalizeFunc(%struct.sqlite3_context* nocapture readonly) #3

; Function Attrs: nounwind ssp uwtable
declare void @first_valueStepFunc(%struct.sqlite3_context* nocapture, i32, %struct.sqlite3_value** nocapture readonly) #3

; Function Attrs: nounwind ssp uwtable
declare void @first_valueFinalizeFunc(%struct.sqlite3_context* nocapture readonly) #3

; Function Attrs: nounwind ssp uwtable
declare void @rankStepFunc(%struct.sqlite3_context* nocapture readonly, i32, %struct.sqlite3_value** nocapture readnone) #3

; Function Attrs: nounwind ssp uwtable
declare void @rankValueFunc(%struct.sqlite3_context* nocapture readonly) #3

; Function Attrs: nounwind ssp uwtable
declare void @percent_rankStepFunc(%struct.sqlite3_context* nocapture readonly, i32, %struct.sqlite3_value** nocapture readnone) #3

; Function Attrs: nounwind ssp uwtable
declare void @percent_rankInvFunc(%struct.sqlite3_context* nocapture readonly, i32, %struct.sqlite3_value** nocapture readnone) #3

; Function Attrs: nounwind ssp uwtable
declare void @percent_rankValueFunc(%struct.sqlite3_context* nocapture readonly) #3

; Function Attrs: nounwind ssp uwtable
declare void @cume_distStepFunc(%struct.sqlite3_context* nocapture readonly, i32, %struct.sqlite3_value** nocapture readnone) #3

; Function Attrs: nounwind ssp uwtable
declare void @cume_distInvFunc(%struct.sqlite3_context* nocapture readonly, i32, %struct.sqlite3_value** nocapture readnone) #3

; Function Attrs: nounwind ssp uwtable
declare void @cume_distValueFunc(%struct.sqlite3_context* nocapture readonly) #3

; Function Attrs: nounwind ssp uwtable
declare void @ntileStepFunc(%struct.sqlite3_context* nocapture, i32, %struct.sqlite3_value** nocapture readonly) #3

; Function Attrs: nounwind ssp uwtable
declare void @ntileInvFunc(%struct.sqlite3_context* nocapture readonly, i32, %struct.sqlite3_value** nocapture readnone) #3

; Function Attrs: nounwind ssp uwtable
declare void @ntileValueFunc(%struct.sqlite3_context* nocapture readonly) #3

; Function Attrs: nounwind ssp uwtable
declare void @last_valueStepFunc(%struct.sqlite3_context* nocapture, i32, %struct.sqlite3_value** nocapture readonly) #3

; Function Attrs: nounwind ssp uwtable
declare void @last_valueInvFunc(%struct.sqlite3_context* nocapture readonly, i32, %struct.sqlite3_value** nocapture readnone) #3

; Function Attrs: nounwind ssp uwtable
declare void @last_valueValueFunc(%struct.sqlite3_context* nocapture readonly) #3

; Function Attrs: nounwind ssp uwtable
declare void @last_valueFinalizeFunc(%struct.sqlite3_context* nocapture readonly) #3

; Function Attrs: norecurse nounwind readnone ssp uwtable
declare void @noopStepFunc(%struct.sqlite3_context* nocapture, i32, %struct.sqlite3_value** nocapture) #11

; Function Attrs: norecurse nounwind readnone ssp uwtable
declare void @noopValueFunc(%struct.sqlite3_context* nocapture) #11

; Function Attrs: nounwind ssp uwtable
declare %struct.Window* @windowFind(%struct.Parse* nocapture, %struct.Window*, i8*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @selectWindowRewriteExprCb(%struct.Walker* nocapture readonly, %struct.Expr*) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @selectWindowRewriteSelectCb(%struct.Walker*, %struct.Select*) #3

; Function Attrs: nounwind ssp uwtable
declare void @selectWindowRewriteEList(%struct.Parse*, %struct.Window*, %struct.SrcList*, %struct.ExprList* readonly, %struct.Table*, %struct.ExprList** nocapture) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare %struct.ExprList* @exprListAppendList(%struct.Parse* nocapture readonly, %struct.ExprList*, %struct.ExprList* readonly, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @windowCheckValue(%struct.Parse*, i32, i32) local_unnamed_addr #3

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i32 @windowArgCount(%struct.Window* nocapture readonly) local_unnamed_addr #7

; Function Attrs: nounwind ssp uwtable
declare void @windowReadPeerValues(%struct.WindowCodeArg* nocapture readonly, i32, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @windowAggStep(%struct.WindowCodeArg* nocapture readonly, %struct.Window* readonly, i32, i32, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @windowAggFinal(%struct.WindowCodeArg* nocapture readonly, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @windowFullScan(%struct.WindowCodeArg* nocapture readonly) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @windowReturnOneRow(%struct.WindowCodeArg* nocapture readonly) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @windowInitAccum(%struct.Parse*, %struct.Window* readonly) local_unnamed_addr #3

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i32 @windowCacheFrame(%struct.Window* readonly) local_unnamed_addr #7

; Function Attrs: nounwind ssp uwtable
declare void @windowIfNewPeer(%struct.Parse*, %struct.ExprList* readonly, i32, i32, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @windowCodeRangeTest(%struct.WindowCodeArg* nocapture readonly, i32, i32, i32, i32, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @windowCodeOp(%struct.WindowCodeArg*, i32, i32, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @windowExprGtZero(%struct.Parse* nocapture readonly, %struct.Expr* readonly) local_unnamed_addr #3

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare void @disableLookaside(%struct.Parse* nocapture) local_unnamed_addr #15

; Function Attrs: nounwind ssp uwtable
declare void @yy_destructor(%struct.yyParser* nocapture readonly, i16 zeroext, %union.YYMINORTYPE* nocapture readonly) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3WindowDelete(%struct.sqlite3*, %struct.Window*) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3DeleteTriggerStep(%struct.sqlite3*, %struct.TriggerStep*) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @yy_pop_parser_stack(%struct.yyParser* nocapture) local_unnamed_addr #3

; Function Attrs: norecurse nounwind readnone ssp uwtable
declare zeroext i16 @yy_find_shift_action(i16 zeroext, i16 zeroext) local_unnamed_addr #11

; Function Attrs: norecurse nounwind readnone ssp uwtable
declare zeroext i16 @yy_find_reduce_action(i16 zeroext, i16 zeroext) local_unnamed_addr #11

; Function Attrs: nounwind ssp uwtable
declare void @yyStackOverflow(%struct.yyParser*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @yy_shift(%struct.yyParser*, i16 zeroext, i16 zeroext, i8*, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare zeroext i16 @yy_reduce(%struct.yyParser*, i32, i32, i8*, i32, %struct.Parse*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3StartTable(%struct.Parse*, %struct.Token*, %struct.Token*, i32, i32, i32) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3EndTable(%struct.Parse*, %struct.Token* nocapture readonly, %struct.Token* readonly, i8 zeroext, %struct.Select*) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3AddDefaultValue(%struct.Parse*, %struct.Expr*, i8*, i8*) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local %struct.Expr* @tokenExpr(%struct.Parse* nocapture, i32, i8*, i32) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3AddPrimaryKey(%struct.Parse*, %struct.ExprList*, i32, i32, i32) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3CreateForeignKey(%struct.Parse* nocapture, %struct.ExprList*, %struct.Token*, %struct.ExprList*, i32) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3AddGenerated(%struct.Parse* nocapture, %struct.Expr*, %struct.Token* readonly) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3DropTable(%struct.Parse*, %struct.SrcList*, i32, i32) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3JoinType(%struct.Parse* nocapture, %struct.Token*, %struct.Token*, %struct.Token*) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local %struct.ExprList* @sqlite3ExprListAppendVector(%struct.Parse*, %struct.ExprList*, %struct.IdList*, %struct.Expr*) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local %struct.IdList* @sqlite3IdListAppend(%struct.Parse* nocapture, %struct.IdList*, %struct.Token* readonly) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3GetInt32(i8* nocapture readonly, i32*) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3Vacuum(%struct.Parse*, %struct.Token*, %struct.Expr*) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3Pragma(%struct.Parse*, %struct.Token*, %struct.Token*, %struct.Token*, i32) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3Analyze(%struct.Parse*, %struct.Token*, %struct.Token* nocapture readonly) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local %struct.With* @sqlite3WithAdd(%struct.Parse* nocapture, %struct.With*, %struct.Token* readonly, %struct.ExprList*, %struct.Select*) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3WindowChain(%struct.Parse* nocapture, %struct.Window* nocapture, %struct.Window* readonly) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local %struct.Window* @sqlite3WindowAlloc(%struct.Parse*, i32, i32, %struct.Expr*, i32, %struct.Expr*, i8 zeroext) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare void @yy_syntax_error(%struct.yyParser* nocapture, i32, i8*, i32) local_unnamed_addr #3

; Function Attrs: norecurse nounwind readnone ssp uwtable
declare void @yy_accept(%struct.yyParser* nocapture) local_unnamed_addr #11

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare i32 @keywordCode(i8* nocapture readonly, i32 returned, i32* nocapture) local_unnamed_addr #15

; Function Attrs: nofree norecurse nounwind ssp uwtable writeonly
declare i32 @sqlite3_keyword_name(i32, i8** nocapture, i32* nocapture) #10

; Function Attrs: norecurse nounwind readnone ssp uwtable
declare i32 @sqlite3_keyword_count() #11

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_keyword_check(i8* nocapture readonly, i32) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @getToken(i8** nocapture) local_unnamed_addr #3

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare dso_local i32 @sqlite3GetToken(i8* readonly, i32*) unnamed_addr #15

; Function Attrs: nounwind ssp uwtable
declare i32 @analyzeWindowKeyword(i8*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @analyzeOverKeyword(i8*, i32) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @analyzeFilterKeyword(i8*, i32) local_unnamed_addr #3

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i32 @sqlite3_complete(i8* readonly) #7

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_complete16(i8*) #3

; Function Attrs: norecurse nounwind readnone ssp uwtable
declare i32 @sqlite3_libversion_number() #11

; Function Attrs: norecurse nounwind readnone ssp uwtable
declare i32 @sqlite3_threadsafe() #11

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_shutdown() local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_config(i32, ...) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @setupLookaside(%struct.sqlite3*, i8*, i32, i32) local_unnamed_addr #3

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare %struct.sqlite3_mutex* @sqlite3_db_mutex(%struct.sqlite3* nocapture readonly) #7

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_db_release_memory(%struct.sqlite3* nocapture) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_db_cacheflush(%struct.sqlite3* nocapture) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_db_config(%struct.sqlite3*, i32, ...) #3

; Function Attrs: nounwind readonly ssp uwtable
declare i32 @binCollFunc(i8* nocapture readnone, i32, i8* nocapture readonly, i32, i8* nocapture readonly) #18

; Function Attrs: nounwind readonly ssp uwtable
declare i32 @rtrimCollFunc(i8* nocapture readnone, i32, i8* nocapture readonly, i32, i8* nocapture readonly) #18

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i32 @nocaseCollatingFunc(i8* nocapture readnone, i32, i8* readonly, i32, i8* readonly) #7

; Function Attrs: nounwind ssp uwtable
declare void @sqlite3_set_last_insert_rowid(%struct.sqlite3* nocapture, i64) #3

; Function Attrs: nounwind ssp uwtable
declare void @functionDestroy(%struct.sqlite3*, %struct.FuncDef* nocapture readonly) local_unnamed_addr #3

; Function Attrs: norecurse nounwind readnone ssp uwtable
declare void @disconnectAllVtab(%struct.sqlite3* nocapture) local_unnamed_addr #11

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i32 @connectionIsBusy(%struct.sqlite3* nocapture readonly) local_unnamed_addr #7

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_close(%struct.sqlite3*) #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3Close(%struct.sqlite3*, i32) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_close_v2(%struct.sqlite3*) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqliteDefaultBusyCallback(i8* nocapture readonly, i32, %struct.sqlite3_file* nocapture readnone) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_busy_handler(%struct.sqlite3* nocapture, i32 (i8*, i32)*, i8*) #3

; Function Attrs: nounwind ssp uwtable
declare void @sqlite3_progress_handler(%struct.sqlite3* nocapture, i32, i32 (i8*)*, i8*) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_busy_timeout(%struct.sqlite3*, i32) #3

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare void @sqlite3_interrupt(%struct.sqlite3*) #15

; Function Attrs: nounwind ssp uwtable
declare i32 @createFunctionApi(%struct.sqlite3*, i8*, i32, i32, i8*, void (%struct.sqlite3_context*, i32, %struct.sqlite3_value**)*, void (%struct.sqlite3_context*, i32, %struct.sqlite3_value**)*, void (%struct.sqlite3_context*)*, void (%struct.sqlite3_context*)*, void (%struct.sqlite3_context*, i32, %struct.sqlite3_value**)*, void (i8*)*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3CreateFunc(%struct.sqlite3*, i8*, i32, i32, i8*, void (%struct.sqlite3_context*, i32, %struct.sqlite3_value**)*, void (%struct.sqlite3_context*, i32, %struct.sqlite3_value**)*, void (%struct.sqlite3_context*)*, void (%struct.sqlite3_context*)*, void (%struct.sqlite3_context*, i32, %struct.sqlite3_value**)*, %struct.FuncDestructor*) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_create_function(%struct.sqlite3*, i8*, i32, i32, i8*, void (%struct.sqlite3_context*, i32, %struct.sqlite3_value**)*, void (%struct.sqlite3_context*, i32, %struct.sqlite3_value**)*, void (%struct.sqlite3_context*)*) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_create_function_v2(%struct.sqlite3*, i8*, i32, i32, i8*, void (%struct.sqlite3_context*, i32, %struct.sqlite3_value**)*, void (%struct.sqlite3_context*, i32, %struct.sqlite3_value**)*, void (%struct.sqlite3_context*)*, void (i8*)*) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_create_window_function(%struct.sqlite3*, i8*, i32, i32, i8*, void (%struct.sqlite3_context*, i32, %struct.sqlite3_value**)*, void (%struct.sqlite3_context*)*, void (%struct.sqlite3_context*)*, void (%struct.sqlite3_context*, i32, %struct.sqlite3_value**)*, void (i8*)*) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_create_function16(%struct.sqlite3*, i8*, i32, i32, i8*, void (%struct.sqlite3_context*, i32, %struct.sqlite3_value**)*, void (%struct.sqlite3_context*, i32, %struct.sqlite3_value**)*, void (%struct.sqlite3_context*)*) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_overload_function(%struct.sqlite3*, i8*, i32) #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3InvalidFunction(%struct.sqlite3_context* nocapture, i32, %struct.sqlite3_value** nocapture readnone) #3

; Function Attrs: nounwind ssp uwtable
declare i8* @sqlite3_commit_hook(%struct.sqlite3* nocapture, i32 (i8*)*, i8*) #3

; Function Attrs: nounwind ssp uwtable
declare i8* @sqlite3_update_hook(%struct.sqlite3* nocapture, void (i8*, i32, i8*, i8*, i64)*, i8*) #3

; Function Attrs: nounwind ssp uwtable
declare i8* @sqlite3_rollback_hook(%struct.sqlite3* nocapture, void (i8*)*, i8*) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_wal_autocheckpoint(%struct.sqlite3* nocapture, i32) #3

; Function Attrs: nounwind ssp uwtable
declare i8* @sqlite3_wal_hook(%struct.sqlite3* nocapture, i32 (i8*, %struct.sqlite3*, i8*, i32)*, i8*) #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3WalDefaultHook(i8*, %struct.sqlite3*, i8*, i32) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_wal_checkpoint_v2(%struct.sqlite3*, i8*, i32, i32*, i32*) #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3Checkpoint(%struct.sqlite3* nocapture readonly, i32, i32, i32*, i32*) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_wal_checkpoint(%struct.sqlite3*, i8*) #3

; Function Attrs: nounwind ssp uwtable
declare i8* @sqlite3_errmsg16(%struct.sqlite3*) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_errcode(%struct.sqlite3* readonly) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_extended_errcode(%struct.sqlite3* readonly) #3

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i32 @sqlite3_system_errno(%struct.sqlite3* readonly) #7

; Function Attrs: norecurse nounwind readnone ssp uwtable
declare i8* @sqlite3_errstr(i32) #11

; Function Attrs: nounwind ssp uwtable
declare i32 @createCollation(%struct.sqlite3*, i8*, i8 zeroext, i8*, i32 (i8*, i32, i8*, i32, i8*)*, void (i8*)*) local_unnamed_addr #3

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare i32 @sqlite3_limit(%struct.sqlite3* nocapture, i32, i32) #15

; Function Attrs: nounwind readonly ssp uwtable
declare i8* @uriParameter(i8* readonly, i8* nocapture readonly) local_unnamed_addr #18

; Function Attrs: nounwind ssp uwtable
declare i32 @openDatabase(i8*, %struct.sqlite3** nocapture, i32, i8*) local_unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_open(i8*, %struct.sqlite3** nocapture) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_open_v2(i8*, %struct.sqlite3** nocapture, i32, i8*) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_open16(i8*, %struct.sqlite3** nocapture) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_create_collation(%struct.sqlite3*, i8*, i32, i8*, i32 (i8*, i32, i8*, i32, i8*)*) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_create_collation_v2(%struct.sqlite3*, i8*, i32, i8*, i32 (i8*, i32, i8*, i32, i8*)*, void (i8*)*) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_create_collation16(%struct.sqlite3*, i8*, i32, i8*, i32 (i8*, i32, i8*, i32, i8*)*) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_collation_needed(%struct.sqlite3* nocapture, i8*, void (i8*, %struct.sqlite3*, i32, i8*)*) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_collation_needed16(%struct.sqlite3* nocapture, i8*, void (i8*, %struct.sqlite3*, i32, i8*)*) #3

; Function Attrs: norecurse nounwind readnone ssp uwtable
declare i32 @sqlite3_global_recover() local_unnamed_addr #11

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i32 @sqlite3_get_autocommit(%struct.sqlite3* nocapture readonly) #7

; Function Attrs: norecurse nounwind readnone ssp uwtable
declare void @sqlite3_thread_cleanup() #11

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_table_column_metadata(%struct.sqlite3*, i8* readonly, i8*, i8*, i8**, i8**, i32*, i32*, i32*) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_sleep(i32) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_extended_result_codes(%struct.sqlite3* nocapture, i32) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_file_control(%struct.sqlite3* nocapture readonly, i8* readonly, i32, i8*) #3

; Function Attrs: nounwind ssp uwtable
declare i32 @sqlite3_test_control(i32, ...) #3

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i8* @databaseName(i8* readonly) local_unnamed_addr #7

; Function Attrs: nofree nounwind ssp uwtable
declare nonnull i8* @appendText(i8*, i8*) local_unnamed_addr #8

; Function Attrs: nounwind ssp uwtable
declare i8* @sqlite3_create_filename(i8*, i8*, i8*, i32, i8** nocapture readonly) #3

; Function Attrs: nounwind readonly ssp uwtable
declare i8* @sqlite3_uri_key(i8* readonly, i32) #18

; Function Attrs: nounwind ssp uwtable
declare i64 @sqlite3_uri_int64(i8* readonly, i8* readonly, i64) #3

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i8* @sqlite3_filename_database(i8* readonly) #7

; Function Attrs: nounwind readonly ssp uwtable
declare nonnull i8* @sqlite3_filename_journal(i8* readonly) #18

; Function Attrs: nounwind readonly ssp uwtable
declare nonnull i8* @sqlite3_filename_wal(i8* readonly) #18

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i8* @sqlite3_db_filename(%struct.sqlite3* nocapture readonly, i8* readonly) #7

; Function Attrs: norecurse nounwind readonly ssp uwtable
declare i32 @sqlite3_db_readonly(%struct.sqlite3* nocapture readonly, i8* readonly) #7

; Function Attrs: noinline nounwind ssp uwtable
declare dso_local void @sqlite3ErrorFinish(%struct.sqlite3* nocapture, i32) unnamed_addr #1

; Function Attrs: nofree nounwind ssp uwtable
declare dso_local void @sqlite3BitvecClear(%struct.Bitvec*, i32, i8*) unnamed_addr #8

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3BtreeTripAllCursors(%struct.Btree*, i32, i32) unnamed_addr #3

; Function Attrs: noinline nounwind ssp uwtable
declare dso_local i32 @sqlite3VdbeMemTranslate(%struct.sqlite3_value*, i8 zeroext) unnamed_addr #1

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3BtreeCloseCursor(%struct.BtCursor*) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3VdbeSorterReset(%struct.sqlite3*, %struct.VdbeSorter*) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3VdbeTransferError(%struct.Vdbe* nocapture readonly) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3RollbackAll(%struct.sqlite3*, i32) unnamed_addr #3

; Function Attrs: noreturn
declare void @exit(i32) local_unnamed_addr #24

; Function Attrs: norecurse nounwind readnone ssp uwtable
declare dso_local void @sqlite3NoopDestructor(i8* nocapture) #11

; Function Attrs: noinline nounwind ssp uwtable
declare dso_local i32 @sqlite3VdbeFinishMoveto(%struct.VdbeCursor* nocapture) unnamed_addr #1

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3SchemaClear(i8* nocapture) #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3InitOne(%struct.sqlite3*, i32, i8**, i32) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3InitCallback(i8* nocapture, i32, i8**, i8** nocapture readnone) #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3AnalysisLoad(%struct.sqlite3*, i32) unnamed_addr #3

; Function Attrs: nofree norecurse nounwind ssp uwtable
declare dso_local void @sqlite3VdbeFrameMemDel(i8*) #15

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3PagerSetJournalMode(%struct.Pager*, i32) unnamed_addr #3

; Function Attrs: noinline nounwind ssp uwtable
declare dso_local i32 @sqlite3RunVacuum(i8** nocapture, %struct.sqlite3*, i32, %struct.sqlite3_value*) unnamed_addr #1

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3Prepare(%struct.sqlite3*, i8*, i32, i32, %struct.Vdbe*, %struct.sqlite3_stmt** nocapture, i8**) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3RowSetDelete(i8*) #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3WalClose(%struct.Wal*, %struct.sqlite3*, i32, i32, i8*) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3WalCheckpoint(%struct.Wal*, %struct.sqlite3*, i32, i32 (i8*)*, i8*, i32, i32, i8*, i32*, i32*) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3BtreeSetSpillSize(%struct.Btree* nocapture, i32) unnamed_addr #3

declare i32 @"\01_pthread_join"(%struct._opaque_pthread_t*, i8**) local_unnamed_addr #12

declare i32 @pthread_create(%struct._opaque_pthread_t**, %struct._opaque_pthread_attr_t*, i8* (i8*)*, i8*) local_unnamed_addr #12

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3WalkSelectExpr(%struct.Walker*, %struct.Select* nocapture readonly) unnamed_addr #3

; Function Attrs: noinline nounwind ssp uwtable
declare dso_local void @sqlite3ExprDeleteNN(%struct.sqlite3*, %struct.Expr*) unnamed_addr #1

; Function Attrs: nounwind ssp uwtable
declare dso_local %struct.SrcList* @sqlite3SrcListDup(%struct.sqlite3*, %struct.SrcList* readonly, i32) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3ExprCodeGeneratedColumn(%struct.Parse*, %struct.Column*, i32) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3ExprCodeRunJustOnce(%struct.Parse*, %struct.Expr*, i32) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3ExprCodeIN(%struct.Parse*, %struct.Expr*, i32, i32) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3ExprCodeCopy(%struct.Parse*, %struct.Expr*, i32) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3ExprCodeGetColumnOfTable(%struct.Vdbe* nocapture, %struct.Table* readonly, i32, i32, i32) unnamed_addr #3

; Function Attrs: noinline nounwind readonly ssp uwtable
declare dso_local i32 @sqlite3BlobCompare(%struct.sqlite3_value* nocapture readonly, %struct.sqlite3_value* nocapture readonly) unnamed_addr #25

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3WindowCompare(%struct.Parse*, %struct.Window* readonly, %struct.Window* readonly, i32) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local %struct.KeyInfo* @sqlite3KeyInfoOfIndex(%struct.Parse* nocapture, %struct.Index* nocapture) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3PagerClose(%struct.Pager*, %struct.sqlite3*) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3AuthReadCol(%struct.Parse* nocapture, i8*, i8*, i32) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3ReadSchema(%struct.Parse*) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local %struct.Table* @sqlite3ResultSetOfSelect(%struct.Parse*, %struct.Select*, i8 signext) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3FixSrcList(%struct.DbFixer* nocapture readonly, %struct.SrcList*) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3CheckObjectName(%struct.Parse* nocapture, i8*, i8* readonly, i8* readonly) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3FindDb(%struct.sqlite3*, %struct.Token* readonly) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3FixSelect(%struct.DbFixer* nocapture readonly, %struct.Select* readonly) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3FixExpr(%struct.DbFixer* nocapture readonly, %struct.Expr*) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3UniqueConstraint(%struct.Parse*, i32, %struct.Index* nocapture readonly) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local %struct.CollSeq* @sqlite3GetCollSeq(%struct.Parse* nocapture, i8 zeroext, %struct.CollSeq*, i8*) unnamed_addr #3

; Function Attrs: norecurse nounwind readnone ssp uwtable
declare dso_local i32 @sqlite3ExprWalkNoop(%struct.Walker* nocapture readnone, %struct.Expr* nocapture readnone) #11

; Function Attrs: nounwind readonly ssp uwtable
declare dso_local %struct.Expr* @sqlite3ExprSimplifiedAndOr(%struct.Expr* readonly) unnamed_addr #18

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3ExprIfTrue(%struct.Parse*, %struct.Expr*, i32, i32) #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3OpenTableAndIndices(%struct.Parse*, %struct.Table* nocapture readonly, i32, i8 zeroext, i32, i8* readonly, i32*, i32*) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3ComputeGeneratedColumns(%struct.Parse*, i32, %struct.Table*) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3TableAffinity(%struct.Vdbe* nocapture, %struct.Table* nocapture, i32) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3CodeRowTrigger(%struct.Parse*, %struct.Trigger*, i32, %struct.ExprList* readonly, i32, %struct.Table*, i32, i32, i32) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3GenerateConstraintChecks(%struct.Parse*, %struct.Table*, i32* nocapture readonly, i32, i32, i32, i32, i8 zeroext, i8 zeroext, i32, i32* nocapture, i32*, %struct.Upsert*) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3FkCheck(%struct.Parse*, %struct.Table*, i32, i32, i32* readonly, i32) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3CompleteInsertion(%struct.Parse*, %struct.Table*, i32, i32, i32, i32* nocapture readonly, i32, i32, i32) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3GenerateRowDelete(%struct.Parse*, %struct.Table*, %struct.Trigger*, i32, i32, i32, i16 signext, i8 zeroext, i8 zeroext, i8 zeroext, i32) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3GenerateRowIndexDelete(%struct.Parse*, %struct.Table* nocapture readonly, i32, i32, i32* readonly, i32) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3UpsertDoUpdate(%struct.Parse*, %struct.Upsert*, %struct.Table* nocapture readonly, %struct.Index* readonly, i32) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3FkOldmask(%struct.Parse* nocapture, %struct.Table* nocapture readonly) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3MaterializeView(%struct.Parse*, %struct.Table* nocapture readonly, %struct.Expr*, i32) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3SetHasNullFlag(%struct.Vdbe* nocapture, i32, i32) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3WhereExplainOneScan(%struct.Parse* nocapture readonly, %struct.SrcList* nocapture readonly, %struct.WhereLevel* nocapture readonly, i16 zeroext) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i64 @sqlite3WhereCodeOneLoopStart(%struct.Parse*, %struct.Vdbe*, %struct.WhereInfo*, i32, %struct.WhereLevel*, i64) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3CodeVerifyNamedSchema(%struct.Parse* nocapture, i8* readonly) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3CodeDropTable(%struct.Parse*, %struct.Table* nocapture readonly, i32, i32) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3DropTriggerPtr(%struct.Parse*, %struct.Trigger* nocapture readonly) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local %struct.Expr* @sqlite3WindowOffsetExpr(%struct.Parse*, %struct.Expr*) unnamed_addr #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i8* @sqlite3MemMalloc(i32) #3

; Function Attrs: nounwind ssp uwtable
declare dso_local void @sqlite3MemFree(i8*) #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i8* @sqlite3MemRealloc(i8*, i32) #3

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3MemSize(i8*) #3

; Function Attrs: norecurse nounwind readnone ssp uwtable
declare dso_local i32 @sqlite3MemRoundup(i32) #11

; Function Attrs: nounwind ssp uwtable
declare dso_local i32 @sqlite3MemInit(i8* nocapture readnone) #3

; Function Attrs: norecurse nounwind readnone ssp uwtable
declare dso_local void @sqlite3MemShutdown(i8* nocapture) #11

; Function Attrs: allocsize(1)
declare i8* @malloc_zone_malloc(%struct._malloc_zone_t*, i64) local_unnamed_addr #26

declare void @malloc_zone_free(%struct._malloc_zone_t*, i8*) local_unnamed_addr #12

; Function Attrs: allocsize(2)
declare i8* @malloc_zone_realloc(%struct._malloc_zone_t*, i8*, i64) local_unnamed_addr #27

declare i64 @malloc_size(i8*) local_unnamed_addr #12

declare i32 @sysctlbyname(i8*, i8*, i64*, i8*, i64) local_unnamed_addr #12

declare %struct._malloc_zone_t* @malloc_default_zone() local_unnamed_addr #12

declare %struct._malloc_zone_t* @malloc_create_zone(i64, i32) local_unnamed_addr #12

declare void @malloc_set_zone_name(%struct._malloc_zone_t*, i8*) local_unnamed_addr #12

; Function Attrs: nounwind readnone speculatable willreturn
declare i32 @llvm.ctpop.i32(i32) #28

; Function Attrs: nounwind readnone speculatable willreturn
declare i32 @llvm.bswap.i32(i32) #28

; Function Attrs: nofree nounwind
declare i64 @fwrite(i8* nocapture, i64, i64, %struct.__sFILE* nocapture) local_unnamed_addr #29

; Function Attrs: nounwind readnone speculatable willreturn
declare i64 @llvm.ctpop.i64(i64) #28

; Function Attrs: cold noreturn nounwind
declare void @llvm.trap() #30

; Function Attrs: nounwind readnone speculatable willreturn
declare i64 @llvm.ctlz.i64(i64, i1 immarg) #28

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memmove.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i1 immarg) #6

; Function Attrs: nofree
declare i64 @strlcat(i8*, i8*, i64) #31

; Function Attrs: nofree
declare i64 @strlcpy(i8*, i8*, i64) #31

attributes #0 = { norecurse nounwind nonlazybind uwtable willreturn "nonfree" }
attributes #1 = { noinline nounwind ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { alwaysinline nofree norecurse nounwind ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { alwaysinline nounwind ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind }
attributes #6 = { argmemonly nounwind willreturn }
attributes #7 = { norecurse nounwind readonly ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #8 = { nofree nounwind ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #9 = { nofree nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #10 = { nofree norecurse nounwind ssp uwtable writeonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #11 = { norecurse nounwind readnone ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #12 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #13 = { argmemonly nounwind willreturn writeonly }
attributes #14 = { nofree nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #15 = { nofree norecurse nounwind ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #16 = { argmemonly nofree nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #17 = { noinline nounwind ssp uwtable writeonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #18 = { nounwind readonly ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #19 = { nofree noinline nounwind ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #20 = { nounwind ssp uwtable writeonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #21 = { nofree noinline norecurse nounwind ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #22 = { alwaysinline norecurse nounwind readnone ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #23 = { nounwind readnone ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #24 = { noreturn "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #25 = { noinline nounwind readonly ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #26 = { allocsize(1) "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #27 = { allocsize(2) "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #28 = { nounwind readnone speculatable willreturn }
attributes #29 = { nofree nounwind }
attributes #30 = { cold noreturn nounwind }
attributes #31 = { nofree }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4}
!llvm.ident = !{!5}

!0 = distinct !DICompileUnit(language: DW_LANG_C, file: !1, producer: "mlir", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug)
!1 = !DIFile(filename: "LLVMDialectModule", directory: "/")
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = !{i32 1, !"wchar_size", i32 4}
!4 = !{i32 7, !"PIC Level", i32 2}
!5 = !{!"clang version 11.0.0 (https://github.com/KowalskiThomas/LLVM 63660cfe7d4c851881497a874a10f82c1b74cd5a)"}
!6 = !{!7, !7, i64 0}
!7 = !{!"double", !8, i64 0}
!8 = !{!"omnipotent char", !9, i64 0}
!9 = !{!"Simple C/C++ TBAA"}
!10 = !{!8, !8, i64 0}
!11 = !{!12, !13, i64 8}
!12 = !{!"UnpackedRecord", !13, i64 0, !13, i64 8, !14, i64 16, !8, i64 18, !8, i64 19, !8, i64 20, !8, i64 21, !8, i64 22}
!13 = !{!"any pointer", !8, i64 0}
!14 = !{!"short", !8, i64 0}
!15 = !{!12, !8, i64 18}
!16 = !{!17, !17, i64 0}
!17 = !{!"long long", !8, i64 0}
!18 = !{!19, !8, i64 4}
!19 = !{!"KeyInfo", !20, i64 0, !8, i64 4, !14, i64 6, !14, i64 8, !13, i64 16, !13, i64 24, !8, i64 32}
!20 = !{!"int", !8, i64 0}
!21 = !{!22, !8, i64 10}
!22 = !{!"sqlite3_value", !8, i64 0, !14, i64 8, !8, i64 10, !8, i64 11, !20, i64 12, !13, i64 16, !13, i64 24, !20, i64 32, !20, i64 36, !13, i64 40, !13, i64 48}
!23 = !{!19, !13, i64 16}
!24 = !{!22, !13, i64 40}
!25 = !{!22, !20, i64 32}
!26 = !{!22, !13, i64 16}
!27 = !{!12, !14, i64 16}
!28 = !{!22, !14, i64 8}
!29 = !{!22, !20, i64 12}
!30 = !{!22, !13, i64 24}
!31 = !{!32, !13, i64 8}
!32 = !{!"sqlite3_str", !13, i64 0, !13, i64 8, !20, i64 16, !20, i64 20, !20, i64 24, !8, i64 28, !8, i64 29}
!33 = !{!32, !13, i64 0}
!34 = !{!32, !20, i64 16}
!35 = !{!32, !20, i64 24}
!36 = !{!14, !14, i64 0}
!37 = distinct !DISubprogram(name: "jittedFunction", linkageName: "jittedFunction", scope: null, file: !38, line: 1623, type: !39, scopeLine: 1623, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !40)
!38 = !DIFile(filename: "../src/mlir/thomas/ModuleWriter.cpp", directory: "/Users/kowalski/dev/sqlite/release")
!39 = !DISubroutineType(types: !40)
!40 = !{}
!41 = !DILocation(line: 100, scope: !42)
!42 = !DILexicalBlockFile(scope: !37, file: !38, discriminator: 0)
!43 = !DILocation(line: 102, scope: !42)
!44 = !DILocation(line: 106, scope: !42)
!45 = !DILocation(line: 107, scope: !42)
!46 = !DILocation(line: 111, scope: !42)
!47 = !DILocation(line: 112, scope: !42)
!48 = !DILocation(line: 116, scope: !42)
!49 = !DILocation(line: 117, scope: !42)
!50 = !DILocation(line: 135, scope: !42)
!51 = !DILocation(line: 136, scope: !42)
!52 = !DILocation(line: 1581, scope: !42)
!53 = !DILocation(line: 24, scope: !54)
!54 = !DILexicalBlockFile(scope: !37, file: !55, discriminator: 0)
!55 = !DIFile(filename: "../src/mlir/lib/Standalone/Lowering/InitLowering.cpp", directory: "/Users/kowalski/dev/sqlite/release")
!56 = !DILocation(line: 28, scope: !54)
!57 = !DILocation(line: 34, scope: !54)
!58 = !DILocation(line: 38, scope: !54)
!59 = !DILocation(line: 39, scope: !54)
!60 = !DILocation(line: 40, scope: !54)
!61 = !DILocation(line: 25, scope: !62)
!62 = !DILexicalBlockFile(scope: !37, file: !63, discriminator: 0)
!63 = !DIFile(filename: "../src/mlir/lib/Standalone/Lowering/TransactionLowering.cpp", directory: "/Users/kowalski/dev/sqlite/release")
!64 = !DILocation(line: 48, scope: !62)
!65 = !DILocation(line: 52, scope: !62)
!66 = !DILocation(line: 53, scope: !62)
!67 = !DILocation(line: 54, scope: !62)
!68 = !DILocation(line: 55, scope: !62)
!69 = !DILocation(line: 57, scope: !62)
!70 = !DILocation(line: 58, scope: !62)
!71 = !DILocation(line: 60, scope: !62)
!72 = !DILocation(line: 65, scope: !62)
!73 = !DILocation(line: 43, scope: !74)
!74 = !DILexicalBlockFile(scope: !37, file: !75, discriminator: 0)
!75 = !DIFile(filename: "../src/mlir/lib/Standalone/Lowering/NullLowering.cpp", directory: "/Users/kowalski/dev/sqlite/release")
!76 = !DILocation(line: 52, scope: !74)
!77 = !DILocation(line: 55, scope: !74)
!78 = !DILocation(line: 58, scope: !74)
!79 = !DILocation(line: 59, scope: !74)
!80 = !DILocation(line: 63, scope: !74)
!81 = !DILocation(line: 66, scope: !74)
!82 = !DILocation(line: 71, scope: !74)
!83 = !DILocation(line: 74, scope: !74)
!84 = !DILocation(line: 75, scope: !74)
!85 = !DILocation(line: 37, scope: !86)
!86 = !DILexicalBlockFile(scope: !37, file: !87, discriminator: 0)
!87 = !DIFile(filename: "../src/mlir/lib/Standalone/Lowering/OpenReadLowering.cpp", directory: "/Users/kowalski/dev/sqlite/release")
!88 = !DILocation(line: 38, scope: !86)
!89 = !DILocation(line: 39, scope: !86)
!90 = !DILocation(line: 43, scope: !86)
!91 = !DILocation(line: 45, scope: !86)
!92 = !DILocation(line: 94, scope: !86)
!93 = !DILocation(line: 103, scope: !86)
!94 = !DILocation(line: 104, scope: !86)
!95 = !DILocation(line: 107, scope: !86)
!96 = !DILocation(line: 109, scope: !86)
!97 = !DILocation(line: 111, scope: !86)
!98 = !DILocation(line: 112, scope: !86)
!99 = !DILocation(line: 115, scope: !86)
!100 = !DILocation(line: 117, scope: !86)
!101 = !DILocation(line: 120, scope: !86)
!102 = !DILocation(line: 126, scope: !86)
!103 = !DILocation(line: 129, scope: !86)
!104 = !DILocation(line: 136, scope: !86)
!105 = !DILocation(line: 138, scope: !86)
!106 = !DILocation(line: 141, scope: !86)
!107 = !DILocation(line: 142, scope: !86)
!108 = !DILocation(line: 145, scope: !86)
!109 = !DILocation(line: 28, scope: !110)
!110 = !DILexicalBlockFile(scope: !37, file: !111, discriminator: 0)
!111 = !DIFile(filename: "../src/mlir/lib/Standalone/Lowering/RewindLowering.cpp", directory: "/Users/kowalski/dev/sqlite/release")
!112 = !DILocation(line: 39, scope: !110)
!113 = !DILocation(line: 43, scope: !110)
!114 = !DILocation(line: 45, scope: !110)
!115 = !DILocation(line: 46, scope: !110)
!116 = !DILocation(line: 49, scope: !110)
!117 = !DILocation(line: 56, scope: !110)
!118 = !DILocation(line: 58, scope: !110)
!119 = !DILocation(line: 73, scope: !110)
!120 = !DILocation(line: 74, scope: !110)
!121 = !DILocation(line: 77, scope: !110)
!122 = !DILocation(line: 85, scope: !110)
!123 = !DILocation(line: 87, scope: !110)
!124 = !DILocation(line: 89, scope: !110)
!125 = !DILocation(line: 100, scope: !110)
!126 = !DILocation(line: 107, scope: !110)
!127 = !DILocation(line: 111, scope: !110)
!128 = !DILocation(line: 115, scope: !110)
!129 = !DILocation(line: 121, scope: !110)
!130 = !DILocation(line: 125, scope: !110)
!131 = !DILocation(line: 129, scope: !110)
!132 = !DILocation(line: 133, scope: !110)
!133 = !DILocation(line: 136, scope: !110)
!134 = !DILocation(line: 142, scope: !110)
!135 = !DILocation(line: 148, scope: !110)
!136 = !DILocation(line: 149, scope: !110)
!137 = !DILocation(line: 151, scope: !110)
!138 = !DILocation(line: 155, scope: !110)
!139 = !DILocation(line: 157, scope: !110)
!140 = !DILocation(line: 159, scope: !110)
!141 = !DILocation(line: 162, scope: !110)
!142 = !DILocation(line: 30, scope: !143)
!143 = !DILexicalBlockFile(scope: !37, file: !144, discriminator: 0)
!144 = !DIFile(filename: "../src/mlir/lib/Standalone/Lowering/ColumnLowering.cpp", directory: "/Users/kowalski/dev/sqlite/release")
!145 = !DILocation(line: 42, scope: !143)
!146 = !DILocation(line: 43, scope: !143)
!147 = !DILocation(line: 60, scope: !143)
!148 = !DILocation(line: 61, scope: !143)
!149 = !DILocation(line: 72, scope: !143)
!150 = !DILocation(line: 73, scope: !143)
!151 = !DILocation(line: 74, scope: !143)
!152 = !DILocation(line: 85, scope: !143)
!153 = !DILocation(line: 88, scope: !143)
!154 = !DILocation(line: 93, scope: !143)
!155 = !DILocation(line: 103, scope: !143)
!156 = !DILocation(line: 120, scope: !143)
!157 = !DILocation(line: 126, scope: !143)
!158 = !DILocation(line: 130, scope: !143)
!159 = !DILocation(line: 142, scope: !143)
!160 = !DILocation(line: 147, scope: !143)
!161 = !DILocation(line: 153, scope: !143)
!162 = !DILocation(line: 159, scope: !143)
!163 = !DILocation(line: 168, scope: !143)
!164 = !DILocation(line: 174, scope: !143)
!165 = !DILocation(line: 179, scope: !143)
!166 = !DILocation(line: 181, scope: !143)
!167 = !DILocation(line: 199, scope: !143)
!168 = !DILocation(line: 206, scope: !143)
!169 = !DILocation(line: 214, scope: !143)
!170 = !DILocation(line: 222, scope: !143)
!171 = !DILocation(line: 230, scope: !143)
!172 = !DILocation(line: 248, scope: !143)
!173 = !DILocation(line: 253, scope: !143)
!174 = !DILocation(line: 257, scope: !143)
!175 = !DILocation(line: 261, scope: !143)
!176 = !DILocation(line: 264, scope: !143)
!177 = !DILocation(line: 268, scope: !143)
!178 = !DILocation(line: 303, scope: !143)
!179 = !DILocation(line: 498, scope: !143)
!180 = !DILocation(line: 499, scope: !143)
!181 = !DILocation(line: 504, scope: !143)
!182 = !DILocation(line: 23, scope: !183)
!183 = !DILexicalBlockFile(scope: !37, file: !184, discriminator: 0)
!184 = !DIFile(filename: "../src/mlir/lib/Standalone/Lowering/Operators/GetVarint32.cpp", directory: "/Users/kowalski/dev/sqlite/release")
!185 = !DILocation(line: 36, scope: !183)
!186 = !DILocation(line: 39, scope: !183)
!187 = !DILocation(line: 47, scope: !183)
!188 = !DILocation(line: 50, scope: !183)
!189 = !DILocation(line: 53, scope: !183)
!190 = !DILocation(line: 55, scope: !183)
!191 = !DILocation(line: 64, scope: !183)
!192 = !DILocation(line: 71, scope: !183)
!193 = !DILocation(line: 72, scope: !183)
!194 = !DILocation(line: 73, scope: !183)
!195 = !DILocation(line: 509, scope: !143)
!196 = !DILocation(line: 517, scope: !143)
!197 = !DILocation(line: 518, scope: !143)
!198 = !DILocation(line: 521, scope: !143)
!199 = !DILocation(line: 524, scope: !143)
!200 = !DILocation(line: 547, scope: !143)
!201 = !DILocation(line: 550, scope: !143)
!202 = !DILocation(line: 533, scope: !143)
!203 = !DILocation(line: 535, scope: !143)
!204 = !DILocation(line: 556, scope: !143)
!205 = !DILocation(line: 425, scope: !143)
!206 = !DILocation(line: 433, scope: !143)
!207 = !DILocation(line: 469, scope: !143)
!208 = !DILocation(line: 474, scope: !143)
!209 = !DILocation(line: 478, scope: !143)
!210 = !DILocation(line: 484, scope: !143)
!211 = !DILocation(line: 491, scope: !143)
!212 = !DILocation(line: 327, scope: !143)
!213 = !DILocation(line: 332, scope: !143)
!214 = !DILocation(line: 343, scope: !143)
!215 = !DILocation(line: 349, scope: !143)
!216 = !DILocation(line: 352, scope: !143)
!217 = !DILocation(line: 358, scope: !143)
!218 = !DILocation(line: 362, scope: !143)
!219 = !DILocation(line: 364, scope: !143)
!220 = !DILocation(line: 372, scope: !143)
!221 = !DILocation(line: 377, scope: !143)
!222 = !DILocation(line: 378, scope: !143)
!223 = !DILocation(line: 379, scope: !143)
!224 = !DILocation(line: 384, scope: !143)
!225 = !DILocation(line: 389, scope: !143)
!226 = !DILocation(line: 390, scope: !143)
!227 = !DILocation(line: 405, scope: !143)
!228 = !DILocation(line: 411, scope: !143)
!229 = !DILocation(line: 563, scope: !143)
!230 = !DILocation(line: 565, scope: !143)
!231 = !DILocation(line: 575, scope: !143)
!232 = !DILocation(line: 1037, scope: !143)
!233 = !DILocation(line: 1041, scope: !143)
!234 = !DILocation(line: 1042, scope: !143)
!235 = !DILocation(line: 1044, scope: !143)
!236 = !DILocation(line: 1057, scope: !143)
!237 = !DILocation(line: 1063, scope: !143)
!238 = !DILocation(line: 1072, scope: !143)
!239 = !DILocation(line: 1077, scope: !143)
!240 = !DILocation(line: 1083, scope: !143)
!241 = !DILocation(line: 1095, scope: !143)
!242 = !DILocation(line: 1097, scope: !143)
!243 = !DILocation(line: 1099, scope: !143)
!244 = !DILocation(line: 1101, scope: !143)
!245 = !DILocation(line: 1103, scope: !143)
!246 = !DILocation(line: 1109, scope: !143)
!247 = !DILocation(line: 1110, scope: !143)
!248 = !DILocation(line: 1111, scope: !143)
!249 = !DILocation(line: 1112, scope: !143)
!250 = !DILocation(line: 1113, scope: !143)
!251 = !DILocation(line: 1114, scope: !143)
!252 = !DILocation(line: 1115, scope: !143)
!253 = !DILocation(line: 1116, scope: !143)
!254 = !DILocation(line: 1123, scope: !143)
!255 = !DILocation(line: 1124, scope: !143)
!256 = !DILocation(line: 1125, scope: !143)
!257 = !DILocation(line: 1130, scope: !143)
!258 = !DILocation(line: 1134, scope: !143)
!259 = !DILocation(line: 1140, scope: !143)
!260 = !DILocation(line: 1141, scope: !143)
!261 = !DILocation(line: 1142, scope: !143)
!262 = !DILocation(line: 1143, scope: !143)
!263 = !DILocation(line: 1145, scope: !143)
!264 = !DILocation(line: 1148, scope: !143)
!265 = !DILocation(line: 1149, scope: !143)
!266 = !DILocation(line: 1152, scope: !143)
!267 = !DILocation(line: 1157, scope: !143)
!268 = !DILocation(line: 1159, scope: !143)
!269 = !DILocation(line: 1163, scope: !143)
!270 = !DILocation(line: 1172, scope: !143)
!271 = !DILocation(line: 1182, scope: !143)
!272 = !DILocation(line: 1188, scope: !143)
!273 = !DILocation(line: 1190, scope: !143)
!274 = !DILocation(line: 1192, scope: !143)
!275 = !DILocation(line: 1194, scope: !143)
!276 = !DILocation(line: 1199, scope: !143)
!277 = !DILocation(line: 1201, scope: !143)
!278 = !DILocation(line: 1210, scope: !143)
!279 = !DILocation(line: 1217, scope: !143)
!280 = !DILocation(line: 1222, scope: !143)
!281 = !DILocation(line: 1225, scope: !143)
!282 = !DILocation(line: 1227, scope: !143)
!283 = !DILocation(line: 1234, scope: !143)
!284 = !DILocation(line: 1235, scope: !143)
!285 = !DILocation(line: 1236, scope: !143)
!286 = !DILocation(line: 1237, scope: !143)
!287 = !DILocation(line: 1242, scope: !143)
!288 = !DILocation(line: 1243, scope: !143)
!289 = !DILocation(line: 1245, scope: !143)
!290 = !DILocation(line: 1246, scope: !143)
!291 = !DILocation(line: 1247, scope: !143)
!292 = !DILocation(line: 1250, scope: !143)
!293 = !DILocation(line: 1252, scope: !143)
!294 = !DILocation(line: 1254, scope: !143)
!295 = !DILocation(line: 1256, scope: !143)
!296 = !DILocation(line: 1258, scope: !143)
!297 = !DILocation(line: 1268, scope: !143)
!298 = !DILocation(line: 1272, scope: !143)
!299 = !DILocation(line: 1281, scope: !143)
!300 = !DILocation(line: 1282, scope: !143)
!301 = !DILocation(line: 1283, scope: !143)
!302 = !DILocation(line: 1285, scope: !143)
!303 = !DILocation(line: 1287, scope: !143)
!304 = !DILocation(line: 1297, scope: !143)
!305 = !DILocation(line: 1300, scope: !143)
!306 = !DILocation(line: 1309, scope: !143)
!307 = !DILocation(line: 1326, scope: !143)
!308 = !DILocation(line: 1334, scope: !143)
!309 = !DILocation(line: 1339, scope: !143)
!310 = !DILocation(line: 1340, scope: !143)
!311 = !DILocation(line: 1343, scope: !143)
!312 = !DILocation(line: 1354, scope: !143)
!313 = !DILocation(line: 1359, scope: !143)
!314 = !DILocation(line: 1363, scope: !143)
!315 = !DILocation(line: 1373, scope: !143)
!316 = !DILocation(line: 1375, scope: !143)
!317 = !DILocation(line: 1376, scope: !143)
!318 = !DILocation(line: 1378, scope: !143)
!319 = !DILocation(line: 1314, scope: !143)
!320 = !DILocation(line: 1318, scope: !143)
!321 = !DILocation(line: 1017, scope: !143)
!322 = !DILocation(line: 1023, scope: !143)
!323 = !DILocation(line: 1025, scope: !143)
!324 = !DILocation(line: 1027, scope: !143)
!325 = !DILocation(line: 584, scope: !143)
!326 = !DILocation(line: 585, scope: !143)
!327 = !DILocation(line: 586, scope: !143)
!328 = !DILocation(line: 595, scope: !143)
!329 = !DILocation(line: 605, scope: !143)
!330 = !DILocation(line: 607, scope: !143)
!331 = !DILocation(line: 614, scope: !143)
!332 = !DILocation(line: 628, scope: !143)
!333 = !DILocation(line: 629, scope: !143)
!334 = !DILocation(line: 644, scope: !143)
!335 = !DILocation(line: 645, scope: !143)
!336 = !DILocation(line: 646, scope: !143)
!337 = !DILocation(line: 647, scope: !143)
!338 = !DILocation(line: 649, scope: !143)
!339 = !DILocation(line: 651, scope: !143)
!340 = !DILocation(line: 654, scope: !143)
!341 = !DILocation(line: 655, scope: !143)
!342 = !DILocation(line: 656, scope: !143)
!343 = !DILocation(line: 658, scope: !143)
!344 = !DILocation(line: 659, scope: !143)
!345 = !DILocation(line: 662, scope: !143)
!346 = !DILocation(line: 664, scope: !143)
!347 = !DILocation(line: 666, scope: !143)
!348 = !DILocation(line: 668, scope: !143)
!349 = !DILocation(line: 670, scope: !143)
!350 = !DILocation(line: 684, scope: !143)
!351 = !DILocation(line: 695, scope: !143)
!352 = !DILocation(line: 697, scope: !143)
!353 = !DILocation(line: 703, scope: !143)
!354 = !DILocation(line: 704, scope: !143)
!355 = !DILocation(line: 705, scope: !143)
!356 = !DILocation(line: 708, scope: !143)
!357 = !DILocation(line: 710, scope: !143)
!358 = !DILocation(line: 713, scope: !143)
!359 = !DILocation(line: 717, scope: !143)
!360 = !DILocation(line: 786, scope: !143)
!361 = !DILocation(line: 788, scope: !143)
!362 = !DILocation(line: 790, scope: !143)
!363 = !DILocation(line: 794, scope: !143)
!364 = !DILocation(line: 795, scope: !143)
!365 = !DILocation(line: 796, scope: !143)
!366 = !DILocation(line: 799, scope: !143)
!367 = !DILocation(line: 804, scope: !143)
!368 = !DILocation(line: 814, scope: !143)
!369 = !DILocation(line: 817, scope: !143)
!370 = !DILocation(line: 821, scope: !143)
!371 = !DILocation(line: 822, scope: !143)
!372 = !DILocation(line: 823, scope: !143)
!373 = !DILocation(line: 825, scope: !143)
!374 = !DILocation(line: 830, scope: !143)
!375 = !DILocation(line: 833, scope: !143)
!376 = !DILocation(line: 750, scope: !143)
!377 = !DILocation(line: 753, scope: !143)
!378 = !DILocation(line: 760, scope: !143)
!379 = !DILocation(line: 766, scope: !143)
!380 = !DILocation(line: 769, scope: !143)
!381 = !DILocation(line: 770, scope: !143)
!382 = !DILocation(line: 773, scope: !143)
!383 = !DILocation(line: 775, scope: !143)
!384 = !DILocation(line: 778, scope: !143)
!385 = !DILocation(line: 779, scope: !143)
!386 = !DILocation(line: 780, scope: !143)
!387 = !DILocation(line: 782, scope: !143)
!388 = !DILocation(line: 723, scope: !143)
!389 = !DILocation(line: 726, scope: !143)
!390 = !DILocation(line: 730, scope: !143)
!391 = !DILocation(line: 731, scope: !143)
!392 = !DILocation(line: 732, scope: !143)
!393 = !DILocation(line: 733, scope: !143)
!394 = !DILocation(line: 734, scope: !143)
!395 = !DILocation(line: 737, scope: !143)
!396 = !DILocation(line: 739, scope: !143)
!397 = !DILocation(line: 741, scope: !143)
!398 = !DILocation(line: 743, scope: !143)
!399 = !DILocation(line: 843, scope: !143)
!400 = !DILocation(line: 844, scope: !143)
!401 = !DILocation(line: 845, scope: !143)
!402 = !DILocation(line: 853, scope: !143)
!403 = !DILocation(line: 857, scope: !143)
!404 = !DILocation(line: 861, scope: !143)
!405 = !DILocation(line: 865, scope: !143)
!406 = !DILocation(line: 869, scope: !143)
!407 = !DILocation(line: 870, scope: !143)
!408 = !DILocation(line: 871, scope: !143)
!409 = !DILocation(line: 877, scope: !143)
!410 = !DILocation(line: 887, scope: !143)
!411 = !DILocation(line: 889, scope: !143)
!412 = !DILocation(line: 892, scope: !143)
!413 = !DILocation(line: 897, scope: !143)
!414 = !DILocation(line: 898, scope: !143)
!415 = !DILocation(line: 900, scope: !143)
!416 = !DILocation(line: 922, scope: !143)
!417 = !DILocation(line: 923, scope: !143)
!418 = !DILocation(line: 924, scope: !143)
!419 = !DILocation(line: 927, scope: !143)
!420 = !DILocation(line: 928, scope: !143)
!421 = !DILocation(line: 929, scope: !143)
!422 = !DILocation(line: 930, scope: !143)
!423 = !DILocation(line: 931, scope: !143)
!424 = !DILocation(line: 932, scope: !143)
!425 = !DILocation(line: 933, scope: !143)
!426 = !DILocation(line: 946, scope: !143)
!427 = !DILocation(line: 961, scope: !143)
!428 = !DILocation(line: 963, scope: !143)
!429 = !DILocation(line: 972, scope: !143)
!430 = !DILocation(line: 974, scope: !143)
!431 = !DILocation(line: 975, scope: !143)
!432 = !DILocation(line: 1001, scope: !143)
!433 = !DILocation(line: 1391, scope: !143)
!434 = !DILocation(line: 36, scope: !435)
!435 = !DILexicalBlockFile(scope: !37, file: !436, discriminator: 0)
!436 = !DIFile(filename: "../src/mlir/lib/Standalone/Lowering/OnceLowering.cpp", directory: "/Users/kowalski/dev/sqlite/release")
!437 = !DILocation(line: 37, scope: !435)
!438 = !DILocation(line: 38, scope: !435)
!439 = !DILocation(line: 41, scope: !435)
!440 = !DILocation(line: 42, scope: !435)
!441 = !DILocation(line: 45, scope: !435)
!442 = !DILocation(line: 52, scope: !435)
!443 = !DILocation(line: 53, scope: !435)
!444 = !DILocation(line: 59, scope: !435)
!445 = !DILocation(line: 60, scope: !435)
!446 = !DILocation(line: 63, scope: !435)
!447 = !DILocation(line: 79, scope: !435)
!448 = !DILocation(line: 85, scope: !435)
!449 = !DILocation(line: 88, scope: !435)
!450 = !DILocation(line: 91, scope: !435)
!451 = !DILocation(line: 97, scope: !435)
!452 = !DILocation(line: 42, scope: !453)
!453 = !DILexicalBlockFile(scope: !37, file: !454, discriminator: 0)
!454 = !DIFile(filename: "../src/mlir/lib/Standalone/Lowering/StringLowering.cpp", directory: "/Users/kowalski/dev/sqlite/release")
!455 = !DILocation(line: 43, scope: !453)
!456 = !DILocation(line: 34, scope: !457)
!457 = !DILexicalBlockFile(scope: !37, file: !458, discriminator: 0)
!458 = !DIFile(filename: "../src/mlir/lib/Standalone/Lowering/Operators/OutToPrerelease.cpp", directory: "/Users/kowalski/dev/sqlite/release")
!459 = !DILocation(line: 38, scope: !457)
!460 = !DILocation(line: 41, scope: !457)
!461 = !DILocation(line: 48, scope: !453)
!462 = !DILocation(line: 49, scope: !453)
!463 = !DILocation(line: 50, scope: !453)
!464 = !DILocation(line: 51, scope: !453)
!465 = !DILocation(line: 52, scope: !453)
!466 = !DILocation(line: 55, scope: !453)
!467 = !DILocation(line: 56, scope: !453)
!468 = !DILocation(line: 57, scope: !453)
!469 = !DILocation(line: 58, scope: !453)
!470 = !DILocation(line: 59, scope: !453)
!471 = !DILocation(line: 60, scope: !453)
!472 = !DILocation(line: 40, scope: !473)
!473 = !DILexicalBlockFile(scope: !37, file: !474, discriminator: 0)
!474 = !DIFile(filename: "../src/mlir/lib/Standalone/Lowering/FunctionLowering.cpp", directory: "/Users/kowalski/dev/sqlite/release")
!475 = !DILocation(line: 42, scope: !473)
!476 = !DILocation(line: 44, scope: !473)
!477 = !DILocation(line: 45, scope: !473)
!478 = !DILocation(line: 46, scope: !473)
!479 = !DILocation(line: 47, scope: !473)
!480 = !DILocation(line: 48, scope: !473)
!481 = !DILocation(line: 49, scope: !473)
!482 = !DILocation(line: 50, scope: !473)
!483 = !DILocation(line: 51, scope: !473)
!484 = !DILocation(line: 52, scope: !473)
!485 = !DILocation(line: 53, scope: !473)
!486 = !DILocation(line: 55, scope: !473)
!487 = !DILocation(line: 56, scope: !473)
!488 = !DILocation(line: 66, scope: !473)
!489 = !DILocation(line: 67, scope: !473)
!490 = !DILocation(line: 65, scope: !473)
!491 = !DILocation(line: 70, scope: !473)
!492 = !DILocation(line: 75, scope: !473)
!493 = !DILocation(line: 76, scope: !473)
!494 = !DILocation(line: 79, scope: !473)
!495 = !DILocation(line: 83, scope: !473)
!496 = !DILocation(line: 85, scope: !473)
!497 = !DILocation(line: 88, scope: !473)
!498 = !DILocation(line: 98, scope: !473)
!499 = !DILocation(line: 25, scope: !473)
!500 = !DILocation(line: 102, scope: !473)
!501 = !DILocation(line: 109, scope: !473)
!502 = !DILocation(line: 110, scope: !473)
!503 = !DILocation(line: 111, scope: !473)
!504 = !DILocation(line: 114, scope: !473)
!505 = !DILocation(line: 115, scope: !473)
!506 = !DILocation(line: 121, scope: !473)
!507 = !DILocation(line: 127, scope: !473)
!508 = !DILocation(line: 123, scope: !473)
!509 = !DILocation(line: 136, scope: !473)
!510 = !DILocation(line: 138, scope: !473)
!511 = !DILocation(line: 144, scope: !473)
!512 = !DILocation(line: 163, scope: !473)
!513 = !DILocation(line: 164, scope: !473)
!514 = !DILocation(line: 165, scope: !473)
!515 = !DILocation(line: 167, scope: !473)
!516 = !DILocation(line: 171, scope: !473)
!517 = !DILocation(line: 174, scope: !473)
!518 = !DILocation(line: 179, scope: !473)
!519 = !DILocation(line: 58, scope: !520)
!520 = !DILexicalBlockFile(scope: !37, file: !521, discriminator: 0)
!521 = !DIFile(filename: "../src/mlir/lib/Standalone/Lowering/CompareJumpLowering.cpp", directory: "/Users/kowalski/dev/sqlite/release")
!522 = !DILocation(line: 61, scope: !520)
!523 = !DILocation(line: 63, scope: !520)
!524 = !DILocation(line: 66, scope: !520)
!525 = !DILocation(line: 72, scope: !520)
!526 = !DILocation(line: 73, scope: !520)
!527 = !DILocation(line: 74, scope: !520)
!528 = !DILocation(line: 75, scope: !520)
!529 = !DILocation(line: 78, scope: !520)
!530 = !DILocation(line: 79, scope: !520)
!531 = !DILocation(line: 80, scope: !520)
!532 = !DILocation(line: 81, scope: !520)
!533 = !DILocation(line: 236, scope: !520)
!534 = !DILocation(line: 238, scope: !520)
!535 = !DILocation(line: 244, scope: !520)
!536 = !DILocation(line: 246, scope: !520)
!537 = !DILocation(line: 332, scope: !520)
!538 = !DILocation(line: 334, scope: !520)
!539 = !DILocation(line: 503, scope: !520)
!540 = !DILocation(line: 505, scope: !520)
!541 = !DILocation(line: 508, scope: !520)
!542 = !DILocation(line: 510, scope: !520)
!543 = !DILocation(line: 513, scope: !520)
!544 = !DILocation(line: 515, scope: !520)
!545 = !DILocation(line: 518, scope: !520)
!546 = !DILocation(line: 520, scope: !520)
!547 = !DILocation(line: 526, scope: !520)
!548 = !DILocation(line: 528, scope: !520)
!549 = !DILocation(line: 532, scope: !520)
!550 = !DILocation(line: 539, scope: !520)
!551 = !DILocation(line: 540, scope: !520)
!552 = !DILocation(line: 541, scope: !520)
!553 = !DILocation(line: 542, scope: !520)
!554 = !DILocation(line: 544, scope: !520)
!555 = !DILocation(line: 553, scope: !520)
!556 = !DILocation(line: 555, scope: !520)
!557 = !DILocation(line: 559, scope: !520)
!558 = !DILocation(line: 566, scope: !520)
!559 = !DILocation(line: 567, scope: !520)
!560 = !DILocation(line: 568, scope: !520)
!561 = !DILocation(line: 569, scope: !520)
!562 = !DILocation(line: 571, scope: !520)
!563 = !DILocation(line: 579, scope: !520)
!564 = !DILocation(line: 580, scope: !520)
!565 = !DILocation(line: 581, scope: !520)
!566 = !DILocation(line: 582, scope: !520)
!567 = !DILocation(line: 583, scope: !520)
!568 = !DILocation(line: 588, scope: !520)
!569 = !DILocation(line: 612, scope: !520)
!570 = !DILocation(line: 614, scope: !520)
!571 = !DILocation(line: 619, scope: !520)
!572 = !DILocation(line: 621, scope: !520)
!573 = !DILocation(line: 0, scope: !520)
!574 = !DILocation(line: 650, scope: !520)
!575 = !DILocation(line: 652, scope: !520)
!576 = !DILocation(line: 688, scope: !520)
!577 = !DILocation(line: 689, scope: !520)
!578 = !DILocation(line: 690, scope: !520)
!579 = !DILocation(line: 691, scope: !520)
!580 = !DILocation(line: 62, scope: !435)
!581 = !DILocation(line: 84, scope: !473)
!582 = !DILocation(line: 39, scope: !583)
!583 = !DILexicalBlockFile(scope: !37, file: !584, discriminator: 0)
!584 = !DIFile(filename: "../src/mlir/lib/Standalone/Lowering/RealAffinityLowering.cpp", directory: "/Users/kowalski/dev/sqlite/release")
!585 = !DILocation(line: 41, scope: !583)
!586 = !DILocation(line: 47, scope: !583)
!587 = !DILocation(line: 49, scope: !583)
!588 = !DILocation(line: 53, scope: !583)
!589 = !DILocation(line: 55, scope: !583)
!590 = !DILocation(line: 356, scope: !520)
!591 = !DILocation(line: 358, scope: !520)
!592 = !DILocation(line: 360, scope: !520)
!593 = !DILocation(line: 369, scope: !520)
!594 = !DILocation(line: 370, scope: !520)
!595 = !DILocation(line: 372, scope: !520)
!596 = !DILocation(line: 377, scope: !520)
!597 = !DILocation(line: 42, scope: !598)
!598 = !DILexicalBlockFile(scope: !37, file: !599, discriminator: 0)
!599 = !DIFile(filename: "../src/mlir/lib/Standalone/Lowering/Operators/ApplyNumericAffinity.cpp", directory: "/Users/kowalski/dev/sqlite/release")
!600 = !DILocation(line: 384, scope: !520)
!601 = !DILocation(line: 385, scope: !520)
!602 = !DILocation(line: 387, scope: !520)
!603 = !DILocation(line: 398, scope: !520)
!604 = !DILocation(line: 400, scope: !520)
!605 = !DILocation(line: 402, scope: !520)
!606 = !DILocation(line: 407, scope: !520)
!607 = !DILocation(line: 413, scope: !520)
!608 = !DILocation(line: 425, scope: !520)
!609 = !DILocation(line: 427, scope: !520)
!610 = !DILocation(line: 430, scope: !520)
!611 = !DILocation(line: 432, scope: !520)
!612 = !DILocation(line: 439, scope: !520)
!613 = !DILocation(line: 441, scope: !520)
!614 = !DILocation(line: 444, scope: !520)
!615 = !DILocation(line: 445, scope: !520)
!616 = !DILocation(line: 446, scope: !520)
!617 = !DILocation(line: 447, scope: !520)
!618 = !DILocation(line: 449, scope: !520)
!619 = !DILocation(line: 450, scope: !520)
!620 = !DILocation(line: 456, scope: !520)
!621 = !DILocation(line: 458, scope: !520)
!622 = !DILocation(line: 462, scope: !520)
!623 = !DILocation(line: 464, scope: !520)
!624 = !DILocation(line: 474, scope: !520)
!625 = !DILocation(line: 476, scope: !520)
!626 = !DILocation(line: 480, scope: !520)
!627 = !DILocation(line: 482, scope: !520)
!628 = !DILocation(line: 487, scope: !520)
!629 = !DILocation(line: 489, scope: !520)
!630 = !DILocation(line: 595, scope: !520)
!631 = !DILocation(line: 611, scope: !520)
!632 = !DILocation(line: 626, scope: !520)
!633 = !DILocation(line: 628, scope: !520)
!634 = !DILocation(line: 634, scope: !520)
!635 = !DILocation(line: 636, scope: !520)
!636 = !DILocation(line: 642, scope: !520)
!637 = !DILocation(line: 644, scope: !520)
!638 = !DILocation(line: 38, scope: !583)
!639 = !DILocation(line: 66, scope: !640)
!640 = !DILexicalBlockFile(scope: !37, file: !641, discriminator: 0)
!641 = !DIFile(filename: "../src/mlir/lib/Standalone/Lowering/ArithmeticLowering.cpp", directory: "/Users/kowalski/dev/sqlite/release")
!642 = !DILocation(line: 185, scope: !640)
!643 = !DILocation(line: 43, scope: !644)
!644 = !DILexicalBlockFile(scope: !37, file: !645, discriminator: 0)
!645 = !DIFile(filename: "../src/mlir/lib/Standalone/Lowering/Operators/NumericType.cpp", directory: "/Users/kowalski/dev/sqlite/release")
!646 = !DILocation(line: 45, scope: !644)
!647 = !DILocation(line: 56, scope: !644)
!648 = !DILocation(line: 61, scope: !644)
!649 = !DILocation(line: 67, scope: !644)
!650 = !DILocation(line: 83, scope: !644)
!651 = !DILocation(line: 88, scope: !644)
!652 = !DILocation(line: 94, scope: !644)
!653 = !DILocation(line: 98, scope: !644)
!654 = !DILocation(line: 106, scope: !644)
!655 = !DILocation(line: 188, scope: !640)
!656 = !DILocation(line: 193, scope: !640)
!657 = !DILocation(line: 197, scope: !640)
!658 = !DILocation(line: 200, scope: !640)
!659 = !DILocation(line: 203, scope: !640)
!660 = !DILocation(line: 204, scope: !640)
!661 = !DILocation(line: 205, scope: !640)
!662 = !DILocation(line: 214, scope: !640)
!663 = !DILocation(line: 222, scope: !640)
!664 = !DILocation(line: 223, scope: !640)
!665 = !DILocation(line: 224, scope: !640)
!666 = !DILocation(line: 227, scope: !640)
!667 = !DILocation(line: 228, scope: !640)
!668 = !DILocation(line: 229, scope: !640)
!669 = !DILocation(line: 230, scope: !640)
!670 = !DILocation(line: 231, scope: !640)
!671 = !DILocation(line: 257, scope: !640)
!672 = !DILocation(line: 260, scope: !640)
!673 = !DILocation(line: 261, scope: !640)
!674 = !DILocation(line: 346, scope: !640)
!675 = !DILocation(line: 347, scope: !640)
!676 = !DILocation(line: 348, scope: !640)
!677 = !DILocation(line: 349, scope: !640)
!678 = !DILocation(line: 39, scope: !640)
!679 = !DILocation(line: 354, scope: !640)
!680 = !DILocation(line: 358, scope: !640)
!681 = !DILocation(line: 359, scope: !640)
!682 = !DILocation(line: 360, scope: !640)
!683 = !DILocation(line: 370, scope: !640)
!684 = !DILocation(line: 373, scope: !640)
!685 = !DILocation(line: 390, scope: !640)
!686 = !DILocation(line: 445, scope: !640)
!687 = !DILocation(line: 446, scope: !640)
!688 = !DILocation(line: 448, scope: !640)
!689 = !DILocation(line: 453, scope: !640)
!690 = !DILocation(line: 454, scope: !640)
!691 = !DILocation(line: 455, scope: !640)
!692 = !DILocation(line: 460, scope: !640)
!693 = !DILocation(line: 476, scope: !640)
!694 = !DILocation(line: 469, scope: !640)
!695 = !DILocation(line: 25, scope: !696)
!696 = !DILexicalBlockFile(scope: !37, file: !697, discriminator: 0)
!697 = !DIFile(filename: "../src/mlir/lib/Standalone/Lowering/AggStepLowering.cpp", directory: "/Users/kowalski/dev/sqlite/release")
!698 = !DILocation(line: 47, scope: !696)
!699 = !DILocation(line: 48, scope: !696)
!700 = !DILocation(line: 58, scope: !696)
!701 = !DILocation(line: 63, scope: !696)
!702 = !DILocation(line: 64, scope: !696)
!703 = !DILocation(line: 66, scope: !696)
!704 = !DILocation(line: 73, scope: !696)
!705 = !DILocation(line: 75, scope: !696)
!706 = !DILocation(line: 79, scope: !696)
!707 = !DILocation(line: 80, scope: !696)
!708 = !DILocation(line: 83, scope: !696)
!709 = !DILocation(line: 88, scope: !696)
!710 = !DILocation(line: 89, scope: !696)
!711 = !DILocation(line: 90, scope: !696)
!712 = !DILocation(line: 91, scope: !696)
!713 = !DILocation(line: 92, scope: !696)
!714 = !DILocation(line: 93, scope: !696)
!715 = !DILocation(line: 94, scope: !696)
!716 = !DILocation(line: 95, scope: !696)
!717 = !DILocation(line: 96, scope: !696)
!718 = !DILocation(line: 97, scope: !696)
!719 = !DILocation(line: 108, scope: !696)
!720 = !DILocation(line: 116, scope: !696)
!721 = !DILocation(line: 117, scope: !696)
!722 = !DILocation(line: 119, scope: !696)
!723 = !DILocation(line: 125, scope: !696)
!724 = !DILocation(line: 126, scope: !696)
!725 = !DILocation(line: 128, scope: !696)
!726 = !DILocation(line: 129, scope: !696)
!727 = !DILocation(line: 130, scope: !696)
!728 = !DILocation(line: 131, scope: !696)
!729 = !DILocation(line: 133, scope: !696)
!730 = !DILocation(line: 136, scope: !696)
!731 = !DILocation(line: 137, scope: !696)
!732 = !DILocation(line: 138, scope: !696)
!733 = !DILocation(line: 139, scope: !696)
!734 = !DILocation(line: 140, scope: !696)
!735 = !DILocation(line: 143, scope: !696)
!736 = !DILocation(line: 146, scope: !696)
!737 = !DILocation(line: 150, scope: !696)
!738 = !DILocation(line: 158, scope: !696)
!739 = !DILocation(line: 164, scope: !696)
!740 = !DILocation(line: 165, scope: !696)
!741 = !DILocation(line: 166, scope: !696)
!742 = !DILocation(line: 167, scope: !696)
!743 = !DILocation(line: 171, scope: !696)
!744 = !DILocation(line: 172, scope: !696)
!745 = !DILocation(line: 173, scope: !696)
!746 = !DILocation(line: 174, scope: !696)
!747 = !DILocation(line: 175, scope: !696)
!748 = !DILocation(line: 178, scope: !696)
!749 = !DILocation(line: 182, scope: !696)
!750 = !DILocation(line: 187, scope: !696)
!751 = !DILocation(line: 188, scope: !696)
!752 = !DILocation(line: 189, scope: !696)
!753 = !DILocation(line: 194, scope: !696)
!754 = !DILocation(line: 198, scope: !696)
!755 = !DILocation(line: 199, scope: !696)
!756 = !DILocation(line: 200, scope: !696)
!757 = !DILocation(line: 201, scope: !696)
!758 = !DILocation(line: 202, scope: !696)
!759 = !DILocation(line: 203, scope: !696)
!760 = !DILocation(line: 210, scope: !696)
!761 = !DILocation(line: 231, scope: !696)
!762 = !DILocation(line: 233, scope: !696)
!763 = !DILocation(line: 234, scope: !696)
!764 = !DILocation(line: 239, scope: !696)
!765 = !DILocation(line: 242, scope: !696)
!766 = !DILocation(line: 243, scope: !696)
!767 = !DILocation(line: 246, scope: !696)
!768 = !DILocation(line: 216, scope: !696)
!769 = !DILocation(line: 219, scope: !696)
!770 = !DILocation(line: 221, scope: !696)
!771 = !DILocation(line: 256, scope: !696)
!772 = !DILocation(line: 258, scope: !696)
!773 = !DILocation(line: 259, scope: !696)
!774 = !DILocation(line: 260, scope: !696)
!775 = !DILocation(line: 263, scope: !696)
!776 = !DILocation(line: 270, scope: !696)
!777 = !DILocation(line: 271, scope: !696)
!778 = !DILocation(line: 277, scope: !696)
!779 = !DILocation(line: 278, scope: !696)
!780 = !DILocation(line: 279, scope: !696)
!781 = !DILocation(line: 282, scope: !696)
!782 = !DILocation(line: 283, scope: !696)
!783 = !DILocation(line: 289, scope: !696)
!784 = !DILocation(line: 293, scope: !696)
!785 = !DILocation(line: 297, scope: !696)
!786 = !DILocation(line: 302, scope: !696)
!787 = !DILocation(line: 303, scope: !696)
!788 = !DILocation(line: 305, scope: !696)
!789 = !DILocation(line: 311, scope: !696)
!790 = !DILocation(line: 312, scope: !696)
!791 = !DILocation(line: 314, scope: !696)
!792 = !DILocation(line: 319, scope: !696)
!793 = !DILocation(line: 320, scope: !696)
!794 = !DILocation(line: 325, scope: !696)
!795 = !DILocation(line: 336, scope: !696)
!796 = !DILocation(line: 341, scope: !696)
!797 = !DILocation(line: 350, scope: !696)
!798 = !DILocation(line: 352, scope: !696)
!799 = !DILocation(line: 358, scope: !696)
!800 = !DILocation(line: 359, scope: !696)
!801 = !DILocation(line: 362, scope: !696)
!802 = !DILocation(line: 363, scope: !696)
!803 = !DILocation(line: 366, scope: !696)
!804 = !DILocation(line: 369, scope: !696)
!805 = !DILocation(line: 374, scope: !696)
!806 = !DILocation(line: 382, scope: !696)
!807 = !DILocation(line: 1559, scope: !42)
!808 = !DILocation(line: 43, scope: !809)
!809 = !DILexicalBlockFile(scope: !37, file: !810, discriminator: 0)
!810 = !DIFile(filename: "../src/mlir/lib/Standalone/Lowering/NextLowering.cpp", directory: "/Users/kowalski/dev/sqlite/release")
!811 = !DILocation(line: 46, scope: !809)
!812 = !DILocation(line: 65, scope: !809)
!813 = !DILocation(line: 71, scope: !809)
!814 = !DILocation(line: 75, scope: !809)
!815 = !DILocation(line: 80, scope: !809)
!816 = !DILocation(line: 83, scope: !809)
!817 = !DILocation(line: 84, scope: !809)
!818 = !DILocation(line: 87, scope: !809)
!819 = !DILocation(line: 93, scope: !809)
!820 = !DILocation(line: 99, scope: !809)
!821 = !DILocation(line: 101, scope: !809)
!822 = !DILocation(line: 114, scope: !809)
!823 = !DILocation(line: 116, scope: !809)
!824 = !DILocation(line: 31, scope: !825)
!825 = !DILexicalBlockFile(scope: !37, file: !826, discriminator: 0)
!826 = !DIFile(filename: "../src/mlir/lib/Standalone/Lowering/AggFinalLowering.cpp", directory: "/Users/kowalski/dev/sqlite/release")
!827 = !DILocation(line: 32, scope: !825)
!828 = !DILocation(line: 33, scope: !825)
!829 = !DILocation(line: 34, scope: !825)
!830 = !DILocation(line: 39, scope: !825)
!831 = !DILocation(line: 45, scope: !825)
!832 = !DILocation(line: 47, scope: !825)
!833 = !DILocation(line: 48, scope: !825)
!834 = !DILocation(line: 49, scope: !825)
!835 = !DILocation(line: 56, scope: !825)
!836 = !DILocation(line: 59, scope: !825)
!837 = !DILocation(line: 67, scope: !825)
!838 = !DILocation(line: 41, scope: !839)
!839 = !DILexicalBlockFile(scope: !37, file: !840, discriminator: 0)
!840 = !DIFile(filename: "../src/mlir/lib/Standalone/Lowering/CopyLowering.cpp", directory: "/Users/kowalski/dev/sqlite/release")
!841 = !DILocation(line: 43, scope: !839)
!842 = !DILocation(line: 23, scope: !843)
!843 = !DILexicalBlockFile(scope: !37, file: !844, discriminator: 0)
!844 = !DIFile(filename: "../src/mlir/lib/Standalone/Lowering/ResultRowLowering.cpp", directory: "/Users/kowalski/dev/sqlite/release")
!845 = !DILocation(line: 28, scope: !843)
!846 = !DILocation(line: 52, scope: !843)
!847 = !DILocation(line: 56, scope: !843)
!848 = !DILocation(line: 62, scope: !843)
!849 = !DILocation(line: 63, scope: !843)
!850 = !DILocation(line: 64, scope: !843)
!851 = !DILocation(line: 65, scope: !843)
!852 = !DILocation(line: 75, scope: !843)
!853 = !DILocation(line: 76, scope: !843)
!854 = !DILocation(line: 80, scope: !843)
!855 = !DILocation(line: 82, scope: !843)
!856 = !DILocation(line: 83, scope: !843)
!857 = !DILocation(line: 84, scope: !843)
!858 = !DILocation(line: 85, scope: !843)
!859 = !DILocation(line: 91, scope: !843)
!860 = !DILocation(line: 95, scope: !843)
!861 = !DILocation(line: 99, scope: !843)
!862 = !DILocation(line: 106, scope: !843)
!863 = !DILocation(line: 111, scope: !843)
!864 = !DILocation(line: 112, scope: !843)
!865 = !DILocation(line: 113, scope: !843)
!866 = !DILocation(line: 121, scope: !843)
!867 = !DILocation(line: 127, scope: !843)
!868 = !DILocation(line: 128, scope: !843)
!869 = !DILocation(line: 26, scope: !870)
!870 = !DILexicalBlockFile(scope: !37, file: !871, discriminator: 0)
!871 = !DIFile(filename: "../src/mlir/lib/Standalone/Lowering/HaltLowering.cpp", directory: "/Users/kowalski/dev/sqlite/release")
!872 = !DILocation(line: 29, scope: !870)
!873 = !DILocation(line: 69, scope: !62)
!874 = !DILocation(line: 71, scope: !62)
!875 = !DILocation(line: 143, scope: !62)
!876 = !DILocation(line: 152, scope: !62)
!877 = !DILocation(line: 153, scope: !62)
!878 = !DILocation(line: 156, scope: !62)
!879 = !DILocation(line: 157, scope: !62)
!880 = !DILocation(line: 158, scope: !62)
!881 = !DILocation(line: 159, scope: !62)
!882 = !DILocation(line: 161, scope: !62)
!883 = !DILocation(line: 162, scope: !62)
!884 = !DILocation(line: 181, scope: !62)
!885 = !DILocation(line: 189, scope: !62)
!886 = !DILocation(line: 40, scope: !887)
!887 = !DILexicalBlockFile(scope: !37, file: !888, discriminator: 0)
!888 = !DIFile(filename: "../src/mlir/lib/Standalone/Lowering/RealLowering.cpp", directory: "/Users/kowalski/dev/sqlite/release")
!889 = !DILocation(line: 41, scope: !887)
!890 = !DILocation(line: 42, scope: !887)
!891 = !DILocation(line: 43, scope: !887)
!892 = !DILocation(line: 46, scope: !887)
!893 = !DILocation(line: 50, scope: !887)
!894 = !DILocation(line: 53, scope: !887)
!895 = !DILocation(line: 54, scope: !887)
!896 = !DILocation(line: 57, scope: !887)
!897 = !DILocation(line: 58, scope: !887)
!898 = !DILocation(line: 71, scope: !640)
!899 = !DILocation(line: 74, scope: !640)
!900 = !DILocation(line: 78, scope: !640)
!901 = !DILocation(line: 79, scope: !640)
!902 = !DILocation(line: 39, scope: !644)
!903 = !DILocation(line: 247, scope: !640)
!904 = !DILocation(line: 250, scope: !640)
!905 = !DILocation(line: 251, scope: !640)
!906 = !DILocation(line: 384, scope: !640)
!907 = !DILocation(line: 237, scope: !640)
!908 = !DILocation(line: 240, scope: !640)
!909 = !DILocation(line: 241, scope: !640)
!910 = !DILocation(line: 378, scope: !640)
!911 = !DILocation(line: 30, scope: !912)
!912 = !DILexicalBlockFile(scope: !37, file: !913, discriminator: 0)
!913 = !DIFile(filename: "../src/mlir/lib/Standalone/Lowering/IntegerLowering.cpp", directory: "/Users/kowalski/dev/sqlite/release")
!914 = !DILocation(line: 36, scope: !912)
!915 = !DILocation(line: 39, scope: !912)
!916 = !DILocation(line: 40, scope: !912)
!917 = !DILocation(line: 42, scope: !912)
!918 = !DILocation(line: 42, scope: !74)
