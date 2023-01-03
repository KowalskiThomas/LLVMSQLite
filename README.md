<h1 align="center">LLVMSQLite</h1>

LLVMSQLite was built for my MSc. Thesis at Imperial College London.

If you want to read more about it and the design choices I made,
[the thesis PDF is available in the repository](https://github.com/KowalskiThomas/LLVMSQLite/blob/master/Thesis.pdf).

# Building LLVMSQLite 

LLVMSQLite does not use the canonical build process used by SQLite, but rather a mix between their configure script and Makefiles and CMake, for everything LLVM-related.

Since the Makefile does some serious things that I'm not sure I'd be able to do in a CMake project, the CMake project calls the SQLite configure script and Makefiles to generate the resources it needs.

More precisely: traditionally, SQLite uses what they call the *amalgamation* which is essentially a big C file containing *everything* SQLite needs to be compiled (it's a *pretty big* C file), called `sqlite3.c`.
Generating `sqlite3.c` takes a bit of time, that is why it's not desirable to do so when working on the SQLite code. 
Though, the amalgamation can be very useful for loading the definition of certain functions at run-time, for performing inlining in the JIT compiler. 
That is why the CMake project uses both build methods:

* `sqlite3.c` for generating `sqlite3.ll`, a huge IR module loaded at JIT-compile-time, but never used in the AOT build process ;
* The C files in `src` that are compiled together to form `libsqlite3`, against which LLVMSQLite is linked. 

That allows me to get the best of both worlds. 

Now let's get to the serious stuff, how to build LLVMSQLite. Assuming you have cloned the LLVMSQLite repository in the current working directory:

```
cd LLVMSQLite
mkdir build
cd build
cmake .. -G Ninja -DCLANG11=path/to/clang11 -DCMAKE_BUILD_TYPE=RelWithDebInfo
ninja
```

The `CLANG11` option allows you to give the path to `clang`, which is not necessarily the `clang` used to compile the project. **The LLVM version of the clang at `CLANG11` should be the same as the version you're linking against in the project.** Otherwise, loading the IR module (`sqlite3.ll`)
may cause crashes due to LLVM not being able to verify the loaded module. 

Other options exist:

* `DXRAY=ON` compiles LLVMSQLite with LLVM-XRay (for profiling purposes) ;
* `DVTUNE=ON` compiles LLVMSQLite with calls to the Intel VTune API (`libittnotify`), to only profile the parts of the process that are of interest to us ;
* `DSANITIZE=[san]` (where `san` can be `address`, `undefined` or `memory`) compiles LLVMSQLite with one of the *San tools for checking for issues. 


**Note:** Should you have installed the custom LLVM libraries to another directory than `~/llvm`, you need to update the definitions in `src/mlir/CMakeLists.txt`. They should be fairly easy to adapt once you've built LLVM (see **Prerequisites**). The affected line is the following:

```
# The directory where LLVM libraries are installed
set(PREFIX "$ENV{HOME}/llvm/usr/local/")
```

# Prerequisites

[Clone my version of LLVM from the repo](https://github.com/kowalskithomas/LLVM). 

The difference between my LLVM and upstream `llvm/llvm-project` is that:

* Some `asserts` have been made clearer to help when debugging IR generation (only if `NDEBUG` is not #define'd);
*  Some MLIR operations have been added to the LLVM dialect:
   * Memory intrinsics (`memcmp`, `memcpy`, `memset`, `memcpyinline`) ;
   * `stackSave` and `stackRestore` 
   * `call` can now call values (and not only `LLVMFuncOp`'s)
   * `switch` instructions can now be emitted 

As explained earlier, you'll need to compile and install MLIR and Clang:

```
mkdir ~/llvm/
mkdir build && cd build

export CC=clang
export CXX=clang++

cmake -G Ninja ../llvm \
    -DLLVM_ENABLE_PROJECTS="mlir;clang" \
    -DLLVM_TARGETS_TO_BUILD="X86" \
    -DCMAKE_BUILD_TYPE=RelWithDebInfo \ 
    -DLLVM_ENABLE_ASSERTIONS=ON

DESTDIR=~/llvm ninja install
```

# Usage 

LLVMSQLite works in the exact same way as the SQLite shell. The build process produces three binaries:

* `shell_default` is the exact same thing as the classical SQLite shell; 
* `shell_jit` works the same way as `shell_default` but uses the JIT compiler instead of the embedded interpreter;
* `profilable_shell` works the same way as the others but allows you to switch JIT compilation on or off using `-jit` or `-nojit`.

*I have modified the shell so that if you pass an initialisation SQL file with `-init`, SQLite will exit after executing it. That is useful when executing benchmarking scripts.*

# Benchmarking with TPC-H

To carry out performance tests, I use the TPC-H benchmark. To do that, you'll need (1) a TPC-H database and (2) TPC-H compliant queries. 

**Getting TPC-H and SSBM databases**

I use a modified version of the very useful [TPC-H SQLite](https://github.com/lovasoa/TPCH-sqlite) repository. 
It can generate database files of various scales for both TPC-H and SSBM benchmarks.

```
git clone https://github.com/kowalskithomas/llvmsqlite_dbgen dbgen
cd dbgen
make -f MakefileTPCH
```

This will generate several `TPC-H-[Size].db` files that you can use with the SQLite shell:

```
./shell_default /home/me/tpch/TPC-H-big.db
```

**Getting SQL queries**

TPC-H is a set of 22 SQL queries that are randomly generated given some constraints. I have implemented a generator that you will find in `llvmsqlite_util/benchmarking`. 
To use it, simply do the following:

```
cd llvmsqlite_util/benchmarking
python3 generator_tpch.py --query N > q.sql
```

Where *N* is any number between 1 and 22. (The script is compatible with Python >= 3.7.)

To use the SQL statement directly in the shell, do the following:

```
./shell /path/to/the.db -init /path/to/q.sql
```

The custom LLVMSQLite shell will exit immediately once the statement is processed.
