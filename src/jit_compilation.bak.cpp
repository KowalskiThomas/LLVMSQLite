#include <iostream>
#include <string>

#include <cmath>
#include <unordered_map>
#include <llvm/ExecutionEngine/ExecutionEngine.h>
#include <thirdparty/codegen/include/codegen/statements.hpp>

#include "thirdparty/codegen/include/codegen/compiler.hpp"
#include "thirdparty/codegen/include/codegen/module_builder.hpp"
#include "thirdparty/codegen/include/codegen/module.hpp"
#include "thirdparty/codegen/include/codegen/variable.hpp"
#include "thirdparty/codegen/include/codegen/literals.hpp"
#include "thirdparty/codegen/include/codegen/builtin.hpp"
#include "thirdparty/codegen/include/codegen/arithmetic_ops.hpp"

int func() {
    return 2;
}

// extern "C" {

namespace cg = codegen;

using function_pointer_type = int (*)(int);
/*
struct Context {
    codegen::compiler c;
    cg::module_builder builder;

    Context()
            :
            c{},
            builder{c, "module_name"}
    {
    }
};
*/

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

int main() {
    // Context context;
    codegen::compiler c;
    cg::module_builder builder(c, "my_module");

    std::vector<instr> instructions = {
            { op_init },
            { op_set, 2, 5 },
            { op_add, 1, 2, 1 },
            { op_add, 1, 2, 1 },
            { op_add, 1, 2, 1 },
            { op_jump, 6 },
            { op_add, 1, 2, 1 },
            { op_add, 1, 2, 1 },
            { op_halt, 2 }
    };

    llvm::LLVMContext& ctx = *builder.context_;
    auto function_reference = builder.create_function<int(int)>(
            "function_name",
            [&instructions, &ctx](cg::value<int> v) {
                // llvm::FunctionType* intOfVoid = llvm::FunctionType::get(llvm::Type::getInt32Ty(ctx), {}, false);
                // llvm::Function* f = llvm::Function::Create(
                //         intOfVoid, // Function type
                //         llvm::GlobalValue::LinkageTypes::ExternalLinkage, // Linkage
                //         "func", // Function name
                //         nullptr // Module
                // );

                // This does not change anything to the issue:
                // f->setCallingConv(llvm::CallingConv::C);

                // auto func = cg::function_ref<int>("func", f);

                // This line is the culprit:
                // cg::value returned = cg::call(func);

                using var = cg::variable<int>;

                size_t N = 128;
                // auto regs = (var*)malloc(N * sizeof(var));
                std::vector<var*> registers(N, nullptr);
                auto zero = cg::constant<int>(0);
                for(size_t i = 0; i < N; i++) {
                    registers[i] = new var(std::string{"Reg"} + std::to_string(i), zero);
                }

                cg::variable<bool> b("b", false);
                cg::variable<int> integer("i", 123);
                cg::variable<int> targetVar("target", 125);
                cg::value<int> target = targetVar.get();
                for(size_t i = 0; i < instructions.size(); i++) {
                    auto& instr = instructions[i];
                    auto var = cg::variable<unsigned>("var", cg::constant<unsigned>(0));
                    switch (instr.opCode) {
                        case op_add:
                            registers[instr.p1]->set(registers[instr.p1]->get() + registers[instr.p2]->get());
                            break;
                        case op_set:
                            registers[instr.p1]->set(cg::constant<int>(instr.p2));
                            break;
                        case op_gt:
                            cg::while_([&] { return var.get() < target; },
                                       [&] {
                                           var.set(var.get() + cg::constant<unsigned>(1));
                                       });
                            // cg::if_([&] { return integer.get() < target; },
                            //         [&] { registers[instr.p2]->set(cg::constant<int>(1)); });
                                    // [&] { registers[instr.p2]->set(cg::constant<int>(0)); });
                        case op_jump:
                            i = instr.p1;
                            break;
                        case op_halt:
                            cg::return_(registers[instr.p1]->get());
                        case op_init:
                            break;
                    }
                }

                // cg::variable<int> var("var");
                // var.set(zero);

                // cg::variable<int> var2("var");
                // var2.set(var.get() + cg::constant<int>(124));

                // cg::return_(v + returned);
                // cg::return_(var2.get());
            });

    std::cout << "Building" << std::endl;

    std::cout << builder << std::endl;

    auto module = std::move(builder).build();
    std::cout << "Getting main function address" << std::endl;
    function_pointer_type function_pointer = module.get_address(function_reference);
    std::cout << "Call" << std::endl;
    std::cout << function_pointer(5) << std::endl;
    func();
    return 0;
}
