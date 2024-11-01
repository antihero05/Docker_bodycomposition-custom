#!/bin/sh
set -e

mosquitto_sub -h $MQTTHOST -t $MQTTTOPIC -u $MQTTUSER -P $MQTTPASSWORD -k 60 | /cmd.sh
