#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"

#include "Standalone/ConstantManager.h"

#define EXIT_PASS_EARLY(with_call_to_debug) { \
    if (with_call_to_debug) { \
        rewriter.create<CallOp>(LOC, f_debug, ValueRange{}); \
    } \
    rewriter.eraseOp(colOp); \
    err("QSDQSD EXIT EARLY"); \
    parentModule.dump(); \
    return success(); \
};

#define CALL_DEBUG { \
    rewriter.create<CallOp>(LOC, f_debug, ValueRange{}); \
};

namespace mlir {
    namespace standalone {
        namespace passes {
            LogicalResult ColumnLowering::matchAndRewrite(Column colOp, PatternRewriter &rewriter) const {
                auto op = &colOp;
                auto &builder = rewriter;
                LOWERING_PASS_HEADER
                LOWERING_NAMESPACE

                ConstantManager constants(rewriter, ctx);
                auto pVdbe = constants(T::VdbePtrTy, vdbe);

                auto curIdxAttr = colOp.getAttrOfType<mlir::IntegerAttr>("curIdx");
                auto columnAttr = colOp.getAttrOfType<mlir::IntegerAttr>("column");
                auto extractToAttr = colOp.getAttrOfType<mlir::IntegerAttr>("extractTo");
                auto defaultValueAttr = colOp.getAttrOfType<mlir::IntegerAttr>("defaultValue");
                auto flagsAttr = colOp.getAttrOfType<mlir::IntegerAttr>("flags");

                auto curIdxValue = constants(curIdxAttr.getValue().getLimitedValue(32), 32);
                auto extractToValue = constants(extractToAttr.getValue().getLimitedValue(32), 32);

                auto curIdx = rewriter.create<AllocaOp>(LOC, T::i32PtrTy, constants(1, 32), 0);
                rewriter.create<StoreOp>(LOC, curIdxValue, curIdx);

                PROGRESS_PRINT_INT(curIdxValue, "OP_Column: Cursor index");

                // The address of the array of (pointers to) cursors in the VDBE
                auto apCsr = constants(T::VdbeCursorPtrPtrTy, vdbe->apCsr);
                // The address of this particular pointer-to-cursor
                auto pCAddr = rewriter.create<GEPOp>(LOC, T::VdbeCursorPtrPtrTy, apCsr, ValueRange{curIdxValue});
                // The address of the cursor
                auto pCValue = rewriter.create<LoadOp>(LOC, pCAddr);
                auto pC = rewriter.create<AllocaOp>(LOC, T::VdbeCursorPtrPtrTy, constants(1, 32), 0);
                rewriter.create<StoreOp>(LOC, pCValue, pC);

                auto rc = rewriter.create<CallOp>(LOC, f_sqlite3VdbeCursorMoveto,
                                                  ValueRange{pC, curIdx}).getResult(0);

                // TODO: if (rc) goto abort_due_to_error;

                // pDest = &aMem[pOp->p3];
                // Initialise aMem with its actual value
                auto aMem = CONSTANT_PTR(T::sqlite3_valuePtrTy, vdbe->aMem);
                // Get the address of the P3'th (extractTo) element
                auto pDest = rewriter.create<GEPOp>(LOC, T::sqlite3_valuePtrTy, aMem,
                                                    ValueRange{extractToValue});

                // aOffset = pC->aOffset;
                auto aOffsetAddr = rewriter.create<GEPOp>
                        (LOC, T::i32PtrTy.getPointerTo(), pCValue,
                         ValueRange{
                                 constants(0, 32), // Address of *pC
                                 constants(19, 32)  // Address of aOffset in pC
                         });
                auto aOffset = rewriter.create<LoadOp>(LOC, aOffsetAddr);

                auto curBlock = rewriter.getBlock();

                /*
                auto blockCacheStatusNeqCacheCtr = rewriter.getBlock()->splitBlock(colOp);
                rewriter.setInsertionPoint(colOp);
                auto blockAfterCacheStatusNeqCachePtr = rewriter.getBlock()->splitBlock(colOp);
                rewriter.setInsertionPoint(colOp);
                auto blockNullRow = rewriter.getBlock()->splitBlock(colOp);
                rewriter.setInsertionPoint(colOp);
                auto blockNotNullRow = rewriter.getBlock()->splitBlock(colOp);
                rewriter.setInsertionPoint(colOp);
                auto blockCURTYPE_PSEUDO = rewriter.getBlock()->splitBlock(colOp);
                rewriter.setInsertionPoint(colOp);
                auto blockNotCURTYPE_PSEUDO = rewriter.getBlock()->splitBlock(colOp);
                */

                // Go back to the end of the current block to insert branching
                rewriter.setInsertionPointToEnd(curBlock);

                auto cacheStatusAddr = rewriter.create<GEPOp>
                        (LOC, T::i32PtrTy, pC,
                         ValueRange{
                                 constants(0, 32), // *pC
                                 constants(9, 32)  // Address of field cacheStatus
                         });
                auto cacheStatus = rewriter.create<LoadOp>(LOC, cacheStatusAddr);

                auto cacheCtrAddr = rewriter.create<GEPOp>
                        (LOC, T::i32PtrTy, pVdbe,
                                ValueRange{
                                    constants(0, 32), // *pVdbe
                                    constants(9, 32)  // Address of cacheCtr in Vdbe
                        });
                auto cacheCtr = rewriter.create<LoadOp>(LOC, cacheCtrAddr);

                CALL_DEBUG;
                EXIT_PASS_EARLY(false)

                auto nullRowAddr = nullptr;
                auto nullRow = nullptr;

                auto curTypeAddr = nullptr;


                rewriter.eraseOp(colOp);
                return success();
            } // matchAndRewrite
        } // namespace passes
    } // namespace standalone
} // namespace mlir