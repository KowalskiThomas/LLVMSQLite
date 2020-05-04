#include "Standalone/Utils.h"
#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"

namespace mlir {
namespace standalone {
namespace passes {
namespace {
    static void useMacros() {
        auto *ctx = std::declval<mlir::MLIRContext *>();
        auto &builder = *std::declval<mlir::OpBuilder *>();
        auto &rewriter = *std::declval<mlir::ConversionPatternRewriter *>();
        auto &val = *std::declval<mlir::Value*>();
        auto *vdbe = static_cast<Vdbe*>(nullptr);
        auto *vdbeCtx = std::declval<VdbeContext*>();
        PROGRESSB("__unused__");
        PROGRESS("__unused__");
        PROGRESS_PRINT_PTR(val, "__unused__");
        {
            out("__unused__");
        }
        {
            auto op = static_cast<mlir::ModuleOp*>(nullptr);
            LOWERING_PASS_HEADER
        }
        {
            PTR_TO_P1(0);
            PTR_TO_P2(0);
            PTR_TO_P3(0);
            PTR_TO_P4(0);
            PTR_TO_P5(0);
            PTR_TO_REGISTER(0);
        }
    }
} // namespace

/*
mlir::LogicalResult
Plus32Lowering::matchAndRewrite(mlir::Operation *op, llvm::ArrayRef<mlir::Value> operands,
                                                  mlir::ConversionPatternRewriter &rewriter) const {
    auto *llvmDialect = op->getContext()->getRegisteredDialect<LLVM::LLVMDialect>();
    assert(llvmDialect && "expected llvm dialect to be registered");
    auto *ctx = op->getContext();
    ModuleOp parentModule = op->getParentOfType<ModuleOp>();

    auto thirtyTwo = rewriter.create<ConstantIntOp>(LOC, 32, 32);
    auto inputValue = op->getOperand(0);
    auto result = rewriter.create<AddIOp>(LOC, thirtyTwo, inputValue);

    rewriter.replaceOp(op, { result });
    return success();
}

mlir::LogicalResult InitRegLowering::matchAndRewrite(mlir::Operation *op, llvm::ArrayRef<mlir::Value> operands,
                                                   mlir::ConversionPatternRewriter &rewriter) const {
    auto *llvmDialect = op->getContext()->getRegisteredDialect<LLVM::LLVMDialect>();
    assert(llvmDialect && "expected llvm dialect to be registered");
    auto* ctx = op->getContext();
    ModuleOp parentModule = op->getParentOfType<ModuleOp>();

    auto intTy = LLVM::LLVMType::getInt32Ty(llvmDialect);
    auto structTy = T::sqlite3_valuePtrTy;
    auto structPtrTy = structTy.getPointerTo();
    auto constInt = IntegerAttr::get(IntegerType::get(32, rewriter.getContext()), 1);
    auto iOne = rewriter.create<LLVM::ConstantOp>(LOC, intTy, constInt);
    auto s = rewriter.create<LLVM::AllocaOp>(LOC, structTy.getPointerTo(), iOne, 0);

    auto s2 = rewriter.create<LLVM::AllocaOp>(LOC, structPtrTy.getPointerTo(), iOne, 0);
    auto s3 = rewriter.create<LLVM::StoreOp>(LOC, s, s2);

    rewriter.replaceOp(op, { iOne });
    return success();
}
*/

mlir::LogicalResult IntegerLowering::matchAndRewrite(mlir::Operation *op, llvm::ArrayRef<mlir::Value> operands,
                                                   mlir::ConversionPatternRewriter &rewriter) const {
    auto *llvmDialect = op->getContext()->getRegisteredDialect<LLVM::LLVMDialect>();
    assert(llvmDialect && "expected llvm dialect to be registered");
    auto* ctx = op->getContext();
    ModuleOp parentModule = op->getParentOfType<ModuleOp>();

    auto result = rewriter.create<ConstantIntOp>(LOC, 123, 32);
    rewriter.eraseOp(op);
    return success();
}

mlir::LogicalResult OpenCursorLowering::matchAndRewrite(mlir::Operation *op, llvm::ArrayRef<mlir::Value> operands,
                                                   mlir::ConversionPatternRewriter &rewriter) const {
    auto *llvmDialect = op->getContext()->getRegisteredDialect<LLVM::LLVMDialect>();
    assert(llvmDialect && "expected llvm dialect to be registered");
    ModuleOp parentModule = op->getParentOfType<ModuleOp>();

    auto *ctx = llvmDialect->getContext();

    auto firstParam = operands[0];
    auto secondParam = operands[1];
    auto result2 = rewriter.create<mlir::LLVM::CallOp>(LOC, addFunction, ArrayRef<Value>{ firstParam, secondParam });

    PROGRESS("add has been called and returned");

    rewriter.replaceOp(op, { result2.getResult(0) });
    return success();
}
} // namespace passes
} // namespace standalone
} // namespace mlir
