# TODO: lock alpine version
FROM alpine
#mount log volume
# VOLUME ["/home/tuff/loom"] # TODO: find a way to mount the volume from the docker file
# this creates a NEW volume, to use the host files use the -v option with the odkcer run
# example: docker run -v /var/lib/docker/containers:containers ... <image name>
#install required packages
RUN apk --no-cache add --update rsyslog rsyslog-tls curl openrc \
# get certificate
&& mkdir -p /etc/rsyslog.d/ \
#create config shell inside the container to configure the rsyslog and work as entrypoint
&& echo 'SENDING_IP=${SENDING_IP:=$SEND_IP}' >> config.sh \
&& echo 'CUST_NAME=${CUST_NAME:=$CUSTOMER_NAME}' >> config.sh \
&& echo '' >> config.sh \
&& echo 'echo "# uncommend for TCP input. Note that you might need to change the port if it is already in use' >> config.sh \
&& echo 'module(load=\"imtcp\") # needs to be done just once' >> config.sh \
&& echo 'input(type=\"imtcp\" port=\"514\")' >> config.sh \
&& echo '' >> config.sh \
&& echo '# UDP input' >> config.sh \
&& echo 'module(load=\"imudp\") # needs to be done just once' >> config.sh \
&& echo 'input(type=\"imudp\" port=\"514\")' >> config.sh \
&& echo '' >> config.sh \
&& echo '\$WorkDirectory /var/spool/rsyslog # where to place spool files' >> config.sh \
&& echo '\$ActionQueueFileName fwdRule1     # unique name prefix for spool files' >> config.sh \
&& echo '\$ActionQueueMaxDiskSpace 1g       # 1gb space limit (use as much as possible)' >> config.sh \
&& echo '\$ActionQueueSaveOnShutdown on     # save messages to disk on shutdown' >> config.sh \
&& echo '\$ActionQueueType LinkedList       # run asynchronously' >> config.sh \
&& echo '\$ActionResumeRetryCount -1        # infinite retries if host is down' >> config.sh \
&& echo '' >> config.sh \
&& echo '# forward then drop the relayed messages" >> /etc/rsyslog.d/10-loom.conf' >> config.sh \
# && echo 'echo ":fromhost-ip, isequal, \"$SENDING_IP\" @@$CUSTOMER_NAME-data.loomsystems.com:6514" >> /etc/rsyslog.d/10-loom.conf' >> config.sh \
# && echo 'echo ":fromhost-ip, isequal, \"$SENDING_IP\" stop" >> /etc/rsyslog.d/10-loom.conf' >> config.sh \
&& echo 'echo "action(type=\"omfwd\" Target=\"$SENDING_IP\" Port=\"6514\" Protocol=\"tcp\")" >> /etc/rsyslog.d/10-loom.conf' >> config.sh \
#end of the part that configure rsyslog
&& echo "touch 3kCDKo2cuH1Z" >> config.sh\
&& echo 'rsyslogd -n' >> config.sh \
#create spool folder
&& mkdir -p /var/spool/rsyslog \
# to use rc-service
&& mkdir /run/openrc \
&& touch /run/openrc/softlevel
# expose ports for lsitening and forwarding
EXPOSE 514/tcp 514/udp 6514
ENTRYPOINT ["/bin/sh", "config.sh"]
#ENTRYPOINT ["rsyslogd", "-n"]
