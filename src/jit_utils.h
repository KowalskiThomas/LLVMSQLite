#include <llvm/IR/Module.h>
#include <llvm/Support/raw_ostream.h>
#include <iostream>

using namespace llvm;

void print_module(llvm::Module& m, bool = true);
void print_module(const std::unique_ptr<llvm::Module>& m, bool = true);

template<typename T>
void llvm_print(T& x) {
    std::string str;
    raw_string_ostream s(str);
    x.print(s);
    std::cout << str << std::endl;
}
