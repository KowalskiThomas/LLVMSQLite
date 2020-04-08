#include <iostream>
#include <string>
#include <cmath>
#include <unordered_map>
#include <iostream>
#include <memory>

#include <llvm/ADT/StringRef.h>
#include <llvm/ExecutionEngine/ExecutionEngine.h>
#include <llvm/ExecutionEngine/MCJIT.h>
#include <llvm/IR/Constant.h>
#include <llvm/IR/IRBuilder.h>
#include <llvm/IR/LLVMContext.h>
#include <llvm/IR/Module.h>
#include <llvm/IR/Verifier.h>
#include <llvm/Support/DynamicLibrary.h>
#include <llvm/Support/raw_ostream.h>
#include <llvm/Support/TargetSelect.h>
#include <llvm/ExecutionEngine/ExecutionEngine.h>
#include "llvm/ExecutionEngine/GenericValue.h"
#include <llvm/ExecutionEngine/MCJIT.h>
#include <llvm/IR/PassManager.h>
#include "llvm/ADT/StringRef.h"
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

using namespace llvm;
using namespace orc;

enum opcode {
    op_add,
    op_set,
    op_jump,
    op_halt,
    op_gt,
    op_init
};

struct instr {
    opcode opCode;
    int p1;
    int p2;
    int p3;
    int p4;
};

void foo(int k) {
    std::cout << "foo called with " << k << "\n";
}

int getInt() {
    return 31415;
}

using namespace llvm;

struct my_context {
    std::unique_ptr<Module> module;
    Function* mainFunction;
    LLVMContext context;
};

my_context createMain(LLVMContext& context) {
    llvm::InitializeNativeTarget();
    llvm::InitializeNativeTargetAsmPrinter();
    llvm::InitializeNativeTargetAsmParser();

    auto module = std::make_unique<llvm::Module>("top", context);
    llvm::IRBuilder<> builder(context);

    auto fooType = llvm::FunctionType::get(builder.getVoidTy(), { builder.getInt32Ty() }, false);
    auto fooFunc = llvm::Function::Create(fooType, llvm::Function::ExternalLinkage, "foo", *module);
    llvm::sys::DynamicLibrary::AddSymbol("foo", reinterpret_cast<void *>(foo));

    auto getIntType = llvm::FunctionType::get(builder.getInt32Ty(), false);
    auto getIntFunc = llvm::Function::Create(getIntType,
                                             llvm::Function::ExternalLinkage, "getInt", *module);
    llvm::sys::DynamicLibrary::AddSymbol("getInt", reinterpret_cast<int *>(getInt));


    auto mainType = llvm::FunctionType::get(builder.getInt32Ty(), false);
    auto mainFunc = llvm::Function::Create(mainType, llvm::GlobalValue::LinkageTypes::ExternalLinkage,
                                           "myFunction", *module);

    auto three = ConstantInt::get(Type::getInt32Ty(context), 3);
    auto entryBlock = llvm::BasicBlock::Create(context, "entry", mainFunc);
    CallInst::Create(fooFunc, { three }, "", entryBlock);
    auto callInst = CallInst::Create(getIntFunc, "result", entryBlock);
    /* auto retInst = */ ReturnInst::Create(context, callInst, entryBlock);

    return { std::move(module), mainFunc };
}

int main() {
    auto llvmContext = LLVMContext();
    auto ctx = createMain(llvmContext);

    std::string error;
    llvm::raw_string_ostream error_os(error);
    if (llvm::verifyModule(*ctx.module, &error_os)) {
        std::cerr << "Module Error: " << error << '\n';
        ctx.module->print(error_os, nullptr);
        std::cerr << error << std::endl;
        return 1;
    }

    errs() << "Module:\n" << *ctx.module;
    auto engine = llvm::EngineBuilder(std::move(ctx.module))
            .setErrorStr(&error)
            .setOptLevel(llvm::CodeGenOpt::Aggressive)
            .setEngineKind(llvm::EngineKind::JIT)
            .create();

    if (!engine) {
        std::cerr << "EE Error: " << error << '\n';
        return 1;
    }
    engine->finalizeObject();

    std::vector<GenericValue> NoArgs(0);
    std::cout << "Calling" << std::endl;
    GenericValue val = engine->runFunction(ctx.mainFunction, NoArgs);
    outs() << val.IntVal << '\n';
    std::cout << "OK" << std::endl;

    return 0;
}