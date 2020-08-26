import sys
import os
import shutil

arg = sys.argv[1]
with open(arg) as f:
  lines = f.read().split('\n')

shutil.copy(arg, arg + ".sav")

out = list()
for l in lines:
  if "t::createStructTy" not in l:
    out.append(l)
    continue

  l = l.replace("t::createStructTy(d, Optional<StringRef>(", "converter.get(loadedModule->getTypeByName(")
  out.append(l)

with open(arg, 'w') as f:
  f.write('\n'.join(out))
