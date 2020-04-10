#include "thomas.h"

void writeInstruction(my_context& ctx, size_t pc) {
    auto op = ctx.vdbe->aOp[pc];
    auto block = ctx.blocks[pc];
    switch(op.opcode) {
    }

    if (pc < ctx.vdbe->nOp - 1 && op.opcode != OP_Jump)
        BranchInst::Create(ctx.blocks[pc + 1], ctx.blocks[pc]);
}
