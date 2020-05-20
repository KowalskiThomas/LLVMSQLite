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
// def Integer : TypeAlias<I64, "Integer">;
def Vdbe : TypeAlias<OpaqueType<"standalone", "VdbeState", "A VDBE">>;

/*
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
*/

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

/*
def Standalone_Plus32Op : Standalone_Op<"plus32"> {
    let summary = "adds 32";
    let arguments = (ins I32:$val);
    let results = (outs I32:$result);

    let assemblyFormat = [{
        $val attr-dict `:` type($result)
    }];
}
*/

/*
def Standalone_IntegerOp : Standalone_Op<"Integer"> {
    let summary = "Puts an integer in a register";

    let arguments = (ins Register:$reg, I32Attr:$val);
    // let results = (outs )
}
*/

def Standalone_OpenCursorOp : Standalone_Op<"OpenCursor"> {
    let summary = "Opens a cursor";

    let arguments = (ins I64:$tableIndex, I64:$cursorIndex);
    let results = (outs I32:$returnCode);
}

def Standalone_InitOp : Standalone_Op<"Init", [Terminator]> {
    let summary = "Jumps to $jump_to if not 0. Updates the Once value so that all Once opcodes will run again.";

    let arguments = (ins I64:$jump_to);

    let successors = (successor AnySuccessor:$jumpTo);
}

def Standalone_Noop : Standalone_Op<"Noop"> {
    let summary = "Does nothing";

    let arguments = (ins I64:$pc);
}

def Standalone_Goto : Standalone_TerminatorOp<"Goto", [Terminator]> {
    let summary = "Unconditionally jumps to instruction $pc";

    let successors = (successor AnySuccessor:$dest);
}

def Standalone_Halt : Standalone_TerminatorOp<"Halt"> {
    let summary = "Halts the execution immediately";
}

def Standalone_OpenRead : Standalone_Op<"OpenRead"> {
    let summary = "Opens a cursor and whatnot";

    let arguments = (ins I64:$counter, I32:$curIdx, I64:$rootPage, I32:$database, I32:$P4, I16Attr:$P5);
}

def Standalone_Rewind : Standalone_Op<"Rewind"> {
    let summary = "Rewinds a cursor";

    let arguments = (ins I32:$curIdx, I32:$jumpTo);
}

def Standalone_Column : Standalone_Op<"Column"> {
    let summary = "Extracts a value from a record";

    let arguments = (ins I64Attr:$counter, I32Attr:$curIdx, I32Attr:$column, I32Attr:$extractTo, I64Attr:$defaultValue, I16Attr:$flags);
}

def Standalone_ResultRow : Standalone_Op<"ResultRow", [Terminator]> {
    let summary = "Calls the callback";

    let arguments = (ins I64Attr:$counter, I32Attr:$firstCol, I32Attr:$nCol);
}

def Standalone_Next : Standalone_Op<"Next", [Terminator]> {
    let summary = "Advances the cursor P1 then jumps to P2. Uses P3 to advance.";

    let arguments = (ins I32Attr:$curIdx, I32Attr:$curHint, I64Attr:$advancer, I16Attr:$P5);
    let successors = (successor AnySuccessor:$jumpTo, AnySuccessor:$fallthrough);
}

def Standalone_Transaction : Standalone_Op<"Transaction"> {
    let summary = "Begin a transaction on database P1 if a transaction is not already active. If P2 is non-zero, then a write-transaction is started, or if a read-transaction is already active, it is upgraded to a write-transaction. If P2 is zero, then a read-transaction is started.";

    let arguments = (ins I32Attr:$dbIdx, I32Attr:$isWrite, I32Attr:$P3, I64Attr:$P4, I16Attr:$P5);
}

def Standalone_Null : Standalone_Op<"Null"> {
    let summary = "Puts null in some registers";

    let arguments = (ins I64Attr:$pc, I32Attr:$setMemCleared, I32Attr:$firstReg, I32Attr:$lastReg);
}

def Standalone_AggStep : Standalone_Op<"AggStep"> {
    let summary = "TODO";

    let arguments = (ins I64Attr:$pc, I32Attr:$p1, I32Attr:$firstReg, I32Attr:$toReg, I64Attr:$function, I16Attr:$nReg);
}

def Standalone_AggFinal : Standalone_Op<"AggFinal"> {
    let summary = "";

    let arguments = (ins I32Attr:$toReg, I32Attr:$nArgs, I64Attr:$function);
}

def Standalone_Copy : Standalone_Op<"Copy"> {
    let summary = "";

    let arguments = (ins I32Attr:$firstFromReg, I32Attr:$firstToReg, I32Attr:$nFromReg);
}

def Standalone_SorterOpen : Standalone_Op<"SorterOpen"> {
    let arguments = (ins I32Attr:$curIdx, I32Attr:$nCol, I32Attr:$p3, I64Attr:$p4);
}

def Standalone_Integer : Standalone_Op<"Integer"> {
    let arguments = (ins I32Attr:$value, I32Attr:$dest);
}

def Standalone_Gosub : Standalone_Op<"Gosub"> {
    let arguments = (ins I32Attr:$writeAddressTo, I32Attr:$jumpTo);
}

def Standalone_MakeRecord : Standalone_Op<"MakeRecord"> {
    let arguments = (ins I32Attr:$firstRegFrom, I32Attr:$nReg, I32Attr:$dest, I64Attr:$affinities);
}

def Standalone_SorterInsert : Standalone_Op<"SorterInsert"> {
    let arguments = (ins I32Attr:$curIdx, I32Attr:$reg);
}

def Standalone_OpenPseudo : Standalone_Op<"OpenPseudo"> {
    let arguments = (ins I32Attr:$curIdx, I32Attr:$reg, I32Attr:$nFields);
}

#endif // STANDALONE_OPS
