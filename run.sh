if [ -z "$CUSTOMER_NAME" ]
then
  echo "Error starting monitor: please specify your customer name"
  exit 1
fi
python update_filebeat_config.py
filebeat -e &
while true
do
  python update_filebeat_config.py
  sleep 5
done
