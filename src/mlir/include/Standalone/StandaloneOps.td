#ifndef STANDALONE_OPS
#define STANDALONE_OPS

include "StandaloneDialect.td"
include "mlir/Interfaces/SideEffects.td"

def MemValue : TypeAlias<OpaqueType<"standalone", "MemValue", "A MemValue">>;
def Register : TypeAlias<MemRefOf<[MemValue]>>;
def ProgrammeCounter : TypeAlias<I64, "ProgrammeCounter">;
def Vdbe : TypeAlias<OpaqueType<"standalone", "VdbeState", "A VDBE">>;

def Standalone_InitOp : Standalone_Op<"Init", [Terminator]> {
    let summary = "Jumps to $jump_to if not 0. Updates the Once value so that all Once opcodes will run again.";

    let arguments = (ins I64Attr:$jump_to);

    let successors = (successor AnySuccessor:$jumpTo);
}

def Standalone_Noop : Standalone_Op<"Noop"> {
    let summary = "Does nothing";

    let arguments = (ins I64Attr:$pc);
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

    let arguments = (ins I64Attr:$counter, I32Attr:$curIdx, I64Attr:$rootPage, I32Attr:$database, I32Attr:$P4, I16Attr:$P5);
}

def Standalone_Rewind : Standalone_Op<"Rewind", [Terminator]> {
    let summary = "Rewinds a cursor";

    let arguments = (ins I32Attr:$curIdx);

    let successors = (successor AnySuccessor:$jumpToIfEmpty, AnySuccessor:$fallthrough);
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
    let arguments = (ins I64Attr:$pc, I32Attr:$value, I32Attr:$dest);
}

def Standalone_Gosub : Standalone_Op<"Gosub", [Terminator]> {
    let arguments = (ins I64Attr:$pc, I32Attr:$writeAddressTo);

    let successors = (successor AnySuccessor:$jumpTo);
}

def Standalone_MakeRecord : Standalone_Op<"MakeRecord"> {
    let arguments = (ins I64Attr:$pc, I32Attr:$firstRegFrom, I32Attr:$nReg, I32Attr:$dest, I64Attr:$affinities);
}

def Standalone_SorterInsert : Standalone_Op<"SorterInsert"> {
    let arguments = (ins I32Attr:$curIdx, I32Attr:$reg);
}

def Standalone_OpenPseudo : Standalone_Op<"OpenPseudo"> {
    let arguments = (ins I32Attr:$curIdx, I32Attr:$reg, I32Attr:$nFields);
}

def Standalone_Return : Standalone_Op<"Return", [Terminator]> {
    let arguments = (ins I32Attr:$continueAtNextInstructionFromReg);

    // let successors = (successor AnySuccessor:$continueAt);
}

def Standalone_SorterSort : Standalone_Op<"SorterSort", [Terminator]> {
    let arguments = (ins I32Attr:$curIdx);

    let successors = (successor AnySuccessor:$jumpToIfEmpty, AnySuccessor:$fallthrough);
}

def Standalone_SorterData : Standalone_Op<"SorterData"> {
    let arguments = (ins I32Attr:$curIdx, I32Attr:$reg, I32Attr:$curClearHeader);
}

def Standalone_Compare : Standalone_Op<"Compare"> {
    let arguments = (ins I64Attr:$pc, I32Attr:$firstLhs, I32Attr:$firstRhs, I32Attr:$nReg, I64Attr:$keyInfo, I16Attr:$flags);
}

def Standalone_Jump : Standalone_Op<"Jump", [Terminator]> {
    // let arguments = (ins I32Attr:$ifLess, I32Attr:$ifEqual, I32Attr:$ifGreater);

    let successors = (successor AnySuccessor:$ifLess, AnySuccessor:$ifEqual, AnySuccessor:$ifGreater);
}

def Standalone_Move : Standalone_Op<"Move"> {
    let arguments = (ins I32Attr:$firstFromReg, I32Attr:$firstToReg, I32Attr:$nReg);
}

def Standalone_IfPos : Standalone_Op<"IfPos", [Terminator]> {
    let arguments = (ins I32Attr:$integerReg, I32Attr:$toSubtract);

    let successors = (successor AnySuccessor:$jumpTo, AnySuccessor:$fallthrough);
}

def Standalone_SorterNext : Standalone_Op<"SorterNext", [Terminator]> {
    let arguments = (ins I32Attr:$curIdx, I32Attr:$hints);

    let successors = (successor AnySuccessor:$jumpTo, AnySuccessor:$fallthrough);
}

/*
def Standalone_ : Standalone_Op<""> {
    let arguments = (ins I32Attr:$curIdx, I32Attr:$reg, I32Attr:$nFields);
}
*/


#endif // STANDALONE_OPS
