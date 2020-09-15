import os
import sys
from pathlib import Path

prologExe=Path(r"C:\Program Files\ECLiPSe 7.0\lib\x86_64_nt\eclipse.exe")
scriptPath=sys.argv[1]
cwd=Path(os.path.dirname(scriptPath))

script = open(Path.joinpath(cwd, scriptPath))
contents="cd(" + '%r'%str(cwd) + ").\n" + script.read() + "\nhalt."
print(contents)
tpin = open('tpin', 'w')
tpin.write(contents)
tpin.close()

os.system('"'+str(prologExe) + '" < tpin')