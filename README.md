<h1 align="center">LLVMSQLite</h1>

**Note:** Most of that is TODO. 

# Buidling LLVMSQLite 

LLVMSQLite does not use the canonical build process used by SQLite, but rather a mix between their configure script and Makefiles and CMake, for everything LLVM-related.

Since the Makefile does some serious things that I'm not sure I'd be able to do in a CMake project, the CMake project calls the SQLite configure script and Makefiles to generate the resources it needs.

More precisely: traditionally, SQLite uses what they call the *amalgamation* which is essentially a big C file containing *everything* (it's a *pretty big* C file) that SQLite needs to be compiled, called `sqlite3.c`. Generating `sqlite3.c` takes a bit of time, that is why it's not desirable to do so when working on the code SQLite. Though, the amalgamation can be very useful for loading the definition of certain functions at run-time, for performing inlining in the JIT compiler. That is why the CMake project uses both builds:

* `sqlite3.c` for generating `sqlite3.ll`, a huge IR module loaded at JIT-compile-time, but never used in the AOT build process ;
* The C files in `src` that are compiled together to form `libsqlite3`, against which LLVMSQLite is linked. 

That allows me to get the best of both worlds. 

Now let's get to the serious stuff, how to build LLVMSQLite. 

```
mkdir build
cd build
cmake .. -G Ninja -DCLANG11=path/to/clang11
ninja
```

The `CLANG11` option allows you to give the path to `clang`, which is not necessarily the `clang` used to compile the project. **The LLVM version of the clang at `CLANG11` should be the same as the version you're linking against in the project.** Otherwise, loading the IR module (`sqlite3.ll`)
may cause crashes due to LLVM not being to verify the loaded module. 

**TODO:** You also need to define the right paths to the LLVM libraries in `src/mlir`. They should be fairly easy to adapt once you've built LLVM (see **Prerequisites**).

Other options exist:

* `DXRAY=ON` compiles LLVMSQLite with LLVM-XRay (for profiling purposes) ;
* `DVTUNE=ON` compiles LLVMSQLite with calls to the Intel VTune API (`libittnotify`), to only profile the parts of the process that are of interest to us ;
* `DSANITIZE=[san]` (where `san` can be `address`, `undefined` or `memory`) compiles LLVMSQLite with one of the *San tools for checking for issues. 

# Prerequisites

[Clone my version of LLVM from the repo](https://github.com/kowalskithomas/LLVM). 

The difference between my LLVM and `llvm/llvm-project` is that:

* Some `asserts` have been made clearer to help when debugging IR generation (only if `NDEBUG` is not defined);
*  Some MLIR operations have been added to the LLVMIR dialect:
   * Memory intrinsics (`memcmp`, `memcpy`, `memset`, `memcpyinline`) ;
   * `stackSave` and `stackRestore` 
   * `call` can now call values (and not only `LLVMFuncOp`'s)

As explained earlier, you'll need to compile and install MLIR and Clang:

```
mkdir ~/llvm/
mkdir build && cd build
export CC=clang
export CXX=clang++
cmake -G Ninja ../llvm -DLLVM_ENABLE_PROJECTS="mlir;clang" -DLLVM_TARGETS_TO_BUILD="X86" -DCMAKE_BUILD_TYPE=RelWithDebInfo -DLLVM_ENABLE_ASSERTIONS=ON
DESTDIR=~/llvm ninja install
```


# Usage 

LLVMSQLite works in the exact same way as the SQLite shell. The build process produces three binaries:

* `shell_default` is the exact same thing as the classical SQLite shell; 
* `shell_jit` works the same way as `shell_default` but uses the JIT compiler instead of the embedded interpreter;
* `profilable_shell` works the same way as the others but allows you to switch JIT compilation on or off using `-jit` or `-nojit`.

*I have modified the shell so that if you pass an initialisation SQL file with `-init`, SQLite will exit after executing it.*

# Benchmarking with TPC-H

To carry out performance tests, I use the TPC-H benchmark. To do that, you'll need (1) a TPC-H database and (2) TPC-H compliant queries. 

**Getting a TPC-H database**

I use the very good [TPC-H SQLite](https://github.com/lovasoa/TPCH-sqlite) repository.

```
git clone https://github.com/lovasoa/TPCH-sqlite tpch
cd tpch
SCALE_FACTOR=1.0 make
```

This will generate a `TPC-H.db` file that you can use with the SQLite shell:

```
./shell /home/me/tpch/TPC-H.db
```

**Getting SQL queries**

TPC-H is a set of 21 SQL queries that are randomly generated given some constraints. I have implemented a generator that you will find in `kowalski_util/tpc-h`. To use it, simply do the following:

```
cd kowalski_util/tpc-h
python3 generator.py N > q.sql
```

Where N is any number between 1 and 21. (Compatible with Python >= 3.7.)

To use the SQL statement directly in the shell, do the following:

```
./shell /path/to/the.db -init /path/to/q.sql
```

The custom LLVMSQLite shell will exit immediately when the statement is processed.
