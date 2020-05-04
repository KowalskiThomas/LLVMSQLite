#include "function_definitions.h"
#include "type_definitions.h"

FunctionType* allocateCursorTy;
Function* allocateCursorF;

#include "vdbe.h"

void load_function_definitions(my_context& ctx) {
    auto& m = *ctx.module;

    auto fTy = FunctionType::get(
            T::VdbeCursorPtrTy, {
                T::VdbePtrTy,
                T::i32Ty,
                T::i32Ty,
                T::i32Ty,
                T::i8Ty
            }, false);
    auto f = Function::Create(fTy, GlobalValue::LinkageTypes::ExternalLinkage, "allocateCursor", m);
    sys::DynamicLibrary::AddSymbol("allocateCursor", reinterpret_cast<void *>(allocateCursor));

    allocateCursorTy = fTy;
    allocateCursorF = f;
}