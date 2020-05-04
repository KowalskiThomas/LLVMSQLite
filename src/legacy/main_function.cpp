#include "vdbe_exec.h"
#include "type_definitions.h"

// Function* printIntFunc;
// FunctionType* printIntType;

void createLlvmTypes(LLVMContext& context) {
    // Types we use
    intTy = IntegerType::getInt32Ty(context);
    fltTy = IntegerType::getFloatTy(context);
    bitTy = IntegerType::getInt1Ty(context);

}

my_context createMain(LLVMContext& context, Vdbe* vdbe) {
    createLlvmTypes(context);

    // Initialise JIT
    InitializeNativeTarget();
    InitializeNativeTargetAsmPrinter();
    InitializeNativeTargetAsmParser();

    // Our module
    auto module = std::make_unique<llvm::Module>("top", context);
    IRBuilder<> builder(context);

    // The main function executed by the JIT
    auto mainType = FunctionType::get(builder.getInt32Ty(), {  }, false);
    auto mainFunc = Function::Create(
            mainType,
            GlobalValue::LinkageTypes::ExternalLinkage,
            "jitMain",
            *module
    );

    // The entry block in the main function
    auto entryBlock = BasicBlock::Create(context, "entry", mainFunc);

    // Get the arguments passed to the JITted function and use
    // auto args = mainFunc->arg_begin();
    // Value* treeArgument = args++;

    // Generate all blocks (for each instruction) and all registers (stack variables)
    my_context::BlocksMap blocks;
    my_context::ParametersMap parameters;
    for(size_t i = 0; i < vdbe->nOp; i++) {
        blocks[i] = BasicBlock::Create(context, "Instr" + std::to_string(i), mainFunc);
        std::string name = "I" + std::to_string(i) + "P";
        parameters[i] = {
                { 1, new AllocaInst(intTy, 0, name + std::to_string(1), entryBlock) },
                { 2, new AllocaInst(intTy, 0, name + std::to_string(2), entryBlock) },
                { 3, new AllocaInst(intTy, 0, name + std::to_string(3), entryBlock) },
                { 4, new AllocaInst(intTy, 0, name + std::to_string(4), entryBlock) },
        };
    }

    my_context::RegsMap registers;
    for(size_t i = 0; i < 100; i++) {
        registers[i] = new AllocaInst(T::sqlite3_valuePtrTy, 0, "Reg" + std::to_string(i), entryBlock);
    }

    // Return our Context
    return my_context(vdbe, std::move(module), mainFunc, context, entryBlock, nullptr, std::move(blocks), std::move(registers), std::move(parameters));

    std::cout << "ok <" << std::endl;
}
