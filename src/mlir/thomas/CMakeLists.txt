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

set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl -z origin")

add_library(sqlite_jit
    SQLiteBridge.cpp
    ModuleWriter.cpp
)
llvm_update_compile_flags(sqlite_jit)
target_link_libraries(sqlite_jit PRIVATE ${LIBS})
