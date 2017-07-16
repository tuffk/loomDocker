import sys, json, os
kuz = open("/usr/share/filebeat/filebeat.yml","w")
kuz.write("filebeat.prospectors:\n")
PATH = "/containers"
# PATH = "/var/lib/docker/containers"
files = os.listdir(PATH)
dat =[]
for f in files:
    json_file = open(PATH+"/"+f+"/config.v2.json")
    temp = json.load(json_file)
    json_file.close()
    kuz.write("- input_type: log\n")
    kuz.write("  paths:\n")
    kuz.write("    - "+PATH+"/"+f+"/*.log\n")
    kuz.write("  include_lines: ${INCLUDE}\n\
  exclude_lines: ${EXCLUDE}\n\
  exclude_files: ${EXCLUDE_FILES}\n\
  tags: ${TAGS}\n\
  ignore_older: ${IGNORE_OLDER}\n\
  encoding: ${ENCODING}\n\
  json:\n\
    keys_under_root: true\n\
    add_error_key: true\n\
    message_key: log\n\
  tail_files: true\n")
    kuz.write("  fields:\n")
    kuz.write("    name: "+temp["Name"]+"\n")
    kuz.write("    image: "+temp["Config"]["Image"]+"\n")
    kuz.write("    hostname: "+temp["Config"]["Hostname"]+"\n")
    kuz.write("    ID: "+temp["ID"]+"\n\n")
kuz.write("\n\
filebeat.config.prospectors:\n\
  path: /usr/share/filebeat/filebeat.yml\n\
  reload.enabled: true\n\
  reload.period: 3s\n\
\n\
output:\n\
  logstash:\n\
    hosts: [\"${CUSTOMER_NAME}-data.loomsystems.com:5044\"]\n\
    ssl:\n\
      enabled: true\n\
      certificate_authorities: /usr/share/loom/loom.pem\n\
      certificate: /usr/share/loom/selfsigned.crt\n\
      key: /usr/share/loom/selfsigned.key\n\
  console:\n\
    pretty: true\n")
kuz.close()

#/var/lib/docker/containers/59ad9fbbc017d15cd8a6943969cc455aa3ceabb183d772369e4eaff819bd7471/config.v2.json
