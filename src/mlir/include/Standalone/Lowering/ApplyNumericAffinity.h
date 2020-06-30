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
    struct ApplyNumericAffinity {
        Printer& printer;
        ConstantManager& constantManager;
        MLIRContext& mlirContext;
        OpBuilder& rewriter;
        VdbeContext& vdbeCtx;

        ApplyNumericAffinity(VdbeContext&, MLIRContext&, OpBuilder&, Printer&, ConstantManager&);

        void operator()(Location, Value, Value);
        Value alsoAnInt(Location loc, Value pRec, Value rValue, Value out);
    };
}