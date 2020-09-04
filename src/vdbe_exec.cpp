#include <chrono>

#include "mlir/include/Standalone/DebugUtils.h"

extern char enableJit;

#ifdef VTUNE
#include "ittnotify.h"
#endif

#include "vdbe_exec.h"

#define INCONSISTENT_STATE 110

using namespace std::chrono;

extern "C" {

#ifndef ENABLE_JIT
#error("Please define ENABLE_JIT")
#endif
#ifndef ENABLE_DEFAULT
#error("Please define ENABLE_DEFAULT")
#endif

#if !ENABLE_JIT
    unsigned long long functionPreparationTime = 0;
    unsigned long long functionOptimisationTime = 0;
#endif

int jitVdbeStep(Vdbe *);

extern "C" {
    extern int query_id;
}

int sqlite3VdbeExec(Vdbe *p) {
#ifdef VTUNE
    __itt_resume();
#endif

  static void* last_vdbe = 0;
  if (last_vdbe == 0)
    last_vdbe = p;
  else if (last_vdbe != p) {
    last_vdbe = p;
    query_id++;
  }

    static Vdbe* lastVdbe = nullptr;
    static auto initialTick = decltype(high_resolution_clock::now()){};
    if (lastVdbe != p) {
#ifdef DEBUG_MACHINE
        printf("Resetting initialTick\n");
#endif
        initialTick = high_resolution_clock::now();
        lastVdbe = p;
    }

#ifdef LLVMSQLITE_DEBUG
    auto tick = std::chrono::high_resolution_clock::now();
#endif

#if ENABLE_JIT && !ENABLE_DEFAULT
    LLVMSQLITE_ASSERT(enableJit == -1);
    auto step_return = jitVdbeStep(p);
#else
#if ENABLE_DEFAULT && !ENABLE_JIT
    LLVMSQLITE_ASSERT(enableJit == -1);
    auto step_return = VDBE_EXEC_NAME(p);
#else
#if ENABLE_DEFAULT && ENABLE_JIT
    int step_return;
    if (enableJit == 1)
        step_return = jitVdbeStep(p);
    else if (enableJit == 0)
        step_return = VDBE_EXEC_NAME(p);
    else if (enableJit == -1) {
        fprintf(stderr, "Please select a mode with -jit or -nojit\n");
        exit(INCONSISTENT_STATE);
    } else {
        fprintf(stderr, "enableJit has an unexpected value!\n");
        exit(INCONSISTENT_STATE);
    }
#else
#error "Nothing is enabled"
#endif
#endif
#endif

    auto tock = high_resolution_clock::now();

#ifdef LLVMSQLITE_DEBUG
    auto diff = (unsigned long long)(duration_cast<milliseconds>(tock - tick).count());
    printf("Total step time: %llu ms. RC = %d\n", diff, step_return);
#endif

    if (step_return == SQLITE_DONE) {
        auto initialDiff = (unsigned long long)(duration_cast<milliseconds>(tock - initialTick).count());
#if ENABLE_JIT
        // Time spent in writeModule
        extern unsigned long long functionPreparationTime;
        // Time spent in optimiseModule
        extern unsigned long long functionOptimisationTime;
        // Time spent in createExecutionEngine
        extern unsigned long long functionCompilationTime;
        // Time spent getting a valid VdbeRunner in jitVdbeStep
        extern unsigned long long vdbeRunnerCreationTime;

        printf("VdbeRunner creation time: %llu ms\n", vdbeRunnerCreationTime);
        printf("Preparation time: %llu ms\n", functionPreparationTime);
        printf("Optimisation time: %llu ms\n", functionOptimisationTime);
        printf("Compilation time: %llu ms\n", functionCompilationTime);
        printf("Sum: %llu ms\n",
                vdbeRunnerCreationTime + functionPreparationTime + functionOptimisationTime + functionCompilationTime);
#endif
#if ENABLE_JIT && ENABLE_DEFAULT
	if (enableJit == 0)
#endif
#if ENABLE_DEFAULT
	    printf("Default Implementation Vdbe execution time: %llu ms\n", (unsigned long long)(initialDiff));
#endif
#if ENABLE_JIT && ENABLE_DEFAULT
	else {
#endif
#if ENABLE_JIT
	printf("Total execution time with compilation and optimisation: %llu ms\n", initialDiff);
        printf("JIT Vdbe execution time: %llu ms\n",
                initialDiff
                - functionPreparationTime
                - functionOptimisationTime
                - functionCompilationTime
                - vdbeRunnerCreationTime);

        // Reset all times for next run
        functionPreparationTime = 0;
        functionOptimisationTime = 0;
        functionCompilationTime = 0;
        vdbeRunnerCreationTime = 0;
#endif
#if ENABLE_JIT && ENABLE_DEFAULT
        }
#endif
        lastVdbe = nullptr;
    }

#ifdef VTUNE
    __itt_pause();
#endif
    return step_return;
}

}
