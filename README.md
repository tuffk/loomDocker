# LoomDocker
Docekr Container to monitor other containers logs and send them to loom's log stash

build and run the container
```shell
docker build -t <name> .
```
```shell
docker run --name <name> [-e CUSTOMER_NAME=<customer name> ...] --privileged -v /var/lib/docker/containers:/containers:ro <name>
```
* `-v /var/lib/docker/containers:/containers:ro` this allows the docker to read the other containers logs

#### supported configurations for filebeat with env variables
* `EXCLUDE` - exclude lines
* `INCLUDE` - include lines
* `EXCLUDE_FILES` - exclude files
* `TAGS` - tags
* `IGNORE_OLDER` - ignore older  
* `ENCODING` - encoding
