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

    let arguments = (ins I64Attr:$pc);

    let successors = (successor AnySuccessor:$jumpTo);
}

def Standalone_Noop : Standalone_Op<"Noop"> {
    let summary = "Does nothing";

    let arguments = (ins I64Attr:$pc);
}

def Standalone_Goto : Standalone_TerminatorOp<"Goto", [Terminator]> {
    let summary = "Unconditionally jumps to instruction $pc";

    let arguments = (ins I64Attr:$pc);
    let successors = (successor AnySuccessor:$dest);
}

def Standalone_Halt : Standalone_TerminatorOp<"Halt"> {
    let summary = "Halts the execution immediately";

    let arguments = (ins I64Attr:$pc);
}

def Standalone_OpenRead : Standalone_Op<"OpenRead"> {
    let summary = "Opens a cursor and whatnot";

    let arguments = (ins I64Attr:$counter, I32Attr:$curIdx, I64Attr:$rootPage, I32Attr:$database, I64Attr:$P4, I16Attr:$P5);
}

def Standalone_Rewind : Standalone_Op<"Rewind", [Terminator]> {
    let summary = "Rewinds a cursor";

    let arguments = (ins I64Attr:$pc, I32Attr:$curIdx);

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

    let arguments = (ins I64Attr:$pc, I32Attr:$curIdx, I32Attr:$curHint, I64Attr:$advancer, I16Attr:$P5);
    let successors = (successor AnySuccessor:$jumpTo, AnySuccessor:$fallthrough);
}

def Standalone_Transaction : Standalone_Op<"Transaction"> {
    let summary = "Begin a transaction on database P1 if a transaction is not already active. If P2 is non-zero, then a write-transaction is started, or if a read-transaction is already active, it is upgraded to a write-transaction. If P2 is zero, then a read-transaction is started.";

    let arguments = (ins I64Attr:$pc, I32Attr:$dbIdx, I32Attr:$isWrite, I32Attr:$P3, I64Attr:$P4, I16Attr:$P5);
}

def Standalone_AggStep : Standalone_Op<"AggStep"> {
    let summary = "TODO";

    let arguments = (ins I64Attr:$pc, I32Attr:$p1, I32Attr:$firstReg, I32Attr:$toReg, I64Attr:$function, I16Attr:$nReg);
}

def Standalone_AggFinal : Standalone_Op<"AggFinal"> {
    let summary = "";

    let arguments = (ins I64Attr:$pc, I32Attr:$toReg, I32Attr:$nArgs, I64Attr:$function);
}

def Standalone_Copy : Standalone_Op<"Copy"> {
    let summary = "";

    let arguments = (ins I64Attr:$pc, I32Attr:$firstFromReg, I32Attr:$firstToReg, I32Attr:$nFromReg);
}

def Standalone_SorterOpen : Standalone_Op<"SorterOpen"> {
    let arguments = (ins I64Attr:$pc, I32Attr:$curIdx, I32Attr:$nCol, I32Attr:$p3, I64Attr:$p4);
}

def Standalone_Integer : Standalone_Op<"Integer"> {
    let arguments = (ins I64Attr:$pc, I32Attr:$value, I32Attr:$dest);
}

def Standalone_Real : Standalone_Op<"Real"> {
    let arguments = (ins I64Attr:$pc, I32Attr:$regTo, I64Attr:$pointerToValue);
}

def Standalone_String : Standalone_Op<"String"> {
    let arguments = (ins I64Attr:$pc, I32Attr:$len, I32Attr:$regTo, I32Attr:$hints, I64Attr:$string, I16Attr:$flags);
}

def Standalone_String8 : Standalone_Op<"String8"> {
    let arguments = (ins I64Attr:$pc, I32Attr:$regTo, I64Attr:$string);
}

def Standalone_Variable : Standalone_Op<"Variable"> {
    let arguments = (ins I64Attr:$pc, I32Attr:$p1, I32Attr:$regTo, I64Attr:$parameterName);
}

def Standalone_Null : Standalone_Op<"Null"> {
    let summary = "Puts null in some registers";

    let arguments = (ins I64Attr:$pc, I32Attr:$setMemCleared, I32Attr:$firstReg, I32Attr:$lastReg);
}

def Standalone_Gosub : Standalone_Op<"Gosub", [Terminator]> {
    let arguments = (ins I64Attr:$pc, I32Attr:$writeAddressTo);

    let successors = (successor AnySuccessor:$jumpTo);
}

