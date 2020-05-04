#include "sqlite_bridge.h"

#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/StandaloneDialect.h"
#include "Standalone/StandaloneOps.h"
#include "Standalone/StandalonePassManager.h"
#include "Standalone/StandalonePasses.h"
#include "Standalone/TypeDefinitions.h"

#include "Standalone/VdbeContext.h"

void writeFunction(mlir::MLIRContext& context, mlir::LLVM::LLVMDialect* llvmDialect, mlir::ModuleOp& theModule) {
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
        // auto addr = &vdbeCtx->regInstances.back();
        // auto attr = builder.getIntegerAttr(builder.getIndexType(), (uint64_t)addr);
        // auto constantOp = builder.create<mlir::LLVM::ConstantOp>(LOCB, T::sqlite3_valuePtrTy, attr);
        // vdbeCtx->registers.push_back(constantOp);
    }

    auto inTypes = mlir::ArrayRef<mlir::Type>{
            mlir::standalone::VdbeTypes::VdbeType::get(ctx),
            builder.getIntegerType(64),
            builder.getIntegerType(64)
    };
    auto funcTy = builder.getFunctionType(inTypes, builder.getIntegerType(32));
    auto func = mlir::FuncOp::create(LOCB, JIT_MAIN_FN_NAME, funcTy);
    theModule.push_back(func);

    auto *block = func.addEntryBlock();
    auto *block2 = func.addBlock();

    builder.setInsertionPointToStart(block);
    auto i = builder.create<mlir::ConstantIntOp>(LOCB, 32, 32);

    {
        mlir::Value cst0 = builder.create<mlir::LLVM::ConstantOp>(
                LOCB,
                mlir::LLVM::LLVMType::getInt32Ty(llvmDialect),
                builder.getIntegerAttr(builder.getIndexType(), 0));
        mlir::Value cst4 = builder.create<mlir::LLVM::ConstantOp>(
                LOCB,
                mlir::LLVM::LLVMType::getInt32Ty(llvmDialect),
                builder.getIntegerAttr(builder.getIndexType(), 4));

        auto mem = PTR_TO_REGISTER(0);
        auto ptr = builder.create<mlir::LLVM::GEPOp>(LOCB, T::doublePtrTy, mem, mlir::ArrayRef<mlir::Value>{ cst0, cst0, cst0 });
        auto d = builder.create<mlir::LLVM::ConstantOp>(LOCB, mlir::LLVM::LLVMType::getDoubleTy(llvmDialect),
                builder.getF64FloatAttr(123));
        auto s = builder.create<mlir::LLVM::StoreOp>(LOCB, d, ptr);
    }

    auto br = builder.create<mlir::BranchOp>(LOCB, block2);

    auto builder1 = builder;
    builder.setInsertionPointToStart(block2);

    auto ii = builder.create<mlir::ConstantIntOp>(LOCB, 123, 64);
    builder.create<mlir::standalone::InitOp>(LOCB, ii);

    auto i32Type = builder.getIntegerType(32);
    auto input = builder.create<mlir::ConstantIntOp>(LOCB, 48, 32);
    auto result = builder.create<mlir::standalone::Plus32Op>(LOCB, i32Type, input);

    mlir::Value i1 = builder.create<mlir::ConstantIntOp>(LOCB, 12, 32);
    mlir::Value i2 = builder.create<mlir::ConstantIntOp>(LOCB, 18, 32);
    auto test = builder.create<mlir::standalone::OpenCursorOp>(LOCB, i32Type, i1, i2);

    {
        auto reg = builder.create<mlir::standalone::InitReg>(LOCB);
        auto dataAttribute = builder.getIntegerAttr(builder.getIntegerType(32), 123123);
        auto intInReg = builder.create<mlir::standalone::IntegerOp>(LOCB, reg, dataAttribute);
    }

    {
        mlir::Value par1 = func.getArgument(0);
        mlir::Value par2 = func.getArgument(1);

        PROGRESS_PRINT_INT(par2, "param2");

        mlir::Value cst0 = builder.create<mlir::LLVM::ConstantOp>(
                LOCB,
                mlir::LLVM::LLVMType::getInt32Ty(llvmDialect),
                builder.getIntegerAttr(builder.getIndexType(), 0));
        mlir::Value cst4 = builder.create<mlir::LLVM::ConstantOp>(
                LOCB,
                mlir::LLVM::LLVMType::getInt32Ty(llvmDialect),
                builder.getIntegerAttr(builder.getIndexType(), 4));

        auto ptr = builder.create<mlir::LLVM::GEPOp>(LOCB, T::i16PtrTy, par1, mlir::ArrayRef<mlir::Value>{ cst0, cst4 });
        mlir::Value cst123 = builder.create<mlir::LLVM::ConstantOp>(
                 LOCB,
                 T::i16Ty,
                builder.getIntegerAttr(builder.getIndexType(), 123));
        builder.create<mlir::LLVM::StoreOp>(LOCB, cst123, ptr);

        PROGRESS_PRINT_PTR(par1, "Par1");
        PROGRESS_PRINT_PTR(ptr, "GEP Pointer");
        PROGRESSB("hello");
        builder.create<mlir::LLVM::StoreOp>(LOCB, cst123, ptr);
    }

    mlir::Value return0 = builder.create<mlir::ConstantIntOp>(LOCB, 0, 32);
    builder.create<mlir::ReturnOp>(LOCB, return0);
}
