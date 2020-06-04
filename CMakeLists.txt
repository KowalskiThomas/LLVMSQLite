project(sqlite)
cmake_minimum_required(VERSION 3.15)

# Sanitation measures
# set(sanitize "")
# set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fsanitize=${sanitize}  -fno-omit-frame-pointer -fsanitize-memory-track-origins -g")
# set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fsanitize=${sanitize}  -fno-omit-frame-pointer -fsanitize-memory-track-origins -g")

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package (Threads)

include_directories(${PROJECT_SOURCE_DIR})
include_directories(${PROJECT_SOURCE_DIR}/src)

add_subdirectory(${PROJECT_SOURCE_DIR}/src/mlir)

# Custom file serving as a bridge between SQLite and the JIT
add_library(vdbe_exec_llvm ${PROJECT_SOURCE_DIR}/src/vdbe_exec.cpp)
target_compile_definitions(vdbe_exec_llvm PUBLIC ENABLE_JIT=1)

add_library(vdbe_exec_default ${PROJECT_SOURCE_DIR}/src/vdbe_exec.cpp)
target_compile_definitions(vdbe_exec_default PUBLIC ENABLE_JIT=0)

add_library(sqlite
        ${PROJECT_SOURCE_DIR}/src/alter.c
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
        ${PROJECT_SOURCE_DIR}/src/whereexpr.c
        ${PROJECT_SOURCE_DIR}/src/whereInt.h
        ${PROJECT_SOURCE_DIR}/src/window.c
        ${PROJECT_SOURCE_DIR}/opcodes.c
        ${PROJECT_SOURCE_DIR}/parse.c
)

add_executable(shell_jit shell.c)
target_link_libraries(shell_jit sqlite_llvm)
target_link_libraries(shell_jit vdbe_exec_llvm)
target_link_libraries(shell_jit sqlite)
target_link_libraries(shell_jit ${CMAKE_THREAD_LIBS_INIT})

add_executable(shell_default shell.c)
target_link_libraries(shell_default sqlite)
target_link_libraries(shell_default vdbe_exec_default)
target_link_libraries(shell_default ${CMAKE_THREAD_LIBS_INIT})
