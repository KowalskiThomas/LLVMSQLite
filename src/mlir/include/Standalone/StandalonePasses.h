#include <mlir/Pass/PassManager.h>
#include "mlir/IR/Dialect.h"
#include "mlir/IR/MLIRContext.h"
#include "mlir/InitAllDialects.h"
#include "mlir/InitAllPasses.h"
#include "mlir/Pass/Pass.h"
#include "mlir/Pass/Pass.h"
#include "mlir/Support/FileUtilities.h"
#include "mlir/Support/MlirOptMain.h"
#include "llvm/Support/CommandLine.h"
#include "mlir/Dialect/LLVMIR/LLVMDialect.h"
#include "mlir/Target/LLVMIR.h"
#include "llvm/Support/InitLLVM.h"
#include "llvm/Support/SourceMgr.h"
#include "llvm/Support/ToolOutputFile.h"
#include "mlir/Pass/Pass.h"

#include "Standalone/StandaloneDialect.h"
#include "Standalone/StandaloneOps.h"

namespace mlir {
    namespace standalone {
        namespace passes {
            /*
        class Plus32Lowering : public mlir::OpRewritePattern<Plus32Op> {
        public:
            using mlir::OpRewritePattern<Plus32Op>::OpRewritePattern;

            LogicalResult matchAndRewrite(Operation *op, ArrayRef<Value> operands, ConversionPatternRewriter &rewriter) const override;
        };

        class InitRegLowering : public mlir::ConversionPattern {
        public:
            explicit InitRegLowering(MLIRContext *context) : ConversionPattern(standalone::InitReg::getOperationName(), 1, context) {}

            LogicalResult matchAndRewrite(Operation *op, ArrayRef<Value> operands, ConversionPatternRewriter &rewriter) const override;
        };
             */

        class IntegerLowering : public mlir::ConversionPattern {
        public:
            explicit IntegerLowering(MLIRContext *context) : ConversionPattern(standalone::IntegerOp::getOperationName(), 1, context) {}

            LogicalResult matchAndRewrite(Operation *op, ArrayRef<Value> operands, ConversionPatternRewriter &rewriter) const override;
        };

        class OpenCursorLowering : public mlir::ConversionPattern {
        public:
            explicit OpenCursorLowering(MLIRContext* context) : ConversionPattern(standalone::OpenCursorOp::getOperationName(), 1, context) {}

            LogicalResult matchAndRewrite(Operation* op, ArrayRef<Value> operands, ConversionPatternRewriter& rewriter) const override;
        };

        class InitLowering : public mlir::OpRewritePattern<InitOp> {
        public:
            using OpRewritePattern<InitOp>::OpRewritePattern;

            LogicalResult matchAndRewrite(InitOp op, PatternRewriter& rewriter) const override;
        };

        class NoopLowering : public mlir::OpRewritePattern<Noop> {
        public:
            using OpRewritePattern<Noop>::OpRewritePattern;

            LogicalResult matchAndRewrite(Noop op, PatternRewriter& rewriter) const override;
        };

        class JumpLowering : public mlir::OpRewritePattern<Jump> {
        public:
            using mlir::OpRewritePattern<Jump>::OpRewritePattern;

            LogicalResult matchAndRewrite(Jump op, PatternRewriter& rewriter) const override;
        };

        } // namespace passes
    } // namespace standalone
} // namespace mlir