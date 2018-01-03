#!/bin/bash

echo "RegSnips"
set -e

CONFIG_PATH=/data/options.json	
SNIPS_CONFIG=/data/config

MQTT_BRIDGE=$(jq --raw-output '.mqtt_bridge.external' $CONFIG_PATH)
ASSISTANT=$(jq --raw-output '.assistant' $CONFIG_PATH)
SPEAKER=$(jq --raw-output '.speaker' $CONFIG_PATH)
MIC=$(jq --raw-output '.mic' $CONFIG_PATH)
DISABLE_AUDIO_ASR=$(jq --raw-output '.disable_audio_asr' $CONFIG_PATH)

echo "[Info] Show audio device"
aplay -l

#comment out the following lines for USB Auido Jabra 510 card 1
#echo "[Info] Setup audio device"
sed -i "s/%%SPEAKER%%/$SPEAKER/g" /etc/asound.conf
sed -i "s/%%MIC%%/$MIC/g" /etc/asound.conf

# check if a new assistant file exists
if [ -f "/share/$ASSISTANT" ]; then
    echo "[Info] Install/Update snips assistant"
    unzip -o -u "/share/$ASSISTANT" -d "/usr/share/snips"
fi

if [ "$DISABLE_AUDIO_ASR" == "true" ]; then
  EXECLUDE_COMP="--exclude-components snips-asr --exclude-components snips-audio-server"
else
  EXECLUDE_COMP=""
fi

# mqtt bridge
if [ "$MQTT_BRIDGE" == "true" ]; then
    HOST=$(jq --raw-output '.mqtt_bridge.host' $CONFIG_PATH)
    PORT=$(jq --raw-output '.mqtt_bridge.port' $CONFIG_PATH)
#    USER=$(jq --raw-output '.mqtt_bridge.user' $CONFIG_PATH)
#    PASSWORD=$(jq --raw-output '.mqtt_bridge.password' $CONFIG_PATH)
    echo "[Info] Setup external mqtt bridge"
/opt/snips/snips-entrypoint.sh --mqtt $HOST:$PORT $EXECLUDE_COMP
else
/opt/snips/snips-entrypoint.sh $EXECLUDE_COMP
fi
