#pragma once

#include "SQLiteBridge.h"

extern "C" {
#include "src/sqlite3ext.h"
#include "src/sqliteInt.h"
#include "src/vdbe.h"
#include "src/vdbeInt.h"
}

struct VdbeHash {
    size_t operator()(const Vdbe& vdbe) const;
    size_t operator()(const Vdbe* const vdbe) const;

    std::string getFileName(const Vdbe* const vdbe) const;
};