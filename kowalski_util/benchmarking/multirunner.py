from common import run_blocking
from sys import argv
import sys

db = argv[1]
if not ".db" in db:
    print("Please give the database as first argument")
    sys.exit(1)

do_run = "echo" not in argv

excluded = { 17 }
queries = [x for x in range(1, 22) if not x in excluded]
jit_config = ["jit", "nojit"]

count = 5
for i, arg in enumerate(argv):
    if arg.strip('-') == "count":
        count = int(argv[i + 1])

total_line = ""
for q in queries:
    for jit in jit_config:
        to_run = f"python3 runner.py {db} {jit} query {q} count {count}"
        if do_run:
            print(f">>> {to_run}")
            stdout, stderr = run_blocking(to_run)
            print(stdout, stderr)
        else:
            total_line += to_run + "\n"

if not do_run:
    with open("script.sh", 'w') as f:
        f.write(total_line)
