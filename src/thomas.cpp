#include <iostream>
#include <string>

extern "C" {
    #include "sqliteInt.h"
    #include "vdbeInt.h"
}

extern "C" {
    int sqlite3VdbeExec(
            Vdbe *p                    /* The VDBE */
    ){
        for(size_t i = 0; i < p->nOp; i++) {
            std::cout << p->aOp[i].opcode << std::endl;
        }
    }

}
