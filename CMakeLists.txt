project(sqlite)
cmake_minimum_required(VERSION 3.15)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# I don't know what to do with that:
# set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=gnu++17 -stdlib=libc++")

option(XRAY "Enable support for LLVM X-Ray")
option(VTUNE "Enable support for profiling with VTune")
option(SANITIZE "Enable support for a sanitizer (undefined address memory thread)")
option(CLANG11 "Path to the version of Clang that corresponds to the MLIR framework")
option(EXT_DEBUG "Show more debugging information")

if (NOT CLANG11) 
    message(FATAL_ERROR "Please define the path to Clang 11 with -DCLANG11=...")
endif()

if (NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Debug)
    message("CMAKE_BUILD_TYPE defaulted to Debug")
endif()

set(LLVM_ENABLE_LIBCXX ON)

if (VTUNE)
    if ("${CMAKE_BUILD_TYPE}" STREQUAL "Release")
        message("Replacing build type 'Release' with 'RelWithDebInfo'")
        set(CMAKE_BUILD_TYPE "RelWithDebInfo")
    endif ()
    message("VTune Enabled")
    link_libraries(${PROJECT_SOURCE_DIR}/libittnotify.a)
endif ()

if (XRAY)
    set(XRAY_THRESHOLD "25")
    set(XRAY_OPTIONS "-fxray-instrument -fxray-instruction-threshold ${XRAY_THRESHOLD}")
    message("LLVM X-Ray enabled!")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${XRAY_OPTIONS}")
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${XRAY_OPTIONS}")
endif ()

if ("${CMAKE_BUILD_TYPE}" STREQUAL "Release" OR "${CMAKE_BUILD_TYPE}" STREQUAL "RelWithDebInfo")
    message("Release build")
    add_compile_definitions(LLVMSQLITE_RELEASE)
else ()
    message("Debug build")
    add_compile_definitions(LLVMSQLITE_DEBUG)
endif ()

add_compile_definitions(SQLITE_OMIT_VIRTUALTABLE=1)
add_compile_definitions(SQLITE_OMIT_TRACE=1)

if (EXT_DEBUG)
    message("Debug machine")
    add_compile_definitions(DEBUG_MACHINE)
endif ()

if (VTUNE)
    add_compile_definitions(VTUNE)
endif ()

if (SANITIZE)
    message("Sanitizer: '${SANITIZE}'")

    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fsanitize=${SANITIZE} -fno-omit-frame-pointer -g")
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fsanitize=${SANITIZE} -fno-omit-frame-pointer -g")

    if (SANITIZE STREQUAL "address")
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}")
        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS}")
    elseif (SANITIZE STREQUAL "memory")
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fsanitize-memory-track-origins")
        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fsanitize-memory-track-origins")
    endif ()
endif ()

find_package(Threads)

include_directories(${PROJECT_SOURCE_DIR})
include_directories(${PROJECT_SOURCE_DIR}/src)

add_subdirectory(${PROJECT_SOURCE_DIR}/src/mlir)

add_custom_command(
    OUTPUT ${PROJECT_SOURCE_DIR}/Makefile-NoAlgam
    COMMAND ./configure  --disable-tcl --disable-load-extension --disable-amalgamation && mv Makefile Makefile-NoAlgam
    WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
    DEPENDS ${PROJECT_SOURCE_DIR}/Makefile.in
)

add_custom_command(
    OUTPUT ${PROJECT_SOURCE_DIR}/Makefile-Algam
    COMMAND ./configure  --disable-tcl --disable-load-extension && mv Makefile Makefile-Algam
    WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
    DEPENDS ${PROJECT_SOURCE_DIR}/Makefile.in
)

add_custom_command(
    OUTPUT 
        ${PROJECT_SOURCE_DIR}/opcodes.c
        ${PROJECT_SOURCE_DIR}/opcodes.h
        ${PROJECT_SOURCE_DIR}/parse.h
        ${PROJECT_SOURCE_DIR}/parse.c
        ${PROJECT_SOURCE_DIR}/sqlite3.h
        ${PROJECT_SOURCE_DIR}/keywordhash.h
    VERBATIM COMMAND cd ${PROJECT_SOURCE_DIR} && make -f Makefile-NoAlgam opcodes.c opcodes.h parse.c parse.h keywordhash.h sqlite3.h -j4
    DEPENDS ${PROJECT_SOURCE_DIR}/Makefile-NoAlgam
)

