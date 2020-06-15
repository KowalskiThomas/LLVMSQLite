#include "vdbe_exec.h"
#include <chrono>

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

// Whether to use JIT for queries. Should be -1 if ENABLE_JIT && !ENABLE_DEFAULT or !ENABLE_JIT && ENABLE_DEFAULT
char enableJit = -1;

int jitVdbeStep(Vdbe *);

int sqlite3VdbeExec(Vdbe *p) {
    static Vdbe* lastVdbe = nullptr;
    static auto initialTick = decltype(system_clock::now()){};
    if (lastVdbe != p) {
#ifdef DEBUG_MACHINE
        printf("Resetting initialTick\n");
#endif
        initialTick = system_clock::now();
        lastVdbe = p;
    }

#ifdef DEBUG_MACHINE
    auto tick = std::chrono::system_clock::now();
#endif

#if ENABLE_JIT && !ENABLE_DEFAULT
    assert(enableJit == -1);
    auto step_return = jitVdbeStep(p);
#else
#if ENABLE_DEFAULT && !ENABLE_JIT
    assert(enableJit == -1);
    auto step_return = sqlite3VdbeExec2(p);
#else
#if ENABLE_DEFAULT && ENABLE_JIT
    int step_return;
    if (enableJit)
        step_return = jitVdbeStep(p);
    else
        step_return = sqlite3VdbeExec2(p);
#else
#error "Nothing is enabled"
#endif
#endif
#endif

#ifdef DEBUG_MACHINE
    auto tock = system_clock::now();
    auto diff = (unsigned long long)(duration_cast<milliseconds>(tock - tick).count());
    printf("Total step time: %llu ms. RC = %d\n", diff, step_return);
#endif

    if (step_return == SQLITE_DONE) {
        extern unsigned long long functionPreparationTime;
        extern unsigned long long functionOptimisationTime;
        auto initialDiff = (unsigned long long)(duration_cast<milliseconds>(tock - initialTick).count());
#if ENABLE_JIT
        printf("Preparation time: %llu ms\n", functionPreparationTime);
        printf("Optimisation time: %llu ms\n", functionOptimisationTime);
#endif
        printf("Total Vdbe execution time: %llu ms\n", initialDiff);
#if ENABLE_JIT
        printf("Vdbe execution time without compilation: %llu ms\n",
                initialDiff - functionPreparationTime - functionOptimisationTime);
#endif
    }


    return step_return;
}

}
