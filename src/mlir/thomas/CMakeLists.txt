get_property(dialect_libs GLOBAL PROPERTY MLIR_DIALECT_LIBS)
get_property(conversion_libs GLOBAL PROPERTY MLIR_CONVERSION_LIBS)

set(LIBS
    ${dialect_libs}
    ${conversion_libs}
    MLIROptLib
    MLIRStandalone
    MLIRAnalysis
    MLIRCallInterfaces
    MLIRExecutionEngine
    MLIRIR
    MLIRParser
    MLIRPass
    MLIRSideEffects
    MLIRTargetLLVMIR
    MLIRTransforms
    LLVMCore
    LLVMExecutionEngine
    LLVMInterpreter
    LLVMSupport
    LLVMMCJIT
    LLVMLTO
)

# Needed for LTO
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl -z origin")

add_library(sqlite_llvm
    SQLiteBridge.cpp
    VdbeHash.cpp
    ModuleOptimisation.cpp
    BridgeUtils.cpp
    ModuleWriter.cpp
    DynamicLibrary.cpp
)
llvm_update_compile_flags(sqlite_llvm)
target_link_libraries(sqlite_llvm PRIVATE ${LIBS})
