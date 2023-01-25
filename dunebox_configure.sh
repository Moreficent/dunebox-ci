#!/usr/bin/env bash

/setup/oda dunebox-configure \
  --server $DUNEBOX_SERVER \
  --access-key $DUNEBOX_ACCESS_KEY \
  --secret-key $DUNEBOX_SECRET_KEY \
  --adb-path /setup/Android/Sdk/platform-tools/adb