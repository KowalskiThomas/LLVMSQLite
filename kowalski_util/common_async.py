import sys
import os
import subprocess
import asyncio

from common import human_size, get_extension, copy_mtime
import common

class Limits:
    lock = asyncio.Lock()
    max_concurrent_tasks = None
    
    _current_tasks = 0

    @staticmethod
    async def try_start():
        async with Limits.lock:
            if Limits._current_tasks < Limits.max_concurrent_tasks:
                Limits._current_tasks += 1
                return True

            return False

    @staticmethod
    async def finish():
        async with Limits.lock:
            Limits._current_tasks -= 1



async def run_blocking(to_call):
    proc = await asyncio.create_subprocess_shell(
        to_call,
        stdout=asyncio.subprocess.PIPE,
        stderr=asyncio.subprocess.PIPE)

    stdout, stderr = await proc.communicate()
    try:
        out_stdout = stdout.decode("utf-8").strip()
        out_stderr = stderr.decode("utf-8").strip()
    except UnicodeDecodeError:
        try:
            out_stdout = stdout.decode("latin-1").strip()
            out_stderr = stderr.decode("latin-1").strip()
        except:
            print(stdout, stderr)
            raise
    return out_stdout, out_stderr


async def get_file_size(name: str):
    return common.get_file_size(name)

    try:
        stdout, stderr = await run_blocking(f"stat -f%z \"{name}\"")
        return int(stdout.split()[0])
    except:
        print(f"Couldn't get file sile for {name}")
        raise 
