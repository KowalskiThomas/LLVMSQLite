#include "vdbe_exec.h"

Type* intTy = nullptr;
Type* fltTy = nullptr;
Type* bitTy = nullptr;

extern "C" {

int sqlite3VdbeExec(Vdbe *p) {
    auto llvmContext = LLVMContext();
    load_type_definitions(llvmContext);
    auto ctx = createMain(llvmContext, p);
    load_function_definitions(ctx);
    ctx.end = BasicBlock::Create(llvmContext, "end", ctx.mainFunction);

    auto firstRegVal = new LoadInst(intTy, ctx.registers[1], "regVal", ctx.end);
    ReturnInst::Create(llvmContext, firstRegVal, ctx.end);

    for (size_t pc = 0; pc < p->nOp; pc++)
        writeInstruction(ctx, pc);

    BranchInst::Create(ctx.blocks[0], ctx.entry);
    BranchInst::Create(ctx.end, ctx.blocks[p->nOp - 1]);

    print_module(ctx.module, false);
    std::cout << "------------------------------------------------------------" << std::endl;

    std::string error;
    raw_string_ostream error_os(error);
    if (verifyModule(*ctx.module, &error_os)) {
        std::cerr << "Module Error: " << error << '\n';
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

    std::cout << "Calling" << std::endl;
    auto mainFunction = reinterpret_cast<int(*)()>(engine->getFunctionAddress("jitMain"));
    auto result = mainFunction();
    std::cout << "Result of function: " << result << std::endl;
    std::cout << "OK" << std::endl;

    return SQLITE_OK;
}

}