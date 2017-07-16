import sys, json

with open(sys.argv[1]) as json_file:
    content = json_file.readlines()

for x in content:
    dat = json.load(content)
arr = []
arr.append(dat["Name"])
arr.append(dat["Config"]["Hostname"])
arr.append(dat["Config"]["Image"])
arr.append(dat["ID"])
