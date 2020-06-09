struct ConstantManager;

struct Vdbe;
struct VdbeOp;

namespace mlir {
    struct Printer;
    class MLIRContext;
    class OpBuilder;
    class Value;
}

namespace mlir::standalone::Lowering {
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

        OutToPrerelease(MLIRContext&, OpBuilder&, Printer&, ConstantManager&);

        Value operator()(Vdbe*, VdbeOp*);
    };
}