import sys
import os
import subprocess
import datetime
import asyncio
cwd = os.getcwd()

date_format = "%Y-%m-%d %H-%M-%S"


def now():
    return datetime.datetime.now()


def date_from_string(s: str):
    if not s:
        return None

    return datetime.datetime.strptime(s, date_format)


def date_to_string(dt: datetime.datetime):
    if dt is None:
        return None

    return dt.strftime(date_format)


def human_size(s: int):
    if s > 1E6:
        return f"{s / 1E6:.2f}M"
    elif s > 1E3:
        return f"{s / 1E3:.2f}K"
    else:
        return s

def run_blocking(to_call, parameters = None, cwd: str = None):
    # print(f"> {to_call}")
    process = subprocess.Popen(
        to_call,
        shell=True,
        universal_newlines=True,
        stderr=subprocess.PIPE,
    stdout=subprocess.PIPE,
    cwd=cwd
    )
    try:
        return process.communicate()
    except:
        return None, None


def get_file_size(name: str):
    return os.stat(name).st_size

    # stdout, stderr = run_blocking(f"stat -f%z '{name}'")
    # return int(stdout.split()[0])

def get_folder_size(name: str):
    size = 0
    for f in os.listdir(name):
        f = name + "/" + f
        if os.path.isdir(f):
            size += get_folder_size(f)
        elif os.path.isfile(f):
            size += get_file_size(f)

    return size

def get_size(name: str):
    if os.path.isdir(name):
        return get_folder_size(name)
    else:
        return get_file_size(name)

def get_extension(file_name: str):
    return file_name.split(".")[-1].lower()

def get_basename(file_name: str):
    return ".".join(file_name.split(".")[:-1])

def copy_mtime(copy_from: str, copy_to: str):
    stat = os.stat(copy_from)
    os.utime(copy_to, (stat.st_atime, stat.st_mtime))

def get_mtime(copy_from: str) -> datetime.datetime:
    stat = os.stat(copy_from)
    return datetime.datetime.fromtimestamp(stat.st_mtime)

def find_shell(jit_enabled: bool, path="."):
    binary_name = "shell_jit" if jit_enabled else "shell_default"
    path = os.path.abspath(path)
    print(path)
    path = path + "/../../"
    path = os.path.abspath(path)

    dirs = os.listdir(path)
    dir = "release"
    if dir in dirs:
        path = path + '/' + dir + '/'
    else:
        print(f"Could not find directory '{dir}' in {path}")

    wd = path
    path = path + binary_name
    path = os.path.abspath(path)

    return wd, path
