# Docker_bodycomposition-custom

Docker image to upload Mi Bodycomposition Scale data to Garmin Connect.

Based on https://github.com/cyberjunky/python-garminconnect - Release 0.2.19

Needs https://github.com/lolouk44/xiaomi_mi_scale and a MQTT server to work with.

## Docker environment variables
Variable|Usage
--------|-----
MQTTHOST|Hostname for the MQTT server
MQTTUSER|User for subscribing to the MQTT server
MQTTPASSWORD|Password for the MQTT user
MQTTTOPIC|MQTT Topic providing the Mi Scale Data (including the user defined on the scale for assigning the data)
GARMINUSER|Mailaddress of the 'Garmin Connect' account
GARMINPASSWORD|Passwort for the 'Garmin Connect' account
GARMINTOKENSTORE|Directory for 'Garmin Connect' oAuth Tokens - Default /opt/bodycomposition/tokens
