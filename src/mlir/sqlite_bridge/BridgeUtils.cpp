#include "BridgeUtils.h"

void writeToFile(const char *const fileName, std::string s) {
    debug("Writing to file " << fileName);
    auto fd = fopen(fileName, "w");
    fwrite(s.c_str(), sizeof(char), s.size(), fd);
    fclose(fd);
}

void writeToFile(const char *const fileName, mlir::ModuleOp &x) {
    std::string s;
    auto stream = llvm::raw_string_ostream(s);
    x.print(stream);
    writeToFile(fileName, s);
}

void writeToFile(const char *const fileName, llvm::Module &m) {
    std::string s;
    auto stream = llvm::raw_string_ostream(s);
    stream << m;
    writeToFile(fileName, s);
}
