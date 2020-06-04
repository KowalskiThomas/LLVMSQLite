#include "Standalone/AllIncludes.h"
#include "Standalone/TypeDefinitions.h"
#include "Standalone/ConstantManager.h"
#include "Standalone/StandalonePrerequisites.h"

struct MyAssertOperator {
    using OpBuilder = mlir::OpBuilder;
    USING_OPS

    OpBuilder& rewriter;
    ConstantManager& constants;
    MLIRContext* ctx;
    const char* fileName;

    MyAssertOperator(OpBuilder& rewriter, ConstantManager& constants, MLIRContext* ctx, const char* fileName)
            : rewriter(rewriter), constants(constants), ctx(ctx), fileName(fileName)
    {
    }

    void operator()(mlir::Location loc, size_t line, mlir::Value val);
};
