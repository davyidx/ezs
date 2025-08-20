#!/bin/bash

# Variables
BIN_FILE="ezs"
SHARE_DIR="/usr/share/.ezs/"
SHARE_FILE1=".default_cursor"
SHARE_FILE2=".default_session"
SERVICE_FILE="ezs.service"

if [ ! -d "$SHARE_DIR" ]; then
    echo -e "created directory \".ezs\" under /usr/share"
    sudo mkdir -p "$SHARE_DIR"
fi

sudo cp "$BIN_FILE" /usr/bin/
sudo chmod +x "/usr/bin/$BIN_FILE"

sudo cp "$SHARE_FILE1" "$SHARE_DIR/"
sudo cp "$SHARE_FILE2" "$SHARE_DIR/"

sudo cp "$SERVICE_FILE" /etc/systemd/system/

sudo systemctl daemon-reload

sudo systemctl enable "$SERVICE_FILE"

echo "completed"