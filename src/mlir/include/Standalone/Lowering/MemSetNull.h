struct ConstantManager;

struct Vdbe;
struct VdbeOp;
struct VdbeContext;

namespace mlir {
    struct Printer;
    class MLIRContext;
    class OpBuilder;
    class Value;
    class Location;
}

namespace mlir::standalone::passes::Inlining {
    /**
     * Generates a code equivalent to a call to applyNumericAffinity
     * ```
     * Mem *applyNumericAffinity(Mem*, int);
     * ```
     */
    struct MemSetNull {
        Printer& printer;
        ConstantManager& constantManager;
        MLIRContext& mlirContext;
        OpBuilder& rewriter;
        VdbeContext& vdbeCtx;

        MemSetNull(VdbeContext&, MLIRContext&, OpBuilder&, Printer&, ConstantManager&);

        Value operator()(Location, Value pMem);
    };
}