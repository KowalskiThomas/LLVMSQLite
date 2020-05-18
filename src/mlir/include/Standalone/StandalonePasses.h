#include "Standalone/AllIncludes.h"

#include "Standalone/StandaloneDialect.h"
#include "Standalone/StandaloneOps.h"

#define DECLARE_LOWERING(op) \
    class op##Lowering : public mlir::OpRewritePattern<op> { \
    public: \
        using mlir::OpRewritePattern<op>::OpRewritePattern; \
         \
        LogicalResult matchAndRewrite(op, PatternRewriter& rewriter) const override; \
    };

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

        class HaltLowering : public mlir::OpRewritePattern<Halt> {
        public:
            using mlir::OpRewritePattern<Halt>::OpRewritePattern;

            LogicalResult matchAndRewrite(Halt op, PatternRewriter& rewriter) const override;
        };

        class OpenReadLowering : public mlir::OpRewritePattern<OpenRead> {
        public:
            using mlir::OpRewritePattern<OpenRead>::OpRewritePattern;

            LogicalResult matchAndRewrite(OpenRead orOp, PatternRewriter& rewriter) const override;
        };

        class RewindLowering : public mlir::OpRewritePattern<Rewind> {
        public:
            using mlir::OpRewritePattern<Rewind>::OpRewritePattern;

            LogicalResult matchAndRewrite(Rewind rewindOp, PatternRewriter& rewriter) const override;
        };

        class ColumnLowering : public mlir::OpRewritePattern<Column> {
        public:
            using mlir::OpRewritePattern<Column>::OpRewritePattern;

            LogicalResult matchAndRewrite(Column rewindOp, PatternRewriter& rewriter) const override;
        };

        class ResultRowLowering : public mlir::OpRewritePattern<ResultRow> {
        public:
            using mlir::OpRewritePattern<ResultRow>::OpRewritePattern;

            LogicalResult matchAndRewrite(ResultRow rewindOp, PatternRewriter& rewriter) const override;
        };

        class NextLowering : public mlir::OpRewritePattern<Next> {
        public:
            using mlir::OpRewritePattern<Next>::OpRewritePattern;

            LogicalResult matchAndRewrite(Next rewindOp, PatternRewriter& rewriter) const override;
        };

        class TransactionLowering : public mlir::OpRewritePattern<Transaction> {
        public:
            using mlir::OpRewritePattern<Transaction>::OpRewritePattern;

            LogicalResult matchAndRewrite(Transaction txnOp, PatternRewriter& rewriter) const override;
        };

        DECLARE_LOWERING(Null)
        DECLARE_LOWERING(AggFinal)
        DECLARE_LOWERING(AggStep)
        DECLARE_LOWERING(Copy)

        } // namespace passes
    } // namespace standalone
} // namespace mlir