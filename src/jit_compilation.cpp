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

using namespace llvm;
using namespace orc;

enum opcode {
    op_add,
    op_set,
    op_jump,
    op_halt,
    op_lt,
    op_init
};

struct instr {
    opcode opCode;
    int p1;
    int p2;
    int p3;
    int p4;
};
using prog = std::vector<instr>;

int getInt() {
    return 31415;
}

void print_int(int x) {
    std::cout << "PRINTING " << x << std::endl;
}

typedef struct {
    int i;
    float f;
    int b:1;
} myStruct;

struct tree {
    std::map<int, std::string> map;
};

void printAgg(myStruct* s) {
    std::cout << "Value of f : " << s->f << " Value of b : " << s->b << std::endl;
}

void printTree(tree* t) {
    std::cout << "I print trees" << std::endl;
    for(auto &x : t->map) {
        std::cout << '\t' << x.first << " -> " << x.second << std::endl;
    }
};

struct my_context {
    // The LLVM module
    std::unique_ptr<Module> module;
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
};

Function* printIntFunc;
FunctionType* printIntType;

my_context createMain(LLVMContext& context, const prog& p) {
    // Initialise JIT
    InitializeNativeTarget();
    InitializeNativeTargetAsmPrinter();
    InitializeNativeTargetAsmParser();

    // Types we use
    auto intTy = IntegerType::getInt32Ty(context);
    auto fltTy = IntegerType::getFloatTy(context);
    auto bitTy = IntegerType::getInt1Ty(context);

    // Our module
    auto module = std::make_unique<Module>("top", context);
    IRBuilder<> builder(context);

    // The print_int function (defined in C++)
    printIntType = FunctionType::get(builder.getVoidTy(), { builder.getInt32Ty() }, false);
    printIntFunc = Function::Create(printIntType, Function::ExternalLinkage, "print_int", *module);
    sys::DynamicLibrary::AddSymbol("print_int", reinterpret_cast<void *>(print_int));

    // The getInt function (allows to return an int) (defined in C++)
    auto getIntType = FunctionType::get(builder.getInt32Ty(), false);
    auto getIntFunc = Function::Create(getIntType, Function::ExternalLinkage, "getInt", *module);
    sys::DynamicLibrary::AddSymbol("getInt", reinterpret_cast<int *>(getInt));

    // The tree structure type (opaque aggregate type)
    auto treeType = StructType::create(context, "tree");
    // And pointer-to-tree type
    auto treePointerType = PointerType::get(treeType, 0);

    // The main function executed by the JIT
    auto mainType = FunctionType::get(builder.getInt32Ty(), { treePointerType }, false);
    auto mainFunc = Function::Create(mainType, GlobalValue::LinkageTypes::ExternalLinkage, "jitMain", *module);

    // The printTree function (defined in C++), takes a pointer-to-tree-structure as a parameter
    auto printTreeType = FunctionType::get(builder.getVoidTy(), { treePointerType }, false);
    auto printTreeFunc = Function::Create(printTreeType, GlobalValue::LinkageTypes::ExternalLinkage, "printTree", *module);
    sys::DynamicLibrary::AddSymbol("printTree", reinterpret_cast<void *>(printTree));

    // The entry block in the main function
    auto entryBlock = BasicBlock::Create(context, "entry", mainFunc);

    // Get the arguments passed to the JITted function and use
    auto args = mainFunc->arg_begin();
    Value* treeArgument = args++;
    // And use them in a call to printTree
    CallInst::Create(printTreeType, printTreeFunc, { treeArgument }, "", entryBlock);

    // An explicitly defined aggregate type
    Type* structType = StructType::create(context, { intTy, fltTy, bitTy }, "myAggregateType");
    // Allocate an aggregate of the newly defined type
    Value* s = new AllocaInst(structType, 0, "myAggregate", entryBlock);

    // Constants
    auto zero = ConstantInt::get(intTy, 0, false);
    auto one = ConstantInt::get(intTy, 1, false);
    auto two = ConstantInt::get(intTy, 2, false);

    // Pointer-to-FP in our aggregate
    auto fltPtr = GetElementPtrInst::Create(nullptr, s, { zero, one }, "ptrToFloat", entryBlock);

    // The pi FP constant
    auto pi = ConstantFP::get(fltTy, 3.1415926);
    // Store it in the pointer we got from the aggregate earlier on
    new StoreInst(pi, fltPtr, entryBlock);

    // Add a function that takes a pointer-to-aggregate as a parameter
    auto aggrPtrTy = PointerType::get(structType, 0);
    auto aggrFunType = FunctionType::get(builder.getVoidTy(), { aggrPtrTy }, false);
    auto aggrFunFunc = Function::Create(aggrFunType, GlobalValue::LinkageTypes::ExternalLinkage, "printAgg", *module);
    sys::DynamicLibrary::AddSymbol("printAgg", reinterpret_cast<void *>(printAgg));

    // Call discussed function
    CallInst::Create(aggrFunType, aggrFunFunc, { s }, "", entryBlock);

    // Generate all blocks (for each instruction) and all registers (stack variables)
    my_context::BlocksMap blocks;
    my_context::RegsMap registers;
    for(size_t i = 0; i < p.size(); i++) {
        blocks[i] = BasicBlock::Create(context, "Instr" + std::to_string(i), mainFunc);
        registers[i] = new AllocaInst(intTy, 0, "Reg" + std::to_string(i), entryBlock);
    }

    // Return our Context
    return {
        .module =  std::move(module),
        .mainFunction = mainFunc,
        .context = context,
        .entry = entryBlock,
        .blocks = std::move(blocks),
        .registers = std::move(registers),
    };
}

