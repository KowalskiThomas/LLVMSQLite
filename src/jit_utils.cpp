#include "jit_utils.h"

void print_module(llvm::Module& m) {
    std::string str;
    raw_string_ostream s(str);
    m.print(s, nullptr);
    std::cout << str;
}

void print_module(const std::unique_ptr<llvm::Module>& m) {
    std::string str;
    raw_string_ostream s(str);
    m->print(s, nullptr);
    std::cout << str;
}