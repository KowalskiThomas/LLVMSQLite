import os
from common import run_blocking, find_shell, cwd

min_price = 0
max_price = 2048
step = 15
step_count = int((max_price - min_price) / step)
print("Steps:", step_count)

db_path = f"{cwd}/micro.db"

cur_price = min_price
prices = list()
while cur_price < max_price + step:
    prices.append(cur_price)
    cur_price += step

enable_jit = True
if enable_jit:
    to_find = "JIT Vdbe execution time"
else:
    to_find = "Default Implementation Vdbe execution time"

path, shell = find_shell(enable_jit)
points = list()
file_name = f"selectivity.csv"
for price in prices:
    sql = f"SELECT I_ID FROM Items WHERE I_Price < {price}"
    to_run = f"{shell} {db_path} '{sql}'"
    print(f"> {to_run}")
    stdout, stderr = run_blocking(to_run, cwd=path)

    data = list()
    for line in stdout.split('\n'):
        line = line.strip()
        if not line:
            continue

        if to_find in line:
            data_point = line.split(':')[1].strip().split()[0]
            data_point = int(data_point)
            data.append(data_point)

    # Only keep second time point
    data = data[1]
    points.append((price, data))
    print(points[-1])

    with open(file_name + ".new", 'w') as f:
        for p, t in points:
            f.write(f"{p},{t}\n")

    os.rename(file_name + ".new", file_name)