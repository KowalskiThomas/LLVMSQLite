import os
import tarfile

from common import get_size, human_size

folders = [
    ("/Users/kowalski/dev/tosubmit/llvm", "LLVM"),
    ("/Users/kowalski/dev/tosubmit/LLVMSQLite", "LLVMSQLite"),
    ("/Users/kowalski/dev/tosubmit/LLVMSQLite_DBGen", "DBGen")
]

folders = [(
    x[0] + "/" if not x[0].endswith("/") else x[0],
    x[1] + "/" if not x[1].endswith("/") else x[1],
) for x in folders]

files = list()
for folder, to in folders:
    temp = os.listdir(folder)
    temp = [(folder + f, to + f) for f in temp]
    files.extend(temp)

excluded = (
    ".git",
    "build",
    "release",
    "debug",
    "reldebinfo",
    ".lo",
    ".log",
    ".o",
    "sqlite3.c",
    ".db",
    ".txz",
    ".out",
    ".dSYM"
)

out = list()
for f_from, f_to in files:
    f = f_from.lower()
    do_ex = False
    for ex in excluded:
        if f.endswith(ex):
            if f.endswith("txz"):
                print(f"Ignoring TXZ {f_from}")
            do_ex = True
            break

    if do_ex:
        continue

    out.append((f_from, f_to))

total_size = sum([get_size(f) for f, _ in out])
print(f"Total size: {human_size(total_size)}")


archive_name = "software.txz"
tar = tarfile.open(archive_name, mode='w:xz')

for f_from, f_to in out:
    print(f"Adding {f_from} -> {f_to}")
    tar.add(f_from, arcname=f_to)

tar.close()

print(f"Archive size: {human_size(get_size(archive_name))}")
