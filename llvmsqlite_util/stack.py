with open("stack.txt") as f:
    stack = f.read().split('\n')

with open("map.txt") as f:
    map = f.read().split('\n')

functions = dict()
for l in map:
    if "->" in l:
        address_str, f_name = l.split('->')
        address_str = address_str.replace("0x", "").strip()
        address = int(address_str, base=16)

        f_name = f_name.strip()
        functions[address] = f_name

print(map)
for line in stack:
    if "unknown" not in line:
        *name, address = line.split()
        name = " ".join(name)
        print(f"{name:>35} {address}")
        continue

    address = int(line.split()[1].replace("0x", ""), base=16)
    while address not in functions and address > 0:
        address -= 1

    assert address != 0
    print(f"{functions[address]:>35} {address}")


        
    
