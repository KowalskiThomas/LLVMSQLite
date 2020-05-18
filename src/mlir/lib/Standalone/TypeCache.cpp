#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"

static LLVMDialect* firstDialect = nullptr;

void initialiseTypeCache(LLVMDialect* dialect) {
    // if (firstDialect == nullptr) {
    //     firstDialect = dialect;
    // } else {
    //     assert(firstDialect == dialect);
    // }

    // static bool cacheInitialised = false;
    // if (cacheInitialised) {
    //     // llvm::outs() << "LLVM Type Cache already initialised!";
    //     return;
    // }
    // cacheInitialised = true;

    load_type_definitions(dialect);
}
