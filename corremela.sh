echo "borrando y buildeando"
docker rm -f listen2 ; docker build -t listen2 .
echo "\n\n\n\n\n\n----------------------CORRIENDO-------------------------------"
docker run --name listen2 -e SEND_IP=192.168.0.13 -e CUSTOMER_NAME=testing --privileged -v /var/lib/docker/containers:/containers:ro listen2
