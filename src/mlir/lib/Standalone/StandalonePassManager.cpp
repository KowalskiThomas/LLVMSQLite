#include <Standalone/TypeDefinitions.h>
#include "mlir/IR/Types.h"
#include "mlir/IR/TypeSupport.h"

#include "Standalone/StandalonePassManager.h"
#include "Standalone/StandalonePasses.h"
#include "Standalone/StandaloneDialect.h"

namespace mlir {
    namespace standalone {
        struct VdbeTypeConverter : public mlir::LLVMTypeConverter {
            friend LogicalResult;

            using RegisterType = mlir::standalone::VdbeTypes::RegisterType;
            using VdbeType = mlir::standalone::VdbeTypes::VdbeType;

        public:
            Type convertRegister(RegisterType t) {
                if (t == RegisterType::get(&getContext())) {
                    return T::sqlite3_valuePtrTy;
                }
                llvm_unreachable("Trying to convert non-RegisterType with convertRegister!");
            }

            Type convertVdbe(VdbeType t) {
                if (t == VdbeType::get(&getContext())) {
                    return T::VdbePtrTy;
                }
                llvm_unreachable("Trying to convert non-VdbeType with convertVdbe!");
            }

            VdbeTypeConverter(MLIRContext *ctx)
                    : LLVMTypeConverter(ctx) {
                addConversion([&](RegisterType t) { return convertRegister(t); });
                addConversion([&](VdbeType t) { return convertVdbe(t); });
            }
        };
    } // namespace standalone
} // namespace mlir

void VdbeToLLVM::createBlocks() {
    auto mod = getOperation();

    auto vdbe = getVdbeContext()->vdbe;
    for(auto i = 0; i < vdbe->nOp; i++) {
        // auto block = mod
    }
}

VdbeContext* VdbeToLLVM::getVdbeContext() {
    return &getContext().getRegisteredDialect<mlir::standalone::StandaloneDialect>()->vdbeContext;
}

void VdbeToLLVM::runOnOperation() {
    mlir::ConversionTarget target(getContext());
    target.addLegalDialect<mlir::LLVM::LLVMDialect>();
    target.addLegalOp<mlir::ModuleOp, mlir::ModuleTerminatorOp>();

    mlir::standalone::VdbeTypeConverter typeConverter(&getContext());
    mlir::OwningRewritePatternList patterns;
    {
        using namespace mlir::standalone::passes;
        patterns.insert<InitLowering>(&getContext());
        patterns.insert<NoopLowering>(&getContext());
        patterns.insert<GotoLowering>(&getContext());
        patterns.insert<HaltLowering>(&getContext());
        patterns.insert<OpenReadLowering>(&getContext());
        patterns.insert<RewindLowering>(&getContext());
        patterns.insert<ColumnLowering>(&getContext());

        // patterns.insert<Plus32Lowering>(&getContext());
        // patterns.insert<InitRegLowering>(&getContext());
        // patterns.insert<IntegerLowering>(&getContext());
        // patterns.insert<OpenCursorLowering>(&getContext());

        mlir::populateStdToLLVMConversionPatterns(typeConverter, patterns);
    }



    mlir::ModuleOp module = getOperation();

    if (mlir::failed(mlir::applyFullConversion(module, target, patterns, &typeConverter))) {
        signalPassFailure();
    }
}