#include <iostream>
#include <string>

#include <cmath>
#include <unordered_map>
#include <llvm/ExecutionEngine/ExecutionEngine.h>
// #include <thirdparty/codegen/include/codegen/statements.hpp>

/*
#include "thirdparty/codegen/include/codegen/compiler.hpp"
#include "thirdparty/codegen/include/codegen/module_builder.hpp"
#include "thirdparty/codegen/include/codegen/module.hpp"
#include "thirdparty/codegen/include/codegen/variable.hpp"
#include "thirdparty/codegen/include/codegen/literals.hpp"
#include "thirdparty/codegen/include/codegen/builtin.hpp"
#include "thirdparty/codegen/include/codegen/arithmetic_ops.hpp"
*/

extern "C" {
#include "sqliteInt.h"
#include "vdbeInt.h"
}

extern "C" {

int sqlite3VdbeExec(Vdbe *p) {
    std::cout << "OK" << std::endl;

    return SQLITE_OK;
}

}
