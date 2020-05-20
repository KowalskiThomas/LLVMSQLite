#include "Standalone/Utils.h"
#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"

namespace mlir::standalone::passes {
namespace {
    static void useMacros() {
        auto *ctx = std::declval<mlir::MLIRContext *>();
        auto &builder = *std::declval<mlir::OpBuilder *>();
        auto &rewriter = *std::declval<mlir::ConversionPatternRewriter *>();
        auto &val = *std::declval<mlir::Value *>();
        auto *vdbe = static_cast<Vdbe *>(nullptr);
        auto *vdbeCtx = std::declval<VdbeContext *>();
        PROGRESSB("__unused__")
        PROGRESS("__unused__")
        PROGRESS_PRINT_PTR(val, "__unused__")
        {
            out("__unused__")
        }
        {
            auto op = static_cast<mlir::ModuleOp *>(nullptr);
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
        {
            LLVM_CONSTANT_INT(T::i32Ty, 32, 0);
        }
        {
            CONSTANT_INT(32, 0);
        }
    }
} // namespace

/*
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
*/

/*
mlir::LogicalResult OpenCursorLowering::matchAndRewrite(mlir::Operation *op, llvm::ArrayRef<mlir::Value> operands,
                                                   mlir::ConversionPatternRewriter &rewriter) const {
    auto *llvmDialect = op->getContext()->getRegisteredDialect<LLVM::LLVMDialect>();
    assert(llvmDialect && "expected llvm dialect to be registered");
    ModuleOp parentModule = op->getParentOfType<ModuleOp>();

    auto *ctx = llvmDialect->getContext();

    auto firstParam = operands[0];
    auto secondParam = operands[1];
    assert(false && "We should not be lowering ADDs");
    // auto result2 = rewriter.create<mlir::LLVM::CallOp>(LOC, addFunction, ArrayRef<Value>{ firstParam, secondParam });

    // rewriter.replaceOp(op, { result2.getResult(0) });
    return success();
}
*/
} // namespace mlir::standalone::passes
