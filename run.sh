if [ -z "$CUSTOMER_NAME" ]
then
  echo "Error starting monitor: please specify your customer name"
  exit 1
fi
python jsoner.py
filebeat -e &
while true
do
  python jsoner.py
  sleep 5
done
