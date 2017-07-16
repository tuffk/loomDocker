for container in "/var/lib/docker/containers"/*
do
  FILE="$container/config.v2.json"
  python jsoner.py $FILE
done
