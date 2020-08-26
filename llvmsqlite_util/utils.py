import datetime
import random
import sys

date_format = "%Y-%m-%d %H:%M:%S"

raw_args = [arg for arg in sys.argv[1:]]
# print(raw_args)

args = [arg.lower() for arg in raw_args]

def date_from_timestamp(timestamp):
    dt = datetime.datetime.fromtimestamp(timestamp)
    return dt.strftime("%m/%d")


def time_from_timestamp(timestamp):
    dt = datetime.datetime.fromtimestamp(timestamp)
    return dt.strftime("%H:%M")


def date_from_string(s: str):
    if not s:
        return None

    return datetime.datetime.strptime(s, date_format)


def date_to_string(dt: datetime.datetime):
    if dt is None:
        return None

    return dt.strftime(date_format)

def date_from_git_string(s: str):
    return datetime.strptime(' '.join(s.split(' ')[:-1]), '%a %b %d %H:%M:%S %Y')

def date_to_git_string(dt: str):
    return dt.strftime('%a %b %d %H:%M:%S %Y')


Alphabet = [chr(c) for c in range(ord('a'), ord('z') + 1)] + \
           [chr(c) for c in range(ord('A'), ord('Z') + 1)] + \
           [str(i) for i in range(0, 11)]


def random_string(length: int):
    result = str()
    for _ in range(length):
        result += random.choice(Alphabet)

    return result


def get_arg(name: str, default: str = None):
    """
    Finds the value of an argument passed named `name` with `arg value`, `-arg value` or `--arg value`
    If `arg` is not given, returns `default`.
    """
    name = name.lower()
    for i, arg in enumerate(args):
        if arg in (name.lower(), "-" + name, "--" + name):
            return raw_args[i + 1]

    return default