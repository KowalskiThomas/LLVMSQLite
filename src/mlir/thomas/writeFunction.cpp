#include <unordered_map>
#include "sqlite_bridge.h"

#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/StandaloneDialect.h"
#include "Standalone/StandaloneOps.h"
#include "Standalone/StandalonePassManager.h"
#include "Standalone/StandalonePasses.h"
#include "Standalone/TypeDefinitions.h"

#include "Standalone/VdbeContext.h"

#include "tsrc/vdbe.h"

using MLIRContext = mlir::MLIRContext;
using LLVMDialect = mlir::LLVM::LLVMDialect;
using ModuleOp = mlir::ModuleOp;
using FuncOp = mlir::FuncOp;

void writeFunction(MLIRContext& mlirContext, LLVMDialect* llvmDialect, FuncOp& func) {
    auto ctx = &mlirContext;
    auto vdbeDialect = mlirContext.getRegisteredDialect<mlir::standalone::StandaloneDialect>();
    auto* vdbeCtx = &vdbeDialect->vdbeContext;
    auto* vdbe = vdbeCtx->vdbe;

    // All the blocks / operations we have already translated
    auto& blocks = vdbeCtx->blocks;

    // Operations that depend on a block that has not yet been built.
    // This map should be checked for at the end of every block / operation translation to update jumps.
    std::unordered_map<size_t, llvm::SmallVector<mlir::Operation*, 128>> operations_to_update;

    // Create an OpBuilder and make it write in the (new) function's entryBlock
    auto builder = mlir::OpBuilder(ctx);
    auto* entryBlock = func.addEntryBlock();
    builder.setInsertionPointToStart(entryBlock);

    // Each time we translate an instruction, we need to branch from its block to the next block
    // We store the last instruction's block to this end.
    mlir::Block* lastBlock = entryBlock;

    // Iterate over the VDBE programme
    bool writeBranchOut = true;
    for(auto pc = 0llu; pc < vdbe->nOp; pc++) {
        // Create a block for that operation
        auto block = func.addBlock();
        builder.setInsertionPointToStart(block);
        auto& op = vdbe->aOp[pc];

        out(pc << " " << sqlite3OpcodeName(op.opcode))

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
                auto param = builder.create<mlir::ConstantIntOp>(LOCB, op.p1, 64);
                builder.create<mlir::standalone::InitOp>(LOCB, param);
                break;
            }
            case OP_Noop: {
                auto pcParam = builder.create<mlir::ConstantIntOp>(LOCB, pc, 64);
                builder.create<mlir::standalone::Noop>(LOCB, pcParam);
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
                auto op = builder.create<mlir::standalone::Goto>(LOCB, toBlock);

                // If the destination block hasn't been created yet, add this operation to the
                // ones that need to be updated when the destination block is created
                if (toBlock == entryBlock) {
                    operations_to_update[toBlockPc].push_back(op.getOperation());
                }

                break;
            }
            case OP_Halt: {
                /* auto returnOp = */ builder.create<mlir::standalone::Halt>(LOCB);
                newWriteBranchOut = false;
                break;
            }
            case OP_OpenRead: {
                // TODO: Remove that
                // op.p2 = 5;
                // vdbe->aMem[5].u.i = 123;

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
                    builder.create<mlir::standalone::OpenRead>(LOCB,
                                                               CONSTANT_INT(curIdx, 32),
                                                               CONSTANT_INT(rootPage, 32),
                                                               CONSTANT_INT(dbIdx, 32),
                                                               CONSTANT_INT(p4.i, 32),
                                                               builder.getIntegerAttr(builder.getIntegerType(16, false), p5));
                }
                break;
            }
            case OP_Rewind: {
                auto curIdx = op.p1;
                auto jumpTo = op.p2;

                builder.create<mlir::standalone::Rewind>(LOCB,
                                                         CONSTANT_INT(curIdx, 32),
                                                         CONSTANT_INT(jumpTo, 32));

                break;
            }
        }

        // Add the block to the blocks map (for use in branches)
        blocks[pc] = block;

        // Update all instructions that branch to this instruction but couldn't refer to it before
        for(auto op : operations_to_update[pc]) {
            op->getBlockOperands()[0].set(block);
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
        if (op.opcode == OP_Rewind) {
            out("Exiting code generation early after OP_Rewind")
            break;
        }
    }

    // Add the returning block and a branch from the last VDBE instruction block to it
    auto endBlock = func.addBlock();
    builder.setInsertionPointToEnd(lastBlock);
    builder.create<mlir::BranchOp>(LOCB, endBlock);

    // Add a return operation in the returning block
    builder.setInsertionPointToStart(endBlock);
    auto return0 = builder.create<mlir::ConstantIntOp>(LOCB, 0, 32);
    builder.create<mlir::ReturnOp>(LOCB, (mlir::Value)return0);

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
            mlir::standalone::VdbeTypes::VdbeType::get(ctx),
            builder.getIntegerType(64),
            builder.getIntegerType(64)
    };

    auto funcTy = builder.getFunctionType(inTypes, builder.getIntegerType(32));
    auto func = mlir::FuncOp::create(LOCB, JIT_MAIN_FN_NAME, funcTy);
    theModule.push_back(func);

    writeFunction(context, llvmDialect, func);
}
