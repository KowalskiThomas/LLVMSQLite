from utils import raw_args, args

opcodes = dict()
with open("../opcodes.h") as f_opcodes:
    lines_opcodes = f_opcodes.read().split('\n')
    for line in lines_opcodes:
        if line.startswith("#define") and "{" not in line:
            _, name, value, *_ = line.split()

            if not name.startswith("OP_"):
                continue

            if "x" in value:
                value = int(value.split('x')[-1], base=16)
            else:
                value = int(value)
            
            name = name.strip()
            opcodes[value] = name

c_lines = ['']
with open("../src/vdbe.c") as f_c:
    lines_c = f_c.read().split('\n')
    for i, x in enumerate(lines_c):
        c_lines.append(x)
    print(len(lines_c))

f = raw_args[0]

assert f.endswith(".ll")

with open(f) as fn:
    contents = fn.read()

lines = contents.split("\n")

# Load debug symbols
debug_symbols = dict()
for line in lines:
    if line.startswith("!"):
        symbol_id = line.split(' ')[0][1:]
        if "DILocation" in line:
            data = line.split('(')[1].split(')')[0]
            line_no = data.split(',')[0].split(':')[1]
            debug_symbols[symbol_id] = {"line":line_no}

# Add line numbers before blocks
last_line = None
output_lines = list()
for i, line in enumerate(lines):
    if "!dbg" in line:
        dbg_start = line.index("!dbg")
        dbg_symbol_id = line[dbg_start + 3:].split()[1][1:]
        if dbg_symbol_id in debug_symbols:
            dbg_line_no = int(debug_symbols[dbg_symbol_id]["line"].strip())
            if dbg_line_no != last_line:
                output_lines.append(f"; line {dbg_line_no}: {c_lines[dbg_line_no].strip()}")
                last_line = dbg_line_no

    output_lines.append(line)

# Add labels in switch block
opcode_handler_labels = dict()
for i, line in enumerate(output_lines):
    if "switch i32" in line or "switch i8" in line:
        do_this_one = False
        for j in range(i + 1, len(lines)):
            line_j = output_lines[j]
            if "]" in line_j:
                if j - i > 15:
                    do_this_one = True
                break

        if do_this_one:
            print("Doing for", i, j)
            all_positive = True
            for k in range(i + 1, j):
                line = output_lines[k]
                t = "i32 "
                if t not in line:
                    t = "i8 "
                i32_index = line.index(t)
                opcode_value = int(line[i32_index + len(t):].split()[0][:-1])
                if opcode_value < 0:
                    all_positive = False
                    break

            if all_positive:
                print("No optimisation has been done on opcode values")
            else:
                print("Optimisations done on opcodes range")
                opcodes = {(k % 128 - 128 if k >= 128 else k) : v for k, v in opcodes.items()}

            for k in range(i + 1, j):
                line = output_lines[k]
                t = "i32 "
                if t not in line:
                    t = "i8 "
                i32_index = line.index(t)
                opcode_value = int(line[i32_index + len(t):].split()[0][:-1])
                output_lines[k] = f"{line} ; {opcodes[opcode_value]}"
                
                label_index = line.index("label")
                labelNumber = line[label_index + 5:].split(';')[0].strip()[1:]
                labelNumber = int(labelNumber)
                opcode_handler_labels[opcode_value] = labelNumber

for i, line in enumerate(output_lines):
    found = False
    for opcode_value, label in opcode_handler_labels.items():
        if line.strip().startswith(f"{label}:"):
            line = line.split(':')[0] + ':'
            output_lines[i] = f"{line} ; {opcodes[opcode_value]}"
            found = True
            break
    
    if found:
        del opcode_handler_labels[opcode_value]

output_file_name = f.replace(".ll", ".out.ll")
with open(output_file_name, 'w') as f:
    f.write("\n".join(output_lines))