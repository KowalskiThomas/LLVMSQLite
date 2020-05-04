//===- StandaloneOps.h - Standalone dialect ops -----------------*- C++ -*-===//
//
// This file is licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef STANDALONE_STANDALONEOPS_H
#define STANDALONE_STANDALONEOPS_H

#include "mlir/IR/Dialect.h"
#include "mlir/IR/OpDefinition.h"
#include "mlir/Interfaces/SideEffects.h"

namespace mlir {
    namespace standalone {

#define GET_OP_CLASSES

#include "Standalone/StandaloneOps.h.inc"

        class ConstantOp2 : public mlir::Op<ConstantOp2
                /// The ConstantOp takes no inputs.
                // mlir::OpTrait::ZeroOperands,
                /// The ConstantOp returns a single result.
                // mlir::OpTrait::OneResult
                > {

        public:
            /// Inherit the constructors from the base Op class.
            using Op::Op;

            /// Provide the unique name for this operation. MLIR will use this to register
            /// the operation and uniquely identify it throughout the system.
            static llvm::StringRef getOperationName() { return "standalone.constant"; }

            /// Return the value of the constant by fetching it from the attribute.
            // mlir::DenseElementsAttr getValue();

            /// Operations can provide additional verification beyond the traits they
            /// define. Here we will ensure that the specific invariants of the constant
            /// operation are upheld, for example the result type must be of TensorType.
            // LogicalResult verify();

            /// Provide an interface to build this operation from a set of input values.
            /// This interface is used by the builder to allow for easily generating
            /// instances of this operation:
            ///   mlir::OpBuilder::create<ConstantOp>(...)
            /// This method populates the given `state` that MLIR uses to create
            /// operations. This state is a collection of all of the discrete elements
            /// that an operation may contain.
            /// Build a constant with the given return type and `value` attribute.
            // static void build(mlir::Builder *builder, mlir::OperationState &state, mlir::Type result, mlir::DenseElementsAttr value);

            /// Build a constant and reuse the type from the given 'value'.
            // static void build(mlir::Builder *builder, mlir::OperationState &state, mlir::DenseElementsAttr value);

            /// Build a constant by broadcasting the given 'value'.
            // static void build(mlir::Builder *builder, mlir::OperationState &state, double value);
        };


    } // namespace standalone
} // namespace mlir

#endif // STANDALONE_STANDALONEOPS_H
