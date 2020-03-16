project(sqlite)
cmake_minimum_required(VERSION 3.15)

find_package(LLVM REQUIRED CONFIG)
add_definitions(${LLVM_DEFINITIONS})

include_directories(${LLVM_INCLUDE_DIRS})
include_directories(${PROJECT_SOURCE_DIR})
include_directories(${PROJECT_SOURCE_DIR}/src)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

message("thomas")
message(${LLVM_INCLUDE_DIRS})

add_library(sqlite
        ${PROJECT_SOURCE_DIR}/src/alter.c 
        ${PROJECT_SOURCE_DIR}/src/thomas.cpp
        ${PROJECT_SOURCE_DIR}/src/analyze.c
        ${PROJECT_SOURCE_DIR}/src/attach.c
        ${PROJECT_SOURCE_DIR}/src/auth.c
        ${PROJECT_SOURCE_DIR}/src/backup.c
        ${PROJECT_SOURCE_DIR}/src/bitvec.c
        ${PROJECT_SOURCE_DIR}/src/btmutex.c
        ${PROJECT_SOURCE_DIR}/src/btree.c
        ${PROJECT_SOURCE_DIR}/src/btree.h
        ${PROJECT_SOURCE_DIR}/src/btreeInt.h
        ${PROJECT_SOURCE_DIR}/src/build.c
        ${PROJECT_SOURCE_DIR}/src/callback.c
        ${PROJECT_SOURCE_DIR}/src/complete.c
        ${PROJECT_SOURCE_DIR}/src/ctime.c
        ${PROJECT_SOURCE_DIR}/src/date.c
        ${PROJECT_SOURCE_DIR}/src/dbpage.c
        ${PROJECT_SOURCE_DIR}/src/dbstat.c
        ${PROJECT_SOURCE_DIR}/src/delete.c
        ${PROJECT_SOURCE_DIR}/src/expr.c
        ${PROJECT_SOURCE_DIR}/src/fault.c
        ${PROJECT_SOURCE_DIR}/src/fkey.c
        ${PROJECT_SOURCE_DIR}/src/func.c
        ${PROJECT_SOURCE_DIR}/src/global.c
        ${PROJECT_SOURCE_DIR}/src/hash.c
        ${PROJECT_SOURCE_DIR}/src/hash.h
        ${PROJECT_SOURCE_DIR}/src/hwtime.h
        ${PROJECT_SOURCE_DIR}/src/insert.c
        ${PROJECT_SOURCE_DIR}/src/legacy.c
        ${PROJECT_SOURCE_DIR}/src/loadext.c
        ${PROJECT_SOURCE_DIR}/src/main.c
        ${PROJECT_SOURCE_DIR}/src/malloc.c
        ${PROJECT_SOURCE_DIR}/src/mem0.c
        ${PROJECT_SOURCE_DIR}/src/mem1.c
        ${PROJECT_SOURCE_DIR}/src/mem2.c
        ${PROJECT_SOURCE_DIR}/src/mem3.c
        ${PROJECT_SOURCE_DIR}/src/mem5.c
        ${PROJECT_SOURCE_DIR}/src/memdb.c
        ${PROJECT_SOURCE_DIR}/src/memjournal.c
        ${PROJECT_SOURCE_DIR}/src/msvc.h
        ${PROJECT_SOURCE_DIR}/src/mutex.c
        ${PROJECT_SOURCE_DIR}/src/mutex.h
        ${PROJECT_SOURCE_DIR}/src/mutex_noop.c
        ${PROJECT_SOURCE_DIR}/src/mutex_unix.c
        ${PROJECT_SOURCE_DIR}/src/mutex_w32.c
        ${PROJECT_SOURCE_DIR}/src/notify.c
        ${PROJECT_SOURCE_DIR}/src/os.c
        ${PROJECT_SOURCE_DIR}/src/os.h
        ${PROJECT_SOURCE_DIR}/src/os_common.h
        ${PROJECT_SOURCE_DIR}/src/os_setup.h
        ${PROJECT_SOURCE_DIR}/src/os_unix.c
        ${PROJECT_SOURCE_DIR}/src/os_win.c
        ${PROJECT_SOURCE_DIR}/src/os_win.h
        ${PROJECT_SOURCE_DIR}/src/pager.c
        ${PROJECT_SOURCE_DIR}/src/pager.h
        ${PROJECT_SOURCE_DIR}/src/parse.y
        ${PROJECT_SOURCE_DIR}/src/pcache.c
        ${PROJECT_SOURCE_DIR}/src/pcache.h
        ${PROJECT_SOURCE_DIR}/src/pcache1.c
        ${PROJECT_SOURCE_DIR}/src/pragma.c
        ${PROJECT_SOURCE_DIR}/src/pragma.h
        ${PROJECT_SOURCE_DIR}/src/prepare.c
        ${PROJECT_SOURCE_DIR}/src/printf.c
        ${PROJECT_SOURCE_DIR}/src/random.c
        ${PROJECT_SOURCE_DIR}/src/resolve.c
        ${PROJECT_SOURCE_DIR}/src/rowset.c
        ${PROJECT_SOURCE_DIR}/src/select.c
        ${PROJECT_SOURCE_DIR}/src/status.c
        ${PROJECT_SOURCE_DIR}/src/shell.c.in
        ${PROJECT_SOURCE_DIR}/src/sqlite.h.in
        ${PROJECT_SOURCE_DIR}/src/sqlite3ext.h
        ${PROJECT_SOURCE_DIR}/src/sqliteInt.h
        ${PROJECT_SOURCE_DIR}/src/sqliteLimit.h
        ${PROJECT_SOURCE_DIR}/src/table.c
        ${PROJECT_SOURCE_DIR}/src/tclsqlite.c
        ${PROJECT_SOURCE_DIR}/src/threads.c
        ${PROJECT_SOURCE_DIR}/src/tokenize.c
        ${PROJECT_SOURCE_DIR}/src/treeview.c
        ${PROJECT_SOURCE_DIR}/src/trigger.c
        ${PROJECT_SOURCE_DIR}/src/utf.c
        ${PROJECT_SOURCE_DIR}/src/update.c
        ${PROJECT_SOURCE_DIR}/src/upsert.c
        ${PROJECT_SOURCE_DIR}/src/util.c
        ${PROJECT_SOURCE_DIR}/src/vacuum.c
        ${PROJECT_SOURCE_DIR}/src/vdbe.c
        ${PROJECT_SOURCE_DIR}/src/vdbe.h
        ${PROJECT_SOURCE_DIR}/src/vdbeapi.c
        ${PROJECT_SOURCE_DIR}/src/vdbeaux.c
        ${PROJECT_SOURCE_DIR}/src/vdbeblob.c
        ${PROJECT_SOURCE_DIR}/src/vdbemem.c
        ${PROJECT_SOURCE_DIR}/src/vdbesort.c
        ${PROJECT_SOURCE_DIR}/src/vdbetrace.c
        ${PROJECT_SOURCE_DIR}/src/vdbeInt.h
        ${PROJECT_SOURCE_DIR}/src/vtab.c
        ${PROJECT_SOURCE_DIR}/src/vxworks.h
        ${PROJECT_SOURCE_DIR}/src/wal.c
        ${PROJECT_SOURCE_DIR}/src/wal.h
        ${PROJECT_SOURCE_DIR}/src/walker.c
        ${PROJECT_SOURCE_DIR}/src/where.c
        ${PROJECT_SOURCE_DIR}/src/wherecode.c
        ${PROJECT_SOURCE_DIR}/src/thomas.cpp
        ${PROJECT_SOURCE_DIR}/src/whereexpr.c
        ${PROJECT_SOURCE_DIR}/src/whereInt.h
        ${PROJECT_SOURCE_DIR}/src/window.c
        ${PROJECT_SOURCE_DIR}/opcodes.c
        ${PROJECT_SOURCE_DIR}/parse.c
)

add_executable(shell shell.c)
# target_link_libraries(shell stdc++)
target_link_libraries(shell sqlite)