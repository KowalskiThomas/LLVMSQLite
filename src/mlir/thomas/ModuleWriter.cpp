#include <unordered_map>

#include "Standalone/Lowering/MyBuilder.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/ConstantManager.h"
#include "Standalone/StandaloneDialect.h"
#include "Standalone/StandaloneOps.h"
#include "Standalone/StandalonePasses.h"
#include "Standalone/TypeDefinitions.h"
#include "Standalone/Lowering/Printer.h"
#include "Standalone/VdbeContext.h"
#include "Standalone/ErrorCodes.h"
#include "Standalone/DefaultImplementation.h"
#include "Standalone/DebugUtils.h"

#include "SQLiteBridge.h"

#include "vdbe.h"

#define INTEGER_ATTR(width, signed, value) opBuilder.getIntegerAttr(opBuilder.getIntegerType(width, signed), value)

using mlir::MLIRContext;
using mlir::LLVM::LLVMDialect;
using mlir::ModuleOp;
using mlir::FuncOp;
using mlir::BranchOp;

using namespace mlir::standalone;

using mlir::Block;
using mlir::Operation;

using std::pair;
using llvm::SmallVector;
using std::unordered_map;

namespace VdbeOps = mlir::standalone;

void writeFunction(MLIRContext& mlirContext, LLVMDialect* llvmDialect, FuncOp& func) {
    // A pointer to the MLIR Context
    auto ctx = &mlirContext;
    // The StandaloneDialect instance
    auto vdbeDialect = mlirContext.getRegisteredDialect<StandaloneDialect>();
    // A pointer to the VdbeContext instance we use for this query
    auto* vdbeCtx = &vdbeDialect->vdbeContext;
    vdbeCtx->mainFunction = func;

    // The Vdbe instance we use for this query
    auto* vdbe = vdbeCtx->vdbe;

    // All the blocks / operations we have already translated
    auto& blocks = vdbeCtx->blocks;

    // Operations that depend on a block that has not yet been built.
    // This map should be checked for at the end of every block / operation translation to update jumps.
    unordered_map<size_t, SmallVector<pair<Operation*, size_t>, 128>> operations_to_update;

    // Create an OpBuilder and make it write in the function's newly created entryBlock
    auto opBuilder = mlir::OpBuilder(ctx);
    auto& rewriter = opBuilder;
    auto* entryBlock = func.addEntryBlock();
    vdbeCtx->entryBlock = entryBlock;
    opBuilder.setInsertionPointToStart(entryBlock);

    // A handy tool for generating constants (constant integers, nullptr's...)
    ConstantManager constants(opBuilder, ctx);

    // A handy tool for printing stuff at run-time
    mlir::Printer print(ctx, opBuilder, __FILE_NAME__);

    using namespace mlir;
    auto builder = MyBuilder(ctx, constants, rewriter);
    auto myAssert = MyAssertOperator(rewriter, constants, ctx, __FILE_NAME__);
    myOperators
    { // Load "globals"

        /// Get the address of the VDBE
        auto beg = vdbeCtx->entryBlock->args_begin();
        auto end = vdbeCtx->entryBlock->args_end();
        auto p = *beg;
        vdbeCtx->p = p;

        // aMem (an sqlite3_value*) is the 20-th element in the Clang-compiled Vdbe
        auto aMemAddr = getElementPtrImm(LOC, T::sqlite3_valuePtrTy.getPointerTo(), p, 0, 19);
        // Load the value of aMem (the actual start of the array)
        auto aMem = load(LOC, aMemAddr);
        vdbeCtx->aMem = aMem;

        // apCsr (an sqlite3_cursor*) is the 22-th element in the Clang-compiled Vdbe
        auto apCsrAddr = getElementPtrImm(LOC, T::VdbeCursorPtrPtrTy.getPointerTo(), vdbeCtx->p, 0, 21);
        auto apCsr = load(LOC, apCsrAddr);
        vdbeCtx->apCsr = apCsr;

        /// aOp (a VdbeOp*) is the 24-th element of the Clang-compiled Vdbe
        auto aOpAddr = getElementPtrImm(LOC, T::VdbeOpPtrTy.getPointerTo(), p, 0, 23);
        auto aOp = load(LOC, aOpAddr);
        vdbeCtx->aOp = aOp;

        /// db (a sqlite3*)
        auto dbAddr = getElementPtrImm(LOC, T::sqlite3PtrTy.getPointerTo(), p, 0, 0);
        auto db = load(LOC, dbAddr);
        vdbeCtx->db = db;

#ifdef LLVMSQLITE_DEBUG
        {
            // The code in this scope allows us to check that the offsets we assume in the structs
            // are indeed the right ones. Otherwise, the code will behave very weirdly.
            // Ideally, it should work the offsets for every possible GEP instruction ever.
            MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);

            // Get &aOp[1]
            auto tmpAddress = getElementPtrImm(LOC, T::VdbeOpPtrTy, vdbeCtx->aOp, 4);
            auto tmpAddressInt = ptrToInt(LOC, tmpAddress);
            auto compileTimeAddress = constants((uint64_t)&vdbe->aOp[4], 64);
            auto addressesMatch = iCmp(LOC, ICmpPredicate::eq,
                    compileTimeAddress,
                    tmpAddressInt
                );

            myAssert(LOCL, addressesMatch);

            tmpAddress = getElementPtrImm(LOC, T::i8PtrTy, vdbeCtx->aOp, 35, 1);
            tmpAddressInt = ptrToInt(LOC, tmpAddress);
            compileTimeAddress = constants((uint64_t)&vdbe->aOp[35].p4type, 64);
            addressesMatch = iCmp(LOC, ICmpPredicate::eq,
                compileTimeAddress,
                tmpAddressInt
            );

            myAssert(LOCL, addressesMatch);
        }
#endif
    }

    // Each time we translate an instruction, we need to branch from its block to the next block
    // We store the last instruction's block to this end.
    mlir::Block* lastBlock = entryBlock;

    print(LOCL, "-- Entered JITted function");

    // A block in which we will jump to other blocks. It is useful for resuming execution of the Vdbe.
    auto jumpsBlock = entryBlock->splitBlock(entryBlock->end());
    vdbeCtx->jumpsBlock = jumpsBlock;
    opBuilder.setInsertionPointToEnd(entryBlock);
    branch(LOC, jumpsBlock);
    opBuilder.setInsertionPointToStart(jumpsBlock);

    // The iCompare value. It is supposed to be local to sqlite3VdbeExec but I moved it out
    // so we can interleave JIT execution and default implementation
    extern int iCompare;
    // TODO: Fix iCompare
    vdbeCtx->iCompare = constants(T::i32PtrTy, &iCompare);

    // Our goal here: check the value of vdbe->pc and jump to the right block
    auto pcAddr = getElementPtrImm(LOC, T::i32PtrTy, vdbeCtx->p, 0, 10);
    auto pcValue = load(LOC, pcAddr);
    // print(LOCL, pcValue, "PC: ");

    Block* targetBlock = nullptr;
    Block* blockAfterJump = nullptr;
    for(auto targetPc = 0; targetPc < vdbe->nOp; targetPc++) {
        auto curBlock = opBuilder.getBlock();
        // Only certain codes can be jumped back to. This saves a lot of branching.
        auto targetOpCode = vdbe->aOp[targetPc].opcode;
        if (targetOpCode != OP_Next && targetOpCode != OP_Halt
            && targetOpCode != OP_Return
            && !(targetPc > 0 && (
                  vdbe->aOp[targetPc - 1].opcode == OP_ResultRow
                 || vdbe->aOp[targetPc - 1].opcode == OP_Goto
                 || vdbe->aOp[targetPc - 1].opcode == OP_Gosub))
            ) {
            if (!anyDefaultImplUsed()) {
                // Uncomment this when you're sure it works (to generate less branching)
                continue;
            }
        }

        targetBlock = blocks.find(targetOpCode) != blocks.end() ? blocks[targetOpCode] : entryBlock;

        // The next block
        blockAfterJump = SPLIT_BLOCK; GO_BACK_TO(curBlock);
        auto pcValueIsTarget = iCmp(LOC, ICmpPredicate::eq, pcValue, targetPc);

        auto brOp = opBuilder.create<CondBrOp>(LOC, pcValueIsTarget, targetBlock, blockAfterJump);
        if (targetBlock == entryBlock)
            operations_to_update[targetPc].emplace_back(brOp, 0);

        opBuilder.setInsertionPointToStart(blockAfterJump);
        lastBlock = blockAfterJump;
    }

