import os
import sys

dir = sys.argv[1]
files = list()
for f in os.listdir(dir):
    if f.endswith(".txt") and f.startswith("Results-"):
        files.append(f)
files = list(sorted(files))

pairs = list()
for f in files:
    if "nojit" not in f:
        number = f.split('-')[1]
        with_jit = [x for x in files if f"-{number}-nojit" in x and "-nojit-" in x][0]

        f = f"{dir}/{f}"
        with_jit = f"{dir}/{with_jit}"

        pairs.append((f, with_jit))

for f_jit, f_nojit in pairs:
    with open(f_jit, 'r') as fp:
        data_jit = fp.read()
        data_jit = data_jit.split('\n')
    with open(f_nojit, 'r') as fp:
        data_nojit = fp.read()
        data_nojit = data_nojit.split('\n')

    print(f_jit, f_nojit)
    for i, (jit, nojit) in enumerate(zip(data_jit, data_nojit)):
        if not jit and not nojit:
            continue

        jit = int(jit)
        nojit = int(nojit)

        diff = (float(nojit) - jit) / nojit
        diff = diff * 100

        msg = f"{nojit:5d} {jit:5d} -> {diff:2f}"

        print(msg)

