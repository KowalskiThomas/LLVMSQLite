set(LOWERING_FILES
    Lowering/MyBuilder.cpp
    Lowering/Printer.cpp

    Lowering/AggFinalLowering.cpp
    Lowering/AggStepLowering.cpp
    Lowering/ColumnLowering.cpp
    Lowering/CompareLowering.cpp
    Lowering/CopyLowering.cpp
    Lowering/GosubLowering.cpp
    Lowering/GotoLowering.cpp
    Lowering/HaltLowering.cpp
    Lowering/IfPosLowering.cpp
    Lowering/InitLowering.cpp
    Lowering/IntegerLowering.cpp
    Lowering/JumpLowering.cpp
    Lowering/MakeRecordLowering.cpp
    Lowering/MoveLowering.cpp
    Lowering/NextLowering.cpp
    Lowering/NoopLowering.cpp
    Lowering/NullLowering.cpp
    Lowering/OpenPseudoLowering.cpp
    Lowering/OpenReadLowering.cpp
    Lowering/ResultRowLowering.cpp
    Lowering/ReturnLowering.cpp
    Lowering/RewindLowering.cpp
    Lowering/SorterDataLowering.cpp
    Lowering/SorterInsertLowering.cpp
    Lowering/SorterNextLowering.cpp
    Lowering/SorterOpenLowering.cpp
    Lowering/SorterSortLowering.cpp
    Lowering/TransactionLowering.cpp
    Lowering/ArithmeticLowering.cpp
    Lowering/String8Lowering.cpp
    Lowering/StringLowering.cpp
    Lowering/VariableLowering.cpp
    Lowering/RealLowering.cpp
    Lowering/CompareJumpLowering.cpp
    Lowering/IfLowering.cpp
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
