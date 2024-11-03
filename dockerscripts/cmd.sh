#!/bin/sh
set -e

read json

echo "Received data from MQTT: $json"

timestamp=$(echo "$json" | jq '.timestamp')
timestamp=$(eval echo $timestamp)
unix_timestamp=$(date -d $timestamp '+%s')
current_time=$(date '+%s')
measurement_time_limit=$(($unix_timestamp + 900))

if [ $current_time -lt $measurement_time_limit ]
then
    echo "$json" | python3 -B -u /opt/bodycomposition/bodycomposition.py
fi