#ifdef LLVMSQLITE_DEBUG && !LLVMSQLITE_DONT_PRINT_VDBE
    // Prints all the opcodes of the Vdbe in order
    for(auto pc = 0llu; pc < vdbe->nOp; pc++) {
        auto& op = vdbe->aOp[pc];
        out(pc << " - " << sqlite3OpcodeName(op.opcode))
    }
#endif

    // Whether this operation should have branching to the next block appended to it
    bool writeBranchOut = true;

    // Flag to exit sqlite if we find an unsupported opcode
    bool unsupportedOpCodeSeen = false;

    // Iterate over the VDBE programme
    for(auto pc = 0llu; pc < vdbe->nOp; pc++) {
        // Create a block for that operation
        auto block = func.addBlock();
        opBuilder.setInsertionPointToStart(block);
        
        // The VdbeOp we're currently working on 
        auto& op = vdbe->aOp[pc];

        // By default, we write branching to the next block
        bool newWriteBranchOut = true;
 
        // Construct the adequate VDBE MLIR operation based on the instruction
        switch(op.opcode) {
            default:
                llvm::errs() << "Unsupported opcode: " << sqlite3OpcodeName(op.opcode) << '\n';
                llvm::errs().flush();
                unsupportedOpCodeSeen = true;
            case OP_Init: {
                auto initValue = op.p1;
                auto jumpTo = op.p2;
                if (jumpTo == 0) {
                    jumpTo = pc + 1;
                }

                auto initOp = opBuilder.create<VdbeOps::InitOp>
                        (LOC,
                         INTEGER_ATTR(64, false, pc),
                         entryBlock
                        );

                operations_to_update[jumpTo].emplace_back(initOp, 0);

                newWriteBranchOut = false;
                break;
            }
            case OP_Noop: {
                opBuilder.create<VdbeOps::Noop>
                        (LOC,
                         INTEGER_ATTR(64, false, pc)
                        );
                break;
            }
            case OP_Goto: {
                auto toBlockPc = op.p2;

                // Jumping to the entry block is invalid. This is on purpose.
                // If we don't update that jump before the end of the conversion, then we haven't
                // generated the right translation, which means it's not supposed to run.
                auto toBlock = entryBlock;

                // Of course, if the block to which we want to jump already exists, we want to use it
                if (blocks.find(toBlockPc) != blocks.end()) {
                    toBlock = blocks[toBlockPc];
                }

                // Create the jump
                auto op = opBuilder.create<VdbeOps::Goto>(
                        LOC,
                        INTEGER_ATTR(64, false, pc),
                        toBlock
                );

                // If the destination block hasn't been created yet, add this operation to the
                // ones that need to be updated when the destination block is created
                if (toBlock == entryBlock) {
                    operations_to_update[toBlockPc].emplace_back(op.getOperation(), 0);
                }

                newWriteBranchOut = false;
                break;
            }
            case OP_Halt: {
                opBuilder.create<VdbeOps::Halt>
                    (LOC,
                        INTEGER_ATTR(64, false, pc)
                    );
                newWriteBranchOut = false;
                break;
            }
            case OP_OpenWrite: {
                llvm_unreachable("OpenWrite is not implemented.");
            }
            case OP_OpenRead: {
                auto curIdx = op.p1;
                auto rootPage = op.p2;
                auto dbIdx = op.p3;
                auto p4 = op.p4.pKeyInfo;
                auto p5 = op.p5;

                // TODO: Fix the memory leak caused by this
                if (op.p4type == P4_KEYINFO)
                    p4->nRef++;

                opBuilder.create<VdbeOps::OpenRead>
                    (LOC,
                         INTEGER_ATTR(64, false, pc),
                         INTEGER_ATTR(32, true, curIdx),
                         INTEGER_ATTR(32, true, rootPage),
                         INTEGER_ATTR(32, true, dbIdx),
                         INTEGER_ATTR(64, false, (uint64_t)p4),
                         INTEGER_ATTR(16, false, p5)
                    );
                break;
            }
            case OP_Sort:
            case OP_SorterSort:
            case OP_Rewind: {
                auto curIdx = op.p1;
                auto jumpTo = op.p2;

                Block *blockJumpTo = blocks.count(jumpTo) == 0 ? entryBlock : blocks[jumpTo];
                Block *blockFallthrough = blocks.count(pc + 1) == 0 ? entryBlock : blocks[pc + 1];

                auto op = opBuilder.create<VdbeOps::Rewind>
                        (LOC,
                         INTEGER_ATTR(64, false, pc),
                         INTEGER_ATTR(32, true, curIdx),
                         blockJumpTo,
                         blockFallthrough
                        );

                if (blockJumpTo == entryBlock)
                    operations_to_update[jumpTo].emplace_back(op.getOperation(), 0);
                if (blockFallthrough == entryBlock)
                    operations_to_update[pc + 1].emplace_back(op.getOperation(), 1);

                newWriteBranchOut = false;
                break;
            }
            case OP_Column: {
                auto cursor = op.p1;
                auto column = op.p2;
                auto extractTo = op.p3;
                auto defaultNull = op.p4;
                auto flags = op.p5;

                opBuilder.create<VdbeOps::Column>
                        (LOC,
                         INTEGER_ATTR(64, true, pc),
                         INTEGER_ATTR(32, true, cursor),
                         INTEGER_ATTR(32, true, column),
                         INTEGER_ATTR(32, true, extractTo),
                         INTEGER_ATTR(64, false, (uint64_t) defaultNull.p),
                         INTEGER_ATTR(16, false, flags)
                        );

                break;
            }
            case OP_ResultRow: {
                auto firstColumnIndex = op.p1;
                auto nColumn = op.p2;

                opBuilder.create<VdbeOps::ResultRow>
                        (LOC,
                         INTEGER_ATTR(64, true, pc),
                         INTEGER_ATTR(32, true, firstColumnIndex),
                         INTEGER_ATTR(32, true, nColumn)
                        );

                newWriteBranchOut = false;
                break;
            }
            case OP_Next: {
                auto curIdx = op.p1;
                auto jumpTo = op.p2;
                auto curHint = op.p3;
                auto p4 = op.p4;
                auto p5 = op.p5;

                auto blockJumpTo = entryBlock;
                auto blockFallThrough = entryBlock;
                if (blocks.find(jumpTo) != blocks.end()) {
                    blockJumpTo = blocks[jumpTo];
                }

                auto op = opBuilder.create<VdbeOps::Next>
                        (LOC,
                         INTEGER_ATTR(64, false, pc),
                         INTEGER_ATTR(32, true, curIdx),
                         INTEGER_ATTR(32, true, curHint),
                         INTEGER_ATTR(64, false, (uint64_t) p4.p),
                         INTEGER_ATTR(16, false, p5),
                         blockJumpTo,
                         blockFallThrough
                        );

                if (block == entryBlock)
                    operations_to_update[jumpTo].emplace_back(op.getOperation(), 0);
                operations_to_update[pc + 1].emplace_back(op.getOperation(), 1);

                newWriteBranchOut = false;
                break;
            }
            case OP_Transaction: {
                auto dbIdx = op.p1;
                auto isWrite = op.p2;
                auto p3 = op.p3;
                auto p4 = (uint64_t) op.p4.p;
                auto p5 = op.p5;

                opBuilder.create<VdbeOps::Transaction>
                        (LOC,
                         INTEGER_ATTR(64, false, pc),
                         INTEGER_ATTR(32, true, dbIdx),
                         INTEGER_ATTR(32, true, isWrite),
                         INTEGER_ATTR(32, true, p3),
                         INTEGER_ATTR(64, true, p4),
                         INTEGER_ATTR(16, true, p5)
                        );

                break;
            }
            case OP_Null: {
                auto setMemCleared = op.p1;
                auto firstReg = op.p2;
                auto lastReg = op.p3;

                opBuilder.create<VdbeOps::Null>
                        (LOC,
                         INTEGER_ATTR(64, false, pc),
                         INTEGER_ATTR(32, true, setMemCleared),
                         INTEGER_ATTR(32, true, firstReg),
                         INTEGER_ATTR(32, true, lastReg)
                        );

                break;
            }
            case OP_AggStep: {
                auto p1 = op.p1;
                auto firstRegFrom = op.p2;
                auto firstRegTo = op.p3;
                auto funcDef = op.p4.pFunc;
                auto nArgs = op.p5;

                opBuilder.create<VdbeOps::AggStep>
                        (LOC,
                         INTEGER_ATTR(64, false, pc),
                         INTEGER_ATTR(32, false, p1),
                         INTEGER_ATTR(32, true, firstRegFrom),
                         INTEGER_ATTR(32, true, firstRegTo),
                         INTEGER_ATTR(64, false, (uint64_t) funcDef),
                         INTEGER_ATTR(16, true, nArgs)
                        );

                break;
            }
            case OP_AggFinal: {
                auto p1 = op.p1;
                auto nArgs = op.p2;
                auto funcDef = op.p4.pFunc;

                opBuilder.create<VdbeOps::AggFinal>
                        (LOC,
                         INTEGER_ATTR(64, false, pc),
                         INTEGER_ATTR(32, true, p1),
                         INTEGER_ATTR(32, false, nArgs),
                         INTEGER_ATTR(64, false, (uint64_t) funcDef)
                        );

                break;
            }
            case OP_Copy: {
                auto firstRegTo = op.p1;
                auto firstRegFrom = op.p2;
                auto nRegs = op.p3;

                opBuilder.create<VdbeOps::Copy>
                        (LOC,
                         INTEGER_ATTR(64, false, pc),
                         INTEGER_ATTR(32, true, firstRegTo),
                         INTEGER_ATTR(32, true, firstRegFrom),
                         INTEGER_ATTR(32, true, nRegs)
                        );

                break;
            }
            case OP_Integer: {
                auto value = op.p1;
                auto nothing = op.p2;

                opBuilder.create<VdbeOps::Integer>
                        (LOC,
                         INTEGER_ATTR(64, false, pc),
                         INTEGER_ATTR(32, true, value),
                         INTEGER_ATTR(32, true, nothing)
                        );

                break;
            }
            case OP_Gosub: {
                auto writeAddressTo = op.p1;
                auto jumpTo = op.p2;

                Block *blockJumpTo = blocks.count(jumpTo) == 0 ? entryBlock : blocks[jumpTo];

                auto op = rewriter.create<VdbeOps::Gosub>
                        (LOC,
                         INTEGER_ATTR(64, false, pc),
                         INTEGER_ATTR(32, true, writeAddressTo),
                         blockJumpTo
                        );

                if (blockJumpTo == entryBlock)
                    operations_to_update[jumpTo].emplace_back(op.getOperation(), 0);

                newWriteBranchOut = false;
                break;
            }
            case OP_MakeRecord: {
                auto firstRegFrom = op.p1;
                auto nReg = op.p2;
                auto dest = op.p3;
                auto affinities = (uint64_t) op.p4.p;

                rewriter.create<VdbeOps::MakeRecord>
                        (LOC,
                         INTEGER_ATTR(64, false, pc),
                         INTEGER_ATTR(32, true, firstRegFrom),
                         INTEGER_ATTR(32, true, nReg),
                         INTEGER_ATTR(32, true, dest),
                         INTEGER_ATTR(64, false, affinities)
                        );

                break;
            }
            case OP_OpenPseudo: {
                auto curIdx = op.p1;
                auto reg = op.p2;
                auto nFields = op.p3;

                rewriter.create<VdbeOps::OpenPseudo>
                        (LOC,
                         INTEGER_ATTR(64, false, pc),
                         INTEGER_ATTR(32, true, curIdx),
                         INTEGER_ATTR(32, true, reg),
                         INTEGER_ATTR(32, true, nFields)
                        );

                break;
            }
            case OP_SorterInsert: {
                auto curIdx = op.p1;
                auto reg = op.p2;

                rewriter.create<VdbeOps::SorterInsert>
                        (LOC,
                         INTEGER_ATTR(64, false, pc),
                         INTEGER_ATTR(32, true, curIdx),
                         INTEGER_ATTR(32, true, reg)
                        );

                break;
            }
            case OP_SorterOpen: {
                auto curIdx = op.p1;
                auto nCol = op.p2;
                auto p3 = op.p3;
                auto p4 = (uint64_t) op.p4.p;

                opBuilder.create<VdbeOps::SorterOpen>
                        (LOC,
                         INTEGER_ATTR(64, false, pc),
                         INTEGER_ATTR(32, true, curIdx),
                         INTEGER_ATTR(32, true, nCol),
                         INTEGER_ATTR(32, true, p3),
                         INTEGER_ATTR(64, false, p4)
                        );

                break;
            }
            case OP_SorterData: {
                auto curIdx = op.p1;
                auto regTo = op.p2;
                auto p3 = op.p3;

                auto op = opBuilder.create<VdbeOps::SorterData>
                        (LOC,
                         INTEGER_ATTR(64, false, pc),
                         INTEGER_ATTR(32, true, curIdx),
                         INTEGER_ATTR(32, true, regTo),
                         INTEGER_ATTR(32, true, p3)
                        );

                break;
            }
            case OP_SorterNext: {
                auto p1 = op.p1;
                auto p5 = op.p5;
                auto jumpToAddr = op.p2;

                auto jumpToBlock = blocks.find(jumpToAddr) != blocks.end() ? blocks[jumpToAddr] : entryBlock;
                auto fallthroughBlock = blocks.find(pc + 1) != blocks.end() ? blocks[pc + 1] : entryBlock;

                auto op = opBuilder.create<VdbeOps::SorterNext>
                        (LOC,
                         INTEGER_ATTR(64, false, pc),
                         INTEGER_ATTR(32, true, p1),
                         INTEGER_ATTR(16, false, p5),
                         jumpToBlock,
                         fallthroughBlock
                        );

                if (jumpToBlock == entryBlock)
                    operations_to_update[jumpToAddr].emplace_back(op, 0);
                if (fallthroughBlock == entryBlock)
                    operations_to_update[pc + 1].emplace_back(op, 1);

                newWriteBranchOut = false;
                break;
            }
            case OP_Compare: {
                auto p1 = op.p1;
                auto p2 = op.p2;
                auto p3 = op.p3;
                auto p4 = (uint64_t) op.p4.p;
                auto p5 = op.p5;

                opBuilder.create<VdbeOps::Compare>
                        (LOC,
                         INTEGER_ATTR(64, false, pc),
                         INTEGER_ATTR(32, true, p1),
                         INTEGER_ATTR(32, true, p2),
                         INTEGER_ATTR(32, true, p3),
                         INTEGER_ATTR(64, false, p4),
                         INTEGER_ATTR(16, true, p5)
                        );

                break;
            }
            case OP_Jump: {
                auto addrLess = op.p1;
                auto addrEq = op.p2;
                auto addrGreater = op.p3;

                Block *blockLess = blocks.count(addrLess) == 0 ? entryBlock : blocks[addrLess];
                Block *blockEq = blocks.count(addrEq) == 0 ? entryBlock : blocks[addrEq];
                Block *blockGreater = blocks.count(addrGreater) == 0 ? entryBlock : blocks[addrGreater];

                auto op = opBuilder.create<VdbeOps::Jump>
                        (LOC,
                         INTEGER_ATTR(64, false, pc),
                         blockLess,
                         blockEq,
                         blockGreater
                        );

                if (blockLess == entryBlock)
                    operations_to_update[addrLess].emplace_back(op.getOperation(), 0);
                if (blockEq == entryBlock)
                    operations_to_update[addrEq].emplace_back(op.getOperation(), 1);
                if (blockGreater == entryBlock)
                    operations_to_update[addrGreater].emplace_back(op.getOperation(), 2);

                newWriteBranchOut = false;
                break;
            }
            case OP_Move: {
                auto p1 = op.p1;
                auto p2 = op.p2;
                auto p3 = op.p3;

                rewriter.create<VdbeOps::Move>
                        (LOC,
                         INTEGER_ATTR(64, false, pc),
                         INTEGER_ATTR(32, true, p1),
                         INTEGER_ATTR(32, true, p2),
                         INTEGER_ATTR(32, true, p3)
                        );

                break;
            }
            case OP_IfPos: {
                auto p1 = op.p1;
                auto p3 = op.p3;

                auto jumpToAddr = op.p2;
                Block *blockTarget = blocks.count(jumpToAddr) == 0 ? entryBlock : blocks[jumpToAddr];
                Block *blockFallthrough = blocks.count(pc + 1) == 0 ? entryBlock : blocks[pc + 1];

                auto op = rewriter.create<VdbeOps::IfPos>
                        (LOC,
                         INTEGER_ATTR(64, false, pc),
                         INTEGER_ATTR(32, true, p1),
                         INTEGER_ATTR(32, true, p3),
                         blockTarget,
                         blockFallthrough
                        );

                if (blockTarget == entryBlock)
                    operations_to_update[jumpToAddr].emplace_back(op.getOperation(), 0);
                if (blockFallthrough == entryBlock)
                    operations_to_update[pc + 1].emplace_back(op.getOperation(), 1);

                newWriteBranchOut = false;
                break;
            }
            case OP_Return: {
                auto returnToAddrReg = op.p1;

                auto op = rewriter.create<VdbeOps::Return>
                        (LOC,
                         INTEGER_ATTR(64, false, pc),
                         INTEGER_ATTR(32, true, returnToAddrReg)
                        );

                newWriteBranchOut = false;
                break;
            }
            case OP_Add:
            case OP_Subtract:
            case OP_Multiply:
            case OP_Divide:
            case OP_Remainder: {
                auto p1 = op.p1;
                auto p2 = op.p2;
                auto p3 = op.p3;

                rewriter.create<VdbeOps::Arithmetic>
                        (LOC,
                         INTEGER_ATTR(64, false, pc),
                         INTEGER_ATTR(32, true, p1),
                         INTEGER_ATTR(32, true, p2),
                         INTEGER_ATTR(32, true, p3)
                        );

                break;
            }
            case OP_Real: {
                auto p2 = op.p2;
                auto p4 = op.p4.pReal;

                rewriter.create<VdbeOps::Real>
                        (LOC,
                         INTEGER_ATTR(64, false, pc),
                         INTEGER_ATTR(32, true, p2),
                         INTEGER_ATTR(64, false, (uint64_t) p4)
                        );

                break;
            }
            case OP_String: {
                auto len = op.p1;
                auto regTo = op.p2;
                auto hints = op.p3;
                auto string = op.p4.z;
                auto flags = op.p5;

                rewriter.create<VdbeOps::String>
                        (LOC,
                         INTEGER_ATTR(64, false, pc),
                         INTEGER_ATTR(32, true, len),
                         INTEGER_ATTR(32, true, regTo),
                         INTEGER_ATTR(32, true, hints),
                         INTEGER_ATTR(64, false, (uint64_t) string),
                         INTEGER_ATTR(16, false, flags)
                        );

                break;
            }
            case OP_String8: {
                auto string = (char*)op.p4.z;
                auto strLen = sqlite3Strlen30(string);
                auto regTo = op.p2;
                auto p3 = op.p3;
                auto p5 = op.p5;

                rewriter.create<VdbeOps::String>
                        (LOC,
                         INTEGER_ATTR(64, false, pc),
                         INTEGER_ATTR(32, true, strLen),
                         INTEGER_ATTR(32, true, regTo),
                         INTEGER_ATTR(32, true, p3),
                         INTEGER_ATTR(64, false, (uint64_t) string),
                         INTEGER_ATTR(16, false, p5)
                        );

                break;
            }
            case OP_Variable: {
                auto parameter = op.p1;
                auto regTo = op.p2;
                auto parameterName = op.p4.z;

                rewriter.create<VdbeOps::Variable>
                        (LOC,
                         INTEGER_ATTR(64, false, pc),
                         INTEGER_ATTR(32, true, parameter),
                         INTEGER_ATTR(32, true, regTo),
                         INTEGER_ATTR(64, false, (uint64_t) parameterName)
                        );

                break;
            }
            case OP_Eq:
            case OP_Ne:
            case OP_Lt:
            case OP_Le:
            case OP_Gt:
            case OP_Ge: {
                auto* pOp = &vdbe->aOp[pc];
                LLVMSQLITE_ASSERT(pOp->p4type == P4_COLLSEQ || pOp->p4.pColl == 0);
                auto lhs = op.p1;
                auto p2 = op.p2;
                auto rhs = op.p3;
                auto comparator = op.p4.pColl;
                auto flags = op.p5;
                auto jumpTo = op.p2;

                Block *blockJumpTo = blocks.count(jumpTo) == 0 ? entryBlock : blocks[jumpTo];
                Block *blockFallthrough = blocks.count(pc + 1) == 0 ? entryBlock : blocks[pc + 1];

                auto op = rewriter.create<VdbeOps::CompareJump>
                    (LOC,
                        INTEGER_ATTR(64, false, pc),
                        INTEGER_ATTR(32, true, p2),
                        INTEGER_ATTR(32, true, lhs),
                        INTEGER_ATTR(32, true, rhs),
                        INTEGER_ATTR(64, false, (uint64_t)comparator),
                        INTEGER_ATTR(16, false, flags),
                        blockJumpTo,
                        blockFallthrough
                    );

                if (blockJumpTo == entryBlock)
                    operations_to_update[jumpTo].emplace_back(op.getOperation(), 0);
                if (blockFallthrough == entryBlock)
                    operations_to_update[pc + 1].emplace_back(op.getOperation(), 1);

                newWriteBranchOut = false;
                break;
            }
            case OP_Once: {
                auto jumpTo = op.p2;

                Block *blockJumpTo = blocks.count(jumpTo) == 0 ? entryBlock : blocks[jumpTo];
                Block *blockFallthrough = blocks.count(pc + 1) == 0 ? entryBlock : blocks[pc + 1];

                auto op = rewriter.create<VdbeOps::Once>
                    (LOC,
                        INTEGER_ATTR(64, false, pc),
                        blockJumpTo,
                        blockFallthrough
                    );

                if (blockJumpTo == entryBlock)
                    operations_to_update[jumpTo].emplace_back(op.getOperation(), 0);
                if (blockFallthrough == entryBlock)
                    operations_to_update[pc + 1].emplace_back(op.getOperation(), 1);

                newWriteBranchOut = false;
                break;
            }
            case OP_If: {
                auto p1 = op.p1;
                auto p2 = op.p2;
                auto p3 = op.p3;

                Block *blockJump = blocks.count(p2) == 0 ? entryBlock : blocks[p2];
                Block *blockFallthrough = blocks.count(pc + 1) == 0 ? entryBlock : blocks[pc + 1];

                auto op = rewriter.create<VdbeOps::If>
                    (LOC,
                     INTEGER_ATTR(64, false, pc),
                         INTEGER_ATTR(32, true, p1),
                         INTEGER_ATTR(32, true, p3),
                         blockJump,
                         blockFallthrough
                    );

                if (blockJump == entryBlock)
                    operations_to_update[p2].emplace_back(op.getOperation(), 0);
                if (blockFallthrough == entryBlock)
                    operations_to_update[pc + 1].emplace_back(op.getOperation(), 1);

                newWriteBranchOut = false;
                break;
            }
            case OP_PureFunc:
            case OP_Function: {
                auto bitmask = op.p1;
                auto firstParameter = op.p2;
                auto outRegister = op.p3;
                auto func = op.p4.pCtx;

                rewriter.create<VdbeOps::Function>
                    (LOC,
                         INTEGER_ATTR(64, false, pc),
                         INTEGER_ATTR(32, true, bitmask),
                         INTEGER_ATTR(32, true, firstParameter),
                         INTEGER_ATTR(32, true, outRegister),
                         INTEGER_ATTR(64, false, (uint64_t)func)
                    );

                break;
            }
            case OP_OpenAutoindex:
            case OP_OpenEphemeral: {
                auto p1 = op.p1;
                auto p2 = op.p2;
                auto p4 = op.p4.pKeyInfo;
                auto p5 = op.p5;

                // TODO: Fix the memory leaks caused by this:
                if (p4)
                    p4->nRef += 5;

                rewriter.create<VdbeOps::OpenEphemeral>
                    (LOC,
                         INTEGER_ATTR(64, false, pc),
                         INTEGER_ATTR(32, true, p1),
                         INTEGER_ATTR(32, true, p2),
                         INTEGER_ATTR(64, false, (uint64_t)p4),
                         INTEGER_ATTR(16, false, p5)
                    );

                break;
            }
            case OP_IdxRowid:
            case OP_DeferredSeek: {
                auto p1 = op.p1;
                auto p3 = op.p3;
                auto p4 = (char*)op.p4.z;

                rewriter.create<VdbeOps::DeferredSeek>
                    (LOC,
                        INTEGER_ATTR(64, false, pc),
                        INTEGER_ATTR(32, true, p1),
                        INTEGER_ATTR(32, true, p3),
                        INTEGER_ATTR(64, false, (uint64_t)p4)
                    );

                break;
            }
            case OP_SeekRowid: {
                auto p1 = op.p1;
                auto p2 = op.p2;
                auto p3 = op.p3;

                auto jumpToBlock = blocks.find(p2) != blocks.end() ? blocks[p2] : entryBlock;
                auto fallthroughBlock = blocks.find(pc + 1) != blocks.end() ? blocks[pc + 1] : entryBlock;                

                auto op = rewriter.create<VdbeOps::SeekRowid>
                    (LOC,
                        INTEGER_ATTR(64, false, pc),
                        INTEGER_ATTR(32, true, p1),
                        INTEGER_ATTR(32, true, p3),
                        jumpToBlock,
                        fallthroughBlock
                    );

                if (jumpToBlock == entryBlock)
                    operations_to_update[p2].emplace_back(op, 0);
                if (fallthroughBlock == entryBlock)
                    operations_to_update[pc + 1].emplace_back(op, 1);

                newWriteBranchOut = false;
                break;
            }
            case OP_Sequence: {
                auto p1 = op.p1;
                auto p2 = op.p2;

                rewriter.create<VdbeOps::Sequence>
                    (LOC,
                        INTEGER_ATTR(64, false, pc),
                        INTEGER_ATTR(32, true, p1),
                        INTEGER_ATTR(32, true, p2)
                    );

                break;
            }
            case OP_IfNotZero: {
                auto p1 = op.p1;
                auto p2 = op.p2;

                auto jumpToBlock = blocks.find(p2) != blocks.end() ? blocks[p2] : entryBlock;
                auto fallthroughBlock = blocks.find(pc + 1) != blocks.end() ? blocks[pc + 1] : entryBlock;                

                auto op = rewriter.create<VdbeOps::IfNotZero>
                    (LOC,
                        INTEGER_ATTR(64, false, pc),
                        INTEGER_ATTR(32, true, p1),
                        jumpToBlock,
                        fallthroughBlock
                    );

                if (jumpToBlock == entryBlock)
                    operations_to_update[p2].emplace_back(op, 0);
                if (fallthroughBlock == entryBlock)
                    operations_to_update[pc + 1].emplace_back(op, 1);

                newWriteBranchOut = false;
                break;
            }
            case OP_IfNot: {
                auto p1 = op.p1;
                auto p2 = op.p2;
                auto p3 = op.p3;

                auto jumpToBlock = blocks.find(p2) != blocks.end() ? blocks[p2] : entryBlock;
                auto fallthroughBlock = blocks.find(pc + 1) != blocks.end() ? blocks[pc + 1] : entryBlock;

                auto op = rewriter.create<VdbeOps::IfNot>
                        (LOC,
                         INTEGER_ATTR(64, false, pc),
                         INTEGER_ATTR(32, true, p1),
                         INTEGER_ATTR(32, true, p3),
                         jumpToBlock,
                         fallthroughBlock
                        );

                if (jumpToBlock == entryBlock)
                    operations_to_update[p2].emplace_back(op, 0);
                if (fallthroughBlock == entryBlock)
                    operations_to_update[pc + 1].emplace_back(op, 1);

                newWriteBranchOut = false;
                break;
            }
            case OP_IfNullRow: {
                auto p1 = op.p1;
                auto p2 = op.p2;
                auto p3 = op.p3;

                auto jumpToBlock = blocks.find(p2) != blocks.end() ? blocks[p2] : entryBlock;
                auto fallthroughBlock = blocks.find(pc + 1) != blocks.end() ? blocks[pc + 1] : entryBlock;

                auto op = rewriter.create<VdbeOps::IfNullRow>
                        (LOC,
                         INTEGER_ATTR(64, false, pc),
                         INTEGER_ATTR(32, true, p1),
                         INTEGER_ATTR(32, true, p3),
                         jumpToBlock,
                         fallthroughBlock
                        );

                if (jumpToBlock == entryBlock)
                    operations_to_update[p2].emplace_back(op, 0);
                if (fallthroughBlock == entryBlock)
                    operations_to_update[pc + 1].emplace_back(op, 1);

                newWriteBranchOut = false;
                break;
            }
            case OP_NotNull: {
                auto p1 = op.p1;
                auto p2 = op.p2;

                auto jumpToBlock = blocks.find(p2) != blocks.end() ? blocks[p2] : entryBlock;
                auto fallthroughBlock = blocks.find(pc + 1) != blocks.end() ? blocks[pc + 1] : entryBlock;

                auto op = rewriter.create<VdbeOps::NotNull>
                        (LOC,
                         INTEGER_ATTR(64, false, pc),
                         INTEGER_ATTR(32, true, p1),
                         jumpToBlock,
                         fallthroughBlock
                        );

                if (jumpToBlock == entryBlock)
                    operations_to_update[p2].emplace_back(op, 0);
                if (fallthroughBlock == entryBlock)
                    operations_to_update[pc + 1].emplace_back(op, 1);

                newWriteBranchOut = false;
                break;
            }
            case OP_IsNull: {
                auto p1 = op.p1;
                auto p2 = op.p2;

                auto jumpToBlock = blocks.find(p2) != blocks.end() ? blocks[p2] : entryBlock;
                auto fallthroughBlock = blocks.find(pc + 1) != blocks.end() ? blocks[pc + 1] : entryBlock;

                auto op = rewriter.create<VdbeOps::IsNull>
                        (LOC,
                         INTEGER_ATTR(64, false, pc),
                         INTEGER_ATTR(32, true, p1),
                         jumpToBlock,
                         fallthroughBlock
                        );

                if (jumpToBlock == entryBlock)
                    operations_to_update[p2].emplace_back(op, 0);
                if (fallthroughBlock == entryBlock)
                    operations_to_update[pc + 1].emplace_back(op, 1);

                newWriteBranchOut = false;
                break;
            }
            case OP_Last: {
                auto p1 = op.p1;
                auto p2 = op.p2;

                p2 = p2 == 0 ? pc + 1 : p2;
                auto jumpToBlock = blocks.find(p2) != blocks.end() ? blocks[p2] : entryBlock;
                auto fallthroughBlock = blocks.find(pc + 1) != blocks.end() ? blocks[pc + 1] : entryBlock;                

                auto op = rewriter.create<VdbeOps::Last>
                    (LOC,
                        INTEGER_ATTR(64, false, pc),
                        INTEGER_ATTR(32, true, p1),
                        jumpToBlock,
                        fallthroughBlock
                    );

                if (jumpToBlock == entryBlock)
                    operations_to_update[p2].emplace_back(op, 0);
                if (fallthroughBlock == entryBlock)
                    operations_to_update[pc + 1].emplace_back(op, 1);
                
                newWriteBranchOut = false;
                break;
            }
            case OP_IdxGE:
            case OP_IdxGT:
            case OP_IdxLT:
            case OP_IdxLE: {
                auto p1 = op.p1;
                auto p2 = op.p2;
                auto p3 = op.p3;
                auto p4 = op.p4.p;
                auto p5 = op.p5;

                auto jumpToBlock = blocks.find(p2) != blocks.end() ? blocks[p2] : entryBlock;
                auto fallthroughBlock = blocks.find(pc + 1) != blocks.end() ? blocks[pc + 1] : entryBlock;                

                auto op = rewriter.create<VdbeOps::IdxCompare>
                    (LOC,
                        INTEGER_ATTR(64, false, pc),
                        INTEGER_ATTR(32, true, p1),
                        INTEGER_ATTR(32, true, p3),
                        INTEGER_ATTR(64, false, (uint64_t)p4),
                        INTEGER_ATTR(16, false, p5),
                        jumpToBlock,
                        fallthroughBlock
                    );

                if (jumpToBlock == entryBlock)
                    operations_to_update[p2].emplace_back(op, 0);
                if (fallthroughBlock == entryBlock)
                    operations_to_update[pc + 1].emplace_back(op, 1);
                
                newWriteBranchOut = false;
                break;
            }
            case OP_Delete: {
                auto p1 = op.p1;
                auto p2 = op.p2;
                auto p3 = op.p3;
                auto p4 = op.p4.p;
                auto p5 = op.p5;

                auto op = rewriter.create<VdbeOps::Delete>
                    (LOC,
                        INTEGER_ATTR(64, false, pc),
                        INTEGER_ATTR(32, true, p1),
                        INTEGER_ATTR(32, true, p2),
                        INTEGER_ATTR(32, true, p3),
                        INTEGER_ATTR(64, false, (uint64_t)p4),
                        INTEGER_ATTR(16, false, p5)
                    );
                
                break;
            }
            case OP_IdxInsert: {
                auto p1 = op.p1;
                auto p2 = op.p2;
                auto p3 = op.p3;
                auto p4 = op.p4.p;
                auto p5 = op.p5;

                rewriter.create<VdbeOps::IdxInsert>
                    (LOC,
                        INTEGER_ATTR(64, false, pc),
                        INTEGER_ATTR(32, true, p1),
                        INTEGER_ATTR(32, true, p2),
                        INTEGER_ATTR(32, true, p3),
                        INTEGER_ATTR(64, false, (uint64_t)p4),
                        INTEGER_ATTR(16, false, p5)
                    );
                
                break;
            }
            case OP_Rowid: {
                auto p1 = op.p1;
                auto p2 = op.p2;

                rewriter.create<VdbeOps::Rowid>
                    (LOC,
                        INTEGER_ATTR(64, false, pc),
                        INTEGER_ATTR(32, true, p1),
                        INTEGER_ATTR(32, true, p2)
                    );

                break;
            }
            case OP_Found:
            case OP_NotFound: {
                auto p1 = op.p1;
                auto p2 = op.p2;
                auto p3 = op.p3;
                auto p4 = op.p4;

                auto jumpToBlock = blocks.find(p2) != blocks.end() ? blocks[p2] : entryBlock;
                auto fallthroughBlock = blocks.find(pc + 1) != blocks.end() ? blocks[pc + 1] : entryBlock;

                auto op = rewriter.create<VdbeOps::NotFound>
                    (LOC,
                        INTEGER_ATTR(64, false, pc),
                        INTEGER_ATTR(32, true, p1),
                        INTEGER_ATTR(32, true, p2),
                        INTEGER_ATTR(32, true, p3),
                        INTEGER_ATTR(64, true, p4.i),
                        jumpToBlock,
                        fallthroughBlock
                    );

                if (jumpToBlock == entryBlock)
                    operations_to_update[p2].emplace_back(op, 0);
                if (fallthroughBlock == entryBlock)
                    operations_to_update[pc + 1].emplace_back(op, 1);

                newWriteBranchOut = false;
                break;
            }
            case OP_RowSetTest: {
                auto p1 = op.p1;
                auto p2 = op.p2;
                auto p3 = op.p3;
                auto p4 = op.p4.i;

                auto jumpToBlock = blocks.find(p2) != blocks.end() ? blocks[p2] : entryBlock;
                auto fallthroughBlock = blocks.find(pc + 1) != blocks.end() ? blocks[pc + 1] : entryBlock;

                auto op = rewriter.create<VdbeOps::RowSetTest>
                    (LOC,
                        INTEGER_ATTR(64, false, pc),
                        INTEGER_ATTR(32, true, p1),
                        INTEGER_ATTR(32, true, p2),
                        INTEGER_ATTR(32, true, p3),
                        INTEGER_ATTR(64, true, p4),
                        jumpToBlock,
                        fallthroughBlock
                    );

                if (jumpToBlock == entryBlock)
                    operations_to_update[p2].emplace_back(op, 0);
                if (fallthroughBlock == entryBlock)
                    operations_to_update[pc + 1].emplace_back(op, 1);

                newWriteBranchOut = false;
                break;
            }
            case OP_Affinity: {
                auto p1 = op.p1;
                auto p2 = op.p2;
                auto p4 = op.p4.z;

                auto op = rewriter.create<VdbeOps::Affinity>
                    (LOC,
                         INTEGER_ATTR(64, false, pc),
                         INTEGER_ATTR(32, true, p1),
                         INTEGER_ATTR(32, true, p2),
                         INTEGER_ATTR(64, false, (uint64_t)p4)
                    );

                break;
            }
            case OP_SeekLE:
            case OP_SeekLT:
            case OP_SeekGE:
            case OP_SeekGT: {
                auto p1 = op.p1;
                auto p2 = op.p2;
                auto p3 = op.p3;
                auto p4 = op.p4.i;

                auto jumpToBlock = blocks.find(p2) != blocks.end() ? blocks[p2] : entryBlock;
                auto fallthroughBlock = blocks.find(pc + 1) != blocks.end() ? blocks[pc + 1] : entryBlock;
                auto skipNextBlock = blocks.find(pc + 2) != blocks.end() ? blocks[pc + 2] : entryBlock;

                auto op = rewriter.create<VdbeOps::SeekGE>
                        (LOC,
                         INTEGER_ATTR(64, true, pc),
                         INTEGER_ATTR(32, true, p1),
                         INTEGER_ATTR(32, true, p2),
                         INTEGER_ATTR(32, true, p3),
                         INTEGER_ATTR(64, false, p4),
                         jumpToBlock,
                         fallthroughBlock,
                         skipNextBlock
                        );

                if (jumpToBlock == entryBlock)
                    operations_to_update[p2].emplace_back(op, 0);
                if (fallthroughBlock == entryBlock)
                    operations_to_update[pc + 1].emplace_back(op, 1);
                if (skipNextBlock == entryBlock)
                    operations_to_update[pc + 2].emplace_back(op, 2);

                newWriteBranchOut = false;
                break;
            }
            case OP_DecrJumpZero: {
                auto p1 = op.p1;
                auto p2 = op.p2;
                auto p3 = op.p3;
                auto p4 = op.p4.i;

                auto jumpToBlock = blocks.find(p2) != blocks.end() ? blocks[p2] : entryBlock;
                auto fallthroughBlock = blocks.find(pc + 1) != blocks.end() ? blocks[pc + 1] : entryBlock;

                auto op = rewriter.create<VdbeOps::DecrJumpZero>
                        (LOC,
                         INTEGER_ATTR(64, true, pc),
                         INTEGER_ATTR(32, true, p1),
                         INTEGER_ATTR(32, true, p2),
                         jumpToBlock,
                         fallthroughBlock
                        );

                if (jumpToBlock == entryBlock)
                    operations_to_update[p2].emplace_back(op, 0);
                if (fallthroughBlock == entryBlock)
                    operations_to_update[pc + 1].emplace_back(op, 1);

                newWriteBranchOut = false;
                break;
            }
            case OP_CollSeq: {
                auto p1 = op.p1;
                auto p4 = op.p4.pColl;

                rewriter.create<VdbeOps::CollSeq>
                        (LOC,
                            INTEGER_ATTR(64, false, pc),
                            INTEGER_ATTR(32, true, p1),
                            INTEGER_ATTR(64, false, (uint64_t)p4)
                        );

                break;
            }
            case OP_SCopy:{
                auto p1 = op.p1;
                auto p2 = op.p2;

                rewriter.create<VdbeOps::SCopy>
                    (LOC,
                        INTEGER_ATTR(64, false, pc),
                        INTEGER_ATTR(32, true, p1),
                        INTEGER_ATTR(32, true, p2)
                    );

                break;
            }
            case OP_InitCoroutine: {
                auto p1 = op.p1;
                auto p2 = op.p2;
                auto p3 = op.p3;
                auto p4 = op.p4.i;

                if (p2 == 0)
                    p2 = pc + 1;

                auto jumpToBlock = blocks.find(p2) != blocks.end() ? blocks[p2] : entryBlock;
                auto fallthroughBlock = blocks.find(pc + 1) != blocks.end() ? blocks[pc + 1] : entryBlock;

                auto op = rewriter.create<VdbeOps::InitCoroutine>
                        (LOC,
                         INTEGER_ATTR(64, false, pc),
                         INTEGER_ATTR(32, true, p1),
                         INTEGER_ATTR(32, true, p3),
                         jumpToBlock,
                         fallthroughBlock
                        );

                if (jumpToBlock == entryBlock)
                    operations_to_update[p2].emplace_back(op, 0);
                if (fallthroughBlock == entryBlock)
                    operations_to_update[pc + 1].emplace_back(op, 1);

                newWriteBranchOut = false;
                break;
            }
            case OP_NullRow: {
                auto p1 = op.p1;

                rewriter.create<VdbeOps::NullRow>
                    (LOC,
                        INTEGER_ATTR(64, false, pc),
                        INTEGER_ATTR(32, true, p1)
                    );

                break;
            }
            case OP_Yield: {
                auto p1 = op.p1;
                auto p2 = op.p2;

                rewriter.create<VdbeOps::Yield>
                        (LOC,
                             INTEGER_ATTR(64, false, pc),
                             INTEGER_ATTR(32, true, p1),
                             INTEGER_ATTR(32, true, p2)
                        );

                newWriteBranchOut = false;
                break;
            }
            case OP_EndCoroutine: {
                auto p1 = op.p1;

                rewriter.create<VdbeOps::EndCoroutine>
                    (LOC,
                        INTEGER_ATTR(64, false, pc),
                        INTEGER_ATTR(32, true, p1)
                    );

                newWriteBranchOut = false;
                break;
            }
            case OP_Cast: {
                auto p1 = op.p1;
                auto p2 = op.p2;

                rewriter.create<VdbeOps::Cast>
                    (LOC,
                        INTEGER_ATTR(64, false, pc),
                        INTEGER_ATTR(32, true, p1),
                        INTEGER_ATTR(32, true, p2)
                    );

                break;
            }
            case OP_ReadCookie: {
                auto p1 = op.p1;
                auto p2 = op.p2;
                auto p3 = op.p3;

                rewriter.create<VdbeOps::ReadCookie>
                    (LOC,
                        INTEGER_ATTR(64, false, pc),
                        INTEGER_ATTR(32, true, p1),
                        INTEGER_ATTR(32, true, p2),
                        INTEGER_ATTR(32, true, p3)
                    );

                break;
            }
            case OP_SetCookie: {
                auto p1 = op.p1;
                auto p2 = op.p2;
                auto p3 = op.p3;

                rewriter.create<VdbeOps::SetCookie>
                    (LOC,
                        INTEGER_ATTR(64, false, pc),
                        INTEGER_ATTR(32, true, p1),
                        INTEGER_ATTR(32, true, p2),
                        INTEGER_ATTR(32, true, p3)
                    );

                break;
            }
            case OP_Blob: {
                auto p1 = op.p1;
                auto p2 = op.p2;
                auto p4 = op.p4.z;

                rewriter.create<VdbeOps::Blob>
                    (LOC,
                        INTEGER_ATTR(64, false, pc),
                        INTEGER_ATTR(32, true, p1),
                        INTEGER_ATTR(32, true, p2),
                        INTEGER_ATTR(64, false, (uint64_t)p4)
                    );

                break;
            }
            case OP_Close: {
                auto p1 = op.p1;

                rewriter.create<VdbeOps::Close>
                    (LOC,
                        INTEGER_ATTR(64, false, pc),
                        INTEGER_ATTR(32, true, p1)
                    );

                break;
            }
            case OP_Insert: {
                auto p1 = op.p1;
                auto p2 = op.p2;
                auto p3 = op.p3;
                auto p4 = op.p4.z;
                auto p5 = op.p5;

                rewriter.create<VdbeOps::Insert>
                    (LOC,
                        INTEGER_ATTR(64, false, pc),
                        INTEGER_ATTR(32, true, p1),
                        INTEGER_ATTR(32, true, p2),
                        INTEGER_ATTR(32, true, p3),
                        INTEGER_ATTR(64, false, (uint64_t)p4),
                        INTEGER_ATTR(16, false, p5)
                    );

                break;
            }
            case OP_ParseSchema: {
                auto p1 = op.p1;
                auto p4 = op.p4.p;

                rewriter.create<VdbeOps::ParseSchema>
                    (LOC,
                        INTEGER_ATTR(64, false, pc),
                        INTEGER_ATTR(32, true, p1),
                        INTEGER_ATTR(64, false, (uint64_t)p4)
                    );

                break;
            }
            case OP_NewRowid: {
                auto p1 = op.p1;
                auto p2 = op.p2;
                auto p3 = op.p3;

                rewriter.create<VdbeOps::NewRowid>
                    (LOC,
                        INTEGER_ATTR(64, false, pc),
                        INTEGER_ATTR(32, true, p1),
                        INTEGER_ATTR(32, true, p2),
                        INTEGER_ATTR(32, true, p3)
                    );

                break;
            }
            case OP_DropTable: {
                auto p1 = op.p1;
                auto p4 = op.p4.p;

                rewriter.create<VdbeOps::DropTable>
                    (LOC,
                        INTEGER_ATTR(64, false, pc),
                        INTEGER_ATTR(32, true, p1),
                        INTEGER_ATTR(64, false, (uint64_t)p4)
                    );

                break;
            }
        }

        // Add the block to the blocks map (for use in branches)
        blocks[pc] = block;

        // Update all instructions that branch to this instruction but couldn't refer to it before
        for(const auto& opAndIdx : operations_to_update[pc]) {
            auto op = opAndIdx.first;
            auto idx = opAndIdx.second;
            op->getBlockOperands()[idx].set(block);
        }

        // Remove these instructions from the map
        operations_to_update.erase(pc);

        // Add a branch from the latest block to this one
        if (writeBranchOut) {
            opBuilder.setInsertionPointToEnd(lastBlock);
            vdbeCtx->outBranches[pc] = opBuilder.create<BranchOp>(LOC, block);
            opBuilder.setInsertionPointToStart(block);
        }

        // Mark this block as the lastBlock
        lastBlock = block;
        writeBranchOut = newWriteBranchOut;
    }

    if (unsupportedOpCodeSeen) {
        out("Exiting after seeing unsupported opcodes")
        exit(UNSUPPORTED_OPCODE);
    }

    // If the map is not empty, then we didn't generate the destination block of some branches.
    LLVMSQLITE_ASSERT(operations_to_update.empty() && "All blocks have not been updated.");
}

