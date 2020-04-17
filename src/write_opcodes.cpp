#include "thomas.h"
#include "type_definitions.h"

#include <cassert>

Value* SOne;
Value* SThirtyTwo;
Value* SZero;
Value* STwo;


static inline void writeInit(my_context& ctx, Op& op, const size_t pc, BasicBlock* const block) {
    // auto i = new AllocaInst(intTy, 0, "i", block);
    auto p1 = ctx.parameters[pc][1];
    assert(p1);

    /// if (pOp->p1 >= sqlite3GlobalConfig.iOnceResetThreshold)
    SThirtyTwo = ConstantInt::get(intTy, 32);
    SOne = ConstantInt::get(intTy, 1);
    SZero = ConstantInt::get(intTy, 0);
    STwo = ConstantInt::get(intTy, 2);
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

/**
 * Creates the code to update the flags in a register
 * @param c the context
 * @param llvmPMem a pointer to the sqlite3_value struct to modify
 * @param block the basic block
 * @param f the new flags value
 */
void JitMemSetTypeFlag(my_context& c, Value* llvmPMem, BasicBlock* block, u16 f) {
    auto tmpAddr = GetElementPtrInst::Create(nullptr, llvmPMem, { SZero, SOne }, "flagsAddress", block);
    auto flagsAddress = CastInst::Create(Instruction::CastOps::BitCast, tmpAddr, T::i16PtrTy, "flagsAddress", block);
    new StoreInst(ConstantInt::get(T::i16Ty, f), flagsAddress, block);
}

#include "jit_utils.h"

/**
 * Gets the current value of flags in a given sqlite3_value
 * @param c the context
 * @param llvmPMem a pointer in the form of an LLVM Value* to the sqlite3_value to read
 * @param block the current basic block
 * @return the register in which flags were read
 */
auto JitMemCurrentFlags(my_context& c, Value* llvmPMem, BasicBlock* block) -> Value* {
    auto flagsAddress = GetElementPtrInst::Create(nullptr, llvmPMem, { SZero, SOne }, "flagsAddress", block);
    auto loadInst = new LoadInst(T::i16Ty, flagsAddress, "flags", block);
    return loadInst;
}

FunctionType* integerValueType;
Function* integerValue;

auto JitVdbeIntegerValue(my_context& c) {
    integerValueType = FunctionType::get(T::i64Ty, { T::sqlite3_valuePtrTy }, false);
    integerValue = Function::Create(integerValueType, GlobalValue::LinkageTypes::ExternalLinkage, "integerValue", *c.module);

    auto block = BasicBlock::Create(c.context, "entry", integerValue);
    auto args = integerValue->arg_begin();
    Value* llvmPMem = args++;
    auto flags = JitMemCurrentFlags(c, llvmPMem, block);

    auto MemIntOrMemIntReal = ConstantInt::get(T::i16Ty, MEM_Int | MEM_IntReal);
    auto MemReal = ConstantInt::get(T::i16Ty, MEM_Real);
    auto MemStrOrMemBlob = ConstantInt::get(T::i16Ty, MEM_Str | MEM_Blob);

    auto Zero16 = ConstantInt::get(T::i16Ty, 0);

    auto result = new AllocaInst(T::i64Ty, 0, "resultingInt", block);

    auto isIntOrIntReal = BinaryOperator::CreateAnd(flags, MemIntOrMemIntReal, "isMemIntOrMemIntReal", block);
    auto isIntOrIntReal1 = ICmpInst::Create(Instruction::OtherOps::ICmp, CmpInst::ICMP_EQ, isIntOrIntReal, Zero16, "isIntOrIntReal1", block);

    auto isReal = BinaryOperator::CreateAnd(flags, MemReal, "isMemReal", block);
    auto isReal1 = ICmpInst::Create(Instruction::OtherOps::ICmp, CmpInst::ICMP_EQ, isReal, Zero16, "isReal1", block);

    auto isStringOrBlob = BinaryOperator::CreateAnd(flags, MemStrOrMemBlob, "isMemStrOrMemBlob", block);
    auto isStringOrBlob1 = ICmpInst::Create(Instruction::OtherOps::ICmp, CmpInst::ICMP_EQ, isStringOrBlob, Zero16, "isStringBlob1", block);

    auto BlockIntOrIntReal = BasicBlock::Create(c.context, "BlockIntOrIntReal", integerValue);
    auto BlockIsNotIntNotIntReal = BasicBlock::Create(c.context, "BlockIsNotIntNotIntReal", integerValue);
    auto BlockReal = BasicBlock::Create(c.context, "BlockReal", integerValue);
    auto BlockNotReal = BasicBlock::Create(c.context, "BlockNotReal", integerValue);
    auto BlockStrOrBlob = BasicBlock::Create(c.context, "BlockStrOrBlob", integerValue);
    auto BlockNotStrNorBlob = BasicBlock::Create(c.context, "BlockNotStrNorBlob", integerValue);
    auto BlockEnd = BasicBlock::Create(c.context, "BlockEnd", integerValue);

    // If Int or IntReal then jump to BlockIntOrIntReal else BlockIsNotIntNotIntReal
    BranchInst::Create(BlockIntOrIntReal, BlockIsNotIntNotIntReal, isIntOrIntReal1, block);
    auto unionAddress = GetElementPtrInst::Create(nullptr, llvmPMem, { SZero, SZero }, "unionAddress", BlockIntOrIntReal);
    auto unionAddress2 = CastInst::Create(Instruction::CastOps::BitCast, unionAddress, T::i64PtrTy, "unionAddress", BlockIntOrIntReal);
    auto unionValue = new LoadInst(T::i64Ty, unionAddress2, "unionValue", BlockIntOrIntReal);
    new StoreInst(unionValue, result, BlockIntOrIntReal);
    BranchInst::Create(BlockEnd, BlockIntOrIntReal);

    // Int Real jump to BlockReal else BlockNotReal
    BranchInst::Create(BlockReal, BlockNotReal, isReal1, BlockIsNotIntNotIntReal);
    // TODO: doubleToInt64
    BranchInst::Create(BlockEnd, BlockReal);

    // If Str or Blob jump to BlockStrBlob
    BranchInst::Create(BlockStrOrBlob, BlockNotStrNorBlob, isStringOrBlob1, BlockNotReal);
    // TODO: memIntValue
    BranchInst::Create(BlockEnd, BlockStrOrBlob);

    // If no compatible type
    auto Null = ConstantInt::get(T::i64Ty, 0);
    new StoreInst(Null, result, BlockNotStrNorBlob);
    BranchInst::Create(BlockEnd, BlockNotStrNorBlob);

    auto resultValue = new LoadInst(T::i64Ty, result, "resultIntValue", BlockEnd);
    ReturnInst::Create(c.context, resultValue, BlockEnd);
}

void JitVdbeMemIntegerify(my_context& c, Value* llvmPMem, BasicBlock* block) {
    auto currentValue = CallInst::Create(integerValueType, integerValue, { llvmPMem }, "integerValue", block);
    auto unionAddress = GetElementPtrInst::Create(nullptr, llvmPMem, { SZero, SZero }, "unionAddress", block);
    auto unionAddress2 = CastInst::Create(Instruction::CastOps::BitCast, unionAddress, T::i64PtrTy, "unionAddress2", block);
    new StoreInst(currentValue, unionAddress2, block);
    JitMemSetTypeFlag(c, llvmPMem, block, MEM_Int);
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

    JitVdbeIntegerValue(ctx);

    auto i32Ty = IntegerType::get(ctx.context, 32);
    auto i16Ty = IntegerType::get(ctx.context, 16);
    auto i8Ty = IntegerType::get(ctx.context, 8);
    auto i1Ty = IntegerType::get(ctx.context, 1);
    auto i8PtrTy = PointerType::get(i8Ty, 0);

    auto ARR = ArrayType::get(i8Ty, 1);

    // nField = 0;
    auto nField = new AllocaInst(intTy, 0, "nField", block);
    new StoreInst(SZero, nField, block);
    // pKeyInfo = 0
    auto pKeyInfo = new AllocaInst(T::KeyInfoPtrTy, 0, "pKeyInfo", block);
    auto temp = IntToPtrInst::Create(Instruction::CastOps::IntToPtr, SZero, T::KeyInfoPtrTy, "temp", block);
    new StoreInst(temp, pKeyInfo, block);
    // p2 = pOp->p2; stays constant
    auto p2Val = ctx.vdbe->aOp[pc].p2;
    auto p2 = new AllocaInst(T::i32Ty, 0, "p2", block);
    new StoreInst(ConstantInt::get(T::i32Ty, p2Val), p2, block);
    // pDb = &db->aDb[iDb];
    auto iDb = ctx.vdbe->aOp[pc].p3;
    auto pDb = &ctx.vdbe->db->aDb[iDb];
    auto pX = pDb->pBt;
    // TODO: OpenWrite for wrFlag
    auto wrFlag = 0;
    auto p5 = ctx.vdbe->aOp[pc].p5;
    if (p5 & OPFLAG_P2ISREG || true) {
        // pIn2 = &aMem[p2];
        auto pIn2 = ctx.registers[p2Val];
        pIn2 = new AllocaInst(T::sqlite3_valuePtrTy, 0, "testtest", block);
        new StoreInst(CastInst::Create(Instruction::CastOps::IntToPtr, ConstantInt::get(T::i64Ty, 0), T::sqlite3_valuePtrTy, "", block), pIn2, block);
        auto llvmPMem = new LoadInst(T::sqlite3_valuePtrTy, pIn2, "pMem", block);
        JitVdbeMemIntegerify(ctx, llvmPMem, block);
        auto unionAddress = GetElementPtrInst::Create(nullptr, llvmPMem, { SZero, SZero }, "unionAddressDbg", block);
        auto valueStoredInP2Reg = CastInst::CreateIntegerCast(
                new LoadInst(T::i64Ty, unionAddress, "p2", block),
                T::i32Ty, true, "", block);
        new StoreInst(valueStoredInP2Reg, p2, block);
    }
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
