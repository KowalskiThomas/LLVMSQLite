#include <llvm/Support/DynamicLibrary.h>

#include "Standalone/ConstantManager.h"
#include "Standalone/Lowering/MyBuilder.h"
#include "Standalone/AllIncludes.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"

#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"


#define INTEGER_ATTR(width, signed, value) rewriter.getIntegerAttr(rewriter.getIntegerType(width, signed), value)

namespace mlir::standalone::passes {
    LogicalResult SorterSortLowering::matchAndRewrite(SorterSort ssOp, PatternRewriter &rewriter) const {
        auto op = &ssOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        myOperators

        assert(false && "SorterSortLowering should not be called!");

        auto firstBlock = rewriter.getBlock();

        auto curIdx = ssOp.curIdxAttr().getSInt();

        auto jumpToIfEmpty = ssOp.jumpToIfEmpty();
        auto fallthrough = ssOp.fallthrough();

        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(ssOp); GO_BACK_TO(curBlock);

        // branch(LOC, endBlock);

        // ip_start(endBlock);

        // branch(LOC, fallthrough);

        rewriter.create<mlir::standalone::Rewind>
            (LOC,
                 INTEGER_ATTR(32, true, curIdx),
                 jumpToIfEmpty,
                 fallthrough
             );
        // rewriter.eraseOp(ssOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes