#!/bin/bash

FILE="/var/run/podman/podman.sock"

if [ ! -d "/var/run/podman" ]; then
    echo "Directory does not exist. Creating it now."
    mkdir -p /var/run/podman
    # Additional commands can go here
fi

podman system service --time=0 unix:///var/run/podman/podman.sock > podman.log 2>&1 &
bg_pid=$!
until [ -e "$FILE" ]; do
  echo "Waiting for $FILE to be created..."
  sleep 1 # Wait for 1 second before checking again
done

echo "$FILE has been created. Proceeding..."
chmod 777 ${FILE}
trap "echo 'Stopping...'; kill -TERM $bg_pid; wait $bg_pid; exit 0" SIGTERM SIGINT
wait $bg_pid