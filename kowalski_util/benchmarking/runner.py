import random
import sys
import os
import shutil

from typing import Optional
from generator import generate_query as generate_query_tpch
from generator_ssbm import generate_query as generate_query_ssbm
from generator_micro import generate_query as generate_query_micro

from common import run_blocking, date_to_string, now

cwd = os.getcwd()
assert __name__ == '__main__', "runner.py should be the main programme!"

if not os.path.isdir("logs"):
    os.mkdir("logs")


def find_shell(jit_enabled: bool, path="."):
    binary_name = "shell_jit" if jit_enabled else "shell_default"
    path = os.path.abspath(path)
    print(path)
    path = path + "/../../"
    path = os.path.abspath(path)

    dirs = os.listdir(path)
    dir = "release"
    if dir in dirs:
        path = path + '/' + dir + '/'
    else:
        print(f"Could not find directory '{dir}' in {path}")

    wd = path
    path = path + binary_name
    path = os.path.abspath(path)

    return wd, path


args = sys.argv[1:]

for i, arg in enumerate(args):
    if arg.startswith("--"):
        args[i] = arg[2:]
    elif arg.startswith("-"):
        args[i] = arg[1:]

print(f"Args: {args}")

enable_jit: Optional[bool] = None
assert not ("jit" in args and "nojit" in args), "Please use only -jit or -nojit, not both!"
assert not ("jit" not in args and "nojit" not in args), "Please give -jit or -nojit."
if "jit" in args:
    enable_jit = True
elif "nojit" in args:
    enable_jit = False
print(f"JIT Enabled: {'Yes' if enable_jit else 'No'}")

assert not ("tpch" not in args and "ssbm" not in args and "micro" not in args), "Please give --mode tpch, --mode micro or --mode ssbm"
for i, x in enumerate(args):
    if x == "mode":
        mode = args[i + 1]
        break

TPCH = 1
SSBM = 2
MICRO = 3
mode = TPCH if mode == "tpch" else SSBM if mode == "ssbm" else MICRO
print(f"Mode: {'TPC-H' if mode == TPCH else 'SSBM' if mode == SSBM else 'Micro'}")

db_file: Optional[str] = None
for arg in args:
    if ".db" in arg:
        db_file = arg
        break

assert db_file, "Couldn't find database file in arguments"
print(f"Database: '{db_file}'")

count: Optional[int] = None
query_index: Optional[int] = None
for i, arg in enumerate(args[:-1]):
    if arg == "count":
        count = int(args[i + 1])
    elif arg == "query":
        query_index = int(args[i + 1])

assert count is not None, "Couldn't find query count in arguments"
assert query_index is not None, "Couldn't find query index in arguments"

print(f"Workload: {count} x Q{query_index}")

temp_file_path = f"/tmp/sqlite{random.randint(1, 10000)}.sql"
print("Generating SQL statement in", temp_file_path)
complete_script = ""
for _ in range(count):
    if mode == TPCH:
        sql = generate_query_tpch(query_index)
    elif mode == SSBM:
        sql = generate_query_ssbm(query_index)
    else:
        assert mode == MICRO
        sql = generate_query_micro(query_index)

    complete_script += "  " + sql

complete_script += "\n"

with open(temp_file_path, 'w') as f:
    f.write(complete_script)

wd, shell = find_shell(jit_enabled=enable_jit)
print(f"Shell: '{shell}'")

to_run = f'echo ".quit" | {shell} "{db_file}" -init {temp_file_path}'
print(to_run)

date = date_to_string(now())
stdout, stderr = run_blocking(to_run, cwd=wd)
with open(f"logs/stdout-{query_index}-{'jit' if enable_jit else 'nojit'}-{date}.txt", 'w') as f:
    f.write(stdout)
with open(f"logs/stderr-{query_index}-{'jit' if enable_jit else 'nojit'}-{date}.txt", 'w') as f:
    f.write(stderr)

if enable_jit:
    to_find = "JIT Vdbe execution time"
else:
    to_find = "Default Implementation Vdbe execution time"

data = list()
for line in stdout.split('\n'):
    line = line.strip()
    if not line:
        continue

    if to_find in line:
        data_point = line.split(':')[1].strip().split()[0]
        data_point = int(data_point)
        data.append(data_point)

assert len(data) > 0, "Didn't find any data points in the output. Check the value of 'to_find'." + '\n' + stdout + '\n' + stderr

# Skip initial schema retrieval query
data = data[1:]

print("Writing file", cwd)
with open(f"{cwd}/Results-{query_index}-{'jit' if enable_jit else 'nojit'}-{date}.txt", 'w') as f:
    f.write('\n'.join([str(x) for x in data]))
    f.write('\n')
