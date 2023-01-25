#!/usr/bin/env bash

PORT=$((12000+$2))

echo $(date +"%T"): Launching AVD $1

LAUNCH_RES=$(/setup/oda dunebox-init --avd $1 --no-launch --no-snapshot-save --await-online)
ASID=$(echo "$LAUNCH_RES" | /setup/jq -r '.auto_session_id') 

echo $(date +"%T"): Launch success. AVD: $1 ASID: $ASID. Connecting on port $PORT

/setup/oda dunebox-connect --asid $ASID --port $PORT