void writeFunction(MLIRContext& context, LLVMDialect* llvmDialect, ModuleOp& theModule) {
    static_assert(sizeof(int*) == 8, "sizeof(int*) is assumed to be 8!");
    auto ctx = &context;
    auto vdbeDialect = context.getRegisteredDialect<StandaloneDialect>();
    LLVMSQLITE_ASSERT(vdbeDialect && "No VDBE Dialect registered");
    auto* vdbeCtx = &vdbeDialect->vdbeContext;
    auto* vdbe = vdbeCtx->vdbe;

    auto rewriter = mlir::OpBuilder(ctx);
    rewriter.setInsertionPointToStart(theModule.getBody());

    LLVMSQLITE_ASSERT(vdbeCtx->regInstances.empty() && "Registers vector should be empty at that point!");
    for(auto i = 0llu; i < vdbe->nMem; i++) {
        vdbeCtx->regInstances.emplace_back(&vdbe->aMem[i]);
    }

    auto inTypes = SmallVector<mlir::Type, 1>{
        T::VdbePtrTy
    };

    auto funcTy = rewriter.getFunctionType(inTypes, rewriter.getIntegerType(32));
    auto func = FuncOp::create(LOC, JIT_MAIN_FN_NAME, funcTy);
    theModule.push_back(func);

    writeFunction(context, llvmDialect, func);
}
