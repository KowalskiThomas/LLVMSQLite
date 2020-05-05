#include "Standalone/AllIncludes.h"

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

        class GotoLowering : public mlir::OpRewritePattern<Goto> {
        public:
            using mlir::OpRewritePattern<Goto>::OpRewritePattern;

            LogicalResult matchAndRewrite(Goto op, PatternRewriter& rewriter) const override;
        };

        } // namespace passes
    } // namespace standalone
} // namespace mlir