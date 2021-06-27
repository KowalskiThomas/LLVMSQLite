; ModuleID = 'vdbe_4205013591805286785.ll'
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
%struct.sqlite3_vfs = type { i32, i32, i32, %struct.sqlite3_vfs*, i8*, i8*, i32 (%struct.sqlite3_vfs*, i8*, %struct.sqlite3_file*, i32, i32*)*, i32 (%struct.sqlite3_vfs*, i8*, i32)*, i32 (%struct.sqlite3_vfs*, i8*, i32, i32*)*, i32 (%struct.sqlite3_vfs*, i8*, i32, i8*)*, i8* (%struct.sqlite3_vfs*, i8*)*, void (%struct.sqlite3_vfs*, i32, i8*)*, void ()* (%struct.sqlite3_vfs*, i8*, i8*)*, void (%struct.sqlite3_vfs*, i8*)*, i32 (%struct.sqlite3_vfs*, i32, i8*)*, i32 (%struct.sqlite3_vfs*, i32)*, i32 (%struct.sqlite3_vfs*, double*)*, i32 (%struct.sqlite3_vfs*, i32, i8*)*, i32 (%struct.sqlite3_vfs*, i64*)*, i32 (%struct.sqlite3_vfs*, i8*, void ()*)*, void ()* (%struct.sqlite3_vfs*, i8*)*, i8* (%struct.sqlite3_vfs*, i8*)* }
%struct.sqlite3_file = type { %struct.sqlite3_io_methods* }
%struct.sqlite3_io_methods = type { i32, i32 (%struct.sqlite3_file*)*, i32 (%struct.sqlite3_file*, i8*, i32, i64)*, i32 (%struct.sqlite3_file*, i8*, i32, i64)*, i32 (%struct.sqlite3_file*, i64)*, i32 (%struct.sqlite3_file*, i32)*, i32 (%struct.sqlite3_file*, i64*)*, i32 (%struct.sqlite3_file*, i32)*, i32 (%struct.sqlite3_file*, i32)*, i32 (%struct.sqlite3_file*, i32*)*, i32 (%struct.sqlite3_file*, i32, i8*)*, i32 (%struct.sqlite3_file*)*, i32 (%struct.sqlite3_file*)*, i32 (%struct.sqlite3_file*, i32, i32, i32, i8**)*, i32 (%struct.sqlite3_file*, i32, i32, i32)*, void (%struct.sqlite3_file*)*, i32 (%struct.sqlite3_file*, i32)*, i32 (%struct.sqlite3_file*, i64, i32, i8**)*, i32 (%struct.sqlite3_file*, i64, i8*)* }
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
%struct.Bitvec = type { i32, i32, i32, %union.anon.9 }
%union.anon.9 = type { [62 x %struct.Bitvec*] }
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
%struct.Mapping = type { i8*, %struct.sqlite3_io_methods* }
%struct.unix_syscall = type { i8*, void ()*, void ()* }
%struct.unixFile = type { %struct.sqlite3_io_methods*, %struct.sqlite3_vfs*, %struct.unixInodeInfo*, i32, i8, i16, i32, i8*, %struct.UnixUnusedFd*, i8*, %struct.unixShm*, i32, i32, i64, i64, i64, i8*, i32, i32, i32, i32 }
%struct.unixInodeInfo = type { %struct.unixFileId, %struct.sqlite3_mutex*, i32, i32, i8, i8, %struct.UnixUnusedFd*, i32, %struct.unixShmNode*, %struct.unixInodeInfo*, %struct.unixInodeInfo*, i64 }
%struct.unixFileId = type { i32, i64 }
%struct.unixShmNode = type { %struct.unixInodeInfo*, %struct.sqlite3_mutex*, i8*, i32, i32, i16, i8, i8, i8**, i32, %struct.unixShm* }
%struct.UnixUnusedFd = type { i32, i32, %struct.UnixUnusedFd* }
%struct.unixShm = type { %struct.unixShmNode*, %struct.unixShm*, i8, i8, i16, i16 }
%struct.VdbeOpList = type { i8, i8, i8, i8 }
%struct.compareInfo = type { i8, i8, i8, i8 }
%struct.FuncDefHash = type { [23 x %struct.FuncDef*] }
%struct.anon.11 = type { i32, i32 }
%struct.timespec = type { i64, i64 }
%struct.__sFILE = type { i8*, i32, i32, i16, i16, %struct.__sbuf, i32, i8*, i32 (i8*)*, i32 (i8*, i8*, i32)*, i64 (i8*, i64, i32)*, i32 (i8*, i8*, i32)*, %struct.__sbuf, %struct.__sFILEX*, i32, [3 x i8], [1 x i8], %struct.__sbuf, i32, i64 }
%struct.__sFILEX = type opaque
%struct.__sbuf = type { i8*, i32 }
%struct.PCacheGlobal = type { %struct.PGroup, i32, i32, i32, i32, i32, i32, i8*, i8*, %struct.sqlite3_mutex*, %struct.PgFreeslot*, i32, i32 }
%struct.PGroup = type { %struct.sqlite3_mutex*, i32, i32, i32, i32, %struct.PgHdr1 }
%struct.PgHdr1 = type { %struct.sqlite3_pcache_page, i32, i16, i16, %struct.PgHdr1*, %struct.PCache1*, %struct.PgHdr1*, %struct.PgHdr1* }
%struct.PCache1 = type { %struct.PGroup*, i32*, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, %struct.PgHdr1**, %struct.PgHdr1*, i8* }
%struct.PgFreeslot = type { %struct.PgFreeslot* }
%struct.SelectDest = type { i8, i32, i32, i32, i8*, %struct.ExprList* }
%struct.WindowUpdate = type { i8*, i32, i32, i32 }
%struct.anon.21 = type { i8, i8, i8 }
%struct.PragmaName = type { i8*, i8, i8, i8, i8, i64 }
%struct.EncName = type { i8*, i8 }
%struct.OpenMode = type { i8*, i32 }
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
%struct.anon.23 = type { i8, i8, i8*, double, double }
%struct._malloc_zone_t = type { i8*, i8*, i64 (%struct._malloc_zone_t*, i8*)*, {}*, i8* (%struct._malloc_zone_t*, i64, i64)*, {}*, void (%struct._malloc_zone_t*, i8*)*, i8* (%struct._malloc_zone_t*, i8*, i64)*, void (%struct._malloc_zone_t*)*, i8*, i32 (%struct._malloc_zone_t*, i64, i8**, i32)*, void (%struct._malloc_zone_t*, i8**, i32)*, %struct.malloc_introspection_t*, i32, i8* (%struct._malloc_zone_t*, i64, i64)*, void (%struct._malloc_zone_t*, i8*, i64)*, i64 (%struct._malloc_zone_t*, i64)*, i32 (%struct._malloc_zone_t*, i8*)* }
%struct.malloc_introspection_t = type { i32 (i32, i8*, i32, i64, i32 (i32, i64, i64, i8**)*, void (i32, i8*, i32, %struct.vm_range_t*, i32)*)*, i64 (%struct._malloc_zone_t*, i64)*, i32 (%struct._malloc_zone_t*)*, void (%struct._malloc_zone_t*, i32)*, void (%struct._malloc_zone_t*, i8*)*, void (%struct._malloc_zone_t*)*, void (%struct._malloc_zone_t*)*, void (%struct._malloc_zone_t*, %struct.malloc_statistics_t*)*, i32 (%struct._malloc_zone_t*)*, i32 (%struct._malloc_zone_t*)*, void (%struct._malloc_zone_t*)*, void (%struct._malloc_zone_t*, i8*)*, void (%struct._malloc_zone_t*, void (i8*, i8*)*)*, void (%struct._malloc_zone_t*)*, void (i32, i32, i64, i32 (i32, i64, i64, i8**)*, void (i8*, ...)*)*, void (i32, i64, i32 (i32, i64, i64, i8**)*, %struct.malloc_statistics_t*)* }
%struct.vm_range_t = type { i64, i64 }
%struct.malloc_statistics_t = type { i32, i64, i64, i64 }
%struct.RowSet = type { %struct.RowSetChunk*, %struct.sqlite3*, %struct.RowSetEntry*, %struct.RowSetEntry*, %struct.RowSetEntry*, %struct.RowSetEntry*, i16, i16, i32 }
%struct.RowSetChunk = type { %struct.RowSetChunk*, [42 x %struct.RowSetEntry] }
%struct.RowSetEntry = type { i64, %struct.RowSetEntry*, %struct.RowSetEntry* }
%struct.UnpackedRecord = type { %struct.KeyInfo*, %struct.sqlite3_value*, i16, i8, i8, i8, i8, i8 }
%struct.BtreePayload = type { i8*, i64, i8*, %struct.sqlite3_value*, i16, i32, i32 }

@sqlite3_version = constant [7 x i8] c"3.32.0\00", align 1
@sqlite3Stat = internal unnamed_addr global %struct.sqlite3StatType zeroinitializer, align 8
@sqlite3Config = external dso_local global %struct.Sqlite3Config, align 8
@vfsList = internal unnamed_addr global %struct.sqlite3_vfs* null, align 8
@mem0 = internal unnamed_addr global %struct.Mem0Global zeroinitializer, align 8
@.str = private unnamed_addr constant [2 x i8] c"%\00", align 1
@fmtinfo = internal unnamed_addr constant [23 x %struct.et_info] [%struct.et_info { i8 100, i8 10, i8 1, i8 16, i8 0, i8 0 }, %struct.et_info { i8 115, i8 0, i8 4, i8 5, i8 0, i8 0 }, %struct.et_info { i8 103, i8 0, i8 1, i8 3, i8 30, i8 0 }, %struct.et_info { i8 122, i8 0, i8 4, i8 6, i8 0, i8 0 }, %struct.et_info { i8 113, i8 0, i8 4, i8 9, i8 0, i8 0 }, %struct.et_info { i8 81, i8 0, i8 4, i8 10, i8 0, i8 0 }, %struct.et_info { i8 119, i8 0, i8 4, i8 14, i8 0, i8 0 }, %struct.et_info { i8 99, i8 0, i8 0, i8 8, i8 0, i8 0 }, %struct.et_info { i8 111, i8 8, i8 0, i8 0, i8 0, i8 2 }, %struct.et_info { i8 117, i8 10, i8 0, i8 16, i8 0, i8 0 }, %struct.et_info { i8 120, i8 16, i8 0, i8 0, i8 16, i8 1 }, %struct.et_info { i8 88, i8 16, i8 0, i8 0, i8 0, i8 4 }, %struct.et_info { i8 102, i8 0, i8 1, i8 1, i8 0, i8 0 }, %struct.et_info { i8 101, i8 0, i8 1, i8 2, i8 30, i8 0 }, %struct.et_info { i8 69, i8 0, i8 1, i8 2, i8 14, i8 0 }, %struct.et_info { i8 71, i8 0, i8 1, i8 3, i8 14, i8 0 }, %struct.et_info { i8 105, i8 10, i8 1, i8 16, i8 0, i8 0 }, %struct.et_info { i8 110, i8 0, i8 0, i8 4, i8 0, i8 0 }, %struct.et_info { i8 37, i8 0, i8 0, i8 7, i8 0, i8 0 }, %struct.et_info { i8 112, i8 16, i8 0, i8 13, i8 0, i8 1 }, %struct.et_info { i8 84, i8 0, i8 0, i8 11, i8 0, i8 0 }, %struct.et_info { i8 83, i8 0, i8 0, i8 12, i8 0, i8 0 }, %struct.et_info { i8 114, i8 10, i8 1, i8 15, i8 0, i8 0 }], align 16
@sqlite3_str_vappendf.zOrd = internal unnamed_addr constant [9 x i8] c"thstndrd\00", align 1
@aDigits = internal unnamed_addr constant [33 x i8] c"0123456789ABCDEF0123456789abcdef\00", align 16
@aPrefix = internal unnamed_addr constant [7 x i8] c"-x0\00X0\00", align 1
@arRound = internal unnamed_addr constant [10 x double] [double 5.000000e-01, double 5.000000e-02, double 5.000000e-03, double 5.000000e-04, double 5.000000e-05, double 5.000000e-06, double 5.000000e-07, double 5.000000e-08, double 5.000000e-09, double 5.000000e-10], align 16
@.str.1 = private unnamed_addr constant [4 x i8] c"NaN\00", align 1
@.str.3 = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@.str.4 = private unnamed_addr constant [5 x i8] c"NULL\00", align 1
@.str.5 = private unnamed_addr constant [7 x i8] c"(NULL)\00", align 1
@.str.6 = private unnamed_addr constant [2 x i8] c".\00", align 1
@sqlite3OomStr = internal global %struct.sqlite3_str { %struct.sqlite3* null, i8* null, i32 0, i32 0, i32 0, i8 7, i8 0 }, align 8
@sqlite3Prng = internal unnamed_addr global %struct.sqlite3PrngType zeroinitializer, align 1
@sqlite3UpperToLower = internal unnamed_addr constant [256 x i8] c"\00\01\02\03\04\05\06\07\08\09\0A\0B\0C\0D\0E\0F\10\11\12\13\14\15\16\17\18\19\1A\1B\1C\1D\1E\1F !\22#$%&'()*+,-./0123456789:;<=>?@abcdefghijklmnopqrstuvwxyz[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~\7F\80\81\82\83\84\85\86\87\88\89\8A\8B\8C\8D\8E\8F\90\91\92\93\94\95\96\97\98\99\9A\9B\9C\9D\9E\9F\A0\A1\A2\A3\A4\A5\A6\A7\A8\A9\AA\AB\AC\AD\AE\AF\B0\B1\B2\B3\B4\B5\B6\B7\B8\B9\BA\BB\BC\BD\BE\BF\C0\C1\C2\C3\C4\C5\C6\C7\C8\C9\CA\CB\CC\CD\CE\CF\D0\D1\D2\D3\D4\D5\D6\D7\D8\D9\DA\DB\DC\DD\DE\DF\E0\E1\E2\E3\E4\E5\E6\E7\E8\E9\EA\EB\EC\ED\EE\EF\F0\F1\F2\F3\F4\F5\F6\F7\F8\F9\FA\FB\FC\FD\FE\FF", align 16
@posixIoMethods = external constant %struct.sqlite3_io_methods, align 8
@nolockIoMethods = external constant %struct.sqlite3_io_methods, align 8
@dotlockIoMethods = external constant %struct.sqlite3_io_methods, align 8
@flockIoMethods = external constant %struct.sqlite3_io_methods, align 8
@afpIoMethods = external constant %struct.sqlite3_io_methods, align 8
@proxyIoMethods = external constant %struct.sqlite3_io_methods, align 8
@nfsIoMethods = external constant %struct.sqlite3_io_methods, align 8
@autolockIoFinderImpl.aMap = internal unnamed_addr constant [6 x %struct.Mapping] [%struct.Mapping { i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.7, i32 0, i32 0), %struct.sqlite3_io_methods* @posixIoMethods }, %struct.Mapping { i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.8, i32 0, i32 0), %struct.sqlite3_io_methods* @posixIoMethods }, %struct.Mapping { i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.9, i32 0, i32 0), %struct.sqlite3_io_methods* @afpIoMethods }, %struct.Mapping { i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.10, i32 0, i32 0), %struct.sqlite3_io_methods* @afpIoMethods }, %struct.Mapping { i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.11, i32 0, i32 0), %struct.sqlite3_io_methods* @nolockIoMethods }, %struct.Mapping zeroinitializer], align 16
@.str.7 = private unnamed_addr constant [4 x i8] c"hfs\00", align 1
@.str.8 = private unnamed_addr constant [4 x i8] c"ufs\00", align 1
@.str.9 = private unnamed_addr constant [6 x i8] c"afpfs\00", align 1
@.str.10 = private unnamed_addr constant [6 x i8] c"smbfs\00", align 1
@.str.11 = private unnamed_addr constant [7 x i8] c"webdav\00", align 1
@aSyscall = external dso_local unnamed_addr global [29 x %struct.unix_syscall], align 16
@sqlite3_os_init.aVfs = external dso_local global [9 x %struct.sqlite3_vfs], align 16
@.str.13 = private unnamed_addr constant [5 x i8] c"unix\00", align 1
@autolockIoFinder = external dso_local constant %struct.sqlite3_io_methods* (i8*, %struct.unixFile*)*, align 8
@.str.14 = private unnamed_addr constant [10 x i8] c"unix-none\00", align 1
@nolockIoFinder = external dso_local constant %struct.sqlite3_io_methods* (i8*, %struct.unixFile*)*, align 8
@.str.15 = private unnamed_addr constant [13 x i8] c"unix-dotfile\00", align 1
@dotlockIoFinder = external dso_local constant %struct.sqlite3_io_methods* (i8*, %struct.unixFile*)*, align 8
@.str.16 = private unnamed_addr constant [10 x i8] c"unix-excl\00", align 1
@posixIoFinder = external dso_local constant %struct.sqlite3_io_methods* (i8*, %struct.unixFile*)*, align 8
@.str.17 = private unnamed_addr constant [11 x i8] c"unix-posix\00", align 1
@.str.18 = private unnamed_addr constant [11 x i8] c"unix-flock\00", align 1
@flockIoFinder = external dso_local constant %struct.sqlite3_io_methods* (i8*, %struct.unixFile*)*, align 8
@.str.19 = private unnamed_addr constant [9 x i8] c"unix-afp\00", align 1
@afpIoFinder = external dso_local constant %struct.sqlite3_io_methods* (i8*, %struct.unixFile*)*, align 8
@.str.20 = private unnamed_addr constant [9 x i8] c"unix-nfs\00", align 1
@nfsIoFinder = external dso_local constant %struct.sqlite3_io_methods* (i8*, %struct.unixFile*)*, align 8
@.str.21 = private unnamed_addr constant [11 x i8] c"unix-proxy\00", align 1
@proxyIoFinder = external dso_local constant %struct.sqlite3_io_methods* (i8*, %struct.unixFile*)*, align 8
@unixBigLock = internal unnamed_addr global %struct.sqlite3_mutex* null, align 8
@.str.22 = private unnamed_addr constant [40 x i8] c"source and destination must be distinct\00", align 1
@sqlite3PendingByte = internal unnamed_addr global i32 1073741824, align 4
@sqlite3_value_type.aType = internal unnamed_addr constant [64 x i8] c"\04\05\03\05\01\05\01\05\02\05\02\05\01\05\01\05\04\05\03\05\01\05\01\05\02\05\02\05\01\05\01\05\02\05\03\05\02\05\02\05\02\05\02\05\02\05\02\05\04\05\03\05\02\05\02\05\02\05\02\05\02\05\02\05", align 16
@.str.23 = private unnamed_addr constant [23 x i8] c"string or blob too big\00", align 1
@enableJit = local_unnamed_addr global i8 -1, align 1
@Argv = local_unnamed_addr global i8** null, align 8
@Argc = local_unnamed_addr global i32 -1, align 4
@maxVdbeSteps = local_unnamed_addr global i64 -1, align 8
@pcHasBeenSet = local_unnamed_addr global i8 0, align 1
@iCompare = local_unnamed_addr global i32 0, align 4
@.str.25 = private unnamed_addr constant [36 x i8] c"cannot open table without rowid: %s\00", align 1
@.str.26 = private unnamed_addr constant [21 x i8] c"cannot open view: %s\00", align 1
@.str.27 = private unnamed_addr constant [21 x i8] c"no such column: \22%s\22\00", align 1
@.str.28 = private unnamed_addr constant [12 x i8] c"foreign key\00", align 1
@.str.29 = private unnamed_addr constant [8 x i8] c"indexed\00", align 1
@.str.30 = private unnamed_addr constant [34 x i8] c"cannot open %s column for writing\00", align 1
@sqlite3_blob_open.openBlob = internal constant [6 x %struct.VdbeOpList] [%struct.VdbeOpList { i8 -95, i8 0, i8 0, i8 0 }, %struct.VdbeOpList { i8 96, i8 0, i8 0, i8 0 }, %struct.VdbeOpList { i8 32, i8 0, i8 5, i8 1 }, %struct.VdbeOpList { i8 89, i8 0, i8 0, i8 1 }, %struct.VdbeOpList { i8 80, i8 1, i8 0, i8 0 }, %struct.VdbeOpList { i8 68, i8 0, i8 0, i8 0 }], align 16
@.str.31 = private unnamed_addr constant [3 x i8] c"%s\00", align 1
@globInfo = internal constant %struct.compareInfo { i8 42, i8 63, i8 91, i8 0 }, align 1
@likeInfoNorm = internal constant %struct.compareInfo { i8 37, i8 95, i8 0, i8 1 }, align 1
@sqlite3CtypeMap = internal constant [256 x i8] c"\00\00\00\00\00\00\00\00\00\01\01\01\01\01\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\01\00\80\00@\00\00\80\00\00\00\00\00\00\00\00\0C\0C\0C\0C\0C\0C\0C\0C\0C\0C\00\00\00\00\00\00\00\0A\0A\0A\0A\0A\0A\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\80\00\00\00@\80******\22\22\22\22\22\22\22\22\22\22\22\22\22\22\22\22\22\22\22\22\00\00\00\00\00@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@", align 16
@zKWText = internal constant [647 x i8] c"REINDEXEDESCAPEACHECKEYBEFOREIGNOREGEXPLAINSTEADDATABASELECTABLEFTHENDEFERRABLELSEXCLUDELETEMPORARYISNULLSAVEPOINTERSECTIESNOTNULLIKEXCEPTRANSACTIONATURALTERAISEXCLUSIVEXISTSCONSTRAINTOFFSETRIGGERANGENERATEDETACHAVINGLOBEGINNEREFERENCESUNIQUERYWITHOUTERELEASEATTACHBETWEENOTHINGROUPSCASCADEFAULTCASECOLLATECREATECURRENT_DATEIMMEDIATEJOINSERTMATCHPLANALYZEPRAGMABORTUPDATEVALUESVIRTUALWAYSWHENWHERECURSIVEAFTERENAMEANDEFERREDISTINCTAUTOINCREMENTCASTCOLUMNCOMMITCONFLICTCROSSCURRENT_TIMESTAMPARTITIONDROPRECEDINGFAILASTFILTEREPLACEFIRSTFOLLOWINGFROMFULLIMITIFORDERESTRICTOTHERSOVERIGHTROLLBACKROWSUNBOUNDEDUNIONUSINGVACUUMVIEWINDOWBYINITIALLYPRIMARY", align 16
@aKWOffset = internal unnamed_addr constant [145 x i16] [i16 0, i16 2, i16 2, i16 8, i16 9, i16 14, i16 16, i16 20, i16 23, i16 25, i16 25, i16 29, i16 33, i16 36, i16 41, i16 46, i16 48, i16 53, i16 54, i16 59, i16 62, i16 65, i16 67, i16 69, i16 78, i16 81, i16 86, i16 90, i16 90, i16 94, i16 99, i16 101, i16 105, i16 111, i16 119, i16 123, i16 123, i16 123, i16 126, i16 129, i16 132, i16 137, i16 142, i16 146, i16 147, i16 152, i16 156, i16 160, i16 168, i16 174, i16 181, i16 184, i16 184, i16 187, i16 189, i16 195, i16 198, i16 206, i16 211, i16 216, i16 219, i16 222, i16 226, i16 236, i16 239, i16 244, i16 244, i16 248, i16 252, i16 259, i16 265, i16 271, i16 277, i16 277, i16 283, i16 284, i16 288, i16 295, i16 299, i16 306, i16 312, i16 324, i16 333, i16 335, i16 341, i16 346, i16 348, i16 355, i16 360, i16 365, i16 371, i16 377, i16 382, i16 388, i16 392, i16 395, i16 404, i16 408, i16 414, i16 416, i16 423, i16 424, i16 431, i16 433, i16 435, i16 444, i16 448, i16 454, i16 460, i16 468, i16 473, i16 473, i16 473, i16 489, i16 498, i16 501, i16 510, i16 513, i16 517, i16 522, i16 529, i16 534, i16 543, i16 547, i16 550, i16 555, i16 557, i16 561, i16 569, i16 575, i16 578, i16 583, i16 591, i16 591, i16 595, i16 604, i16 609, i16 614, i16 620, i16 623, i16 626, i16 629, i16 631, i16 636, i16 640], align 16
@aKWLen = internal unnamed_addr constant [145 x i8] c"\07\07\05\04\06\04\05\03\06\07\03\06\06\07\07\03\08\02\06\05\04\04\03\0A\04\07\06\09\04\02\06\05\09\09\04\07\03\02\04\04\06\0B\06\02\07\05\05\09\06\0A\04\06\02\03\07\05\09\06\06\04\05\05\0A\06\05\07\04\05\07\06\07\07\06\05\07\03\07\04\07\06\0C\09\04\06\05\04\07\06\05\06\06\07\06\04\05\09\05\06\03\08\08\02\0D\02\02\04\06\06\08\05\11\0C\07\09\04\09\04\04\06\07\05\09\04\04\05\02\05\08\06\04\05\08\04\03\09\05\05\06\04\06\02\02\09\03\07", align 16
@sqlite3_complete.trans = internal unnamed_addr constant [8 x [8 x i8]] [[8 x i8] c"\01\00\02\03\04\02\02\02", [8 x i8] c"\01\01\02\03\04\02\02\02", [8 x i8] c"\01\02\02\02\02\02\02\02", [8 x i8] c"\01\03\03\02\04\02\02\02", [8 x i8] c"\01\04\02\02\02\04\05\02", [8 x i8] c"\06\05\05\05\05\05\05\05", [8 x i8] c"\06\06\05\05\05\05\05\07", [8 x i8] c"\01\07\05\05\05\05\05\05"], align 16
@.str.32 = private unnamed_addr constant [7 x i8] c"create\00", align 1
@.str.33 = private unnamed_addr constant [8 x i8] c"trigger\00", align 1
@.str.34 = private unnamed_addr constant [5 x i8] c"temp\00", align 1
@.str.35 = private unnamed_addr constant [10 x i8] c"temporary\00", align 1
@.str.36 = private unnamed_addr constant [4 x i8] c"end\00", align 1
@.str.37 = private unnamed_addr constant [8 x i8] c"explain\00", align 1
@sqlite3_temp_directory = local_unnamed_addr global i8* null, align 8
@sqlite3_data_directory = local_unnamed_addr global i8* null, align 8
@sqlite3BuiltinFunctions = internal unnamed_addr global %struct.FuncDefHash zeroinitializer, align 8
@sqlite3_db_config.aFlagOp = internal unnamed_addr constant [16 x %struct.anon.11] [%struct.anon.11 { i32 1002, i32 16384 }, %struct.anon.11 { i32 1003, i32 262144 }, %struct.anon.11 { i32 1015, i32 -2147483648 }, %struct.anon.11 { i32 1004, i32 4194304 }, %struct.anon.11 { i32 1005, i32 65536 }, %struct.anon.11 { i32 1006, i32 2048 }, %struct.anon.11 { i32 1007, i32 8388608 }, %struct.anon.11 { i32 1008, i32 16777216 }, %struct.anon.11 { i32 1009, i32 33554432 }, %struct.anon.11 { i32 1010, i32 268435456 }, %struct.anon.11 { i32 1011, i32 134217729 }, %struct.anon.11 { i32 1012, i32 67108864 }, %struct.anon.11 { i32 1014, i32 536870912 }, %struct.anon.11 { i32 1013, i32 1073741824 }, %struct.anon.11 { i32 1016, i32 2 }, %struct.anon.11 { i32 1017, i32 128 }], align 16
@.str.38 = private unnamed_addr constant [21 x i8] c"unknown database: %s\00", align 1
@sqlite3_errmsg16.outOfMem = internal constant [14 x i16] [i16 111, i16 117, i16 116, i16 32, i16 111, i16 102, i16 32, i16 109, i16 101, i16 109, i16 111, i16 114, i16 121, i16 0], align 16
@sqlite3_errmsg16.misuse = internal constant [34 x i16] [i16 98, i16 97, i16 100, i16 32, i16 112, i16 97, i16 114, i16 97, i16 109, i16 101, i16 116, i16 101, i16 114, i16 32, i16 111, i16 114, i16 32, i16 111, i16 116, i16 104, i16 101, i16 114, i16 32, i16 65, i16 80, i16 73, i16 32, i16 109, i16 105, i16 115, i16 117, i16 115, i16 101, i16 0], align 16
@aHardLimit = internal constant [12 x i32] [i32 1000000000, i32 1000000000, i32 2000, i32 1000, i32 500, i32 250000000, i32 127, i32 10, i32 50000, i32 32766, i32 1000, i32 8], align 16
@.str.39 = private unnamed_addr constant [3 x i8] zeroinitializer, align 1
@.str.40 = private unnamed_addr constant [8 x i8] c"INTEGER\00", align 1
@.str.41 = private unnamed_addr constant [28 x i8] c"no such table column: %s.%s\00", align 1
@.str.42 = private unnamed_addr constant [8 x i8] c"SQLITE_\00", align 1
@.str.43 = private unnamed_addr constant [85 x i8] c"2020-03-11 19:56:26 c5f96a085db9688a09793f52ce1ecf033c2e6e2e5873a19fe0fb374b242balt1\00", align 1
@top_of_stack = local_unnamed_addr global i64 0, align 8
@pthreadMutexAlloc.staticMutexes = internal global [12 x %struct.sqlite3_mutex] [%struct.sqlite3_mutex { %struct._opaque_pthread_mutex_t { i64 850045863, [56 x i8] zeroinitializer } }, %struct.sqlite3_mutex { %struct._opaque_pthread_mutex_t { i64 850045863, [56 x i8] zeroinitializer } }, %struct.sqlite3_mutex { %struct._opaque_pthread_mutex_t { i64 850045863, [56 x i8] zeroinitializer } }, %struct.sqlite3_mutex { %struct._opaque_pthread_mutex_t { i64 850045863, [56 x i8] zeroinitializer } }, %struct.sqlite3_mutex { %struct._opaque_pthread_mutex_t { i64 850045863, [56 x i8] zeroinitializer } }, %struct.sqlite3_mutex { %struct._opaque_pthread_mutex_t { i64 850045863, [56 x i8] zeroinitializer } }, %struct.sqlite3_mutex { %struct._opaque_pthread_mutex_t { i64 850045863, [56 x i8] zeroinitializer } }, %struct.sqlite3_mutex { %struct._opaque_pthread_mutex_t { i64 850045863, [56 x i8] zeroinitializer } }, %struct.sqlite3_mutex { %struct._opaque_pthread_mutex_t { i64 850045863, [56 x i8] zeroinitializer } }, %struct.sqlite3_mutex { %struct._opaque_pthread_mutex_t { i64 850045863, [56 x i8] zeroinitializer } }, %struct.sqlite3_mutex { %struct._opaque_pthread_mutex_t { i64 850045863, [56 x i8] zeroinitializer } }, %struct.sqlite3_mutex { %struct._opaque_pthread_mutex_t { i64 850045863, [56 x i8] zeroinitializer } }], align 16
@.str.44 = private unnamed_addr constant [24 x i8] c"cannot fstat db file %s\00", align 1
@.str.45 = private unnamed_addr constant [29 x i8] c"file unlinked while open: %s\00", align 1
@.str.46 = private unnamed_addr constant [27 x i8] c"multiple links to file: %s\00", align 1
@.str.47 = private unnamed_addr constant [28 x i8] c"file renamed while open: %s\00", align 1
@inodeList = internal unnamed_addr global %struct.unixInodeInfo* null, align 8
@.str.48 = private unnamed_addr constant [6 x i8] c"close\00", align 1
@.str.49 = private unnamed_addr constant [31 x i8] c"os_unix.c:%d: (%d) %s(%s) - %s\00", align 1
@.str.50 = private unnamed_addr constant [10 x i8] c"ftruncate\00", align 1
@.str.51 = private unnamed_addr constant [11 x i8] c"full_fsync\00", align 1
@.str.52 = private unnamed_addr constant [17 x i8] c"%s/etilqs_%llx%c\00", align 1
@unixTempFileDir.azDirs = internal unnamed_addr global [6 x i8*] [i8* null, i8* null, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.53, i32 0, i32 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.54, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.55, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.6, i32 0, i32 0)], align 16
@.str.53 = private unnamed_addr constant [9 x i8] c"/var/tmp\00", align 1
@.str.54 = private unnamed_addr constant [9 x i8] c"/usr/tmp\00", align 1
@.str.55 = private unnamed_addr constant [5 x i8] c"/tmp\00", align 1
@.str.56 = private unnamed_addr constant [14 x i8] c"SQLITE_TMPDIR\00", align 1
@.str.57 = private unnamed_addr constant [7 x i8] c"TMPDIR\00", align 1
@.str.58 = private unnamed_addr constant [5 x i8] c"mmap\00", align 1
@.str.59 = private unnamed_addr constant [18 x i8] c":auto: (not held)\00", align 1
@.str.60 = private unnamed_addr constant [7 x i8] c":auto:\00", align 1
@__const.proxyGetHostID.timeout = private unnamed_addr constant %struct.timespec { i64 1, i64 0 }, align 8
@.str.61 = private unnamed_addr constant [6 x i8] c"break\00", align 1
@.str.62 = private unnamed_addr constant [20 x i8] c"path error (len %d)\00", align 1
@.str.63 = private unnamed_addr constant [20 x i8] c"read error (len %d)\00", align 1
@.str.64 = private unnamed_addr constant [19 x i8] c"create failed (%d)\00", align 1
@.str.65 = private unnamed_addr constant [18 x i8] c"write failed (%d)\00", align 1
@.str.66 = private unnamed_addr constant [19 x i8] c"rename failed (%d)\00", align 1
@__stderrp = external local_unnamed_addr global %struct.__sFILE*, align 8
@.str.67 = private unnamed_addr constant [24 x i8] c"broke stale lock on %s\0A\00", align 1
@.str.68 = private unnamed_addr constant [38 x i8] c"failed to break stale lock on %s, %s\0A\00", align 1
@.str.69 = private unnamed_addr constant [13 x i8] c"sqliteplocks\00", align 1
@.str.70 = private unnamed_addr constant [2 x i8] c"/\00", align 1
@.str.71 = private unnamed_addr constant [43 x i8] c"attempt to open \22%s\22 as file descriptor %d\00", align 1
@.str.72 = private unnamed_addr constant [10 x i8] c"/dev/null\00", align 1
@.str.73 = private unnamed_addr constant [17 x i8] c"cannot open file\00", align 1
@.str.74 = private unnamed_addr constant [25 x i8] c"%s at line %d of [%.10s]\00", align 1
@.str.75 = private unnamed_addr constant [6 x i8] c"dummy\00", align 1
@.str.76 = private unnamed_addr constant [5 x i8] c"psow\00", align 1
@.str.77 = private unnamed_addr constant [8 x i8] c"%s.lock\00", align 1
@.str.78 = private unnamed_addr constant [2 x i8] c"S\00", align 1
@.str.79 = private unnamed_addr constant [7 x i8] c"-conch\00", align 1
@.str.80 = private unnamed_addr constant [6 x i8] c"write\00", align 1
@.str.81 = private unnamed_addr constant [7 x i8] c"%s-shm\00", align 1
@.str.82 = private unnamed_addr constant [13 x i8] c"readonly_shm\00", align 1
@.str.83 = private unnamed_addr constant [5 x i8] c"open\00", align 1
@.str.84 = private unnamed_addr constant [7 x i8] c"access\00", align 1
@.str.85 = private unnamed_addr constant [7 x i8] c"getcwd\00", align 1
@.str.86 = private unnamed_addr constant [5 x i8] c"stat\00", align 1
@.str.87 = private unnamed_addr constant [6 x i8] c"fstat\00", align 1
@.str.88 = private unnamed_addr constant [6 x i8] c"fcntl\00", align 1
@.str.89 = private unnamed_addr constant [5 x i8] c"read\00", align 1
@.str.90 = private unnamed_addr constant [6 x i8] c"pread\00", align 1
@.str.91 = private unnamed_addr constant [8 x i8] c"pread64\00", align 1
@.str.92 = private unnamed_addr constant [7 x i8] c"pwrite\00", align 1
@.str.93 = private unnamed_addr constant [9 x i8] c"pwrite64\00", align 1
@.str.94 = private unnamed_addr constant [7 x i8] c"fchmod\00", align 1
@.str.95 = private unnamed_addr constant [10 x i8] c"fallocate\00", align 1
@.str.96 = private unnamed_addr constant [7 x i8] c"unlink\00", align 1
@.str.97 = private unnamed_addr constant [14 x i8] c"openDirectory\00", align 1
@.str.98 = private unnamed_addr constant [6 x i8] c"mkdir\00", align 1
@.str.99 = private unnamed_addr constant [6 x i8] c"rmdir\00", align 1
@.str.100 = private unnamed_addr constant [7 x i8] c"fchown\00", align 1
@.str.101 = private unnamed_addr constant [8 x i8] c"geteuid\00", align 1
@.str.102 = private unnamed_addr constant [7 x i8] c"munmap\00", align 1
@.str.103 = private unnamed_addr constant [7 x i8] c"mremap\00", align 1
@.str.104 = private unnamed_addr constant [12 x i8] c"getpagesize\00", align 1
@.str.105 = private unnamed_addr constant [9 x i8] c"readlink\00", align 1
@.str.106 = private unnamed_addr constant [6 x i8] c"lstat\00", align 1
@.str.107 = private unnamed_addr constant [6 x i8] c"ioctl\00", align 1
@randomnessPid = internal global i32 0, align 4
@.str.108 = private unnamed_addr constant [6 x i8] c"msdos\00", align 1
@.str.109 = private unnamed_addr constant [6 x i8] c"exfat\00", align 1
@.str.110 = private unnamed_addr constant [27 x i8] c"SQLITE_FORCE_PROXY_LOCKING\00", align 1
@.str.111 = private unnamed_addr constant [7 x i8] c"modeof\00", align 1
@.str.112 = private unnamed_addr constant [6 x i8] c"fsync\00", align 1
@.str.113 = private unnamed_addr constant [13 x i8] c"/dev/urandom\00", align 1
@pcache1_g = internal global %struct.PCacheGlobal zeroinitializer, align 8
@.str.114 = private unnamed_addr constant [20 x i8] c"unknown database %s\00", align 1
@.str.115 = private unnamed_addr constant [70 x i8] c"unable to open a temporary database file for storing temporary tables\00", align 1
@.str.116 = private unnamed_addr constant [9 x i8] c":memory:\00", align 1
@sqlite3SharedCacheList = internal unnamed_addr global %struct.BtShared* null, align 8
@sqlite3PagerFilename.zFake = internal constant [8 x i8] zeroinitializer, align 1
@.str.119 = private unnamed_addr constant [7 x i8] c"nolock\00", align 1
@.str.120 = private unnamed_addr constant [10 x i8] c"immutable\00", align 1
@MemJournalMethods = external dso_local constant %struct.sqlite3_io_methods, align 8
@.str.121 = private unnamed_addr constant [37 x i8] c"recovered %d frames from WAL file %s\00", align 1
@.str.122 = private unnamed_addr constant [20 x i8] c"database corruption\00", align 1
@.str.123 = private unnamed_addr constant [26 x i8] c"cannot limit WAL size: %s\00", align 1
@aJournalMagic = internal constant [8 x i8] c"\D9\D5\05\F9 \A1c\D7", align 1
@syncJournal.zerobyte = internal constant i8 0, align 1
@.str.124 = private unnamed_addr constant [27 x i8] c"recovered %d pages from %s\00", align 1
@zeroJournalHdr.zeroHdr = internal constant [28 x i8] zeroinitializer, align 16
@.str.125 = private unnamed_addr constant [31 x i8] c"destination database is in use\00", align 1
@zMagicHeader = internal constant [16 x i8] c"SQLite format 3\00", align 16
@.str.126 = private unnamed_addr constant [4 x i8] c"@  \00", align 1
@.str.127 = private unnamed_addr constant [45 x i8] c"API called with finalized prepared statement\00", align 1
@.str.128 = private unnamed_addr constant [30 x i8] c"FOREIGN KEY constraint failed\00", align 1
@.str.129 = private unnamed_addr constant [20 x i8] c"%s-mjXXXXXX9XXz%c%c\00", align 1
@.str.130 = private unnamed_addr constant [14 x i8] c"MJ delete: %s\00", align 1
@.str.131 = private unnamed_addr constant [15 x i8] c"MJ collide: %s\00", align 1
@.str.132 = private unnamed_addr constant [13 x i8] c"-mj%06X9%02X\00", align 1
@sqlite3Utf8Trans1 = internal unnamed_addr constant [64 x i8] c"\00\01\02\03\04\05\06\07\08\09\0A\0B\0C\0D\0E\0F\10\11\12\13\14\15\16\17\18\19\1A\1B\1C\1D\1E\1F\00\01\02\03\04\05\06\07\08\09\0A\0B\0C\0D\0E\0F\00\01\02\03\04\05\06\07\00\01\02\03\00\01\00\00", align 16
@.str.133 = private unnamed_addr constant [35 x i8] c"sqlite3VdbeRealValue: NO FLAG SET\0A\00", align 1
@.str.134 = private unnamed_addr constant [40 x i8] c"API called with NULL prepared statement\00", align 1
@.str.135 = private unnamed_addr constant [5 x i8] c"%.2x\00", align 1
@sqlite3OpcodeName.azName = internal unnamed_addr constant [176 x i8*] [i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.136, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.137, i32 0, i32 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.138, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.139, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.140, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.141, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.142, i32 0, i32 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.143, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.144, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.145, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.146, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.147, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.148, i32 0, i32 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.149, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.150, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.151, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.152, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.153, i32 0, i32 0), i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.154, i32 0, i32 0), i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.155, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.156, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.157, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.158, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.159, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.160, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.161, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.162, i32 0, i32 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.163, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.164, i32 0, i32 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.165, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.166, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.167, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.168, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.169, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.170, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.171, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.172, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.173, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.174, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.175, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.176, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.177, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.178, i32 0, i32 0), i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.179, i32 0, i32 0), i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.180, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.181, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.182, i32 0, i32 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.183, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.184, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.185, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.186, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.187, i32 0, i32 0), i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.188, i32 0, i32 0), i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.189, i32 0, i32 0), i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.190, i32 0, i32 0), i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.191, i32 0, i32 0), i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.192, i32 0, i32 0), i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.193, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.194, i32 0, i32 0), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.195, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.196, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.197, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.198, i32 0, i32 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.199, i32 0, i32 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.200, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.201, i32 0, i32 0), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.202, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.203, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.204, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.205, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.206, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.207, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.208, i32 0, i32 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.209, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.210, i32 0, i32 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.211, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.212, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.213, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.214, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.215, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.216, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.217, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.218, i32 0, i32 0), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.219, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.220, i32 0, i32 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.221, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.222, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.223, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.224, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.225, i32 0, i32 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.226, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.227, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.228, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.229, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.230, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.231, i32 0, i32 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.232, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.233, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.234, i32 0, i32 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.235, i32 0, i32 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.236, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.237, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.238, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.239, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.240, i32 0, i32 0), i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.241, i32 0, i32 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.242, i32 0, i32 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.243, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.244, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.245, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.246, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.247, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.248, i32 0, i32 0), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.249, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.250, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.251, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.252, i32 0, i32 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.253, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.254, i32 0, i32 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.255, i32 0, i32 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.256, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.257, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.258, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.259, i32 0, i32 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.260, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.261, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.262, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.263, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.264, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.265, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.266, i32 0, i32 0), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.267, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.268, i32 0, i32 0), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.269, i32 0, i32 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.270, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.271, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.272, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.273, i32 0, i32 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.274, i32 0, i32 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.275, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.276, i32 0, i32 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.277, i32 0, i32 0), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.278, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.279, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.280, i32 0, i32 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.281, i32 0, i32 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.282, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.283, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.284, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.285, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.286, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.287, i32 0, i32 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.288, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.289, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.290, i32 0, i32 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.291, i32 0, i32 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.292, i32 0, i32 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.293, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.294, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.295, i32 0, i32 0), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.296, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.297, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.298, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.299, i32 0, i32 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.300, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.301, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.302, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.303, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.304, i32 0, i32 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.305, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.306, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.307, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.308, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.309, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.310, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.311, i32 0, i32 0)], align 16
@.str.136 = private unnamed_addr constant [10 x i8] c"Savepoint\00", align 1
@.str.137 = private unnamed_addr constant [11 x i8] c"AutoCommit\00", align 1
@.str.138 = private unnamed_addr constant [12 x i8] c"Transaction\00", align 1
@.str.139 = private unnamed_addr constant [11 x i8] c"SorterNext\00", align 1
@.str.140 = private unnamed_addr constant [5 x i8] c"Prev\00", align 1
@.str.141 = private unnamed_addr constant [5 x i8] c"Next\00", align 1
@.str.142 = private unnamed_addr constant [11 x i8] c"Checkpoint\00", align 1
@.str.143 = private unnamed_addr constant [12 x i8] c"JournalMode\00", align 1
@.str.144 = private unnamed_addr constant [7 x i8] c"Vacuum\00", align 1
@.str.145 = private unnamed_addr constant [8 x i8] c"VFilter\00", align 1
@.str.146 = private unnamed_addr constant [8 x i8] c"VUpdate\00", align 1
@.str.147 = private unnamed_addr constant [5 x i8] c"Goto\00", align 1
@.str.148 = private unnamed_addr constant [6 x i8] c"Gosub\00", align 1
@.str.149 = private unnamed_addr constant [14 x i8] c"InitCoroutine\00", align 1
@.str.150 = private unnamed_addr constant [6 x i8] c"Yield\00", align 1
@.str.151 = private unnamed_addr constant [10 x i8] c"MustBeInt\00", align 1
@.str.152 = private unnamed_addr constant [5 x i8] c"Jump\00", align 1
@.str.153 = private unnamed_addr constant [5 x i8] c"Once\00", align 1
@.str.154 = private unnamed_addr constant [3 x i8] c"If\00", align 1
@.str.155 = private unnamed_addr constant [4 x i8] c"Not\00", align 1
@.str.156 = private unnamed_addr constant [6 x i8] c"IfNot\00", align 1
@.str.157 = private unnamed_addr constant [10 x i8] c"IfNullRow\00", align 1
@.str.158 = private unnamed_addr constant [7 x i8] c"SeekLT\00", align 1
@.str.159 = private unnamed_addr constant [7 x i8] c"SeekLE\00", align 1
@.str.160 = private unnamed_addr constant [7 x i8] c"SeekGE\00", align 1
@.str.161 = private unnamed_addr constant [7 x i8] c"SeekGT\00", align 1
@.str.162 = private unnamed_addr constant [10 x i8] c"IfNotOpen\00", align 1
@.str.163 = private unnamed_addr constant [9 x i8] c"IfNoHope\00", align 1
@.str.164 = private unnamed_addr constant [11 x i8] c"NoConflict\00", align 1
@.str.165 = private unnamed_addr constant [9 x i8] c"NotFound\00", align 1
@.str.166 = private unnamed_addr constant [6 x i8] c"Found\00", align 1
@.str.167 = private unnamed_addr constant [10 x i8] c"SeekRowid\00", align 1
@.str.168 = private unnamed_addr constant [10 x i8] c"NotExists\00", align 1
@.str.169 = private unnamed_addr constant [5 x i8] c"Last\00", align 1
@.str.170 = private unnamed_addr constant [10 x i8] c"IfSmaller\00", align 1
@.str.171 = private unnamed_addr constant [11 x i8] c"SorterSort\00", align 1
@.str.172 = private unnamed_addr constant [5 x i8] c"Sort\00", align 1
@.str.173 = private unnamed_addr constant [7 x i8] c"Rewind\00", align 1
@.str.174 = private unnamed_addr constant [6 x i8] c"IdxLE\00", align 1
@.str.175 = private unnamed_addr constant [6 x i8] c"IdxGT\00", align 1
@.str.176 = private unnamed_addr constant [6 x i8] c"IdxLT\00", align 1
@.str.177 = private unnamed_addr constant [6 x i8] c"IdxGE\00", align 1
@.str.178 = private unnamed_addr constant [11 x i8] c"RowSetRead\00", align 1
@.str.179 = private unnamed_addr constant [3 x i8] c"Or\00", align 1
@.str.180 = private unnamed_addr constant [4 x i8] c"And\00", align 1
@.str.181 = private unnamed_addr constant [11 x i8] c"RowSetTest\00", align 1
@.str.182 = private unnamed_addr constant [8 x i8] c"Program\00", align 1
@.str.183 = private unnamed_addr constant [9 x i8] c"FkIfZero\00", align 1
@.str.184 = private unnamed_addr constant [6 x i8] c"IfPos\00", align 1
@.str.185 = private unnamed_addr constant [10 x i8] c"IfNotZero\00", align 1
@.str.186 = private unnamed_addr constant [7 x i8] c"IsNull\00", align 1
@.str.187 = private unnamed_addr constant [8 x i8] c"NotNull\00", align 1
@.str.188 = private unnamed_addr constant [3 x i8] c"Ne\00", align 1
@.str.189 = private unnamed_addr constant [3 x i8] c"Eq\00", align 1
@.str.190 = private unnamed_addr constant [3 x i8] c"Gt\00", align 1
@.str.191 = private unnamed_addr constant [3 x i8] c"Le\00", align 1
@.str.192 = private unnamed_addr constant [3 x i8] c"Lt\00", align 1
@.str.193 = private unnamed_addr constant [3 x i8] c"Ge\00", align 1
@.str.194 = private unnamed_addr constant [10 x i8] c"ElseNotEq\00", align 1
@.str.195 = private unnamed_addr constant [13 x i8] c"DecrJumpZero\00", align 1
@.str.196 = private unnamed_addr constant [11 x i8] c"IncrVacuum\00", align 1
@.str.197 = private unnamed_addr constant [6 x i8] c"VNext\00", align 1
@.str.198 = private unnamed_addr constant [5 x i8] c"Init\00", align 1
@.str.199 = private unnamed_addr constant [9 x i8] c"PureFunc\00", align 1
@.str.200 = private unnamed_addr constant [9 x i8] c"Function\00", align 1
@.str.201 = private unnamed_addr constant [7 x i8] c"Return\00", align 1
@.str.202 = private unnamed_addr constant [13 x i8] c"EndCoroutine\00", align 1
@.str.203 = private unnamed_addr constant [11 x i8] c"HaltIfNull\00", align 1
@.str.204 = private unnamed_addr constant [5 x i8] c"Halt\00", align 1
@.str.205 = private unnamed_addr constant [8 x i8] c"Integer\00", align 1
@.str.206 = private unnamed_addr constant [6 x i8] c"Int64\00", align 1
@.str.207 = private unnamed_addr constant [7 x i8] c"String\00", align 1
@.str.208 = private unnamed_addr constant [5 x i8] c"Null\00", align 1
@.str.209 = private unnamed_addr constant [9 x i8] c"SoftNull\00", align 1
@.str.210 = private unnamed_addr constant [5 x i8] c"Blob\00", align 1
@.str.211 = private unnamed_addr constant [9 x i8] c"Variable\00", align 1
@.str.212 = private unnamed_addr constant [5 x i8] c"Move\00", align 1
@.str.213 = private unnamed_addr constant [5 x i8] c"Copy\00", align 1
@.str.214 = private unnamed_addr constant [6 x i8] c"SCopy\00", align 1
@.str.215 = private unnamed_addr constant [8 x i8] c"IntCopy\00", align 1
@.str.216 = private unnamed_addr constant [10 x i8] c"ResultRow\00", align 1
@.str.217 = private unnamed_addr constant [8 x i8] c"CollSeq\00", align 1
@.str.218 = private unnamed_addr constant [7 x i8] c"AddImm\00", align 1
@.str.219 = private unnamed_addr constant [13 x i8] c"RealAffinity\00", align 1
@.str.220 = private unnamed_addr constant [5 x i8] c"Cast\00", align 1
@.str.221 = private unnamed_addr constant [12 x i8] c"Permutation\00", align 1
@.str.222 = private unnamed_addr constant [8 x i8] c"Compare\00", align 1
@.str.223 = private unnamed_addr constant [7 x i8] c"IsTrue\00", align 1
@.str.224 = private unnamed_addr constant [7 x i8] c"Offset\00", align 1
@.str.225 = private unnamed_addr constant [7 x i8] c"Column\00", align 1
@.str.226 = private unnamed_addr constant [9 x i8] c"Affinity\00", align 1
@.str.227 = private unnamed_addr constant [11 x i8] c"MakeRecord\00", align 1
@.str.228 = private unnamed_addr constant [6 x i8] c"Count\00", align 1
@.str.229 = private unnamed_addr constant [11 x i8] c"ReadCookie\00", align 1
@.str.230 = private unnamed_addr constant [10 x i8] c"SetCookie\00", align 1
@.str.231 = private unnamed_addr constant [10 x i8] c"ReopenIdx\00", align 1
@.str.232 = private unnamed_addr constant [9 x i8] c"OpenRead\00", align 1
@.str.233 = private unnamed_addr constant [10 x i8] c"OpenWrite\00", align 1
@.str.234 = private unnamed_addr constant [8 x i8] c"OpenDup\00", align 1
@.str.235 = private unnamed_addr constant [14 x i8] c"OpenAutoindex\00", align 1
@.str.236 = private unnamed_addr constant [14 x i8] c"OpenEphemeral\00", align 1
@.str.237 = private unnamed_addr constant [7 x i8] c"BitAnd\00", align 1
@.str.238 = private unnamed_addr constant [6 x i8] c"BitOr\00", align 1
@.str.239 = private unnamed_addr constant [10 x i8] c"ShiftLeft\00", align 1
@.str.240 = private unnamed_addr constant [11 x i8] c"ShiftRight\00", align 1
@.str.241 = private unnamed_addr constant [4 x i8] c"Add\00", align 1
@.str.242 = private unnamed_addr constant [9 x i8] c"Subtract\00", align 1
@.str.243 = private unnamed_addr constant [9 x i8] c"Multiply\00", align 1
@.str.244 = private unnamed_addr constant [7 x i8] c"Divide\00", align 1
@.str.245 = private unnamed_addr constant [10 x i8] c"Remainder\00", align 1
@.str.246 = private unnamed_addr constant [7 x i8] c"Concat\00", align 1
@.str.247 = private unnamed_addr constant [11 x i8] c"SorterOpen\00", align 1
@.str.248 = private unnamed_addr constant [7 x i8] c"BitNot\00", align 1
@.str.249 = private unnamed_addr constant [13 x i8] c"SequenceTest\00", align 1
@.str.250 = private unnamed_addr constant [11 x i8] c"OpenPseudo\00", align 1
@.str.251 = private unnamed_addr constant [8 x i8] c"String8\00", align 1
@.str.252 = private unnamed_addr constant [6 x i8] c"Close\00", align 1
@.str.253 = private unnamed_addr constant [12 x i8] c"ColumnsUsed\00", align 1
@.str.254 = private unnamed_addr constant [8 x i8] c"SeekHit\00", align 1
@.str.255 = private unnamed_addr constant [9 x i8] c"Sequence\00", align 1
@.str.256 = private unnamed_addr constant [9 x i8] c"NewRowid\00", align 1
@.str.257 = private unnamed_addr constant [7 x i8] c"Insert\00", align 1
@.str.258 = private unnamed_addr constant [7 x i8] c"Delete\00", align 1
@.str.259 = private unnamed_addr constant [11 x i8] c"ResetCount\00", align 1
@.str.260 = private unnamed_addr constant [14 x i8] c"SorterCompare\00", align 1
@.str.261 = private unnamed_addr constant [11 x i8] c"SorterData\00", align 1
@.str.262 = private unnamed_addr constant [8 x i8] c"RowData\00", align 1
@.str.263 = private unnamed_addr constant [6 x i8] c"Rowid\00", align 1
@.str.264 = private unnamed_addr constant [8 x i8] c"NullRow\00", align 1
@.str.265 = private unnamed_addr constant [8 x i8] c"SeekEnd\00", align 1
@.str.266 = private unnamed_addr constant [10 x i8] c"IdxInsert\00", align 1
@.str.267 = private unnamed_addr constant [13 x i8] c"SorterInsert\00", align 1
@.str.268 = private unnamed_addr constant [10 x i8] c"IdxDelete\00", align 1
@.str.269 = private unnamed_addr constant [13 x i8] c"DeferredSeek\00", align 1
@.str.270 = private unnamed_addr constant [9 x i8] c"IdxRowid\00", align 1
@.str.271 = private unnamed_addr constant [11 x i8] c"FinishSeek\00", align 1
@.str.272 = private unnamed_addr constant [8 x i8] c"Destroy\00", align 1
@.str.273 = private unnamed_addr constant [6 x i8] c"Clear\00", align 1
@.str.274 = private unnamed_addr constant [12 x i8] c"ResetSorter\00", align 1
@.str.275 = private unnamed_addr constant [12 x i8] c"CreateBtree\00", align 1
@.str.276 = private unnamed_addr constant [8 x i8] c"SqlExec\00", align 1
@.str.277 = private unnamed_addr constant [12 x i8] c"ParseSchema\00", align 1
@.str.278 = private unnamed_addr constant [13 x i8] c"LoadAnalysis\00", align 1
@.str.279 = private unnamed_addr constant [10 x i8] c"DropTable\00", align 1
@.str.280 = private unnamed_addr constant [10 x i8] c"DropIndex\00", align 1
@.str.281 = private unnamed_addr constant [12 x i8] c"DropTrigger\00", align 1
@.str.282 = private unnamed_addr constant [12 x i8] c"IntegrityCk\00", align 1
@.str.283 = private unnamed_addr constant [10 x i8] c"RowSetAdd\00", align 1
@.str.284 = private unnamed_addr constant [6 x i8] c"Param\00", align 1
@.str.285 = private unnamed_addr constant [10 x i8] c"FkCounter\00", align 1
@.str.286 = private unnamed_addr constant [5 x i8] c"Real\00", align 1
@.str.287 = private unnamed_addr constant [7 x i8] c"MemMax\00", align 1
@.str.288 = private unnamed_addr constant [12 x i8] c"OffsetLimit\00", align 1
@.str.289 = private unnamed_addr constant [11 x i8] c"AggInverse\00", align 1
@.str.290 = private unnamed_addr constant [8 x i8] c"AggStep\00", align 1
@.str.291 = private unnamed_addr constant [9 x i8] c"AggStep1\00", align 1
@.str.292 = private unnamed_addr constant [9 x i8] c"AggValue\00", align 1
@.str.293 = private unnamed_addr constant [9 x i8] c"AggFinal\00", align 1
@.str.294 = private unnamed_addr constant [7 x i8] c"Expire\00", align 1
@.str.295 = private unnamed_addr constant [11 x i8] c"CursorLock\00", align 1
@.str.296 = private unnamed_addr constant [13 x i8] c"CursorUnlock\00", align 1
@.str.297 = private unnamed_addr constant [10 x i8] c"TableLock\00", align 1
@.str.298 = private unnamed_addr constant [7 x i8] c"VBegin\00", align 1
@.str.299 = private unnamed_addr constant [8 x i8] c"VCreate\00", align 1
@.str.300 = private unnamed_addr constant [9 x i8] c"VDestroy\00", align 1
@.str.301 = private unnamed_addr constant [6 x i8] c"VOpen\00", align 1
@.str.302 = private unnamed_addr constant [8 x i8] c"VColumn\00", align 1
@.str.303 = private unnamed_addr constant [8 x i8] c"VRename\00", align 1
@.str.304 = private unnamed_addr constant [10 x i8] c"Pagecount\00", align 1
@.str.305 = private unnamed_addr constant [9 x i8] c"MaxPgcnt\00", align 1
@.str.306 = private unnamed_addr constant [6 x i8] c"Trace\00", align 1
@.str.307 = private unnamed_addr constant [11 x i8] c"CursorHint\00", align 1
@.str.308 = private unnamed_addr constant [11 x i8] c"ReleaseReg\00", align 1
@.str.309 = private unnamed_addr constant [5 x i8] c"Noop\00", align 1
@.str.310 = private unnamed_addr constant [8 x i8] c"Explain\00", align 1
@.str.311 = private unnamed_addr constant [10 x i8] c"Abortable\00", align 1
@.str.312 = private unnamed_addr constant [5 x i8] c"k(%d\00", align 1
@.str.313 = private constant [7 x i8] c"BINARY\00", align 1
@.str.314 = private unnamed_addr constant [2 x i8] c"B\00", align 1
@.str.315 = private unnamed_addr constant [8 x i8] c",%s%s%s\00", align 1
@.str.316 = private unnamed_addr constant [2 x i8] c"-\00", align 1
@.str.317 = private unnamed_addr constant [3 x i8] c"N.\00", align 1
@.str.318 = private unnamed_addr constant [2 x i8] c")\00", align 1
@displayP4.encnames = internal unnamed_addr constant [4 x i8*] [i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.319, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.320, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.321, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.322, i32 0, i32 0)], align 16
@.str.319 = private unnamed_addr constant [2 x i8] c"?\00", align 1
@.str.320 = private unnamed_addr constant [2 x i8] c"8\00", align 1
@.str.321 = private unnamed_addr constant [5 x i8] c"16LE\00", align 1
@.str.322 = private unnamed_addr constant [5 x i8] c"16BE\00", align 1
@.str.323 = private unnamed_addr constant [9 x i8] c"%.18s-%s\00", align 1
@.str.324 = private unnamed_addr constant [7 x i8] c"%s(%d)\00", align 1
@.str.325 = private unnamed_addr constant [5 x i8] c"%lld\00", align 1
@.str.326 = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@.str.327 = private unnamed_addr constant [6 x i8] c"%.16g\00", align 1
@.str.328 = private unnamed_addr constant [7 x i8] c"(blob)\00", align 1
@.str.329 = private unnamed_addr constant [4 x i8] c",%d\00", align 1
@.str.330 = private unnamed_addr constant [2 x i8] c"]\00", align 1
@.str.331 = private unnamed_addr constant [8 x i8] c"program\00", align 1
@sqlite3VdbeExec.azType = internal unnamed_addr constant [4 x i8*] [i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.332, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.333, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.334, i32 0, i32 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.335, i32 0, i32 0)], align 16
@.str.332 = private unnamed_addr constant [9 x i8] c"NOT NULL\00", align 1
@.str.333 = private unnamed_addr constant [7 x i8] c"UNIQUE\00", align 1
@.str.334 = private unnamed_addr constant [6 x i8] c"CHECK\00", align 1
@.str.335 = private unnamed_addr constant [12 x i8] c"FOREIGN KEY\00", align 1
@.str.336 = private unnamed_addr constant [21 x i8] c"%s constraint failed\00", align 1
@.str.337 = private unnamed_addr constant [7 x i8] c"%z: %s\00", align 1
@.str.338 = private unnamed_addr constant [24 x i8] c"abort at %d in [%s]: %s\00", align 1
@sqlite3VdbeExec.aLTb = internal unnamed_addr constant [6 x i8] c"\01\00\00\01\01\00", align 1
@sqlite3VdbeExec.aEQb = internal unnamed_addr constant [6 x i8] c"\00\01\00\01\00\01", align 1
@sqlite3VdbeExec.aGTb = internal unnamed_addr constant [6 x i8] c"\01\00\01\00\00\01", align 1
@sqlite3VdbeExec.and_logic = internal unnamed_addr constant [9 x i8] c"\00\00\00\00\01\02\00\02\02", align 1
@sqlite3VdbeExec.or_logic = internal unnamed_addr constant [9 x i8] c"\00\01\02\01\01\01\02\01\02", align 1
@sqlite3VdbeExec.aFlag = internal unnamed_addr constant [2 x i16] [i16 16, i16 514], align 2
@.str.339 = private unnamed_addr constant [51 x i8] c"cannot open savepoint - SQL statements in progress\00", align 1
@.str.340 = private unnamed_addr constant [22 x i8] c"no such savepoint: %s\00", align 1
@.str.341 = private unnamed_addr constant [54 x i8] c"cannot release savepoint - SQL statements in progress\00", align 1
@.str.342 = private unnamed_addr constant [55 x i8] c"cannot commit transaction - SQL statements in progress\00", align 1
@.str.343 = private unnamed_addr constant [48 x i8] c"cannot start a transaction within a transaction\00", align 1
@.str.344 = private unnamed_addr constant [43 x i8] c"cannot rollback - no transaction is active\00", align 1
@.str.345 = private unnamed_addr constant [41 x i8] c"cannot commit - no transaction is active\00", align 1
@.str.346 = private unnamed_addr constant [28 x i8] c"database schema has changed\00", align 1
@.str.347 = private unnamed_addr constant [14 x i8] c"sqlite_master\00", align 1
@.str.348 = private unnamed_addr constant [43 x i8] c"SELECT*FROM\22%w\22.%s WHERE %s ORDER BY rowid\00", align 1
@.str.349 = private unnamed_addr constant [37 x i8] c"too many levels of trigger recursion\00", align 1
@.str.350 = private unnamed_addr constant [52 x i8] c"cannot change %s wal mode from within a transaction\00", align 1
@.str.351 = private unnamed_addr constant [5 x i8] c"into\00", align 1
@.str.352 = private unnamed_addr constant [7 x i8] c"out of\00", align 1
@.str.353 = private unnamed_addr constant [29 x i8] c"database table is locked: %s\00", align 1
@.str.354 = private unnamed_addr constant [32 x i8] c"statement aborts at %d: [%s] %s\00", align 1
@.str.355 = private unnamed_addr constant [14 x i8] c"out of memory\00", align 1
@sqlite3SmallTypeSizes = internal unnamed_addr constant [128 x i8] c"\00\01\02\03\04\06\08\08\00\00\00\00\00\00\01\01\02\02\03\03\04\04\05\05\06\06\07\07\08\08\09\09\0A\0A\0B\0B\0C\0C\0D\0D\0E\0E\0F\0F\10\10\11\11\12\12\13\13\14\14\15\15\16\16\17\17\18\18\19\19\1A\1A\1B\1B\1C\1C\1D\1D\1E\1E\1F\1F  !!\22\22##$$%%&&''(())**++,,--..//00112233445566778899", align 16
@sqlite3VdbeSerialGet.aFlag = internal unnamed_addr constant [2 x i16] [i16 4112, i16 4098], align 2
@sqlite3BtreeFakeValidCursor.fakeCursor = internal global i8 0, align 1
@sqlite3LogEst.a = internal unnamed_addr constant [8 x i16] [i16 0, i16 2, i16 3, i16 5, i16 6, i16 7, i16 8, i16 9], align 16
@vdbeSorterCompareInt.aLen = internal unnamed_addr constant [10 x i8] c"\00\01\02\03\04\06\08\00\00\00", align 1
@.str.356 = private unnamed_addr constant [6 x i8] c"table\00", align 1
@.str.357 = private unnamed_addr constant [19 x i8] c"sqlite_temp_master\00", align 1
@.str.358 = private unnamed_addr constant [2 x i8] c"1\00", align 1
@.str.359 = private unnamed_addr constant [72 x i8] c"CREATE TABLE x(type text,name text,tbl_name text,rootpage int,sql text)\00", align 1
@.str.360 = private unnamed_addr constant [68 x i8] c"attached databases must use the same text encoding as main database\00", align 1
@.str.361 = private unnamed_addr constant [24 x i8] c"unsupported file format\00", align 1
@.str.362 = private unnamed_addr constant [34 x i8] c"SELECT*FROM\22%w\22.%s ORDER BY rowid\00", align 1
@findElementWithHash.nullElement = internal global %struct.HashElem zeroinitializer, align 8
@.str.363 = private unnamed_addr constant [8 x i8] c"create \00", align 1
@.str.364 = private unnamed_addr constant [17 x i8] c"invalid rootpage\00", align 1
@.str.365 = private unnamed_addr constant [13 x i8] c"orphan index\00", align 1
@.str.366 = private unnamed_addr constant [31 x i8] c"malformed database schema (%s)\00", align 1
@.str.367 = private unnamed_addr constant [8 x i8] c"%z - %s\00", align 1
@.str.368 = private unnamed_addr constant [30 x i8] c"database schema is locked: %s\00", align 1
@.str.369 = private unnamed_addr constant [19 x i8] c"statement too long\00", align 1
@.str.370 = private unnamed_addr constant [27 x i8] c"unrecognized token: \22%.*s\22\00", align 1
@.str.371 = private unnamed_addr constant [11 x i8] c"%s in \22%s\22\00", align 1
@aiClass = internal unnamed_addr constant [256 x i8] c"\1C\1B\1B\1B\1B\1B\1B\1B\1B\07\07\1B\07\07\1B\1B\1B\1B\1B\1B\1B\1B\1B\1B\1B\1B\1B\1B\1B\1B\1B\1B\07\0F\08\05\04\16\18\08\11\12\15\14\17\0B\1A\10\03\03\03\03\03\03\03\03\03\03\05\13\0C\0E\0D\06\05\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\00\01\01\09\1B\1B\1B\01\08\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\00\01\01\1B\0A\1B\19\1B\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02", align 16
@aKWHash = internal unnamed_addr constant [127 x i8] c"Tf\84Rr\1D\00\00[\00UH\005#V\0F\00*^6~\85\13\00\00\8A\00(\80\00\16h\00\09\00\00zP\00N\06\00Ac\91\00\86p\00\000\00d\18\00\11\00\1BF\17\1A\05<\8Cky\00IeG\8F=wJ\001\00\0B)\00n\00\00\00j\0Alq|\0E2{\00Y\00\12x\8E8\81\89XS%\1E}\00\00i3\82\7F\00\22\00\00,\00_&'\00\14-tZ", align 16
@aKWCode = internal unnamed_addr constant [145 x i8] c"ar\9E':)zC!\82>?/\02A\A0&\18\88\10t\9C\0B\81\9D[~\15\15+2R\0D\87^3\13Bw/\86\06\1Cqt\9FG\09\14u\94ED\80MY_(\91/\05t{y\03\19Qt\0E 0\95\\\90#\1Fv\9Ao\11c\08\8D}.\04\1EF\1B\7F\89P`\9B\93H\1Db,\07\8A-|\0F1$<\0A%tccUW\83X*T\A3ISV\8Ct\92\12\8FJ]\A2t\0CLKZ\84\8ENO\A1=\22@\85x", align 16
@aKWNext = internal unnamed_addr constant [145 x i8] c"\00\00\00\00\04\00+\00\00go\00\00\00\02\00\00\8D\00\00\00\0D\00\00\00\00\8B\00\00v4\00\00\87\0C\00\00>\00\88\00\83\00\00$\00\00\1CM\00\00\00\00;\00/\00\00\00\00\00\00\00\00\00\00E\00\00\00\00\00\90\03\00:\00\01K\00\00\00\1F\00\00\00\00\00\00@B?\00\00\00\00.\00\10\00s\00\00\00\00\00\00\00\00\00\00Qa\00\08\00m\15\07C\00O]u\00\00D\00\00`\007\00L\00\\ !9\19\00b\00\00W", align 16
@yyFallback = internal unnamed_addr constant <{ [100 x i16], [81 x i16] }> <{ [100 x i16] [i16 0, i16 0, i16 59, i16 59, i16 59, i16 59, i16 0, i16 59, i16 59, i16 59, i16 0, i16 59, i16 59, i16 59, i16 59, i16 0, i16 0, i16 0, i16 59, i16 0, i16 0, i16 59, i16 0, i16 0, i16 0, i16 59, i16 0, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 0, i16 0, i16 0, i16 59, i16 59, i16 0, i16 0, i16 0, i16 0, i16 0, i16 0, i16 0, i16 0, i16 0, i16 0, i16 0, i16 0, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59, i16 59], [81 x i16] zeroinitializer }>, align 16
@yy_shift_ofst = internal unnamed_addr constant [535 x i16] [i16 1448, i16 1277, i16 1072, i16 1668, i16 1072, i16 319, i16 1122, i16 1225, i16 1332, i16 1481, i16 1481, i16 1481, i16 57, i16 0, i16 0, i16 180, i16 897, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 930, i16 930, i16 1020, i16 1020, i16 290, i16 378, i16 319, i16 319, i16 319, i16 319, i16 319, i16 319, i16 40, i16 110, i16 219, i16 288, i16 327, i16 396, i16 435, i16 504, i16 543, i16 612, i16 651, i16 720, i16 877, i16 897, i16 897, i16 897, i16 897, i16 897, i16 897, i16 897, i16 897, i16 897, i16 897, i16 897, i16 897, i16 897, i16 897, i16 897, i16 897, i16 897, i16 897, i16 917, i16 897, i16 1019, i16 763, i16 763, i16 1451, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1553, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 1481, i16 147, i16 258, i16 258, i16 258, i16 258, i16 258, i16 360, i16 424, i16 81, i16 183, i16 1039, i16 183, i16 636, i16 636, i16 183, i16 434, i16 434, i16 189, i16 434, i16 434, i16 134, i16 225, i16 225, i16 511, i16 29, i16 1924, i16 1924, i16 399, i16 399, i16 399, i16 93, i16 163, i16 187, i16 163, i16 163, i16 821, i16 821, i16 487, i16 237, i16 183, i16 183, i16 183, i16 183, i16 183, i16 183, i16 183, i16 183, i16 183, i16 183, i16 183, i16 183, i16 183, i16 183, i16 183, i16 183, i16 183, i16 183, i16 183, i16 183, i16 183, i16 332, i16 332, i16 183, i16 773, i16 419, i16 419, i16 937, i16 937, i16 548, i16 840, i16 1924, i16 1924, i16 466, i16 739, i16 739, i16 453, i16 53, i16 618, i16 513, i16 688, i16 737, i16 746, i16 935, i16 183, i16 183, i16 183, i16 183, i16 183, i16 183, i16 183, i16 183, i16 183, i16 51, i16 183, i16 183, i16 183, i16 183, i16 183, i16 183, i16 183, i16 183, i16 183, i16 183, i16 715, i16 715, i16 715, i16 183, i16 183, i16 183, i16 183, i16 772, i16 183, i16 183, i16 183, i16 971, i16 1091, i16 183, i16 183, i16 1238, i16 183, i16 183, i16 183, i16 183, i16 183, i16 183, i16 183, i16 183, i16 714, i16 1132, i16 502, i16 398, i16 398, i16 398, i16 398, i16 1090, i16 502, i16 502, i16 909, i16 853, i16 896, i16 817, i16 1292, i16 300, i16 300, i16 1135, i16 1292, i16 1292, i16 1135, i16 1266, i16 1136, i16 1260, i16 1080, i16 1080, i16 1080, i16 300, i16 1062, i16 1062, i16 905, i16 1276, i16 1175, i16 1071, i16 1577, i16 1499, i16 1499, i16 1604, i16 1604, i16 1499, i16 1496, i16 1532, i16 1626, i16 1608, i16 1508, i16 1638, i16 1638, i16 1638, i16 1638, i16 1508, i16 1508, i16 1532, i16 1626, i16 1608, i16 1608, i16 1508, i16 1499, i16 1665, i16 1531, i16 1625, i16 1499, i16 1665, i16 1669, i16 1499, i16 1665, i16 1499, i16 1665, i16 1669, i16 1583, i16 1583, i16 1583, i16 1645, i16 1680, i16 1680, i16 1669, i16 1583, i16 1588, i16 1583, i16 1645, i16 1583, i16 1583, i16 1552, i16 1669, i16 1609, i16 1609, i16 1669, i16 1584, i16 1617, i16 1584, i16 1617, i16 1584, i16 1617, i16 1584, i16 1617, i16 1499, i16 1641, i16 1641, i16 1662, i16 1662, i16 1599, i16 1605, i16 1725, i16 1499, i16 1600, i16 1599, i16 1611, i16 1610, i16 1508, i16 1732, i16 1733, i16 1749, i16 1749, i16 1761, i16 1761, i16 1761, i16 1924, i16 1924, i16 1924, i16 1924, i16 1924, i16 1924, i16 1924, i16 1924, i16 1924, i16 1924, i16 1924, i16 1924, i16 20, i16 1178, i16 397, i16 1133, i16 1310, i16 1245, i16 385, i16 1184, i16 1327, i16 1335, i16 1431, i16 1440, i16 1497, i16 1511, i16 1516, i16 1518, i16 1312, i16 1268, i16 1435, i16 1385, i16 1341, i16 1523, i16 1525, i16 1423, i16 1507, i16 1164, i16 1252, i16 1536, i16 1538, i16 1362, i16 1404, i16 1781, i16 1783, i16 1628, i16 1777, i16 1695, i16 1779, i16 1773, i16 1774, i16 1661, i16 1652, i16 1673, i16 1778, i16 1663, i16 1786, i16 1806, i16 1670, i16 1659, i16 1681, i16 1750, i16 1775, i16 1666, i16 1760, i16 1762, i16 1763, i16 1764, i16 1690, i16 1705, i16 1787, i16 1683, i16 1819, i16 1818, i16 1802, i16 1712, i16 1671, i16 1758, i16 1804, i16 1765, i16 1753, i16 1790, i16 1693, i16 1721, i16 1811, i16 1816, i16 1820, i16 1708, i16 1715, i16 1821, i16 1780, i16 1822, i16 1823, i16 1817, i16 1824, i16 1782, i16 1789, i16 1826, i16 1745, i16 1814, i16 1829, i16 1785, i16 1825, i16 1830, i16 1707, i16 1833, i16 1834, i16 1835, i16 1836, i16 1837, i16 1838, i16 1842, i16 1832, i16 1843, i16 1845, i16 1841, i16 1729, i16 1846, i16 1847, i16 1746, i16 1839, i16 1849, i16 1731, i16 1848, i16 1844, i16 1850, i16 1851, i16 1852, i16 1788, i16 1800, i16 1791, i16 1853, i16 1805, i16 1794, i16 1854, i16 1856, i16 1859, i16 1858, i16 1857, i16 1863, i16 1860, i16 1867, i16 1848, i16 1868, i16 1869, i16 1870, i16 1872, i16 1873, i16 1875, i16 1874, i16 1889, i16 1879, i16 1880, i16 1881, i16 1882, i16 1884, i16 1885, i16 1877, i16 1776, i16 1769, i16 1771, i16 1772, i16 1784, i16 1890, i16 1897, i16 1913, i16 1914], align 16
@yy_lookahead = internal unnamed_addr constant [2105 x i16] [i16 189, i16 211, i16 189, i16 267, i16 268, i16 269, i16 267, i16 268, i16 269, i16 189, i16 211, i16 189, i16 189, i16 189, i16 189, i16 189, i16 294, i16 197, i16 189, i16 19, i16 298, i16 201, i16 211, i16 212, i16 211, i16 212, i16 200, i16 288, i16 200, i16 206, i16 207, i16 31, i16 189, i16 211, i16 212, i16 211, i16 212, i16 211, i16 212, i16 39, i16 211, i16 212, i16 189, i16 43, i16 44, i16 45, i16 46, i16 47, i16 48, i16 49, i16 50, i16 51, i16 52, i16 53, i16 54, i16 55, i16 56, i16 57, i16 233, i16 19, i16 234, i16 235, i16 234, i16 235, i16 211, i16 212, i16 46, i16 47, i16 48, i16 49, i16 230, i16 231, i16 248, i16 247, i16 248, i16 247, i16 189, i16 248, i16 214, i16 251, i16 252, i16 257, i16 271, i16 43, i16 44, i16 45, i16 46, i16 47, i16 48, i16 49, i16 50, i16 51, i16 52, i16 53, i16 54, i16 55, i16 56, i16 57, i16 211, i16 212, i16 277, i16 101, i16 102, i16 103, i16 104, i16 105, i16 106, i16 107, i16 108, i16 109, i16 110, i16 111, i16 299, i16 300, i16 289, i16 181, i16 182, i16 183, i16 184, i16 185, i16 186, i16 299, i16 211, i16 301, i16 73, i16 191, i16 86, i16 193, i16 88, i16 19, i16 73, i16 267, i16 268, i16 269, i16 200, i16 292, i16 26, i16 200, i16 81, i16 119, i16 111, i16 101, i16 102, i16 103, i16 104, i16 105, i16 106, i16 107, i16 108, i16 109, i16 110, i16 111, i16 59, i16 43, i16 44, i16 45, i16 46, i16 47, i16 48, i16 49, i16 50, i16 51, i16 52, i16 53, i16 54, i16 55, i16 56, i16 57, i16 234, i16 235, i16 117, i16 234, i16 235, i16 120, i16 121, i16 122, i16 125, i16 126, i16 127, i16 69, i16 189, i16 247, i16 125, i16 130, i16 247, i16 22, i16 299, i16 300, i16 107, i16 108, i16 109, i16 110, i16 111, i16 136, i16 137, i16 261, i16 218, i16 189, i16 220, i16 19, i16 263, i16 54, i16 55, i16 56, i16 57, i16 58, i16 228, i16 114, i16 115, i16 116, i16 21, i16 101, i16 102, i16 103, i16 104, i16 105, i16 106, i16 107, i16 108, i16 109, i16 110, i16 111, i16 59, i16 43, i16 44, i16 45, i16 46, i16 47, i16 48, i16 49, i16 50, i16 51, i16 52, i16 53, i16 54, i16 55, i16 56, i16 57, i16 19, i16 214, i16 208, i16 148, i16 59, i16 24, i16 236, i16 208, i16 59, i16 67, i16 101, i16 102, i16 103, i16 104, i16 105, i16 106, i16 107, i16 108, i16 109, i16 110, i16 111, i16 72, i16 126, i16 127, i16 43, i16 44, i16 45, i16 46, i16 47, i16 48, i16 49, i16 50, i16 51, i16 52, i16 53, i16 54, i16 55, i16 56, i16 57, i16 114, i16 115, i16 116, i16 225, i16 101, i16 102, i16 103, i16 104, i16 105, i16 106, i16 107, i16 108, i16 109, i16 110, i16 111, i16 267, i16 268, i16 269, i16 189, i16 59, i16 114, i16 115, i16 116, i16 210, i16 114, i16 115, i16 116, i16 267, i16 268, i16 269, i16 19, i16 218, i16 72, i16 121, i16 23, i16 54, i16 55, i16 56, i16 57, i16 284, i16 211, i16 212, i16 19, i16 101, i16 102, i16 103, i16 104, i16 105, i16 106, i16 107, i16 108, i16 109, i16 110, i16 111, i16 43, i16 44, i16 45, i16 46, i16 47, i16 48, i16 49, i16 50, i16 51, i16 52, i16 53, i16 54, i16 55, i16 56, i16 57, i16 19, i16 158, i16 189, i16 59, i16 23, i16 114, i16 115, i16 116, i16 248, i16 205, i16 206, i16 207, i16 26, i16 101, i16 102, i16 103, i16 104, i16 105, i16 106, i16 107, i16 108, i16 109, i16 110, i16 111, i16 43, i16 44, i16 45, i16 46, i16 47, i16 48, i16 49, i16 50, i16 51, i16 52, i16 53, i16 54, i16 55, i16 56, i16 57, i16 189, i16 266, i16 162, i16 163, i16 101, i16 102, i16 103, i16 104, i16 105, i16 106, i16 107, i16 108, i16 109, i16 110, i16 111, i16 81, i16 208, i16 206, i16 207, i16 114, i16 115, i16 116, i16 117, i16 76, i16 24, i16 120, i16 121, i16 122, i16 16, i16 114, i16 19, i16 296, i16 297, i16 19, i16 23, i16 130, i16 89, i16 24, i16 24, i16 92, i16 205, i16 206, i16 207, i16 101, i16 102, i16 103, i16 104, i16 105, i16 106, i16 107, i16 108, i16 109, i16 110, i16 111, i16 43, i16 44, i16 45, i16 46, i16 47, i16 48, i16 49, i16 50, i16 51, i16 52, i16 53, i16 54, i16 55, i16 56, i16 57, i16 19, i16 136, i16 137, i16 59, i16 23, i16 81, i16 26, i16 101, i16 102, i16 103, i16 104, i16 105, i16 106, i16 107, i16 108, i16 109, i16 110, i16 111, i16 279, i16 277, i16 77, i16 22, i16 79, i16 284, i16 43, i16 44, i16 45, i16 46, i16 47, i16 48, i16 49, i16 50, i16 51, i16 52, i16 53, i16 54, i16 55, i16 56, i16 57, i16 194, i16 95, i16 76, i16 118, i16 101, i16 102, i16 103, i16 104, i16 105, i16 106, i16 107, i16 108, i16 109, i16 110, i16 111, i16 89, i16 189, i16 111, i16 92, i16 59, i16 115, i16 136, i16 137, i16 117, i16 118, i16 119, i16 120, i16 121, i16 122, i16 123, i16 19, i16 139, i16 59, i16 189, i16 23, i16 129, i16 105, i16 106, i16 107, i16 108, i16 109, i16 110, i16 111, i16 101, i16 102, i16 103, i16 104, i16 105, i16 106, i16 107, i16 108, i16 109, i16 110, i16 111, i16 43, i16 44, i16 45, i16 46, i16 47, i16 48, i16 49, i16 50, i16 51, i16 52, i16 53, i16 54, i16 55, i16 56, i16 57, i16 19, i16 76, i16 227, i16 99, i16 23, i16 114, i16 115, i16 116, i16 136, i16 137, i16 59, i16 274, i16 87, i16 189, i16 89, i16 278, i16 189, i16 92, i16 114, i16 115, i16 189, i16 189, i16 189, i16 119, i16 43, i16 44, i16 45, i16 46, i16 47, i16 48, i16 49, i16 50, i16 51, i16 52, i16 53, i16 54, i16 55, i16 56, i16 57, i16 189, i16 266, i16 230, i16 231, i16 101, i16 102, i16 103, i16 104, i16 105, i16 106, i16 107, i16 108, i16 109, i16 110, i16 111, i16 150, i16 151, i16 152, i16 189, i16 107, i16 110, i16 111, i16 211, i16 212, i16 189, i16 233, i16 114, i16 115, i16 116, i16 143, i16 19, i16 296, i16 297, i16 132, i16 23, i16 134, i16 135, i16 226, i16 189, i16 22, i16 211, i16 212, i16 189, i16 101, i16 102, i16 103, i16 104, i16 105, i16 106, i16 107, i16 108, i16 109, i16 110, i16 111, i16 43, i16 44, i16 45, i16 46, i16 47, i16 48, i16 49, i16 50, i16 51, i16 52, i16 53, i16 54, i16 55, i16 56, i16 57, i16 19, i16 189, i16 239, i16 183, i16 184, i16 185, i16 186, i16 59, i16 248, i16 293, i16 294, i16 191, i16 249, i16 193, i16 298, i16 291, i16 292, i16 257, i16 293, i16 294, i16 200, i16 143, i16 189, i16 298, i16 43, i16 44, i16 45, i16 46, i16 47, i16 48, i16 49, i16 50, i16 51, i16 52, i16 53, i16 54, i16 55, i16 56, i16 57, i16 161, i16 22, i16 189, i16 276, i16 101, i16 102, i16 103, i16 104, i16 105, i16 106, i16 107, i16 108, i16 109, i16 110, i16 111, i16 234, i16 235, i16 189, i16 234, i16 235, i16 184, i16 227, i16 186, i16 114, i16 115, i16 116, i16 285, i16 191, i16 247, i16 193, i16 19, i16 247, i16 105, i16 106, i16 189, i16 262, i16 200, i16 189, i16 59, i16 211, i16 212, i16 35, i16 261, i16 101, i16 102, i16 103, i16 104, i16 105, i16 106, i16 107, i16 108, i16 109, i16 110, i16 111, i16 43, i16 44, i16 45, i16 46, i16 47, i16 48, i16 49, i16 50, i16 51, i16 52, i16 53, i16 54, i16 55, i16 56, i16 57, i16 189, i16 234, i16 235, i16 66, i16 19, i16 189, i16 11, i16 248, i16 150, i16 189, i16 152, i16 74, i16 236, i16 189, i16 247, i16 236, i16 257, i16 23, i16 59, i16 189, i16 26, i16 201, i16 211, i16 212, i16 114, i16 115, i16 116, i16 59, i16 261, i16 156, i16 45, i16 46, i16 47, i16 48, i16 49, i16 50, i16 51, i16 52, i16 53, i16 54, i16 55, i16 56, i16 57, i16 101, i16 102, i16 103, i16 104, i16 105, i16 106, i16 107, i16 108, i16 109, i16 110, i16 111, i16 15, i16 12, i16 189, i16 233, i16 189, i16 248, i16 99, i16 125, i16 126, i16 127, i16 189, i16 128, i16 189, i16 200, i16 294, i16 244, i16 27, i16 246, i16 298, i16 114, i16 115, i16 116, i16 115, i16 189, i16 211, i16 212, i16 119, i16 189, i16 114, i16 115, i16 116, i16 42, i16 101, i16 102, i16 103, i16 104, i16 105, i16 106, i16 107, i16 108, i16 109, i16 110, i16 111, i16 22, i16 156, i16 60, i16 141, i16 234, i16 235, i16 211, i16 212, i16 189, i16 63, i16 189, i16 189, i16 141, i16 116, i16 150, i16 151, i16 152, i16 247, i16 248, i16 73, i16 201, i16 19, i16 234, i16 235, i16 126, i16 127, i16 24, i16 257, i16 7, i16 8, i16 9, i16 189, i16 211, i16 212, i16 262, i16 247, i16 258, i16 189, i16 141, i16 259, i16 189, i16 19, i16 223, i16 248, i16 225, i16 43, i16 44, i16 45, i16 46, i16 47, i16 48, i16 49, i16 50, i16 51, i16 52, i16 53, i16 54, i16 55, i16 56, i16 57, i16 294, i16 19, i16 211, i16 212, i16 298, i16 43, i16 44, i16 45, i16 46, i16 47, i16 48, i16 49, i16 50, i16 51, i16 52, i16 53, i16 54, i16 55, i16 56, i16 57, i16 258, i16 233, i16 22, i16 105, i16 106, i16 43, i16 44, i16 45, i16 46, i16 47, i16 48, i16 49, i16 50, i16 51, i16 52, i16 53, i16 54, i16 55, i16 56, i16 57, i16 258, i16 136, i16 137, i16 101, i16 102, i16 103, i16 104, i16 105, i16 106, i16 107, i16 108, i16 109, i16 110, i16 111, i16 59, i16 189, i16 189, i16 189, i16 22, i16 59, i16 24, i16 59, i16 189, i16 101, i16 102, i16 103, i16 104, i16 105, i16 106, i16 107, i16 108, i16 109, i16 110, i16 111, i16 189, i16 263, i16 189, i16 211, i16 212, i16 211, i16 212, i16 107, i16 189, i16 101, i16 102, i16 103, i16 104, i16 105, i16 106, i16 107, i16 108, i16 109, i16 110, i16 111, i16 226, i16 59, i16 211, i16 212, i16 211, i16 212, i16 105, i16 106, i16 189, i16 19, i16 211, i16 212, i16 233, i16 133, i16 113, i16 114, i16 115, i16 116, i16 138, i16 118, i16 114, i16 115, i16 116, i16 115, i16 189, i16 226, i16 200, i16 126, i16 189, i16 19, i16 189, i16 155, i16 189, i16 157, i16 44, i16 45, i16 46, i16 47, i16 48, i16 49, i16 50, i16 51, i16 52, i16 53, i16 54, i16 55, i16 56, i16 57, i16 189, i16 189, i16 59, i16 150, i16 189, i16 152, i16 211, i16 212, i16 46, i16 115, i16 285, i16 26, i16 234, i16 235, i16 19, i16 20, i16 22, i16 22, i16 24, i16 76, i16 189, i16 226, i16 211, i16 212, i16 233, i16 247, i16 211, i16 212, i16 189, i16 236, i16 87, i16 36, i16 89, i16 189, i16 31, i16 92, i16 189, i16 226, i16 189, i16 26, i16 189, i16 226, i16 39, i16 101, i16 102, i16 103, i16 104, i16 105, i16 106, i16 107, i16 108, i16 109, i16 110, i16 111, i16 59, i16 211, i16 212, i16 114, i16 115, i16 116, i16 211, i16 212, i16 211, i16 212, i16 19, i16 20, i16 71, i16 22, i16 200, i16 189, i16 226, i16 200, i16 285, i16 189, i16 262, i16 113, i16 81, i16 19, i16 200, i16 294, i16 66, i16 36, i16 23, i16 298, i16 29, i16 26, i16 143, i16 200, i16 33, i16 200, i16 259, i16 129, i16 200, i16 48, i16 99, i16 211, i16 212, i16 248, i16 259, i16 85, i16 105, i16 106, i16 234, i16 235, i16 59, i16 234, i16 235, i16 112, i16 94, i16 114, i16 115, i16 116, i16 234, i16 235, i16 119, i16 247, i16 71, i16 16, i16 247, i16 189, i16 65, i16 234, i16 235, i16 234, i16 235, i16 247, i16 234, i16 235, i16 143, i16 116, i16 85, i16 136, i16 137, i16 189, i16 247, i16 90, i16 247, i16 251, i16 252, i16 247, i16 189, i16 211, i16 212, i16 189, i16 99, i16 150, i16 151, i16 152, i16 153, i16 154, i16 105, i16 106, i16 189, i16 189, i16 141, i16 211, i16 212, i16 112, i16 144, i16 114, i16 115, i16 116, i16 211, i16 212, i16 119, i16 211, i16 212, i16 19, i16 20, i16 189, i16 22, i16 189, i16 114, i16 12, i16 211, i16 212, i16 203, i16 204, i16 77, i16 189, i16 79, i16 125, i16 126, i16 127, i16 36, i16 294, i16 189, i16 189, i16 27, i16 298, i16 22, i16 211, i16 212, i16 211, i16 212, i16 150, i16 151, i16 152, i16 153, i16 154, i16 0, i16 1, i16 2, i16 42, i16 189, i16 5, i16 235, i16 59, i16 211, i16 212, i16 10, i16 11, i16 12, i16 13, i16 14, i16 26, i16 189, i16 17, i16 247, i16 71, i16 189, i16 53, i16 189, i16 259, i16 63, i16 26, i16 211, i16 212, i16 189, i16 46, i16 30, i16 133, i16 32, i16 85, i16 127, i16 189, i16 138, i16 150, i16 90, i16 152, i16 40, i16 26, i16 211, i16 212, i16 211, i16 212, i16 189, i16 99, i16 303, i16 189, i16 211, i16 212, i16 189, i16 105, i16 106, i16 22, i16 149, i16 211, i16 212, i16 158, i16 112, i16 189, i16 114, i16 115, i16 116, i16 189, i16 189, i16 119, i16 211, i16 212, i16 70, i16 211, i16 212, i16 23, i16 19, i16 20, i16 26, i16 22, i16 78, i16 189, i16 22, i16 81, i16 189, i16 211, i16 212, i16 189, i16 259, i16 211, i16 212, i16 189, i16 221, i16 36, i16 59, i16 189, i16 59, i16 189, i16 113, i16 97, i16 150, i16 151, i16 152, i16 153, i16 154, i16 189, i16 211, i16 212, i16 189, i16 211, i16 212, i16 118, i16 119, i16 211, i16 212, i16 124, i16 59, i16 211, i16 212, i16 211, i16 212, i16 61, i16 189, i16 203, i16 204, i16 59, i16 189, i16 150, i16 71, i16 152, i16 211, i16 212, i16 189, i16 131, i16 189, i16 189, i16 189, i16 189, i16 136, i16 137, i16 189, i16 140, i16 85, i16 189, i16 211, i16 212, i16 59, i16 90, i16 211, i16 212, i16 115, i16 22, i16 115, i16 189, i16 211, i16 212, i16 99, i16 211, i16 212, i16 211, i16 212, i16 159, i16 105, i16 106, i16 147, i16 211, i16 212, i16 7, i16 8, i16 112, i16 189, i16 114, i16 115, i16 116, i16 1, i16 2, i16 119, i16 189, i16 5, i16 23, i16 221, i16 115, i16 26, i16 10, i16 11, i16 12, i16 13, i16 14, i16 23, i16 189, i16 17, i16 26, i16 211, i16 212, i16 189, i16 19, i16 20, i16 189, i16 22, i16 189, i16 189, i16 189, i16 115, i16 30, i16 189, i16 32, i16 253, i16 150, i16 151, i16 152, i16 153, i16 154, i16 36, i16 40, i16 189, i16 221, i16 211, i16 212, i16 189, i16 211, i16 212, i16 211, i16 212, i16 211, i16 212, i16 19, i16 20, i16 189, i16 22, i16 119, i16 189, i16 83, i16 84, i16 189, i16 189, i16 59, i16 211, i16 212, i16 189, i16 129, i16 211, i16 212, i16 36, i16 70, i16 189, i16 23, i16 250, i16 71, i16 26, i16 211, i16 212, i16 78, i16 211, i16 212, i16 81, i16 23, i16 211, i16 212, i16 26, i16 23, i16 211, i16 212, i16 26, i16 189, i16 23, i16 59, i16 23, i16 26, i16 139, i16 26, i16 97, i16 23, i16 189, i16 23, i16 26, i16 99, i16 26, i16 71, i16 189, i16 189, i16 189, i16 105, i16 106, i16 107, i16 23, i16 189, i16 23, i16 26, i16 112, i16 26, i16 114, i16 115, i16 116, i16 189, i16 231, i16 119, i16 189, i16 19, i16 20, i16 281, i16 22, i16 189, i16 189, i16 189, i16 131, i16 99, i16 189, i16 189, i16 189, i16 136, i16 137, i16 105, i16 106, i16 280, i16 36, i16 237, i16 290, i16 250, i16 112, i16 250, i16 114, i16 115, i16 116, i16 250, i16 238, i16 119, i16 150, i16 151, i16 152, i16 153, i16 154, i16 250, i16 159, i16 209, i16 187, i16 241, i16 254, i16 59, i16 254, i16 286, i16 241, i16 241, i16 286, i16 215, i16 224, i16 220, i16 214, i16 214, i16 214, i16 71, i16 244, i16 254, i16 244, i16 273, i16 238, i16 240, i16 150, i16 151, i16 152, i16 153, i16 154, i16 192, i16 60, i16 139, i16 196, i16 290, i16 196, i16 38, i16 196, i16 148, i16 113, i16 276, i16 287, i16 22, i16 265, i16 287, i16 43, i16 99, i16 229, i16 241, i16 147, i16 18, i16 232, i16 105, i16 106, i16 264, i16 232, i16 232, i16 265, i16 232, i16 112, i16 264, i16 114, i16 115, i16 116, i16 229, i16 229, i16 119, i16 5, i16 241, i16 241, i16 196, i16 241, i16 10, i16 11, i16 12, i16 13, i16 14, i16 18, i16 195, i16 17, i16 155, i16 62, i16 283, i16 196, i16 195, i16 22, i16 282, i16 216, i16 196, i16 195, i16 113, i16 196, i16 30, i16 195, i16 32, i16 216, i16 22, i16 150, i16 151, i16 152, i16 153, i16 154, i16 40, i16 64, i16 222, i16 219, i16 124, i16 219, i16 162, i16 213, i16 213, i16 297, i16 213, i16 256, i16 111, i16 275, i16 216, i16 213, i16 215, i16 213, i16 142, i16 213, i16 213, i16 275, i16 113, i16 255, i16 91, i16 216, i16 256, i16 222, i16 216, i16 255, i16 70, i16 256, i16 256, i16 255, i16 255, i16 196, i16 82, i16 146, i16 78, i16 22, i16 143, i16 81, i16 260, i16 302, i16 302, i16 196, i16 144, i16 155, i16 145, i16 25, i16 199, i16 26, i16 198, i16 270, i16 13, i16 190, i16 190, i16 97, i16 245, i16 6, i16 244, i16 241, i16 243, i16 245, i16 242, i16 188, i16 188, i16 188, i16 208, i16 202, i16 208, i16 260, i16 208, i16 202, i16 217, i16 217, i16 208, i16 4, i16 3, i16 209, i16 160, i16 209, i16 208, i16 202, i16 15, i16 98, i16 272, i16 16, i16 23, i16 23, i16 137, i16 131, i16 148, i16 128, i16 24, i16 140, i16 136, i16 137, i16 20, i16 1, i16 149, i16 128, i16 140, i16 61, i16 37, i16 53, i16 148, i16 53, i16 53, i16 53, i16 128, i16 114, i16 1, i16 34, i16 139, i16 5, i16 22, i16 113, i16 68, i16 159, i16 75, i16 158, i16 26, i16 41, i16 139, i16 68, i16 113, i16 24, i16 20, i16 129, i16 123, i16 19, i16 23, i16 96, i16 28, i16 22, i16 22, i16 22, i16 22, i16 67, i16 59, i16 67, i16 24, i16 22, i16 67, i16 23, i16 147, i16 22, i16 24, i16 23, i16 23, i16 23, i16 114, i16 23, i16 37, i16 26, i16 22, i16 24, i16 23, i16 22, i16 139, i16 23, i16 23, i16 22, i16 141, i16 34, i16 26, i16 75, i16 88, i16 86, i16 34, i16 23, i16 75, i16 22, i16 24, i16 26, i16 34, i16 34, i16 34, i16 93, i16 34, i16 26, i16 23, i16 23, i16 23, i16 23, i16 34, i16 23, i16 22, i16 44, i16 23, i16 26, i16 11, i16 22, i16 22, i16 26, i16 23, i16 23, i16 22, i16 22, i16 139, i16 133, i16 139, i16 139, i16 15, i16 23, i16 1, i16 1, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 139, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304, i16 304], align 16
@yy_action = internal unnamed_addr constant [1924 x i16] [i16 528, i16 1183, i16 528, i16 114, i16 111, i16 208, i16 114, i16 111, i16 208, i16 192, i16 1186, i16 528, i16 418, i16 528, i16 450, i16 528, i16 1447, i16 362, i16 528, i16 380, i16 6, i16 373, i16 70, i16 70, i16 42, i16 42, i16 476, i16 1423, i16 485, i16 418, i16 417, i16 911, i16 505, i16 42, i16 42, i16 71, i16 71, i16 51, i16 51, i16 912, i16 71, i16 71, i16 484, i16 121, i16 122, i16 112, i16 1132, i16 1132, i16 980, i16 983, i16 973, i16 973, i16 119, i16 119, i16 120, i16 120, i16 120, i16 120, i16 415, i16 380, i16 261, i16 261, i16 261, i16 261, i16 16, i16 16, i16 970, i16 970, i16 981, i16 984, i16 1226, i16 1226, i16 510, i16 525, i16 477, i16 525, i16 528, i16 491, i16 350, i16 236, i16 205, i16 486, i16 356, i16 121, i16 122, i16 112, i16 1132, i16 1132, i16 980, i16 983, i16 973, i16 973, i16 119, i16 119, i16 120, i16 120, i16 120, i16 120, i16 42, i16 42, i16 418, i16 118, i16 118, i16 118, i16 118, i16 117, i16 117, i16 116, i16 116, i16 116, i16 115, i16 409, i16 1452, i16 349, i16 413, i16 1150, i16 1, i16 1, i16 534, i16 3, i16 1154, i16 1454, i16 1185, i16 348, i16 940, i16 286, i16 1081, i16 143, i16 1081, i16 380, i16 940, i16 114, i16 111, i16 208, i16 1234, i16 1440, i16 98, i16 370, i16 164, i16 974, i16 409, i16 118, i16 118, i16 118, i16 118, i16 117, i16 117, i16 116, i16 116, i16 116, i16 115, i16 409, i16 1109, i16 121, i16 122, i16 112, i16 1132, i16 1132, i16 980, i16 983, i16 973, i16 973, i16 119, i16 119, i16 120, i16 120, i16 120, i16 120, i16 261, i16 261, i16 228, i16 261, i16 261, i16 463, i16 460, i16 459, i16 306, i16 423, i16 296, i16 123, i16 435, i16 525, i16 306, i16 458, i16 525, i16 177, i16 1452, i16 499, i16 116, i16 116, i16 116, i16 115, i16 409, i16 285, i16 519, i16 218, i16 1221, i16 335, i16 1200, i16 380, i16 431, i16 120, i16 120, i16 120, i16 120, i16 113, i16 1221, i16 1109, i16 1110, i16 1111, i16 794, i16 118, i16 118, i16 118, i16 118, i16 117, i16 117, i16 116, i16 116, i16 116, i16 115, i16 409, i16 1109, i16 121, i16 122, i16 112, i16 1132, i16 1132, i16 980, i16 983, i16 973, i16 973, i16 119, i16 119, i16 120, i16 120, i16 120, i16 120, i16 380, i16 351, i16 12, i16 83, i16 1109, i16 81, i16 142, i16 256, i16 1109, i16 80, i16 118, i16 118, i16 118, i16 118, i16 117, i16 117, i16 116, i16 116, i16 116, i16 115, i16 409, i16 169, i16 426, i16 307, i16 121, i16 122, i16 112, i16 1132, i16 1132, i16 980, i16 983, i16 973, i16 973, i16 119, i16 119, i16 120, i16 120, i16 120, i16 120, i16 1109, i16 1110, i16 1111, i16 1497, i16 118, i16 118, i16 118, i16 118, i16 117, i16 117, i16 116, i16 116, i16 116, i16 115, i16 409, i16 114, i16 111, i16 208, i16 528, i16 1109, i16 1109, i16 1110, i16 1111, i16 1491, i16 1109, i16 1110, i16 1111, i16 114, i16 111, i16 208, i16 380, i16 1193, i16 183, i16 1003, i16 321, i16 120, i16 120, i16 120, i16 120, i16 440, i16 71, i16 71, i16 487, i16 118, i16 118, i16 118, i16 118, i16 117, i16 117, i16 116, i16 116, i16 116, i16 115, i16 409, i16 121, i16 122, i16 112, i16 1132, i16 1132, i16 980, i16 983, i16 973, i16 973, i16 119, i16 119, i16 120, i16 120, i16 120, i16 120, i16 380, i16 1379, i16 1468, i16 1109, i16 464, i16 1109, i16 1110, i16 1111, i16 281, i16 522, i16 522, i16 522, i16 97, i16 118, i16 118, i16 118, i16 118, i16 117, i16 117, i16 116, i16 116, i16 116, i16 115, i16 409, i16 121, i16 122, i16 112, i16 1132, i16 1132, i16 980, i16 983, i16 973, i16 973, i16 119, i16 119, i16 120, i16 120, i16 120, i16 120, i16 1392, i16 1334, i16 203, i16 473, i16 118, i16 118, i16 118, i16 118, i16 117, i16 117, i16 116, i16 116, i16 116, i16 115, i16 409, i16 164, i16 12, i16 1392, i16 1394, i16 1109, i16 1110, i16 1111, i16 228, i16 1076, i16 215, i16 463, i16 460, i16 459, i16 319, i16 488, i16 380, i16 334, i16 1465, i16 399, i16 816, i16 458, i16 1076, i16 239, i16 325, i16 1076, i16 407, i16 407, i16 407, i16 118, i16 118, i16 118, i16 118, i16 117, i16 117, i16 116, i16 116, i16 116, i16 115, i16 409, i16 121, i16 122, i16 112, i16 1132, i16 1132, i16 980, i16 983, i16 973, i16 973, i16 119, i16 119, i16 120, i16 120, i16 120, i16 120, i16 380, i16 285, i16 519, i16 1130, i16 809, i16 164, i16 235, i16 118, i16 118, i16 118, i16 118, i16 117, i16 117, i16 116, i16 116, i16 116, i16 115, i16 409, i16 189, i16 1392, i16 314, i16 178, i16 317, i16 425, i16 121, i16 122, i16 112, i16 1132, i16 1132, i16 980, i16 983, i16 973, i16 973, i16 119, i16 119, i16 120, i16 120, i16 120, i16 120, i16 382, i16 466, i16 1076, i16 419, i16 118, i16 118, i16 118, i16 118, i16 117, i16 117, i16 116, i16 116, i16 116, i16 115, i16 409, i16 1076, i16 527, i16 396, i16 1076, i16 1109, i16 1130, i16 285, i16 519, i16 247, i16 264, i16 333, i16 469, i16 328, i16 468, i16 233, i16 380, i16 217, i16 812, i16 336, i16 1094, i16 324, i16 117, i16 117, i16 116, i16 116, i16 116, i16 115, i16 409, i16 118, i16 118, i16 118, i16 118, i16 117, i16 117, i16 116, i16 116, i16 116, i16 115, i16 409, i16 121, i16 122, i16 112, i16 1132, i16 1132, i16 980, i16 983, i16 973, i16 973, i16 119, i16 119, i16 120, i16 120, i16 120, i16 120, i16 380, i16 1076, i16 394, i16 960, i16 961, i16 1109, i16 1110, i16 1111, i16 285, i16 519, i16 1109, i16 444, i16 495, i16 163, i16 1076, i16 441, i16 347, i16 1076, i16 812, i16 951, i16 450, i16 505, i16 163, i16 950, i16 121, i16 122, i16 112, i16 1132, i16 1132, i16 980, i16 983, i16 973, i16 973, i16 119, i16 119, i16 120, i16 120, i16 120, i16 120, i16 528, i16 1333, i16 1224, i16 1224, i16 118, i16 118, i16 118, i16 118, i16 117, i16 117, i16 116, i16 116, i16 116, i16 115, i16 409, i16 950, i16 950, i16 952, i16 528, i16 877, i16 115, i16 409, i16 13, i16 13, i16 293, i16 1422, i16 1109, i16 1110, i16 1111, i16 494, i16 380, i16 334, i16 1465, i16 526, i16 945, i16 866, i16 866, i16 388, i16 439, i16 32, i16 71, i16 71, i16 490, i16 118, i16 118, i16 118, i16 118, i16 117, i16 117, i16 116, i16 116, i16 116, i16 115, i16 409, i16 121, i16 122, i16 112, i16 1132, i16 1132, i16 980, i16 983, i16 973, i16 973, i16 119, i16 119, i16 120, i16 120, i16 120, i16 120, i16 380, i16 433, i16 284, i16 1471, i16 534, i16 3, i16 1154, i16 1109, i16 510, i16 474, i16 1446, i16 286, i16 378, i16 143, i16 6, i16 506, i16 1439, i16 509, i16 503, i16 1446, i16 1234, i16 508, i16 336, i16 6, i16 121, i16 122, i16 112, i16 1132, i16 1132, i16 980, i16 983, i16 973, i16 973, i16 119, i16 119, i16 120, i16 120, i16 120, i16 120, i16 137, i16 5, i16 206, i16 1387, i16 118, i16 118, i16 118, i16 118, i16 117, i16 117, i16 116, i16 116, i16 116, i16 115, i16 409, i16 261, i16 261, i16 528, i16 255, i16 255, i16 533, i16 401, i16 1154, i16 1109, i16 1110, i16 1111, i16 270, i16 286, i16 525, i16 143, i16 380, i16 525, i16 406, i16 405, i16 335, i16 267, i16 1234, i16 335, i16 1109, i16 71, i16 71, i16 832, i16 218, i16 118, i16 118, i16 118, i16 118, i16 117, i16 117, i16 116, i16 116, i16 116, i16 115, i16 409, i16 121, i16 122, i16 112, i16 1132, i16 1132, i16 980, i16 983, i16 973, i16 973, i16 119, i16 119, i16 120, i16 120, i16 120, i16 120, i16 528, i16 261, i16 261, i16 467, i16 380, i16 355, i16 1023, i16 510, i16 1139, i16 192, i16 1139, i16 833, i16 145, i16 450, i16 525, i16 141, i16 475, i16 258, i16 1109, i16 1434, i16 896, i16 368, i16 71, i16 71, i16 1109, i16 1110, i16 1111, i16 1109, i16 218, i16 100, i16 112, i16 1132, i16 1132, i16 980, i16 983, i16 973, i16 973, i16 119, i16 119, i16 120, i16 120, i16 120, i16 120, i16 118, i16 118, i16 118, i16 118, i16 117, i16 117, i16 116, i16 116, i16 116, i16 115, i16 409, i16 211, i16 1044, i16 528, i16 1386, i16 433, i16 282, i16 960, i16 1028, i16 1028, i16 447, i16 386, i16 397, i16 1319, i16 511, i16 1444, i16 357, i16 1045, i16 353, i16 6, i16 1109, i16 1110, i16 1111, i16 951, i16 414, i16 71, i16 71, i16 950, i16 528, i16 1109, i16 1110, i16 1111, i16 1046, i16 118, i16 118, i16 118, i16 118, i16 117, i16 117, i16 116, i16 116, i16 116, i16 115, i16 409, i16 125, i16 103, i16 1147, i16 898, i16 261, i16 261, i16 71, i16 71, i16 192, i16 852, i16 528, i16 386, i16 897, i16 207, i16 950, i16 950, i16 952, i16 525, i16 510, i16 853, i16 379, i16 380, i16 262, i16 262, i16 426, i16 307, i16 193, i16 512, i16 782, i16 783, i16 784, i16 386, i16 55, i16 55, i16 271, i16 525, i16 295, i16 450, i16 896, i16 390, i16 528, i16 380, i16 275, i16 404, i16 275, i16 121, i16 122, i16 112, i16 1132, i16 1132, i16 980, i16 983, i16 973, i16 973, i16 119, i16 119, i16 120, i16 120, i16 120, i16 120, i16 1445, i16 380, i16 56, i16 56, i16 6, i16 121, i16 122, i16 112, i16 1132, i16 1132, i16 980, i16 983, i16 973, i16 973, i16 119, i16 119, i16 120, i16 120, i16 120, i16 120, i16 268, i16 1233, i16 2, i16 377, i16 376, i16 121, i16 110, i16 112, i16 1132, i16 1132, i16 980, i16 983, i16 973, i16 973, i16 119, i16 119, i16 120, i16 120, i16 120, i16 120, i16 269, i16 285, i16 519, i16 118, i16 118, i16 118, i16 118, i16 117, i16 117, i16 116, i16 116, i16 116, i16 115, i16 409, i16 1109, i16 528, i16 439, i16 528, i16 9, i16 1109, i16 239, i16 1113, i16 450, i16 118, i16 118, i16 118, i16 118, i16 117, i16 117, i16 116, i16 116, i16 116, i16 115, i16 409, i16 528, i16 420, i16 528, i16 15, i16 15, i16 13, i16 13, i16 471, i16 528, i16 118, i16 118, i16 118, i16 118, i16 117, i16 117, i16 116, i16 116, i16 116, i16 115, i16 409, i16 393, i16 1130, i16 44, i16 44, i16 57, i16 57, i16 406, i16 405, i16 1431, i16 380, i16 13, i16 13, i16 1229, i16 872, i16 1136, i16 1109, i16 1110, i16 1111, i16 871, i16 1138, i16 1109, i16 1110, i16 1111, i16 1113, i16 439, i16 395, i16 294, i16 1137, i16 450, i16 455, i16 335, i16 104, i16 528, i16 102, i16 122, i16 112, i16 1132, i16 1132, i16 980, i16 983, i16 973, i16 973, i16 119, i16 119, i16 120, i16 120, i16 120, i16 120, i16 528, i16 433, i16 1109, i16 1139, i16 528, i16 1139, i16 13, i16 13, i16 232, i16 1130, i16 305, i16 109, i16 261, i16 261, i16 107, i16 520, i16 140, i16 4, i16 38, i16 1076, i16 1319, i16 274, i16 13, i16 13, i16 312, i16 525, i16 13, i16 13, i16 1319, i16 144, i16 502, i16 523, i16 1076, i16 528, i16 911, i16 1076, i16 288, i16 186, i16 528, i16 896, i16 528, i16 187, i16 912, i16 118, i16 118, i16 118, i16 118, i16 117, i16 117, i16 116, i16 116, i16 116, i16 115, i16 409, i16 410, i16 13, i16 13, i16 1109, i16 1110, i16 1111, i16 71, i16 71, i16 58, i16 58, i16 107, i16 520, i16 517, i16 4, i16 304, i16 289, i16 507, i16 1232, i16 273, i16 528, i16 272, i16 383, i16 164, i16 437, i16 1172, i16 1443, i16 501, i16 523, i16 1496, i16 6, i16 1025, i16 841, i16 493, i16 478, i16 1025, i16 481, i16 391, i16 324, i16 513, i16 8, i16 960, i16 59, i16 59, i16 408, i16 392, i16 500, i16 105, i16 105, i16 261, i16 261, i16 410, i16 261, i16 261, i16 106, i16 1087, i16 410, i16 530, i16 529, i16 261, i16 261, i16 950, i16 525, i16 517, i16 301, i16 525, i16 528, i16 445, i16 261, i16 261, i16 261, i16 261, i16 525, i16 261, i16 261, i16 508, i16 207, i16 497, i16 285, i16 519, i16 528, i16 525, i16 496, i16 525, i16 260, i16 205, i16 525, i16 528, i16 60, i16 60, i16 528, i16 960, i16 950, i16 950, i16 952, i16 953, i16 27, i16 105, i16 105, i16 528, i16 1319, i16 896, i16 61, i16 61, i16 106, i16 1087, i16 410, i16 530, i16 529, i16 62, i16 62, i16 950, i16 45, i16 45, i16 107, i16 520, i16 528, i16 4, i16 528, i16 438, i16 1044, i16 46, i16 46, i16 1175, i16 384, i16 298, i16 292, i16 300, i16 231, i16 230, i16 229, i16 523, i16 1442, i16 528, i16 1270, i16 1045, i16 6, i16 30, i16 47, i16 47, i16 49, i16 49, i16 950, i16 950, i16 952, i16 953, i16 27, i16 1470, i16 1098, i16 412, i16 1046, i16 528, i16 265, i16 1238, i16 410, i16 50, i16 50, i16 366, i16 366, i16 365, i16 250, i16 363, i16 97, i16 1319, i16 791, i16 525, i16 517, i16 528, i16 31, i16 528, i16 446, i16 516, i16 1129, i16 63, i16 63, i16 528, i16 232, i16 212, i16 872, i16 291, i16 497, i16 428, i16 528, i16 871, i16 1022, i16 498, i16 1022, i16 290, i16 201, i16 64, i16 64, i16 65, i16 65, i16 528, i16 960, i16 1459, i16 528, i16 14, i16 14, i16 1269, i16 105, i16 105, i16 139, i16 937, i16 66, i16 66, i16 299, i16 106, i16 528, i16 410, i16 530, i16 529, i16 528, i16 422, i16 950, i16 127, i16 127, i16 214, i16 67, i16 67, i16 303, i16 107, i16 520, i16 97, i16 4, i16 156, i16 1411, i16 17, i16 158, i16 528, i16 52, i16 52, i16 528, i16 402, i16 68, i16 68, i16 528, i16 1204, i16 523, i16 804, i16 528, i16 819, i16 528, i16 383, i16 213, i16 950, i16 950, i16 952, i16 953, i16 27, i16 1410, i16 69, i16 69, i16 528, i16 53, i16 53, i16 831, i16 830, i16 151, i16 151, i16 823, i16 410, i16 152, i16 152, i16 76, i16 76, i16 427, i16 528, i16 521, i16 384, i16 1010, i16 528, i16 1021, i16 517, i16 1021, i16 54, i16 54, i16 528, i16 381, i16 442, i16 528, i16 309, i16 528, i16 285, i16 519, i16 1266, i16 196, i16 497, i16 528, i16 72, i16 72, i16 954, i16 496, i16 128, i16 128, i16 804, i16 263, i16 819, i16 313, i16 73, i16 73, i16 960, i16 129, i16 129, i16 130, i16 130, i16 416, i16 105, i16 105, i16 95, i16 126, i16 126, i16 838, i16 839, i16 106, i16 528, i16 410, i16 530, i16 529, i16 1098, i16 412, i16 950, i16 316, i16 265, i16 942, i16 1203, i16 1010, i16 238, i16 366, i16 366, i16 365, i16 250, i16 363, i16 432, i16 318, i16 791, i16 238, i16 150, i16 150, i16 528, i16 107, i16 520, i16 528, i16 4, i16 528, i16 320, i16 528, i16 954, i16 212, i16 1217, i16 291, i16 1257, i16 950, i16 950, i16 952, i16 953, i16 27, i16 523, i16 290, i16 528, i16 1202, i16 149, i16 149, i16 528, i16 134, i16 134, i16 133, i16 133, i16 131, i16 131, i16 107, i16 520, i16 528, i16 4, i16 332, i16 528, i16 914, i16 915, i16 1201, i16 528, i16 410, i16 132, i16 132, i16 528, i16 331, i16 75, i16 75, i16 523, i16 214, i16 327, i16 434, i16 280, i16 517, i16 238, i16 77, i16 77, i16 156, i16 74, i16 74, i16 158, i16 869, i16 43, i16 43, i16 109, i16 308, i16 48, i16 48, i16 97, i16 337, i16 456, i16 410, i16 322, i16 234, i16 1484, i16 97, i16 213, i16 1006, i16 338, i16 905, i16 234, i16 960, i16 238, i16 517, i16 1278, i16 1318, i16 1253, i16 105, i16 105, i16 876, i16 802, i16 1264, i16 870, i16 138, i16 106, i16 109, i16 410, i16 530, i16 529, i16 514, i16 515, i16 950, i16 1324, i16 99, i16 520, i16 451, i16 4, i16 1182, i16 1174, i16 1163, i16 381, i16 960, i16 1162, i16 1164, i16 1478, i16 285, i16 519, i16 105, i16 105, i16 253, i16 523, i16 195, i16 210, i16 1250, i16 106, i16 340, i16 410, i16 530, i16 529, i16 342, i16 11, i16 950, i16 950, i16 950, i16 952, i16 953, i16 27, i16 344, i16 416, i16 198, i16 367, i16 1303, i16 421, i16 410, i16 297, i16 302, i16 1311, i16 372, i16 436, i16 461, i16 202, i16 1200, i16 330, i16 1383, i16 1382, i16 517, i16 190, i16 346, i16 191, i16 518, i16 197, i16 360, i16 950, i16 950, i16 952, i16 953, i16 27, i16 1481, i16 1147, i16 242, i16 1430, i16 165, i16 1428, i16 1144, i16 385, i16 83, i16 430, i16 1388, i16 79, i16 175, i16 1308, i16 82, i16 161, i16 960, i16 167, i16 1300, i16 95, i16 424, i16 170, i16 105, i16 105, i16 35, i16 171, i16 172, i16 371, i16 173, i16 106, i16 36, i16 410, i16 530, i16 529, i16 1314, i16 179, i16 950, i16 265, i16 369, i16 429, i16 443, i16 1377, i16 366, i16 366, i16 365, i16 250, i16 363, i16 454, i16 222, i16 791, i16 88, i16 449, i16 1399, i16 254, i16 224, i16 184, i16 311, i16 452, i16 315, i16 225, i16 470, i16 1165, i16 212, i16 226, i16 291, i16 374, i16 90, i16 950, i16 950, i16 952, i16 953, i16 27, i16 290, i16 398, i16 1211, i16 1495, i16 823, i16 1494, i16 203, i16 1220, i16 1219, i16 1464, i16 1218, i16 1261, i16 400, i16 278, i16 375, i16 1190, i16 1189, i16 329, i16 489, i16 1188, i16 1493, i16 279, i16 94, i16 339, i16 241, i16 480, i16 1262, i16 1210, i16 483, i16 341, i16 214, i16 1260, i16 1259, i16 343, i16 345, i16 240, i16 403, i16 124, i16 156, i16 10, i16 508, i16 158, i16 1285, i16 1450, i16 1449, i16 354, i16 492, i16 101, i16 96, i16 248, i16 1171, i16 34, i16 531, i16 1363, i16 1104, i16 249, i16 251, i16 213, i16 1243, i16 252, i16 352, i16 359, i16 194, i16 1242, i16 358, i16 532, i16 1160, i16 1155, i16 1415, i16 153, i16 1416, i16 1284, i16 1414, i16 154, i16 136, i16 276, i16 1413, i16 778, i16 411, i16 199, i16 287, i16 200, i16 78, i16 155, i16 209, i16 266, i16 283, i16 135, i16 1020, i16 1018, i16 934, i16 381, i16 166, i16 157, i16 216, i16 168, i16 285, i16 519, i16 855, i16 1034, i16 938, i16 159, i16 174, i16 387, i16 389, i16 84, i16 176, i16 85, i16 86, i16 87, i16 160, i16 1037, i16 1033, i16 219, i16 220, i16 146, i16 18, i16 221, i16 1026, i16 416, i16 1141, i16 310, i16 238, i16 448, i16 223, i16 180, i16 181, i16 37, i16 793, i16 331, i16 227, i16 453, i16 323, i16 465, i16 834, i16 182, i16 89, i16 19, i16 20, i16 457, i16 821, i16 462, i16 326, i16 91, i16 277, i16 147, i16 92, i16 472, i16 479, i16 1092, i16 148, i16 986, i16 904, i16 1062, i16 162, i16 93, i16 39, i16 482, i16 1063, i16 40, i16 204, i16 257, i16 259, i16 185, i16 899, i16 237, i16 109, i16 1082, i16 1078, i16 1080, i16 21, i16 1066, i16 1086, i16 33, i16 504, i16 188, i16 22, i16 23, i16 24, i16 1085, i16 25, i16 97, i16 1001, i16 987, i16 985, i16 989, i16 26, i16 1043, i16 244, i16 7, i16 1042, i16 243, i16 990, i16 28, i16 41, i16 524, i16 955, i16 803, i16 108, i16 29, i16 245, i16 865, i16 246, i16 1486, i16 364, i16 361, i16 1100, i16 1099, i16 1151, i16 1151, i16 1151, i16 1151, i16 1151, i16 1151, i16 1151, i16 1485], align 16
@yy_default = internal unnamed_addr constant [535 x i16] [i16 1523, i16 1523, i16 1372, i16 1523, i16 1149, i16 1258, i16 1149, i16 1149, i16 1149, i16 1372, i16 1372, i16 1372, i16 1149, i16 1288, i16 1288, i16 1425, i16 1180, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1371, i16 1149, i16 1149, i16 1149, i16 1149, i16 1448, i16 1448, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1297, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1373, i16 1374, i16 1149, i16 1149, i16 1149, i16 1424, i16 1426, i16 1389, i16 1307, i16 1306, i16 1305, i16 1304, i16 1407, i16 1275, i16 1302, i16 1295, i16 1299, i16 1367, i16 1368, i16 1366, i16 1370, i16 1374, i16 1373, i16 1149, i16 1298, i16 1338, i16 1352, i16 1337, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1346, i16 1351, i16 1357, i16 1350, i16 1347, i16 1340, i16 1339, i16 1341, i16 1342, i16 1149, i16 1222, i16 1149, i16 1149, i16 1149, i16 1149, i16 1436, i16 1435, i16 1170, i16 1149, i16 1149, i16 1180, i16 1332, i16 1331, i16 1343, i16 1344, i16 1354, i16 1353, i16 1432, i16 1483, i16 1482, i16 1390, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1448, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1448, i16 1448, i16 1149, i16 1180, i16 1448, i16 1448, i16 1176, i16 1176, i16 1282, i16 1149, i16 1258, i16 1249, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1429, i16 1427, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1254, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1477, i16 1149, i16 1402, i16 1236, i16 1254, i16 1254, i16 1254, i16 1254, i16 1256, i16 1237, i16 1235, i16 1248, i16 1181, i16 1156, i16 1521, i16 1301, i16 1277, i16 1277, i16 1518, i16 1301, i16 1301, i16 1518, i16 1197, i16 1499, i16 1192, i16 1288, i16 1288, i16 1288, i16 1277, i16 1282, i16 1282, i16 1369, i16 1255, i16 1248, i16 1149, i16 1521, i16 1263, i16 1263, i16 1520, i16 1520, i16 1263, i16 1390, i16 1310, i16 1316, i16 1225, i16 1301, i16 1231, i16 1231, i16 1231, i16 1231, i16 1301, i16 1301, i16 1310, i16 1316, i16 1225, i16 1225, i16 1301, i16 1263, i16 1167, i16 1406, i16 1515, i16 1263, i16 1167, i16 1380, i16 1263, i16 1167, i16 1263, i16 1167, i16 1380, i16 1223, i16 1223, i16 1223, i16 1212, i16 1149, i16 1149, i16 1380, i16 1223, i16 1197, i16 1223, i16 1212, i16 1223, i16 1223, i16 1466, i16 1380, i16 1384, i16 1384, i16 1380, i16 1281, i16 1276, i16 1281, i16 1276, i16 1281, i16 1276, i16 1281, i16 1276, i16 1263, i16 1458, i16 1458, i16 1291, i16 1291, i16 1296, i16 1282, i16 1375, i16 1263, i16 1149, i16 1296, i16 1294, i16 1292, i16 1301, i16 1173, i16 1215, i16 1480, i16 1480, i16 1476, i16 1476, i16 1476, i16 1492, i16 1180, i16 1180, i16 1180, i16 1180, i16 1492, i16 1199, i16 1199, i16 1181, i16 1181, i16 1180, i16 1492, i16 1149, i16 1149, i16 1149, i16 1149, i16 1487, i16 1391, i16 1267, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1321, i16 1149, i16 1152, i16 1149, i16 1149, i16 1433, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1268, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1517, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1405, i16 1404, i16 1149, i16 1149, i16 1265, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1195, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1293, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1463, i16 1283, i16 1149, i16 1149, i16 1508, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1149, i16 1503, i16 1239, i16 1323, i16 1149, i16 1322, i16 1326, i16 1149, i16 1161, i16 1149, i16 1149], align 16
@yyRuleInfoNRhs = internal unnamed_addr constant [372 x i8] c"\FF\FD\FF\FD\00\FF\FF\FF\FE\FE\FE\FD\FB\FA\FF\00\FD\FF\00\FB\FE\00\FE\FE\00\FC\FA\FE\00\00\FE\FD\FC\FC\FC\FD\FD\FB\FE\FC\FC\FF\FE\FD\FC\00\FF\00\FE\FE\FD\FD\FD\FE\FE\FF\FF\FE\FD\FE\00\FE\FE\00\FF\FE\F9\FB\FB\F6\00\00\FD\00\FE\FF\FF\FC\FE\00\F7\FC\FF\FD\FC\FF\FD\FF\FE\FF\F7\F6\FC\FB\FF\FF\00\00\FB\FD\FB\FE\00\00\FE\FE\00\F9\F7\F9\F9\00\FE\FF\FD\FF\FD\FB\FD\FF\FE\FD\FC\FE\00\00\FD\FE\FC\00\00\FD\FB\FD\FF\FF\00\FE\FE\00\00\FD\00\FE\00\FE\FC\FC\FA\00\FE\F8\FB\F9\FD\FB\F9\F9\00\F5\F8\FC\FE\FF\00\FD\FD\FF\FD\FF\FF\FD\FB\FF\FF\FF\FF\FD\FA\FB\FC\FA\FB\FF\FB\FD\FD\FD\FD\FD\FD\FD\FD\FE\FD\FB\FE\FD\FD\FC\FE\FE\FE\FF\FE\FB\FF\FE\FB\FD\FB\FB\FC\FB\FB\FC\FE\00\FF\00\00\FD\FF\00\FD\F4\FF\00\00\FD\FB\FD\00\FE\FC\FE\FD\FE\00\FD\FB\FA\FB\FA\FE\FE\FB\F5\FF\FE\00\FF\FF\FD\00\FE\FD\FE\FD\FD\FE\F8\F8\FA\FD\FC\FA\FF\FF\FF\FC\FA\FD\00\FE\FF\FD\FF\FD\FA\F9\FF\F8\FE\FD\FA\F8\FF\FD\FB\FB\FA\FC\FB\FF\FE\00\FD\FA\FF\FF\FE\FF\FE\FE\FE\00\FE\FE\FE\FF\FE\FE\FF\FF\FC\FE\FB\FF\FE\FF\FF\FE\FD\00\FF\FE\FF\00\FE\FC\FE\FF\FF\FF\FF\FF\FF\FF\FE\00\FE\FC\FE\FE\FD\FF\00\FF\FF\FF\FF\FE\FF\FF\FF\FF\FF\FF\FF\FF\FF\FF\00\FD\FF\00\FF\00\00\FF\00", align 16
@.str.373 = private unnamed_addr constant [6 x i8] c"rowid\00", align 1
@.str.374 = private unnamed_addr constant [27 x i8] c"unknown table option: %.*s\00", align 1
@__const.yy_reduce.dest = private unnamed_addr constant %struct.SelectDest { i8 9, i32 0, i32 0, i32 0, i8* null, %struct.ExprList* null }, align 8
@.str.375 = private unnamed_addr constant [9 x i8] c"set list\00", align 1
@.str.376 = private unnamed_addr constant [24 x i8] c"near \22%T\22: syntax error\00", align 1
@.str.377 = private unnamed_addr constant [2 x i8] c"0\00", align 1
@.str.378 = private unnamed_addr constant [95 x i8] c"qualified table names are not allowed on INSERT, UPDATE, and DELETE statements within triggers\00", align 1
@.str.379 = private unnamed_addr constant [84 x i8] c"the INDEXED BY clause is not allowed on UPDATE or DELETE statements within triggers\00", align 1
@.str.380 = private unnamed_addr constant [85 x i8] c"the NOT INDEXED clause is not allowed on UPDATE or DELETE statements within triggers\00", align 1
@yyRuleInfoLhs = internal unnamed_addr constant [372 x i16] [i16 185, i16 185, i16 184, i16 186, i16 187, i16 187, i16 187, i16 187, i16 186, i16 186, i16 186, i16 186, i16 186, i16 191, i16 193, i16 195, i16 195, i16 194, i16 194, i16 192, i16 192, i16 199, i16 199, i16 201, i16 203, i16 203, i16 203, i16 204, i16 208, i16 209, i16 210, i16 210, i16 210, i16 210, i16 210, i16 210, i16 210, i16 210, i16 210, i16 210, i16 210, i16 210, i16 210, i16 219, i16 219, i16 215, i16 215, i16 217, i16 217, i16 220, i16 220, i16 220, i16 220, i16 221, i16 221, i16 221, i16 221, i16 221, i16 218, i16 218, i16 222, i16 222, i16 222, i16 198, i16 224, i16 225, i16 225, i16 225, i16 225, i16 225, i16 228, i16 213, i16 213, i16 229, i16 229, i16 230, i16 230, i16 186, i16 232, i16 232, i16 186, i16 186, i16 186, i16 200, i16 200, i16 200, i16 234, i16 237, i16 237, i16 237, i16 235, i16 235, i16 247, i16 247, i16 238, i16 238, i16 238, i16 249, i16 239, i16 239, i16 239, i16 250, i16 250, i16 240, i16 240, i16 252, i16 252, i16 251, i16 251, i16 251, i16 251, i16 196, i16 196, i16 233, i16 233, i16 258, i16 258, i16 258, i16 258, i16 253, i16 253, i16 253, i16 253, i16 255, i16 255, i16 254, i16 254, i16 254, i16 256, i16 256, i16 244, i16 244, i16 226, i16 226, i16 214, i16 214, i16 214, i16 260, i16 260, i16 260, i16 242, i16 242, i16 243, i16 243, i16 245, i16 245, i16 245, i16 245, i16 186, i16 241, i16 241, i16 186, i16 262, i16 262, i16 262, i16 262, i16 186, i16 186, i16 265, i16 265, i16 265, i16 265, i16 263, i16 263, i16 264, i16 264, i16 259, i16 259, i16 212, i16 212, i16 212, i16 212, i16 212, i16 211, i16 211, i16 211, i16 212, i16 212, i16 212, i16 212, i16 212, i16 212, i16 212, i16 211, i16 212, i16 212, i16 212, i16 212, i16 212, i16 212, i16 212, i16 212, i16 212, i16 267, i16 212, i16 212, i16 212, i16 212, i16 212, i16 212, i16 212, i16 212, i16 212, i16 268, i16 268, i16 212, i16 269, i16 269, i16 212, i16 212, i16 212, i16 212, i16 212, i16 212, i16 272, i16 272, i16 273, i16 273, i16 271, i16 271, i16 257, i16 248, i16 248, i16 270, i16 270, i16 186, i16 274, i16 274, i16 216, i16 216, i16 227, i16 227, i16 275, i16 275, i16 186, i16 186, i16 186, i16 276, i16 276, i16 186, i16 186, i16 186, i16 186, i16 186, i16 206, i16 207, i16 186, i16 278, i16 280, i16 280, i16 280, i16 281, i16 281, i16 281, i16 283, i16 283, i16 279, i16 279, i16 285, i16 286, i16 286, i16 284, i16 284, i16 284, i16 284, i16 212, i16 212, i16 231, i16 231, i16 231, i16 186, i16 186, i16 186, i16 288, i16 288, i16 186, i16 186, i16 186, i16 186, i16 186, i16 186, i16 289, i16 186, i16 261, i16 261, i16 236, i16 236, i16 291, i16 291, i16 292, i16 293, i16 293, i16 293, i16 293, i16 293, i16 293, i16 294, i16 294, i16 294, i16 298, i16 300, i16 300, i16 301, i16 301, i16 299, i16 299, i16 302, i16 302, i16 303, i16 303, i16 303, i16 246, i16 266, i16 266, i16 266, i16 297, i16 297, i16 296, i16 181, i16 182, i16 182, i16 183, i16 183, i16 183, i16 188, i16 188, i16 188, i16 190, i16 190, i16 186, i16 197, i16 197, i16 189, i16 189, i16 189, i16 203, i16 204, i16 205, i16 205, i16 202, i16 202, i16 210, i16 210, i16 210, i16 198, i16 223, i16 223, i16 224, i16 228, i16 230, i16 234, i16 235, i16 249, i16 250, i16 212, i16 267, i16 257, i16 277, i16 277, i16 277, i16 277, i16 277, i16 206, i16 282, i16 282, i16 285, i16 286, i16 287, i16 287, i16 290, i16 290, i16 261], align 16
@.str.381 = private unnamed_addr constant [22 x i8] c"parser stack overflow\00", align 1
@sqlite3VdbeGetOp.dummy = internal global %struct.VdbeOp zeroinitializer, align 8
@sqlite3AutoincrementBegin.autoInc = internal constant [12 x %struct.VdbeOpList] [%struct.VdbeOpList { i8 72, i8 0, i8 0, i8 0 }, %struct.VdbeOpList { i8 37, i8 0, i8 10, i8 0 }, %struct.VdbeOpList { i8 89, i8 0, i8 0, i8 0 }, %struct.VdbeOpList { i8 52, i8 0, i8 9, i8 0 }, %struct.VdbeOpList { i8 127, i8 0, i8 0, i8 0 }, %struct.VdbeOpList { i8 89, i8 0, i8 1, i8 0 }, %struct.VdbeOpList { i8 82, i8 0, i8 0, i8 0 }, %struct.VdbeOpList { i8 77, i8 0, i8 0, i8 0 }, %struct.VdbeOpList { i8 11, i8 0, i8 11, i8 0 }, %struct.VdbeOpList { i8 5, i8 0, i8 2, i8 0 }, %struct.VdbeOpList { i8 69, i8 0, i8 0, i8 0 }, %struct.VdbeOpList { i8 116, i8 0, i8 0, i8 0 }], align 16
@.str.382 = private unnamed_addr constant [31 x i8] c"no such collation sequence: %s\00", align 1
@sqlite3ExprCodeTarget.zAff = internal constant [8 x i8] c"B\00C\00D\00E\00", align 1
@.str.383 = private unnamed_addr constant [30 x i8] c"generated column loop on \22%s\22\00", align 1
@.str.384 = private unnamed_addr constant [26 x i8] c"misuse of aggregate: %s()\00", align 1
@.str.385 = private unnamed_addr constant [23 x i8] c"unknown function: %s()\00", align 1
@.str.386 = private unnamed_addr constant [30 x i8] c"%d columns assigned %d values\00", align 1
@.str.387 = private unnamed_addr constant [18 x i8] c"row value misused\00", align 1
@.str.388 = private unnamed_addr constant [50 x i8] c"RAISE() may only be used within a trigger-program\00", align 1
@.str.389 = private unnamed_addr constant [5 x i8] c"%s%s\00", align 1
@.str.390 = private unnamed_addr constant [3 x i8] c"0x\00", align 1
@.str.391 = private unnamed_addr constant [26 x i8] c"hex literal too big: %s%s\00", align 1
@.str.392 = private unnamed_addr constant [19 x i8] c"unsafe use of %s()\00", align 1
@.str.393 = private unnamed_addr constant [44 x i8] c"sub-select returns %d columns - expected %d\00", align 1
@.str.394 = private unnamed_addr constant [18 x i8] c"REUSE SUBQUERY %d\00", align 1
@.str.395 = private unnamed_addr constant [21 x i8] c"%sSCALAR SUBQUERY %d\00", align 1
@.str.396 = private unnamed_addr constant [12 x i8] c"CORRELATED \00", align 1
@.str.397 = private unnamed_addr constant [2 x i8] c"E\00", align 1
@.str.398 = private unnamed_addr constant [47 x i8] c"USING ROWID SEARCH ON TABLE %s FOR IN-OPERATOR\00", align 1
@.str.399 = private unnamed_addr constant [31 x i8] c"USING INDEX %s FOR IN-OPERATOR\00", align 1
@.str.400 = private unnamed_addr constant [23 x i8] c"REUSE LIST SUBQUERY %d\00", align 1
@.str.401 = private unnamed_addr constant [19 x i8] c"%sLIST SUBQUERY %d\00", align 1
@.str.402 = private unnamed_addr constant [6 x i8] c"BEGIN\00", align 1
@.str.403 = private unnamed_addr constant [15 x i8] c"not authorized\00", align 1
@.str.404 = private unnamed_addr constant [23 x i8] c"authorizer malfunction\00", align 1
@.str.405 = private unnamed_addr constant [9 x i8] c"ROLLBACK\00", align 1
@.str.406 = private unnamed_addr constant [7 x i8] c"COMMIT\00", align 1
@.str.407 = private unnamed_addr constant [8 x i8] c"RELEASE\00", align 1
@.str.408 = private unnamed_addr constant [41 x i8] c"temporary table name must be unqualified\00", align 1
@.str.409 = private unnamed_addr constant [5 x i8] c"view\00", align 1
@sqlite3StartTable.aCode = internal unnamed_addr constant [4 x i8] c"\02\04\08\06", align 1
@.str.410 = private unnamed_addr constant [24 x i8] c"table %T already exists\00", align 1
@.str.411 = private unnamed_addr constant [35 x i8] c"there is already an index named %s\00", align 1
@.str.412 = private unnamed_addr constant [16 x i8] c"sqlite_sequence\00", align 1
@sqlite3StartTable.nullRow = internal constant [6 x i8] c"\06\00\00\00\00\00", align 1
@.str.413 = private unnamed_addr constant [17 x i8] c"corrupt database\00", align 1
@.str.414 = private unnamed_addr constant [20 x i8] c"unknown database %T\00", align 1
@.str.415 = private unnamed_addr constant [8 x i8] c"sqlite_\00", align 1
@.str.416 = private unnamed_addr constant [42 x i8] c"object name reserved for internal use: %s\00", align 1
@.str.417 = private unnamed_addr constant [50 x i8] c"AUTOINCREMENT not allowed on WITHOUT ROWID tables\00", align 1
@.str.418 = private unnamed_addr constant [32 x i8] c"PRIMARY KEY missing on table %s\00", align 1
@.str.419 = private unnamed_addr constant [44 x i8] c"must have at least one non-generated column\00", align 1
@.str.420 = private unnamed_addr constant [6 x i8] c"TABLE\00", align 1
@.str.421 = private unnamed_addr constant [5 x i8] c"VIEW\00", align 1
@.str.422 = private unnamed_addr constant [15 x i8] c"CREATE %s %.*s\00", align 1
@.str.423 = private unnamed_addr constant [87 x i8] c"UPDATE %Q.%s SET type='%s', name=%Q, tbl_name=%Q, rootpage=#%d, sql=%Q WHERE rowid=#%d\00", align 1
@.str.424 = private unnamed_addr constant [42 x i8] c"CREATE TABLE %Q.sqlite_sequence(name,seq)\00", align 1
@.str.425 = private unnamed_addr constant [34 x i8] c"tbl_name='%q' AND type!='trigger'\00", align 1
@.str.426 = private unnamed_addr constant [17 x i8] c"the \22.\22 operator\00", align 1
@.str.427 = private unnamed_addr constant [71 x i8] c"second argument to likelihood() must be a constant between 0.0 and 1.0\00", align 1
@.str.428 = private unnamed_addr constant [35 x i8] c"not authorized to use function: %s\00", align 1
@.str.429 = private unnamed_addr constant [28 x i8] c"non-deterministic functions\00", align 1
@.str.430 = private unnamed_addr constant [44 x i8] c"%.*s() may not be used as a window function\00", align 1
@.str.431 = private unnamed_addr constant [7 x i8] c"window\00", align 1
@.str.432 = private unnamed_addr constant [10 x i8] c"aggregate\00", align 1
@.str.433 = private unnamed_addr constant [29 x i8] c"misuse of %s function %.*s()\00", align 1
@.str.434 = private unnamed_addr constant [23 x i8] c"no such function: %.*s\00", align 1
@.str.435 = private unnamed_addr constant [45 x i8] c"wrong number of arguments to function %.*s()\00", align 1
@.str.436 = private unnamed_addr constant [49 x i8] c"FILTER may not be used with non-aggregate %.*s()\00", align 1
@.str.437 = private unnamed_addr constant [11 x i8] c"subqueries\00", align 1
@.str.438 = private unnamed_addr constant [11 x i8] c"parameters\00", align 1
@.str.439 = private unnamed_addr constant [28 x i8] c"partial index WHERE clauses\00", align 1
@.str.440 = private unnamed_addr constant [18 x i8] c"index expressions\00", align 1
@.str.441 = private unnamed_addr constant [18 x i8] c"CHECK constraints\00", align 1
@.str.442 = private unnamed_addr constant [18 x i8] c"generated columns\00", align 1
@.str.443 = private unnamed_addr constant [20 x i8] c"%s prohibited in %s\00", align 1
@.str.444 = private unnamed_addr constant [4 x i8] c"new\00", align 1
@.str.445 = private unnamed_addr constant [4 x i8] c"old\00", align 1
@.str.446 = private unnamed_addr constant [9 x i8] c"excluded\00", align 1
@.str.447 = private unnamed_addr constant [31 x i8] c"misuse of aliased aggregate %s\00", align 1
@.str.448 = private unnamed_addr constant [37 x i8] c"misuse of aliased window function %s\00", align 1
@.str.449 = private unnamed_addr constant [35 x i8] c"double-quoted string literal: \22%w\22\00", align 1
@.str.450 = private unnamed_addr constant [15 x i8] c"no such column\00", align 1
@.str.451 = private unnamed_addr constant [22 x i8] c"ambiguous column name\00", align 1
@.str.452 = private unnamed_addr constant [13 x i8] c"%s: %s.%s.%s\00", align 1
@.str.453 = private unnamed_addr constant [10 x i8] c"%s: %s.%s\00", align 1
@.str.454 = private unnamed_addr constant [7 x i8] c"%s: %s\00", align 1
@.str.455 = private unnamed_addr constant [6 x i8] c"ROWID\00", align 1
@.str.456 = private unnamed_addr constant [6 x i8] c"%s.%s\00", align 1
@.str.457 = private unnamed_addr constant [6 x i8] c"%s.%z\00", align 1
@.str.458 = private unnamed_addr constant [27 x i8] c"access to %z is prohibited\00", align 1
@.str.459 = private unnamed_addr constant [71 x i8] c"RANGE with offset PRECEDING/FOLLOWING requires one ORDER BY expression\00", align 1
@.str.460 = private unnamed_addr constant [63 x i8] c"FILTER clause may only be used with aggregate window functions\00", align 1
@row_numberName = internal constant [11 x i8] c"row_number\00", align 1
@dense_rankName = internal constant [11 x i8] c"dense_rank\00", align 1
@rankName = internal constant [5 x i8] c"rank\00", align 1
@percent_rankName = internal constant [13 x i8] c"percent_rank\00", align 1
@cume_distName = internal constant [10 x i8] c"cume_dist\00", align 1
@ntileName = internal constant [6 x i8] c"ntile\00", align 1
@leadName = internal constant [5 x i8] c"lead\00", align 1
@lagName = internal constant [4 x i8] c"lag\00", align 1
@__const.sqlite3WindowUpdate.aUp = private unnamed_addr constant [8 x %struct.WindowUpdate] [%struct.WindowUpdate { i8* getelementptr inbounds ([11 x i8], [11 x i8]* @row_numberName, i32 0, i32 0), i32 76, i32 90, i32 85 }, %struct.WindowUpdate { i8* getelementptr inbounds ([11 x i8], [11 x i8]* @dense_rankName, i32 0, i32 0), i32 89, i32 90, i32 85 }, %struct.WindowUpdate { i8* getelementptr inbounds ([5 x i8], [5 x i8]* @rankName, i32 0, i32 0), i32 89, i32 90, i32 85 }, %struct.WindowUpdate { i8* getelementptr inbounds ([13 x i8], [13 x i8]* @percent_rankName, i32 0, i32 0), i32 92, i32 85, i32 90 }, %struct.WindowUpdate { i8* getelementptr inbounds ([10 x i8], [10 x i8]* @cume_distName, i32 0, i32 0), i32 92, i32 86, i32 90 }, %struct.WindowUpdate { i8* getelementptr inbounds ([6 x i8], [6 x i8]* @ntileName, i32 0, i32 0), i32 76, i32 85, i32 90 }, %struct.WindowUpdate { i8* getelementptr inbounds ([5 x i8], [5 x i8]* @leadName, i32 0, i32 0), i32 76, i32 90, i32 90 }, %struct.WindowUpdate { i8* getelementptr inbounds ([4 x i8], [4 x i8]* @lagName, i32 0, i32 0), i32 76, i32 90, i32 85 }], align 16
@.str.461 = private unnamed_addr constant [19 x i8] c"no such window: %s\00", align 1
@.str.462 = private unnamed_addr constant [44 x i8] c"a GROUP BY clause is required before HAVING\00", align 1
@.str.463 = private unnamed_addr constant [6 x i8] c"ORDER\00", align 1
@.str.464 = private unnamed_addr constant [6 x i8] c"GROUP\00", align 1
@.str.465 = private unnamed_addr constant [59 x i8] c"aggregate functions are not allowed in the GROUP BY clause\00", align 1
@.str.466 = private unnamed_addr constant [39 x i8] c"too many references to \22%s\22: max 65535\00", align 1
@.str.467 = private unnamed_addr constant [31 x i8] c"access to view \22%s\22 prohibited\00", align 1
@.str.468 = private unnamed_addr constant [2 x i8] c"*\00", align 1
@.str.469 = private unnamed_addr constant [9 x i8] c"%s.%s.%s\00", align 1
@.str.470 = private unnamed_addr constant [18 x i8] c"no such table: %s\00", align 1
@.str.471 = private unnamed_addr constant [20 x i8] c"no tables specified\00", align 1
@.str.472 = private unnamed_addr constant [31 x i8] c"too many columns in result set\00", align 1
@.str.473 = private unnamed_addr constant [43 x i8] c"multiple references to recursive table: %s\00", align 1
@.str.474 = private unnamed_addr constant [23 x i8] c"circular reference: %s\00", align 1
@.str.475 = private unnamed_addr constant [38 x i8] c"table %s has %d values for %d columns\00", align 1
@.str.476 = private unnamed_addr constant [34 x i8] c"multiple recursive references: %s\00", align 1
@.str.477 = private unnamed_addr constant [38 x i8] c"recursive reference in a subquery: %s\00", align 1
@.str.478 = private unnamed_addr constant [9 x i8] c"column%d\00", align 1
@.str.479 = private unnamed_addr constant [8 x i8] c"%.*z:%u\00", align 1
@.str.480 = private unnamed_addr constant [5 x i8] c"true\00", align 1
@.str.481 = private unnamed_addr constant [6 x i8] c"false\00", align 1
@.str.482 = private unnamed_addr constant [12 x i8] c"subquery_%u\00", align 1
@.str.483 = private unnamed_addr constant [23 x i8] c"'%s' is not a function\00", align 1
@.str.484 = private unnamed_addr constant [30 x i8] c"view %s is circularly defined\00", align 1
@.str.485 = private unnamed_addr constant [18 x i8] c"no such index: %s\00", align 1
@.str.486 = private unnamed_addr constant [50 x i8] c"a NATURAL join may not have an ON or USING clause\00", align 1
@.str.487 = private unnamed_addr constant [55 x i8] c"cannot have both ON and USING clauses in the same join\00", align 1
@.str.488 = private unnamed_addr constant [64 x i8] c"cannot join using column %s - column not present in both tables\00", align 1
@.str.489 = private unnamed_addr constant [56 x i8] c"%r %s BY term out of range - should be between 1 and %d\00", align 1
@.str.490 = private unnamed_addr constant [31 x i8] c"too many terms in %s BY clause\00", align 1
@.str.491 = private unnamed_addr constant [46 x i8] c"all VALUES must have the same number of terms\00", align 1
@.str.492 = private unnamed_addr constant [82 x i8] c"SELECTs to the left and right of %s do not have the same number of result columns\00", align 1
@.str.493 = private unnamed_addr constant [10 x i8] c"UNION ALL\00", align 1
@.str.494 = private unnamed_addr constant [10 x i8] c"INTERSECT\00", align 1
@.str.495 = private unnamed_addr constant [7 x i8] c"EXCEPT\00", align 1
@.str.496 = private unnamed_addr constant [6 x i8] c"UNION\00", align 1
@.str.497 = private unnamed_addr constant [34 x i8] c"too many terms in ORDER BY clause\00", align 1
@.str.498 = private unnamed_addr constant [61 x i8] c"%r ORDER BY term does not match any column in the result set\00", align 1
@.str.499 = private unnamed_addr constant [48 x i8] c"Expression tree is too large (maximum depth %d)\00", align 1
@.str.500 = private unnamed_addr constant [2 x i8] c",\00", align 1
@.str.501 = private unnamed_addr constant [4 x i8] c"\0A  \00", align 1
@.str.502 = private unnamed_addr constant [5 x i8] c",\0A  \00", align 1
@.str.503 = private unnamed_addr constant [3 x i8] c"\0A)\00", align 1
@.str.504 = private unnamed_addr constant [14 x i8] c"CREATE TABLE \00", align 1
@createTableStmt.azType = internal unnamed_addr constant [5 x i8*] [i8* getelementptr inbounds ([1 x i8], [1 x i8]* @.str.3, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.505, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.506, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.507, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.508, i32 0, i32 0)], align 16
@.str.505 = private unnamed_addr constant [6 x i8] c" TEXT\00", align 1
@.str.506 = private unnamed_addr constant [5 x i8] c" NUM\00", align 1
@.str.507 = private unnamed_addr constant [5 x i8] c" INT\00", align 1
@.str.508 = private unnamed_addr constant [6 x i8] c" REAL\00", align 1
@.str.509 = private unnamed_addr constant [23 x i8] c"too many columns on %s\00", align 1
@.str.510 = private unnamed_addr constant [26 x i8] c"duplicate column name: %s\00", align 1
@.str.511 = private unnamed_addr constant [45 x i8] c"default value of column [%s] is not constant\00", align 1
@.str.512 = private unnamed_addr constant [41 x i8] c"cannot use DEFAULT on a generated column\00", align 1
@.str.513 = private unnamed_addr constant [41 x i8] c"table \22%s\22 has more than one primary key\00", align 1
@.str.514 = private unnamed_addr constant [56 x i8] c"AUTOINCREMENT is only allowed on an INTEGER PRIMARY KEY\00", align 1
@.str.515 = private unnamed_addr constant [52 x i8] c"generated columns cannot be part of the PRIMARY KEY\00", align 1
@.str.516 = private unnamed_addr constant [28 x i8] c"unsupported use of NULLS %s\00", align 1
@.str.517 = private unnamed_addr constant [6 x i8] c"FIRST\00", align 1
@.str.518 = private unnamed_addr constant [5 x i8] c"LAST\00", align 1
@.str.519 = private unnamed_addr constant [6 x i8] c"index\00", align 1
@.str.520 = private unnamed_addr constant [50 x i8] c"cannot create a TEMP index on non-TEMP table \22%s\22\00", align 1
@.str.521 = private unnamed_addr constant [28 x i8] c"table %s may not be indexed\00", align 1
@.str.522 = private unnamed_addr constant [25 x i8] c"views may not be indexed\00", align 1
@.str.523 = private unnamed_addr constant [34 x i8] c"there is already a table named %s\00", align 1
@.str.524 = private unnamed_addr constant [24 x i8] c"index %s already exists\00", align 1
@.str.525 = private unnamed_addr constant [23 x i8] c"sqlite_autoindex_%s_%d\00", align 1
@.str.526 = private unnamed_addr constant [61 x i8] c"expressions prohibited in PRIMARY KEY and UNIQUE constraints\00", align 1
@.str.527 = private unnamed_addr constant [42 x i8] c"conflicting ON CONFLICT clauses specified\00", align 1
@.str.528 = private unnamed_addr constant [20 x i8] c"CREATE%s INDEX %.*s\00", align 1
@.str.529 = private unnamed_addr constant [8 x i8] c" UNIQUE\00", align 1
@.str.530 = private unnamed_addr constant [48 x i8] c"INSERT INTO %Q.%s VALUES('index',%Q,%Q,#%d,%Q);\00", align 1
@.str.531 = private unnamed_addr constant [27 x i8] c"name='%q' AND type='index'\00", align 1
@.str.532 = private unnamed_addr constant [46 x i8] c"%s %T cannot reference objects in database %s\00", align 1
@.str.533 = private unnamed_addr constant [24 x i8] c"%s cannot use variables\00", align 1
@__const.sqlite3DefaultRowEst.aVal = private unnamed_addr constant [5 x i16] [i16 33, i16 32, i16 30, i16 28, i16 26], align 2
@.str.534 = private unnamed_addr constant [11 x i8] c"index '%q'\00", align 1
@.str.535 = private unnamed_addr constant [3 x i8] c", \00", align 1
@.str.536 = private unnamed_addr constant [63 x i8] c"foreign key on %s should reference only one column of table %T\00", align 1
@.str.537 = private unnamed_addr constant [94 x i8] c"number of columns in foreign key does not match the number of columns in the referenced table\00", align 1
@.str.538 = private unnamed_addr constant [46 x i8] c"unknown column \22%s\22 in foreign key definition\00", align 1
@.str.541 = private unnamed_addr constant [31 x i8] c"error in generated column \22%s\22\00", align 1
@.str.542 = private unnamed_addr constant [28 x i8] c"table %s may not be dropped\00", align 1
@.str.543 = private unnamed_addr constant [34 x i8] c"use DROP TABLE to delete table %s\00", align 1
@.str.544 = private unnamed_addr constant [32 x i8] c"use DROP VIEW to delete view %s\00", align 1
@.str.545 = private unnamed_addr constant [4 x i8] c"tbl\00", align 1
@.str.546 = private unnamed_addr constant [14 x i8] c"sqlite_stat%d\00", align 1
@.str.547 = private unnamed_addr constant [30 x i8] c"DELETE FROM %Q.%s WHERE %s=%Q\00", align 1
@.str.548 = private unnamed_addr constant [45 x i8] c"DELETE FROM %Q.sqlite_sequence WHERE name=%Q\00", align 1
@.str.549 = private unnamed_addr constant [56 x i8] c"DELETE FROM %Q.%s WHERE tbl_name=%Q and type!='trigger'\00", align 1
@.str.550 = private unnamed_addr constant [51 x i8] c"DELETE FROM %Q.%s WHERE name=%Q AND type='trigger'\00", align 1
@.str.551 = private unnamed_addr constant [15 x i8] c"corrupt schema\00", align 1
@.str.552 = private unnamed_addr constant [56 x i8] c"UPDATE %Q.%s SET rootpage=%d WHERE #%d AND rootpage=#%d\00", align 1
@.str.553 = private unnamed_addr constant [36 x i8] c"parameters are not allowed in views\00", align 1
@.str.554 = private unnamed_addr constant [40 x i8] c"expected %d columns for '%s' but got %d\00", align 1
@.str.555 = private unnamed_addr constant [14 x i8] c"CO-ROUTINE %u\00", align 1
@.str.556 = private unnamed_addr constant [15 x i8] c"MATERIALIZE %u\00", align 1
@.str.557 = private unnamed_addr constant [9 x i8] c"DISTINCT\00", align 1
@.str.558 = private unnamed_addr constant [9 x i8] c"GROUP BY\00", align 1
@.str.559 = private unnamed_addr constant [23 x i8] c"RIGHT PART OF ORDER BY\00", align 1
@.str.560 = private unnamed_addr constant [9 x i8] c"ORDER BY\00", align 1
@.str.561 = private unnamed_addr constant [36 x i8] c"too many FROM clause terms, max: %d\00", align 1
@.str.562 = private unnamed_addr constant [42 x i8] c"%s clause should come after %s not before\00", align 1
@.str.563 = private unnamed_addr constant [6 x i8] c"LIMIT\00", align 1
@.str.564 = private unnamed_addr constant [15 x i8] c"COMPOUND QUERY\00", align 1
@.str.565 = private unnamed_addr constant [19 x i8] c"LEFT-MOST SUBQUERY\00", align 1
@.str.566 = private unnamed_addr constant [21 x i8] c"%s USING TEMP B-TREE\00", align 1
@.str.567 = private unnamed_addr constant [23 x i8] c"SCAN %d CONSTANT ROW%s\00", align 1
@.str.568 = private unnamed_addr constant [49 x i8] c"cannot use window functions in recursive queries\00", align 1
@.str.569 = private unnamed_addr constant [6 x i8] c"SETUP\00", align 1
@.str.570 = private unnamed_addr constant [42 x i8] c"recursive aggregate queries not supported\00", align 1
@.str.571 = private unnamed_addr constant [15 x i8] c"RECURSIVE STEP\00", align 1
@.str.572 = private unnamed_addr constant [11 x i8] c"MERGE (%s)\00", align 1
@.str.573 = private unnamed_addr constant [5 x i8] c"LEFT\00", align 1
@.str.574 = private unnamed_addr constant [6 x i8] c"RIGHT\00", align 1
@sqlite3LogEstAdd.x = internal unnamed_addr constant [32 x i8] c"\0A\0A\09\09\08\08\07\07\07\06\06\06\05\05\05\04\04\04\04\03\03\03\03\03\03\02\02\02\02\02\02\02", align 16
@nth_valueName = internal constant [10 x i8] c"nth_value\00", align 1
@first_valueName = internal constant [12 x i8] c"first_value\00", align 1
@.str.575 = private unnamed_addr constant [28 x i8] c"at most %d tables in a join\00", align 1
@.str.576 = private unnamed_addr constant [18 x i8] c"SCAN CONSTANT ROW\00", align 1
@.str.577 = private unnamed_addr constant [36 x i8] c"too many arguments on %s() - max %d\00", align 1
@.str.578 = private unnamed_addr constant [41 x i8] c"ON clause references tables to its right\00", align 1
@.str.579 = private unnamed_addr constant [7 x i8] c"NOCASE\00", align 1
@.str.580 = private unnamed_addr constant [35 x i8] c"abbreviated query algorithm search\00", align 1
@.str.581 = private unnamed_addr constant [18 x i8] c"no query solution\00", align 1
@.str.582 = private unnamed_addr constant [26 x i8] c"automatic index on %s(%s)\00", align 1
@.str.583 = private unnamed_addr constant [11 x i8] c"auto-index\00", align 1
@.str.584 = private unnamed_addr constant [7 x i8] c"SEARCH\00", align 1
@.str.585 = private unnamed_addr constant [5 x i8] c"SCAN\00", align 1
@.str.586 = private unnamed_addr constant [13 x i8] c" SUBQUERY %u\00", align 1
@.str.587 = private unnamed_addr constant [10 x i8] c" TABLE %s\00", align 1
@.str.588 = private unnamed_addr constant [7 x i8] c" AS %s\00", align 1
@.str.589 = private unnamed_addr constant [12 x i8] c"PRIMARY KEY\00", align 1
@.str.590 = private unnamed_addr constant [33 x i8] c"AUTOMATIC PARTIAL COVERING INDEX\00", align 1
@.str.591 = private unnamed_addr constant [25 x i8] c"AUTOMATIC COVERING INDEX\00", align 1
@.str.592 = private unnamed_addr constant [18 x i8] c"COVERING INDEX %s\00", align 1
@.str.593 = private unnamed_addr constant [9 x i8] c"INDEX %s\00", align 1
@.str.594 = private unnamed_addr constant [8 x i8] c" USING \00", align 1
@.str.595 = private unnamed_addr constant [2 x i8] c"=\00", align 1
@.str.596 = private unnamed_addr constant [14 x i8] c">? AND rowid<\00", align 1
@.str.597 = private unnamed_addr constant [2 x i8] c">\00", align 1
@.str.598 = private unnamed_addr constant [2 x i8] c"<\00", align 1
@.str.599 = private unnamed_addr constant [38 x i8] c" USING INTEGER PRIMARY KEY (rowid%s?)\00", align 1
@.str.600 = private unnamed_addr constant [3 x i8] c" (\00", align 1
@.str.601 = private unnamed_addr constant [6 x i8] c" AND \00", align 1
@.str.602 = private unnamed_addr constant [5 x i8] c"%s=?\00", align 1
@.str.603 = private unnamed_addr constant [8 x i8] c"ANY(%s)\00", align 1
@.str.604 = private unnamed_addr constant [7 x i8] c"<expr>\00", align 1
@.str.605 = private unnamed_addr constant [2 x i8] c"(\00", align 1
@__const.sqlite3WhereCodeOneLoopStart.aMoveOp = private unnamed_addr constant [4 x i8] c"\19\17\16\18", align 1
@sqlite3WhereCodeOneLoopStart.aStartOp = internal unnamed_addr constant [8 x i8] c"\00\00%!\19\16\18\17", align 1
@sqlite3WhereCodeOneLoopStart.aEndOp = internal unnamed_addr constant [4 x i8] c")'&(", align 1
@.str.606 = private unnamed_addr constant [15 x i8] c"MULTI-INDEX OR\00", align 1
@.str.607 = private unnamed_addr constant [9 x i8] c"INDEX %d\00", align 1
@sqlite3WhereCodeOneLoopStart.aStep = internal unnamed_addr constant [2 x i8] c"\05\04", align 1
@sqlite3WhereCodeOneLoopStart.aStart = internal unnamed_addr constant [2 x i8] c"%!", align 1
@windowCheckValue.azErr = internal unnamed_addr constant [5 x i8*] [i8* getelementptr inbounds ([53 x i8], [53 x i8]* @.str.608, i32 0, i32 0), i8* getelementptr inbounds ([51 x i8], [51 x i8]* @.str.609, i32 0, i32 0), i8* getelementptr inbounds ([56 x i8], [56 x i8]* @.str.610, i32 0, i32 0), i8* getelementptr inbounds ([52 x i8], [52 x i8]* @.str.611, i32 0, i32 0), i8* getelementptr inbounds ([50 x i8], [50 x i8]* @.str.612, i32 0, i32 0)], align 16
@.str.608 = private unnamed_addr constant [53 x i8] c"frame starting offset must be a non-negative integer\00", align 1
@.str.609 = private unnamed_addr constant [51 x i8] c"frame ending offset must be a non-negative integer\00", align 1
@.str.610 = private unnamed_addr constant [56 x i8] c"second argument to nth_value must be a positive integer\00", align 1
@.str.611 = private unnamed_addr constant [52 x i8] c"frame starting offset must be a non-negative number\00", align 1
@.str.612 = private unnamed_addr constant [50 x i8] c"frame ending offset must be a non-negative number\00", align 1
@windowCheckValue.aOp = internal unnamed_addr constant [5 x i32] [i32 57, i32 57, i32 54, i32 57, i32 57], align 16
@.str.613 = private unnamed_addr constant [4 x i8] c"min\00", align 1
@.str.614 = private unnamed_addr constant [4 x i8] c"max\00", align 1
@.str.615 = private unnamed_addr constant [23 x i8] c"USE TEMP B-TREE FOR %s\00", align 1
@.str.616 = private unnamed_addr constant [51 x i8] c"DISTINCT aggregates must have exactly one argument\00", align 1
@.str.617 = private unnamed_addr constant [18 x i8] c"SCAN TABLE %s%s%s\00", align 1
@.str.618 = private unnamed_addr constant [23 x i8] c" USING COVERING INDEX \00", align 1
@.str.619 = private unnamed_addr constant [34 x i8] c"too many terms in compound SELECT\00", align 1
@.str.620 = private unnamed_addr constant [36 x i8] c"a JOIN clause is required before %s\00", align 1
@.str.621 = private unnamed_addr constant [3 x i8] c"ON\00", align 1
@.str.622 = private unnamed_addr constant [6 x i8] c"USING\00", align 1
@sqlite3JoinType.zKeyText = internal unnamed_addr constant [34 x i8] c"naturaleftouterightfullinnercross\00", align 16
@sqlite3JoinType.aKeyword = internal unnamed_addr constant [7 x %struct.anon.21] [%struct.anon.21 { i8 0, i8 7, i8 4 }, %struct.anon.21 { i8 6, i8 4, i8 40 }, %struct.anon.21 { i8 10, i8 5, i8 32 }, %struct.anon.21 { i8 14, i8 5, i8 48 }, %struct.anon.21 { i8 19, i8 4, i8 56 }, %struct.anon.21 { i8 23, i8 5, i8 1 }, %struct.anon.21 { i8 28, i8 5, i8 3 }], align 16
@.str.623 = private unnamed_addr constant [2 x i8] c" \00", align 1
@.str.624 = private unnamed_addr constant [44 x i8] c"unknown or unsupported join type: %T %T%s%T\00", align 1
@.str.625 = private unnamed_addr constant [55 x i8] c"RIGHT and FULL OUTER JOINs are not currently supported\00", align 1
@.str.626 = private unnamed_addr constant [13 x i8] c"rows deleted\00", align 1
@.str.627 = private unnamed_addr constant [29 x i8] c"table %s may not be modified\00", align 1
@.str.628 = private unnamed_addr constant [38 x i8] c"cannot modify %s because it is a view\00", align 1
@.str.629 = private unnamed_addr constant [13 x i8] c"sqlite_stat1\00", align 1
@.str.630 = private unnamed_addr constant [45 x i8] c"foreign key mismatch - \22%w\22 referencing \22%w\22\00", align 1
@autoIncrementEnd.autoIncEnd = internal constant [5 x %struct.VdbeOpList] [%struct.VdbeOpList { i8 51, i8 0, i8 2, i8 0 }, %struct.VdbeOpList { i8 120, i8 0, i8 0, i8 0 }, %struct.VdbeOpList { i8 91, i8 0, i8 2, i8 0 }, %struct.VdbeOpList { i8 121, i8 0, i8 0, i8 0 }, %struct.VdbeOpList { i8 116, i8 0, i8 0, i8 0 }], align 16
@.str.631 = private unnamed_addr constant [23 x i8] c"too many columns in %s\00", align 1
@.str.632 = private unnamed_addr constant [36 x i8] c"cannot UPDATE generated column \22%s\22\00", align 1
@.str.633 = private unnamed_addr constant [19 x i8] c"no such column: %s\00", align 1
@.str.634 = private unnamed_addr constant [13 x i8] c"rows updated\00", align 1
@sqlite3OpcodeProperty = internal unnamed_addr constant [176 x i8] c"\00\00\00\01\01\01\00\10\00\01\00\01\01\01\03\03\01\01\03\12\03\01\09\09\09\09\01\09\09\09\09\09\09\01\01\01\01\01\01\01\01\01#&&\0B\01\01\03\03\03\03\0B\0B\0B\0B\0B\0B\01\03\01\01\01\00\00\02\02\08\00\10\10\10\10\00\10\10\00\00\10\10\00\00\02\02\02\00\00\12 \00\00\00\10\10\00\00\00\00\00\00\00&&&&&&&&&&\00\12\00\00\10\00\00\00\10\10\00\00\00\00\00\00\10\00\00\04\04\00\00\10\00\10\00\00\10\00\00\00\00\00\00\00\06\10\00\10\04\1A\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\10\10\00\00\00\00\00\00", align 16
@.str.635 = private unnamed_addr constant [9 x i8] c"%s.rowid\00", align 1
@.str.636 = private unnamed_addr constant [41 x i8] c"cannot INSERT into generated column \22%s\22\00", align 1
@.str.637 = private unnamed_addr constant [32 x i8] c"table %S has no column named %s\00", align 1
@.str.638 = private unnamed_addr constant [52 x i8] c"table %S has %d columns but %d values were supplied\00", align 1
@.str.639 = private unnamed_addr constant [25 x i8] c"%d values for %d columns\00", align 1
@.str.640 = private unnamed_addr constant [21 x i8] c"cannot UPSERT a view\00", align 1
@.str.641 = private unnamed_addr constant [14 x i8] c"rows inserted\00", align 1
@.str.642 = private unnamed_addr constant [71 x i8] c"ON CONFLICT clause does not match any PRIMARY KEY or UNIQUE constraint\00", align 1
@.str.643 = private unnamed_addr constant [43 x i8] c"variable number must be between ?1 and ?%d\00", align 1
@.str.644 = private unnamed_addr constant [23 x i8] c"too many SQL variables\00", align 1
@.str.645 = private unnamed_addr constant [34 x i8] c"too many arguments on function %T\00", align 1
@.str.646 = private unnamed_addr constant [47 x i8] c"DISTINCT is not supported for window functions\00", align 1
@.str.647 = private unnamed_addr constant [38 x i8] c"syntax error after column name \22%.*s\22\00", align 1
@.str.648 = private unnamed_addr constant [18 x i8] c"no such index: %S\00", align 1
@.str.649 = private unnamed_addr constant [73 x i8] c"index associated with UNIQUE or PRIMARY KEY constraint cannot be dropped\00", align 1
@.str.650 = private unnamed_addr constant [49 x i8] c"DELETE FROM %Q.%s WHERE name=%Q AND type='index'\00", align 1
@.str.651 = private unnamed_addr constant [4 x i8] c"idx\00", align 1
@.str.652 = private unnamed_addr constant [4 x i8] c"-%T\00", align 1
@sqlite3Pragma.getCacheSize = internal constant [9 x %struct.VdbeOpList] [%struct.VdbeOpList { i8 2, i8 0, i8 0, i8 0 }, %struct.VdbeOpList { i8 93, i8 0, i8 1, i8 3 }, %struct.VdbeOpList { i8 48, i8 1, i8 8, i8 0 }, %struct.VdbeOpList { i8 69, i8 0, i8 2, i8 0 }, %struct.VdbeOpList { i8 106, i8 1, i8 2, i8 1 }, %struct.VdbeOpList { i8 48, i8 1, i8 8, i8 0 }, %struct.VdbeOpList { i8 69, i8 0, i8 1, i8 0 }, %struct.VdbeOpList { i8 -83, i8 0, i8 0, i8 0 }, %struct.VdbeOpList { i8 80, i8 1, i8 1, i8 0 }], align 16
@.str.653 = private unnamed_addr constant [5 x i8] c"fast\00", align 1
@.str.654 = private unnamed_addr constant [7 x i8] c"normal\00", align 1
@.str.655 = private unnamed_addr constant [10 x i8] c"exclusive\00", align 1
@sqlite3Pragma.setMeta6 = internal constant [5 x %struct.VdbeOpList] [%struct.VdbeOpList { i8 2, i8 0, i8 1, i8 0 }, %struct.VdbeOpList { i8 93, i8 0, i8 1, i8 4 }, %struct.VdbeOpList { i8 18, i8 1, i8 0, i8 0 }, %struct.VdbeOpList { i8 68, i8 0, i8 2, i8 0 }, %struct.VdbeOpList { i8 94, i8 0, i8 7, i8 0 }], align 16
@.str.657 = private unnamed_addr constant [25 x i8] c"not a writable directory\00", align 1
@.str.658 = private unnamed_addr constant [30 x i8] c"failed to set lock proxy file\00", align 1
@.str.659 = private unnamed_addr constant [53 x i8] c"Safety level may not be changed inside a transaction\00", align 1
@.str.660 = private unnamed_addr constant [8 x i8] c"issisii\00", align 1
@.str.661 = private unnamed_addr constant [7 x i8] c"issisi\00", align 1
@.str.662 = private unnamed_addr constant [5 x i8] c"iisX\00", align 1
@.str.663 = private unnamed_addr constant [5 x i8] c"isiX\00", align 1
@.str.664 = private unnamed_addr constant [2 x i8] c"c\00", align 1
@.str.665 = private unnamed_addr constant [2 x i8] c"u\00", align 1
@.str.666 = private unnamed_addr constant [3 x i8] c"pk\00", align 1
@__const.sqlite3Pragma.azOrigin = private unnamed_addr constant [3 x i8*] [i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.664, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.665, i32 0, i32 0), i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.666, i32 0, i32 0)], align 16
@.str.667 = private unnamed_addr constant [6 x i8] c"isisi\00", align 1
@.str.668 = private unnamed_addr constant [4 x i8] c"iss\00", align 1
@.str.669 = private unnamed_addr constant [3 x i8] c"is\00", align 1
@.str.670 = private unnamed_addr constant [2 x i8] c"s\00", align 1
@aPragmaName = internal unnamed_addr constant [64 x %struct.PragmaName] [%struct.PragmaName { i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.str.743, i32 0, i32 0), i8 1, i8 20, i8 0, i8 0, i64 8 }, %struct.PragmaName { i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.744, i32 0, i32 0), i8 2, i8 -107, i8 0, i8 0, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.745, i32 0, i32 0), i8 3, i8 20, i8 0, i8 0, i64 32768 }, %struct.PragmaName { i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.746, i32 0, i32 0), i8 4, i8 16, i8 50, i8 1, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.731, i32 0, i32 0), i8 5, i8 -107, i8 0, i8 0, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.747, i32 0, i32 0), i8 6, i8 -108, i8 0, i8 0, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([20 x i8], [20 x i8]* @.str.748, i32 0, i32 0), i8 7, i8 2, i8 0, i8 0, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.749, i32 0, i32 0), i8 3, i8 20, i8 0, i8 0, i64 2097152 }, %struct.PragmaName { i8* getelementptr inbounds ([21 x i8], [21 x i8]* @.str.750, i32 0, i32 0), i8 3, i8 20, i8 0, i8 0, i64 16 }, %struct.PragmaName { i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.str.751, i32 0, i32 0), i8 8, i8 16, i8 32, i8 2, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.752, i32 0, i32 0), i8 9, i8 16, i8 0, i8 0, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.753, i32 0, i32 0), i8 3, i8 20, i8 0, i8 0, i64 4294967296 }, %struct.PragmaName { i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.754, i32 0, i32 0), i8 1, i8 24, i8 0, i8 0, i64 15 }, %struct.PragmaName { i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.755, i32 0, i32 0), i8 11, i8 17, i8 41, i8 3, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.756, i32 0, i32 0), i8 12, i8 -107, i8 49, i8 1, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.757, i32 0, i32 0), i8 3, i8 20, i8 0, i8 0, i64 524288 }, %struct.PragmaName { i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.758, i32 0, i32 0), i8 3, i8 20, i8 0, i8 0, i64 256 }, %struct.PragmaName { i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.759, i32 0, i32 0), i8 13, i8 20, i8 0, i8 0, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.760, i32 0, i32 0), i8 14, i8 17, i8 37, i8 4, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.761, i32 0, i32 0), i8 15, i8 97, i8 0, i8 8, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.762, i32 0, i32 0), i8 3, i8 20, i8 0, i8 0, i64 16384 }, %struct.PragmaName { i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.str.763, i32 0, i32 0), i8 1, i8 24, i8 0, i8 0, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.764, i32 0, i32 0), i8 3, i8 20, i8 0, i8 0, i64 4 }, %struct.PragmaName { i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.765, i32 0, i32 0), i8 3, i8 20, i8 0, i8 0, i64 8 }, %struct.PragmaName { i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.766, i32 0, i32 0), i8 16, i8 16, i8 21, i8 6, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.767, i32 0, i32 0), i8 17, i8 16, i8 0, i8 0, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([25 x i8], [25 x i8]* @.str.768, i32 0, i32 0), i8 3, i8 20, i8 0, i8 0, i64 512 }, %struct.PragmaName { i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.769, i32 0, i32 0), i8 18, i8 3, i8 0, i8 0, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.770, i32 0, i32 0), i8 19, i8 97, i8 15, i8 3, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.771, i32 0, i32 0), i8 20, i8 97, i8 32, i8 5, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.772, i32 0, i32 0), i8 19, i8 97, i8 15, i8 6, i64 1 }, %struct.PragmaName { i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.773, i32 0, i32 0), i8 21, i8 49, i8 0, i8 0, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.774, i32 0, i32 0), i8 22, i8 -111, i8 0, i8 0, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.775, i32 0, i32 0), i8 23, i8 -112, i8 0, i8 0, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.776, i32 0, i32 0), i8 3, i8 20, i8 0, i8 0, i64 67108864 }, %struct.PragmaName { i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.777, i32 0, i32 0), i8 24, i8 4, i8 0, i8 0, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.778, i32 0, i32 0), i8 25, i8 -112, i8 0, i8 0, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.str.779, i32 0, i32 0), i8 26, i8 -111, i8 0, i8 0, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.780, i32 0, i32 0), i8 27, i8 0, i8 0, i8 0, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.781, i32 0, i32 0), i8 29, i8 33, i8 0, i8 0, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.782, i32 0, i32 0), i8 26, i8 -111, i8 0, i8 0, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.783, i32 0, i32 0), i8 30, i8 -108, i8 0, i8 0, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.784, i32 0, i32 0), i8 31, i8 16, i8 9, i8 1, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.785, i32 0, i32 0), i8 3, i8 20, i8 0, i8 0, i64 1048576 }, %struct.PragmaName { i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.786, i32 0, i32 0), i8 21, i8 49, i8 0, i8 0, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.787, i32 0, i32 0), i8 3, i8 20, i8 0, i8 0, i64 1024 }, %struct.PragmaName { i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.788, i32 0, i32 0), i8 3, i8 20, i8 0, i8 0, i64 8192 }, %struct.PragmaName { i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.789, i32 0, i32 0), i8 3, i8 20, i8 0, i8 0, i64 4096 }, %struct.PragmaName { i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.str.790, i32 0, i32 0), i8 1, i8 20, i8 0, i8 0, i64 1 }, %struct.PragmaName { i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.791, i32 0, i32 0), i8 32, i8 16, i8 0, i8 0, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.792, i32 0, i32 0), i8 3, i8 20, i8 0, i8 0, i64 64 }, %struct.PragmaName { i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.793, i32 0, i32 0), i8 33, i8 2, i8 0, i8 0, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.794, i32 0, i32 0), i8 34, i8 16, i8 0, i8 0, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.795, i32 0, i32 0), i8 35, i8 -107, i8 0, i8 0, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.796, i32 0, i32 0), i8 36, i8 97, i8 8, i8 6, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.797, i32 0, i32 0), i8 36, i8 97, i8 8, i8 7, i64 1 }, %struct.PragmaName { i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.798, i32 0, i32 0), i8 37, i8 20, i8 0, i8 0, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([21 x i8], [21 x i8]* @.str.799, i32 0, i32 0), i8 38, i8 4, i8 0, i8 0, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.800, i32 0, i32 0), i8 39, i8 16, i8 0, i8 0, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.str.801, i32 0, i32 0), i8 3, i8 20, i8 0, i8 0, i64 128 }, %struct.PragmaName { i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.802, i32 0, i32 0), i8 1, i8 20, i8 0, i8 0, i64 6 }, %struct.PragmaName { i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.803, i32 0, i32 0), i8 40, i8 0, i8 0, i8 0, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.str.804, i32 0, i32 0), i8 41, i8 1, i8 44, i8 3, i64 0 }, %struct.PragmaName { i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.805, i32 0, i32 0), i8 3, i8 20, i8 0, i8 0, i64 134217729 }], align 16
@.str.671 = private unnamed_addr constant [9 x i8] c"iissssss\00", align 1
@.str.672 = private unnamed_addr constant [5 x i8] c"NONE\00", align 1
@.str.673 = private unnamed_addr constant [4 x i8] c"siX\00", align 1
@.str.674 = private unnamed_addr constant [24 x i8] c"*** in database %s ***\0A\00", align 1
@.str.675 = private unnamed_addr constant [20 x i8] c"NULL value in %s.%s\00", align 1
@.str.676 = private unnamed_addr constant [30 x i8] c"CHECK constraint failed in %s\00", align 1
@.str.677 = private unnamed_addr constant [5 x i8] c"row \00", align 1
@.str.678 = private unnamed_addr constant [21 x i8] c" missing from index \00", align 1
@.str.679 = private unnamed_addr constant [27 x i8] c"non-unique entry in index \00", align 1
@.str.680 = private unnamed_addr constant [29 x i8] c"wrong # of entries in index \00", align 1
@sqlite3Pragma.endCode = internal constant [7 x %struct.VdbeOpList] [%struct.VdbeOpList { i8 82, i8 1, i8 0, i8 0 }, %struct.VdbeOpList { i8 49, i8 1, i8 4, i8 0 }, %struct.VdbeOpList { i8 115, i8 0, i8 3, i8 0 }, %struct.VdbeOpList { i8 80, i8 3, i8 1, i8 0 }, %struct.VdbeOpList { i8 68, i8 0, i8 0, i8 0 }, %struct.VdbeOpList { i8 115, i8 0, i8 3, i8 0 }, %struct.VdbeOpList { i8 11, i8 0, i8 3, i8 0 }], align 16
@.str.682 = private unnamed_addr constant [3 x i8] c"ok\00", align 1
@sqlite3Pragma.encnames = internal unnamed_addr constant [9 x %struct.EncName] [%struct.EncName { i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.683, i32 0, i32 0), i8 1 }, %struct.EncName { i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.684, i32 0, i32 0), i8 1 }, %struct.EncName { i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.685, i32 0, i32 0), i8 2 }, %struct.EncName { i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.686, i32 0, i32 0), i8 3 }, %struct.EncName { i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.687, i32 0, i32 0), i8 2 }, %struct.EncName { i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.688, i32 0, i32 0), i8 3 }, %struct.EncName { i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.689, i32 0, i32 0), i8 0 }, %struct.EncName { i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.690, i32 0, i32 0), i8 0 }, %struct.EncName zeroinitializer], align 16
@.str.683 = private unnamed_addr constant [5 x i8] c"UTF8\00", align 1
@.str.684 = private unnamed_addr constant [6 x i8] c"UTF-8\00", align 1
@.str.685 = private unnamed_addr constant [9 x i8] c"UTF-16le\00", align 1
@.str.686 = private unnamed_addr constant [9 x i8] c"UTF-16be\00", align 1
@.str.687 = private unnamed_addr constant [8 x i8] c"UTF16le\00", align 1
@.str.688 = private unnamed_addr constant [8 x i8] c"UTF16be\00", align 1
@.str.689 = private unnamed_addr constant [7 x i8] c"UTF-16\00", align 1
@.str.690 = private unnamed_addr constant [6 x i8] c"UTF16\00", align 1
@.str.691 = private unnamed_addr constant [25 x i8] c"unsupported encoding: %s\00", align 1
@sqlite3Pragma.setCookie = internal constant [2 x %struct.VdbeOpList] [%struct.VdbeOpList { i8 2, i8 0, i8 1, i8 0 }, %struct.VdbeOpList { i8 94, i8 0, i8 0, i8 0 }], align 1
@sqlite3Pragma.readCookie = internal constant [3 x %struct.VdbeOpList] [%struct.VdbeOpList { i8 2, i8 0, i8 0, i8 0 }, %struct.VdbeOpList { i8 93, i8 0, i8 1, i8 0 }, %struct.VdbeOpList { i8 80, i8 1, i8 1, i8 0 }], align 1
@.str.692 = private unnamed_addr constant [5 x i8] c"full\00", align 1
@.str.693 = private unnamed_addr constant [8 x i8] c"restart\00", align 1
@.str.694 = private unnamed_addr constant [9 x i8] c"truncate\00", align 1
@.str.695 = private unnamed_addr constant [18 x i8] c"ANALYZE \22%w\22.\22%w\22\00", align 1
@pragCName = internal unnamed_addr constant [51 x i8*] [i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.696, i32 0, i32 0), i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.697, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.356, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.698, i32 0, i32 0), i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.699, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.700, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.701, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.702, i32 0, i32 0), i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.703, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.704, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.705, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.706, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.707, i32 0, i32 0), i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.666, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.708, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.709, i32 0, i32 0), i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.703, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.704, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.710, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.711, i32 0, i32 0), i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.712, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.704, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.713, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.705, i32 0, i32 0), i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.714, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.715, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.716, i32 0, i32 0), i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.545, i32 0, i32 0), i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.651, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.717, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.718, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.719, i32 0, i32 0), i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.697, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.704, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.720, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.721, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.722, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.356, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.373, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.723, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.724, i32 0, i32 0), i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.697, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.704, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.725, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.726, i32 0, i32 0), i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.727, i32 0, i32 0), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.728, i32 0, i32 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.729, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.730, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.731, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.732, i32 0, i32 0)], align 16
@.str.696 = private unnamed_addr constant [3 x i8] c"id\00", align 1
@.str.697 = private unnamed_addr constant [4 x i8] c"seq\00", align 1
@.str.698 = private unnamed_addr constant [5 x i8] c"from\00", align 1
@.str.699 = private unnamed_addr constant [3 x i8] c"to\00", align 1
@.str.700 = private unnamed_addr constant [10 x i8] c"on_update\00", align 1
@.str.701 = private unnamed_addr constant [10 x i8] c"on_delete\00", align 1
@.str.702 = private unnamed_addr constant [6 x i8] c"match\00", align 1
@.str.703 = private unnamed_addr constant [4 x i8] c"cid\00", align 1
@.str.704 = private unnamed_addr constant [5 x i8] c"name\00", align 1
@.str.705 = private unnamed_addr constant [5 x i8] c"type\00", align 1
@.str.706 = private unnamed_addr constant [8 x i8] c"notnull\00", align 1
@.str.707 = private unnamed_addr constant [11 x i8] c"dflt_value\00", align 1
@.str.708 = private unnamed_addr constant [7 x i8] c"hidden\00", align 1
@.str.709 = private unnamed_addr constant [6 x i8] c"seqno\00", align 1
@.str.710 = private unnamed_addr constant [5 x i8] c"desc\00", align 1
@.str.711 = private unnamed_addr constant [5 x i8] c"coll\00", align 1
@.str.712 = private unnamed_addr constant [4 x i8] c"key\00", align 1
@.str.713 = private unnamed_addr constant [8 x i8] c"builtin\00", align 1
@.str.714 = private unnamed_addr constant [4 x i8] c"enc\00", align 1
@.str.715 = private unnamed_addr constant [5 x i8] c"narg\00", align 1
@.str.716 = private unnamed_addr constant [6 x i8] c"flags\00", align 1
@.str.717 = private unnamed_addr constant [5 x i8] c"wdth\00", align 1
@.str.718 = private unnamed_addr constant [5 x i8] c"hght\00", align 1
@.str.719 = private unnamed_addr constant [5 x i8] c"flgs\00", align 1
@.str.720 = private unnamed_addr constant [7 x i8] c"unique\00", align 1
@.str.721 = private unnamed_addr constant [7 x i8] c"origin\00", align 1
@.str.722 = private unnamed_addr constant [8 x i8] c"partial\00", align 1
@.str.723 = private unnamed_addr constant [7 x i8] c"parent\00", align 1
@.str.724 = private unnamed_addr constant [5 x i8] c"fkid\00", align 1
@.str.725 = private unnamed_addr constant [5 x i8] c"file\00", align 1
@.str.726 = private unnamed_addr constant [5 x i8] c"busy\00", align 1
@.str.727 = private unnamed_addr constant [4 x i8] c"log\00", align 1
@.str.728 = private unnamed_addr constant [13 x i8] c"checkpointed\00", align 1
@.str.729 = private unnamed_addr constant [9 x i8] c"database\00", align 1
@.str.730 = private unnamed_addr constant [7 x i8] c"status\00", align 1
@.str.731 = private unnamed_addr constant [11 x i8] c"cache_size\00", align 1
@.str.732 = private unnamed_addr constant [8 x i8] c"timeout\00", align 1
@.str.733 = private unnamed_addr constant [5 x i8] c"none\00", align 1
@.str.734 = private unnamed_addr constant [12 x i8] c"incremental\00", align 1
@.str.735 = private unnamed_addr constant [7 x i8] c"memory\00", align 1
@.str.736 = private unnamed_addr constant [62 x i8] c"temporary storage cannot be changed from within a transaction\00", align 1
@getSafetyLevel.zText = internal unnamed_addr constant [25 x i8] c"onoffalseyestruextrafull\00", align 16
@getSafetyLevel.iValue = internal unnamed_addr constant [8 x i8] c"\01\00\00\00\01\01\03\02", align 1
@pragmaFunclistLine.azEnc = internal unnamed_addr constant [4 x i8*] [i8* null, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.737, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.738, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.739, i32 0, i32 0)], align 16
@.str.737 = private unnamed_addr constant [5 x i8] c"utf8\00", align 1
@.str.738 = private unnamed_addr constant [8 x i8] c"utf16le\00", align 1
@.str.739 = private unnamed_addr constant [8 x i8] c"utf16be\00", align 1
@.str.740 = private unnamed_addr constant [2 x i8] c"w\00", align 1
@.str.741 = private unnamed_addr constant [2 x i8] c"a\00", align 1
@.str.742 = private unnamed_addr constant [7 x i8] c"sissii\00", align 1
@.str.743 = private unnamed_addr constant [15 x i8] c"application_id\00", align 1
@.str.744 = private unnamed_addr constant [12 x i8] c"auto_vacuum\00", align 1
@.str.745 = private unnamed_addr constant [16 x i8] c"automatic_index\00", align 1
@.str.746 = private unnamed_addr constant [13 x i8] c"busy_timeout\00", align 1
@.str.747 = private unnamed_addr constant [12 x i8] c"cache_spill\00", align 1
@.str.748 = private unnamed_addr constant [20 x i8] c"case_sensitive_like\00", align 1
@.str.749 = private unnamed_addr constant [16 x i8] c"cell_size_check\00", align 1
@.str.750 = private unnamed_addr constant [21 x i8] c"checkpoint_fullfsync\00", align 1
@.str.751 = private unnamed_addr constant [15 x i8] c"collation_list\00", align 1
@.str.752 = private unnamed_addr constant [16 x i8] c"compile_options\00", align 1
@.str.753 = private unnamed_addr constant [14 x i8] c"count_changes\00", align 1
@.str.754 = private unnamed_addr constant [13 x i8] c"data_version\00", align 1
@.str.755 = private unnamed_addr constant [14 x i8] c"database_list\00", align 1
@.str.756 = private unnamed_addr constant [19 x i8] c"default_cache_size\00", align 1
@.str.757 = private unnamed_addr constant [19 x i8] c"defer_foreign_keys\00", align 1
@.str.758 = private unnamed_addr constant [23 x i8] c"empty_result_callbacks\00", align 1
@.str.759 = private unnamed_addr constant [9 x i8] c"encoding\00", align 1
@.str.760 = private unnamed_addr constant [18 x i8] c"foreign_key_check\00", align 1
@.str.761 = private unnamed_addr constant [17 x i8] c"foreign_key_list\00", align 1
@.str.762 = private unnamed_addr constant [13 x i8] c"foreign_keys\00", align 1
@.str.763 = private unnamed_addr constant [15 x i8] c"freelist_count\00", align 1
@.str.764 = private unnamed_addr constant [18 x i8] c"full_column_names\00", align 1
@.str.765 = private unnamed_addr constant [10 x i8] c"fullfsync\00", align 1
@.str.766 = private unnamed_addr constant [14 x i8] c"function_list\00", align 1
@.str.767 = private unnamed_addr constant [16 x i8] c"hard_heap_limit\00", align 1
@.str.768 = private unnamed_addr constant [25 x i8] c"ignore_check_constraints\00", align 1
@.str.769 = private unnamed_addr constant [19 x i8] c"incremental_vacuum\00", align 1
@.str.770 = private unnamed_addr constant [11 x i8] c"index_info\00", align 1
@.str.771 = private unnamed_addr constant [11 x i8] c"index_list\00", align 1
@.str.772 = private unnamed_addr constant [12 x i8] c"index_xinfo\00", align 1
@.str.773 = private unnamed_addr constant [16 x i8] c"integrity_check\00", align 1
@.str.774 = private unnamed_addr constant [13 x i8] c"journal_mode\00", align 1
@.str.775 = private unnamed_addr constant [19 x i8] c"journal_size_limit\00", align 1
@.str.776 = private unnamed_addr constant [19 x i8] c"legacy_alter_table\00", align 1
@.str.777 = private unnamed_addr constant [16 x i8] c"lock_proxy_file\00", align 1
@.str.778 = private unnamed_addr constant [13 x i8] c"locking_mode\00", align 1
@.str.779 = private unnamed_addr constant [15 x i8] c"max_page_count\00", align 1
@.str.780 = private unnamed_addr constant [10 x i8] c"mmap_size\00", align 1
@.str.781 = private unnamed_addr constant [9 x i8] c"optimize\00", align 1
@.str.782 = private unnamed_addr constant [11 x i8] c"page_count\00", align 1
@.str.783 = private unnamed_addr constant [10 x i8] c"page_size\00", align 1
@.str.784 = private unnamed_addr constant [12 x i8] c"pragma_list\00", align 1
@.str.785 = private unnamed_addr constant [11 x i8] c"query_only\00", align 1
@.str.786 = private unnamed_addr constant [12 x i8] c"quick_check\00", align 1
@.str.787 = private unnamed_addr constant [17 x i8] c"read_uncommitted\00", align 1
@.str.788 = private unnamed_addr constant [19 x i8] c"recursive_triggers\00", align 1
@.str.789 = private unnamed_addr constant [26 x i8] c"reverse_unordered_selects\00", align 1
@.str.790 = private unnamed_addr constant [15 x i8] c"schema_version\00", align 1
@.str.791 = private unnamed_addr constant [14 x i8] c"secure_delete\00", align 1
@.str.792 = private unnamed_addr constant [19 x i8] c"short_column_names\00", align 1
@.str.793 = private unnamed_addr constant [14 x i8] c"shrink_memory\00", align 1
@.str.794 = private unnamed_addr constant [16 x i8] c"soft_heap_limit\00", align 1
@.str.795 = private unnamed_addr constant [12 x i8] c"synchronous\00", align 1
@.str.796 = private unnamed_addr constant [11 x i8] c"table_info\00", align 1
@.str.797 = private unnamed_addr constant [12 x i8] c"table_xinfo\00", align 1
@.str.798 = private unnamed_addr constant [11 x i8] c"temp_store\00", align 1
@.str.799 = private unnamed_addr constant [21 x i8] c"temp_store_directory\00", align 1
@.str.800 = private unnamed_addr constant [8 x i8] c"threads\00", align 1
@.str.801 = private unnamed_addr constant [15 x i8] c"trusted_schema\00", align 1
@.str.802 = private unnamed_addr constant [13 x i8] c"user_version\00", align 1
@.str.803 = private unnamed_addr constant [19 x i8] c"wal_autocheckpoint\00", align 1
@.str.804 = private unnamed_addr constant [15 x i8] c"wal_checkpoint\00", align 1
@.str.805 = private unnamed_addr constant [16 x i8] c"writable_schema\00", align 1
@.str.806 = private unnamed_addr constant [9 x i8] c"SET NULL\00", align 1
@.str.807 = private unnamed_addr constant [12 x i8] c"SET DEFAULT\00", align 1
@.str.808 = private unnamed_addr constant [8 x i8] c"CASCADE\00", align 1
@.str.809 = private unnamed_addr constant [9 x i8] c"RESTRICT\00", align 1
@.str.810 = private unnamed_addr constant [10 x i8] c"NO ACTION\00", align 1
@likeInfoAlt = internal constant %struct.compareInfo { i8 37, i8 95, i8 0, i8 0 }, align 1
@.str.811 = private unnamed_addr constant [5 x i8] c"like\00", align 1
@.str.812 = private unnamed_addr constant [33 x i8] c"LIKE or GLOB pattern too complex\00", align 1
@.str.813 = private unnamed_addr constant [45 x i8] c"ESCAPE expression must be a single character\00", align 1
@.str.814 = private unnamed_addr constant [64 x i8] c"INSERT INTO %Q.%s VALUES('trigger',%Q,%Q,0,'CREATE TRIGGER %q')\00", align 1
@.str.815 = private unnamed_addr constant [29 x i8] c"type='trigger' AND name='%q'\00", align 1
@.str.816 = private unnamed_addr constant [46 x i8] c"temporary trigger may not have qualified name\00", align 1
@.str.817 = private unnamed_addr constant [26 x i8] c"trigger %T already exists\00", align 1
@.str.818 = private unnamed_addr constant [38 x i8] c"cannot create trigger on system table\00", align 1
@.str.819 = private unnamed_addr constant [37 x i8] c"cannot create %s trigger on view: %S\00", align 1
@.str.820 = private unnamed_addr constant [7 x i8] c"BEFORE\00", align 1
@.str.821 = private unnamed_addr constant [6 x i8] c"AFTER\00", align 1
@.str.822 = private unnamed_addr constant [46 x i8] c"cannot create INSTEAD OF trigger on table: %S\00", align 1
@.str.823 = private unnamed_addr constant [20 x i8] c"no such trigger: %S\00", align 1
@sqlite3Attach.attach_func = external dso_local constant %struct.FuncDef, align 8
@.str.824 = private unnamed_addr constant [14 x i8] c"sqlite_attach\00", align 1
@.str.825 = private unnamed_addr constant [37 x i8] c"too many attached databases - max %d\00", align 1
@.str.826 = private unnamed_addr constant [30 x i8] c"database %s is already in use\00", align 1
@.str.827 = private unnamed_addr constant [29 x i8] c"database is already attached\00", align 1
@.str.828 = private unnamed_addr constant [28 x i8] c"unable to open database: %s\00", align 1
@.str.829 = private unnamed_addr constant [6 x i8] c"file:\00", align 1
@.str.830 = private unnamed_addr constant [10 x i8] c"localhost\00", align 1
@.str.831 = private unnamed_addr constant [28 x i8] c"invalid uri authority: %.*s\00", align 1
@.str.832 = private unnamed_addr constant [4 x i8] c"vfs\00", align 1
@.str.833 = private unnamed_addr constant [6 x i8] c"cache\00", align 1
@sqlite3ParseUri.aCacheMode = internal unnamed_addr constant [3 x %struct.OpenMode] [%struct.OpenMode { i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.834, i32 0, i32 0), i32 131072 }, %struct.OpenMode { i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.835, i32 0, i32 0), i32 262144 }, %struct.OpenMode zeroinitializer], align 16
@.str.834 = private unnamed_addr constant [7 x i8] c"shared\00", align 1
@.str.835 = private unnamed_addr constant [8 x i8] c"private\00", align 1
@.str.836 = private unnamed_addr constant [5 x i8] c"mode\00", align 1
@sqlite3ParseUri.aOpenMode = internal unnamed_addr constant [5 x %struct.OpenMode] [%struct.OpenMode { i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.837, i32 0, i32 0), i32 1 }, %struct.OpenMode { i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.838, i32 0, i32 0), i32 2 }, %struct.OpenMode { i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.839, i32 0, i32 0), i32 6 }, %struct.OpenMode { i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.735, i32 0, i32 0), i32 128 }, %struct.OpenMode zeroinitializer], align 16
@.str.837 = private unnamed_addr constant [3 x i8] c"ro\00", align 1
@.str.838 = private unnamed_addr constant [3 x i8] c"rw\00", align 1
@.str.839 = private unnamed_addr constant [4 x i8] c"rwc\00", align 1
@.str.840 = private unnamed_addr constant [20 x i8] c"no such %s mode: %s\00", align 1
@.str.841 = private unnamed_addr constant [24 x i8] c"%s mode not allowed: %s\00", align 1
@.str.842 = private unnamed_addr constant [16 x i8] c"no such vfs: %s\00", align 1
@sqlite3Detach.detach_func = external dso_local constant %struct.FuncDef, align 8
@.str.843 = private unnamed_addr constant [14 x i8] c"sqlite_detach\00", align 1
@.str.844 = private unnamed_addr constant [21 x i8] c"no such database: %s\00", align 1
@.str.845 = private unnamed_addr constant [26 x i8] c"cannot detach database %s\00", align 1
@.str.846 = private unnamed_addr constant [22 x i8] c"database %s is locked\00", align 1
@.str.847 = private unnamed_addr constant [46 x i8] c"unable to identify the object to be reindexed\00", align 1
@.str.848 = private unnamed_addr constant [13 x i8] c"tbl,idx,stat\00", align 1
@.str.849 = private unnamed_addr constant [13 x i8] c"sqlite_stat4\00", align 1
@.str.850 = private unnamed_addr constant [13 x i8] c"sqlite_stat3\00", align 1
@.str.851 = private unnamed_addr constant [23 x i8] c"CREATE TABLE %Q.%s(%s)\00", align 1
@.str.852 = private unnamed_addr constant [10 x i8] c"sqlite\\_%\00", align 1
@statInitFuncdef = external dso_local constant %struct.FuncDef, align 8
@statPushFuncdef = external dso_local constant %struct.FuncDef, align 8
@.str.853 = private unnamed_addr constant [4 x i8] c"BBB\00", align 1
@.str.854 = private unnamed_addr constant [10 x i8] c"stat_init\00", align 1
@.str.855 = private unnamed_addr constant [10 x i8] c"stat_push\00", align 1
@statGetFuncdef = external dso_local constant %struct.FuncDef, align 8
@.str.856 = private unnamed_addr constant [9 x i8] c"stat_get\00", align 1
@.str.857 = private unnamed_addr constant [5 x i8] c"%llu\00", align 1
@.str.858 = private unnamed_addr constant [6 x i8] c" %llu\00", align 1
@.str.859 = private unnamed_addr constant [59 x i8] c"there is already another table or index with this name: %s\00", align 1
@.str.860 = private unnamed_addr constant [27 x i8] c"view %s may not be altered\00", align 1
@.str.861 = private unnamed_addr constant [173 x i8] c"UPDATE \22%w\22.%s SET sql = sqlite_rename_table(%Q, type, name, sql, %Q, %Q, %d) WHERE (type!='index' OR tbl_name=%Q COLLATE nocase)AND   name NOT LIKE 'sqliteX_%%' ESCAPE 'X'\00", align 1
@.str.862 = private unnamed_addr constant [294 x i8] c"UPDATE %Q.%s SET tbl_name = %Q, name = CASE WHEN type='table' THEN %Q WHEN name LIKE 'sqliteX_autoindex%%' ESCAPE 'X'      AND type='index' THEN 'sqlite_autoindex_' || %Q || substr(name,%d+18) ELSE name END WHERE tbl_name=%Q COLLATE nocase AND (type='table' OR type='index' OR type='trigger');\00", align 1
@.str.863 = private unnamed_addr constant [58 x i8] c"UPDATE \22%w\22.sqlite_sequence set name = %Q WHERE name = %Q\00", align 1
@.str.864 = private unnamed_addr constant [254 x i8] c"UPDATE sqlite_temp_master SET sql = sqlite_rename_table(%Q, type, name, sql, %Q, %Q, 1), tbl_name = CASE WHEN tbl_name=%Q COLLATE nocase AND           sqlite_rename_test(%Q, sql, type, name, 1) THEN %Q ELSE tbl_name END WHERE type IN ('view', 'trigger')\00", align 1
@.str.865 = private unnamed_addr constant [28 x i8] c"table %s may not be altered\00", align 1
@.str.866 = private unnamed_addr constant [156 x i8] c"SELECT 1 FROM \22%w\22.%s WHERE name NOT LIKE 'sqliteX_%%' ESCAPE 'X' AND sql NOT LIKE 'create virtual%%' AND sqlite_rename_test(%Q, sql, type, name, %d)=NULL \00", align 1
@.str.867 = private unnamed_addr constant [155 x i8] c"SELECT 1 FROM temp.%s WHERE name NOT LIKE 'sqliteX_%%' ESCAPE 'X' AND sql NOT LIKE 'create virtual%%' AND sqlite_rename_test(%Q, sql, type, name, 1)=NULL \00", align 1
@.str.868 = private unnamed_addr constant [32 x i8] c"Cannot add a PRIMARY KEY column\00", align 1
@.str.869 = private unnamed_addr constant [27 x i8] c"Cannot add a UNIQUE column\00", align 1
@.str.870 = private unnamed_addr constant [59 x i8] c"Cannot add a REFERENCES column with non-NULL default value\00", align 1
@.str.871 = private unnamed_addr constant [53 x i8] c"Cannot add a NOT NULL column with default value NULL\00", align 1
@.str.872 = private unnamed_addr constant [46 x i8] c"Cannot add a column with non-constant default\00", align 1
@.str.873 = private unnamed_addr constant [27 x i8] c"cannot add a STORED column\00", align 1
@.str.874 = private unnamed_addr constant [109 x i8] c"UPDATE \22%w\22.%s SET sql = substr(sql,1,%d) || ', ' || %Q || substr(sql,%d) WHERE type = 'table' AND name = %Q\00", align 1
@.str.875 = private unnamed_addr constant [30 x i8] c"Cannot add a column to a view\00", align 1
@.str.876 = private unnamed_addr constant [19 x i8] c"sqlite_altertab_%s\00", align 1
@.str.877 = private unnamed_addr constant [207 x i8] c"UPDATE \22%w\22.%s SET sql = sqlite_rename_column(sql, type, name, %Q, %Q, %d, %Q, %d, %d) WHERE name NOT LIKE 'sqliteX_%%' ESCAPE 'X'  AND (type != 'index' OR tbl_name = %Q) AND sql NOT LIKE 'create virtual%%'\00", align 1
@.str.878 = private unnamed_addr constant [120 x i8] c"UPDATE temp.%s SET sql = sqlite_rename_column(sql, type, name, %Q, %Q, %d, %Q, %d, 1) WHERE type IN ('trigger', 'view')\00", align 1
@.str.879 = private unnamed_addr constant [33 x i8] c"cannot rename columns of %s \22%s\22\00", align 1
@.str.880 = private unnamed_addr constant [30 x i8] c"duplicate WITH table name: %s\00", align 1
@.str.881 = private unnamed_addr constant [17 x i8] c"PARTITION clause\00", align 1
@.str.882 = private unnamed_addr constant [16 x i8] c"ORDER BY clause\00", align 1
@.str.883 = private unnamed_addr constant [20 x i8] c"frame specification\00", align 1
@.str.884 = private unnamed_addr constant [33 x i8] c"cannot override %s of window: %s\00", align 1
@.str.885 = private unnamed_addr constant [32 x i8] c"unsupported frame specification\00", align 1
@yy_reduce_ofst = internal unnamed_addr constant [380 x i16] [i16 -66, i16 490, i16 645, i16 545, i16 -174, i16 -172, i16 -187, i16 -178, i16 -113, i16 -176, i16 430, i16 537, i16 -63, i16 -136, i16 25, i16 -261, i16 37, i16 412, i16 803, i16 828, i16 872, i16 -171, i16 888, i16 892, i16 106, i16 589, i16 921, i16 -189, i16 670, i16 926, i16 -177, i16 196, i16 386, i16 395, i16 694, i16 855, i16 945, i16 948, i16 955, i16 964, i16 966, i16 969, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -147, i16 696, i16 726, i16 801, i16 820, i16 822, i16 928, i16 961, i16 1007, i16 1021, i16 1028, i16 1031, i16 1040, i16 1057, i16 1059, i16 1074, i16 1092, i16 1108, i16 1110, i16 1116, i16 1123, i16 1134, i16 1137, i16 1149, i16 1153, i16 1170, i16 1173, i16 1177, i16 1181, i16 1183, i16 1194, i16 1208, i16 1212, i16 1218, i16 1221, i16 1223, i16 1229, i16 1256, i16 1280, i16 1283, i16 1285, i16 1287, i16 1300, i16 1304, i16 1313, i16 1316, i16 1320, i16 1324, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -264, i16 -175, i16 -22, i16 394, i16 150, i16 220, i16 -180, i16 493, i16 663, i16 299, i16 493, i16 663, i16 193, i16 120, i16 336, i16 -264, i16 -264, i16 -264, i16 -264, i16 90, i16 90, i16 90, i16 436, i16 482, i16 8, i16 647, i16 889, i16 -160, i16 373, i16 -278, i16 554, i16 598, i16 653, i16 697, i16 717, i16 557, i16 393, i16 602, i16 723, i16 808, i16 450, i16 655, i16 802, i16 908, i16 916, i16 864, i16 1041, i16 868, i16 337, i16 870, i16 503, i16 1104, i16 552, i16 641, i16 -157, i16 32, i16 862, i16 968, i16 1050, i16 1195, i16 603, i16 1048, i16 963, i16 433, i16 -210, i16 -201, i16 -89, i16 -9, i16 55, i16 159, i16 320, i16 389, i16 454, i16 522, i16 594, i16 608, i16 666, i16 848, i16 924, i16 957, i16 1067, i16 1075, i16 1140, i16 1154, i16 747, i16 1167, i16 1191, i16 1220, i16 1222, i16 1226, i16 1239, i16 1263, i16 1275, i16 1286, i16 1290, i16 1146, i16 1234, i16 1269, i16 1319, i16 1330, i16 1349, i16 1358, i16 1228, i16 1364, i16 1365, i16 1366, i16 1271, i16 1022, i16 1371, i16 1379, i16 1338, i16 1382, i16 320, i16 1387, i16 1388, i16 1389, i16 1392, i16 1393, i16 1394, i16 1293, i16 1308, i16 1353, i16 1342, i16 1344, i16 1348, i16 1356, i16 1228, i16 1353, i16 1353, i16 1361, i16 1399, i16 1422, i16 1301, i16 1369, i16 1357, i16 1359, i16 1328, i16 1374, i16 1375, i16 1331, i16 1403, i16 1395, i16 1400, i16 1407, i16 1408, i16 1409, i16 1372, i16 1381, i16 1383, i16 1355, i16 1390, i16 1391, i16 1444, i16 1350, i16 1443, i16 1445, i16 1360, i16 1363, i16 1447, i16 1370, i16 1384, i16 1396, i16 1424, i16 1413, i16 1425, i16 1429, i16 1430, i16 1432, i16 1433, i16 1434, i16 1398, i16 1402, i16 1441, i16 1442, i16 1436, i16 1480, i16 1489, i16 1405, i16 1410, i16 1493, i16 1495, i16 1477, i16 1498, i16 1500, i16 1501, i16 1504, i16 1485, i16 1502, i16 1503, i16 1505, i16 1488, i16 1492, i16 1494, i16 1506, i16 1510, i16 1509, i16 1512, i16 1513, i16 1514, i16 1515, i16 1420, i16 1517, i16 1446, i16 1454, i16 1520, i16 1463, i16 1476, i16 1478, i16 1482, i16 1483, i16 1486, i16 1484, i16 1487, i16 1547, i16 1449, i16 1450, i16 1490, i16 1519, i16 1521, i16 1524, i16 1491, i16 1557, i16 1522, i16 1526, i16 1527, i16 1530, i16 1528, i16 1559, i16 1562, i16 1573, i16 1574, i16 1585, i16 1586, i16 1587, i16 1575, i16 1568, i16 1570, i16 1572, i16 1576, i16 1579, i16 1565, i16 1566, i16 1578, i16 1580, i16 1582, i16 1589], align 16
@.str.886 = private unnamed_addr constant [17 x i8] c"incomplete input\00", align 1
@.str.887 = private unnamed_addr constant [41 x i8] c"SELECT tbl,idx,stat FROM %Q.sqlite_stat1\00", align 1
@.str.888 = private unnamed_addr constant [11 x i8] c"unordered*\00", align 1
@.str.889 = private unnamed_addr constant [10 x i8] c"sz=[0-9]*\00", align 1
@.str.890 = private unnamed_addr constant [12 x i8] c"noskipscan*\00", align 1
@.str.891 = private unnamed_addr constant [16 x i8] c"Main freelist: \00", align 1
@.str.892 = private unnamed_addr constant [45 x i8] c"max rootpage (%d) disagrees with header (%d)\00", align 1
@.str.893 = private unnamed_addr constant [55 x i8] c"incremental_vacuum enabled with a max rootpage of zero\00", align 1
@.str.894 = private unnamed_addr constant [22 x i8] c"Page %d is never used\00", align 1
@.str.895 = private unnamed_addr constant [34 x i8] c"Pointer map page %d is referenced\00", align 1
@.str.896 = private unnamed_addr constant [22 x i8] c"failed to get page %d\00", align 1
@.str.897 = private unnamed_addr constant [39 x i8] c"freelist leaf count too big on page %d\00", align 1
@.str.898 = private unnamed_addr constant [26 x i8] c"%s is %d but should be %d\00", align 1
@.str.899 = private unnamed_addr constant [5 x i8] c"size\00", align 1
@.str.900 = private unnamed_addr constant [21 x i8] c"overflow list length\00", align 1
@.str.901 = private unnamed_addr constant [23 x i8] c"invalid page number %d\00", align 1
@.str.902 = private unnamed_addr constant [25 x i8] c"2nd reference to page %d\00", align 1
@.str.903 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.904 = private unnamed_addr constant [29 x i8] c"Failed to read ptrmap key=%d\00", align 1
@.str.905 = private unnamed_addr constant [54 x i8] c"Bad ptr map entry key=%d expected=(%d,%d) got=(%d,%d)\00", align 1
@.str.906 = private unnamed_addr constant [10 x i8] c"Page %d: \00", align 1
@.str.907 = private unnamed_addr constant [38 x i8] c"unable to get the page. error code=%d\00", align 1
@.str.908 = private unnamed_addr constant [38 x i8] c"btreeInitPage() returns error code %d\00", align 1
@.str.909 = private unnamed_addr constant [22 x i8] c"free space corruption\00", align 1
@.str.910 = private unnamed_addr constant [26 x i8] c"On tree page %d cell %d: \00", align 1
@.str.911 = private unnamed_addr constant [28 x i8] c"On page %d at right child: \00", align 1
@.str.912 = private unnamed_addr constant [30 x i8] c"Offset %d out of range %d..%d\00", align 1
@.str.913 = private unnamed_addr constant [24 x i8] c"Extends off end of page\00", align 1
@.str.914 = private unnamed_addr constant [24 x i8] c"Rowid %lld out of order\00", align 1
@.str.915 = private unnamed_addr constant [25 x i8] c"Child page depth differs\00", align 1
@.str.916 = private unnamed_addr constant [37 x i8] c"Multiple uses for byte %u of page %d\00", align 1
@.str.917 = private unnamed_addr constant [52 x i8] c"Fragmentation of %d bytes reported as %d on page %d\00", align 1
@sqlite3JournalModename.azModeName = internal unnamed_addr constant [6 x i8*] [i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.918, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.919, i32 0, i32 0), i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.920, i32 0, i32 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.694, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.735, i32 0, i32 0), i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.921, i32 0, i32 0)], align 16
@.str.918 = private unnamed_addr constant [7 x i8] c"delete\00", align 1
@.str.919 = private unnamed_addr constant [8 x i8] c"persist\00", align 1
@.str.920 = private unnamed_addr constant [4 x i8] c"off\00", align 1
@.str.921 = private unnamed_addr constant [4 x i8] c"wal\00", align 1
@.str.922 = private unnamed_addr constant [40 x i8] c"cannot VACUUM from within a transaction\00", align 1
@.str.923 = private unnamed_addr constant [43 x i8] c"cannot VACUUM - SQL statements in progress\00", align 1
@.str.924 = private unnamed_addr constant [18 x i8] c"non-text filename\00", align 1
@.str.925 = private unnamed_addr constant [23 x i8] c"ATTACH %Q AS vacuum_db\00", align 1
@.str.926 = private unnamed_addr constant [27 x i8] c"output file already exists\00", align 1
@.str.927 = private unnamed_addr constant [108 x i8] c"SELECT sql FROM \22%w\22.sqlite_master WHERE type='table'AND name<>'sqlite_sequence' AND coalesce(rootpage,1)>0\00", align 1
@.str.928 = private unnamed_addr constant [54 x i8] c"SELECT sql FROM \22%w\22.sqlite_master WHERE type='index'\00", align 1
@.str.929 = private unnamed_addr constant [151 x i8] c"SELECT'INSERT INTO vacuum_db.'||quote(name)||' SELECT*FROM\22%w\22.'||quote(name)FROM vacuum_db.sqlite_master WHERE type='table'AND coalesce(rootpage,1)>0\00", align 1
@.str.930 = private unnamed_addr constant [130 x i8] c"INSERT INTO vacuum_db.sqlite_master SELECT*FROM \22%w\22.sqlite_master WHERE type IN('view','trigger') OR(type='table'AND rootpage=0)\00", align 1
@sqlite3RunVacuum.aCopy = internal unnamed_addr constant [10 x i8] c"\01\01\03\00\05\00\06\00\08\00", align 1
@.str.931 = private unnamed_addr constant [4 x i8] c"CRE\00", align 1
@.str.932 = private unnamed_addr constant [4 x i8] c"INS\00", align 1
@columnNullValue.nullMem = internal constant %struct.sqlite3_value { %union.MemValue zeroinitializer, i16 1, i8 0, i8 0, i32 0, i8* null, i8* null, i32 0, i32 0, %struct.sqlite3* null, void (i8*)* null }, align 8
@.str.933 = private unnamed_addr constant [40 x i8] c"bind on a busy prepared statement: [%s]\00", align 1
@.str.934 = private unnamed_addr constant [19 x i8] c"922337203685477580\00", align 1
@.str.935 = private unnamed_addr constant [7 x i8] c"%!.15g\00", align 1
@sqlite3VdbeMakeReady.azColName = internal unnamed_addr constant [12 x i8*] [i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.936, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.937, i32 0, i32 0), i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.938, i32 0, i32 0), i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.939, i32 0, i32 0), i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.940, i32 0, i32 0), i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.941, i32 0, i32 0), i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.942, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.943, i32 0, i32 0), i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.696, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.723, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.944, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.945, i32 0, i32 0)], align 16
@.str.936 = private unnamed_addr constant [5 x i8] c"addr\00", align 1
@.str.937 = private unnamed_addr constant [7 x i8] c"opcode\00", align 1
@.str.938 = private unnamed_addr constant [3 x i8] c"p1\00", align 1
@.str.939 = private unnamed_addr constant [3 x i8] c"p2\00", align 1
@.str.940 = private unnamed_addr constant [3 x i8] c"p3\00", align 1
@.str.941 = private unnamed_addr constant [3 x i8] c"p4\00", align 1
@.str.942 = private unnamed_addr constant [3 x i8] c"p5\00", align 1
@.str.943 = private unnamed_addr constant [8 x i8] c"comment\00", align 1
@.str.944 = private unnamed_addr constant [8 x i8] c"notused\00", align 1
@.str.945 = private unnamed_addr constant [7 x i8] c"detail\00", align 1
@.str.946 = private unnamed_addr constant [29 x i8] c"cannot open value of type %s\00", align 1
@.str.947 = private unnamed_addr constant [5 x i8] c"null\00", align 1
@.str.948 = private unnamed_addr constant [5 x i8] c"real\00", align 1
@.str.949 = private unnamed_addr constant [8 x i8] c"integer\00", align 1
@.str.950 = private unnamed_addr constant [20 x i8] c"no such rowid: %lld\00", align 1
@.str.951 = private unnamed_addr constant [13 x i8] c"no such view\00", align 1
@.str.952 = private unnamed_addr constant [14 x i8] c"no such table\00", align 1
@.str.953 = private unnamed_addr constant [9 x i8] c"unopened\00", align 1
@.str.954 = private unnamed_addr constant [45 x i8] c"API call with %s database connection pointer\00", align 1
@.str.955 = private unnamed_addr constant [6 x i8] c"dylib\00", align 1
@.str.956 = private unnamed_addr constant [23 x i8] c"sqlite3_extension_init\00", align 1
@.str.957 = private unnamed_addr constant [35 x i8] c"unable to open shared library [%s]\00", align 1
@.str.959 = private unnamed_addr constant [4 x i8] c"lib\00", align 1
@.str.960 = private unnamed_addr constant [6 x i8] c"_init\00", align 1
@.str.961 = private unnamed_addr constant [43 x i8] c"no entry point [%s] in shared library [%s]\00", align 1
@sqlite3Apis = external dso_local constant %struct.sqlite3_api_routines, align 8
@.str.962 = private unnamed_addr constant [32 x i8] c"error during initialization: %s\00", align 1
@.str.963 = private unnamed_addr constant [65 x i8] c"sqlite3_get_table() called with two or more incompatible queries\00", align 1
@sqlite3RegisterBuiltinFunctions.aBuiltinFunc = external dso_local global [62 x %struct.FuncDef], align 16
@.str.964 = private unnamed_addr constant [20 x i8] c"implies_nonnull_row\00", align 1
@.str.965 = private unnamed_addr constant [13 x i8] c"expr_compare\00", align 1
@.str.966 = private unnamed_addr constant [18 x i8] c"expr_implies_expr\00", align 1
@.str.967 = private unnamed_addr constant [15 x i8] c"load_extension\00", align 1
@.str.968 = private unnamed_addr constant [26 x i8] c"sqlite_compileoption_used\00", align 1
@.str.969 = private unnamed_addr constant [25 x i8] c"sqlite_compileoption_get\00", align 1
@.str.970 = private unnamed_addr constant [9 x i8] c"unlikely\00", align 1
@.str.971 = private unnamed_addr constant [11 x i8] c"likelihood\00", align 1
@.str.972 = private unnamed_addr constant [7 x i8] c"likely\00", align 1
@.str.973 = private unnamed_addr constant [6 x i8] c"ltrim\00", align 1
@.str.974 = private unnamed_addr constant [6 x i8] c"rtrim\00", align 1
@.str.975 = private unnamed_addr constant [5 x i8] c"trim\00", align 1
@.str.976 = private unnamed_addr constant [7 x i8] c"typeof\00", align 1
@.str.977 = private unnamed_addr constant [7 x i8] c"length\00", align 1
@.str.978 = private unnamed_addr constant [6 x i8] c"instr\00", align 1
@.str.979 = private unnamed_addr constant [7 x i8] c"printf\00", align 1
@.str.980 = private unnamed_addr constant [8 x i8] c"unicode\00", align 1
@.str.981 = private unnamed_addr constant [5 x i8] c"char\00", align 1
@.str.982 = private unnamed_addr constant [4 x i8] c"abs\00", align 1
@.str.983 = private unnamed_addr constant [6 x i8] c"round\00", align 1
@.str.984 = private unnamed_addr constant [6 x i8] c"upper\00", align 1
@.str.985 = private unnamed_addr constant [6 x i8] c"lower\00", align 1
@.str.986 = private unnamed_addr constant [4 x i8] c"hex\00", align 1
@.str.987 = private unnamed_addr constant [7 x i8] c"ifnull\00", align 1
@.str.988 = private unnamed_addr constant [7 x i8] c"random\00", align 1
@.str.989 = private unnamed_addr constant [11 x i8] c"randomblob\00", align 1
@.str.990 = private unnamed_addr constant [7 x i8] c"nullif\00", align 1
@.str.991 = private unnamed_addr constant [15 x i8] c"sqlite_version\00", align 1
@.str.992 = private unnamed_addr constant [17 x i8] c"sqlite_source_id\00", align 1
@.str.993 = private unnamed_addr constant [11 x i8] c"sqlite_log\00", align 1
@.str.994 = private unnamed_addr constant [6 x i8] c"quote\00", align 1
@.str.995 = private unnamed_addr constant [18 x i8] c"last_insert_rowid\00", align 1
@.str.996 = private unnamed_addr constant [8 x i8] c"changes\00", align 1
@.str.997 = private unnamed_addr constant [14 x i8] c"total_changes\00", align 1
@.str.998 = private unnamed_addr constant [8 x i8] c"replace\00", align 1
@.str.999 = private unnamed_addr constant [9 x i8] c"zeroblob\00", align 1
@.str.1000 = private unnamed_addr constant [7 x i8] c"substr\00", align 1
@.str.1001 = private unnamed_addr constant [4 x i8] c"sum\00", align 1
@.str.1002 = private unnamed_addr constant [6 x i8] c"total\00", align 1
@.str.1003 = private unnamed_addr constant [4 x i8] c"avg\00", align 1
@.str.1004 = private unnamed_addr constant [6 x i8] c"count\00", align 1
@.str.1005 = private unnamed_addr constant [13 x i8] c"group_concat\00", align 1
@.str.1006 = private unnamed_addr constant [5 x i8] c"glob\00", align 1
@.str.1007 = private unnamed_addr constant [9 x i8] c"coalesce\00", align 1
@trimFunc.lenOne = internal unnamed_addr constant [1 x i8] c"\01", align 1
@trimFunc.azOne = internal constant [1 x i8*] [i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.623, i32 0, i32 0)], align 8
@typeofFunc.azType = internal unnamed_addr constant [5 x i8*] [i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.949, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.948, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.1008, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.1009, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.947, i32 0, i32 0)], align 16
@.str.1008 = private unnamed_addr constant [5 x i8] c"text\00", align 1
@.str.1009 = private unnamed_addr constant [5 x i8] c"blob\00", align 1
@.str.1010 = private unnamed_addr constant [17 x i8] c"integer overflow\00", align 1
@.str.1011 = private unnamed_addr constant [5 x i8] c"%.*f\00", align 1
@hexdigits = internal unnamed_addr constant [16 x i8] c"0123456789ABCDEF", align 16
@.str.1012 = private unnamed_addr constant [7 x i8] c"%!.20e\00", align 1
@sqlite3AlterFunctions.aAlterTableFuncs = external dso_local global [3 x %struct.FuncDef], align 16
@.str.1013 = private unnamed_addr constant [21 x i8] c"sqlite_rename_column\00", align 1
@.str.1014 = private unnamed_addr constant [20 x i8] c"sqlite_rename_table\00", align 1
@.str.1015 = private unnamed_addr constant [19 x i8] c"sqlite_rename_test\00", align 1
@.str.1016 = private unnamed_addr constant [5 x i8] c"\22%w\22\00", align 1
@.str.1017 = private unnamed_addr constant [21 x i8] c"error in %s %s%s: %s\00", align 1
@.str.1018 = private unnamed_addr constant [14 x i8] c" after rename\00", align 1
@sqlite3WindowFunctions.aWindowFuncs = external dso_local global [15 x %struct.FuncDef], align 16
@last_valueName = internal constant [11 x i8] c"last_value\00", align 1
@.str.1019 = private unnamed_addr constant [45 x i8] c"argument of ntile must be a positive integer\00", align 1
@sqlite3RegisterDateTimeFunctions_aDateTimeFuncs = external dso_local global [8 x %struct.FuncDef], align 16
@.str.1020 = private unnamed_addr constant [10 x i8] c"julianday\00", align 1
@.str.1021 = private unnamed_addr constant [5 x i8] c"date\00", align 1
@.str.1022 = private unnamed_addr constant [5 x i8] c"time\00", align 1
@.str.1023 = private unnamed_addr constant [9 x i8] c"datetime\00", align 1
@.str.1024 = private unnamed_addr constant [9 x i8] c"strftime\00", align 1
@.str.1025 = private unnamed_addr constant [13 x i8] c"current_time\00", align 1
@.str.1026 = private unnamed_addr constant [18 x i8] c"current_timestamp\00", align 1
@.str.1027 = private unnamed_addr constant [13 x i8] c"current_date\00", align 1
@.str.1028 = private unnamed_addr constant [4 x i8] c"now\00", align 1
@.str.1029 = private unnamed_addr constant [12 x i8] c"40f-21a-21d\00", align 1
@getDigits.aMx = internal unnamed_addr constant [6 x i16] [i16 12, i16 14, i16 24, i16 31, i16 59, i16 9999], align 2
@.str.1030 = private unnamed_addr constant [8 x i8] c"20c:20e\00", align 1
@.str.1031 = private unnamed_addr constant [4 x i8] c"20e\00", align 1
@.str.1032 = private unnamed_addr constant [8 x i8] c"20b:20e\00", align 1
@.str.1033 = private unnamed_addr constant [19 x i8] c"a CHECK constraint\00", align 1
@.str.1034 = private unnamed_addr constant [19 x i8] c"a generated column\00", align 1
@.str.1035 = private unnamed_addr constant [9 x i8] c"an index\00", align 1
@.str.1036 = private unnamed_addr constant [36 x i8] c"non-deterministic use of %s() in %s\00", align 1
@.str.1037 = private unnamed_addr constant [10 x i8] c"localtime\00", align 1
@.str.1038 = private unnamed_addr constant [10 x i8] c"unixepoch\00", align 1
@.str.1039 = private unnamed_addr constant [4 x i8] c"utc\00", align 1
@.str.1040 = private unnamed_addr constant [9 x i8] c"weekday \00", align 1
@.str.1041 = private unnamed_addr constant [10 x i8] c"start of \00", align 1
@.str.1042 = private unnamed_addr constant [6 x i8] c"month\00", align 1
@.str.1043 = private unnamed_addr constant [5 x i8] c"year\00", align 1
@.str.1044 = private unnamed_addr constant [4 x i8] c"day\00", align 1
@aXformType = internal unnamed_addr constant [6 x %struct.anon.23] [%struct.anon.23 { i8 0, i8 6, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.1046, i32 0, i32 0), double 0x425B0625EAB00000, double 1.000000e+03 }, %struct.anon.23 { i8 0, i8 6, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.1047, i32 0, i32 0), double 0x41FCD35BA5000000, double 6.000000e+04 }, %struct.anon.23 { i8 0, i8 4, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.1048, i32 0, i32 0), double 0x419EBF50B0000000, double 3.600000e+06 }, %struct.anon.23 { i8 0, i8 3, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.1044, i32 0, i32 0), double 0x41547F8B40000000, double 8.640000e+07 }, %struct.anon.23 { i8 1, i8 5, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.1042, i32 0, i32 0), double 1.765460e+05, double 2.592000e+09 }, %struct.anon.23 { i8 2, i8 4, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.1043, i32 0, i32 0), double 1.471300e+04, double 3.153600e+10 }], align 16
@.str.1045 = private unnamed_addr constant [23 x i8] c"local time unavailable\00", align 1
@.str.1046 = private unnamed_addr constant [7 x i8] c"second\00", align 1
@.str.1047 = private unnamed_addr constant [7 x i8] c"minute\00", align 1
@.str.1048 = private unnamed_addr constant [5 x i8] c"hour\00", align 1
@.str.1049 = private unnamed_addr constant [15 x i8] c"%04d-%02d-%02d\00", align 1
@.str.1050 = private unnamed_addr constant [15 x i8] c"%02d:%02d:%02d\00", align 1
@.str.1051 = private unnamed_addr constant [30 x i8] c"%04d-%02d-%02d %02d:%02d:%02d\00", align 1
@.str.1052 = private unnamed_addr constant [5 x i8] c"%02d\00", align 1
@.str.1053 = private unnamed_addr constant [7 x i8] c"%06.3f\00", align 1
@.str.1054 = private unnamed_addr constant [5 x i8] c"%03d\00", align 1
@.str.1055 = private unnamed_addr constant [5 x i8] c"%04d\00", align 1
@sqlite3MemSetDefault_defaultMethods = external dso_local constant %struct.sqlite3_mem_methods, align 8
@_sqliteZone_ = internal unnamed_addr global %struct._malloc_zone_t* null, align 8
@.str.1056 = private unnamed_addr constant [38 x i8] c"failed to allocate %u bytes of memory\00", align 1
@.str.1057 = private unnamed_addr constant [36 x i8] c"failed memory resize %u to %u bytes\00", align 1
@.str.1058 = private unnamed_addr constant [8 x i8] c"hw.ncpu\00", align 1
@.str.1059 = private unnamed_addr constant [12 x i8] c"Sqlite_Heap\00", align 1
@sqlite3PCacheSetDefault_defaultMethods = external dso_local constant %struct.sqlite3_pcache_methods2, align 8
@.str.1060 = private unnamed_addr constant [68 x i8] c"unable to close due to unfinalized statements or unfinished backups\00", align 1
@sqlite3ErrStr.aMsg = internal unnamed_addr constant [29 x i8*] [i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.1061, i32 0, i32 0), i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.1062, i32 0, i32 0), i8* null, i8* getelementptr inbounds ([25 x i8], [25 x i8]* @.str.1063, i32 0, i32 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1064, i32 0, i32 0), i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.1065, i32 0, i32 0), i8* getelementptr inbounds ([25 x i8], [25 x i8]* @.str.1066, i32 0, i32 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.355, i32 0, i32 0), i8* getelementptr inbounds ([37 x i8], [37 x i8]* @.str.1067, i32 0, i32 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.1068, i32 0, i32 0), i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.str.1069, i32 0, i32 0), i8* getelementptr inbounds ([33 x i8], [33 x i8]* @.str.1070, i32 0, i32 0), i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.1071, i32 0, i32 0), i8* getelementptr inbounds ([25 x i8], [25 x i8]* @.str.1072, i32 0, i32 0), i8* getelementptr inbounds ([29 x i8], [29 x i8]* @.str.1073, i32 0, i32 0), i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.1074, i32 0, i32 0), i8* null, i8* getelementptr inbounds ([28 x i8], [28 x i8]* @.str.346, i32 0, i32 0), i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.23, i32 0, i32 0), i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.1075, i32 0, i32 0), i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.1076, i32 0, i32 0), i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.str.1077, i32 0, i32 0), i8* null, i8* getelementptr inbounds ([21 x i8], [21 x i8]* @.str.1078, i32 0, i32 0), i8* null, i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.1079, i32 0, i32 0), i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.1080, i32 0, i32 0), i8* getelementptr inbounds ([21 x i8], [21 x i8]* @.str.1081, i32 0, i32 0), i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.1082, i32 0, i32 0)], align 16
@.str.1061 = private unnamed_addr constant [13 x i8] c"not an error\00", align 1
@.str.1062 = private unnamed_addr constant [16 x i8] c"SQL logic error\00", align 1
@.str.1063 = private unnamed_addr constant [25 x i8] c"access permission denied\00", align 1
@.str.1064 = private unnamed_addr constant [14 x i8] c"query aborted\00", align 1
@.str.1065 = private unnamed_addr constant [19 x i8] c"database is locked\00", align 1
@.str.1066 = private unnamed_addr constant [25 x i8] c"database table is locked\00", align 1
@.str.1067 = private unnamed_addr constant [37 x i8] c"attempt to write a readonly database\00", align 1
@.str.1068 = private unnamed_addr constant [12 x i8] c"interrupted\00", align 1
@.str.1069 = private unnamed_addr constant [15 x i8] c"disk I/O error\00", align 1
@.str.1070 = private unnamed_addr constant [33 x i8] c"database disk image is malformed\00", align 1
@.str.1071 = private unnamed_addr constant [18 x i8] c"unknown operation\00", align 1
@.str.1072 = private unnamed_addr constant [25 x i8] c"database or disk is full\00", align 1
@.str.1073 = private unnamed_addr constant [29 x i8] c"unable to open database file\00", align 1
@.str.1074 = private unnamed_addr constant [17 x i8] c"locking protocol\00", align 1
@.str.1075 = private unnamed_addr constant [18 x i8] c"constraint failed\00", align 1
@.str.1076 = private unnamed_addr constant [18 x i8] c"datatype mismatch\00", align 1
@.str.1077 = private unnamed_addr constant [34 x i8] c"bad parameter or other API misuse\00", align 1
@.str.1078 = private unnamed_addr constant [21 x i8] c"authorization denied\00", align 1
@.str.1079 = private unnamed_addr constant [26 x i8] c"column index out of range\00", align 1
@.str.1080 = private unnamed_addr constant [23 x i8] c"file is not a database\00", align 1
@.str.1081 = private unnamed_addr constant [21 x i8] c"notification message\00", align 1
@.str.1082 = private unnamed_addr constant [16 x i8] c"warning message\00", align 1
@.str.1083 = private unnamed_addr constant [14 x i8] c"unknown error\00", align 1
@.str.1084 = private unnamed_addr constant [22 x i8] c"abort due to ROLLBACK\00", align 1
@.str.1085 = private unnamed_addr constant [22 x i8] c"another row available\00", align 1
@.str.1086 = private unnamed_addr constant [23 x i8] c"no more rows available\00", align 1
@.str.1087 = private unnamed_addr constant [63 x i8] c"unable to delete/modify user-function due to active statements\00", align 1
@.str.1088 = private unnamed_addr constant [51 x i8] c"unable to use function %s in the requested context\00", align 1
@.str.1089 = private unnamed_addr constant [5 x i8] c"main\00", align 1
@.str.1090 = private unnamed_addr constant [8 x i8] c"invalid\00", align 1
@.str.1091 = private unnamed_addr constant [6 x i8] c"RTRIM\00", align 1
@.str.1092 = private unnamed_addr constant [6 x i8] c"MATCH\00", align 1
@.str.1093 = private unnamed_addr constant [39 x i8] c"automatic extension loading failed: %s\00", align 1
@.str.1094 = private unnamed_addr constant [68 x i8] c"unable to delete/modify collation sequence due to active statements\00", align 1
@.str.1095 = private unnamed_addr constant [7 x i8] c"misuse\00", align 1
@.str.1096 = private unnamed_addr constant [8 x i8] c"_ROWID_\00", align 1
@.str.1097 = private unnamed_addr constant [4 x i8] c"OID\00", align 1
@sqlite3SavedPrng = internal unnamed_addr global %struct.sqlite3PrngType zeroinitializer, align 1
@sqlite3azCompileOpt = internal unnamed_addr constant [4 x i8*] [i8* getelementptr inbounds ([22 x i8], [22 x i8]* @.str.1098, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.1099, i32 0, i32 0), i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.1100, i32 0, i32 0), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.1101, i32 0, i32 0)], align 16
@.str.1098 = private unnamed_addr constant [22 x i8] c"COMPILER=clang-11.0.0\00", align 1
@.str.1099 = private unnamed_addr constant [11 x i8] c"OMIT_TRACE\00", align 1
@.str.1100 = private unnamed_addr constant [18 x i8] c"OMIT_VIRTUALTABLE\00", align 1
@.str.1101 = private unnamed_addr constant [13 x i8] c"THREADSAFE=1\00", align 1
@sqlite3Autoext.0 = internal unnamed_addr global i32 0, align 8
@sqlite3Autoext.1 = internal unnamed_addr global void ()** null, align 8
@sqlite3Hooks.0 = internal unnamed_addr global void ()* null, align 8
@sqlite3Hooks.1 = internal unnamed_addr global void ()* null, align 8
@switch.table.sqlite3Pragma.1262 = private unnamed_addr constant [4 x i8*] [i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.809, i64 0, i64 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.806, i64 0, i64 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.807, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.808, i64 0, i64 0)], align 8
@switch.table.multiSelectOrderBy = private unnamed_addr constant [3 x i8*] [i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.493, i64 0, i64 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.495, i64 0, i64 0), i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.494, i64 0, i64 0)], align 8

declare i8* @malloc(i64)

declare void @free(i8*)

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare void @my_assert(i1, i64, i8*) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare void @dbg() #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare void @printTypeOf(i8*, i32, %struct.Vdbe*, %struct.sqlite3_value*) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare void @vdbeMemClearExternAndSetNull(%struct.sqlite3_value*) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare void @sqlite3VdbeIntegerAffinity(%struct.sqlite3_value*) #0

; Function Attrs: alwaysinline nofree norecurse nounwind ssp uwtable
define dso_local fastcc i32 @sqlite3AtoF(i8* readonly %z, double* nocapture %pResult, i32 %length, i8 zeroext %enc) unnamed_addr #1 {
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

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare void @sqlite3_randomness(i32, i8*) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare void @sqlite3VdbeMemIntegerify(%struct.sqlite3_value*) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare void @sqlite3UnlinkAndDeleteTable(%struct.sqlite3*, i32, i8*) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare void @sqlite3ExpirePreparedStatements(%struct.sqlite3*, i32) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i32 @sqlite3BtreeUpdateMeta(%struct.Btree*, i32, i32) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare void @sqlite3VdbeFreeCursor(%struct.Vdbe*, %struct.VdbeCursor*) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i32 @sqlite3VdbeMemSetStr(%struct.sqlite3_value*, i8*, i32, i8, void (i8*)*) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare void @sqlite3BtreeGetMeta(%struct.Btree*, i32, i32*) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i32 @sqlite3VdbeMemCast(%struct.sqlite3_value*, i8, i8) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i32 @sqlite3BtreePrevious(%struct.BtCursor*, i32) #0

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

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare void @sqlite3DbFreeNN(%struct.sqlite3*, i8*) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare void @sqlite3VdbeRecordUnpack(%struct.KeyInfo*, i32, i8*, %struct.UnpackedRecord*) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare %struct.UnpackedRecord* @sqlite3VdbeAllocUnpackedRecord(%struct.KeyInfo*) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i32 @sqlite3BtreeCreateTable(%struct.Btree*, i32*, i32) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i32 @sqlite3BtreeOpen(%struct.sqlite3_vfs*, i8*, %struct.sqlite3*, %struct.Btree**, i32, i32) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i32 @sqlite3BtreeMovetoUnpacked(%struct.BtCursor*, %struct.UnpackedRecord*, i64, i32, i32*) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i32 @sqlite3BtreeLast(%struct.BtCursor*, i32*) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i32 @sqlite3BtreeCursorIsValidNN(%struct.BtCursor*) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i32 @sqlite3BtreeInsert(%struct.BtCursor*, %struct.BtreePayload*, i32, i32) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i32 @sqlite3VdbeIdxKeyCompare(%struct.sqlite3*, %struct.VdbeCursor*, %struct.UnpackedRecord*, i32*) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i32 @sqlite3VdbeCursorRestore(%struct.VdbeCursor*) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i32 @sqlite3VdbeIdxRowid(%struct.sqlite3*, %struct.BtCursor*, i64*) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i32 @sqlite3BtreeDelete(%struct.BtCursor*, i8) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i64 @sqlite3BtreeIntegerKey(%struct.BtCursor*) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i32 @sqlite3BtreeClearTable(%struct.Btree*, i32, i32*) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i16 @computeNumericType(%struct.sqlite3_value*) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i8* @sqlite3_value_text(%struct.sqlite3_value*) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare void @sqlite3VdbeError(%struct.Vdbe*, i8*, ...) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i32 @sqlite3VdbeBooleanValue(%struct.sqlite3_value*, i32) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i32 @sqlite3VdbeMemTooBig(%struct.sqlite3_value*) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i32 @sqlite3VdbeMemStringify(%struct.sqlite3_value*, i8, i8) #0

; Function Attrs: alwaysinline nounwind ssp uwtable
define void @applyNumericAffinity(%struct.sqlite3_value* nocapture %pRec, i32 %bTryForInt) local_unnamed_addr #2 {
entry:
  %rValue = alloca double, align 8
  %0 = bitcast double* %rValue to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %0) #4
  %enc1 = getelementptr inbounds %struct.sqlite3_value, %struct.sqlite3_value* %pRec, i64 0, i32 2
  %1 = load i8, i8* %enc1, align 2, !tbaa !11
  %z = getelementptr inbounds %struct.sqlite3_value, %struct.sqlite3_value* %pRec, i64 0, i32 5
  %2 = load i8*, i8** %z, align 8, !tbaa !16
  %n = getelementptr inbounds %struct.sqlite3_value, %struct.sqlite3_value* %pRec, i64 0, i32 4
  %3 = load i32, i32* %n, align 4, !tbaa !17
  %call = call fastcc i32 @sqlite3AtoF(i8* %2, double* nonnull %rValue, i32 %3, i8 zeroext %1)
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
  store i64 %conv.i, i64* %i, align 8, !tbaa !18
  br label %if.then4

alsoAnInt.exit:                                   ; preds = %lor.rhs.i.i
  %10 = load i8*, i8** %z, align 8, !tbaa !16
  %11 = load i32, i32* %n, align 4, !tbaa !17
  %12 = load i8, i8* %enc1, align 2, !tbaa !11
  %call1.i = tail call fastcc i32 @sqlite3Atoi64(i8* %10, i64* %i, i32 %11, i8 zeroext %12) #4
  %cmp.i = icmp eq i32 %call1.i, 0
  br i1 %cmp.i, label %if.then4, label %if.else

if.then4:                                         ; preds = %alsoAnInt.exit, %alsoAnInt.exit.thread
  %flags = getelementptr inbounds %struct.sqlite3_value, %struct.sqlite3_value* %pRec, i64 0, i32 1
  %13 = load i16, i16* %flags, align 8, !tbaa !20
  %14 = or i16 %13, 4
  store i16 %14, i16* %flags, align 8, !tbaa !20
  br label %if.end14

if.else:                                          ; preds = %alsoAnInt.exit, %if.end
  %15 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %pRec, i64 0, i32 0, i32 0
  store double %4, double* %15, align 8, !tbaa !10
  %flags7 = getelementptr inbounds %struct.sqlite3_value, %struct.sqlite3_value* %pRec, i64 0, i32 1
  %16 = load i16, i16* %flags7, align 8, !tbaa !20
  %17 = or i16 %16, 8
  store i16 %17, i16* %flags7, align 8, !tbaa !20
  %tobool11 = icmp eq i32 %bTryForInt, 0
  br i1 %tobool11, label %if.end14, label %if.then12

if.then12:                                        ; preds = %if.else
  %call.i = tail call fastcc i64 @doubleToInt64(double %4) #4
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
  store i16 %22, i16* %flags7, align 8, !tbaa !20
  br label %if.end14

if.end14:                                         ; preds = %if.then.i33, %if.then12, %if.else, %if.then4
  %23 = phi i16 [ %22, %if.then.i33 ], [ %17, %if.then12 ], [ %17, %if.else ], [ %14, %if.then4 ]
  %flags15 = getelementptr inbounds %struct.sqlite3_value, %struct.sqlite3_value* %pRec, i64 0, i32 1
  %24 = and i16 %23, -3
  store i16 %24, i16* %flags15, align 8, !tbaa !20
  br label %cleanup

cleanup:                                          ; preds = %if.end14, %entry
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %0) #4
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

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i16 @numericType(%struct.sqlite3_value*) #0

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

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare void @applyAffinity(%struct.sqlite3_value*, i8, i8) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i32 @sqlite3VdbeSorterInit(%struct.sqlite3*, i32, %struct.VdbeCursor*) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i32 @sqlite3MemCompare(%struct.sqlite3_value*, %struct.sqlite3_value*, %struct.CollSeq*) #0

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

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i8* @sqlite3DbMallocRawNN(%struct.sqlite3*, i64) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare void @sqlite3VdbeMemInit(%struct.sqlite3_value*, %struct.sqlite3*, i16) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare %struct.sqlite3_value* @out2PrereleaseWithClear(%struct.sqlite3_value*) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i32 @sqlite3BtreeBeginStmt(%struct.Btree*, i32) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i32 @sqlite3BtreeBeginTrans(%struct.Btree*, i32, i32*) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i32 @sqlite3VdbeHalt(%struct.Vdbe*) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i32 @sqlite3BtreeNext(%struct.BtCursor*, i32) #0

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
declare dso_local fastcc i32 @sqlite3VdbeMemGrow(%struct.sqlite3_value*, i32, i32) unnamed_addr #3

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare i32 @sqlite3VdbeSerialGet(i8*, i32, %struct.sqlite3_value*) #0

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare void @f_sqlite3VdbeMemRelease(%struct.sqlite3_value*) #0

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

; Function Attrs: norecurse nounwind nonlazybind uwtable willreturn
declare %struct.VdbeCursor* @allocateCursor(%struct.Vdbe*, i32, i32, i32, i8) #0

declare void @printProgress(i64, i32, i64)

declare void @printInt(i64, i64, i32, i64)

declare void @printDouble(double, i64, i32, i64)

declare void @printPtrAndValue(i64, i64, i64, i32, i64, i1)

define i32 @jittedFunction(%struct.Vdbe* %0) !dbg !21 {
  %2 = getelementptr %struct.Vdbe, %struct.Vdbe* %0, i32 0, i32 19, !dbg !25
  %3 = load %struct.sqlite3_value*, %struct.sqlite3_value** %2, align 8, !dbg !27
  %4 = getelementptr %struct.Vdbe, %struct.Vdbe* %0, i32 0, i32 21, !dbg !28
  %5 = load %struct.VdbeCursor**, %struct.VdbeCursor*** %4, align 8, !dbg !29
  %6 = getelementptr %struct.Vdbe, %struct.Vdbe* %0, i32 0, i32 23, !dbg !30
  %7 = load %struct.VdbeOp*, %struct.VdbeOp** %6, align 8, !dbg !31
  %8 = getelementptr %struct.Vdbe, %struct.Vdbe* %0, i32 0, i32 0, !dbg !32
  %9 = load %struct.sqlite3*, %struct.sqlite3** %8, align 8, !dbg !33
  %10 = getelementptr %struct.Vdbe, %struct.Vdbe* %0, i32 0, i32 10, !dbg !34
  %11 = load i32, i32* %10, align 4, !dbg !35
  switch i32 %11, label %12 [
    i32 13, label %16
    i32 1, label %16
    i32 2, label %16
    i32 3, label %33
    i32 4, label %56
    i32 5, label %319
    i32 6, label %584
    i32 7, label %849
    i32 8, label %1114
    i32 9, label %1379
    i32 10, label %1423
    i32 11, label %1436
    i32 12, label %1438
  ], !dbg !36

12:                                               ; preds = %1
  %13 = getelementptr %struct.VdbeOp, %struct.VdbeOp* %7, i32 0, i32 3, !dbg !37
  %14 = load i32, i32* %13, align 4, !dbg !40
  %15 = add i32 %14, 1, !dbg !41
  store i32 %15, i32* %13, align 4, !dbg !42
  br label %1438, !dbg !43

16:                                               ; preds = %1450, %1, %1, %1
  %17 = load %struct.sqlite3*, %struct.sqlite3** %8, align 8, !dbg !44
  %18 = getelementptr %struct.sqlite3, %struct.sqlite3* %17, i32 0, i32 4, !dbg !47
  %19 = load %struct.Db*, %struct.Db** %18, align 8, !dbg !48
  %20 = getelementptr %struct.Db, %struct.Db* %19, i32 0, i32 1, !dbg !49
  %21 = load %struct.Btree*, %struct.Btree** %20, align 8, !dbg !50
  %22 = call %struct.VdbeCursor* @allocateCursor(%struct.Vdbe* %0, i32 0, i32 5, i32 0, i8 0), !dbg !51
  %23 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %22, i32 0, i32 2, !dbg !52
  store i8 1, i8* %23, align 1, !dbg !53
  %24 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %22, i32 0, i32 5, !dbg !54
  %25 = load i8, i8* %24, align 1, !dbg !55
  %26 = or i8 %25, 4, !dbg !56
  store i8 %26, i8* %24, align 1, !dbg !57
  %27 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %22, i32 0, i32 15, !dbg !58
  store i32 1, i32* %27, align 4, !dbg !59
  %28 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %22, i32 0, i32 12, i32 0, !dbg !60
  %29 = load %struct.BtCursor*, %struct.BtCursor** %28, align 8, !dbg !61
  %30 = call i32 @sqlite3BtreeCursor(%struct.Btree* %21, i32 1, i32 0, %struct.KeyInfo* null, %struct.BtCursor* %29), !dbg !62
  %31 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %22, i32 0, i32 13, !dbg !63
  store %struct.KeyInfo* null, %struct.KeyInfo** %31, align 8, !dbg !64
  %32 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %22, i32 0, i32 4, !dbg !65
  store i8 1, i8* %32, align 1, !dbg !66
  call void @sqlite3BtreeCursorHintFlags(%struct.BtCursor* %29, i32 0), !dbg !67
  br label %33, !dbg !68

33:                                               ; preds = %16, %1
  %34 = call i8* @llvm.stacksave(), !dbg !69
  %35 = load %struct.VdbeCursor**, %struct.VdbeCursor*** %4, align 8, !dbg !72
  %36 = load %struct.VdbeCursor*, %struct.VdbeCursor** %35, align 8, !dbg !73
  %37 = alloca i32, align 4, !dbg !74
  store i32 1, i32* %37, align 4, !dbg !75
  %38 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %36, i32 0, i32 0, !dbg !76
  %39 = load i8, i8* %38, align 1, !dbg !77
  %40 = icmp eq i8 %39, 1, !dbg !78
  %41 = alloca i32, align 4, !dbg !79
  store i32 0, i32* %41, align 4, !dbg !80
  br i1 %40, label %42, label %44, !dbg !81

42:                                               ; preds = %33
  %43 = call i32 @sqlite3VdbeSorterRewind(%struct.VdbeCursor* %36, i32* %37), !dbg !82
  store i32 %43, i32* %41, align 4, !dbg !83
  br label %50, !dbg !84

44:                                               ; preds = %33
  %45 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %36, i32 0, i32 12, i32 0, !dbg !85
  %46 = load %struct.BtCursor*, %struct.BtCursor** %45, align 8, !dbg !86
  %47 = call i32 @sqlite3BtreeFirst(%struct.BtCursor* %46, i32* %37), !dbg !87
  store i32 %47, i32* %41, align 4, !dbg !88
  %48 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %36, i32 0, i32 3, !dbg !89
  store i8 0, i8* %48, align 1, !dbg !90
  %49 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %36, i32 0, i32 9, !dbg !91
  store i32 0, i32* %49, align 4, !dbg !92
  br label %50, !dbg !93

50:                                               ; preds = %44, %42
  %51 = load i32, i32* %41, align 4, !dbg !94
  %52 = load i32, i32* %37, align 4, !dbg !95
  %53 = trunc i32 %52 to i8, !dbg !96
  %54 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %36, i32 0, i32 2, !dbg !97
  store i8 %53, i8* %54, align 1, !dbg !98
  call void @llvm.stackrestore(i8* %34), !dbg !99
  %55 = icmp ne i32 %52, 0, !dbg !100
  br i1 %55, label %1436, label %56, !dbg !101

56:                                               ; preds = %1432, %50, %1
  %57 = call i8* @llvm.stacksave(), !dbg !102
  %58 = getelementptr %struct.sqlite3, %struct.sqlite3* %9, i32 0, i32 16, !dbg !105
  %59 = load i8, i8* %58, align 1, !dbg !106
  %60 = alloca i32, align 4, !dbg !107
  store i32 0, i32* %60, align 4, !dbg !108
  %61 = alloca %struct.VdbeCursor*, align 8, !dbg !109
  %62 = load %struct.VdbeCursor*, %struct.VdbeCursor** %5, align 8, !dbg !110
  store %struct.VdbeCursor* %62, %struct.VdbeCursor** %61, align 8, !dbg !111
  %63 = alloca i8*, align 8, !dbg !112
  %64 = alloca i32, align 4, !dbg !113
  %65 = call i32 @sqlite3VdbeCursorMoveto(%struct.VdbeCursor** %61, i32* %60), !dbg !114
  %66 = load %struct.VdbeCursor*, %struct.VdbeCursor** %61, align 8, !dbg !115
  %67 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %3, i32 1, !dbg !116
  %68 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %66, i32 0, i32 16, !dbg !117
  %69 = load i16, i16* %68, align 2, !dbg !118
  %70 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %66, i32 0, i32 19, !dbg !119
  %71 = load i32*, i32** %70, align 8, !dbg !120
  %72 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %66, i32 0, i32 0, !dbg !121
  %73 = load i8, i8* %72, align 1, !dbg !122
  %74 = icmp ne i8 %73, 3, !dbg !123
  %75 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %66, i32 0, i32 2, !dbg !124
  %76 = load i8, i8* %75, align 1, !dbg !125
  %77 = icmp ne i8 %76, 0, !dbg !126
  %78 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %66, i32 0, i32 14, !dbg !127
  %79 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %66, i32 0, i32 21, !dbg !128
  %80 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %66, i32 0, i32 22, !dbg !129
  %81 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %66, i32 0, i32 20, !dbg !130
  %82 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %66, i32 0, i32 17, !dbg !131
  %83 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %66, i32 0, i32 9, !dbg !132
  %84 = load i32, i32* %83, align 4, !dbg !133
  %85 = getelementptr %struct.Vdbe, %struct.Vdbe* %0, i32 0, i32 9, !dbg !134
  %86 = load i32, i32* %85, align 4, !dbg !135
  %87 = icmp ne i32 %84, %86, !dbg !136
  br i1 %87, label %88, label %130, !dbg !137

88:                                               ; preds = %56
  br i1 %77, label %110, label %105, !dbg !138

89:                                               ; preds = %112, %105
  %90 = load i32, i32* %85, align 4, !dbg !139
  store i32 %90, i32* %83, align 4, !dbg !140
  %91 = load i8*, i8** %81, align 8, !dbg !141
  %92 = load i8, i8* %91, align 1, !dbg !142
  %93 = icmp sgt i8 %92, -1, !dbg !145
  br i1 %93, label %94, label %96, !dbg !146

94:                                               ; preds = %89
  %95 = zext i8 %92 to i32, !dbg !147
  store i32 %95, i32* %71, align 4, !dbg !148
  store i32 1, i32* %78, align 4, !dbg !149
  br label %99, !dbg !150

96:                                               ; preds = %89
  %97 = call i8 @sqlite3GetVarint32(i8* %91, i32* %71), !dbg !151
  %98 = zext i8 %97 to i32, !dbg !152
  store i32 %98, i32* %78, align 4, !dbg !153
  br label %99, !dbg !154

99:                                               ; preds = %96, %94
  store i16 0, i16* %82, align 2, !dbg !155
  %100 = load i32, i32* %80, align 4, !dbg !156
  %101 = load i32, i32* %71, align 4, !dbg !157
  %102 = icmp ult i32 %100, %101, !dbg !158
  br i1 %102, label %104, label %103, !dbg !159

103:                                              ; preds = %99
  store i8* %91, i8** %63, align 8, !dbg !160
  br label %221, !dbg !161

104:                                              ; preds = %99
  store i8* null, i8** %81, align 8, !dbg !162
  store i32 0, i32* %80, align 4, !dbg !163
  br label %130, !dbg !164

105:                                              ; preds = %88
  %106 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %66, i32 0, i32 12, i32 0, !dbg !165
  %107 = load %struct.BtCursor*, %struct.BtCursor** %106, align 8, !dbg !166
  %108 = call i32 @sqlite3BtreePayloadSize(%struct.BtCursor* %107), !dbg !167
  store i32 %108, i32* %79, align 4, !dbg !168
  %109 = call i8* @sqlite3BtreePayloadFetch(%struct.BtCursor* %107, i32* %80), !dbg !169
  store i8* %109, i8** %81, align 8, !dbg !170
  br label %89, !dbg !171

110:                                              ; preds = %88
  %111 = icmp eq i8 %73, 3, !dbg !172
  br i1 %111, label %112, label %123, !dbg !173

112:                                              ; preds = %110
  %113 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %66, i32 0, i32 10, !dbg !174
  %114 = load i32, i32* %113, align 4, !dbg !175
  %115 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %3, i32 %114, !dbg !176
  %116 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %115, i32 0, i32 1, !dbg !177
  %117 = load i16, i16* %116, align 2, !dbg !178
  %118 = and i16 %117, 16, !dbg !179
  %119 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %115, i32 0, i32 4, !dbg !180
  %120 = load i32, i32* %119, align 4, !dbg !181
  store i32 %120, i32* %79, align 4, !dbg !182
  store i32 %120, i32* %80, align 4, !dbg !183
  %121 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %115, i32 0, i32 5, !dbg !184
  %122 = load i8*, i8** %121, align 8, !dbg !185
  store i8* %122, i8** %81, align 8, !dbg !186
  br label %89, !dbg !187

123:                                              ; preds = %110
  %124 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %67, i32 0, i32 1, !dbg !188
  %125 = load i16, i16* %124, align 2, !dbg !188
  %126 = and i16 %125, 9216, !dbg !188
  %127 = icmp ne i16 %126, 0, !dbg !188
  br i1 %127, label %128, label %129, !dbg !188

128:                                              ; preds = %123
  call void @vdbeMemClearExternAndSetNull(%struct.sqlite3_value* %67), !dbg !188
  br label %318, !dbg !188

129:                                              ; preds = %123
  store i16 1, i16* %124, align 2, !dbg !188
  br label %318, !dbg !188

130:                                              ; preds = %104, %56
  %131 = load i16, i16* %82, align 2, !dbg !189
  %132 = icmp ule i16 %131, 0, !dbg !190
  br i1 %132, label %213, label %210, !dbg !191

133:                                              ; preds = %299, %210
  %134 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %67, i32 0, i32 1, !dbg !192
  %135 = load i16, i16* %134, align 2, !dbg !193
  %136 = and i16 9216, %135, !dbg !194
  %137 = icmp eq i16 0, %136, !dbg !195
  br i1 %137, label %138, label %142, !dbg !196

138:                                              ; preds = %133
  %139 = icmp ne i16 %136, 0, !dbg !197
  br i1 %139, label %140, label %141, !dbg !197

140:                                              ; preds = %138
  call void @vdbeMemClearExternAndSetNull(%struct.sqlite3_value* %67), !dbg !197
  br label %142, !dbg !197

141:                                              ; preds = %138
  store i16 1, i16* %134, align 2, !dbg !197
  br label %142, !dbg !197

142:                                              ; preds = %141, %140, %133
  %143 = load i32, i32* %64, align 4, !dbg !198
  %144 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %66, i32 0, i32 23, i32 0, !dbg !199
  %145 = load i32, i32* %144, align 4, !dbg !200
  %146 = load i32, i32* %80, align 4, !dbg !201
  %147 = getelementptr i32, i32* %71, i32 1, !dbg !202
  %148 = load i32, i32* %147, align 4, !dbg !203
  %149 = icmp sge i32 %146, %148, !dbg !204
  br i1 %149, label %150, label %189, !dbg !205

150:                                              ; preds = %142
  %151 = load i8*, i8** %81, align 8, !dbg !206
  %152 = ptrtoint i8* %151 to i64, !dbg !207
  %153 = load i32, i32* %71, align 4, !dbg !208
  %154 = zext i32 %153 to i64, !dbg !209
  %155 = add i64 %152, %154, !dbg !210
  %156 = inttoptr i64 %155 to i8*, !dbg !211
  store i8* %156, i8** %63, align 8, !dbg !212
  %157 = load i32, i32* %64, align 4, !dbg !213
  %158 = icmp ult i32 %157, 12, !dbg !214
  br i1 %158, label %159, label %161, !dbg !215

159:                                              ; preds = %150
  %160 = call i32 @sqlite3VdbeSerialGet(i8* %156, i32 %157, %struct.sqlite3_value* %67), !dbg !216
  br label %318, !dbg !217

161:                                              ; preds = %150
  %162 = alloca i16, i32 2, align 2, !dbg !218
  store i16 16, i16* %162, align 2, !dbg !219
  %163 = getelementptr i16, i16* %162, i32 1, !dbg !220
  store i16 514, i16* %163, align 2, !dbg !221
  %164 = load i32, i32* %64, align 4, !dbg !222
  %165 = sub i32 %164, 12, !dbg !223
  %166 = lshr i32 %165, 1, !dbg !224
  %167 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %67, i32 0, i32 4, !dbg !225
  store i32 %166, i32* %167, align 4, !dbg !226
  %168 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %67, i32 0, i32 2, !dbg !227
  store i8 %59, i8* %168, align 1, !dbg !228
  %169 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %67, i32 0, i32 5, !dbg !229
  %170 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %67, i32 0, i32 7, !dbg !230
  %171 = load i32, i32* %170, align 4, !dbg !231
  %172 = add i32 %166, 2, !dbg !232
  %173 = icmp slt i32 %171, %172, !dbg !233
  br i1 %173, label %174, label %176, !dbg !234

174:                                              ; preds = %161
  store i16 1, i16* %134, align 2, !dbg !235
  %175 = call i32 @sqlite3VdbeMemGrow(%struct.sqlite3_value* %67, i32 %172, i32 0), !dbg !236
  br label %179, !dbg !237

176:                                              ; preds = %161
  %177 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %67, i32 0, i32 6, !dbg !238
  %178 = load i8*, i8** %177, align 8, !dbg !239
  store i8* %178, i8** %169, align 8, !dbg !240
  br label %179, !dbg !241

179:                                              ; preds = %176, %174
  %180 = zext i32 %166 to i64, !dbg !242
  %181 = load i8*, i8** %169, align 8, !dbg !243
  %182 = load i8*, i8** %63, align 8, !dbg !244
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %181, i8* %182, i64 %180, i1 false), !dbg !245
  %183 = getelementptr i8, i8* %181, i32 %166, !dbg !246
  store i8 0, i8* %183, align 1, !dbg !247
  %184 = add i32 %166, 1, !dbg !248
  %185 = getelementptr i8, i8* %181, i32 %184, !dbg !249
  store i8 0, i8* %185, align 1, !dbg !250
  %186 = and i32 %164, 1, !dbg !251
  %187 = getelementptr i16, i16* %162, i32 %186, !dbg !252
  %188 = load i16, i16* %187, align 2, !dbg !253
  store i16 %188, i16* %134, align 2, !dbg !254
  br label %318, !dbg !255

189:                                              ; preds = %142
  %190 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %67, i32 0, i32 2, !dbg !256
  store i8 %59, i8* %190, align 1, !dbg !257
  %191 = load i32, i32* %64, align 4, !dbg !258
  %192 = and i32 %191, 1, !dbg !259
  %193 = icmp eq i32 %192, 0, !dbg !260
  %194 = icmp sge i32 %191, 12, !dbg !261
  %195 = and i1 %194, %193, !dbg !262
  %196 = call i32 @sqlite3VdbeSerialTypeLen(i32 %191), !dbg !263
  %197 = icmp eq i32 %196, 0, !dbg !264
  br i1 %197, label %208, label %198, !dbg !265

198:                                              ; preds = %189
  %199 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %66, i32 0, i32 12, i32 0, !dbg !266
  %200 = load %struct.BtCursor*, %struct.BtCursor** %199, align 8, !dbg !267
  %201 = load i32, i32* %71, align 4, !dbg !268
  %202 = call i32 @sqlite3VdbeMemFromBtree(%struct.BtCursor* %200, i32 %201, i32 %196, %struct.sqlite3_value* %67), !dbg !269
  %203 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %67, i32 0, i32 5, !dbg !270
  %204 = load i8*, i8** %203, align 8, !dbg !271
  %205 = call i32 @sqlite3VdbeSerialGet(i8* %204, i32 %191, %struct.sqlite3_value* %67), !dbg !272
  %206 = load i16, i16* %134, align 2, !dbg !273
  %207 = and i16 %206, -4097, !dbg !274
  store i16 %207, i16* %134, align 2, !dbg !275
  br label %318, !dbg !276

208:                                              ; preds = %189
  %209 = call i32 @sqlite3VdbeSerialGet(i8* inttoptr (i64 4580411056 to i8*), i32 %191, %struct.sqlite3_value* %67), !dbg !277
  br label %318, !dbg !278

210:                                              ; preds = %130
  %211 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %66, i32 0, i32 23, i32 0, !dbg !279
  %212 = load i32, i32* %211, align 4, !dbg !280
  store i32 %212, i32* %64, align 4, !dbg !281
  br label %133, !dbg !282

213:                                              ; preds = %130
  %214 = load i32, i32* %78, align 4, !dbg !283
  %215 = load i32, i32* %71, align 4, !dbg !284
  %216 = icmp ult i32 %214, %215, !dbg !285
  br i1 %216, label %217, label %298, !dbg !286

217:                                              ; preds = %213
  %218 = load i8*, i8** %81, align 8, !dbg !287
  %219 = icmp eq i8* %218, null, !dbg !288
  br i1 %219, label %221, label %220, !dbg !289

220:                                              ; preds = %217
  store i8* %218, i8** %63, align 8, !dbg !290
  br label %221, !dbg !291

221:                                              ; preds = %220, %217, %103
  %222 = alloca i32, align 4, !dbg !292
  %223 = load i16, i16* %82, align 2, !dbg !293
  %224 = zext i16 %223 to i32, !dbg !294
  store i32 %224, i32* %222, align 4, !dbg !295
  %225 = alloca i64, align 8, !dbg !296
  %226 = getelementptr i32, i32* %71, i32 %224, !dbg !297
  %227 = load i32, i32* %226, align 4, !dbg !298
  %228 = zext i32 %227 to i64, !dbg !299
  store i64 %228, i64* %225, align 4, !dbg !300
  %229 = load i8*, i8** %63, align 8, !dbg !301
  %230 = load i32, i32* %78, align 4, !dbg !302
  %231 = alloca i8*, align 8, !dbg !303
  %232 = getelementptr i8, i8* %229, i32 %230, !dbg !304
  store i8* %232, i8** %231, align 8, !dbg !305
  %233 = load i32, i32* %71, align 4, !dbg !306
  %234 = getelementptr i8, i8* %229, i32 %233, !dbg !307
  br label %235, !dbg !308

235:                                              ; preds = %242, %221
  %236 = load i32, i32* %222, align 4, !dbg !309
  %237 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %66, i32 0, i32 23, i32 %236, !dbg !310
  %238 = load i8*, i8** %231, align 8, !dbg !311
  %239 = load i8, i8* %238, align 1, !dbg !312
  %240 = zext i8 %239 to i32, !dbg !313
  store i32 %240, i32* %64, align 4, !dbg !314
  store i32 %240, i32* %237, align 4, !dbg !315
  %241 = icmp sgt i8 %239, -1, !dbg !316
  br i1 %241, label %265, label %256, !dbg !317

242:                                              ; preds = %265, %256
  %243 = load i32, i32* %222, align 4, !dbg !318
  %244 = add i32 %243, 1, !dbg !319
  store i32 %244, i32* %222, align 4, !dbg !320
  %245 = load i64, i64* %225, align 4, !dbg !321
  %246 = and i64 4294967295, %245, !dbg !322
  %247 = trunc i64 %246 to i32, !dbg !323
  %248 = getelementptr i32, i32* %71, i32 %244, !dbg !324
  store i32 %247, i32* %248, align 4, !dbg !325
  %249 = load i32, i32* %222, align 4, !dbg !326
  %250 = icmp sle i32 %249, 0, !dbg !327
  %251 = load i8*, i8** %231, align 8, !dbg !328
  %252 = ptrtoint i8* %251 to i64, !dbg !329
  %253 = ptrtoint i8* %234 to i64, !dbg !330
  %254 = icmp ult i64 %252, %253, !dbg !331
  %255 = and i1 %250, %254, !dbg !332
  br i1 %255, label %235, label %274, !dbg !333

256:                                              ; preds = %235
  %257 = load i8*, i8** %231, align 8, !dbg !334
  %258 = call i8 @sqlite3GetVarint32(i8* %257, i32* %64), !dbg !335
  %259 = getelementptr i8, i8* %257, i8 %258, !dbg !336
  store i8* %259, i8** %231, align 8, !dbg !337
  %260 = load i32, i32* %64, align 4, !dbg !338
  store i32 %260, i32* %237, align 4, !dbg !339
  %261 = load i64, i64* %225, align 4, !dbg !340
  %262 = call i32 @sqlite3VdbeSerialTypeLen(i32 %260), !dbg !341
  %263 = zext i32 %262 to i64, !dbg !342
  %264 = add i64 %261, %263, !dbg !343
  store i64 %264, i64* %225, align 4, !dbg !344
  br label %242, !dbg !345

265:                                              ; preds = %235
  %266 = getelementptr i8, i8* %238, i32 1, !dbg !346
  store i8* %266, i8** %231, align 8, !dbg !347
  %267 = load i32, i32* %64, align 4, !dbg !348
  %268 = trunc i32 %267 to i8, !dbg !349
  %269 = getelementptr i8, i8* inttoptr (i64 4580428736 to i8*), i8 %268, !dbg !350
  %270 = load i8, i8* %269, align 1, !dbg !351
  %271 = zext i8 %270 to i64, !dbg !352
  %272 = load i64, i64* %225, align 4, !dbg !353
  %273 = add i64 %272, %271, !dbg !354
  store i64 %273, i64* %225, align 4, !dbg !355
  br label %242, !dbg !356

274:                                              ; preds = %242
  %275 = load i64, i64* %225, align 4, !dbg !357
  %276 = load i32, i32* %79, align 4, !dbg !358
  %277 = zext i32 %276 to i64, !dbg !359
  %278 = icmp uge i64 %252, %253, !dbg !360
  %279 = icmp ugt i64 %252, %253, !dbg !361
  %280 = icmp ne i64 %275, %277, !dbg !362
  %281 = icmp ugt i64 %275, %277, !dbg !363
  %282 = or i1 %279, %280, !dbg !364
  %283 = and i1 %278, %282, !dbg !365
  %284 = or i1 %283, %281, !dbg !366
  br i1 %284, label %285, label %289, !dbg !367

285:                                              ; preds = %274
  %286 = load i32, i32* %71, align 4, !dbg !368
  %287 = icmp eq i32 %286, 0, !dbg !369
  br i1 %287, label %288, label %289, !dbg !370

288:                                              ; preds = %285
  store i32 0, i32* %222, align 4, !dbg !371
  store i8* %234, i8** %231, align 8, !dbg !372
  br label %289, !dbg !373

289:                                              ; preds = %288, %285, %274
  %290 = load i32, i32* %222, align 4, !dbg !374
  %291 = trunc i32 %290 to i16, !dbg !375
  store i16 %291, i16* %82, align 2, !dbg !376
  %292 = load i8*, i8** %231, align 8, !dbg !377
  %293 = ptrtoint i8* %292 to i64, !dbg !378
  %294 = load i8*, i8** %63, align 8, !dbg !379
  %295 = ptrtoint i8* %294 to i64, !dbg !380
  %296 = sub i64 %293, %295, !dbg !381
  %297 = trunc i64 %296 to i32, !dbg !382
  store i32 %297, i32* %78, align 4, !dbg !383
  br label %299, !dbg !384

298:                                              ; preds = %213
  store i32 0, i32* %64, align 4, !dbg !385
  br label %299, !dbg !386

299:                                              ; preds = %298, %289
  %300 = load i16, i16* %82, align 2, !dbg !387
  %301 = icmp sle i16 %300, 0, !dbg !388
  br i1 %301, label %302, label %133, !dbg !389

302:                                              ; preds = %299
  %303 = getelementptr %struct.VdbeOp, %struct.VdbeOp* %7, i32 4, !dbg !390
  %304 = getelementptr %struct.VdbeOp, %struct.VdbeOp* %303, i32 0, i32 1, !dbg !391
  %305 = load i8, i8* %304, align 1, !dbg !392
  %306 = icmp eq i8 %305, -11, !dbg !393
  br i1 %306, label %314, label %307, !dbg !394

307:                                              ; preds = %302
  %308 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %67, i32 0, i32 1, !dbg !395
  %309 = load i16, i16* %308, align 2, !dbg !395
  %310 = and i16 %309, 9216, !dbg !395
  %311 = icmp ne i16 %310, 0, !dbg !395
  br i1 %311, label %312, label %313, !dbg !395

312:                                              ; preds = %307
  call void @vdbeMemClearExternAndSetNull(%struct.sqlite3_value* %67), !dbg !395
  br label %318, !dbg !395

313:                                              ; preds = %307
  store i16 1, i16* %308, align 2, !dbg !395
  br label %318, !dbg !395

314:                                              ; preds = %302
  %315 = getelementptr %struct.VdbeOp, %struct.VdbeOp* %303, i32 0, i32 6, !dbg !396
  %316 = bitcast %union.p4union* %315 to %struct.sqlite3_value**, !dbg !397
  %317 = load %struct.sqlite3_value*, %struct.sqlite3_value** %316, align 8, !dbg !398
  call void @sqlite3VdbeMemShallowCopy(%struct.sqlite3_value* %67, %struct.sqlite3_value* %317, i32 2048), !dbg !399
  br label %318, !dbg !400

318:                                              ; preds = %314, %313, %312, %208, %198, %179, %159, %129, %128
  call void @llvm.stackrestore(i8* %57), !dbg !401
  br label %319, !dbg !68

319:                                              ; preds = %318, %1
  %320 = call i8* @llvm.stacksave(), !dbg !102
  %321 = getelementptr %struct.sqlite3, %struct.sqlite3* %9, i32 0, i32 16, !dbg !105
  %322 = load i8, i8* %321, align 1, !dbg !106
  %323 = alloca i32, align 4, !dbg !107
  store i32 0, i32* %323, align 4, !dbg !108
  %324 = alloca %struct.VdbeCursor*, align 8, !dbg !109
  %325 = load %struct.VdbeCursor*, %struct.VdbeCursor** %5, align 8, !dbg !110
  store %struct.VdbeCursor* %325, %struct.VdbeCursor** %324, align 8, !dbg !111
  %326 = alloca i8*, align 8, !dbg !112
  %327 = alloca i32, align 4, !dbg !113
  %328 = call i32 @sqlite3VdbeCursorMoveto(%struct.VdbeCursor** %324, i32* %323), !dbg !114
  %329 = load %struct.VdbeCursor*, %struct.VdbeCursor** %324, align 8, !dbg !115
  %330 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %3, i32 2, !dbg !116
  %331 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %329, i32 0, i32 16, !dbg !117
  %332 = load i16, i16* %331, align 2, !dbg !118
  %333 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %329, i32 0, i32 19, !dbg !119
  %334 = load i32*, i32** %333, align 8, !dbg !120
  %335 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %329, i32 0, i32 0, !dbg !121
  %336 = load i8, i8* %335, align 1, !dbg !122
  %337 = icmp ne i8 %336, 3, !dbg !123
  %338 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %329, i32 0, i32 2, !dbg !124
  %339 = load i8, i8* %338, align 1, !dbg !125
  %340 = icmp ne i8 %339, 0, !dbg !126
  %341 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %329, i32 0, i32 14, !dbg !127
  %342 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %329, i32 0, i32 21, !dbg !128
  %343 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %329, i32 0, i32 22, !dbg !129
  %344 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %329, i32 0, i32 20, !dbg !130
  %345 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %329, i32 0, i32 17, !dbg !131
  %346 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %329, i32 0, i32 9, !dbg !132
  %347 = load i32, i32* %346, align 4, !dbg !133
  %348 = getelementptr %struct.Vdbe, %struct.Vdbe* %0, i32 0, i32 9, !dbg !134
  %349 = load i32, i32* %348, align 4, !dbg !135
  %350 = icmp ne i32 %347, %349, !dbg !136
  br i1 %350, label %351, label %393, !dbg !137

351:                                              ; preds = %319
  br i1 %340, label %373, label %368, !dbg !138

352:                                              ; preds = %375, %368
  %353 = load i32, i32* %348, align 4, !dbg !139
  store i32 %353, i32* %346, align 4, !dbg !140
  %354 = load i8*, i8** %344, align 8, !dbg !141
  %355 = load i8, i8* %354, align 1, !dbg !142
  %356 = icmp sgt i8 %355, -1, !dbg !145
  br i1 %356, label %357, label %359, !dbg !146

357:                                              ; preds = %352
  %358 = zext i8 %355 to i32, !dbg !147
  store i32 %358, i32* %334, align 4, !dbg !148
  store i32 1, i32* %341, align 4, !dbg !149
  br label %362, !dbg !150

359:                                              ; preds = %352
  %360 = call i8 @sqlite3GetVarint32(i8* %354, i32* %334), !dbg !151
  %361 = zext i8 %360 to i32, !dbg !152
  store i32 %361, i32* %341, align 4, !dbg !153
  br label %362, !dbg !154

362:                                              ; preds = %359, %357
  store i16 0, i16* %345, align 2, !dbg !155
  %363 = load i32, i32* %343, align 4, !dbg !156
  %364 = load i32, i32* %334, align 4, !dbg !157
  %365 = icmp ult i32 %363, %364, !dbg !158
  br i1 %365, label %367, label %366, !dbg !159

366:                                              ; preds = %362
  store i8* %354, i8** %326, align 8, !dbg !160
  br label %486, !dbg !161

367:                                              ; preds = %362
  store i8* null, i8** %344, align 8, !dbg !162
  store i32 0, i32* %343, align 4, !dbg !163
  br label %393, !dbg !164

368:                                              ; preds = %351
  %369 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %329, i32 0, i32 12, i32 0, !dbg !165
  %370 = load %struct.BtCursor*, %struct.BtCursor** %369, align 8, !dbg !166
  %371 = call i32 @sqlite3BtreePayloadSize(%struct.BtCursor* %370), !dbg !167
  store i32 %371, i32* %342, align 4, !dbg !168
  %372 = call i8* @sqlite3BtreePayloadFetch(%struct.BtCursor* %370, i32* %343), !dbg !169
  store i8* %372, i8** %344, align 8, !dbg !170
  br label %352, !dbg !171

373:                                              ; preds = %351
  %374 = icmp eq i8 %336, 3, !dbg !172
  br i1 %374, label %375, label %386, !dbg !173

375:                                              ; preds = %373
  %376 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %329, i32 0, i32 10, !dbg !174
  %377 = load i32, i32* %376, align 4, !dbg !175
  %378 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %3, i32 %377, !dbg !176
  %379 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %378, i32 0, i32 1, !dbg !177
  %380 = load i16, i16* %379, align 2, !dbg !178
  %381 = and i16 %380, 16, !dbg !179
  %382 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %378, i32 0, i32 4, !dbg !180
  %383 = load i32, i32* %382, align 4, !dbg !181
  store i32 %383, i32* %342, align 4, !dbg !182
  store i32 %383, i32* %343, align 4, !dbg !183
  %384 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %378, i32 0, i32 5, !dbg !184
  %385 = load i8*, i8** %384, align 8, !dbg !185
  store i8* %385, i8** %344, align 8, !dbg !186
  br label %352, !dbg !187

386:                                              ; preds = %373
  %387 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %330, i32 0, i32 1, !dbg !188
  %388 = load i16, i16* %387, align 2, !dbg !188
  %389 = and i16 %388, 9216, !dbg !188
  %390 = icmp ne i16 %389, 0, !dbg !188
  br i1 %390, label %391, label %392, !dbg !188

391:                                              ; preds = %386
  call void @vdbeMemClearExternAndSetNull(%struct.sqlite3_value* %330), !dbg !188
  br label %583, !dbg !188

392:                                              ; preds = %386
  store i16 1, i16* %387, align 2, !dbg !188
  br label %583, !dbg !188

393:                                              ; preds = %367, %319
  %394 = load i16, i16* %345, align 2, !dbg !189
  %395 = icmp ule i16 %394, 1, !dbg !190
  br i1 %395, label %478, label %475, !dbg !191

396:                                              ; preds = %564, %475
  %397 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %330, i32 0, i32 1, !dbg !192
  %398 = load i16, i16* %397, align 2, !dbg !193
  %399 = and i16 9216, %398, !dbg !194
  %400 = icmp eq i16 0, %399, !dbg !195
  br i1 %400, label %401, label %405, !dbg !196

401:                                              ; preds = %396
  %402 = icmp ne i16 %399, 0, !dbg !197
  br i1 %402, label %403, label %404, !dbg !197

403:                                              ; preds = %401
  call void @vdbeMemClearExternAndSetNull(%struct.sqlite3_value* %330), !dbg !197
  br label %405, !dbg !197

404:                                              ; preds = %401
  store i16 1, i16* %397, align 2, !dbg !197
  br label %405, !dbg !197

405:                                              ; preds = %404, %403, %396
  %406 = load i32, i32* %327, align 4, !dbg !198
  %407 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %329, i32 0, i32 23, i32 1, !dbg !199
  %408 = load i32, i32* %407, align 4, !dbg !200
  %409 = load i32, i32* %343, align 4, !dbg !201
  %410 = getelementptr i32, i32* %334, i32 2, !dbg !202
  %411 = load i32, i32* %410, align 4, !dbg !203
  %412 = icmp sge i32 %409, %411, !dbg !204
  br i1 %412, label %413, label %453, !dbg !205

413:                                              ; preds = %405
  %414 = load i8*, i8** %344, align 8, !dbg !206
  %415 = ptrtoint i8* %414 to i64, !dbg !207
  %416 = getelementptr i32, i32* %334, i32 1, !dbg !402
  %417 = load i32, i32* %416, align 4, !dbg !208
  %418 = zext i32 %417 to i64, !dbg !209
  %419 = add i64 %415, %418, !dbg !210
  %420 = inttoptr i64 %419 to i8*, !dbg !211
  store i8* %420, i8** %326, align 8, !dbg !212
  %421 = load i32, i32* %327, align 4, !dbg !213
  %422 = icmp ult i32 %421, 12, !dbg !214
  br i1 %422, label %423, label %425, !dbg !215

423:                                              ; preds = %413
  %424 = call i32 @sqlite3VdbeSerialGet(i8* %420, i32 %421, %struct.sqlite3_value* %330), !dbg !216
  br label %583, !dbg !217

425:                                              ; preds = %413
  %426 = alloca i16, i32 2, align 2, !dbg !218
  store i16 16, i16* %426, align 2, !dbg !219
  %427 = getelementptr i16, i16* %426, i32 1, !dbg !220
  store i16 514, i16* %427, align 2, !dbg !221
  %428 = load i32, i32* %327, align 4, !dbg !222
  %429 = sub i32 %428, 12, !dbg !223
  %430 = lshr i32 %429, 1, !dbg !224
  %431 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %330, i32 0, i32 4, !dbg !225
  store i32 %430, i32* %431, align 4, !dbg !226
  %432 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %330, i32 0, i32 2, !dbg !227
  store i8 %322, i8* %432, align 1, !dbg !228
  %433 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %330, i32 0, i32 5, !dbg !229
  %434 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %330, i32 0, i32 7, !dbg !230
  %435 = load i32, i32* %434, align 4, !dbg !231
  %436 = add i32 %430, 2, !dbg !232
  %437 = icmp slt i32 %435, %436, !dbg !233
  br i1 %437, label %438, label %440, !dbg !234

438:                                              ; preds = %425
  store i16 1, i16* %397, align 2, !dbg !235
  %439 = call i32 @sqlite3VdbeMemGrow(%struct.sqlite3_value* %330, i32 %436, i32 0), !dbg !236
  br label %443, !dbg !237

440:                                              ; preds = %425
  %441 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %330, i32 0, i32 6, !dbg !238
  %442 = load i8*, i8** %441, align 8, !dbg !239
  store i8* %442, i8** %433, align 8, !dbg !240
  br label %443, !dbg !241

443:                                              ; preds = %440, %438
  %444 = zext i32 %430 to i64, !dbg !242
  %445 = load i8*, i8** %433, align 8, !dbg !243
  %446 = load i8*, i8** %326, align 8, !dbg !244
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %445, i8* %446, i64 %444, i1 false), !dbg !245
  %447 = getelementptr i8, i8* %445, i32 %430, !dbg !246
  store i8 0, i8* %447, align 1, !dbg !247
  %448 = add i32 %430, 1, !dbg !248
  %449 = getelementptr i8, i8* %445, i32 %448, !dbg !249
  store i8 0, i8* %449, align 1, !dbg !250
  %450 = and i32 %428, 1, !dbg !251
  %451 = getelementptr i16, i16* %426, i32 %450, !dbg !252
  %452 = load i16, i16* %451, align 2, !dbg !253
  store i16 %452, i16* %397, align 2, !dbg !254
  br label %583, !dbg !255

453:                                              ; preds = %405
  %454 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %330, i32 0, i32 2, !dbg !256
  store i8 %322, i8* %454, align 1, !dbg !257
  %455 = load i32, i32* %327, align 4, !dbg !258
  %456 = and i32 %455, 1, !dbg !259
  %457 = icmp eq i32 %456, 0, !dbg !260
  %458 = icmp sge i32 %455, 12, !dbg !261
  %459 = and i1 %458, %457, !dbg !262
  %460 = call i32 @sqlite3VdbeSerialTypeLen(i32 %455), !dbg !263
  %461 = icmp eq i32 %460, 0, !dbg !264
  br i1 %461, label %473, label %462, !dbg !265

462:                                              ; preds = %453
  %463 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %329, i32 0, i32 12, i32 0, !dbg !266
  %464 = load %struct.BtCursor*, %struct.BtCursor** %463, align 8, !dbg !267
  %465 = getelementptr i32, i32* %334, i32 1, !dbg !403
  %466 = load i32, i32* %465, align 4, !dbg !268
  %467 = call i32 @sqlite3VdbeMemFromBtree(%struct.BtCursor* %464, i32 %466, i32 %460, %struct.sqlite3_value* %330), !dbg !269
  %468 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %330, i32 0, i32 5, !dbg !270
  %469 = load i8*, i8** %468, align 8, !dbg !271
  %470 = call i32 @sqlite3VdbeSerialGet(i8* %469, i32 %455, %struct.sqlite3_value* %330), !dbg !272
  %471 = load i16, i16* %397, align 2, !dbg !273
  %472 = and i16 %471, -4097, !dbg !274
  store i16 %472, i16* %397, align 2, !dbg !275
  br label %583, !dbg !276

473:                                              ; preds = %453
  %474 = call i32 @sqlite3VdbeSerialGet(i8* inttoptr (i64 4580411056 to i8*), i32 %455, %struct.sqlite3_value* %330), !dbg !277
  br label %583, !dbg !278

475:                                              ; preds = %393
  %476 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %329, i32 0, i32 23, i32 1, !dbg !279
  %477 = load i32, i32* %476, align 4, !dbg !280
  store i32 %477, i32* %327, align 4, !dbg !281
  br label %396, !dbg !282

478:                                              ; preds = %393
  %479 = load i32, i32* %341, align 4, !dbg !283
  %480 = load i32, i32* %334, align 4, !dbg !284
  %481 = icmp ult i32 %479, %480, !dbg !285
  br i1 %481, label %482, label %563, !dbg !286

482:                                              ; preds = %478
  %483 = load i8*, i8** %344, align 8, !dbg !287
  %484 = icmp eq i8* %483, null, !dbg !288
  br i1 %484, label %486, label %485, !dbg !289

485:                                              ; preds = %482
  store i8* %483, i8** %326, align 8, !dbg !290
  br label %486, !dbg !291

486:                                              ; preds = %485, %482, %366
  %487 = alloca i32, align 4, !dbg !292
  %488 = load i16, i16* %345, align 2, !dbg !293
  %489 = zext i16 %488 to i32, !dbg !294
  store i32 %489, i32* %487, align 4, !dbg !295
  %490 = alloca i64, align 8, !dbg !296
  %491 = getelementptr i32, i32* %334, i32 %489, !dbg !297
  %492 = load i32, i32* %491, align 4, !dbg !298
  %493 = zext i32 %492 to i64, !dbg !299
  store i64 %493, i64* %490, align 4, !dbg !300
  %494 = load i8*, i8** %326, align 8, !dbg !301
  %495 = load i32, i32* %341, align 4, !dbg !302
  %496 = alloca i8*, align 8, !dbg !303
  %497 = getelementptr i8, i8* %494, i32 %495, !dbg !304
  store i8* %497, i8** %496, align 8, !dbg !305
  %498 = load i32, i32* %334, align 4, !dbg !306
  %499 = getelementptr i8, i8* %494, i32 %498, !dbg !307
  br label %500, !dbg !308

500:                                              ; preds = %507, %486
  %501 = load i32, i32* %487, align 4, !dbg !309
  %502 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %329, i32 0, i32 23, i32 %501, !dbg !310
  %503 = load i8*, i8** %496, align 8, !dbg !311
  %504 = load i8, i8* %503, align 1, !dbg !312
  %505 = zext i8 %504 to i32, !dbg !313
  store i32 %505, i32* %327, align 4, !dbg !314
  store i32 %505, i32* %502, align 4, !dbg !315
  %506 = icmp sgt i8 %504, -1, !dbg !316
  br i1 %506, label %530, label %521, !dbg !317

507:                                              ; preds = %530, %521
  %508 = load i32, i32* %487, align 4, !dbg !318
  %509 = add i32 %508, 1, !dbg !319
  store i32 %509, i32* %487, align 4, !dbg !320
  %510 = load i64, i64* %490, align 4, !dbg !321
  %511 = and i64 4294967295, %510, !dbg !322
  %512 = trunc i64 %511 to i32, !dbg !323
  %513 = getelementptr i32, i32* %334, i32 %509, !dbg !324
  store i32 %512, i32* %513, align 4, !dbg !325
  %514 = load i32, i32* %487, align 4, !dbg !326
  %515 = icmp sle i32 %514, 1, !dbg !327
  %516 = load i8*, i8** %496, align 8, !dbg !328
  %517 = ptrtoint i8* %516 to i64, !dbg !329
  %518 = ptrtoint i8* %499 to i64, !dbg !330
  %519 = icmp ult i64 %517, %518, !dbg !331
  %520 = and i1 %515, %519, !dbg !332
  br i1 %520, label %500, label %539, !dbg !333

521:                                              ; preds = %500
  %522 = load i8*, i8** %496, align 8, !dbg !334
  %523 = call i8 @sqlite3GetVarint32(i8* %522, i32* %327), !dbg !335
  %524 = getelementptr i8, i8* %522, i8 %523, !dbg !336
  store i8* %524, i8** %496, align 8, !dbg !337
  %525 = load i32, i32* %327, align 4, !dbg !338
  store i32 %525, i32* %502, align 4, !dbg !339
  %526 = load i64, i64* %490, align 4, !dbg !340
  %527 = call i32 @sqlite3VdbeSerialTypeLen(i32 %525), !dbg !341
  %528 = zext i32 %527 to i64, !dbg !342
  %529 = add i64 %526, %528, !dbg !343
  store i64 %529, i64* %490, align 4, !dbg !344
  br label %507, !dbg !345

530:                                              ; preds = %500
  %531 = getelementptr i8, i8* %503, i32 1, !dbg !346
  store i8* %531, i8** %496, align 8, !dbg !347
  %532 = load i32, i32* %327, align 4, !dbg !348
  %533 = trunc i32 %532 to i8, !dbg !349
  %534 = getelementptr i8, i8* inttoptr (i64 4580428736 to i8*), i8 %533, !dbg !350
  %535 = load i8, i8* %534, align 1, !dbg !351
  %536 = zext i8 %535 to i64, !dbg !352
  %537 = load i64, i64* %490, align 4, !dbg !353
  %538 = add i64 %537, %536, !dbg !354
  store i64 %538, i64* %490, align 4, !dbg !355
  br label %507, !dbg !356

539:                                              ; preds = %507
  %540 = load i64, i64* %490, align 4, !dbg !357
  %541 = load i32, i32* %342, align 4, !dbg !358
  %542 = zext i32 %541 to i64, !dbg !359
  %543 = icmp uge i64 %517, %518, !dbg !360
  %544 = icmp ugt i64 %517, %518, !dbg !361
  %545 = icmp ne i64 %540, %542, !dbg !362
  %546 = icmp ugt i64 %540, %542, !dbg !363
  %547 = or i1 %544, %545, !dbg !364
  %548 = and i1 %543, %547, !dbg !365
  %549 = or i1 %548, %546, !dbg !366
  br i1 %549, label %550, label %554, !dbg !367

550:                                              ; preds = %539
  %551 = load i32, i32* %334, align 4, !dbg !368
  %552 = icmp eq i32 %551, 0, !dbg !369
  br i1 %552, label %553, label %554, !dbg !370

553:                                              ; preds = %550
  store i32 0, i32* %487, align 4, !dbg !371
  store i8* %499, i8** %496, align 8, !dbg !372
  br label %554, !dbg !373

554:                                              ; preds = %553, %550, %539
  %555 = load i32, i32* %487, align 4, !dbg !374
  %556 = trunc i32 %555 to i16, !dbg !375
  store i16 %556, i16* %345, align 2, !dbg !376
  %557 = load i8*, i8** %496, align 8, !dbg !377
  %558 = ptrtoint i8* %557 to i64, !dbg !378
  %559 = load i8*, i8** %326, align 8, !dbg !379
  %560 = ptrtoint i8* %559 to i64, !dbg !380
  %561 = sub i64 %558, %560, !dbg !381
  %562 = trunc i64 %561 to i32, !dbg !382
  store i32 %562, i32* %341, align 4, !dbg !383
  br label %564, !dbg !384

563:                                              ; preds = %478
  store i32 0, i32* %327, align 4, !dbg !385
  br label %564, !dbg !386

564:                                              ; preds = %563, %554
  %565 = load i16, i16* %345, align 2, !dbg !387
  %566 = icmp sle i16 %565, 1, !dbg !388
  br i1 %566, label %567, label %396, !dbg !389

567:                                              ; preds = %564
  %568 = getelementptr %struct.VdbeOp, %struct.VdbeOp* %7, i32 5, !dbg !390
  %569 = getelementptr %struct.VdbeOp, %struct.VdbeOp* %568, i32 0, i32 1, !dbg !391
  %570 = load i8, i8* %569, align 1, !dbg !392
  %571 = icmp eq i8 %570, -11, !dbg !393
  br i1 %571, label %579, label %572, !dbg !394

572:                                              ; preds = %567
  %573 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %330, i32 0, i32 1, !dbg !395
  %574 = load i16, i16* %573, align 2, !dbg !395
  %575 = and i16 %574, 9216, !dbg !395
  %576 = icmp ne i16 %575, 0, !dbg !395
  br i1 %576, label %577, label %578, !dbg !395

577:                                              ; preds = %572
  call void @vdbeMemClearExternAndSetNull(%struct.sqlite3_value* %330), !dbg !395
  br label %583, !dbg !395

578:                                              ; preds = %572
  store i16 1, i16* %573, align 2, !dbg !395
  br label %583, !dbg !395

579:                                              ; preds = %567
  %580 = getelementptr %struct.VdbeOp, %struct.VdbeOp* %568, i32 0, i32 6, !dbg !396
  %581 = bitcast %union.p4union* %580 to %struct.sqlite3_value**, !dbg !397
  %582 = load %struct.sqlite3_value*, %struct.sqlite3_value** %581, align 8, !dbg !398
  call void @sqlite3VdbeMemShallowCopy(%struct.sqlite3_value* %330, %struct.sqlite3_value* %582, i32 2048), !dbg !399
  br label %583, !dbg !400

583:                                              ; preds = %579, %578, %577, %473, %462, %443, %423, %392, %391
  call void @llvm.stackrestore(i8* %320), !dbg !401
  br label %584, !dbg !68

584:                                              ; preds = %583, %1
  %585 = call i8* @llvm.stacksave(), !dbg !102
  %586 = getelementptr %struct.sqlite3, %struct.sqlite3* %9, i32 0, i32 16, !dbg !105
  %587 = load i8, i8* %586, align 1, !dbg !106
  %588 = alloca i32, align 4, !dbg !107
  store i32 0, i32* %588, align 4, !dbg !108
  %589 = alloca %struct.VdbeCursor*, align 8, !dbg !109
  %590 = load %struct.VdbeCursor*, %struct.VdbeCursor** %5, align 8, !dbg !110
  store %struct.VdbeCursor* %590, %struct.VdbeCursor** %589, align 8, !dbg !111
  %591 = alloca i8*, align 8, !dbg !112
  %592 = alloca i32, align 4, !dbg !113
  %593 = call i32 @sqlite3VdbeCursorMoveto(%struct.VdbeCursor** %589, i32* %588), !dbg !114
  %594 = load %struct.VdbeCursor*, %struct.VdbeCursor** %589, align 8, !dbg !115
  %595 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %3, i32 3, !dbg !116
  %596 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %594, i32 0, i32 16, !dbg !117
  %597 = load i16, i16* %596, align 2, !dbg !118
  %598 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %594, i32 0, i32 19, !dbg !119
  %599 = load i32*, i32** %598, align 8, !dbg !120
  %600 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %594, i32 0, i32 0, !dbg !121
  %601 = load i8, i8* %600, align 1, !dbg !122
  %602 = icmp ne i8 %601, 3, !dbg !123
  %603 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %594, i32 0, i32 2, !dbg !124
  %604 = load i8, i8* %603, align 1, !dbg !125
  %605 = icmp ne i8 %604, 0, !dbg !126
  %606 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %594, i32 0, i32 14, !dbg !127
  %607 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %594, i32 0, i32 21, !dbg !128
  %608 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %594, i32 0, i32 22, !dbg !129
  %609 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %594, i32 0, i32 20, !dbg !130
  %610 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %594, i32 0, i32 17, !dbg !131
  %611 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %594, i32 0, i32 9, !dbg !132
  %612 = load i32, i32* %611, align 4, !dbg !133
  %613 = getelementptr %struct.Vdbe, %struct.Vdbe* %0, i32 0, i32 9, !dbg !134
  %614 = load i32, i32* %613, align 4, !dbg !135
  %615 = icmp ne i32 %612, %614, !dbg !136
  br i1 %615, label %616, label %658, !dbg !137

616:                                              ; preds = %584
  br i1 %605, label %638, label %633, !dbg !138

617:                                              ; preds = %640, %633
  %618 = load i32, i32* %613, align 4, !dbg !139
  store i32 %618, i32* %611, align 4, !dbg !140
  %619 = load i8*, i8** %609, align 8, !dbg !141
  %620 = load i8, i8* %619, align 1, !dbg !142
  %621 = icmp sgt i8 %620, -1, !dbg !145
  br i1 %621, label %622, label %624, !dbg !146

622:                                              ; preds = %617
  %623 = zext i8 %620 to i32, !dbg !147
  store i32 %623, i32* %599, align 4, !dbg !148
  store i32 1, i32* %606, align 4, !dbg !149
  br label %627, !dbg !150

624:                                              ; preds = %617
  %625 = call i8 @sqlite3GetVarint32(i8* %619, i32* %599), !dbg !151
  %626 = zext i8 %625 to i32, !dbg !152
  store i32 %626, i32* %606, align 4, !dbg !153
  br label %627, !dbg !154

627:                                              ; preds = %624, %622
  store i16 0, i16* %610, align 2, !dbg !155
  %628 = load i32, i32* %608, align 4, !dbg !156
  %629 = load i32, i32* %599, align 4, !dbg !157
  %630 = icmp ult i32 %628, %629, !dbg !158
  br i1 %630, label %632, label %631, !dbg !159

631:                                              ; preds = %627
  store i8* %619, i8** %591, align 8, !dbg !160
  br label %751, !dbg !161

632:                                              ; preds = %627
  store i8* null, i8** %609, align 8, !dbg !162
  store i32 0, i32* %608, align 4, !dbg !163
  br label %658, !dbg !164

633:                                              ; preds = %616
  %634 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %594, i32 0, i32 12, i32 0, !dbg !165
  %635 = load %struct.BtCursor*, %struct.BtCursor** %634, align 8, !dbg !166
  %636 = call i32 @sqlite3BtreePayloadSize(%struct.BtCursor* %635), !dbg !167
  store i32 %636, i32* %607, align 4, !dbg !168
  %637 = call i8* @sqlite3BtreePayloadFetch(%struct.BtCursor* %635, i32* %608), !dbg !169
  store i8* %637, i8** %609, align 8, !dbg !170
  br label %617, !dbg !171

638:                                              ; preds = %616
  %639 = icmp eq i8 %601, 3, !dbg !172
  br i1 %639, label %640, label %651, !dbg !173

640:                                              ; preds = %638
  %641 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %594, i32 0, i32 10, !dbg !174
  %642 = load i32, i32* %641, align 4, !dbg !175
  %643 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %3, i32 %642, !dbg !176
  %644 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %643, i32 0, i32 1, !dbg !177
  %645 = load i16, i16* %644, align 2, !dbg !178
  %646 = and i16 %645, 16, !dbg !179
  %647 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %643, i32 0, i32 4, !dbg !180
  %648 = load i32, i32* %647, align 4, !dbg !181
  store i32 %648, i32* %607, align 4, !dbg !182
  store i32 %648, i32* %608, align 4, !dbg !183
  %649 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %643, i32 0, i32 5, !dbg !184
  %650 = load i8*, i8** %649, align 8, !dbg !185
  store i8* %650, i8** %609, align 8, !dbg !186
  br label %617, !dbg !187

651:                                              ; preds = %638
  %652 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %595, i32 0, i32 1, !dbg !188
  %653 = load i16, i16* %652, align 2, !dbg !188
  %654 = and i16 %653, 9216, !dbg !188
  %655 = icmp ne i16 %654, 0, !dbg !188
  br i1 %655, label %656, label %657, !dbg !188

656:                                              ; preds = %651
  call void @vdbeMemClearExternAndSetNull(%struct.sqlite3_value* %595), !dbg !188
  br label %848, !dbg !188

657:                                              ; preds = %651
  store i16 1, i16* %652, align 2, !dbg !188
  br label %848, !dbg !188

658:                                              ; preds = %632, %584
  %659 = load i16, i16* %610, align 2, !dbg !189
  %660 = icmp ule i16 %659, 2, !dbg !190
  br i1 %660, label %743, label %740, !dbg !191

661:                                              ; preds = %829, %740
  %662 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %595, i32 0, i32 1, !dbg !192
  %663 = load i16, i16* %662, align 2, !dbg !193
  %664 = and i16 9216, %663, !dbg !194
  %665 = icmp eq i16 0, %664, !dbg !195
  br i1 %665, label %666, label %670, !dbg !196

666:                                              ; preds = %661
  %667 = icmp ne i16 %664, 0, !dbg !197
  br i1 %667, label %668, label %669, !dbg !197

668:                                              ; preds = %666
  call void @vdbeMemClearExternAndSetNull(%struct.sqlite3_value* %595), !dbg !197
  br label %670, !dbg !197

669:                                              ; preds = %666
  store i16 1, i16* %662, align 2, !dbg !197
  br label %670, !dbg !197

670:                                              ; preds = %669, %668, %661
  %671 = load i32, i32* %592, align 4, !dbg !198
  %672 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %594, i32 0, i32 23, i32 2, !dbg !199
  %673 = load i32, i32* %672, align 4, !dbg !200
  %674 = load i32, i32* %608, align 4, !dbg !201
  %675 = getelementptr i32, i32* %599, i32 3, !dbg !202
  %676 = load i32, i32* %675, align 4, !dbg !203
  %677 = icmp sge i32 %674, %676, !dbg !204
  br i1 %677, label %678, label %718, !dbg !205

678:                                              ; preds = %670
  %679 = load i8*, i8** %609, align 8, !dbg !206
  %680 = ptrtoint i8* %679 to i64, !dbg !207
  %681 = getelementptr i32, i32* %599, i32 2, !dbg !402
  %682 = load i32, i32* %681, align 4, !dbg !208
  %683 = zext i32 %682 to i64, !dbg !209
  %684 = add i64 %680, %683, !dbg !210
  %685 = inttoptr i64 %684 to i8*, !dbg !211
  store i8* %685, i8** %591, align 8, !dbg !212
  %686 = load i32, i32* %592, align 4, !dbg !213
  %687 = icmp ult i32 %686, 12, !dbg !214
  br i1 %687, label %688, label %690, !dbg !215

688:                                              ; preds = %678
  %689 = call i32 @sqlite3VdbeSerialGet(i8* %685, i32 %686, %struct.sqlite3_value* %595), !dbg !216
  br label %848, !dbg !217

690:                                              ; preds = %678
  %691 = alloca i16, i32 2, align 2, !dbg !218
  store i16 16, i16* %691, align 2, !dbg !219
  %692 = getelementptr i16, i16* %691, i32 1, !dbg !220
  store i16 514, i16* %692, align 2, !dbg !221
  %693 = load i32, i32* %592, align 4, !dbg !222
  %694 = sub i32 %693, 12, !dbg !223
  %695 = lshr i32 %694, 1, !dbg !224
  %696 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %595, i32 0, i32 4, !dbg !225
  store i32 %695, i32* %696, align 4, !dbg !226
  %697 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %595, i32 0, i32 2, !dbg !227
  store i8 %587, i8* %697, align 1, !dbg !228
  %698 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %595, i32 0, i32 5, !dbg !229
  %699 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %595, i32 0, i32 7, !dbg !230
  %700 = load i32, i32* %699, align 4, !dbg !231
  %701 = add i32 %695, 2, !dbg !232
  %702 = icmp slt i32 %700, %701, !dbg !233
  br i1 %702, label %703, label %705, !dbg !234

703:                                              ; preds = %690
  store i16 1, i16* %662, align 2, !dbg !235
  %704 = call i32 @sqlite3VdbeMemGrow(%struct.sqlite3_value* %595, i32 %701, i32 0), !dbg !236
  br label %708, !dbg !237

705:                                              ; preds = %690
  %706 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %595, i32 0, i32 6, !dbg !238
  %707 = load i8*, i8** %706, align 8, !dbg !239
  store i8* %707, i8** %698, align 8, !dbg !240
  br label %708, !dbg !241

708:                                              ; preds = %705, %703
  %709 = zext i32 %695 to i64, !dbg !242
  %710 = load i8*, i8** %698, align 8, !dbg !243
  %711 = load i8*, i8** %591, align 8, !dbg !244
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %710, i8* %711, i64 %709, i1 false), !dbg !245
  %712 = getelementptr i8, i8* %710, i32 %695, !dbg !246
  store i8 0, i8* %712, align 1, !dbg !247
  %713 = add i32 %695, 1, !dbg !248
  %714 = getelementptr i8, i8* %710, i32 %713, !dbg !249
  store i8 0, i8* %714, align 1, !dbg !250
  %715 = and i32 %693, 1, !dbg !251
  %716 = getelementptr i16, i16* %691, i32 %715, !dbg !252
  %717 = load i16, i16* %716, align 2, !dbg !253
  store i16 %717, i16* %662, align 2, !dbg !254
  br label %848, !dbg !255

718:                                              ; preds = %670
  %719 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %595, i32 0, i32 2, !dbg !256
  store i8 %587, i8* %719, align 1, !dbg !257
  %720 = load i32, i32* %592, align 4, !dbg !258
  %721 = and i32 %720, 1, !dbg !259
  %722 = icmp eq i32 %721, 0, !dbg !260
  %723 = icmp sge i32 %720, 12, !dbg !261
  %724 = and i1 %723, %722, !dbg !262
  %725 = call i32 @sqlite3VdbeSerialTypeLen(i32 %720), !dbg !263
  %726 = icmp eq i32 %725, 0, !dbg !264
  br i1 %726, label %738, label %727, !dbg !265

727:                                              ; preds = %718
  %728 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %594, i32 0, i32 12, i32 0, !dbg !266
  %729 = load %struct.BtCursor*, %struct.BtCursor** %728, align 8, !dbg !267
  %730 = getelementptr i32, i32* %599, i32 2, !dbg !403
  %731 = load i32, i32* %730, align 4, !dbg !268
  %732 = call i32 @sqlite3VdbeMemFromBtree(%struct.BtCursor* %729, i32 %731, i32 %725, %struct.sqlite3_value* %595), !dbg !269
  %733 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %595, i32 0, i32 5, !dbg !270
  %734 = load i8*, i8** %733, align 8, !dbg !271
  %735 = call i32 @sqlite3VdbeSerialGet(i8* %734, i32 %720, %struct.sqlite3_value* %595), !dbg !272
  %736 = load i16, i16* %662, align 2, !dbg !273
  %737 = and i16 %736, -4097, !dbg !274
  store i16 %737, i16* %662, align 2, !dbg !275
  br label %848, !dbg !276

738:                                              ; preds = %718
  %739 = call i32 @sqlite3VdbeSerialGet(i8* inttoptr (i64 4580411056 to i8*), i32 %720, %struct.sqlite3_value* %595), !dbg !277
  br label %848, !dbg !278

740:                                              ; preds = %658
  %741 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %594, i32 0, i32 23, i32 2, !dbg !279
  %742 = load i32, i32* %741, align 4, !dbg !280
  store i32 %742, i32* %592, align 4, !dbg !281
  br label %661, !dbg !282

743:                                              ; preds = %658
  %744 = load i32, i32* %606, align 4, !dbg !283
  %745 = load i32, i32* %599, align 4, !dbg !284
  %746 = icmp ult i32 %744, %745, !dbg !285
  br i1 %746, label %747, label %828, !dbg !286

747:                                              ; preds = %743
  %748 = load i8*, i8** %609, align 8, !dbg !287
  %749 = icmp eq i8* %748, null, !dbg !288
  br i1 %749, label %751, label %750, !dbg !289

750:                                              ; preds = %747
  store i8* %748, i8** %591, align 8, !dbg !290
  br label %751, !dbg !291

751:                                              ; preds = %750, %747, %631
  %752 = alloca i32, align 4, !dbg !292
  %753 = load i16, i16* %610, align 2, !dbg !293
  %754 = zext i16 %753 to i32, !dbg !294
  store i32 %754, i32* %752, align 4, !dbg !295
  %755 = alloca i64, align 8, !dbg !296
  %756 = getelementptr i32, i32* %599, i32 %754, !dbg !297
  %757 = load i32, i32* %756, align 4, !dbg !298
  %758 = zext i32 %757 to i64, !dbg !299
  store i64 %758, i64* %755, align 4, !dbg !300
  %759 = load i8*, i8** %591, align 8, !dbg !301
  %760 = load i32, i32* %606, align 4, !dbg !302
  %761 = alloca i8*, align 8, !dbg !303
  %762 = getelementptr i8, i8* %759, i32 %760, !dbg !304
  store i8* %762, i8** %761, align 8, !dbg !305
  %763 = load i32, i32* %599, align 4, !dbg !306
  %764 = getelementptr i8, i8* %759, i32 %763, !dbg !307
  br label %765, !dbg !308

765:                                              ; preds = %772, %751
  %766 = load i32, i32* %752, align 4, !dbg !309
  %767 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %594, i32 0, i32 23, i32 %766, !dbg !310
  %768 = load i8*, i8** %761, align 8, !dbg !311
  %769 = load i8, i8* %768, align 1, !dbg !312
  %770 = zext i8 %769 to i32, !dbg !313
  store i32 %770, i32* %592, align 4, !dbg !314
  store i32 %770, i32* %767, align 4, !dbg !315
  %771 = icmp sgt i8 %769, -1, !dbg !316
  br i1 %771, label %795, label %786, !dbg !317

772:                                              ; preds = %795, %786
  %773 = load i32, i32* %752, align 4, !dbg !318
  %774 = add i32 %773, 1, !dbg !319
  store i32 %774, i32* %752, align 4, !dbg !320
  %775 = load i64, i64* %755, align 4, !dbg !321
  %776 = and i64 4294967295, %775, !dbg !322
  %777 = trunc i64 %776 to i32, !dbg !323
  %778 = getelementptr i32, i32* %599, i32 %774, !dbg !324
  store i32 %777, i32* %778, align 4, !dbg !325
  %779 = load i32, i32* %752, align 4, !dbg !326
  %780 = icmp sle i32 %779, 2, !dbg !327
  %781 = load i8*, i8** %761, align 8, !dbg !328
  %782 = ptrtoint i8* %781 to i64, !dbg !329
  %783 = ptrtoint i8* %764 to i64, !dbg !330
  %784 = icmp ult i64 %782, %783, !dbg !331
  %785 = and i1 %780, %784, !dbg !332
  br i1 %785, label %765, label %804, !dbg !333

786:                                              ; preds = %765
  %787 = load i8*, i8** %761, align 8, !dbg !334
  %788 = call i8 @sqlite3GetVarint32(i8* %787, i32* %592), !dbg !335
  %789 = getelementptr i8, i8* %787, i8 %788, !dbg !336
  store i8* %789, i8** %761, align 8, !dbg !337
  %790 = load i32, i32* %592, align 4, !dbg !338
  store i32 %790, i32* %767, align 4, !dbg !339
  %791 = load i64, i64* %755, align 4, !dbg !340
  %792 = call i32 @sqlite3VdbeSerialTypeLen(i32 %790), !dbg !341
  %793 = zext i32 %792 to i64, !dbg !342
  %794 = add i64 %791, %793, !dbg !343
  store i64 %794, i64* %755, align 4, !dbg !344
  br label %772, !dbg !345

795:                                              ; preds = %765
  %796 = getelementptr i8, i8* %768, i32 1, !dbg !346
  store i8* %796, i8** %761, align 8, !dbg !347
  %797 = load i32, i32* %592, align 4, !dbg !348
  %798 = trunc i32 %797 to i8, !dbg !349
  %799 = getelementptr i8, i8* inttoptr (i64 4580428736 to i8*), i8 %798, !dbg !350
  %800 = load i8, i8* %799, align 1, !dbg !351
  %801 = zext i8 %800 to i64, !dbg !352
  %802 = load i64, i64* %755, align 4, !dbg !353
  %803 = add i64 %802, %801, !dbg !354
  store i64 %803, i64* %755, align 4, !dbg !355
  br label %772, !dbg !356

804:                                              ; preds = %772
  %805 = load i64, i64* %755, align 4, !dbg !357
  %806 = load i32, i32* %607, align 4, !dbg !358
  %807 = zext i32 %806 to i64, !dbg !359
  %808 = icmp uge i64 %782, %783, !dbg !360
  %809 = icmp ugt i64 %782, %783, !dbg !361
  %810 = icmp ne i64 %805, %807, !dbg !362
  %811 = icmp ugt i64 %805, %807, !dbg !363
  %812 = or i1 %809, %810, !dbg !364
  %813 = and i1 %808, %812, !dbg !365
  %814 = or i1 %813, %811, !dbg !366
  br i1 %814, label %815, label %819, !dbg !367

815:                                              ; preds = %804
  %816 = load i32, i32* %599, align 4, !dbg !368
  %817 = icmp eq i32 %816, 0, !dbg !369
  br i1 %817, label %818, label %819, !dbg !370

818:                                              ; preds = %815
  store i32 0, i32* %752, align 4, !dbg !371
  store i8* %764, i8** %761, align 8, !dbg !372
  br label %819, !dbg !373

819:                                              ; preds = %818, %815, %804
  %820 = load i32, i32* %752, align 4, !dbg !374
  %821 = trunc i32 %820 to i16, !dbg !375
  store i16 %821, i16* %610, align 2, !dbg !376
  %822 = load i8*, i8** %761, align 8, !dbg !377
  %823 = ptrtoint i8* %822 to i64, !dbg !378
  %824 = load i8*, i8** %591, align 8, !dbg !379
  %825 = ptrtoint i8* %824 to i64, !dbg !380
  %826 = sub i64 %823, %825, !dbg !381
  %827 = trunc i64 %826 to i32, !dbg !382
  store i32 %827, i32* %606, align 4, !dbg !383
  br label %829, !dbg !384

828:                                              ; preds = %743
  store i32 0, i32* %592, align 4, !dbg !385
  br label %829, !dbg !386

829:                                              ; preds = %828, %819
  %830 = load i16, i16* %610, align 2, !dbg !387
  %831 = icmp sle i16 %830, 2, !dbg !388
  br i1 %831, label %832, label %661, !dbg !389

832:                                              ; preds = %829
  %833 = getelementptr %struct.VdbeOp, %struct.VdbeOp* %7, i32 6, !dbg !390
  %834 = getelementptr %struct.VdbeOp, %struct.VdbeOp* %833, i32 0, i32 1, !dbg !391
  %835 = load i8, i8* %834, align 1, !dbg !392
  %836 = icmp eq i8 %835, -11, !dbg !393
  br i1 %836, label %844, label %837, !dbg !394

837:                                              ; preds = %832
  %838 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %595, i32 0, i32 1, !dbg !395
  %839 = load i16, i16* %838, align 2, !dbg !395
  %840 = and i16 %839, 9216, !dbg !395
  %841 = icmp ne i16 %840, 0, !dbg !395
  br i1 %841, label %842, label %843, !dbg !395

842:                                              ; preds = %837
  call void @vdbeMemClearExternAndSetNull(%struct.sqlite3_value* %595), !dbg !395
  br label %848, !dbg !395

843:                                              ; preds = %837
  store i16 1, i16* %838, align 2, !dbg !395
  br label %848, !dbg !395

844:                                              ; preds = %832
  %845 = getelementptr %struct.VdbeOp, %struct.VdbeOp* %833, i32 0, i32 6, !dbg !396
  %846 = bitcast %union.p4union* %845 to %struct.sqlite3_value**, !dbg !397
  %847 = load %struct.sqlite3_value*, %struct.sqlite3_value** %846, align 8, !dbg !398
  call void @sqlite3VdbeMemShallowCopy(%struct.sqlite3_value* %595, %struct.sqlite3_value* %847, i32 2048), !dbg !399
  br label %848, !dbg !400

848:                                              ; preds = %844, %843, %842, %738, %727, %708, %688, %657, %656
  call void @llvm.stackrestore(i8* %585), !dbg !401
  br label %849, !dbg !68

849:                                              ; preds = %848, %1
  %850 = call i8* @llvm.stacksave(), !dbg !102
  %851 = getelementptr %struct.sqlite3, %struct.sqlite3* %9, i32 0, i32 16, !dbg !105
  %852 = load i8, i8* %851, align 1, !dbg !106
  %853 = alloca i32, align 4, !dbg !107
  store i32 0, i32* %853, align 4, !dbg !108
  %854 = alloca %struct.VdbeCursor*, align 8, !dbg !109
  %855 = load %struct.VdbeCursor*, %struct.VdbeCursor** %5, align 8, !dbg !110
  store %struct.VdbeCursor* %855, %struct.VdbeCursor** %854, align 8, !dbg !111
  %856 = alloca i8*, align 8, !dbg !112
  %857 = alloca i32, align 4, !dbg !113
  %858 = call i32 @sqlite3VdbeCursorMoveto(%struct.VdbeCursor** %854, i32* %853), !dbg !114
  %859 = load %struct.VdbeCursor*, %struct.VdbeCursor** %854, align 8, !dbg !115
  %860 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %3, i32 4, !dbg !116
  %861 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %859, i32 0, i32 16, !dbg !117
  %862 = load i16, i16* %861, align 2, !dbg !118
  %863 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %859, i32 0, i32 19, !dbg !119
  %864 = load i32*, i32** %863, align 8, !dbg !120
  %865 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %859, i32 0, i32 0, !dbg !121
  %866 = load i8, i8* %865, align 1, !dbg !122
  %867 = icmp ne i8 %866, 3, !dbg !123
  %868 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %859, i32 0, i32 2, !dbg !124
  %869 = load i8, i8* %868, align 1, !dbg !125
  %870 = icmp ne i8 %869, 0, !dbg !126
  %871 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %859, i32 0, i32 14, !dbg !127
  %872 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %859, i32 0, i32 21, !dbg !128
  %873 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %859, i32 0, i32 22, !dbg !129
  %874 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %859, i32 0, i32 20, !dbg !130
  %875 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %859, i32 0, i32 17, !dbg !131
  %876 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %859, i32 0, i32 9, !dbg !132
  %877 = load i32, i32* %876, align 4, !dbg !133
  %878 = getelementptr %struct.Vdbe, %struct.Vdbe* %0, i32 0, i32 9, !dbg !134
  %879 = load i32, i32* %878, align 4, !dbg !135
  %880 = icmp ne i32 %877, %879, !dbg !136
  br i1 %880, label %881, label %923, !dbg !137

881:                                              ; preds = %849
  br i1 %870, label %903, label %898, !dbg !138

882:                                              ; preds = %905, %898
  %883 = load i32, i32* %878, align 4, !dbg !139
  store i32 %883, i32* %876, align 4, !dbg !140
  %884 = load i8*, i8** %874, align 8, !dbg !141
  %885 = load i8, i8* %884, align 1, !dbg !142
  %886 = icmp sgt i8 %885, -1, !dbg !145
  br i1 %886, label %887, label %889, !dbg !146

887:                                              ; preds = %882
  %888 = zext i8 %885 to i32, !dbg !147
  store i32 %888, i32* %864, align 4, !dbg !148
  store i32 1, i32* %871, align 4, !dbg !149
  br label %892, !dbg !150

889:                                              ; preds = %882
  %890 = call i8 @sqlite3GetVarint32(i8* %884, i32* %864), !dbg !151
  %891 = zext i8 %890 to i32, !dbg !152
  store i32 %891, i32* %871, align 4, !dbg !153
  br label %892, !dbg !154

892:                                              ; preds = %889, %887
  store i16 0, i16* %875, align 2, !dbg !155
  %893 = load i32, i32* %873, align 4, !dbg !156
  %894 = load i32, i32* %864, align 4, !dbg !157
  %895 = icmp ult i32 %893, %894, !dbg !158
  br i1 %895, label %897, label %896, !dbg !159

896:                                              ; preds = %892
  store i8* %884, i8** %856, align 8, !dbg !160
  br label %1016, !dbg !161

897:                                              ; preds = %892
  store i8* null, i8** %874, align 8, !dbg !162
  store i32 0, i32* %873, align 4, !dbg !163
  br label %923, !dbg !164

898:                                              ; preds = %881
  %899 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %859, i32 0, i32 12, i32 0, !dbg !165
  %900 = load %struct.BtCursor*, %struct.BtCursor** %899, align 8, !dbg !166
  %901 = call i32 @sqlite3BtreePayloadSize(%struct.BtCursor* %900), !dbg !167
  store i32 %901, i32* %872, align 4, !dbg !168
  %902 = call i8* @sqlite3BtreePayloadFetch(%struct.BtCursor* %900, i32* %873), !dbg !169
  store i8* %902, i8** %874, align 8, !dbg !170
  br label %882, !dbg !171

903:                                              ; preds = %881
  %904 = icmp eq i8 %866, 3, !dbg !172
  br i1 %904, label %905, label %916, !dbg !173

905:                                              ; preds = %903
  %906 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %859, i32 0, i32 10, !dbg !174
  %907 = load i32, i32* %906, align 4, !dbg !175
  %908 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %3, i32 %907, !dbg !176
  %909 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %908, i32 0, i32 1, !dbg !177
  %910 = load i16, i16* %909, align 2, !dbg !178
  %911 = and i16 %910, 16, !dbg !179
  %912 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %908, i32 0, i32 4, !dbg !180
  %913 = load i32, i32* %912, align 4, !dbg !181
  store i32 %913, i32* %872, align 4, !dbg !182
  store i32 %913, i32* %873, align 4, !dbg !183
  %914 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %908, i32 0, i32 5, !dbg !184
  %915 = load i8*, i8** %914, align 8, !dbg !185
  store i8* %915, i8** %874, align 8, !dbg !186
  br label %882, !dbg !187

916:                                              ; preds = %903
  %917 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %860, i32 0, i32 1, !dbg !188
  %918 = load i16, i16* %917, align 2, !dbg !188
  %919 = and i16 %918, 9216, !dbg !188
  %920 = icmp ne i16 %919, 0, !dbg !188
  br i1 %920, label %921, label %922, !dbg !188

921:                                              ; preds = %916
  call void @vdbeMemClearExternAndSetNull(%struct.sqlite3_value* %860), !dbg !188
  br label %1113, !dbg !188

922:                                              ; preds = %916
  store i16 1, i16* %917, align 2, !dbg !188
  br label %1113, !dbg !188

923:                                              ; preds = %897, %849
  %924 = load i16, i16* %875, align 2, !dbg !189
  %925 = icmp ule i16 %924, 3, !dbg !190
  br i1 %925, label %1008, label %1005, !dbg !191

926:                                              ; preds = %1094, %1005
  %927 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %860, i32 0, i32 1, !dbg !192
  %928 = load i16, i16* %927, align 2, !dbg !193
  %929 = and i16 9216, %928, !dbg !194
  %930 = icmp eq i16 0, %929, !dbg !195
  br i1 %930, label %931, label %935, !dbg !196

931:                                              ; preds = %926
  %932 = icmp ne i16 %929, 0, !dbg !197
  br i1 %932, label %933, label %934, !dbg !197

933:                                              ; preds = %931
  call void @vdbeMemClearExternAndSetNull(%struct.sqlite3_value* %860), !dbg !197
  br label %935, !dbg !197

934:                                              ; preds = %931
  store i16 1, i16* %927, align 2, !dbg !197
  br label %935, !dbg !197

935:                                              ; preds = %934, %933, %926
  %936 = load i32, i32* %857, align 4, !dbg !198
  %937 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %859, i32 0, i32 23, i32 3, !dbg !199
  %938 = load i32, i32* %937, align 4, !dbg !200
  %939 = load i32, i32* %873, align 4, !dbg !201
  %940 = getelementptr i32, i32* %864, i32 4, !dbg !202
  %941 = load i32, i32* %940, align 4, !dbg !203
  %942 = icmp sge i32 %939, %941, !dbg !204
  br i1 %942, label %943, label %983, !dbg !205

943:                                              ; preds = %935
  %944 = load i8*, i8** %874, align 8, !dbg !206
  %945 = ptrtoint i8* %944 to i64, !dbg !207
  %946 = getelementptr i32, i32* %864, i32 3, !dbg !402
  %947 = load i32, i32* %946, align 4, !dbg !208
  %948 = zext i32 %947 to i64, !dbg !209
  %949 = add i64 %945, %948, !dbg !210
  %950 = inttoptr i64 %949 to i8*, !dbg !211
  store i8* %950, i8** %856, align 8, !dbg !212
  %951 = load i32, i32* %857, align 4, !dbg !213
  %952 = icmp ult i32 %951, 12, !dbg !214
  br i1 %952, label %953, label %955, !dbg !215

953:                                              ; preds = %943
  %954 = call i32 @sqlite3VdbeSerialGet(i8* %950, i32 %951, %struct.sqlite3_value* %860), !dbg !216
  br label %1113, !dbg !217

955:                                              ; preds = %943
  %956 = alloca i16, i32 2, align 2, !dbg !218
  store i16 16, i16* %956, align 2, !dbg !219
  %957 = getelementptr i16, i16* %956, i32 1, !dbg !220
  store i16 514, i16* %957, align 2, !dbg !221
  %958 = load i32, i32* %857, align 4, !dbg !222
  %959 = sub i32 %958, 12, !dbg !223
  %960 = lshr i32 %959, 1, !dbg !224
  %961 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %860, i32 0, i32 4, !dbg !225
  store i32 %960, i32* %961, align 4, !dbg !226
  %962 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %860, i32 0, i32 2, !dbg !227
  store i8 %852, i8* %962, align 1, !dbg !228
  %963 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %860, i32 0, i32 5, !dbg !229
  %964 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %860, i32 0, i32 7, !dbg !230
  %965 = load i32, i32* %964, align 4, !dbg !231
  %966 = add i32 %960, 2, !dbg !232
  %967 = icmp slt i32 %965, %966, !dbg !233
  br i1 %967, label %968, label %970, !dbg !234

968:                                              ; preds = %955
  store i16 1, i16* %927, align 2, !dbg !235
  %969 = call i32 @sqlite3VdbeMemGrow(%struct.sqlite3_value* %860, i32 %966, i32 0), !dbg !236
  br label %973, !dbg !237

970:                                              ; preds = %955
  %971 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %860, i32 0, i32 6, !dbg !238
  %972 = load i8*, i8** %971, align 8, !dbg !239
  store i8* %972, i8** %963, align 8, !dbg !240
  br label %973, !dbg !241

973:                                              ; preds = %970, %968
  %974 = zext i32 %960 to i64, !dbg !242
  %975 = load i8*, i8** %963, align 8, !dbg !243
  %976 = load i8*, i8** %856, align 8, !dbg !244
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %975, i8* %976, i64 %974, i1 false), !dbg !245
  %977 = getelementptr i8, i8* %975, i32 %960, !dbg !246
  store i8 0, i8* %977, align 1, !dbg !247
  %978 = add i32 %960, 1, !dbg !248
  %979 = getelementptr i8, i8* %975, i32 %978, !dbg !249
  store i8 0, i8* %979, align 1, !dbg !250
  %980 = and i32 %958, 1, !dbg !251
  %981 = getelementptr i16, i16* %956, i32 %980, !dbg !252
  %982 = load i16, i16* %981, align 2, !dbg !253
  store i16 %982, i16* %927, align 2, !dbg !254
  br label %1113, !dbg !255

983:                                              ; preds = %935
  %984 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %860, i32 0, i32 2, !dbg !256
  store i8 %852, i8* %984, align 1, !dbg !257
  %985 = load i32, i32* %857, align 4, !dbg !258
  %986 = and i32 %985, 1, !dbg !259
  %987 = icmp eq i32 %986, 0, !dbg !260
  %988 = icmp sge i32 %985, 12, !dbg !261
  %989 = and i1 %988, %987, !dbg !262
  %990 = call i32 @sqlite3VdbeSerialTypeLen(i32 %985), !dbg !263
  %991 = icmp eq i32 %990, 0, !dbg !264
  br i1 %991, label %1003, label %992, !dbg !265

992:                                              ; preds = %983
  %993 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %859, i32 0, i32 12, i32 0, !dbg !266
  %994 = load %struct.BtCursor*, %struct.BtCursor** %993, align 8, !dbg !267
  %995 = getelementptr i32, i32* %864, i32 3, !dbg !403
  %996 = load i32, i32* %995, align 4, !dbg !268
  %997 = call i32 @sqlite3VdbeMemFromBtree(%struct.BtCursor* %994, i32 %996, i32 %990, %struct.sqlite3_value* %860), !dbg !269
  %998 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %860, i32 0, i32 5, !dbg !270
  %999 = load i8*, i8** %998, align 8, !dbg !271
  %1000 = call i32 @sqlite3VdbeSerialGet(i8* %999, i32 %985, %struct.sqlite3_value* %860), !dbg !272
  %1001 = load i16, i16* %927, align 2, !dbg !273
  %1002 = and i16 %1001, -4097, !dbg !274
  store i16 %1002, i16* %927, align 2, !dbg !275
  br label %1113, !dbg !276

1003:                                             ; preds = %983
  %1004 = call i32 @sqlite3VdbeSerialGet(i8* inttoptr (i64 4580411056 to i8*), i32 %985, %struct.sqlite3_value* %860), !dbg !277
  br label %1113, !dbg !278

1005:                                             ; preds = %923
  %1006 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %859, i32 0, i32 23, i32 3, !dbg !279
  %1007 = load i32, i32* %1006, align 4, !dbg !280
  store i32 %1007, i32* %857, align 4, !dbg !281
  br label %926, !dbg !282

1008:                                             ; preds = %923
  %1009 = load i32, i32* %871, align 4, !dbg !283
  %1010 = load i32, i32* %864, align 4, !dbg !284
  %1011 = icmp ult i32 %1009, %1010, !dbg !285
  br i1 %1011, label %1012, label %1093, !dbg !286

1012:                                             ; preds = %1008
  %1013 = load i8*, i8** %874, align 8, !dbg !287
  %1014 = icmp eq i8* %1013, null, !dbg !288
  br i1 %1014, label %1016, label %1015, !dbg !289

1015:                                             ; preds = %1012
  store i8* %1013, i8** %856, align 8, !dbg !290
  br label %1016, !dbg !291

1016:                                             ; preds = %1015, %1012, %896
  %1017 = alloca i32, align 4, !dbg !292
  %1018 = load i16, i16* %875, align 2, !dbg !293
  %1019 = zext i16 %1018 to i32, !dbg !294
  store i32 %1019, i32* %1017, align 4, !dbg !295
  %1020 = alloca i64, align 8, !dbg !296
  %1021 = getelementptr i32, i32* %864, i32 %1019, !dbg !297
  %1022 = load i32, i32* %1021, align 4, !dbg !298
  %1023 = zext i32 %1022 to i64, !dbg !299
  store i64 %1023, i64* %1020, align 4, !dbg !300
  %1024 = load i8*, i8** %856, align 8, !dbg !301
  %1025 = load i32, i32* %871, align 4, !dbg !302
  %1026 = alloca i8*, align 8, !dbg !303
  %1027 = getelementptr i8, i8* %1024, i32 %1025, !dbg !304
  store i8* %1027, i8** %1026, align 8, !dbg !305
  %1028 = load i32, i32* %864, align 4, !dbg !306
  %1029 = getelementptr i8, i8* %1024, i32 %1028, !dbg !307
  br label %1030, !dbg !308

1030:                                             ; preds = %1037, %1016
  %1031 = load i32, i32* %1017, align 4, !dbg !309
  %1032 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %859, i32 0, i32 23, i32 %1031, !dbg !310
  %1033 = load i8*, i8** %1026, align 8, !dbg !311
  %1034 = load i8, i8* %1033, align 1, !dbg !312
  %1035 = zext i8 %1034 to i32, !dbg !313
  store i32 %1035, i32* %857, align 4, !dbg !314
  store i32 %1035, i32* %1032, align 4, !dbg !315
  %1036 = icmp sgt i8 %1034, -1, !dbg !316
  br i1 %1036, label %1060, label %1051, !dbg !317

1037:                                             ; preds = %1060, %1051
  %1038 = load i32, i32* %1017, align 4, !dbg !318
  %1039 = add i32 %1038, 1, !dbg !319
  store i32 %1039, i32* %1017, align 4, !dbg !320
  %1040 = load i64, i64* %1020, align 4, !dbg !321
  %1041 = and i64 4294967295, %1040, !dbg !322
  %1042 = trunc i64 %1041 to i32, !dbg !323
  %1043 = getelementptr i32, i32* %864, i32 %1039, !dbg !324
  store i32 %1042, i32* %1043, align 4, !dbg !325
  %1044 = load i32, i32* %1017, align 4, !dbg !326
  %1045 = icmp sle i32 %1044, 3, !dbg !327
  %1046 = load i8*, i8** %1026, align 8, !dbg !328
  %1047 = ptrtoint i8* %1046 to i64, !dbg !329
  %1048 = ptrtoint i8* %1029 to i64, !dbg !330
  %1049 = icmp ult i64 %1047, %1048, !dbg !331
  %1050 = and i1 %1045, %1049, !dbg !332
  br i1 %1050, label %1030, label %1069, !dbg !333

1051:                                             ; preds = %1030
  %1052 = load i8*, i8** %1026, align 8, !dbg !334
  %1053 = call i8 @sqlite3GetVarint32(i8* %1052, i32* %857), !dbg !335
  %1054 = getelementptr i8, i8* %1052, i8 %1053, !dbg !336
  store i8* %1054, i8** %1026, align 8, !dbg !337
  %1055 = load i32, i32* %857, align 4, !dbg !338
  store i32 %1055, i32* %1032, align 4, !dbg !339
  %1056 = load i64, i64* %1020, align 4, !dbg !340
  %1057 = call i32 @sqlite3VdbeSerialTypeLen(i32 %1055), !dbg !341
  %1058 = zext i32 %1057 to i64, !dbg !342
  %1059 = add i64 %1056, %1058, !dbg !343
  store i64 %1059, i64* %1020, align 4, !dbg !344
  br label %1037, !dbg !345

1060:                                             ; preds = %1030
  %1061 = getelementptr i8, i8* %1033, i32 1, !dbg !346
  store i8* %1061, i8** %1026, align 8, !dbg !347
  %1062 = load i32, i32* %857, align 4, !dbg !348
  %1063 = trunc i32 %1062 to i8, !dbg !349
  %1064 = getelementptr i8, i8* inttoptr (i64 4580428736 to i8*), i8 %1063, !dbg !350
  %1065 = load i8, i8* %1064, align 1, !dbg !351
  %1066 = zext i8 %1065 to i64, !dbg !352
  %1067 = load i64, i64* %1020, align 4, !dbg !353
  %1068 = add i64 %1067, %1066, !dbg !354
  store i64 %1068, i64* %1020, align 4, !dbg !355
  br label %1037, !dbg !356

1069:                                             ; preds = %1037
  %1070 = load i64, i64* %1020, align 4, !dbg !357
  %1071 = load i32, i32* %872, align 4, !dbg !358
  %1072 = zext i32 %1071 to i64, !dbg !359
  %1073 = icmp uge i64 %1047, %1048, !dbg !360
  %1074 = icmp ugt i64 %1047, %1048, !dbg !361
  %1075 = icmp ne i64 %1070, %1072, !dbg !362
  %1076 = icmp ugt i64 %1070, %1072, !dbg !363
  %1077 = or i1 %1074, %1075, !dbg !364
  %1078 = and i1 %1073, %1077, !dbg !365
  %1079 = or i1 %1078, %1076, !dbg !366
  br i1 %1079, label %1080, label %1084, !dbg !367

1080:                                             ; preds = %1069
  %1081 = load i32, i32* %864, align 4, !dbg !368
  %1082 = icmp eq i32 %1081, 0, !dbg !369
  br i1 %1082, label %1083, label %1084, !dbg !370

1083:                                             ; preds = %1080
  store i32 0, i32* %1017, align 4, !dbg !371
  store i8* %1029, i8** %1026, align 8, !dbg !372
  br label %1084, !dbg !373

1084:                                             ; preds = %1083, %1080, %1069
  %1085 = load i32, i32* %1017, align 4, !dbg !374
  %1086 = trunc i32 %1085 to i16, !dbg !375
  store i16 %1086, i16* %875, align 2, !dbg !376
  %1087 = load i8*, i8** %1026, align 8, !dbg !377
  %1088 = ptrtoint i8* %1087 to i64, !dbg !378
  %1089 = load i8*, i8** %856, align 8, !dbg !379
  %1090 = ptrtoint i8* %1089 to i64, !dbg !380
  %1091 = sub i64 %1088, %1090, !dbg !381
  %1092 = trunc i64 %1091 to i32, !dbg !382
  store i32 %1092, i32* %871, align 4, !dbg !383
  br label %1094, !dbg !384

1093:                                             ; preds = %1008
  store i32 0, i32* %857, align 4, !dbg !385
  br label %1094, !dbg !386

1094:                                             ; preds = %1093, %1084
  %1095 = load i16, i16* %875, align 2, !dbg !387
  %1096 = icmp sle i16 %1095, 3, !dbg !388
  br i1 %1096, label %1097, label %926, !dbg !389

1097:                                             ; preds = %1094
  %1098 = getelementptr %struct.VdbeOp, %struct.VdbeOp* %7, i32 7, !dbg !390
  %1099 = getelementptr %struct.VdbeOp, %struct.VdbeOp* %1098, i32 0, i32 1, !dbg !391
  %1100 = load i8, i8* %1099, align 1, !dbg !392
  %1101 = icmp eq i8 %1100, -11, !dbg !393
  br i1 %1101, label %1109, label %1102, !dbg !394

1102:                                             ; preds = %1097
  %1103 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %860, i32 0, i32 1, !dbg !395
  %1104 = load i16, i16* %1103, align 2, !dbg !395
  %1105 = and i16 %1104, 9216, !dbg !395
  %1106 = icmp ne i16 %1105, 0, !dbg !395
  br i1 %1106, label %1107, label %1108, !dbg !395

1107:                                             ; preds = %1102
  call void @vdbeMemClearExternAndSetNull(%struct.sqlite3_value* %860), !dbg !395
  br label %1113, !dbg !395

1108:                                             ; preds = %1102
  store i16 1, i16* %1103, align 2, !dbg !395
  br label %1113, !dbg !395

1109:                                             ; preds = %1097
  %1110 = getelementptr %struct.VdbeOp, %struct.VdbeOp* %1098, i32 0, i32 6, !dbg !396
  %1111 = bitcast %union.p4union* %1110 to %struct.sqlite3_value**, !dbg !397
  %1112 = load %struct.sqlite3_value*, %struct.sqlite3_value** %1111, align 8, !dbg !398
  call void @sqlite3VdbeMemShallowCopy(%struct.sqlite3_value* %860, %struct.sqlite3_value* %1112, i32 2048), !dbg !399
  br label %1113, !dbg !400

1113:                                             ; preds = %1109, %1108, %1107, %1003, %992, %973, %953, %922, %921
  call void @llvm.stackrestore(i8* %850), !dbg !401
  br label %1114, !dbg !68

1114:                                             ; preds = %1113, %1
  %1115 = call i8* @llvm.stacksave(), !dbg !102
  %1116 = getelementptr %struct.sqlite3, %struct.sqlite3* %9, i32 0, i32 16, !dbg !105
  %1117 = load i8, i8* %1116, align 1, !dbg !106
  %1118 = alloca i32, align 4, !dbg !107
  store i32 0, i32* %1118, align 4, !dbg !108
  %1119 = alloca %struct.VdbeCursor*, align 8, !dbg !109
  %1120 = load %struct.VdbeCursor*, %struct.VdbeCursor** %5, align 8, !dbg !110
  store %struct.VdbeCursor* %1120, %struct.VdbeCursor** %1119, align 8, !dbg !111
  %1121 = alloca i8*, align 8, !dbg !112
  %1122 = alloca i32, align 4, !dbg !113
  %1123 = call i32 @sqlite3VdbeCursorMoveto(%struct.VdbeCursor** %1119, i32* %1118), !dbg !114
  %1124 = load %struct.VdbeCursor*, %struct.VdbeCursor** %1119, align 8, !dbg !115
  %1125 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %3, i32 5, !dbg !116
  %1126 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %1124, i32 0, i32 16, !dbg !117
  %1127 = load i16, i16* %1126, align 2, !dbg !118
  %1128 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %1124, i32 0, i32 19, !dbg !119
  %1129 = load i32*, i32** %1128, align 8, !dbg !120
  %1130 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %1124, i32 0, i32 0, !dbg !121
  %1131 = load i8, i8* %1130, align 1, !dbg !122
  %1132 = icmp ne i8 %1131, 3, !dbg !123
  %1133 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %1124, i32 0, i32 2, !dbg !124
  %1134 = load i8, i8* %1133, align 1, !dbg !125
  %1135 = icmp ne i8 %1134, 0, !dbg !126
  %1136 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %1124, i32 0, i32 14, !dbg !127
  %1137 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %1124, i32 0, i32 21, !dbg !128
  %1138 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %1124, i32 0, i32 22, !dbg !129
  %1139 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %1124, i32 0, i32 20, !dbg !130
  %1140 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %1124, i32 0, i32 17, !dbg !131
  %1141 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %1124, i32 0, i32 9, !dbg !132
  %1142 = load i32, i32* %1141, align 4, !dbg !133
  %1143 = getelementptr %struct.Vdbe, %struct.Vdbe* %0, i32 0, i32 9, !dbg !134
  %1144 = load i32, i32* %1143, align 4, !dbg !135
  %1145 = icmp ne i32 %1142, %1144, !dbg !136
  br i1 %1145, label %1146, label %1188, !dbg !137

1146:                                             ; preds = %1114
  br i1 %1135, label %1168, label %1163, !dbg !138

1147:                                             ; preds = %1170, %1163
  %1148 = load i32, i32* %1143, align 4, !dbg !139
  store i32 %1148, i32* %1141, align 4, !dbg !140
  %1149 = load i8*, i8** %1139, align 8, !dbg !141
  %1150 = load i8, i8* %1149, align 1, !dbg !142
  %1151 = icmp sgt i8 %1150, -1, !dbg !145
  br i1 %1151, label %1152, label %1154, !dbg !146

1152:                                             ; preds = %1147
  %1153 = zext i8 %1150 to i32, !dbg !147
  store i32 %1153, i32* %1129, align 4, !dbg !148
  store i32 1, i32* %1136, align 4, !dbg !149
  br label %1157, !dbg !150

1154:                                             ; preds = %1147
  %1155 = call i8 @sqlite3GetVarint32(i8* %1149, i32* %1129), !dbg !151
  %1156 = zext i8 %1155 to i32, !dbg !152
  store i32 %1156, i32* %1136, align 4, !dbg !153
  br label %1157, !dbg !154

1157:                                             ; preds = %1154, %1152
  store i16 0, i16* %1140, align 2, !dbg !155
  %1158 = load i32, i32* %1138, align 4, !dbg !156
  %1159 = load i32, i32* %1129, align 4, !dbg !157
  %1160 = icmp ult i32 %1158, %1159, !dbg !158
  br i1 %1160, label %1162, label %1161, !dbg !159

1161:                                             ; preds = %1157
  store i8* %1149, i8** %1121, align 8, !dbg !160
  br label %1281, !dbg !161

1162:                                             ; preds = %1157
  store i8* null, i8** %1139, align 8, !dbg !162
  store i32 0, i32* %1138, align 4, !dbg !163
  br label %1188, !dbg !164

1163:                                             ; preds = %1146
  %1164 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %1124, i32 0, i32 12, i32 0, !dbg !165
  %1165 = load %struct.BtCursor*, %struct.BtCursor** %1164, align 8, !dbg !166
  %1166 = call i32 @sqlite3BtreePayloadSize(%struct.BtCursor* %1165), !dbg !167
  store i32 %1166, i32* %1137, align 4, !dbg !168
  %1167 = call i8* @sqlite3BtreePayloadFetch(%struct.BtCursor* %1165, i32* %1138), !dbg !169
  store i8* %1167, i8** %1139, align 8, !dbg !170
  br label %1147, !dbg !171

1168:                                             ; preds = %1146
  %1169 = icmp eq i8 %1131, 3, !dbg !172
  br i1 %1169, label %1170, label %1181, !dbg !173

1170:                                             ; preds = %1168
  %1171 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %1124, i32 0, i32 10, !dbg !174
  %1172 = load i32, i32* %1171, align 4, !dbg !175
  %1173 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %3, i32 %1172, !dbg !176
  %1174 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %1173, i32 0, i32 1, !dbg !177
  %1175 = load i16, i16* %1174, align 2, !dbg !178
  %1176 = and i16 %1175, 16, !dbg !179
  %1177 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %1173, i32 0, i32 4, !dbg !180
  %1178 = load i32, i32* %1177, align 4, !dbg !181
  store i32 %1178, i32* %1137, align 4, !dbg !182
  store i32 %1178, i32* %1138, align 4, !dbg !183
  %1179 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %1173, i32 0, i32 5, !dbg !184
  %1180 = load i8*, i8** %1179, align 8, !dbg !185
  store i8* %1180, i8** %1139, align 8, !dbg !186
  br label %1147, !dbg !187

1181:                                             ; preds = %1168
  %1182 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %1125, i32 0, i32 1, !dbg !188
  %1183 = load i16, i16* %1182, align 2, !dbg !188
  %1184 = and i16 %1183, 9216, !dbg !188
  %1185 = icmp ne i16 %1184, 0, !dbg !188
  br i1 %1185, label %1186, label %1187, !dbg !188

1186:                                             ; preds = %1181
  call void @vdbeMemClearExternAndSetNull(%struct.sqlite3_value* %1125), !dbg !188
  br label %1378, !dbg !188

1187:                                             ; preds = %1181
  store i16 1, i16* %1182, align 2, !dbg !188
  br label %1378, !dbg !188

1188:                                             ; preds = %1162, %1114
  %1189 = load i16, i16* %1140, align 2, !dbg !189
  %1190 = icmp ule i16 %1189, 4, !dbg !190
  br i1 %1190, label %1273, label %1270, !dbg !191

1191:                                             ; preds = %1359, %1270
  %1192 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %1125, i32 0, i32 1, !dbg !192
  %1193 = load i16, i16* %1192, align 2, !dbg !193
  %1194 = and i16 9216, %1193, !dbg !194
  %1195 = icmp eq i16 0, %1194, !dbg !195
  br i1 %1195, label %1196, label %1200, !dbg !196

1196:                                             ; preds = %1191
  %1197 = icmp ne i16 %1194, 0, !dbg !197
  br i1 %1197, label %1198, label %1199, !dbg !197

1198:                                             ; preds = %1196
  call void @vdbeMemClearExternAndSetNull(%struct.sqlite3_value* %1125), !dbg !197
  br label %1200, !dbg !197

1199:                                             ; preds = %1196
  store i16 1, i16* %1192, align 2, !dbg !197
  br label %1200, !dbg !197

1200:                                             ; preds = %1199, %1198, %1191
  %1201 = load i32, i32* %1122, align 4, !dbg !198
  %1202 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %1124, i32 0, i32 23, i32 4, !dbg !199
  %1203 = load i32, i32* %1202, align 4, !dbg !200
  %1204 = load i32, i32* %1138, align 4, !dbg !201
  %1205 = getelementptr i32, i32* %1129, i32 5, !dbg !202
  %1206 = load i32, i32* %1205, align 4, !dbg !203
  %1207 = icmp sge i32 %1204, %1206, !dbg !204
  br i1 %1207, label %1208, label %1248, !dbg !205

1208:                                             ; preds = %1200
  %1209 = load i8*, i8** %1139, align 8, !dbg !206
  %1210 = ptrtoint i8* %1209 to i64, !dbg !207
  %1211 = getelementptr i32, i32* %1129, i32 4, !dbg !402
  %1212 = load i32, i32* %1211, align 4, !dbg !208
  %1213 = zext i32 %1212 to i64, !dbg !209
  %1214 = add i64 %1210, %1213, !dbg !210
  %1215 = inttoptr i64 %1214 to i8*, !dbg !211
  store i8* %1215, i8** %1121, align 8, !dbg !212
  %1216 = load i32, i32* %1122, align 4, !dbg !213
  %1217 = icmp ult i32 %1216, 12, !dbg !214
  br i1 %1217, label %1218, label %1220, !dbg !215

1218:                                             ; preds = %1208
  %1219 = call i32 @sqlite3VdbeSerialGet(i8* %1215, i32 %1216, %struct.sqlite3_value* %1125), !dbg !216
  br label %1378, !dbg !217

1220:                                             ; preds = %1208
  %1221 = alloca i16, i32 2, align 2, !dbg !218
  store i16 16, i16* %1221, align 2, !dbg !219
  %1222 = getelementptr i16, i16* %1221, i32 1, !dbg !220
  store i16 514, i16* %1222, align 2, !dbg !221
  %1223 = load i32, i32* %1122, align 4, !dbg !222
  %1224 = sub i32 %1223, 12, !dbg !223
  %1225 = lshr i32 %1224, 1, !dbg !224
  %1226 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %1125, i32 0, i32 4, !dbg !225
  store i32 %1225, i32* %1226, align 4, !dbg !226
  %1227 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %1125, i32 0, i32 2, !dbg !227
  store i8 %1117, i8* %1227, align 1, !dbg !228
  %1228 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %1125, i32 0, i32 5, !dbg !229
  %1229 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %1125, i32 0, i32 7, !dbg !230
  %1230 = load i32, i32* %1229, align 4, !dbg !231
  %1231 = add i32 %1225, 2, !dbg !232
  %1232 = icmp slt i32 %1230, %1231, !dbg !233
  br i1 %1232, label %1233, label %1235, !dbg !234

1233:                                             ; preds = %1220
  store i16 1, i16* %1192, align 2, !dbg !235
  %1234 = call i32 @sqlite3VdbeMemGrow(%struct.sqlite3_value* %1125, i32 %1231, i32 0), !dbg !236
  br label %1238, !dbg !237

1235:                                             ; preds = %1220
  %1236 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %1125, i32 0, i32 6, !dbg !238
  %1237 = load i8*, i8** %1236, align 8, !dbg !239
  store i8* %1237, i8** %1228, align 8, !dbg !240
  br label %1238, !dbg !241

1238:                                             ; preds = %1235, %1233
  %1239 = zext i32 %1225 to i64, !dbg !242
  %1240 = load i8*, i8** %1228, align 8, !dbg !243
  %1241 = load i8*, i8** %1121, align 8, !dbg !244
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %1240, i8* %1241, i64 %1239, i1 false), !dbg !245
  %1242 = getelementptr i8, i8* %1240, i32 %1225, !dbg !246
  store i8 0, i8* %1242, align 1, !dbg !247
  %1243 = add i32 %1225, 1, !dbg !248
  %1244 = getelementptr i8, i8* %1240, i32 %1243, !dbg !249
  store i8 0, i8* %1244, align 1, !dbg !250
  %1245 = and i32 %1223, 1, !dbg !251
  %1246 = getelementptr i16, i16* %1221, i32 %1245, !dbg !252
  %1247 = load i16, i16* %1246, align 2, !dbg !253
  store i16 %1247, i16* %1192, align 2, !dbg !254
  br label %1378, !dbg !255

1248:                                             ; preds = %1200
  %1249 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %1125, i32 0, i32 2, !dbg !256
  store i8 %1117, i8* %1249, align 1, !dbg !257
  %1250 = load i32, i32* %1122, align 4, !dbg !258
  %1251 = and i32 %1250, 1, !dbg !259
  %1252 = icmp eq i32 %1251, 0, !dbg !260
  %1253 = icmp sge i32 %1250, 12, !dbg !261
  %1254 = and i1 %1253, %1252, !dbg !262
  %1255 = call i32 @sqlite3VdbeSerialTypeLen(i32 %1250), !dbg !263
  %1256 = icmp eq i32 %1255, 0, !dbg !264
  br i1 %1256, label %1268, label %1257, !dbg !265

1257:                                             ; preds = %1248
  %1258 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %1124, i32 0, i32 12, i32 0, !dbg !266
  %1259 = load %struct.BtCursor*, %struct.BtCursor** %1258, align 8, !dbg !267
  %1260 = getelementptr i32, i32* %1129, i32 4, !dbg !403
  %1261 = load i32, i32* %1260, align 4, !dbg !268
  %1262 = call i32 @sqlite3VdbeMemFromBtree(%struct.BtCursor* %1259, i32 %1261, i32 %1255, %struct.sqlite3_value* %1125), !dbg !269
  %1263 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %1125, i32 0, i32 5, !dbg !270
  %1264 = load i8*, i8** %1263, align 8, !dbg !271
  %1265 = call i32 @sqlite3VdbeSerialGet(i8* %1264, i32 %1250, %struct.sqlite3_value* %1125), !dbg !272
  %1266 = load i16, i16* %1192, align 2, !dbg !273
  %1267 = and i16 %1266, -4097, !dbg !274
  store i16 %1267, i16* %1192, align 2, !dbg !275
  br label %1378, !dbg !276

1268:                                             ; preds = %1248
  %1269 = call i32 @sqlite3VdbeSerialGet(i8* inttoptr (i64 4580411056 to i8*), i32 %1250, %struct.sqlite3_value* %1125), !dbg !277
  br label %1378, !dbg !278

1270:                                             ; preds = %1188
  %1271 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %1124, i32 0, i32 23, i32 4, !dbg !279
  %1272 = load i32, i32* %1271, align 4, !dbg !280
  store i32 %1272, i32* %1122, align 4, !dbg !281
  br label %1191, !dbg !282

1273:                                             ; preds = %1188
  %1274 = load i32, i32* %1136, align 4, !dbg !283
  %1275 = load i32, i32* %1129, align 4, !dbg !284
  %1276 = icmp ult i32 %1274, %1275, !dbg !285
  br i1 %1276, label %1277, label %1358, !dbg !286

1277:                                             ; preds = %1273
  %1278 = load i8*, i8** %1139, align 8, !dbg !287
  %1279 = icmp eq i8* %1278, null, !dbg !288
  br i1 %1279, label %1281, label %1280, !dbg !289

1280:                                             ; preds = %1277
  store i8* %1278, i8** %1121, align 8, !dbg !290
  br label %1281, !dbg !291

1281:                                             ; preds = %1280, %1277, %1161
  %1282 = alloca i32, align 4, !dbg !292
  %1283 = load i16, i16* %1140, align 2, !dbg !293
  %1284 = zext i16 %1283 to i32, !dbg !294
  store i32 %1284, i32* %1282, align 4, !dbg !295
  %1285 = alloca i64, align 8, !dbg !296
  %1286 = getelementptr i32, i32* %1129, i32 %1284, !dbg !297
  %1287 = load i32, i32* %1286, align 4, !dbg !298
  %1288 = zext i32 %1287 to i64, !dbg !299
  store i64 %1288, i64* %1285, align 4, !dbg !300
  %1289 = load i8*, i8** %1121, align 8, !dbg !301
  %1290 = load i32, i32* %1136, align 4, !dbg !302
  %1291 = alloca i8*, align 8, !dbg !303
  %1292 = getelementptr i8, i8* %1289, i32 %1290, !dbg !304
  store i8* %1292, i8** %1291, align 8, !dbg !305
  %1293 = load i32, i32* %1129, align 4, !dbg !306
  %1294 = getelementptr i8, i8* %1289, i32 %1293, !dbg !307
  br label %1295, !dbg !308

1295:                                             ; preds = %1302, %1281
  %1296 = load i32, i32* %1282, align 4, !dbg !309
  %1297 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %1124, i32 0, i32 23, i32 %1296, !dbg !310
  %1298 = load i8*, i8** %1291, align 8, !dbg !311
  %1299 = load i8, i8* %1298, align 1, !dbg !312
  %1300 = zext i8 %1299 to i32, !dbg !313
  store i32 %1300, i32* %1122, align 4, !dbg !314
  store i32 %1300, i32* %1297, align 4, !dbg !315
  %1301 = icmp sgt i8 %1299, -1, !dbg !316
  br i1 %1301, label %1325, label %1316, !dbg !317

1302:                                             ; preds = %1325, %1316
  %1303 = load i32, i32* %1282, align 4, !dbg !318
  %1304 = add i32 %1303, 1, !dbg !319
  store i32 %1304, i32* %1282, align 4, !dbg !320
  %1305 = load i64, i64* %1285, align 4, !dbg !321
  %1306 = and i64 4294967295, %1305, !dbg !322
  %1307 = trunc i64 %1306 to i32, !dbg !323
  %1308 = getelementptr i32, i32* %1129, i32 %1304, !dbg !324
  store i32 %1307, i32* %1308, align 4, !dbg !325
  %1309 = load i32, i32* %1282, align 4, !dbg !326
  %1310 = icmp sle i32 %1309, 4, !dbg !327
  %1311 = load i8*, i8** %1291, align 8, !dbg !328
  %1312 = ptrtoint i8* %1311 to i64, !dbg !329
  %1313 = ptrtoint i8* %1294 to i64, !dbg !330
  %1314 = icmp ult i64 %1312, %1313, !dbg !331
  %1315 = and i1 %1310, %1314, !dbg !332
  br i1 %1315, label %1295, label %1334, !dbg !333

1316:                                             ; preds = %1295
  %1317 = load i8*, i8** %1291, align 8, !dbg !334
  %1318 = call i8 @sqlite3GetVarint32(i8* %1317, i32* %1122), !dbg !335
  %1319 = getelementptr i8, i8* %1317, i8 %1318, !dbg !336
  store i8* %1319, i8** %1291, align 8, !dbg !337
  %1320 = load i32, i32* %1122, align 4, !dbg !338
  store i32 %1320, i32* %1297, align 4, !dbg !339
  %1321 = load i64, i64* %1285, align 4, !dbg !340
  %1322 = call i32 @sqlite3VdbeSerialTypeLen(i32 %1320), !dbg !341
  %1323 = zext i32 %1322 to i64, !dbg !342
  %1324 = add i64 %1321, %1323, !dbg !343
  store i64 %1324, i64* %1285, align 4, !dbg !344
  br label %1302, !dbg !345

1325:                                             ; preds = %1295
  %1326 = getelementptr i8, i8* %1298, i32 1, !dbg !346
  store i8* %1326, i8** %1291, align 8, !dbg !347
  %1327 = load i32, i32* %1122, align 4, !dbg !348
  %1328 = trunc i32 %1327 to i8, !dbg !349
  %1329 = getelementptr i8, i8* inttoptr (i64 4580428736 to i8*), i8 %1328, !dbg !350
  %1330 = load i8, i8* %1329, align 1, !dbg !351
  %1331 = zext i8 %1330 to i64, !dbg !352
  %1332 = load i64, i64* %1285, align 4, !dbg !353
  %1333 = add i64 %1332, %1331, !dbg !354
  store i64 %1333, i64* %1285, align 4, !dbg !355
  br label %1302, !dbg !356

1334:                                             ; preds = %1302
  %1335 = load i64, i64* %1285, align 4, !dbg !357
  %1336 = load i32, i32* %1137, align 4, !dbg !358
  %1337 = zext i32 %1336 to i64, !dbg !359
  %1338 = icmp uge i64 %1312, %1313, !dbg !360
  %1339 = icmp ugt i64 %1312, %1313, !dbg !361
  %1340 = icmp ne i64 %1335, %1337, !dbg !362
  %1341 = icmp ugt i64 %1335, %1337, !dbg !363
  %1342 = or i1 %1339, %1340, !dbg !364
  %1343 = and i1 %1338, %1342, !dbg !365
  %1344 = or i1 %1343, %1341, !dbg !366
  br i1 %1344, label %1345, label %1349, !dbg !367

1345:                                             ; preds = %1334
  %1346 = load i32, i32* %1129, align 4, !dbg !368
  %1347 = icmp eq i32 %1346, 0, !dbg !369
  br i1 %1347, label %1348, label %1349, !dbg !370

1348:                                             ; preds = %1345
  store i32 0, i32* %1282, align 4, !dbg !371
  store i8* %1294, i8** %1291, align 8, !dbg !372
  br label %1349, !dbg !373

1349:                                             ; preds = %1348, %1345, %1334
  %1350 = load i32, i32* %1282, align 4, !dbg !374
  %1351 = trunc i32 %1350 to i16, !dbg !375
  store i16 %1351, i16* %1140, align 2, !dbg !376
  %1352 = load i8*, i8** %1291, align 8, !dbg !377
  %1353 = ptrtoint i8* %1352 to i64, !dbg !378
  %1354 = load i8*, i8** %1121, align 8, !dbg !379
  %1355 = ptrtoint i8* %1354 to i64, !dbg !380
  %1356 = sub i64 %1353, %1355, !dbg !381
  %1357 = trunc i64 %1356 to i32, !dbg !382
  store i32 %1357, i32* %1136, align 4, !dbg !383
  br label %1359, !dbg !384

1358:                                             ; preds = %1273
  store i32 0, i32* %1122, align 4, !dbg !385
  br label %1359, !dbg !386

1359:                                             ; preds = %1358, %1349
  %1360 = load i16, i16* %1140, align 2, !dbg !387
  %1361 = icmp sle i16 %1360, 4, !dbg !388
  br i1 %1361, label %1362, label %1191, !dbg !389

1362:                                             ; preds = %1359
  %1363 = getelementptr %struct.VdbeOp, %struct.VdbeOp* %7, i32 8, !dbg !390
  %1364 = getelementptr %struct.VdbeOp, %struct.VdbeOp* %1363, i32 0, i32 1, !dbg !391
  %1365 = load i8, i8* %1364, align 1, !dbg !392
  %1366 = icmp eq i8 %1365, -11, !dbg !393
  br i1 %1366, label %1374, label %1367, !dbg !394

1367:                                             ; preds = %1362
  %1368 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %1125, i32 0, i32 1, !dbg !395
  %1369 = load i16, i16* %1368, align 2, !dbg !395
  %1370 = and i16 %1369, 9216, !dbg !395
  %1371 = icmp ne i16 %1370, 0, !dbg !395
  br i1 %1371, label %1372, label %1373, !dbg !395

1372:                                             ; preds = %1367
  call void @vdbeMemClearExternAndSetNull(%struct.sqlite3_value* %1125), !dbg !395
  br label %1378, !dbg !395

1373:                                             ; preds = %1367
  store i16 1, i16* %1368, align 2, !dbg !395
  br label %1378, !dbg !395

1374:                                             ; preds = %1362
  %1375 = getelementptr %struct.VdbeOp, %struct.VdbeOp* %1363, i32 0, i32 6, !dbg !396
  %1376 = bitcast %union.p4union* %1375 to %struct.sqlite3_value**, !dbg !397
  %1377 = load %struct.sqlite3_value*, %struct.sqlite3_value** %1376, align 8, !dbg !398
  call void @sqlite3VdbeMemShallowCopy(%struct.sqlite3_value* %1125, %struct.sqlite3_value* %1377, i32 2048), !dbg !399
  br label %1378, !dbg !400

1378:                                             ; preds = %1374, %1373, %1372, %1268, %1257, %1238, %1218, %1187, %1186
  call void @llvm.stackrestore(i8* %1115), !dbg !401
  br label %1379, !dbg !68

1379:                                             ; preds = %1378, %1
  %1380 = call i8* @llvm.stacksave(), !dbg !404
  %1381 = call i32 @sqlite3VdbeCheckFk(%struct.Vdbe* %0, i32 0), !dbg !407
  %1382 = call i32 @sqlite3VdbeCloseStatement(%struct.Vdbe* %0, i32 1), !dbg !408
  %1383 = getelementptr %struct.Vdbe, %struct.Vdbe* %0, i32 0, i32 9, !dbg !409
  %1384 = load i32, i32* %1383, align 4, !dbg !410
  %1385 = or i32 %1384, 1, !dbg !411
  store i32 %1385, i32* %1383, align 4, !dbg !412
  %1386 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %3, i32 1, !dbg !413
  %1387 = getelementptr %struct.Vdbe, %struct.Vdbe* %0, i32 0, i32 27, !dbg !414
  store %struct.sqlite3_value* %1386, %struct.sqlite3_value** %1387, align 8, !dbg !415
  %1388 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %1386, i32 1, !dbg !416
  %1389 = getelementptr %struct.sqlite3_value, %struct.sqlite3_value* %1388, i32 0, i32 1, !dbg !417
  %1390 = load i16, i16* %1389, align 2, !dbg !418
  %1391 = and i16 %1390, 4096, !dbg !419
  %1392 = icmp ne i16 %1391, 0, !dbg !420
  br i1 %1392, label %1393, label %1395, !dbg !421

1393:                                             ; preds = %1379
  %1394 = call i32 @sqlite3VdbeMemMakeWriteable(%struct.sqlite3_value* %1388), !dbg !422
  br label %1395, !dbg !423

1395:                                             ; preds = %1393, %1379
  call void @sqlite3VdbeMemNulTerminate(%struct.sqlite3_value* %1388), !dbg !424
  %1396 = load i16, i16* %1389, align 2, !dbg !418
  %1397 = and i16 %1396, 4096, !dbg !419
  %1398 = icmp ne i16 %1397, 0, !dbg !420
  br i1 %1398, label %1399, label %1401, !dbg !421

1399:                                             ; preds = %1395
  %1400 = call i32 @sqlite3VdbeMemMakeWriteable(%struct.sqlite3_value* %1388), !dbg !422
  br label %1401, !dbg !423

1401:                                             ; preds = %1399, %1395
  call void @sqlite3VdbeMemNulTerminate(%struct.sqlite3_value* %1388), !dbg !424
  %1402 = load i16, i16* %1389, align 2, !dbg !418
  %1403 = and i16 %1402, 4096, !dbg !419
  %1404 = icmp ne i16 %1403, 0, !dbg !420
  br i1 %1404, label %1405, label %1407, !dbg !421

1405:                                             ; preds = %1401
  %1406 = call i32 @sqlite3VdbeMemMakeWriteable(%struct.sqlite3_value* %1388), !dbg !422
  br label %1407, !dbg !423

1407:                                             ; preds = %1405, %1401
  call void @sqlite3VdbeMemNulTerminate(%struct.sqlite3_value* %1388), !dbg !424
  %1408 = load i16, i16* %1389, align 2, !dbg !418
  %1409 = and i16 %1408, 4096, !dbg !419
  %1410 = icmp ne i16 %1409, 0, !dbg !420
  br i1 %1410, label %1411, label %1413, !dbg !421

1411:                                             ; preds = %1407
  %1412 = call i32 @sqlite3VdbeMemMakeWriteable(%struct.sqlite3_value* %1388), !dbg !422
  br label %1413, !dbg !423

1413:                                             ; preds = %1411, %1407
  call void @sqlite3VdbeMemNulTerminate(%struct.sqlite3_value* %1388), !dbg !424
  %1414 = load i16, i16* %1389, align 2, !dbg !418
  %1415 = and i16 %1414, 4096, !dbg !419
  %1416 = icmp ne i16 %1415, 0, !dbg !420
  br i1 %1416, label %1417, label %1419, !dbg !421

1417:                                             ; preds = %1413
  %1418 = call i32 @sqlite3VdbeMemMakeWriteable(%struct.sqlite3_value* %1388), !dbg !422
  br label %1419, !dbg !423

1419:                                             ; preds = %1417, %1413
  call void @sqlite3VdbeMemNulTerminate(%struct.sqlite3_value* %1388), !dbg !424
  %1420 = load %struct.sqlite3*, %struct.sqlite3** %8, align 8, !dbg !425
  %1421 = getelementptr %struct.sqlite3, %struct.sqlite3* %1420, i32 0, i32 19, !dbg !426
  %1422 = load i8, i8* %1421, align 1, !dbg !427
  store i32 10, i32* %10, align 4, !dbg !428
  call void @llvm.stackrestore(i8* %1380), !dbg !429
  ret i32 100, !dbg !430

1423:                                             ; preds = %1
  %1424 = load %struct.VdbeCursor*, %struct.VdbeCursor** %5, align 8, !dbg !431
  %1425 = ptrtoint %struct.VdbeCursor* %1424 to i64, !dbg !434
  %1426 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %1424, i32 0, i32 12, i32 0, !dbg !435
  %1427 = load %struct.BtCursor*, %struct.BtCursor** %1426, align 8, !dbg !436
  %1428 = call i32 @sqlite3BtreeNext(%struct.BtCursor* %1427, i32 0), !dbg !437
  %1429 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %1424, i32 0, i32 2, !dbg !438
  %1430 = getelementptr %struct.VdbeCursor, %struct.VdbeCursor* %1424, i32 0, i32 9, !dbg !439
  store i32 0, i32* %1430, align 4, !dbg !440
  %1431 = icmp eq i32 %1428, 0, !dbg !441
  br i1 %1431, label %1432, label %1435, !dbg !442

1432:                                             ; preds = %1423
  store i8 0, i8* %1429, align 1, !dbg !443
  %1433 = load i32, i32* inttoptr (i64 140582574902188 to i32*), align 4, !dbg !444
  %1434 = add i32 %1433, 1, !dbg !445
  store i32 %1434, i32* inttoptr (i64 140582574902188 to i32*), align 4, !dbg !446
  br label %56, !dbg !447

1435:                                             ; preds = %1423
  store i8 1, i8* %1429, align 1, !dbg !448
  br label %1436, !dbg !449

1436:                                             ; preds = %1435, %50, %1
  %1437 = call i32 @sqlite3VdbeHalt(%struct.Vdbe* %0), !dbg !450
  ret i32 101, !dbg !453

1438:                                             ; preds = %12, %1
  %1439 = call i8* @llvm.stacksave(), !dbg !454
  %1440 = getelementptr %struct.sqlite3, %struct.sqlite3* %9, i32 0, i32 4, !dbg !457
  %1441 = load %struct.Db*, %struct.Db** %1440, align 8, !dbg !458
  %1442 = getelementptr %struct.Db, %struct.Db* %1441, i32 0, i32 1, !dbg !459
  %1443 = load %struct.Btree*, %struct.Btree** %1442, align 8, !dbg !460
  %1444 = ptrtoint %struct.Btree* %1443 to i64, !dbg !461
  %1445 = alloca i32, align 4, !dbg !462
  %1446 = alloca i32, align 4, !dbg !463
  %1447 = icmp ne i64 %1444, 0, !dbg !464
  br i1 %1447, label %1448, label %1450, !dbg !465

1448:                                             ; preds = %1438
  %1449 = call i32 @sqlite3BtreeBeginTrans(%struct.Btree* %1443, i32 0, i32* %1445), !dbg !466
  store i32 %1449, i32* %1446, align 4, !dbg !467
  br label %1450, !dbg !468

1450:                                             ; preds = %1448, %1438
  %1451 = load i32, i32* %1445, align 4, !dbg !469
  %1452 = icmp ne i32 %1451, 8, !dbg !470
  %1453 = getelementptr %struct.Db, %struct.Db* %1441, i32 0, i32 4, !dbg !471
  %1454 = load %struct.Schema*, %struct.Schema** %1453, align 8, !dbg !472
  %1455 = getelementptr %struct.Schema, %struct.Schema* %1454, i32 0, i32 1, !dbg !473
  %1456 = load i32, i32* %1455, align 4, !dbg !474
  %1457 = icmp ne i32 %1456, 0, !dbg !475
  %1458 = or i1 %1457, %1452, !dbg !476
  %1459 = load i32, i32* %1446, align 4, !dbg !477
  call void @llvm.stackrestore(i8* %1439), !dbg !478
  br label %16, !dbg !68
}

; Function Attrs: nounwind
declare i8* @llvm.stacksave() #4

; Function Attrs: nounwind
declare void @llvm.stackrestore(i8*) #4

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #5

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #5

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #5

; Function Attrs: argmemonly nofree nounwind readonly
declare i64 @strlen(i8* nocapture) local_unnamed_addr #6

; Function Attrs: nounwind
declare void @llvm.va_start(i8*) #4

; Function Attrs: nounwind
declare void @llvm.va_end(i8*) #4

; Function Attrs: nounwind ssp uwtable
declare void @sqlite3_log(i32, i8*, ...) #7

; Function Attrs: nounwind ssp uwtable
declare void @sqlite3_str_appendf(%struct.sqlite3_str*, i8*, ...) #7

; Function Attrs: noinline nounwind ssp uwtable
declare i32 @vdbeMemAddTerminator(%struct.sqlite3_value*) local_unnamed_addr #3

; Function Attrs: alwaysinline nofree norecurse nounwind ssp uwtable
define i32 @alsoAnInt(%struct.sqlite3_value* nocapture readonly %pRec, double %rValue, i64* nocapture %piValue) local_unnamed_addr #1 {
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
  store i64 %conv, i64* %piValue, align 8, !tbaa !18
  br label %cleanup

if.end:                                           ; preds = %lor.rhs.i
  %z = getelementptr inbounds %struct.sqlite3_value, %struct.sqlite3_value* %pRec, i64 0, i32 5
  %5 = load i8*, i8** %z, align 8, !tbaa !16
  %n = getelementptr inbounds %struct.sqlite3_value, %struct.sqlite3_value* %pRec, i64 0, i32 4
  %6 = load i32, i32* %n, align 4, !tbaa !17
  %enc = getelementptr inbounds %struct.sqlite3_value, %struct.sqlite3_value* %pRec, i64 0, i32 2
  %7 = load i8, i8* %enc, align 2, !tbaa !11
  %call1 = tail call fastcc i32 @sqlite3Atoi64(i8* %5, i64* %piValue, i32 %6, i8 zeroext %7)
  %cmp = icmp eq i32 %call1, 0
  %conv2 = zext i1 %cmp to i32
  br label %cleanup

cleanup:                                          ; preds = %if.end, %if.then
  %retval.0 = phi i32 [ 1, %if.then ], [ %conv2, %if.end ]
  ret i32 %retval.0
}

; Function Attrs: alwaysinline nofree norecurse nounwind ssp uwtable
define dso_local fastcc i32 @sqlite3Atoi64(i8* readonly %zNum, i64* nocapture %pNum, i32 %length, i8 zeroext %enc) unnamed_addr #1 {
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
  store i64 %sub85.sink, i64* %pNum, align 8, !tbaa !18
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
  store i64 %cond135233, i64* %pNum, align 8, !tbaa !18
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
  %arrayidx3.i = getelementptr inbounds [19 x i8], [19 x i8]* @.str.934, i64 0, i64 %indvars.iv.i
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
  store i64 %cond135, i64* %pNum, align 8, !tbaa !18
  %cmp136 = icmp eq i32 %cond129, 0
  %cond144 = select i1 %tobool81279, i32 %rc.1, i32 3
  %spec.select236 = select i1 %cmp136, i32 %cond144, i32 2
  ret i32 %spec.select236

cleanup:                                          ; preds = %cond.end, %if.else133.thread, %if.end120
  %23 = phi i32 [ 2, %if.else133.thread ], [ %rc.1, %cond.end ], [ %rc.1, %if.end120 ]
  ret i32 %23
}

; Function Attrs: argmemonly nounwind willreturn writeonly
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1 immarg) #8

; Function Attrs: noinline nounwind ssp uwtable
declare dso_local fastcc void @sqlite3PcacheRelease(%struct.PgHdr*) unnamed_addr #3

; Function Attrs: noinline nounwind ssp uwtable
declare dso_local fastcc i32 @sqlite3VdbeMemTranslate(%struct.sqlite3_value*, i8 zeroext) unnamed_addr #3

; Function Attrs: alwaysinline norecurse nounwind readnone ssp uwtable
define dso_local fastcc i64 @doubleToInt64(double %r) unnamed_addr #9 {
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

; Function Attrs: nounwind ssp uwtable
declare dso_local fastcc i32 @btreeMoveto(%struct.BtCursor*, i8*, i64, i32, i32*) unnamed_addr #7

; Function Attrs: nounwind ssp uwtable
declare dso_local fastcc i32 @getAndInitPage(%struct.BtShared*, i32, %struct.MemPage** nocapture, %struct.BtCursor*, i32) unnamed_addr #7

; Function Attrs: nounwind readnone speculatable willreturn
declare i32 @llvm.ctpop.i32(i32) #10

; Function Attrs: nounwind readnone speculatable willreturn
declare i32 @llvm.bswap.i32(i32) #10

; Function Attrs: nounwind readnone speculatable willreturn
declare i64 @llvm.ctpop.i64(i64) #10

; Function Attrs: cold noreturn nounwind
declare void @llvm.trap() #11

; Function Attrs: nounwind readnone speculatable willreturn
declare i64 @llvm.ctlz.i64(i64, i1 immarg) #10

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memmove.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i1 immarg) #5

attributes #0 = { norecurse nounwind nonlazybind uwtable willreturn "nonfree" }
attributes #1 = { alwaysinline nofree norecurse nounwind ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { alwaysinline nounwind ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { noinline nounwind ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind }
attributes #5 = { argmemonly nounwind willreturn }
attributes #6 = { argmemonly nofree nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #7 = { nounwind ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #8 = { argmemonly nounwind willreturn writeonly }
attributes #9 = { alwaysinline norecurse nounwind readnone ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #10 = { nounwind readnone speculatable willreturn }
attributes #11 = { cold noreturn nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4}
!llvm.ident = !{!5}

!0 = distinct !DICompileUnit(language: DW_LANG_C, file: !1, producer: "mlir", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug)
!1 = !DIFile(filename: "LLVMDialectModule", directory: "/")
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = !{i32 1, !"wchar_size", i32 4}
!4 = !{i32 7, !"PIC Level", i32 2}
!5 = !{!"clang version 11.0.0 (https://github.com/KowalskiThomas/LLVM 3f5d9ac5d6518add2e13767f9b5451061f2abfe3)"}
!6 = !{!7, !7, i64 0}
!7 = !{!"double", !8, i64 0}
!8 = !{!"omnipotent char", !9, i64 0}
!9 = !{!"Simple C/C++ TBAA"}
!10 = !{!8, !8, i64 0}
!11 = !{!12, !8, i64 10}
!12 = !{!"sqlite3_value", !8, i64 0, !13, i64 8, !8, i64 10, !8, i64 11, !14, i64 12, !15, i64 16, !15, i64 24, !14, i64 32, !14, i64 36, !15, i64 40, !15, i64 48}
!13 = !{!"short", !8, i64 0}
!14 = !{!"int", !8, i64 0}
!15 = !{!"any pointer", !8, i64 0}
!16 = !{!12, !15, i64 16}
!17 = !{!12, !14, i64 12}
!18 = !{!19, !19, i64 0}
!19 = !{!"long long", !8, i64 0}
!20 = !{!12, !13, i64 8}
!21 = distinct !DISubprogram(name: "jittedFunction", linkageName: "jittedFunction", scope: null, file: !22, line: 1585, type: !23, scopeLine: 1585, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !24)
!22 = !DIFile(filename: "../src/mlir/thomas/ModuleWriter.cpp", directory: "/Users/kowalski/dev/sqlite/release")
!23 = !DISubroutineType(types: !24)
!24 = !{}
!25 = !DILocation(line: 84, scope: !26)
!26 = !DILexicalBlockFile(scope: !21, file: !22, discriminator: 0)
!27 = !DILocation(line: 86, scope: !26)
!28 = !DILocation(line: 90, scope: !26)
!29 = !DILocation(line: 91, scope: !26)
!30 = !DILocation(line: 95, scope: !26)
!31 = !DILocation(line: 96, scope: !26)
!32 = !DILocation(line: 100, scope: !26)
!33 = !DILocation(line: 101, scope: !26)
!34 = !DILocation(line: 125, scope: !26)
!35 = !DILocation(line: 126, scope: !26)
!36 = !DILocation(line: 154, scope: !26)
!37 = !DILocation(line: 34, scope: !38)
!38 = !DILexicalBlockFile(scope: !21, file: !39, discriminator: 0)
!39 = !DIFile(filename: "../src/mlir/lib/Standalone/Lowering/InitLowering.cpp", directory: "/Users/kowalski/dev/sqlite/release")
!40 = !DILocation(line: 38, scope: !38)
!41 = !DILocation(line: 39, scope: !38)
!42 = !DILocation(line: 40, scope: !38)
!43 = !DILocation(line: 46, scope: !38)
!44 = !DILocation(line: 35, scope: !45)
!45 = !DILexicalBlockFile(scope: !21, file: !46, discriminator: 0)
!46 = !DIFile(filename: "../src/mlir/lib/Standalone/Lowering/OpenReadLowering.cpp", directory: "/Users/kowalski/dev/sqlite/release")
!47 = !DILocation(line: 36, scope: !45)
!48 = !DILocation(line: 37, scope: !45)
!49 = !DILocation(line: 41, scope: !45)
!50 = !DILocation(line: 43, scope: !45)
!51 = !DILocation(line: 92, scope: !45)
!52 = !DILocation(line: 101, scope: !45)
!53 = !DILocation(line: 102, scope: !45)
!54 = !DILocation(line: 105, scope: !45)
!55 = !DILocation(line: 107, scope: !45)
!56 = !DILocation(line: 109, scope: !45)
!57 = !DILocation(line: 110, scope: !45)
!58 = !DILocation(line: 113, scope: !45)
!59 = !DILocation(line: 115, scope: !45)
!60 = !DILocation(line: 118, scope: !45)
!61 = !DILocation(line: 124, scope: !45)
!62 = !DILocation(line: 127, scope: !45)
!63 = !DILocation(line: 134, scope: !45)
!64 = !DILocation(line: 136, scope: !45)
!65 = !DILocation(line: 139, scope: !45)
!66 = !DILocation(line: 140, scope: !45)
!67 = !DILocation(line: 143, scope: !45)
!68 = !DILocation(line: 1546, scope: !26)
!69 = !DILocation(line: 28, scope: !70)
!70 = !DILexicalBlockFile(scope: !21, file: !71, discriminator: 0)
!71 = !DIFile(filename: "../src/mlir/lib/Standalone/Lowering/RewindLowering.cpp", directory: "/Users/kowalski/dev/sqlite/release")
!72 = !DILocation(line: 39, scope: !70)
!73 = !DILocation(line: 43, scope: !70)
!74 = !DILocation(line: 45, scope: !70)
!75 = !DILocation(line: 46, scope: !70)
!76 = !DILocation(line: 49, scope: !70)
!77 = !DILocation(line: 56, scope: !70)
!78 = !DILocation(line: 58, scope: !70)
!79 = !DILocation(line: 73, scope: !70)
!80 = !DILocation(line: 74, scope: !70)
!81 = !DILocation(line: 77, scope: !70)
!82 = !DILocation(line: 85, scope: !70)
!83 = !DILocation(line: 87, scope: !70)
!84 = !DILocation(line: 89, scope: !70)
!85 = !DILocation(line: 100, scope: !70)
!86 = !DILocation(line: 107, scope: !70)
!87 = !DILocation(line: 111, scope: !70)
!88 = !DILocation(line: 115, scope: !70)
!89 = !DILocation(line: 121, scope: !70)
!90 = !DILocation(line: 125, scope: !70)
!91 = !DILocation(line: 129, scope: !70)
!92 = !DILocation(line: 133, scope: !70)
!93 = !DILocation(line: 136, scope: !70)
!94 = !DILocation(line: 142, scope: !70)
!95 = !DILocation(line: 148, scope: !70)
!96 = !DILocation(line: 149, scope: !70)
!97 = !DILocation(line: 151, scope: !70)
!98 = !DILocation(line: 155, scope: !70)
!99 = !DILocation(line: 157, scope: !70)
!100 = !DILocation(line: 159, scope: !70)
!101 = !DILocation(line: 162, scope: !70)
!102 = !DILocation(line: 47, scope: !103)
!103 = !DILexicalBlockFile(scope: !21, file: !104, discriminator: 0)
!104 = !DIFile(filename: "../src/mlir/lib/Standalone/Lowering/ColumnLowering.cpp", directory: "/Users/kowalski/dev/sqlite/release")
!105 = !DILocation(line: 59, scope: !103)
!106 = !DILocation(line: 60, scope: !103)
!107 = !DILocation(line: 77, scope: !103)
!108 = !DILocation(line: 78, scope: !103)
!109 = !DILocation(line: 89, scope: !103)
!110 = !DILocation(line: 90, scope: !103)
!111 = !DILocation(line: 91, scope: !103)
!112 = !DILocation(line: 102, scope: !103)
!113 = !DILocation(line: 105, scope: !103)
!114 = !DILocation(line: 110, scope: !103)
!115 = !DILocation(line: 120, scope: !103)
!116 = !DILocation(line: 137, scope: !103)
!117 = !DILocation(line: 143, scope: !103)
!118 = !DILocation(line: 147, scope: !103)
!119 = !DILocation(line: 159, scope: !103)
!120 = !DILocation(line: 164, scope: !103)
!121 = !DILocation(line: 170, scope: !103)
!122 = !DILocation(line: 176, scope: !103)
!123 = !DILocation(line: 185, scope: !103)
!124 = !DILocation(line: 191, scope: !103)
!125 = !DILocation(line: 196, scope: !103)
!126 = !DILocation(line: 198, scope: !103)
!127 = !DILocation(line: 216, scope: !103)
!128 = !DILocation(line: 223, scope: !103)
!129 = !DILocation(line: 231, scope: !103)
!130 = !DILocation(line: 239, scope: !103)
!131 = !DILocation(line: 247, scope: !103)
!132 = !DILocation(line: 265, scope: !103)
!133 = !DILocation(line: 270, scope: !103)
!134 = !DILocation(line: 274, scope: !103)
!135 = !DILocation(line: 278, scope: !103)
!136 = !DILocation(line: 281, scope: !103)
!137 = !DILocation(line: 285, scope: !103)
!138 = !DILocation(line: 320, scope: !103)
!139 = !DILocation(line: 515, scope: !103)
!140 = !DILocation(line: 516, scope: !103)
!141 = !DILocation(line: 521, scope: !103)
!142 = !DILocation(line: 23, scope: !143)
!143 = !DILexicalBlockFile(scope: !21, file: !144, discriminator: 0)
!144 = !DIFile(filename: "../src/mlir/lib/Standalone/Lowering/Operators/GetVarint32.cpp", directory: "/Users/kowalski/dev/sqlite/release")
!145 = !DILocation(line: 36, scope: !143)
!146 = !DILocation(line: 39, scope: !143)
!147 = !DILocation(line: 47, scope: !143)
!148 = !DILocation(line: 50, scope: !143)
!149 = !DILocation(line: 53, scope: !143)
!150 = !DILocation(line: 55, scope: !143)
!151 = !DILocation(line: 64, scope: !143)
!152 = !DILocation(line: 71, scope: !143)
!153 = !DILocation(line: 72, scope: !143)
!154 = !DILocation(line: 73, scope: !143)
!155 = !DILocation(line: 526, scope: !103)
!156 = !DILocation(line: 534, scope: !103)
!157 = !DILocation(line: 535, scope: !103)
!158 = !DILocation(line: 538, scope: !103)
!159 = !DILocation(line: 541, scope: !103)
!160 = !DILocation(line: 564, scope: !103)
!161 = !DILocation(line: 567, scope: !103)
!162 = !DILocation(line: 550, scope: !103)
!163 = !DILocation(line: 552, scope: !103)
!164 = !DILocation(line: 573, scope: !103)
!165 = !DILocation(line: 442, scope: !103)
!166 = !DILocation(line: 450, scope: !103)
!167 = !DILocation(line: 486, scope: !103)
!168 = !DILocation(line: 491, scope: !103)
!169 = !DILocation(line: 495, scope: !103)
!170 = !DILocation(line: 501, scope: !103)
!171 = !DILocation(line: 508, scope: !103)
!172 = !DILocation(line: 344, scope: !103)
!173 = !DILocation(line: 349, scope: !103)
!174 = !DILocation(line: 360, scope: !103)
!175 = !DILocation(line: 366, scope: !103)
!176 = !DILocation(line: 369, scope: !103)
!177 = !DILocation(line: 375, scope: !103)
!178 = !DILocation(line: 379, scope: !103)
!179 = !DILocation(line: 381, scope: !103)
!180 = !DILocation(line: 389, scope: !103)
!181 = !DILocation(line: 394, scope: !103)
!182 = !DILocation(line: 395, scope: !103)
!183 = !DILocation(line: 396, scope: !103)
!184 = !DILocation(line: 401, scope: !103)
!185 = !DILocation(line: 406, scope: !103)
!186 = !DILocation(line: 407, scope: !103)
!187 = !DILocation(line: 422, scope: !103)
!188 = !DILocation(line: 428, scope: !103)
!189 = !DILocation(line: 580, scope: !103)
!190 = !DILocation(line: 582, scope: !103)
!191 = !DILocation(line: 592, scope: !103)
!192 = !DILocation(line: 1075, scope: !103)
!193 = !DILocation(line: 1079, scope: !103)
!194 = !DILocation(line: 1080, scope: !103)
!195 = !DILocation(line: 1082, scope: !103)
!196 = !DILocation(line: 1095, scope: !103)
!197 = !DILocation(line: 1101, scope: !103)
!198 = !DILocation(line: 1110, scope: !103)
!199 = !DILocation(line: 1115, scope: !103)
!200 = !DILocation(line: 1121, scope: !103)
!201 = !DILocation(line: 1133, scope: !103)
!202 = !DILocation(line: 1135, scope: !103)
!203 = !DILocation(line: 1137, scope: !103)
!204 = !DILocation(line: 1139, scope: !103)
!205 = !DILocation(line: 1141, scope: !103)
!206 = !DILocation(line: 1147, scope: !103)
!207 = !DILocation(line: 1148, scope: !103)
!208 = !DILocation(line: 1150, scope: !103)
!209 = !DILocation(line: 1151, scope: !103)
!210 = !DILocation(line: 1152, scope: !103)
!211 = !DILocation(line: 1153, scope: !103)
!212 = !DILocation(line: 1154, scope: !103)
!213 = !DILocation(line: 1161, scope: !103)
!214 = !DILocation(line: 1162, scope: !103)
!215 = !DILocation(line: 1163, scope: !103)
!216 = !DILocation(line: 1168, scope: !103)
!217 = !DILocation(line: 1172, scope: !103)
!218 = !DILocation(line: 1178, scope: !103)
!219 = !DILocation(line: 1179, scope: !103)
!220 = !DILocation(line: 1180, scope: !103)
!221 = !DILocation(line: 1181, scope: !103)
!222 = !DILocation(line: 1183, scope: !103)
!223 = !DILocation(line: 1186, scope: !103)
!224 = !DILocation(line: 1187, scope: !103)
!225 = !DILocation(line: 1190, scope: !103)
!226 = !DILocation(line: 1195, scope: !103)
!227 = !DILocation(line: 1197, scope: !103)
!228 = !DILocation(line: 1201, scope: !103)
!229 = !DILocation(line: 1210, scope: !103)
!230 = !DILocation(line: 1220, scope: !103)
!231 = !DILocation(line: 1226, scope: !103)
!232 = !DILocation(line: 1228, scope: !103)
!233 = !DILocation(line: 1230, scope: !103)
!234 = !DILocation(line: 1232, scope: !103)
!235 = !DILocation(line: 1237, scope: !103)
!236 = !DILocation(line: 1239, scope: !103)
!237 = !DILocation(line: 1248, scope: !103)
!238 = !DILocation(line: 1255, scope: !103)
!239 = !DILocation(line: 1260, scope: !103)
!240 = !DILocation(line: 1263, scope: !103)
!241 = !DILocation(line: 1265, scope: !103)
!242 = !DILocation(line: 1272, scope: !103)
!243 = !DILocation(line: 1273, scope: !103)
!244 = !DILocation(line: 1274, scope: !103)
!245 = !DILocation(line: 1275, scope: !103)
!246 = !DILocation(line: 1280, scope: !103)
!247 = !DILocation(line: 1281, scope: !103)
!248 = !DILocation(line: 1283, scope: !103)
!249 = !DILocation(line: 1284, scope: !103)
!250 = !DILocation(line: 1285, scope: !103)
!251 = !DILocation(line: 1288, scope: !103)
!252 = !DILocation(line: 1290, scope: !103)
!253 = !DILocation(line: 1292, scope: !103)
!254 = !DILocation(line: 1294, scope: !103)
!255 = !DILocation(line: 1296, scope: !103)
!256 = !DILocation(line: 1306, scope: !103)
!257 = !DILocation(line: 1310, scope: !103)
!258 = !DILocation(line: 1319, scope: !103)
!259 = !DILocation(line: 1320, scope: !103)
!260 = !DILocation(line: 1321, scope: !103)
!261 = !DILocation(line: 1323, scope: !103)
!262 = !DILocation(line: 1325, scope: !103)
!263 = !DILocation(line: 1335, scope: !103)
!264 = !DILocation(line: 1338, scope: !103)
!265 = !DILocation(line: 1347, scope: !103)
!266 = !DILocation(line: 1366, scope: !103)
!267 = !DILocation(line: 1374, scope: !103)
!268 = !DILocation(line: 1380, scope: !103)
!269 = !DILocation(line: 1383, scope: !103)
!270 = !DILocation(line: 1394, scope: !103)
!271 = !DILocation(line: 1399, scope: !103)
!272 = !DILocation(line: 1403, scope: !103)
!273 = !DILocation(line: 1413, scope: !103)
!274 = !DILocation(line: 1415, scope: !103)
!275 = !DILocation(line: 1416, scope: !103)
!276 = !DILocation(line: 1418, scope: !103)
!277 = !DILocation(line: 1354, scope: !103)
!278 = !DILocation(line: 1358, scope: !103)
!279 = !DILocation(line: 1055, scope: !103)
!280 = !DILocation(line: 1061, scope: !103)
!281 = !DILocation(line: 1063, scope: !103)
!282 = !DILocation(line: 1065, scope: !103)
!283 = !DILocation(line: 601, scope: !103)
!284 = !DILocation(line: 602, scope: !103)
!285 = !DILocation(line: 603, scope: !103)
!286 = !DILocation(line: 612, scope: !103)
!287 = !DILocation(line: 622, scope: !103)
!288 = !DILocation(line: 624, scope: !103)
!289 = !DILocation(line: 631, scope: !103)
!290 = !DILocation(line: 645, scope: !103)
!291 = !DILocation(line: 646, scope: !103)
!292 = !DILocation(line: 661, scope: !103)
!293 = !DILocation(line: 662, scope: !103)
!294 = !DILocation(line: 663, scope: !103)
!295 = !DILocation(line: 664, scope: !103)
!296 = !DILocation(line: 666, scope: !103)
!297 = !DILocation(line: 668, scope: !103)
!298 = !DILocation(line: 671, scope: !103)
!299 = !DILocation(line: 672, scope: !103)
!300 = !DILocation(line: 673, scope: !103)
!301 = !DILocation(line: 675, scope: !103)
!302 = !DILocation(line: 676, scope: !103)
!303 = !DILocation(line: 679, scope: !103)
!304 = !DILocation(line: 681, scope: !103)
!305 = !DILocation(line: 683, scope: !103)
!306 = !DILocation(line: 685, scope: !103)
!307 = !DILocation(line: 687, scope: !103)
!308 = !DILocation(line: 701, scope: !103)
!309 = !DILocation(line: 712, scope: !103)
!310 = !DILocation(line: 714, scope: !103)
!311 = !DILocation(line: 720, scope: !103)
!312 = !DILocation(line: 721, scope: !103)
!313 = !DILocation(line: 722, scope: !103)
!314 = !DILocation(line: 725, scope: !103)
!315 = !DILocation(line: 727, scope: !103)
!316 = !DILocation(line: 730, scope: !103)
!317 = !DILocation(line: 734, scope: !103)
!318 = !DILocation(line: 804, scope: !103)
!319 = !DILocation(line: 806, scope: !103)
!320 = !DILocation(line: 808, scope: !103)
!321 = !DILocation(line: 812, scope: !103)
!322 = !DILocation(line: 813, scope: !103)
!323 = !DILocation(line: 814, scope: !103)
!324 = !DILocation(line: 817, scope: !103)
!325 = !DILocation(line: 822, scope: !103)
!326 = !DILocation(line: 832, scope: !103)
!327 = !DILocation(line: 835, scope: !103)
!328 = !DILocation(line: 839, scope: !103)
!329 = !DILocation(line: 840, scope: !103)
!330 = !DILocation(line: 841, scope: !103)
!331 = !DILocation(line: 843, scope: !103)
!332 = !DILocation(line: 848, scope: !103)
!333 = !DILocation(line: 851, scope: !103)
!334 = !DILocation(line: 768, scope: !103)
!335 = !DILocation(line: 771, scope: !103)
!336 = !DILocation(line: 778, scope: !103)
!337 = !DILocation(line: 784, scope: !103)
!338 = !DILocation(line: 787, scope: !103)
!339 = !DILocation(line: 788, scope: !103)
!340 = !DILocation(line: 791, scope: !103)
!341 = !DILocation(line: 793, scope: !103)
!342 = !DILocation(line: 796, scope: !103)
!343 = !DILocation(line: 797, scope: !103)
!344 = !DILocation(line: 798, scope: !103)
!345 = !DILocation(line: 800, scope: !103)
!346 = !DILocation(line: 740, scope: !103)
!347 = !DILocation(line: 743, scope: !103)
!348 = !DILocation(line: 747, scope: !103)
!349 = !DILocation(line: 748, scope: !103)
!350 = !DILocation(line: 750, scope: !103)
!351 = !DILocation(line: 751, scope: !103)
!352 = !DILocation(line: 752, scope: !103)
!353 = !DILocation(line: 755, scope: !103)
!354 = !DILocation(line: 757, scope: !103)
!355 = !DILocation(line: 759, scope: !103)
!356 = !DILocation(line: 761, scope: !103)
!357 = !DILocation(line: 861, scope: !103)
!358 = !DILocation(line: 862, scope: !103)
!359 = !DILocation(line: 863, scope: !103)
!360 = !DILocation(line: 871, scope: !103)
!361 = !DILocation(line: 875, scope: !103)
!362 = !DILocation(line: 879, scope: !103)
!363 = !DILocation(line: 883, scope: !103)
!364 = !DILocation(line: 887, scope: !103)
!365 = !DILocation(line: 888, scope: !103)
!366 = !DILocation(line: 889, scope: !103)
!367 = !DILocation(line: 895, scope: !103)
!368 = !DILocation(line: 905, scope: !103)
!369 = !DILocation(line: 907, scope: !103)
!370 = !DILocation(line: 910, scope: !103)
!371 = !DILocation(line: 915, scope: !103)
!372 = !DILocation(line: 916, scope: !103)
!373 = !DILocation(line: 918, scope: !103)
!374 = !DILocation(line: 940, scope: !103)
!375 = !DILocation(line: 941, scope: !103)
!376 = !DILocation(line: 942, scope: !103)
!377 = !DILocation(line: 945, scope: !103)
!378 = !DILocation(line: 946, scope: !103)
!379 = !DILocation(line: 947, scope: !103)
!380 = !DILocation(line: 948, scope: !103)
!381 = !DILocation(line: 949, scope: !103)
!382 = !DILocation(line: 950, scope: !103)
!383 = !DILocation(line: 951, scope: !103)
!384 = !DILocation(line: 964, scope: !103)
!385 = !DILocation(line: 979, scope: !103)
!386 = !DILocation(line: 981, scope: !103)
!387 = !DILocation(line: 990, scope: !103)
!388 = !DILocation(line: 992, scope: !103)
!389 = !DILocation(line: 993, scope: !103)
!390 = !DILocation(line: 997, scope: !103)
!391 = !DILocation(line: 999, scope: !103)
!392 = !DILocation(line: 1003, scope: !103)
!393 = !DILocation(line: 1005, scope: !103)
!394 = !DILocation(line: 1014, scope: !103)
!395 = !DILocation(line: 1036, scope: !103)
!396 = !DILocation(line: 1020, scope: !103)
!397 = !DILocation(line: 1021, scope: !103)
!398 = !DILocation(line: 1022, scope: !103)
!399 = !DILocation(line: 1023, scope: !103)
!400 = !DILocation(line: 1030, scope: !103)
!401 = !DILocation(line: 1431, scope: !103)
!402 = !DILocation(line: 1149, scope: !103)
!403 = !DILocation(line: 1379, scope: !103)
!404 = !DILocation(line: 23, scope: !405)
!405 = !DILexicalBlockFile(scope: !21, file: !406, discriminator: 0)
!406 = !DIFile(filename: "../src/mlir/lib/Standalone/Lowering/ResultRowLowering.cpp", directory: "/Users/kowalski/dev/sqlite/release")
!407 = !DILocation(line: 28, scope: !405)
!408 = !DILocation(line: 52, scope: !405)
!409 = !DILocation(line: 56, scope: !405)
!410 = !DILocation(line: 61, scope: !405)
!411 = !DILocation(line: 63, scope: !405)
!412 = !DILocation(line: 64, scope: !405)
!413 = !DILocation(line: 70, scope: !405)
!414 = !DILocation(line: 74, scope: !405)
!415 = !DILocation(line: 75, scope: !405)
!416 = !DILocation(line: 77, scope: !405)
!417 = !DILocation(line: 79, scope: !405)
!418 = !DILocation(line: 80, scope: !405)
!419 = !DILocation(line: 81, scope: !405)
!420 = !DILocation(line: 82, scope: !405)
!421 = !DILocation(line: 88, scope: !405)
!422 = !DILocation(line: 92, scope: !405)
!423 = !DILocation(line: 93, scope: !405)
!424 = !DILocation(line: 99, scope: !405)
!425 = !DILocation(line: 108, scope: !405)
!426 = !DILocation(line: 109, scope: !405)
!427 = !DILocation(line: 110, scope: !405)
!428 = !DILocation(line: 118, scope: !405)
!429 = !DILocation(line: 124, scope: !405)
!430 = !DILocation(line: 125, scope: !405)
!431 = !DILocation(line: 43, scope: !432)
!432 = !DILexicalBlockFile(scope: !21, file: !433, discriminator: 0)
!433 = !DIFile(filename: "../src/mlir/lib/Standalone/Lowering/NextLowering.cpp", directory: "/Users/kowalski/dev/sqlite/release")
!434 = !DILocation(line: 46, scope: !432)
!435 = !DILocation(line: 65, scope: !432)
!436 = !DILocation(line: 71, scope: !432)
!437 = !DILocation(line: 75, scope: !432)
!438 = !DILocation(line: 80, scope: !432)
!439 = !DILocation(line: 83, scope: !432)
!440 = !DILocation(line: 84, scope: !432)
!441 = !DILocation(line: 87, scope: !432)
!442 = !DILocation(line: 93, scope: !432)
!443 = !DILocation(line: 99, scope: !432)
!444 = !DILocation(line: 105, scope: !432)
!445 = !DILocation(line: 106, scope: !432)
!446 = !DILocation(line: 107, scope: !432)
!447 = !DILocation(line: 109, scope: !432)
!448 = !DILocation(line: 122, scope: !432)
!449 = !DILocation(line: 124, scope: !432)
!450 = !DILocation(line: 27, scope: !451)
!451 = !DILexicalBlockFile(scope: !21, file: !452, discriminator: 0)
!452 = !DIFile(filename: "../src/mlir/lib/Standalone/Lowering/HaltLowering.cpp", directory: "/Users/kowalski/dev/sqlite/release")
!453 = !DILocation(line: 30, scope: !451)
!454 = !DILocation(line: 25, scope: !455)
!455 = !DILexicalBlockFile(scope: !21, file: !456, discriminator: 0)
!456 = !DIFile(filename: "../src/mlir/lib/Standalone/Lowering/TransactionLowering.cpp", directory: "/Users/kowalski/dev/sqlite/release")
!457 = !DILocation(line: 48, scope: !455)
!458 = !DILocation(line: 52, scope: !455)
!459 = !DILocation(line: 53, scope: !455)
!460 = !DILocation(line: 54, scope: !455)
!461 = !DILocation(line: 55, scope: !455)
!462 = !DILocation(line: 57, scope: !455)
!463 = !DILocation(line: 58, scope: !455)
!464 = !DILocation(line: 60, scope: !455)
!465 = !DILocation(line: 65, scope: !455)
!466 = !DILocation(line: 69, scope: !455)
!467 = !DILocation(line: 71, scope: !455)
!468 = !DILocation(line: 143, scope: !455)
!469 = !DILocation(line: 152, scope: !455)
!470 = !DILocation(line: 153, scope: !455)
!471 = !DILocation(line: 156, scope: !455)
!472 = !DILocation(line: 157, scope: !455)
!473 = !DILocation(line: 158, scope: !455)
!474 = !DILocation(line: 159, scope: !455)
!475 = !DILocation(line: 161, scope: !455)
!476 = !DILocation(line: 162, scope: !455)
!477 = !DILocation(line: 181, scope: !455)
!478 = !DILocation(line: 189, scope: !455)
