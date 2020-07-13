#pragma once

#include "SQLiteBridge.h"

using namespace std::chrono;

template<typename T>
void printTimeDifference(time_point<T> tick, std::string msg) {
    auto tock = system_clock::now();
    auto diff = tock - tick;
    printf("%s time difference: %llu ms\n",
           msg.c_str(),
           duration_cast<milliseconds>(diff).count());
}

void writeToFile(const char *const fileName, std::string);

void writeToFile(const char *const fileName, mlir::ModuleOp&);

void writeToFile(const char *const fileName, llvm::Module&);
