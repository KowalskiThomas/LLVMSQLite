#include "vdbe_exec.h"
#include <chrono>

extern "C" {

#ifndef ENABLE_JIT
#error("Please define ENABLE_JIT")
#endif

int jitVdbeStep(Vdbe *);

int sqlite3VdbeExec(Vdbe *p) {
    auto tick = std::chrono::system_clock::now();

#if ENABLE_JIT
    auto step_return = jitVdbeStep(p);
#else
    auto step_return = sqlite3VdbeExec2(p);
#endif

    auto tock = std::chrono::system_clock::now();
    auto diff = (unsigned long long)(std::chrono::duration_cast<std::chrono::milliseconds>(tock - tick).count());
    printf("Total step time: %llu ms\n", diff);

    return step_return;
}

}
