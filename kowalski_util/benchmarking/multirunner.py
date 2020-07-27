import os
import sys

from common import run_blocking
from sys import argv

db = argv[1]
if not ".db" in db:
    print("Please give the database as first argument")
    sys.exit(1)

do_run = "echo" not in argv

TPCH = 0
SSBM = 1

mode = TPCH
if "ssbm" in argv or "ssb" in argv:
    mode = SSBM
elif "tpch" in argv:
    mode = TPCH
else:
    print("Please give 'tpch' or 'ssbm' in arguments")
    sys.exit(1)

if mode == TPCH:
    excluded = { 17 }
    queries = [x for x in range(1, 22) if not x in excluded]
else:
    files = [x for x in os.listdir("ssb")]
    files = [f.split('.')[0] for f in files]
    files = [int(f) for f in files]
    queries = files

jit_config = ["jit", "nojit"]

count = 5
for i, arg in enumerate(argv):
    if arg.strip('-') == "count":
        count = int(argv[i + 1])

total_line = ""
for q in queries:
    for jit in jit_config:
        to_run = f"python3 runner.py {db} {jit} query {q} count {count} mode {'ssbm' if mode == SSBM else 'tpch'}"
        if do_run:
            print(f">>> {to_run}")
            stdout, stderr = run_blocking(to_run)
            print(stdout, stderr)
        else:
            total_line += to_run + "\n"

if not do_run:
    with open("script.sh", 'w') as f:
        f.write(total_line)
