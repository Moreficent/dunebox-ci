#!/usr/bin/env bash

for asid in $(/setup/oda dunebox-port-map | /setup/jq -r '.[] | .tag'); do 
  /setup/oda dunebox-terminate --asid $asid
done