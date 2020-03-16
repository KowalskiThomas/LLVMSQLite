#include <iostream>
#include <string>

#include <llvm/ExecutionEngine/ExecutionEngine.h>

extern "C" {
#include "sqliteInt.h"
#include "vdbeInt.h"
}

extern "C" {
int sqlite3VdbeExec(Vdbe *p) {
    for (size_t i = 0; i < p->nOp; i++) {
        std::cout << sqlite3OpcodeName(p->aOp[i].opcode) << std::endl;
    }
    return SQLITE_OK;
}
}
