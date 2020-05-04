#pragma once

extern "C" {
#include "sqliteInt.h"
#include "vdbe.h"
#include "vdbeInt.h"
#include "sqlite3.h"
}

int sqlite3VdbeExec(Vdbe *p);
