#include "Standalone/DefaultImplementation.h"
#include "Standalone/StandaloneDialect.h"
#include "Standalone/StandaloneOps.h"
#include "Standalone/ErrorCodes.h"
#include "Standalone/DebugUtils.h"

static const constexpr auto useOnlyDefaultImpl = false;

using std::unordered_map;
using std::string;

static unordered_map<string, bool> useDefaultImplMap {
    { "standalone.Affinity", false },
    { "standalone.AggFinal", false },
    { "standalone.AggStep", false },
    { "standalone.Arithmetic", false },
    { "standalone.Column", false },
    { "standalone.Compare", false },
    { "standalone.CompareJump", false },
    { "standalone.Copy", false },
    { "standalone.CollSeq", false },
    { "standalone.DecrJumpZero", false },
    { "standalone.DeferredSeek", false },
    { "standalone.Delete", false },
    { "standalone.FunctionOp", false },
    { "standalone.Gosub", false },
    { "standalone.Goto", false },
    { "standalone.Halt", false },
    { "standalone.IdxCompare", false },
    { "standalone.IdxInsert", false },
    { "standalone.If", false },
    { "standalone.IfNot", false },
    { "standalone.IfNotZero", false },
    { "standalone.IfNullRow", false },
    { "standalone.IfPos", false },
    { "standalone.Init", false },
    { "standalone.IsNull", false },
    { "standalone.Integer", false },
    { "standalone.Jump", false },
    { "standalone.Last", false },
    { "standalone.MakeRecord", false },
    { "standalone.Move", false },
    { "standalone.Next", false },
    { "standalone.Noop", false },
    { "standalone.NotFound", false },
    { "standalone.NotNull", false },
    { "standalone.Null", false },
    { "standalone.Once", false },
    { "standalone.OpenEphemeral", false },
    { "standalone.OpenPseudo", false },
    { "standalone.OpenRead", true }, // TODO: Implement OP_OpenWrite
    { "standalone.Real", false },
    { "standalone.ResultRow", false },
    { "standalone.Return", false },
    { "standalone.Rewind", false },
    { "standalone.RowSetTest", false },
    { "standalone.Rowid", false },
    { "standalone.SCopy", false },
    { "standalone.SeekRowid", false },
    { "standalone.SeekGE", false },
    { "standalone.Sequence", false },
    { "standalone.SorterData", false },
    { "standalone.SorterInsert", false },
    { "standalone.SorterNext", false },
    { "standalone.SorterOpen", false },
    { "standalone.String", false },
    { "standalone.Transaction", false },
    { "standalone.Variable", true },  // TODO: Implement
    { "standalone.Yield", false },
    { "standalone.EndCoroutine", false },
    { "standalone.InitCoroutine", false },
    { "standalone.NullRow", false },

    { "standalone.Cast", false },
    { "standalone.ReadCookie", false },
    { "standalone.SetCookie", true },  // TODO: Implement
    { "standalone.DropTable", true },  // TODO: Implement
    { "standalone.OpenWrite", true },  // TODO: Implement
    { "standalone.NewRowid", true }, // TODO: Implement
    { "standalone.Blob", false },
    { "standalone.Insert", true },  // TODO: Implement
    { "standalone.Close", false },
    { "standalone.OpenWrite", true },  // TODO: Implement
    { "standalone.ParseSchema", true },  // TODO: Implement


    { "standalone.Template", true },  // TODO: Implement
};

bool useDefaultImpl(mlir::Operation* op) {
    if (useOnlyDefaultImpl)
        return true;

    std::string s = op->getName().getStringRef().str();
    
    LLVMSQLITE_ASSERT(useDefaultImplMap.count(s) == 1 && "Undefined useDefaultImpl for operation");
    
    if (useDefaultImplMap.count(s) > 0) {
        auto useDefault = useDefaultImplMap[s];
        if (useDefault)
            err("Warning: using default implementation for " << s);

        return useDefault;
    }

    err("Couldn't find useDefaultImpl value for operation '" << op->getName() << "'");
    exit(UNDEFINED_USE_DEFAULT_IMPL);
}

bool anyDefaultImplUsed() {
    return std::any_of(useDefaultImplMap.cbegin(), useDefaultImplMap.cend(), [](const auto& pair) {
        return pair.second;
    });
}