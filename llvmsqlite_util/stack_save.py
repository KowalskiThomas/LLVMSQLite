import os 

path = "../src/mlir/lib/Standalone/Lowering"
source_files = [path + "/" + x for x in os.listdir(path) if os.path.isfile(path + "/" + x)]

print("Checking", source_files)
for f in source_files:
    with open(f) as fp:
        content = fp.read()

    if "saveStack" in content:
        assert "restoreStack" in content, "Didn't find restoreStack in " + f