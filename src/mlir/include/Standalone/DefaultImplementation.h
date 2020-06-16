#pragma once

#include <cassert>

#include "Standalone/StandaloneDialect.h"
#include "Standalone/StandaloneOps.h"

bool useDefaultImpl(mlir::Operation* op);

/**
 * This macro inserts the code required to possibly call the default implementation of an operation.
 * Whether the default implementation should be called is determined by calling `useDefaultImpl(Operation*)`
 */
#define USE_DEFAULT_BOILERPLATE \
    if (useDefaultImpl(op->getOperation())) { \
        rewriter.create<StoreOp>(LOC, constants(1, 64), constants(T::i64PtrTy, &maxVdbeSteps)); \
        rewriter.create<StoreOp>(LOC, constants(pc, 32), constants(T::i32PtrTy, &vdbe->pc)); \
        rewriter.create<CallOp>(LOC, f_sqlite3VdbeExec2, ValueRange {constants(T::VdbePtrTy, vdbe) }); \
        rewriter.eraseOp(*op); \
        \
        if (op->getOperation()->isKnownTerminator()) { \
            rewriter.create<BranchOp>(LOC, vdbeCtx->jumpsBlock); \
        } \
        \
        return success(); \
    }
