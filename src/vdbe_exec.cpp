#include "vdbe_exec.h"
#include <chrono>

extern "C" {

#ifndef ENABLE_JIT
#error("Please define ENABLE_JIT")
#endif

int jitVdbeStep(Vdbe *);

int sqlite3VdbeExec(Vdbe *p) {
    auto tick = std::chrono::system_clock::now();

    // THOMAS SWITCH HERE azeaze
#if ENABLE_JIT
    auto step_return = jitVdbeStep(p);
#else
    auto step_return = sqlite3VdbeExec2(p);
#endif

    auto tock = std::chrono::system_clock::now();
    auto diff = tock - tick;
    printf("Time with compilation: %llu\n",
            std::chrono::duration_cast<std::chrono::milliseconds>(tock - tick).count());
    return step_return;
}

}
