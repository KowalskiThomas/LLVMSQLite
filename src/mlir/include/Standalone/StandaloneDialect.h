//===- StandaloneDialect.h - Standalone dialect -----------------*- C++ -*-===//
//
// This file is licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef STANDALONE_STANDALONEDIALECT_H
#define STANDALONE_STANDALONEDIALECT_H

#include "mlir/IR/Dialect.h"

#include "Standalone/VdbeContext.h"

namespace mlir {
    namespace standalone {

        #include "Standalone/StandaloneOpsDialect.h.inc"
        struct FooOp;

        namespace VdbeTypes {
            enum Kind {
                Integer = Type::FIRST_PRIVATE_EXPERIMENTAL_0_TYPE,
                Register,
                ProgrammeCounter,
                Vdbe,
                LAST_PRIVATE_EXPERIMENTAL_0_TYPE = Vdbe
            };

            class ProgrammeCounterType : public Type::TypeBase<ProgrammeCounterType, Type> {
            public:
                /// Inherit some necessary constructors from 'TypeBase'.
                using Base::Base;

                /// This static method is used to support type inquiry through isa, cast,
                /// and dyn_cast.
                static bool kindof(unsigned kind) { return kind == VdbeTypes::Kind::Integer; }

                /// This method is used to get an instance of the 'ProgrammeCounterType'. Given that
                /// this is a parameterless type, it just needs to take the context for
                /// uniquing purposes.
                static ProgrammeCounterType get(MLIRContext *context) {
                    // Call into a helper 'get' method in 'TypeBase' to get a uniqued instance
                    // of this type.
                    return Base::get(context, VdbeTypes::Kind::Integer);
                }
            };

            class RegisterType : public Type::TypeBase<RegisterType, Type> {
            public:
                /// Inherit some necessary constructors from 'TypeBase'.
                using Base::Base;

                /// This static method is used to support type inquiry through isa, cast,
                /// and dyn_cast.
                static bool kindof(unsigned kind) { return kind == VdbeTypes::Kind::Register; }

                [[maybe_unused]] void print(raw_ostream &os) {
                    os << "REGISTER";
                }

                /// This method is used to get an instance of the 'ProgrammeCounterType'. Given that
                /// this is a parameterless type, it just needs to take the context for
                /// uniquing purposes.
                static RegisterType get(MLIRContext *context) {
                    // Call into a helper 'get' method in 'TypeBase' to get a uniqued instance
                    // of this type.
                    return Base::get(context, VdbeTypes::Kind::Register);
                }
            };

            class VdbeType : public Type::TypeBase<VdbeType, Type> {
            public:
                using Base::Base;

                static bool kindof(unsigned kind) { return kind == VdbeTypes::Kind::Vdbe; }

                [[maybe_unused]] void print(raw_ostream &os) {
                    os << "VdbeType";
                }

                static VdbeType get(MLIRContext* context) {
                    return Base::get(context, VdbeTypes::Kind::Vdbe);
                }
            };
        } // namespace VdbeTypes
    } // namespace standalone
} // namespace mlir

[[maybe_unused]] [[maybe_unused]] void print(mlir::OpAsmPrinter&, const mlir::standalone::FooOp&);
[[maybe_unused]] [[maybe_unused]] void print(mlir::OpAsmPrinter&, const mlir::standalone::VdbeTypes::RegisterType&);

#endif // STANDALONE_STANDALONEDIALECT_H
