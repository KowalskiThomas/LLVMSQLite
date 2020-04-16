#include "thomas.h"
#include "type_definitions.h"

#include <cassert>

Value* SOne;
Value* SThirtyTwo;
Value* SZero;


static inline void writeInit(my_context& ctx, Op& op, const size_t pc, BasicBlock* const block) {
    // auto i = new AllocaInst(intTy, 0, "i", block);
    auto p1 = ctx.parameters[pc][1];
    assert(p1);

    /// if (pOp->p1 >= sqlite3GlobalConfig.iOnceResetThreshold)
    SThirtyTwo = ConstantInt::get(intTy, 32);
    SOne = ConstantInt::get(intTy, 1);
    SZero = ConstantInt::get(intTy, 0);
    // TODO: Use sqlite3GlobalConfig.iOnceResetThreshold
    // auto cmpResult = CmpInst::Create(Instruction::OtherOps::ICmp, CmpInst::Predicate::ICMP_SGT, p1, SThirtyTwo, "cmpResult", block);
    // auto outerTrueBlock = BasicBlock::Create(ctx.context, "outerTrueBlock", ctx.mainFunction);
    // auto outerFalseBlock = BasicBlock::Create(ctx.context, "outerFalseBlock", ctx.mainFunction);
    // BranchInst::Create(outerTrueBlock, outerFalseBlock, cmpResult, block);

    if (op.opcode == OP_Trace) {
        /// break;
        BranchInst::Create(ctx.blocks[pc + 1], block);
    } else {
        for(int i = 1; i < ctx.vdbe->nOp; i++) {
            if (ctx.vdbe->aOp[i].opcode == OP_Once) {
                new StoreInst(SZero, ctx.parameters[i][1], block);
            }
        }
        new StoreInst(SZero, ctx.parameters[0][1], block);
        // TODO: p->aCounter[SQLITE_STMTSTATUS_RUN]++;

        /// goto jump_to_p2;
        /// pOp = &aOp[pOp->p2 - 1];
        // auto p2value = new LoadInst(intTy, ctx.parameters[pc][2], "jumpToP2Val", outerTrueBlock);
        auto p2Value = ctx.vdbe->aOp[pc].p2;
        auto instrNumber = p2Value - 1;
        auto jumpTo = ctx.blocks[instrNumber];
        BranchInst::Create(jumpTo, block);
    }
}

static inline void writeOpenRead(my_context& ctx, Op& op, const size_t pc, BasicBlock* const block) {
    /* TODO
     * if (p->expired == 1) {
     *     rc = SQLITE_ABORT_ROLLBACK;
     *     goto abort_due_to_error;
     * }
     */

    /**
    int nField;
    KeyInfo *pKeyInfo;
    int p2;
    int iDb;
    int wrFlag;
    Btree *pX;
    VdbeCursor *pCur;
    Db *pDb;
    */

    auto i32Ty = IntegerType::get(ctx.context, 32);
    auto i16Ty = IntegerType::get(ctx.context, 16);
    auto i8Ty = IntegerType::get(ctx.context, 8);
    auto i1Ty = IntegerType::get(ctx.context, 1);
    auto i8PtrTy = PointerType::get(i8Ty, 0);

    auto ARR = ArrayType::get(i8Ty, 1);

    // auto KeyInfoTy = StructType::create(ctx.context, { i32Ty, i8Ty, i16Ty, i16Ty, ARR, i8PtrTy, ARR }, "KeyInfo");
    // auto KeyInfoPtrTy = PointerType::get(KeyInfoTy, 0);

    auto nField = new AllocaInst(intTy, 0, "nField", block);
    new StoreInst(SZero, nField, block);
    auto pKeyInfo = new AllocaInst(T::KeyInfoPtrTy, 0, "pKeyInfo", block);
}

void writeInstruction(my_context& ctx, size_t pc) {
    auto op = ctx.vdbe->aOp[pc];
    auto block = ctx.blocks[pc];
    switch(op.opcode) {
        case OP_Init:
            writeInit(ctx, op, pc, block);
            break;
        case OP_OpenRead:
            writeOpenRead(ctx, op, pc, block);
            break;
    }

    if (pc < ctx.vdbe->nOp - 1 && op.opcode != OP_Jump && op.opcode != OP_Init)
        BranchInst::Create(ctx.blocks[pc + 1], ctx.blocks[pc]);
}
