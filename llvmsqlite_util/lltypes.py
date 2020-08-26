import sys

from utils import raw_args, args

if not raw_args:
    print("Usage: lltypes IR_FILE.ll")
    sys.exit(1)

f = raw_args[0]
assert f.endswith(".ll")


class Data:
    output_lines = list()
    base_types = dict()
    all_type_names = list()
    struct_names = list()
    definitions = dict()
    struct_definitions = dict()
    types_lines = list()
    depends_on = dict()

    custom_types = {
        "i1": "IntegerType::get(ctx, 1)"
    }


def read_file():
    with open(f) as fn:
        contents = fn.read()

    lines = contents.split("\n")

    in_types = False
    for line in lines:
        if line.startswith("%"):
            in_types = True
        elif in_types:
            break

        if in_types:
            Data.types_lines.append(line)


def last_index_of(s: str, c: str):
    for i in range(len(s) - 1, 0 - 1, -1):
        if s[i] == c:
            return i

    return None


def get_type_name(ty_expr):
    ty_expr = ty_expr.strip()

    exceptions = {
        "void ()* (%struct.sqlite3_vfs*, i8*)*": (
            "Void_Of_Void_Of_Sqlite3_Vfs_i8Ptr",
            "PointerType::get(FunctionType::get(FunctionType::get(IntegerType::getVoidTy(ctx), {}, false), { T::sqlite3_vfsPtrTy, T::i8PtrTy }, false), 0)",
            ['Void', 'sqlite3_vfsPtr', 'i8Ptr']
        ),
        "void ()* (%struct.sqlite3_vfs*, i8*, i8*)*": (
            "Void_Of_Void_Of_Sqlite3_Vfs_i8Ptr_i8Ptr",
            "PointerType::get(FunctionType::get(FunctionType::get(IntegerType::getVoidTy(ctx), {}, false), { T::sqlite3_vfsPtrTy, T::i8PtrTy, T::i8PtrTy }, false), 0)",
            ['Void', 'sqlite3_vfsPtr', 'i8Ptr']
        ),
        "{}": (
            "EmptyStruct",
            'StructType::create({}, "emptyStruct")',
            []
        ),
        # "{}**": (
        #     "EmptyStructPtrPtr",
        #     'PointerType::get(PointerType::get(StructType::create({}, "emptyStruct"), 0), 0)',
        #     ["EmptyStruct"]
        # ),
        # "{}**": (
        #     "EmptyStructPtrPtr",
        #     'PointerType::get(PointerType::get(StructType::create({}, "emptyStruct"), 0), 0)',
        #     []
        # ),
        "{}**": (
            "PxFunctionPtr",
            'FunctionType::get(T::i8PtrTy, {T::sqlite3_contextPtrTy, T::i32Ty, T::sqlite3_valuePtrPtrTy}, false)',
            ["i8Ptr", "sqlite3_contextPtr", "sqlite3_valuePtr"]
        )
    }
    if ty_expr in exceptions:
        name, definition, depends_on = exceptions[ty_expr]
    elif ty_expr.endswith("*"):
        sub_type = ty_expr[:-1]
        sub_type = get_type_name(sub_type)
        name = sub_type + "Ptr"
        definition = f"PointerType::get(T::{sub_type}Ty, 0)"
        depends_on = [sub_type]
    elif ty_expr == "void":
        name = "Void"
        definition = "IntegerType::getVoidTy(ctx)"
        depends_on = []
    elif '(' in ty_expr:
        returnType = ty_expr.split('(')[0].strip()
        returnType = get_type_name(returnType)
        argTypes = ty_expr[ty_expr.index('(') + 1: last_index_of(ty_expr, ')')]
        argTypes = [x.strip() for x in argTypes.split(',') if x.strip()]
        if not argTypes:
            depends_on = [returnType]
            argTypesString = "Void"
            definition = f"FunctionType::get({Data.definitions[returnType]}, {{}}, false)"
        else:
            argTypes = [get_type_name(x) for x in argTypes]
            depends_on = argTypes + [returnType]
            argTypesString = '_'.join(argTypes)
            cppArgTypes = ["T::" + x + "Ty" for x in argTypes]
            definition = f"FunctionType::get({Data.definitions[returnType]}, {{{', '.join(cppArgTypes)}}}, false)"

        name = f"{returnType.replace('T::', '')}_Of_{argTypesString}"
        # print(ty_expr, "->", name)
    elif ty_expr.startswith("%"):
        name = ty_expr.replace("%struct.", "").replace("%union.", "").replace(".", "")
        definition = None
        depends_on = None
    elif "[" in ty_expr:
        array_size = int(ty_expr[1:].split('x')[0].strip())
        element_type = ty_expr[ty_expr.index('x') + 1:-1].strip()
        element_type = get_type_name(element_type)
        name = f"Arr_{array_size}_{element_type}"
        definition = f"ArrayType::get({'T::' + element_type + 'Ty' if element_type in Data.struct_names else Data.definitions[element_type]}, {array_size})"
        depends_on = [element_type]
    elif ty_expr.startswith("i"):
        name = ty_expr
        definition = f"IntegerType::get(ctx, {ty_expr[1:].replace('*', '')})"
        depends_on = []
    elif ty_expr.replace("*", "") == "double":
        name = "double"
        definition = "IntegerType::getDoubleTy(ctx)"
        depends_on = []
    else:
        print("Unhandled", ty_expr)
        raise Exception()

    if definition is not None:
        Data.definitions[name] = definition
    if depends_on is not None:
        Data.depends_on[name] = depends_on

    return name


