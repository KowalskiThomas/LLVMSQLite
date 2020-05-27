#include "Standalone/StandalonePrerequisites.h"
#include "Standalone/TypeDefinitions.h"

void initialiseTypeCache(LLVMDialect* dialect) {
    load_type_definitions(dialect);
}
