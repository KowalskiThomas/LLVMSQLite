cmake_minimum_required(VERSION 3.10)

set(LLVM_DIR "/Users/kowalski/llvm/")
set(LLVM_BUILD_DIR "/Users/kowalski/Downloads/llvm-project/build")
set(PREFIX "/Users/kowalski/llvm/usr/local")
set(MLIR_DIR "${PREFIX}/lib/cmake/mlir")
set(LLVM_EXTERNAL_LIT "${LLVM_BUILD_DIR}/bin/llvm-lit")

if(POLICY CMP0068)
  cmake_policy(SET CMP0068 NEW)
  set(CMAKE_BUILD_WITH_INSTALL_NAME_DIR ON)
endif()

if(POLICY CMP0075)
  cmake_policy(SET CMP0075 NEW)
endif()

if(POLICY CMP0077)
  cmake_policy(SET CMP0077 NEW)
endif()

project(standalone-dialect LANGUAGES CXX C)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O0")
set(CMAKE_C_FLAGS   "${CMAKE_CXX_FLAGS} -O0")

if (NOT apple)
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -D__FILE_NAME__=__FILE__")
  set(CMAKE_C_FLAGS   "${CMAKE_CXX_FLAGS} -D__FILE_NAME__=__FILE__")
endif()

find_package(MLIR REQUIRED CONFIG)

message(STATUS "Using MLIRConfig.cmake in: ${MLIR_DIR}")
message(STATUS "Using LLVMConfig.cmake in: ${LLVM_DIR}")
message(STATUS "LLVM CMake DIR:            ${LLVM_CMAKE_DIR}")

set(LLVM_RUNTIME_OUTPUT_INTDIR ${CMAKE_BINARY_DIR}/bin)
set(LLVM_LIBRARY_OUTPUT_INTDIR ${CMAKE_BINARY_DIR}/lib)
set(MLIR_BINARY_DIR ${CMAKE_BINARY_DIR})

list(APPEND CMAKE_MODULE_PATH "${MLIR_CMAKE_DIR}")
list(APPEND CMAKE_MODULE_PATH "${LLVM_CMAKE_DIR}")
include(TableGen)
include(AddLLVM)
include(AddMLIR)
include(HandleLLVMOptions)

include_directories(${LLVM_INCLUDE_DIRS})
include_directories(${MLIR_INCLUDE_DIRS})
# include_directories(${PROJECT_SOURCE_DIR}/include)
# include_directories(${PROJECT_BINARY_DIR}/include)
message("Source Dir: '${PROJECT_SOURCE_DIR}'")
message("Binary Dir: '${PROJECT_BINARY_DIR}'")
include_directories(${PROJECT_SOURCE_DIR}/include)
include_directories(${PROJECT_BINARY_DIR}/include)
link_directories(${LLVM_BUILD_LIBRARY_DIR})
add_definitions(${LLVM_DEFINITIONS})

add_subdirectory(include)
add_subdirectory(lib)
# add_subdirectory(test)
add_subdirectory(standalone-opt)
add_subdirectory(thomas)
