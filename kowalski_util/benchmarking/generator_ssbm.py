import os
import sys
import random
import datetime
from typing import Union

args = sys.argv

date_format = "%Y-%m-%d"


from generator_tpch import output, get_arg

def generate_query(number: Union[str, int]):
    if isinstance(number, int):
        number = str(number)
    assert os.path.isfile(f"ssb/{number}.sql"), f"Couldn't find template for Query {number}"

    with open(f"ssb/{number}.sql") as f:
        sql = f.read()

    return sql

def main():
    queries = [x.split('.')[0] for x in os.listdir('ssb')]
    query_number = get_arg("query", None)
    query_count = int(get_arg("query-count", 1))

    if query_number is not None:
        queries = [query_number] * query_count
    else:
        queries = [random.choice(queries) for _ in range(query_count)]

    result = ""
    for query_number in queries:
        sql = generate_query(query_number)
        result += sql
        result += '\n'

    output(result)

if __name__ == '__main__':
    main()
