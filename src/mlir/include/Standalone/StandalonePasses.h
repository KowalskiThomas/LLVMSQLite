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

        class InitLowering : public mlir::OpRewritePattern<InitOp> {
        public:
            using OpRewritePattern<InitOp>::OpRewritePattern;

            LogicalResult matchAndRewrite(InitOp op, PatternRewriter& rewriter) const override;
        };

        DECLARE_LOWERING(Noop)
        DECLARE_LOWERING(Goto)
        DECLARE_LOWERING(Halt)
        DECLARE_LOWERING(OpenRead)
        DECLARE_LOWERING(Rewind)
        DECLARE_LOWERING(Column)
        DECLARE_LOWERING(ResultRow)
        DECLARE_LOWERING(Next)
        DECLARE_LOWERING(Transaction)
        DECLARE_LOWERING(Null)
        DECLARE_LOWERING(AggFinal)
        DECLARE_LOWERING(AggStep)
        DECLARE_LOWERING(Copy)
        DECLARE_LOWERING(SorterOpen)
        DECLARE_LOWERING(Integer)
        DECLARE_LOWERING(Gosub)
        DECLARE_LOWERING(MakeRecord)
        DECLARE_LOWERING(SorterInsert)
        DECLARE_LOWERING(OpenPseudo)
        DECLARE_LOWERING(SorterSort)
        DECLARE_LOWERING(SorterData)
        DECLARE_LOWERING(SorterNext)
        DECLARE_LOWERING(Compare)
        DECLARE_LOWERING(Jump)
        DECLARE_LOWERING(Move)
        DECLARE_LOWERING(IfPos)
        DECLARE_LOWERING(Return)
        DECLARE_LOWERING(Arithmetic)
        DECLARE_LOWERING(Real)
        DECLARE_LOWERING(String)
        DECLARE_LOWERING(String8)
        DECLARE_LOWERING(Variable)
        DECLARE_LOWERING(If)
        DECLARE_LOWERING(CompareJump)
        DECLARE_LOWERING(Once)
        DECLARE_LOWERING(Function)

        } // namespace passes
    } // namespace standalone
} // namespace mlir

#undef DECLARE_LOWERING
