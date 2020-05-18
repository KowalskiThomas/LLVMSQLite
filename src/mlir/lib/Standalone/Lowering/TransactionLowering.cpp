#include <llvm/Support/DynamicLibrary.h>

#include <src/mlir/include/Standalone/ConstantManager.h>
#include <src/mlir/include/Standalone/Lowering/MyBuilder.h>
#include "Standalone/AllIncludes.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"

#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"


namespace mlir::standalone::passes {
    LogicalResult TransactionLowering::matchAndRewrite(Transaction txnOp, PatternRewriter &rewriter) const {
        auto op = &txnOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        myOperators

        rewriter.eraseOp(txnOp);

        auto dbIdxAttr = txnOp.dbIdxAttr();
        auto isWriteAttr = txnOp.isWriteAttr();
        auto p3Attr = txnOp.P3Attr();
        auto p4Attr = txnOp.P4Attr();
        auto p5Attr = txnOp.P5Attr();

        auto dbIdx = dbIdxAttr.getSInt();
        auto isWrite = isWriteAttr.getSInt();
        auto p3Value = p3Attr.getSInt();
        auto p4Value = p4Attr.getSInt();
        auto p5Value = p5Attr.getSInt();

        // TODO: Implement this

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes