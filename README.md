# Docker_bodycomposition-custom

Docker image to upload Mi Bodycomposition Scale data to Garmin Connect.

Based on https://github.com/davidkroell/bodycomposition - Release 1.7.0.

Needs https://github.com/lolouk44/xiaomi_mi_scale and a MQTT server to work with.

## Docker environment variables
Variable|Usage
--------|-----
MQTTHOST|Hostname for the MQTT server
MQTTUSER|User for subscribing to the MQTT server
MQTTPASSWORD|Password for the MQTT user
MQTTTOPIC|Topic providing the Mi Scale Data (including user)
GARMINUSER|Mailadress of the 'Garmin Connect' account
GARMINPASSWORD|Passwort for the 'Garmin Connect' account