def Standalone_MakeRecord : Standalone_Op<"MakeRecord"> {
    let arguments = (ins I64Attr:$pc, I32Attr:$firstRegFrom, I32Attr:$nReg, I32Attr:$dest, I64Attr:$affinities);
}

def Standalone_SorterInsert : Standalone_Op<"SorterInsert"> {
    let arguments = (ins I64Attr:$pc, I32Attr:$curIdx, I32Attr:$reg);
}

def Standalone_OpenPseudo : Standalone_Op<"OpenPseudo"> {
    let arguments = (ins I64Attr:$pc, I32Attr:$curIdx, I32Attr:$reg, I32Attr:$nFields);
}

def Standalone_Return : Standalone_Op<"Return", [Terminator]> {
    let arguments = (ins I64Attr:$pc, I32Attr:$continueAtNextInstructionFromReg);

    // let successors = (successor AnySuccessor:$continueAt);
}

def Standalone_SorterSort : Standalone_Op<"SorterSort", [Terminator]> {
    let arguments = (ins I64Attr:$pc, I32Attr:$curIdx);

    let successors = (successor AnySuccessor:$jumpToIfEmpty, AnySuccessor:$fallthrough);
}

def Standalone_SorterData : Standalone_Op<"SorterData"> {
    let arguments = (ins I64Attr:$pc, I32Attr:$curIdx, I32Attr:$reg, I32Attr:$curClearHeader);
}

def Standalone_Compare : Standalone_Op<"Compare"> {
    let arguments = (ins I64Attr:$pc, I32Attr:$firstLhs, I32Attr:$firstRhs, I32Attr:$nReg, I64Attr:$keyInfo, I16Attr:$flags);
}

def Standalone_Jump : Standalone_Op<"Jump", [Terminator]> {
    // let arguments = (ins I32Attr:$ifLess, I32Attr:$ifEqual, I32Attr:$ifGreater);
    let arguments = (ins I64Attr:$pc);

    let successors = (successor AnySuccessor:$ifLess, AnySuccessor:$ifEqual, AnySuccessor:$ifGreater);
}

def Standalone_Move : Standalone_Op<"Move"> {
    let arguments = (ins I64Attr:$pc, I32Attr:$firstFromReg, I32Attr:$firstToReg, I32Attr:$nReg);
}

def Standalone_If : Standalone_Op<"If", [Terminator]> {
    let arguments = (ins I64Attr:$pc, I32Attr:$condition, I32Attr:$hints);

    let successors = (successor AnySuccessor:$jumpTo, AnySuccessor:$fallthrough);
}

def Standalone_IfNot : Standalone_Op<"IfNot", [Terminator]> {
    let arguments = (ins I64Attr:$pc, I32Attr:$condition, I32Attr:$hints);

    let successors = (successor AnySuccessor:$jumpTo, AnySuccessor:$fallthrough);
}

def Standalone_IsNull : Standalone_Op<"IsNull", [Terminator]> {
    let arguments = (ins I64Attr:$pc, I32Attr:$reg);

    let successors = (successor AnySuccessor:$jumpTo, AnySuccessor:$fallthrough);
}

def Standalone_NotNull : Standalone_Op<"NotNull", [Terminator]> {
    let arguments = (ins I64Attr:$pc, I32Attr:$reg);

    let successors = (successor AnySuccessor:$jumpTo, AnySuccessor:$fallthrough);
}

def Standalone_IfNullRow : Standalone_Op<"IfNullRow", [Terminator]> {
    let arguments = (ins I64Attr:$pc, I32Attr:$cur, I32Attr:$reg);

    let successors = (successor AnySuccessor:$jumpTo, AnySuccessor:$fallthrough);
}

def Standalone_IfPos : Standalone_Op<"IfPos", [Terminator]> {
    let arguments = (ins I64Attr:$pc, I32Attr:$integerReg, I32Attr:$toSubtract);

    let successors = (successor AnySuccessor:$jumpTo, AnySuccessor:$fallthrough);
}

def Standalone_SorterNext : Standalone_Op<"SorterNext", [Terminator]> {
    let arguments = (ins I64Attr:$pc, I32Attr:$curIdx, I32Attr:$hints);

    let successors = (successor AnySuccessor:$jumpTo, AnySuccessor:$fallthrough);
}

def Standalone_Arithmetic : Standalone_Op<"Arithmetic"> {
    let arguments = (ins I64Attr:$pc, I32Attr:$P1, I32Attr:$P2, I32Attr:$resultReg);
}

