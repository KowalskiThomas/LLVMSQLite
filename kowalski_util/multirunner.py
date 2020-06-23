from common import run_blocking
from sys import argv

db = argv[1]

do_run = "echo" not in argv

queries = [1, 3, 6, 10, 12, 14, 19]
jit_config = ["jit", "nojit"]
count = 50

total_line = ""
for q in queries:
    for jit in jit_config:
        to_run = f"python3 runner.py {db} {jit} query {q} count {count}"
        if do_run:
            print(to_run)
            stdout, stderr = run_blocking(to_run)
            print(stdout, stderr)
        else:
            total_line += to_run + "\n"

with open("script.sh", 'w') as f:
    f.write(total_line)