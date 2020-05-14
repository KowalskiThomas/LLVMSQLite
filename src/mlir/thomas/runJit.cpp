#include "sqlite_bridge.h"
#include "Standalone/StandaloneDialect.h"
#include "Standalone/StandalonePasses.h"

std::unordered_map<Vdbe*, void(*)(void **)> functions;

