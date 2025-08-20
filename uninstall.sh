#!/bin/bash

# Variables
BIN_FILE="ezs"
SHARE_DIR="/usr/share/.ezs/"
SHARE_FILE1=".default_cursor"
SHARE_FILE2=".default_session"
SERVICE_FILE="ezs.service"

# Eliminar el archivo binario
[ -f "/usr/bin/$BIN_FILE" ] && sudo rm "/usr/bin/$BIN_FILE"

# Eliminar los archivos de configuración
[ -f "$SHARE_DIR/$SHARE_FILE1" ] && sudo rm "$SHARE_DIR/$SHARE_FILE1"
[ -f "$SHARE_DIR/$SHARE_FILE2" ] && sudo rm "$SHARE_DIR/$SHARE_FILE2"

# Eliminar el directorio de configuración si está vacío
[ -d "$SHARE_DIR" ] && [ -z "$(ls -A $SHARE_DIR)" ] && sudo rmdir "$SHARE_DIR"

# Eliminar el archivo de servicio
[ -f "/etc/systemd/system/$SERVICE_FILE" ] && {
    sudo systemctl stop "$SERVICE_FILE"
    sudo systemctl disable "$SERVICE_FILE"
    sudo rm "/etc/systemd/system/$SERVICE_FILE"
}

# Recargar el daemon de systemd
sudo systemctl daemon-reload

echo "completed"
