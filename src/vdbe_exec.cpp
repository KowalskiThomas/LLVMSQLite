#include "vdbe_exec.h"
#include <chrono>

extern "C" {

#ifndef ENABLE_JIT
#error("Please define ENABLE_JIT")
#endif
#ifndef ENABLE_DEFAULT
#error("Please define ENABLE_DEFAULT")
#endif

// Whether to use JIT for queries. Should be -1 if ENABLE_JIT && !ENABLE_DEFAULT or !ENABLE_JIT && ENABLE_DEFAULT
char enableJit = -1;

int jitVdbeStep(Vdbe *);

int sqlite3VdbeExec(Vdbe *p) {
    auto tick = std::chrono::system_clock::now();

#if ENABLE_JIT && !ENABLE_DEFAULT
    assert(enableJit == -1);
    auto step_return = jitVdbeStep(p);
#else
#if ENABLE_DEFAULT && !ENABLE_JIT
    assert(enableJit == -1);
    auto step_return = sqlite3VdbeExec2(p);
#else
    int step_return;
    if (enableJit)
        step_return = jitVdbeStep(p);
    else
        step_return = sqlite3VdbeExec2(p);
#endif
#endif

    auto tock = std::chrono::system_clock::now();
    auto diff = (unsigned long long)(std::chrono::duration_cast<std::chrono::milliseconds>(tock - tick).count());
    printf("Total step time: %llu ms\n", diff);

    return step_return;
}

}