add_custom_command(
    OUTPUT ${PROJECT_SOURCE_DIR}/sqlite3.c
    VERBATIM COMMAND cd ${PROJECT_SOURCE_DIR} && ./configure --disable-tcl --disable-load-extension  && make -f Makefile-Algam sqlite3.c -j4
    DEPENDS ${PROJECT_SOURCE_DIR}/Makefile-Algam
)


# Custom file serving as a bridge between SQLite and the JIT
add_library(vdbe_exec_llvm ${PROJECT_SOURCE_DIR}/src/vdbe_exec.cpp ${PROJECT_SOURCE_DIR}/sqlite3.h)
target_compile_definitions(vdbe_exec_llvm PUBLIC ENABLE_JIT=1 ENABLE_DEFAULT=0)
target_compile_definitions(vdbe_exec_llvm PRIVATE VDBE_EXEC_NAME=sqlite3VdbeExecDefault)

add_library(vdbe_exec_default ${PROJECT_SOURCE_DIR}/src/vdbe_exec.cpp ${PROJECT_SOURCE_DIR}/sqlite3.h)
target_compile_definitions(vdbe_exec_default PUBLIC ENABLE_JIT=0 ENABLE_DEFAULT=1)
target_compile_definitions(vdbe_exec_default PRIVATE VDBE_EXEC_NAME=sqlite3VdbeExecDefault)

add_library(vdbe_exec_universal ${PROJECT_SOURCE_DIR}/src/vdbe_exec.cpp ${PROJECT_SOURCE_DIR}/sqlite3.h)
target_compile_definitions(vdbe_exec_universal PUBLIC ENABLE_JIT=1 ENABLE_DEFAULT=1)
target_compile_definitions(vdbe_exec_universal PRIVATE VDBE_EXEC_NAME=sqlite3VdbeExecDefault)

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
    ${PROJECT_SOURCE_DIR}/sqlite3.h
)
target_compile_definitions(sqlite PRIVATE VDBE_EXEC_NAME=sqlite3VdbeExecDefault)
target_compile_definitions(sqlite PRIVATE SQLITE_OMIT_VIRTUALTABLE=1 SQLITE_OMIT_TRACE=1)
target_compile_definitions(sqlite PRIVATE SQLITE_PRIVATE)

# Dummy library to use the sqlite3.c auto-generated file
add_library(sqlite3_aggregate sqlite3.c)

# shell_jit only executes statements using the JIT compiler.
add_executable(shell_jit shell.c ${PROJECT_SOURCE_DIR}/sqlite3.h)
target_link_libraries(shell_jit sqlite)
target_link_libraries(shell_jit vdbe_exec_llvm)
target_link_libraries(shell_jit sqlite_llvm)
target_link_libraries(shell_jit ${CMAKE_THREAD_LIBS_INIT})
target_link_libraries(shell_jit ${CMAKE_DL_LIBS})
# Force shell_jit to be compiled after shell_default and thus sqlite3.h to exist
add_dependencies(shell_jit shell_default)

# shell_default is the same shell as one would get when compiling SQLite in the canonical way.
add_executable(shell_default shell.c ${PROJECT_SOURCE_DIR}/)
target_link_libraries(shell_default sqlite)
target_link_libraries(shell_default vdbe_exec_default)
target_link_libraries(shell_default ${CMAKE_THREAD_LIBS_INIT})
target_link_libraries(shell_default ${CMAKE_DL_LIBS})

# profilable_shell is an executable that can execute both JIT-compiled or interpreted statements.
add_executable(profilable_shell shell.c ${PROJECT_SOURCE_DIR}/)
target_link_libraries(profilable_shell sqlite)
target_link_libraries(profilable_shell vdbe_exec_universal)
target_link_libraries(profilable_shell sqlite_llvm)
target_link_libraries(profilable_shell ${CMAKE_THREAD_LIBS_INIT})
target_link_libraries(profilable_shell ${CMAKE_DL_LIBS})

# Target to build sqlite3.ll, used by JIT inlining features
add_custom_command(
    OUTPUT sqlite3.ll
    VERBATIM COMMAND ${CLANG11} -O3 -S -emit-llvm ${PROJECT_SOURCE_DIR}/sqlite3.c -o sqlite3.ll -DSQLITE_OMIT_VIRTUALTABLE=1 -DSQLITE_OMIT_TRACE=1
    DEPENDS ${PROJECT_SOURCE_DIR}/sqlite3.c
)
add_custom_target(assembly
    DEPENDS sqlite3.ll
)
add_dependencies(shell_jit assembly)
add_dependencies(profilable_shell assembly)









