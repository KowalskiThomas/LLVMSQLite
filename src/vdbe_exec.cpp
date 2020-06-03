#include "vdbe_exec.h"
#include <chrono>

extern "C" {

int jitVdbeStep(Vdbe *);

int sqlite3VdbeExec(Vdbe *p) {
    auto tick = std::chrono::system_clock::now();

    // THOMAS SWITCH HERE azeaze
    //auto step_return = sqlite3VdbeExec2(p);
    auto step_return = jitVdbeStep(p);

    auto tock = std::chrono::system_clock::now();
    auto diff = tock - tick;
    printf("Time with compilation: %llu\n",
            std::chrono::duration_cast<std::chrono::milliseconds>(tock - tick).count());
    return step_return;
}

}
