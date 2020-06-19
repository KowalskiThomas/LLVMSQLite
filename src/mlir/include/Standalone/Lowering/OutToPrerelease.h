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
     * Generates a code equivalent to a call to out2Prerelease
     * ```
     * Mem *out2Prerelease(Vdbe*, VdbeOp*);
     * ```
     */
    struct OutToPrerelease {
        Printer& printer;
        ConstantManager& constantManager;
        MLIRContext& mlirContext;
        OpBuilder& rewriter;
        VdbeContext& vdbeCtx;

        OutToPrerelease(VdbeContext&, MLIRContext&, OpBuilder&, Printer&, ConstantManager&);

        Value operator()(Location, Value, Value);
    };
}