#include "Standalone/Utils.h"
#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"

namespace mlir::standalone::passes {
namespace {
    static void useMacros() {
        auto *ctx = (mlir::MLIRContext *)(nullptr);
        auto &builder = *(mlir::OpBuilder *)(nullptr);
        auto &rewriter = *(mlir::ConversionPatternRewriter *)(nullptr);
        auto &val = *(mlir::Value *)(nullptr);
        auto *vdbe = (Vdbe *)(nullptr);
        auto *vdbeCtx = (VdbeContext *)(nullptr);
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
        }
    }
} // namespace

/*
mlir::LogicalResult IntegerLowering::matchAndRewrite(mlir::Operation *op, llvm::ArrayRef<mlir::Value> operands,
                                                   mlir::ConversionPatternRewriter &rewriter) const {
    auto *llvmDialect = op->getContext()->getRegisteredDialect<LLVM::LLVMDialect)(nullptr);
    assert(llvmDialect && "expected llvm dialect to be registered");
    auto* ctx = op->getContext();
    ModuleOp parentModule = op->getParentOfType<ModuleOp)(nullptr);

    auto result = rewriter.create<ConstantIntOp>(LOC, 123, 32);
    rewriter.eraseOp(op);
    return success();
}
*/

/*
mlir::LogicalResult OpenCursorLowering::matchAndRewrite(mlir::Operation *op, llvm::ArrayRef<mlir::Value> operands,
                                                   mlir::ConversionPatternRewriter &rewriter) const {
    auto *llvmDialect = op->getContext()->getRegisteredDialect<LLVM::LLVMDialect)(nullptr);
    assert(llvmDialect && "expected llvm dialect to be registered");
    ModuleOp parentModule = op->getParentOfType<ModuleOp)(nullptr);

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