def main():
    read_file()
    for line in Data.types_lines:
        print("----")
        print(line)
        type_defined_on_this_line = line.split(' ')[0]
        type_name = get_type_name(type_defined_on_this_line)
        type_definition = line.split('=')[1]
        type_definition = type_definition.replace('type', '').strip()
        if "." in type_name:
            type_name = type_name.replace(".", "")
        print("Trying to define", type_name)

        if "opaque" in line:
            Data.definitions[type_name] = f'StructType::create(ctx, "{type_name}")'
            Data.definitions[type_name + "Ptr"] = f'PointerType::get(T::{type_name}Ty, 0)'
            Data.depends_on[type_name] = list()
        else:
            packed = False
            if '<' in type_definition and '>' in type_definition:
                packed = True

            l = '}'.join('{'.join(type_definition.split('{')[1:]).split('}')[:-1]).strip()
            l2 = ""
            in_function = False
            for c in l:
                if c == '(':
                    in_function = True
                elif c == ',' and in_function:
                    c = ';'
                elif c == ')':
                    in_function = False

                l2 += c
            l = l2

            types = l.split(',')
            types = [t.replace(';', ',') for t in types]
            types = [get_type_name(t) for t in types]
            types = [t.strip() for t in types]
            cppTypes = ["T::" + t + "Ty" for t in types]
            Data.depends_on[type_name] = types
            Data.struct_definitions[
                type_name] = f'T::{type_name}Ty->setBody({{ {", ".join(cppTypes)} }}, {"true" if packed else "false"})'
            Data.definitions[type_name + "Ptr"] = f'PointerType::get(T::{type_name}Ty, 0)'
            Data.struct_names.append(type_name)

    with open("../src/type_definitions.h", 'w') as f:
        s = ('#define SQLITE_JIT_IR_TYPE static inline llvm::Type*\n'
             'void load_type_definitions(LLVMContext&);\n\n'
             'struct T {\n')

        for type_name in Data.struct_names:
            s += f'    static inline StructType* {type_name}Ty = nullptr;\n'

        for type_name in Data.definitions:
            s += f'    SQLITE_JIT_IR_TYPE {type_name}Ty = nullptr;\n'

        for type_name in Data.custom_types:
            s += f'    SQLITE_JIT_IR_TYPE {type_name}Ty = nullptr;\n'

        s += '};\n\n'

        f.write(s)

    generated_types = {t for t in Data.struct_names}
    types_to_generate = [t for t in Data.depends_on.keys() if t not in Data.struct_names]
    all_types = sorted(list(types_to_generate))
    i = 0
    passes = list()

    while all_types:
        to_add = set()
        for x in all_types:
            deps = Data.depends_on[x]
            if all(dep in generated_types or dep in Data.struct_names for dep in deps):
                to_add.add(x)

        # print(f"Step {i}: Add {', '.join(to_add)}")

        if not to_add:
            print("Nothing to add")
            for t in all_types:
                deps = Data.depends_on[t]
                print("---->", t, ", ".join(deps))
            print("Generated", ", ".join(sorted(generated_types)))
            raise Exception()

        for x in to_add:
            all_types.remove(x)
            generated_types.add(x)

        passes.append(to_add)
        i += 1

    with open("../src/type_definitions.cpp", 'w') as f:
        s = '''#include "type_definitions.h"\n
            void load_type_definitions(LLVMContext& ctx) {\n'''

        for type_name in Data.struct_names:
            s += f'    T::{type_name}Ty = StructType::create(ctx, "{type_name}");\n'

        for type_name, definition in Data.custom_types.items():
            s += f'    T::{type_name}Ty = {definition};\n'

        s += '\n\n'
        # for type_name, definition in Data.definitions.items():
        #     s += f'    T::{type_name}Ty = {definition};\n'

        for pas in passes:
            print(", ".join(pas))

            for type_name in pas:
                definition = Data.definitions[type_name]
                s += f'    T::{type_name}Ty = {definition};\n'

        for type_name in Data.struct_names:
            s += f'    {Data.struct_definitions[type_name]};\n'

        for line in list(sorted(list(set(Data.output_lines)))):
            print("out", line)
            s += f'    {line}\n'

        s += '}\n'

        f.write(s)


if __name__ == '__main__':
    main()
