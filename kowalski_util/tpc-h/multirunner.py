from common import run_blocking
from sys import argv

db = argv[1]

do_run = "echo" not in argv

queries = [x for x in range(1, 22)]
jit_config = ["jit", "nojit"]
count = 1

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