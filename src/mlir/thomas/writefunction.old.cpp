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

auto *block2 = func.addBlock();
auto br = builder.create<mlir::BranchOp>(LOCB, block2);
auto builder1 = builder;
builder.setInsertionPointToStart(block2);


auto ii = builder.create<mlir::ConstantIntOp>(LOCB, 123, 64);
builder.create<mlir::standalone::InitOp>(LOCB, ii);

auto* block3 = func.addBlock();
br.getOperation()->getBlockOperands()[0].set(block3);
br = builder.create<mlir::BranchOp>(LOCB, block3);
auto builder2 = builder;
builder.setInsertionPointToStart(block3);

auto i32Type = builder.getIntegerType(32);
auto input = builder.create<mlir::ConstantIntOp>(LOCB, 48, 32);
auto result = builder.create<mlir::standalone::Plus32Op>(LOCB, i32Type, input);

auto* block4 = func.addBlock();
br = builder.create<mlir::BranchOp>(LOCB, block4);
builder.setInsertionPointToStart(block4);

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

// auto ip = builder.saveInsertionPoint();

/*
auto blocks = llvm::SmallVector<mlir::Block*, 256>();
for(auto i = 0; i < vdbe->nOp; i++) {
    auto block = func.addBlock();
    blocks.push_back(block);
}
auto endBlock = func.addBlock();
for(auto i = 0; i < vdbe->nOp - 1; i++) {
    auto block = blocks[i];
    auto nextBlock = blocks[i + 1];
    builder.setInsertionPointToStart(block);
    builder.create<mlir::BranchOp>(LOCB, nextBlock);
}
builder.setInsertionPointToStart(blocks.back());
builder.create<mlir::BranchOp>(LOCB, endBlock);

builder.setInsertionPointToStart(endBlock);

builder.restoreInsertionPoint(ip);
builder.create<mlir::BranchOp>(LOCB, blocks.front());
*/
