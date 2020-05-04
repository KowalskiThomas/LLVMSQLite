add_mlir_dialect_library(MLIRStandalone
        StandaloneDialect.cpp
        StandaloneOps.cpp
        StandalonePasses.cpp
        StandalonePassManager.cpp
        StandalonePrerequisites.cpp
        TypeCache.cpp
        TypeDefinitions.cpp
        Lowering/InitLowering.cpp

        ADDITIONAL_HEADER_DIRS
        ${PROJECT_SOURCE_DIR}/include/Standalone

        DEPENDS
        MLIRStandaloneOpsIncGen
        )

target_link_libraries(MLIRStandalone PUBLIC MLIRIR)
