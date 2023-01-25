#!/usr/bin/env bash

/setup/Android/Sdk/platform-tools/adb start-server

COUNT=0
for row in $(echo "${DUNEBOX_AVDS}" | /setup/jq -r '.[]'); do 
  /scripts/dunebox_start_impl.sh $row $COUNT &
  ((COUNT++))
done

while true
do 
  CONNECTED=$(/setup/Android/Sdk/platform-tools/adb devices | grep localhost | wc -l)
  echo $(date +"%T"): Connected $CONNECTED of $COUNT
  if [ $CONNECTED -eq $COUNT ]; then
    break
  fi
  sleep 2
done