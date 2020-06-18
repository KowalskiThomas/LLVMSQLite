#include "Standalone/DefaultImplementation.h"
#include "Standalone/StandaloneDialect.h"
#include "Standalone/StandaloneOps.h"

static std::unordered_map<std::string, bool> useDefaultImplMap {
    { "standalone.AggFinal", false },
    { "standalone.AggStep", false },
    { "standalone.Arithmetic", false },
    { "standalone.Column", false },
    { "standalone.Compare", false },
    { "standalone.CompareJump", false },
    { "standalone.Copy", false },
    { "standalone.DeferredSeek", false },
    { "standalone.Delete", false },
    { "standalone.FunctionOp", false },
    { "standalone.Gosub", false },
    { "standalone.Goto", false },
    { "standalone.Halt", false },
    { "standalone.IdxCompare", false },
    { "standalone.IdxInsert", false },
    { "standalone.If", false },
    { "standalone.IfNotZero", false },
    { "standalone.IfPos", false },
    { "standalone.Init", false },
    { "standalone.Integer", false },
    { "standalone.Last", false },
    { "standalone.Jump", false },
    { "standalone.MakeRecord", false },
    { "standalone.Move", false },
    { "standalone.Next", false },
    { "standalone.Noop", false },
    { "standalone.Null", false },
    { "standalone.Once", false },
    { "standalone.OpenEphemeral", false },
    { "standalone.OpenPseudo", false },
    { "standalone.OpenRead", true }, // TODO: Fix OpenRead
    { "standalone.Real", false },
    { "standalone.ResultRow", false },
    { "standalone.Return", false },
    { "standalone.Rewind", false },
    { "standalone.SeekRowid", false },
    { "standalone.Sequence", false },
    { "standalone.SorterData", false },
    { "standalone.SorterInsert", false },
    { "standalone.SorterNext", false },
    { "standalone.SorterOpen", false },
    { "standalone.String", false },
    { "standalone.Transaction", false },
    { "standalone.Variable", true },  // TODO: Implement
};

bool useDefaultImpl(mlir::Operation* op) {
    std::string s = op->getName().getStringRef().str();
    
    assert(useDefaultImplMap.count(s) == 1 && "Undefined useDefaultImpl for operation");
    
    if (useDefaultImplMap.count(s) > 0) {
        return useDefaultImplMap[s];
    }

    err("Couldn't find useDefaultImpl value for operation '" << op->getName() << "'");
    exit(129);
}