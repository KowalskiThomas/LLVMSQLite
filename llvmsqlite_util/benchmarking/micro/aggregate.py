import os

sql_files = [x for x in os.listdir(".") if x.endswith("sql")]
sql_files = list(sorted(sql_files, key = lambda x : int(x.split('.')[0])))

result = ""
for i, f in enumerate(sql_files):
    i = i + 1
    i = f.replace(".sql", "")
    with open(f) as sql:
        result += f"--- Query {i}\n"
        result += sql.read().strip()
        result += "\n\n\n"

result = result.strip()
with open("output.txt", 'w') as f:
    f.write(result)