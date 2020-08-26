import os

sql_files = [x for x in os.listdir(".") if x.endswith("sql")]

result = ""
for f in sql_files:
    with open(f) as sql:
        result += sql.read()
        result += "\n"

result = result.strip()
with open("output.txt", 'w') as f:
    f.write(result)