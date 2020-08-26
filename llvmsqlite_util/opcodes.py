with open("prog.txt") as f:
    contents = f.read().split('\n')


equiv = {
    "Add": "Arithmetic",
    "Subtract": "Arithmetic",
    "Multiply": "Arithmetic",
    "Divide": "Arithmetic",

    "Eq": "Compare",
    "Gt": "Compare",
    "Ne": "Compare",
    "Ge": "Compare",
    "Lt": "Compare",

    "String8": "String",
}

opcodes = set()
for line in contents:
    opcode = line.split('-')[1].strip()
    opcode = equiv.get(opcode, opcode)
    opcodes.add(opcode)



for opcode in sorted(list(opcodes)):
    print(opcode)