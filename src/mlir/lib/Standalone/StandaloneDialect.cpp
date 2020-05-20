#include "Standalone/StandaloneDialect.h"
#include "Standalone/StandaloneOps.h"
#include "mlir/Dialect/Linalg/IR/LinalgOps.h"
#include "mlir/Dialect/Linalg/IR/LinalgTypes.h"
#include "mlir/Dialect/StandardOps/IR/Ops.h"
#include "mlir/IR/AffineExpr.h"
#include "mlir/IR/AffineMap.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/Module.h"
#include "mlir/IR/OpImplementation.h"
#include "mlir/IR/PatternMatch.h"
#include "mlir/IR/StandardTypes.h"
#include "mlir/IR/DialectImplementation.h"

#include "llvm/Support/raw_ostream.h"

using namespace mlir;
using namespace mlir::standalone;

StandaloneDialect::StandaloneDialect(mlir::MLIRContext *context)
        : Dialect(getDialectNamespace(), context) {
    addOperations<
#define GET_OP_LIST
#include "Standalone/StandaloneOps.cpp.inc"
    >();

    addTypes<VdbeTypes::ProgrammeCounterType, VdbeTypes::RegisterType, VdbeTypes::VdbeType>();

    mlir::registerDialect<StandaloneDialect>();
}

void StandaloneDialect::setVdbe(Vdbe* vdbe) {
    vdbeContext.vdbe = vdbe;
}

void StandaloneDialect::printType(Type type, DialectAsmPrinter &os) const {
    switch (type.getKind()) {
        default:
            llvm_unreachable("Unknown type to print!");

        case mlir::standalone::VdbeTypes::Kind::Vdbe:
            os << "VdbeInstance";
            break;
        case mlir::standalone::VdbeTypes::Kind::Register:
            os << "Register";
            break;
        case mlir::standalone::VdbeTypes::Kind::ProgrammeCounter:
            os << "ProgCount";
            break;
    }
}
