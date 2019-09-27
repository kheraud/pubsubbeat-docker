#!/bin/sh

# Expect to have a config file to retrieve user host id
OWNER_CONF_FILE="/usr/share/pubsubbeat/pubsubbeat.yml"

# Default uid if no configuration file
PUBSUB_TARGET_ID=0

if [ -f $OWNER_CONF_FILE ]; then
  # Get uid of OWNER_CONF_FILE
  PUBSUB_TARGET_ID=$(stat -c %u $OWNER_CONF_FILE)
fi

if [ $PUBSUB_TARGET_ID -ne 0 ]; then
  # Creating user and group with right uid
  addgroup -g $PUBSUB_TARGET_ID pubsubuser
  adduser -D -H -G pubsubuser -u $PUBSUB_TARGET_ID pubsubuser -s /bin/bash

  # Changing ownership of application / folder to run
  chown -R pubsubuser:pubsubuser /opt/gcp-pubsub-beat

  echo "Running pubsubbeat with user pubsubuser ($PUBSUB_TARGET_ID)"
  # Run pubsubbeat with pubsubuser
  su-exec pubsubuser:pubsubuser /opt/gcp-pubsub-beat/pubsubbeat "$@"
else
  echo "Running pubsubbeat with root user"
  /opt/gcp-pubsub-beat/pubsubbeat "$@"
fi