def Standalone_CompareJump : Standalone_Op<"CompareJump", [Terminator]> {
    let arguments = (ins I64Attr:$pc, I32Attr:$p2, I32Attr:$lhs, I32Attr:$rhs, I64Attr:$comparator, I16Attr:$flags);

    let successors = (successor AnySuccessor:$ifTrue, AnySuccessor:$ifFalse);
}

def Standalone_Once : Standalone_Op<"Once", [Terminator]> {
    let arguments = (ins I64Attr:$pc);

    let successors = (successor AnySuccessor:$jumpTo, AnySuccessor:$fallthrough);
}

def Standalone_Function : Standalone_Op<"FunctionOp"> {
    let arguments = (ins I64Attr:$pc, I32Attr:$constantBitmask, I32Attr:$firstInReg, I32Attr:$outReg, I64Attr:$function);
}

def Standalone_OpenEphemeral : Standalone_Op<"OpenEphemeral"> {
    let arguments = (ins I64Attr:$pc, I32Attr:$curIdx, I32Attr:$nColumn, I64Attr:$btIndex, I16Attr:$flags);
}

def Standalone_DeferredSeek : Standalone_Op<"DeferredSeek"> {
    let arguments = (ins I64Attr:$pc, I32Attr:$curTarget, I32Attr:$curToMove, I64Attr:$array);
}

def Standalone_SeekRowid : Standalone_Op<"SeekRowid", [Terminator]> {
    let arguments = (ins I64Attr:$pc, I32Attr:$curIdx, I32Attr:$reg);

    let successors = (successor AnySuccessor:$jumpTo, AnySuccessor:$fallThrough);
}

def Standalone_Sequence : Standalone_Op<"Sequence"> {
    let arguments = (ins I64Attr:$pc, I32Attr:$curIdx, I32Attr:$reg);
}

def Standalone_IfNotZero : Standalone_Op<"IfNotZero", [Terminator]> {
    let arguments = (ins I64Attr:$pc, I32Attr:$reg);

    let successors = (successor AnySuccessor:$jumpTo, AnySuccessor:$fallThrough);
}

def Standalone_Last : Standalone_Op<"Last", [Terminator]> {
    let arguments = (ins I64Attr:$pc, I32Attr:$curIdx);

    let successors = (successor AnySuccessor:$jumpTo, AnySuccessor:$fallThrough);
}

def Standalone_IdxCompare : Standalone_Op<"IdxCompare", [Terminator]> {
    let arguments = (ins I64Attr:$pc, I32Attr:$curIdx, I32Attr:$firstReg, I64Attr:$nReg, I16Attr:$flags);

    let successors = (successor AnySuccessor:$jumpTo, AnySuccessor:$fallThrough);
}

def Standalone_Delete : Standalone_Op<"Delete"> {
    let arguments = (ins I64Attr:$pc, I32Attr:$curIdx, I32Attr:$p2, I32Attr:$p3, I64Attr:$p4, I16Attr:$p5);
}

def Standalone_IdxInsert : Standalone_Op<"IdxInsert"> {
    let arguments = (ins I64Attr:$pc, I32Attr:$curIdx, I32Attr:$reg, I32Attr:$p3, I64Attr:$p4, I16Attr:$flags);
}

def Standalone_Rowid : Standalone_Op<"Rowid"> {
    let arguments = (ins I64Attr:$pc, I32Attr:$p1, I32Attr:$p2);
}

def Standalone_RowSetTest : Standalone_Op<"RowSetTest", [Terminator]> {
    let arguments = (ins I64Attr:$pc, I32Attr:$p1, I32Attr:$p2, I32Attr:$p3, I64Attr:$p4);

    let successors = (successor AnySuccessor:$jumpTo, AnySuccessor:$fallThrough);
}

def Standalone_Affinity : Standalone_Op<"Affinity"> {
    let arguments = (ins I64Attr:$pc, I32Attr:$p1, I32Attr:$p2, I64Attr:$p4);
}

def Standalone_NotFound : Standalone_Op<"NotFound", [Terminator]> {
    let arguments = (ins I64Attr:$pc, I32Attr:$p1, I32Attr:$p2, I32Attr:$p3, I64Attr:$p4);

    let successors = (successor AnySuccessor:$jumpTo, AnySuccessor:$fallThrough);
}

/*
def Standalone_ : Standalone_Op<""> {
    let arguments = (ins I64Attr:$pc, I32Attr:$curIdx, I32Attr:$reg, I32Attr:$nFields);
}
*/


#endif // STANDALONE_OPS
