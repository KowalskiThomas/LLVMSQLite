import sys

f = sys.argv[1]

with open(f) as f:
    contents = f.read().split('\n')

f_names = set()
for line in contents:
    if not line.startswith("declare"):
        continue

    if "@" not in line:
        continue

    l = line

    end = l.split("@")[1]
    name = end.split()[0]
    name = name.split('(')[0]

    if name.startswith("__"):
        continue

    if name.startswith("\\") or name.startswith('"'):
        continue

    f_name = l.split('@')[1]
    f_name = f_name.split('(')[0]

    if f_name.startswith("llvm."):
        continue

    f_names.add(f_name)

with open("DynamicLibrary.cpp", 'w') as f:
    f.write('''#include "VdbeRunner.h"
extern "C" {\n''')

    for f_name in f_names:
        f.write(f'    void* {f_name}(void*);\n')

    f.write('''}

void addToDynamicLibrary() {
''')

    for f_name in f_names:
        f.write(f'    llvm::sys::DynamicLibrary::AddSymbol("{f_name}", (void*){f_name});\n')

    f.write('}')
    f.write('\n')
