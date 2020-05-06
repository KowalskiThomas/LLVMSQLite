//===- StandaloneOps.td - Standalone dialect ops -----------*- tablegen -*-===//
//
// This file is licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef STANDALONE_OPS
#define STANDALONE_OPS

include "StandaloneDialect.td"
include "mlir/Interfaces/SideEffects.td"

// def Register : Type<CPred<"$_self.isa<VdbeTypes::RegisterType>()">, "VDBE Register Type">;
def MemValue : TypeAlias<OpaqueType<"standalone", "MemValue", "A MemValue">>;
def Register : TypeAlias<MemRefOf<[MemValue]>>;
def ProgrammeCounter : TypeAlias<I64, "ProgrammeCounter">;
def Integer : TypeAlias<I64, "Integer">;
def Vdbe : TypeAlias<OpaqueType<"standalone", "VdbeState", "A VDBE">>;

def Standalone_FooOp : Standalone_Op<"foo", [NoSideEffect]> {
    let summary = "Illustrates how to define an operation.";
    let description = [{
        Wew lad
    }];

    let arguments = (ins I32Attr:$input);
    let results = (outs Register:$res);

    // let printer = [{ return ::print(p, *this); }];

    // let assemblyFormat = [{
    //     $input attr-dict `:` type($input)
    // }];

    /*
    let builders = [
        // Build a constant with a given constant tensor value.
        OpBuilder<"Builder *builder, OperationState &state, "
                  "Type result, IntegerAttr value", [{
            build(builder, state, VdbeTypes::RegisterType::get(builder->context), value);
        }]>
    ];
    */
}

def Standalone_InitReg : Standalone_Op<"InitReg"> {
    let summary = "Initialises a new register";
    let results = (outs Register:$reg);

    let builders = [
        //test
        OpBuilder<"Builder *builder, OperationState& state", [{
            build(builder, state, VdbeTypes::RegisterType::get(builder->getContext()));
        }]>
    ];
}

def Standalone_Plus32Op : Standalone_Op<"plus32"> {
    let summary = "adds 32";
    let arguments = (ins I32:$val);
    let results = (outs I32:$result);

    let assemblyFormat = [{
        $val attr-dict `:` type($result)
    }];
}

def Standalone_IntegerOp : Standalone_Op<"Integer"> {
    let summary = "Puts an integer in a register";

    let arguments = (ins Register:$reg, I32Attr:$val);
    // let results = (outs )
}

def Standalone_OpenCursorOp : Standalone_Op<"OpenCursor"> {
    let summary = "Opens a cursor";

    let arguments = (ins I64:$tableIndex, I64:$cursorIndex);
    let results = (outs I32:$returnCode);
}

def Standalone_InitOp : Standalone_Op<"Init"> {
    let summary = "Jumps to $jump_to if not 0. Updates the Once value so that all Once opcodes will run again.";

    let arguments = (ins I64:$jump_to);
}

def Standalone_Noop : Standalone_Op<"Noop"> {
    let summary = "Does nothing";

    let arguments = (ins I64:$pc);
}

def Standalone_Goto : Standalone_TerminatorOp<"Goto"> {
    let summary = "Unconditionally jumps to instruction $pc";

    let successors = (successor AnySuccessor:$dest);
}

def Standalone_Halt : Standalone_TerminatorOp<"Halt"> {
    let summary = "Halts the execution immediately";
}

def Standalone_OpenRead : Standalone_Op<"OpenRead"> {
    let summary = "Opens a cursor and whatnot";

    let arguments = (ins I32:$curIdx, I64:$rootPage, I32:$database, I32:$P4, I16Attr:$P5);
}

#endif // STANDALONE_OPS'
