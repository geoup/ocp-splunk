#!/bin/sh  
echo "Pushing from $SPLUNK_MONITOR_LOCN to $SPLUNK_SERVER" 

/opt/splunkforwarder/bin/splunk start --accept-license
if [ $? -eq 0 ]
then
  echo "Successfully started splunk universal forwarder"
else
  echo "Failed to start universal forwarder " >&2
  exit 1
fi

/opt/splunkforwarder/bin/splunk add forward-server $SPLUNK_SERVER -auth admin:changeme
if [ $? -eq 0 ]
then
  echo "Successfully registered with splunk remote instance "
else
  echo "Failed to register to remote splunk instance " >&2
  exit 1
fi

/opt/splunkforwarder/bin/splunk add monitor -index=ocplogs  $SPLUNK_MONITOR_LOCN
if [ $? -eq 0 ]
then
  echo "Successfully added monitor of $SPLUNK_MONITOR_LOCN"
else
  echo "Failed to monitor $SPLUNK_MONITOR_LOCN" >&2
  exit 1
fi

while :; do
  sleep 10
done

#tail -n 0 -f /opt/splunkforwarder/var/log/splunk/splunkd_stderr.log &
#wait
