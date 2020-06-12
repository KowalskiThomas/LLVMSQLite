#include "Standalone/ConstantManager.h"

mlir::Value ConstantManager::insertConstant(uint64_t x, size_t width) {
    /*
    if (constants.find(width) == constants.end()) {
        constants[width] = std::unordered_map<size_t, mlir::Value>{};
    }
    auto& c = constants[width];
    if (c.find(x) != c.end()) {
        return c[x];
    }
    */

    auto ty = mlir::LLVM::LLVMType::getIntNTy(ctx->getRegisteredDialect<mlir::LLVM::LLVMDialect>(), width);
    auto attr = rewriter.getIntegerAttr(rewriter.getIntegerType(width), x);
    // c[x] = rewriter.template create<mlir::LLVM::ConstantOp>(LOC, ty, attr);
    // return c[x];
    return rewriter.template create<mlir::LLVM::ConstantOp>(LOC, ty, attr);

    // Old version using mlir::ConstantIntOp
    // c[x] = rewriter.template create<mlir::ConstantIntOp>(LOC, (uint64_t)(x), width);
    // return c[x];
}
