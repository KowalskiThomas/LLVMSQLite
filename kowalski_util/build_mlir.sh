# Run CMake
cmake -G Ninja ../llvm  -DLLVM_ENABLE_PROJECTS=mlir -DLLVM_BUILD_EXAMPLES=ON  -DLLVM_TARGETS_TO_BUILD="X86" -DCMAKE_BUILD_TYPE=RelWithDebInfo \
   -DLLVM_ENABLE_ASSERTIONS=ON -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ #-DLLVM_ENABLE_LLD=ON

# Run tests
cmake --build . --target check-mlir

# Install libs locally
DESTDIR=/Users/kowalski/llvm ninja install