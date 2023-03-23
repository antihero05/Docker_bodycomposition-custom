#!/bin/sh
set -e

read json

echo "Received data from MQTT: $json"

bmi=$(echo "$json" | jq '.bmi')
bone_mass=$(echo "$json" | jq '.bone_mass')
calories=$(echo "$json" | jq '.basal_metabolism')
fat=$(echo "$json" | jq '.body_fat')
hydration=$(echo "$json" | jq '.water')
metabolic_age=$(echo "$json" | jq '.metabolic_age')
muscle_mass=$(echo "$json" | jq '.muscle_mass')
visceral_fat=$(echo "$json" | jq '.visceral_fat')
weight=$(echo "$json" | jq '.weight')

timestamp=$(echo "$json" | jq '.timestamp')
timestamp=$(eval echo $timestamp)
unix_timestamp=$(date -d $timestamp '+%s')

echo "Formatted data at $timestamp: '$bmi', '$bone_mass', '$calories', '$fat', '$hydration', '$metabolic_age', '$muscle_mass', '$visceral_fat', '$weight', '$unix_timestamp'"

current_time=$(date '+%s')
measurement_time_limit=$(($unix_timestamp + 900))

if [ $current_time -lt $measurement_time_limit ]
then
  ./bodycomposition upload --bmi $bmi --bone-mass $bone_mass --calories $calories --fat $fat --hydration $hydration --metabolic-age $metabolic_age --muscle-mass $muscle_mass --visceral-fat $visceral_fat --weight $weight --unix-timestamp $unix_timestamp --email $GARMINUSER --password $GARMINPASSWORD
fi
