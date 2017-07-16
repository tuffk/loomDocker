# Loom Docker Litener
Docker Container to monitor other containers logs and send them to Loom.

This container uses [Filebeat docker](https://www.elastic.co/guide/en/beats/filebeat/current/running-on-docker.html "File Beat")
base image (5.5.0)

## build and run the container
```shell
docker build -t <name> .
```
```shell
docker run --name <name> -e CUSTOMER_NAME=<customer name> [-e ...] --privileged -v /var/lib/docker/containers:/containers:ro <name>
```
* `-v /var/lib/docker/containers:/containers:ro` this allows the docker to read the other containers logs
* `CUSTOMER_NAME` must be set for the container to send the logs to Loom

#### supported configurations for Filebeat with env variables. [Official Filebeat Documentation](https://www.elastic.co/guide/en/beats/filebeat/current/configuring-howto-filebeat.html "Configuring Filebeat")
* `EXCLUDE` - [exclude lines](https://www.elastic.co/guide/en/beats/filebeat/current/configuration-filebeat-options.html#exclude-lines "exclude lines")
* `INCLUDE` - [include lines](https://www.elastic.co/guide/en/beats/filebeat/current/configuration-filebeat-options.html#include-lines "include lines")
* `EXCLUDE_FILES` - [exclude files](https://www.elastic.co/guide/en/beats/filebeat/current/configuration-filebeat-options.html#exclude-files "exclude files")
* `TAGS` - [tags](https://www.elastic.co/guide/en/beats/filebeat/current/configuration-filebeat-options.html#_tags "tags")
* `IGNORE_OLDER` - [ignore older](https://www.elastic.co/guide/en/beats/filebeat/current/configuration-filebeat-options.html#ignore-older "ignore older")  
* `ENCODING` - [encoding](https://www.elastic.co/guide/en/beats/filebeat/current/configuration-filebeat-options.html#_encoding "encoding")
