#include "thomas.h"

Type* intTy = nullptr;
Type* fltTy = nullptr;
Type* bitTy = nullptr;

extern "C" {

int sqlite3VdbeExec(Vdbe *p) {
    auto llvmContext = LLVMContext();
    auto ctx = createMain(llvmContext, p);
    ctx.end = BasicBlock::Create(llvmContext, "end", ctx.mainFunction);
    load_type_definitions(ctx);

    auto firstRegVal = new LoadInst(intTy, ctx.registers[1], "regVal", ctx.end);
    ReturnInst::Create(llvmContext, firstRegVal, ctx.end);

    for (size_t pc = 0; pc < p->nOp; pc++)
        writeInstruction(ctx, pc);

    BranchInst::Create(ctx.blocks[0], ctx.entry);
    BranchInst::Create(ctx.end, ctx.blocks[p->nOp - 1]);

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

    std::cout << "Calling" << std::endl;
    auto mainFunction = reinterpret_cast<int(*)()>(engine->getFunctionAddress("jitMain"));
    auto result = mainFunction();
    std::cout << "Result of function: " << result << std::endl;
    std::cout << "OK" << std::endl;

    return SQLITE_OK;
}

}
