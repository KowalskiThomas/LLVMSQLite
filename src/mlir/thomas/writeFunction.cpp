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

void actuallyWriteFunction(MLIRContext& mlirContext, LLVMDialect* llvmDialect, FuncOp& func) {
    auto ctx = &mlirContext;
    auto vdbeDialect = mlirContext.getRegisteredDialect<mlir::standalone::StandaloneDialect>();
    auto* vdbeCtx = &vdbeDialect->vdbeContext;
    auto* vdbe = vdbeCtx->vdbe;

    auto builder = mlir::OpBuilder(ctx);
    auto entryBlock = func.addEntryBlock();
    builder.setInsertionPointToStart(entryBlock);

    mlir::Block* lastBlock = entryBlock;
    for(auto pc = 0llu; pc < vdbe->nOp; pc++) {
        auto block = func.addBlock();
        auto& op = vdbe->aOp[pc];

        out(pc << " " << sqlite3OpcodeName(op.opcode))
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

        }

        builder.setInsertionPointToEnd(lastBlock);
        builder.create<mlir::BranchOp>(LOCB, block);
        builder.setInsertionPointToStart(block);
        lastBlock = block;
    }

    auto endBlock = func.addBlock();
    builder.setInsertionPointToEnd(lastBlock);
    builder.create<mlir::BranchOp>(LOCB, endBlock);

    builder.setInsertionPointToStart(endBlock);
    auto return0 = builder.create<mlir::ConstantIntOp>(LOCB, 0, 32);
    builder.create<mlir::ReturnOp>(LOCB, (mlir::Value)return0);
}

void writeFunction(MLIRContext& context, LLVMDialect* llvmDialect, ModuleOp& theModule) {
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

    actuallyWriteFunction(context, llvmDialect, func);
}
