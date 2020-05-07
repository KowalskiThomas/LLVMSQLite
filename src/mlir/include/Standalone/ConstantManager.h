#include "AllIncludes.h"
#include "Utils.h"

#pragma once

namespace std {
    /**
     * A simple hash operator for mlir::Type (used for std::unordered_map in ConstantManager)
     */
    template<>
    struct hash<mlir::Type> {
        size_t operator()(const mlir::Type& t) const {
            return t.getKind() * 37 + t.getSubclassData();
        }
    };
}

/**
 * The ConstantManager class. It allows to keep track of already defined constants in MLIR
 * to reduce the number of duplicate definitions (for the same constant value) but without
 * the cumbersomeness and variable-naming issue of manual constant initialisation (like in
 * the tutorial with cst0 or cst0_64...).
 * Constants also designate "constant pointers" which are defined at JIT-compile-time (and
 * do not change at run time).
 * When requested for a certain constant / type pair, the ConstantManager checks if it has
 * already been defined in the past. If so, it returns that mlir::Value. Otherwise, it
 * creates it.
 * @tparam T should be some kind of OpBuilder (possibly a PatternRewriter)
 * @tparam U the MLIR Context in which the builder / rewriter is used
 */
template<typename T, typename U>
struct ConstantManager {
protected:
    // std::unordered_map but shorter
    template<typename K, typename V>
    using umap = std::unordered_map<K, V>;

    /// Constants that have been defined in the form width -> value -> mlir::Value
    umap<size_t, umap<size_t, mlir::Value>> constants;

    /// Pointers that habe been defined in the form type -> value -> mlir::Value
    umap<mlir::Type, umap<void*, mlir::Value>> pointers;

    /// The rewriter / builder
    T& rewriter;

    // The MLIRContext
    U& ctx;

public:
    ConstantManager(T& rewriter, U& ctx)
        : rewriter(rewriter), ctx(ctx)
    {
    }

    /**
     * Inserts a constant integer at call site
     * @param x the constant value
     * @param width the constant width
     * @return the mlir::Value that has been created
     */
    mlir::Value& insertConstant(uint64_t x, size_t width) {
        if (constants.find(width) == constants.end()) {
            constants[width] = std::unordered_map<size_t, mlir::Value>{};
        }
        auto& c = constants[width];
        if (c.find(x) != c.end()) {
            return c[x];
        }

        c[x] = rewriter.template create<mlir::ConstantIntOp>(LOC, (uint64_t)(x), width);
        return c[x];
    }

    /**
     * Inserts a constant pointer at call site
     * @tparam X the (C++) pointer type
     * @param type the LLVM pointer type
     * @param x the pointer
     * @return the mlir::Value that has been created
     */
    template<typename X>
    mlir::Value& insertPointer(mlir::Type type, X* x) {
        if (pointers.find(type) == pointers.end()) {
            pointers[type] = umap<void*, mlir::Value>{};
        }

        auto& p = pointers[type];
        if (p.find(x) != p.end()) {
            return p[x];
        }

        p[x] = rewriter.template create<mlir::LLVM::IntToPtrOp>(LOC, type,
                rewriter.template create<mlir::ConstantIntOp>(LOC, reinterpret_cast<uint64_t>(x), 64));
        return p[x];
    }

    /**
     * Wrapper for insertConstant that deduces the width based on the type of x
     * @tparam X the integer type to use
     * @param x the constant value
     * @return the mlir::Value that has been created
     */
    template<typename X>
    mlir::Value& operator()(X x) {
        return insertConstant(x, CHAR_BIT * sizeof(X));
    }

    /**
     * Wrapper (shorthand) for insertConstant
     * @tparam X the type of x (not used, but for genericity)
     * @param x the constant value
     * @param width the width to use for the integer constant
     * @return the mlir::Value that has been created
     */
    template<typename X>
    mlir::Value& operator()(X x, size_t width) {
        return insertConstant(x, width);
    }

    /**
     * Wrapper (shorthand) for insertPointer
     * @tparam X the (C++) type of x
     * @param type the LLVM pointer type for the constant
     * @param x the pointer value
     * @return the mlir::Value that has been created
     */
    template<typename X>
    mlir::Value operator()(mlir::Type type, X* x) {
        return insertPointer(type, x);
    }
};
