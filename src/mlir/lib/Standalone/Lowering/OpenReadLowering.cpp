#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"
#include "Standalone/Lowering/Printer.h"
#include "Standalone/ConstantManager.h"
#include "Standalone/Lowering/MyBuilder.h"
#include "Standalone/Lowering/AssertOperator.h"
#include "Standalone/ErrorCodes.h"

namespace mlir::standalone::passes {
    LogicalResult OpenReadLowering::matchAndRewrite(OpenRead orOp, PatternRewriter &rewriter) const {
        auto op = &orOp;
        LOWERING_PASS_HEADER
        LOWERING_NAMESPACE
        ConstantManager constants(rewriter, ctx);
        Printer print(ctx, rewriter, __FILE_NAME__);
        MyAssertOperator myAssert(rewriter, constants, ctx, __FILE_NAME__);
        MyBuilder builder(ctx, constants, rewriter);
        myOperators
        
        mlir::Value curIdx = constants(orOp.curIdxAttr().getSInt(), 32);
        mlir::Value databaseIdx = constants(orOp.databaseAttr().getSInt(), 32);

        auto pc = orOp.counterAttr().getUInt();
        auto pOp = &vdbe->aOp[pc];
        auto dbAttr = orOp.databaseAttr().getSInt();

        print(LOCL, "-- OpenRead");
        USE_DEFAULT_BOILERPLATE

        auto p = vdbeCtx->p;

        auto dbAddr = getElementPtrImm(LOC, T::sqlite3PtrTy.getPointerTo(), p, 0, 0);
        auto db = load(LOC, dbAddr);
        auto aDbAddr = getElementPtrImm(LOC, T::DbPtrTy.getPointerTo(), db, 0, 4);
        auto aDb = load(LOC, aDbAddr);

        auto pDb = getElementPtrImm(LOC, T::DbPtrTy, aDb, dbAttr);

        auto ppX = getElementPtrImm(LOC, T::BtreePtrTy.getPointerTo(), pDb, 0, 1);

        auto pX = load(LOC, ppX);

        // TODO: pOp->opcode == OpenWrite ...

        auto wrFlag = constants(0, 32);

        auto p5Value = orOp.P5Attr().getUInt();
        Value rootPage = constants(orOp.rootPageAttr().getSInt(), 32);
        // If P5 says that P2 is a register (and not an integer)
        if (p5Value & OPFLAG_P2ISREG) {
            // Get the address at which the array of sqlite3_value (aMem) starts
            auto addressOfRegisters = vdbeCtx->aMem;
            // Get the address of the value we're looking for
            auto adressOfValue = getElementPtrImm
                    (LOC,
                     T::doublePtrTy, // Union has a double only
                     addressOfRegisters, /* This is the address of the sqlite3_value array */
                     rootPage, 0, 0);

            out("TODO: Add 3826 sqlite3VdbeMemIntegerify(pIn2);")
            exit(INCOMPLETE_LOWERING_USED);

            // Load the content at the address of the union
            auto regContent = load(LOC, adressOfValue);
            // Register contains a union -> BitCast it to i64
            auto valueOfRegisterP2 = bitCast(LOC, regContent, T::i64Ty);
            // rootPage is supposed to be an i32 -> Truncate
            auto valueAsI32 = trunc(LOC, valueOfRegisterP2, T::i32Ty);
            // Update what rootPage is
            rootPage = valueAsI32;
        }

        auto pKeyInfo = constants(T::KeyInfoPtrTy, (KeyInfo*)nullptr);
        Value nField;
        assert(pOp->p4type == P4_INT32 || pOp->p4type == P4_KEYINFO);
        if (pOp->p4type == P4_INT32) {
            nField = constants(orOp.P4Attr().getUInt(), 32);
        } else {
            pKeyInfo = constants(T::KeyInfoPtrTy, (KeyInfo*)orOp.P4Attr().getUInt());
            auto nAllFieldAddr = getElementPtrImm(LOC, T::i16PtrTy, pKeyInfo, 0, 3);
            nField = load(LOC, nAllFieldAddr);
            nField = zExt(LOC, nField, T::i32Ty);
        }

        auto pCur = call
                (LOC, f_allocateCursor, mlir::ValueRange{
                    p,
                    curIdx,
                    nField,
                    databaseIdx,
                    constants(CURTYPE_BTREE, 8)
                }).getValue();

        // pCur->nullRow = 1;
        auto pNullRow = getElementPtrImm(LOC, T::i8PtrTy, pCur, 0, 2);
        store(LOC, constants(1, 8), pNullRow);

        // pCur->isOrdered = 1;
        auto pMixedParameters = getElementPtrImm(LOC, T::i8PtrTy, pCur, 0, 5);

        Value curValue = load(LOC, pMixedParameters);

        curValue = bitOr(LOC, curValue, 4);
        store(LOC, curValue, pMixedParameters);

        // pCur->pgnoRoot = p2;
        auto ppgnoRootAddr = getElementPtrImm(LOC, T::i32PtrTy, pCur, 0, 15);

        store(LOC, rootPage, ppgnoRootAddr);

        auto pCur_uc_pCursor_addr = getElementPtrImm
                (LOC, T::BtCursorPtrTy.getPointerTo(), pCur,
                    0,  // &*pCur
                    12, // &pCur->uc
                    0   // &pCur->uc.pCursor
                );

        auto pCur_uc_pCursor = load(LOC, pCur_uc_pCursor_addr);

        auto rc = call
                (LOC, f_sqlite3BtreeCursor, ValueRange{
                    pX, rootPage, wrFlag, pKeyInfo, pCur_uc_pCursor
                }).getValue();

        // print(LOCL, rc, "Value returned by sqlite3_BtreeCursor:");

        /// pCur->pKeyInfo = pKeyInfo;
        auto ppKeyInfo = getElementPtrImm(LOC, T::KeyInfoPtrTy.getPointerTo(), pCur, 0, 13);

        store(LOC, pKeyInfo, ppKeyInfo);

        /// pCur->isTable = pOp->p4type != P4_KEYINFO;
        auto isTableAddr = getElementPtrImm(LOC, T::i8PtrTy, pCur, 0, 4);
        store(LOC, constants(pOp->p4type != P4_KEYINFO ? 1 : 0, 8), isTableAddr);

        unsigned hint = p5Value & (OPFLAG_BULKCSR | OPFLAG_SEEKEQ);
        call(LOC, f_sqlite3BtreeCursorHintFlags, ValueRange{
            pCur_uc_pCursor, constants(hint, 32)
        });

        { // if (rc) goto abort_due_to_error
            auto rcNull = rewriter.create<ICmpOp>
                (LOC, Pred::eq,
                    rc, constants(0, 32)
                );
            myAssert(LOCL, rcNull);
        } // end if (rc) goto abort_due_to_error

        rewriter.eraseOp(orOp);
        return success();
    } // matchAndRewrite
} // namespace mlir::standalone::passes