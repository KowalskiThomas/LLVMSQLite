# Run CMake
cmake -G Ninja ../llvm -DLLVM_ENABLE_PROJECTS=mlir -DLLVM_BUILD_EXAMPLES=OFF -DLLVM_TARGETS_TO_BUILD="X86" -DCMAKE_BUILD_TYPE=Release -DLLVM_ENABLE_ASSERTIONS=OFF -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++

# Run tests
cmake --build . --target check-mlir

# Install libs locally
DESTDIR=/Users/kowalski/llvm ninja install
