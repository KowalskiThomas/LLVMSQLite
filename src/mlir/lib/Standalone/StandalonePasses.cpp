#include "Standalone/Utils.h"
#include "Standalone/StandalonePasses.h"
#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"

namespace mlir::standalone::passes {
namespace {
    static void useMacros() {
        auto *ctx = (mlir::MLIRContext *)(nullptr);
        auto &builder = *(mlir::OpBuilder *)(nullptr);
        auto &rewriter = *(mlir::ConversionPatternRewriter *)(nullptr);
        auto &val = *(mlir::Value *)(nullptr);
        auto *vdbe = (Vdbe *)(nullptr);
        auto *vdbeCtx = (VdbeContext *)(nullptr);
        {
            out("__unused__")
            err("__unused__");
            debug("__unused__");
        }
        {
            auto op = static_cast<mlir::ModuleOp *>(nullptr);
            LOWERING_PASS_HEADER
        }
    }
} // namespace
} // namespace mlir::standalone::passes
