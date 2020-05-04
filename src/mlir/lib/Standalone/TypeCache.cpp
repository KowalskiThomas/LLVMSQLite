#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"

void initialiseTypeCache(LLVMDialect* dialect) {
    static bool cacheInitialised = false;
    if (cacheInitialised) {
        llvm::outs() << "LLVM Type Cache already initialised!";
        return;
    }
    cacheInitialised = true;

    load_type_definitions(dialect);
}
