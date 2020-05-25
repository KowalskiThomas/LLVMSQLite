#include <unordered_map>
#include <src/mlir/include/Standalone/ConstantManager.h>
#include "sqlite_bridge.h"

#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/StandaloneDialect.h"
#include "Standalone/StandaloneOps.h"
#include "Standalone/StandalonePasses.h"
#include "Standalone/TypeDefinitions.h"
#include "Standalone/Lowering/Printer.h"

#include "Standalone/VdbeContext.h"

#include "tsrc/vdbe.h"

#define INTEGER_ATTR(width, signed, value) builder.getIntegerAttr(builder.getIntegerType(width, signed), value)

using MLIRContext = mlir::MLIRContext;
using LLVMDialect = mlir::LLVM::LLVMDialect;
using ModuleOp = mlir::ModuleOp;
using FuncOp = mlir::FuncOp;
using Block = mlir::Block;

void writeFunction(MLIRContext& mlirContext, LLVMDialect* llvmDialect, FuncOp& func) {
    auto ctx = &mlirContext;
    auto vdbeDialect = mlirContext.getRegisteredDialect<mlir::standalone::StandaloneDialect>();
    auto* vdbeCtx = &vdbeDialect->vdbeContext;
    auto* vdbe = vdbeCtx->vdbe;

    // All the blocks / operations we have already translated
    auto& blocks = vdbeCtx->blocks;

    // Operations that depend on a block that has not yet been built.
    // This map should be checked for at the end of every block / operation translation to update jumps.
    std::unordered_map<size_t, llvm::SmallVector<std::pair<mlir::Operation*, size_t>, 128>> operations_to_update;

    // Create an OpBuilder and make it write in the (new) function's entryBlock
    auto builder = mlir::OpBuilder(ctx);
    auto* entryBlock = func.addEntryBlock();
    builder.setInsertionPointToStart(entryBlock);
    ConstantManager constants(builder, ctx);
    mlir::Printer print(ctx, builder, __FILE_NAME__);

    auto& rewriter = builder;

    // Each time we translate an instruction, we need to branch from its block to the next block
    // We store the last instruction's block to this end.
    mlir::Block* lastBlock = entryBlock;

    vdbeCtx->iCompare = builder.create<mlir::LLVM::AllocaOp>(LOC, T::i32PtrTy, constants(1, 32), 0);
    auto pcAddr = constants(T::i32PtrTy, (int*)&vdbe->pc);
    auto pcValue = builder.create<LoadOp>(LOCB, pcAddr);

    Block* targetBlock = nullptr;
    Block* blockAfterJump = nullptr;
    for(auto targetPc = 0; targetPc < vdbe->nOp; targetPc++) {
        auto curBlock = builder.getBlock();
        // Only certain codes can be jumped back to. This saves a lot of branching.
        auto targetOpCode = vdbe->aOp[targetPc].opcode;
        if (targetOpCode != OP_Next && targetOpCode != OP_Halt
            && targetOpCode != OP_Return
            && !(targetPc > 0 && (
                  vdbe->aOp[targetPc - 1].opcode == OP_ResultRow
                 || vdbe->aOp[targetPc - 1].opcode == OP_Goto))
            ) {
            continue;
        }

        targetBlock = blocks.find(targetOpCode) != blocks.end() ? blocks[targetOpCode] : entryBlock;

        blockAfterJump = SPLIT_BLOCK; GO_BACK_TO(curBlock);
        auto pcValueIsTarget = builder.create<ICmpOp>
                (LOCB, ICmpPredicate::eq,
                 pcValue, constants(targetPc, 32)
                );

        auto brOp = builder.create<CondBrOp>(LOCB, pcValueIsTarget, targetBlock, blockAfterJump);
        if (targetBlock == entryBlock)
            operations_to_update[targetPc].emplace_back(brOp, 0);

        builder.setInsertionPointToStart(blockAfterJump);
        lastBlock = blockAfterJump;
    }

    // Iterate over the VDBE programme
    bool writeBranchOut = true;

    // Used to stop generating code after a certain instruction is seen (and finished)
    bool lastOpSeen = false;
    for(auto pc = 0llu; pc < vdbe->nOp; pc++) {
        // Create a block for that operation
        auto block = func.addBlock();
        builder.setInsertionPointToStart(block);
        auto& op = vdbe->aOp[pc];

        out(pc << " - " << sqlite3OpcodeName(op.opcode))

        bool newWriteBranchOut = true;
        // Construct the adequate VDBE MLIR operation based on the instruction
        switch(op.opcode) {
            default:
                llvm::errs() << "Unsupported opcode: " << sqlite3OpcodeName(op.opcode) << '\n';
                llvm::errs().flush();
#ifdef EXIT_ON_UNSUPPORTED_OPCODE
                exit(3);
#else
                break;
#endif
            case OP_Init: {
                auto initValue = op.p1;
                auto jumpTo = op.p2;
                if (jumpTo == 0) {
                    jumpTo = pc + 1;
                }

                auto initOp = builder.create<mlir::standalone::InitOp>
                    (LOCB,
                        INTEGER_ATTR(64, true, initValue),
                        entryBlock
                    );

                operations_to_update[jumpTo].emplace_back(initOp, 0);

                newWriteBranchOut = false;
                break;
            }
            case OP_Noop: {
                builder.create<mlir::standalone::Noop>
                        (LOCB,
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
                auto op = builder.create<mlir::standalone::Goto>(
                    LOCB,
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
                builder.create<mlir::standalone::Halt>(LOCB);
                newWriteBranchOut = false;
                break;
            }
            case OP_OpenRead: {
                auto curIdx = op.p1;
                auto rootPage = op.p2;
                auto dbIdx = op.p3;
                auto p4 = op.p4;
                auto p5 = op.p5;
                if (op.p4type == P4_KEYINFO) {
                    llvm::errs() << "Not implemented\n";
                    exit(5);
                    /*
                    builder.create<mlir::standalone::OpenRead>(LOCB,
                                                               (mlir::Value)CONSTANT_INT(curIdx, 64),
                                                               (mlir::Value)CONSTANT_INT(rootPage, 32),
                                                               (mlir::Value)CONSTANT_INT(dbIdx, 32),
                                                               (mlir::Value)CONSTANT_PTR(p4.pKeyInfo, 64));
                    */
                } else {
                    builder.create<mlir::standalone::OpenRead>
                        (LOCB,
                            INTEGER_ATTR(64, false, pc),
                            INTEGER_ATTR(32, true, curIdx),
                            INTEGER_ATTR(32, true, rootPage),
                            INTEGER_ATTR(32, true, dbIdx),
                            INTEGER_ATTR(32, true, p4.i),
                            INTEGER_ATTR(16, false, p5)
                        );
                }
                break;
            }
            case OP_Rewind: {
                auto curIdx = op.p1;
                auto jumpTo = op.p2;

                builder.create<mlir::standalone::Rewind>
                    (LOCB,
                        INTEGER_ATTR(32, true, curIdx),
                        INTEGER_ATTR(32, true, jumpTo)
                    );

                break;
            }
            case OP_Column: {
                auto cursor = op.p1;
                auto column = op.p2;
                auto extractTo = op.p3;
                auto defaultNull = op.p4;
                auto flags = op.p5;

                builder.create<mlir::standalone::Column>
                        (LOCB,
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

                builder.create<mlir::standalone::ResultRow>
                        (LOCB,
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

                auto op = builder.create<mlir::standalone::Next>
                        (LOCB,
                         INTEGER_ATTR(32, true, curIdx),
                         INTEGER_ATTR(32, true, curHint),
                         INTEGER_ATTR(64, false, (uint64_t)p4.p),
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
                auto p4 = (uint64_t)op.p4.p;
                auto p5 = op.p5;

                builder.create<mlir::standalone::Transaction>
                        (LOCB,
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

                builder.create<mlir::standalone::Null>
                        (LOCB,
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

                builder.create<mlir::standalone::AggStep>
                        (LOCB,
                             INTEGER_ATTR(64, false, pc),
                             INTEGER_ATTR(32, false, p1),
                             INTEGER_ATTR(32, true, firstRegFrom),
                             INTEGER_ATTR(32, true, firstRegTo),
                             INTEGER_ATTR(64, false, (uint64_t)funcDef),
                             INTEGER_ATTR(16, true, nArgs)
                        );

                break;
            }
            case OP_AggFinal: {
                auto p1 = op.p1;
                auto nArgs = op.p2;
                auto funcDef = op.p4.pFunc;

                builder.create<mlir::standalone::AggFinal>
                        (LOCB,
                            INTEGER_ATTR(32, true, p1),
                            INTEGER_ATTR(32, false, nArgs),
                            INTEGER_ATTR(64, false, (uint64_t)funcDef)
                        );

                break;
            }
            case OP_Copy: {
                auto firstRegTo = op.p1;
                auto firstRegFrom = op.p2;
                auto nRegs = op.p3;

                builder.create<mlir::standalone::Copy>
                        (LOCB,
                         INTEGER_ATTR(32, true, firstRegTo),
                         INTEGER_ATTR(32, true, firstRegFrom),
                         INTEGER_ATTR(32, true, nRegs)
                        );

                break;
            }
            case OP_Integer: {
                auto value = op.p1;
                auto nothing = op.p2;

                builder.create<mlir::standalone::Integer>
                    (LOCB,
                        INTEGER_ATTR(64, false, pc),
                        INTEGER_ATTR(32, true, value),
                        INTEGER_ATTR(32, true, nothing)
                    );

                // lastOpSeen = true;
                break;
            }
            case OP_Gosub: {
                auto writeAddressTo = op.p1;
                auto jumpTo = op.p2;

                rewriter.create<mlir::standalone::Gosub>
                    (LOCB,
                        INTEGER_ATTR(32, true, writeAddressTo),
                        INTEGER_ATTR(32, true, jumpTo)
                     );

                break;
            }
            case OP_MakeRecord: {
                auto firstRegFrom = op.p1;
                auto nReg = op.p2;
                auto dest = op.p3;
                auto affinities = (uint64_t)op.p4.p;

                rewriter.create<mlir::standalone::MakeRecord>
                    (LOCB,
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

                rewriter.create<mlir::standalone::OpenPseudo>
                    (LOCB,
                     INTEGER_ATTR(32, true, curIdx),
                     INTEGER_ATTR(32, true, reg),
                     INTEGER_ATTR(32, true, nFields)
                     );

                break;
            }
            case OP_SorterInsert: {
                auto curIdx = op.p1;
                auto reg = op.p2;

                rewriter.create<mlir::standalone::SorterInsert>
                        (LOCB,
                         INTEGER_ATTR(32, true, curIdx),
                         INTEGER_ATTR(32, true, reg)
                        );

                break;
            }
            case OP_SorterOpen: {
                auto curIdx = op.p1;
                auto nCol = op.p2;
                auto p3 = op.p3;
                auto p4 = (uint64_t)op.p4.p;

                builder.create<mlir::standalone::SorterOpen>
                        (LOCB,
                         INTEGER_ATTR(32, true, curIdx),
                         INTEGER_ATTR(32, true, nCol),
                         INTEGER_ATTR(32, true, p3),
                         INTEGER_ATTR(64, false, p4)
                        );

                break;
            }
            case OP_SorterSort: {
                auto curIdx = op.p1;

                auto jumpToAddr = op.p2;
                auto jumpToBlock = blocks.find(jumpToAddr) != blocks.end() ? blocks[jumpToAddr] : entryBlock;
                auto fallthroughBlock = blocks.find(pc + 1) != blocks.end() ? blocks[pc + 1] : entryBlock;

                auto op = builder.create<mlir::standalone::SorterSort>
                    (LOCB,
                        INTEGER_ATTR(32, true, curIdx),
                        jumpToBlock, fallthroughBlock
                    );

                if (jumpToBlock == entryBlock)
                    operations_to_update[jumpToAddr].emplace_back(op, 0);
                if (fallthroughBlock == entryBlock)
                    operations_to_update[pc + 1].emplace_back(op, 1);

                newWriteBranchOut = false;
                break;
            }
            case OP_SorterData: {
                auto curIdx = op.p1;
                auto regTo = op.p2;
                auto p3 = op.p3;

                auto op = builder.create<mlir::standalone::SorterData>
                    (LOCB,
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

                auto op = builder.create<mlir::standalone::SorterNext>
                    (LOCB,
                        INTEGER_ATTR(32, true, p1),
                        INTEGER_ATTR(16, false, p5),
                        jumpToBlock,
                        fallthroughBlock
                    );

                if (jumpToBlock == entryBlock)
                    operations_to_update[jumpToAddr].emplace_back(op, 0);
                if (fallthroughBlock == entryBlock)
                    operations_to_update[pc + 1].emplace_back(op, 1);

                break;
            }
            case OP_Compare: {
                auto p1 = op.p1;
                auto p2 = op.p2;
                auto p3 = op.p3;
                auto p4 = (uint64_t)op.p4.p;
                auto p5 = op.p5;

                out("test" << (p5 & OPFLAG_PERMUTE))

                builder.create<mlir::standalone::Compare>
                    (LOCB,
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


                break;
            }
            case OP_Move: {


                break;
            }
            case OP_IfPos: {


                break;
            }
            case OP_Return: {
                auto returnToAddr = op.p1;

                auto returnTo = blocks.count(returnToAddr) == 0 ? entryBlock : blocks[returnToAddr];

                auto op = rewriter.create<mlir::standalone::Return>(LOCB, returnTo);

                if (blocks.count(returnToAddr) == 0)
                    operations_to_update[returnToAddr].emplace_back(op, 0);

                break;
            }
        }

        // Add the block to the blocks map (for use in branches)
        blocks[pc] = block;

        // Update all instructions that branch to this instruction but couldn't refer to it before
        for(auto opAndIdx : operations_to_update[pc]) {
            auto op = opAndIdx.first;
            auto idx = opAndIdx.second;
            op->getBlockOperands()[idx].set(block);
        }

        // Remove these instructions from the map
        operations_to_update.erase(pc);

        // Add a branch from the latest block to this one
        if (writeBranchOut) {
            builder.setInsertionPointToEnd(lastBlock);
            vdbeCtx->outBranches[pc] = builder.create<mlir::BranchOp>(LOCB, block);
            builder.setInsertionPointToStart(block);
        }

        // Mark this block as the lastBlock
        lastBlock = block;
        writeBranchOut = newWriteBranchOut;

        // TODO: Remove this to do the whole thing
        if (lastOpSeen) {
            out("Exiting code generation early after " << sqlite3OpcodeName(op.opcode))
            break;
        }
    }

    /*
    // Add the returning block and a branch from the last VDBE instruction block to it
    auto endBlock = func.addBlock();
    builder.setInsertionPointToEnd(lastBlock);
    builder.create<mlir::BranchOp>(LOCB, endBlock);

    // Add a return operation in the returning block
    builder.setInsertionPointToStart(endBlock);
    auto return0 = builder.create<mlir::ConstantIntOp>(LOCB, 0, 32);
    builder.create<mlir::ReturnOp>(LOCB, (mlir::Value)return0);
    */

    // If the map is not empty, then we didn't generate the destination block of some branches.
    assert(operations_to_update.empty());
}

void prepareFunction(MLIRContext& context, LLVMDialect* llvmDialect, ModuleOp& theModule) {
    static_assert(sizeof(int*) == 8, "sizeof(int*) is assumed to be 8!");
    auto ctx = &context;
    auto vdbeDialect = context.getRegisteredDialect<mlir::standalone::StandaloneDialect>();
    assert(vdbeDialect && "No VDBE Dialect registered");
    auto* vdbeCtx = &vdbeDialect->vdbeContext;
    auto* vdbe = vdbeCtx->vdbe;

    auto builder = mlir::OpBuilder(ctx);
    builder.setInsertionPointToStart(theModule.getBody());

    assert(vdbeCtx->regInstances.empty() && "Registers vector should be empty at that point!");
    for(auto i = 0llu; i < vdbe->nMem; i++) {
        vdbeCtx->regInstances.emplace_back(&vdbe->aMem[i]);
    }

    auto inTypes = mlir::ArrayRef<mlir::Type>{
            T::VdbePtrTy
    };

    auto funcTy = builder.getFunctionType(inTypes, builder.getIntegerType(32));
    auto func = mlir::FuncOp::create(LOCB, JIT_MAIN_FN_NAME, funcTy);
    theModule.push_back(func);

    writeFunction(context, llvmDialect, func);
}
