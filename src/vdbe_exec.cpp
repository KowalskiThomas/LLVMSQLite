#include "vdbe_exec.h"

extern "C" {

int jitVdbeStep(Vdbe *);

int sqlite3VdbeExec(Vdbe *p) {
    auto step_return = jitVdbeStep(p);
    return step_return;
}

}
