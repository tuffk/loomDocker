# https://www.elastic.co/guide/en/beats/filebeat/current/running-on-docker.html
# base image centos:7
FROM docker.elastic.co/beats/filebeat:5.5.0

ENV EXCLUDE=[] \
  INCLUDE=[] \
  EXCLUDE_FILES=[] \
  TAGS=[] \
  IGNORE_OLDER=0 \
  ENCODING="plain"

# add the script that generates the filebeat.yml dyanmically to the docker
COPY  ./jsoner.py jsoner.py
COPY ./run.sh run.sh

USER root
#get loom certificate & create init script
RUN mkdir /usr/share/loom \
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
