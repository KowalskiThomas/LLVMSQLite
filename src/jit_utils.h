#include <llvm/IR/Module.h>
#include <llvm/Support/raw_ostream.h>
#include <iostream>

using namespace llvm;

void print_module(llvm::Module& m);
void print_module(const std::unique_ptr<llvm::Module>& m);
