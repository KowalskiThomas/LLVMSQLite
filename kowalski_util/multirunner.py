from common import run_blocking
from sys import argv

db = argv[1]

do_run = "echo" not in argv

queries = [1, 3, 6, 19]
jit_config = ["jit", "nojit"]
count = 50

total_line = "echo ''"
for q in queries:
    for jit in jit_config:
        to_run = f"python3 runner.py {db} {jit} query {q} count {count}"
        if do_run:
            print(to_run)
            stdout, stderr = run_blocking(to_run)
            print(stdout, stderr)
        else:
            total_line += " && " + to_run

if not do_run:
    print(total_line)