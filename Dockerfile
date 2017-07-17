# https://www.elastic.co/guide/en/beats/filebeat/current/running-on-docker.html
# base image centos:7
FROM docker.elastic.co/beats/filebeat:5.5.0

ENV EXCLUDE=[] \
  INCLUDE=[] \
  EXCLUDE_FILES=[] \
  TAGS=[] \
  IGNORE_OLDER=0 \
  ENCODING="plain"

### TODO: if you copy the file in the Dockerfile, you will have to rebuild every time you change the configuration. Instead, mount a volume where you expect the config file, and copy it using a docker entrypoint script.
### Regardless, make sure this is the last step, because the config file will change more frequently than the certificate

# add the filebeat yml to the container
# COPY ./filebeat.yml /usr/share/filebeat/filebeat.yml
COPY  ./jsoner.py jsoner.py

USER root
#get loom certificate
RUN mkdir /usr/share/loom \
  && echo "python jsoner.py" >> run.sh \
  && echo "filebeat -e &" >> run.sh \
  && echo "while true" >> run.sh \
  && echo "do" >> run.sh \
  && echo "python jsoner.py" >> run.sh \
  && echo "sleep 5" >> run.sh \
  && echo "done" >> run.sh \
  && curl -o /usr/share/loom/loom.pem https://static.loomsystems.com/loom.cer \
  && chmod 755 /usr/share/loom/loom.pem \
  && yum install -y openssl \
  && cd /usr/share/loom/ \
  && openssl genrsa -out selfsigned.key 2048 \
  && openssl req -new -key selfsigned.key -batch -out selfsigned.csr \
  && openssl x509 -req -days 3650 -in selfsigned.csr -signkey selfsigned.key -out selfsigned.crt \
  && rm selfsigned.csr \
  && yum remove -y openssl

CMD ["/bin/sh","/usr/share/filebeat/run.sh"]
