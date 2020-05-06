set(LOWERING_FILES
    Lowering/InitLowering.cpp
    Lowering/GotoLowering.cpp
    Lowering/NoopLowering.cpp
    Lowering/HaltLowering.cpp
    Lowering/OpenReadLowering.cpp
    Lowering/RewindLowering.cpp
)

add_mlir_dialect_library(MLIRStandalone
        StandaloneDialect.cpp
        StandaloneOps.cpp
        StandalonePasses.cpp
        StandalonePassManager.cpp
        StandalonePrerequisites.cpp
        TypeCache.cpp
        TypeDefinitions.cpp
        ${LOWERING_FILES}
        ADDITIONAL_HEADER_DIRS
        ${PROJECT_SOURCE_DIR}/include/Standalone

        DEPENDS
        MLIRStandaloneOpsIncGen
        )

target_link_libraries(MLIRStandalone PUBLIC MLIRIR)
