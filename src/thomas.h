#pragma once

#include <cmath>
#include <iostream>
#include <memory>
#include <string>
#include <unordered_map>

#include "llvm/ADT/StringRef.h"
#include "llvm/ExecutionEngine/GenericValue.h"
#include "llvm/ExecutionEngine/JITSymbol.h"
#include "llvm/ExecutionEngine/Orc/CompileUtils.h"
#include "llvm/ExecutionEngine/Orc/Core.h"
#include "llvm/ExecutionEngine/Orc/ExecutionUtils.h"
#include "llvm/ExecutionEngine/Orc/IRCompileLayer.h"
#include "llvm/ExecutionEngine/Orc/JITTargetMachineBuilder.h"
#include "llvm/ExecutionEngine/Orc/RTDyldObjectLinkingLayer.h"
#include "llvm/ExecutionEngine/SectionMemoryManager.h"
#include "llvm/IR/DataLayout.h"
#include "llvm/IR/LLVMContext.h"
#include <llvm/ADT/StringRef.h>
#include <llvm/ExecutionEngine/ExecutionEngine.h>
#include <llvm/ExecutionEngine/MCJIT.h>
#include <llvm/IR/Constant.h>
#include <llvm/IR/IRBuilder.h>
#include <llvm/IR/LLVMContext.h>
#include <llvm/IR/Module.h>
#include <llvm/IR/PassManager.h>
#include <llvm/IR/Verifier.h>
#include <llvm/Support/DynamicLibrary.h>
#include <llvm/Support/TargetSelect.h>
#include <llvm/Support/raw_ostream.h>

extern "C" {
#include "sqliteInt.h"
#include "vdbe.h"
#include "vdbeInt.h"
#include "sqlite3.h"
}

using namespace llvm;
using namespace orc;

extern Type* intTy;
extern Type* fltTy;
extern Type* bitTy;

struct my_context {
    // The VDBE to execute
    Vdbe* vdbe;
    // The LLVM module
    std::unique_ptr<llvm::Module> module;
    // The main JITted function
    Function* mainFunction;
    // The LLVM Context we use in the code generation
    LLVMContext& context;
    // The entry basic block
    BasicBlock* entry;
    // The end basic block (end of JITted main)
    BasicBlock* end;
    // Type used to store the different instruction-basic-blocks
    using BlocksMap = std::unordered_map<size_t, BasicBlock*>;
    // The instruction basic-blocks
    BlocksMap blocks;
    // Type used to store the registers
    using RegsMap = std::unordered_map<size_t, AllocaInst*>;
    // The registers
    RegsMap registers;

    using ParametersMap = std::unordered_map<size_t, std::unordered_map<size_t, AllocaInst*>>;
    ParametersMap parameters;

    my_context(Vdbe* vdbe, std::unique_ptr<llvm::Module> module, Function* mainFunction, LLVMContext& context,
            BasicBlock* entry, BasicBlock* end, BlocksMap blocks, RegsMap registers, ParametersMap parameters)
            : vdbe(vdbe), module(std::move(module)), mainFunction(mainFunction), context(context),
            entry(entry), end(end), blocks(std::move(blocks)), registers(std::move(registers)), parameters(std::move(parameters))
    {
    }
};

my_context createMain(LLVMContext& context, Vdbe* vdbe);
void writeInstruction(my_context& ctx, size_t pc);
void load_type_definitions(my_context&);
