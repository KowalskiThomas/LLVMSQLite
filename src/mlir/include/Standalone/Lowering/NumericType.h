struct ConstantManager;

struct Vdbe;
struct VdbeOp;

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
    struct NumericType {
        Printer& printer;
        ConstantManager& constantManager;
        MLIRContext& mlirContext;
        OpBuilder& rewriter;

        NumericType(MLIRContext&, OpBuilder&, Printer&, ConstantManager&);

        Value operator()(Location, Value);
    };
}