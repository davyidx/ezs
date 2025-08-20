#!/bin/bash

# Variables
BIN_FILE="ezs"
SHARE_DIR="/usr/share/.ezs/"
SHARE_FILE1=".default_cursor"
SHARE_FILE2=".default_session"
SERVICE_FILE="ezs.service"

# Remove the binary file
if [ -f "/usr/bin/$BIN_FILE" ]; then
    echo "Removing binary file: $BIN_FILE from /usr/bin/"
    sudo rm "/usr/bin/$BIN_FILE"
fi

# Remove the configuration files
if [ -f "$SHARE_DIR/$SHARE_FILE1" ]; then
    echo "Removing session data file: $SHARE_FILE1 from $SHARE_DIR"
    sudo rm "$SHARE_DIR/$SHARE_FILE1"
fi

if [ -f "$SHARE_DIR/$SHARE_FILE2" ]; then
    echo "Removing session data file: $SHARE_FILE2 from $SHARE_DIR"
    sudo rm "$SHARE_DIR/$SHARE_FILE2"
fi

# Remove the configuration directory if empty
if [ -d "$SHARE_DIR" ] && [ -z "$(ls -A $SHARE_DIR)" ]; then
    echo "Removing directory: $SHARE_DIR"
    sudo rmdir "$SHARE_DIR"
fi

# Remove the service file
if [ -f "/usr/lib/systemd/system/$SERVICE_FILE" ]; then
    echo "Stopping and disabling service: $SERVICE_FILE"
    sudo systemctl stop "$SERVICE_FILE"
    sudo systemctl disable "$SERVICE_FILE"
    echo "Removing service file: $SERVICE_FILE from /usr/lib/systemd/system/"
    sudo rm "/usr/lib/systemd/system/$SERVICE_FILE"
fi

# Reload the systemd daemon
echo "Reloading systemd daemon"
sudo systemctl daemon-reload

echo "Uninstallation completed."