void createReg(my_context& ctx, size_t reg) {
    if (ctx.registers.count(reg) == 0)
        ctx.registers[reg] = new AllocaInst(
                IntegerType::getInt32Ty(ctx.context), 0, "Reg" + std::to_string(reg), ctx.entry);
}

void writeInstruction(my_context& ctx, prog p, size_t pc) {
    auto ins = p[pc];
    auto intTy = IntegerType::getInt32Ty(ctx.context);
    switch(ins.opCode) {
        case op_add: {
            auto regDest = ins.p1;
            auto val = ins.p2;
            createReg(ctx, regDest);
            auto result = BinaryOperator::CreateAdd(
                    ConstantInt::get(intTy, val),
                    new LoadInst(intTy, ctx.registers[regDest], "", ctx.blocks[pc]),
                    "result", ctx.blocks[pc]);
            new StoreInst(result, ctx.registers[regDest], ctx.blocks[pc]);
            break;
        }
        case op_set: {
            auto toReg = ins.p1;
            auto val = ins.p2;
            createReg(ctx, toReg);
            new StoreInst(ConstantInt::get(intTy, val), ctx.registers[toReg], ctx.blocks[pc]);
            break;
        }
        case op_jump: {
            auto reg = ins.p1;
            auto jumpTo = ins.p2;
            createReg(ctx, reg);
            auto compVal = new LoadInst(intTy, ctx.registers[reg], "compVal", ctx.blocks[pc]);
            auto b = ICmpInst::Create(Instruction::OtherOps::ICmp, CmpInst::Predicate::ICMP_NE,
                    compVal, ConstantInt::get(intTy, 0), "b", ctx.blocks[pc]);
            auto test32 = CastInst::Create(Instruction::CastOps::ZExt, b, intTy, "test32", ctx.blocks[pc]);
            BranchInst::Create(ctx.blocks[jumpTo], ctx.blocks[pc + 1], b, ctx.blocks[pc]);
            break;
        }
        case op_halt:
            BranchInst::Create(ctx.end, ctx.blocks[pc]);
            break;
        case op_lt: {
            auto lhs = ctx.registers[ins.p1];
            auto result = ctx.registers[ins.p2];
            auto rhs = ctx.registers[ins.p3];

            auto val_lhs = new LoadInst(intTy, lhs, "lhs", ctx.blocks[pc]);
            auto val_rhs = new LoadInst(intTy, rhs, "rhs", ctx.blocks[pc]);
            auto compVal = ICmpInst::Create(Instruction::OtherOps::ICmp, CmpInst::Predicate::ICMP_SLT,
                    val_lhs, val_rhs, "result", ctx.blocks[pc]);
            auto compVal32 = CastInst::Create(Instruction::CastOps::ZExt, compVal, intTy, "resulti32", ctx.blocks[pc]);
            // CallInst::Create(printIntType, printIntFunc, { compVal32 }, "", ctx.blocks[pc]);
            new StoreInst(compVal32, result, ctx.blocks[pc]);
            break;
        }
        case op_init:
            break;
    }

    if (pc < p.size() - 1 && ins.opCode != op_jump)
        BranchInst::Create(ctx.blocks[pc + 1], ctx.blocks[pc]);
}

int do_jit() {
    auto p = prog{
            {op_init},
            {op_set,  1, 1},         // 1 Initial value of R1 is 1
            {op_set,  2, 4},         // 2 Initial value of R2 is 4
            {op_add,  1, 1},         // 3 R1 = 1 + R1
            {op_lt,   1, 3, 2}, // 4 R3 = R1 < R2
            {op_jump, 3, 3},         // 5 If R3 GoTo 3
            {op_halt}                         // End
    };

    auto llvmContext = LLVMContext();
    auto ctx = createMain(llvmContext, p);
    auto intTy = IntegerType::getInt32Ty(ctx.context);
    ctx.end = BasicBlock::Create(llvmContext, "end", ctx.mainFunction);
    auto firstRegVal = new LoadInst(intTy, ctx.registers[1], "regVal", ctx.end);
    ReturnInst::Create(llvmContext, firstRegVal, ctx.end);

    for (size_t pc = 0; pc < p.size(); pc++)
        writeInstruction(ctx, p, pc);

    BranchInst::Create(ctx.blocks[0], ctx.entry);

    std::string module_str;
    raw_string_ostream module_stream(module_str);
    ctx.module->print(module_stream, nullptr);
    std::cout << module_str << std::endl;
    std::cout << "------------------------------------------------------------" << std::endl;

    std::string error;
    raw_string_ostream error_os(error);
    if (verifyModule(*ctx.module, &error_os)) {
        std::cerr << "Module Error: " << error << '\n';
        std::cerr << error << std::endl;
        return 1;
    }

    auto engine = EngineBuilder(std::move(ctx.module))
            .setErrorStr(&error)
            .setOptLevel(CodeGenOpt::Aggressive)
            .setEngineKind(EngineKind::JIT)
            .create();

    if (!engine) {
        std::cerr << "EE Error: " << error << '\n';
        return 1;
    }
    engine->finalizeObject();

    tree myTree;
    myTree.map[123] = "thomas";

    std::cout << "Calling" << std::endl;
    auto mainFunction = reinterpret_cast<int(*)(tree*)>(engine->getFunctionAddress("jitMain"));
    auto result = mainFunction(&myTree);
    std::cout << "Result of function: " << result << std::endl;
    std::cout << "OK" << std::endl;

    return 0;
}

int main() {
    do_jit();
    return 0;
}