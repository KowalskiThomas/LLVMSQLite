import sys

from common import run_blocking, find_shell
from generator_tpch import generate_query

path, shell = find_shell(False)

db = [x for x in sys.argv if ".db" in x][0]

queries = list(range(1, 23))
for query in queries:
    sql = generate_query(query)

    query_path = "/tmp/sql.sql"
    with open(query_path, 'w') as f:
        f.write(sql)

    parameters = [db, "-init", query_path]
    to_call = shell + " " + " ".join(parameters)
    stdout, _ = run_blocking(to_call, cwd=path)

    types = dict()
    for line in stdout.split('\n'):
        if "Column" in line and "from" in line:
            _, column_no, _, index_no, _, register, ty = line.split()
            register = int(register)
            ty = ty[1:-1]
            types[register] = ty

    sql = "EXPLAIN " + sql
    with open(query_path, 'w') as f:
        f.write(sql)

    stdout, stderr = run_blocking(to_call, cwd=path)
    operations = stdout.split('\n')

    listing = list()
    for line in operations:
        try:
            line_data = line.strip().split("  ")
            line_data = [x.strip() for x in line_data if x.strip()]
            while len(line_data) < 8:
                line_data.append("")
            index, opcode, p1, p2, p3, p4, p5, comment = line_data
            index = int(index)
        except Exception as e:
            # print(type(e), e)
            continue

        listing.append((index, opcode, p1, p2, p3, p4, p5, comment))

    for i, line in enumerate(listing):
        index = line[0]
        assert i == index, f"Bad index for line {line} and i = {i}"

    types_before = dict()
    well_typed = True
    while types_before != types:
        types_before = types

        for index, opcode, p1, p2, p3, p4, p5, _ in listing:
            # print(index, opcode, p1, p2, p3, p4)
            p1, p2, p3 = map(int, (p1, p2, p3))
            if opcode in ("Add", "Multiply", "Divide", "Remainder", "Subtract"):
                if p2 in types and p1 in types:
                    if types[p1] != types[p2]:
                        well_typed = False
                        break
                    else:
                        assert types[p1] == types[p2], f"Types mismatch {types[p1]}, {types[p2]}"

                    types[p3] = types[p1]
            elif opcode == "Integer":
                types[p2] = "Int"
            elif opcode == "Real":
                types[p2] = "Real"
            elif opcode == "RealAffinity":
                types[p1] = "Real"
            else:
                pass
                # print("Unknown op:", opcode)

    if not well_typed:
        print(f"Cannot type {query}")
    else:
        with open(f"types_{query}.c", 'w') as f:
            f.write('#include "sqliteInt.h"\n')
            f.write('#include "vdbeInt.h"\n')

            f.write('const int empty[] = { ')
            for reg in range(255):
                f.write('0, ')
            f.write('};\n')

            f.write('const int types[] = { ')
            for reg in range(255):
                if reg in types:
                    type = types[reg]
                    f.write(f"MEM_{type}, ")
                else:
                    f.write("0, ")
            f.write("};\n")

            f.write("const int* query_types[] = { empty, types };")
