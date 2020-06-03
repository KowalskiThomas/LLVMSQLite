#include <llvm/Support/DynamicLibrary.h>

#include <src/mlir/include/Standalone/ConstantManager.h>
#include <src/mlir/include/Standalone/Lowering/MyBuilder.h>
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/Lowering/Printer.h"

#include "Standalone/StandalonePasses.h"


namespace mlir::standalone::passes {
    LogicalResult String8Lowering::matchAndRewrite(String8 strOp, PatternRewriter &rewriter) const {
        auto op = &strOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE

        ConstantManager constants(rewriter, ctx);
        MyBuilder builder(ctx, constants, rewriter);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        Printer print(ctx, rewriter, __FILE_NAME__);
        myOperators

        err("String8 should not be used!");
        exit(123);

        auto firstBlock = rewriter.getBlock();

        // pc = Programme Counter
        auto pc = strOp.pcAttr().getUInt();
        // regTo = p2
        auto regTo = strOp.regToAttr().getSInt();
        // string = p4
        auto string = (const char*)strOp.stringAttr().getUInt();


        if (true) {
            // TODO: Use our own implementation
            print(LOCL, "Calling into default implementation");
            rewriter.create<StoreOp>(LOC, constants(1, 64), constants(T::i64PtrTy, &maxVdbeSteps));
            rewriter.create<StoreOp>(LOC, constants(pc, 32), constants(T::i32PtrTy, &vdbe->pc));
            rewriter.create<CallOp>(LOC, f_sqlite3VdbeExec2, ValueRange{
                    constants(T::VdbePtrTy, vdbe)
            });
            rewriter.eraseOp(*op);
            return success();
        }


        auto curBlock = rewriter.getBlock();
        auto endBlock = curBlock->splitBlock(strOp); GO_BACK_TO(curBlock);

        branch(LOC, endBlock);

        ip_start(endBlock);

        myAssert(LOCL, constants(0, 1));

        rewriter.eraseOp(strOp);

        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes