#include "Standalone/AllIncludes.h"
#include "Standalone/DefaultImplementation.h"

#include "Standalone/StandaloneDialect.h"
#include "Standalone/StandaloneOps.h"

#define DECLARE_LOWERING(op) \
    class op##Lowering : public mlir::OpRewritePattern<op> { \
    public: \
        using mlir::OpRewritePattern<op>::OpRewritePattern; \
         \
        LogicalResult matchAndRewrite(op, PatternRewriter& rewriter) const override; \
    };

namespace mlir::standalone::passes {
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
    DECLARE_LOWERING(CompareJump)
    DECLARE_LOWERING(Once)
    DECLARE_LOWERING(Function)
    DECLARE_LOWERING(OpenEphemeral)
    DECLARE_LOWERING(DeferredSeek)
    DECLARE_LOWERING(SeekRowid)
    DECLARE_LOWERING(Sequence)
    DECLARE_LOWERING(If)
    DECLARE_LOWERING(IfNot)
    DECLARE_LOWERING(IfNotZero)
    DECLARE_LOWERING(IfNullRow)
    DECLARE_LOWERING(NotNull)
    DECLARE_LOWERING(IsNull)
    DECLARE_LOWERING(Last)
    DECLARE_LOWERING(IdxCompare)
    DECLARE_LOWERING(Delete)
    DECLARE_LOWERING(IdxInsert)
    DECLARE_LOWERING(Rowid)
    DECLARE_LOWERING(NotFound)
    DECLARE_LOWERING(RowSetTest)
    DECLARE_LOWERING(Affinity)
    DECLARE_LOWERING(SeekGE)
    DECLARE_LOWERING(DecrJumpZero)
    DECLARE_LOWERING(CollSeq)
    DECLARE_LOWERING(SCopy)
    DECLARE_LOWERING(InitCoroutine)
    DECLARE_LOWERING(NullRow)
    DECLARE_LOWERING(Yield)
    DECLARE_LOWERING(EndCoroutine)
    DECLARE_LOWERING(Cast)
    DECLARE_LOWERING(ReadCookie)
    DECLARE_LOWERING(SetCookie)
    DECLARE_LOWERING(NewRowid)
    DECLARE_LOWERING(Blob)
    DECLARE_LOWERING(Insert)
    DECLARE_LOWERING(Close)
    DECLARE_LOWERING(ParseSchema)
    DECLARE_LOWERING(DropTable)
    DECLARE_LOWERING(RealAffinity)

} // namespace mlir::standalone::passes

#undef DECLARE_LOWERING
