import sys, json, os
conf_file = open("/usr/share/filebeat/filebeat.yml","w")
conf_file.write("filebeat.prospectors:\n")
PATH = "/containers"
# PATH = "/var/lib/docker/containers"
files = os.listdir(PATH)
dat =[]
for f in files:
    json_file = open(PATH+"/"+f+"/config.v2.json")
    temp = json.load(json_file)
    json_file.close()
    conf_file.write("- input_type: log\n")
    conf_file.write("  paths:\n")
    conf_file.write("    - "+PATH+"/"+f+"/*.log\n")
    conf_file.write("  include_lines: ${INCLUDE}\n\
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
    conf_file.write("  fields:\n")
    conf_file.write("    name: "+temp["Name"]+"\n")
    conf_file.write("    image: "+temp["Config"]["Image"]+"\n")
    conf_file.write("    hostname: "+temp["Config"]["Hostname"]+"\n")
    conf_file.write("    ID: "+temp["ID"]+"\n\n")
conf_file.write("\n\
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
conf_file.close()
