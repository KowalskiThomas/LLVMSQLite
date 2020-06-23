import sys
import random
import datetime

args = sys.argv

date_format = "%Y-%m-%d"

query_number = args[1]

import static_data as data
from static_data import types as q_types

def generate_int(info):
    min = info["min"]
    max = info["max"]
    return random.randint(min, max)

def generate_date(info):
    min = datetime.datetime.strptime(info["min"], date_format)
    max = datetime.datetime.strptime(info["max"], date_format)
    max_date_diff = (max - min).total_seconds() / (3600 * 24)
    random_days = random.randint(0, max_date_diff)
    new_date = min + datetime.timedelta(days=random_days)
    return new_date.strftime(date_format)

def generate_float(info):
    if "value" in info:
        return info["value"]

    min = info["min"]
    max = info["max"]
    return min + (max - min) * random.random()

def generate_region(info):
    return random.choice(data.regions)

def generate_segment(info):
    return random.choice(data.segments)

def generate_brand(info):
    return f"Brand##{random.randint(1, 5)}{random.randint(1, 5)}"

def generate_type(info):
    if "syllables" in info:
        n = info["syllables"]
    else:
        n = 3

    return " ".join((
        random.choice(data.types1),
        random.choice(data.types2),
        random.choice(data.types3)
    )[:n])

def generate_nation(info):
    return random.choice(data.nations)

def generate_p_name(info):
    words = [random.choice(data.p_name_words) for _ in range(5)]
    return " ".join(words)

def generate_ship_mode(info):
    return random.choice(data.ship_modes)

def generate_union(info):
    assert "items" in info
    return random.choice(info["items"])

def generate_constant(info):
    assert "value" in info
    return info["value"]

def generate_parameter(name, ty_info):
    type_name = ty_info["type"]
    generators = {
        "int": generate_int,
        "float": generate_float,
        "date": generate_date,
        "segment": generate_segment,
        "region": generate_region,
        "brand": generate_brand,
        "p_name": generate_p_name,
        "shipmode": generate_ship_mode,
        "nation": generate_nation,
        "type": generate_type,
        "union": generate_union,
        "constant": generate_constant
    }
    generator = generators[type_name]
    return generator(ty_info)

def generate_dict(cons):
    parameters = dict()
    for parameter_name, type_info in cons.items():
        type_name = type_info["type"]
        parameters[parameter_name] = generate_parameter(parameter_name, type_info)

    return parameters

constraints = q_types[query_number]
parameter_dict = generate_dict(constraints)
# print("Parameters:", parameter_dict)

with open(f"{query_number}.sql") as f:
    sql = f.read()

sql = sql.format(**parameter_dict)
print(sql.replace("\n", "    "))