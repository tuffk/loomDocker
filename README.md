# Loom Docker Listener
Docker Container to monitor other containers logs and send them to Loom.

This container uses [Filebeat docker](https://www.elastic.co/guide/en/beats/filebeat/current/running-on-docker.html "File Beat") base image (5.5.0)

## Run the container
<!-- ```shell
docker build -t <name> .
``` -->
```shell
docker run --name <name> -e CUSTOMER_NAME=<customer name> [-e ...] --privileged -v /var/lib/docker/containers:/containers:ro <name>
```
* `-v /var/lib/docker/containers:/containers:ro` this allows the docker to read the other containers logs. The host directory must be where all the docker containers are stored (normally /var/lib/docker/containers for Linux).
* `CUSTOMER_NAME` must be set for the container to send the logs to Loom.

#### Supported configurations for Filebeat with env variables. [Official Filebeat Documentation](https://www.elastic.co/guide/en/beats/filebeat/current/configuring-howto-filebeat.html "Configuring Filebeat")
* `EXCLUDE` - [exclude lines](https://www.elastic.co/guide/en/beats/filebeat/current/configuration-filebeat-options.html#exclude-lines "exclude lines") Default is none
* `INCLUDE` - [include lines](https://www.elastic.co/guide/en/beats/filebeat/current/configuration-filebeat-options.html#include-lines "include lines") Default is none
* `EXCLUDE_FILES` - [exclude files](https://www.elastic.co/guide/en/beats/filebeat/current/configuration-filebeat-options.html#exclude-files "exclude files") Default is none
* `TAGS` - [tags](https://www.elastic.co/guide/en/beats/filebeat/current/configuration-filebeat-options.html#_tags "tags") Default is none
* `IGNORE_OLDER` - [ignore older](https://www.elastic.co/guide/en/beats/filebeat/current/configuration-filebeat-options.html#ignore-older "ignore older")  Default is 0
* `ENCODING` - [encoding](https://www.elastic.co/guide/en/beats/filebeat/current/configuration-filebeat-options.html#_encoding "encoding") Default is 'plain'

#### Additional notes
This was tested on a Linux Mint Serena 18.1 and with Docker version 17.06
