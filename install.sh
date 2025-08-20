#!/bin/bash

# Variables
BIN_FILE="ezs"
SHARE_DIR="/usr/share/.ezs/"
SHARE_FILE1=".default_cursor"
SHARE_FILE2=".default_session"
SERVICE_FILE="ezs.service"
UA_VERSION="5.4.4"  # Specify the desired Lua version
LUA_TAR="lua-$LUA_VERSION.tar.gz"
LUA_URL="https://www.lua.org/ftp/$LUA_TAR"

# Function to install dependencies based on the package manager
install_dependencies() {
    if command -v apt-get &> /dev/null; then
        sudo apt-get update
        sudo apt-get install -y build-essential libreadline-dev
    elif command -v dnf &> /dev/null; then
        sudo dnf install -y make gcc readline-devel
    elif command -v yum &> /dev/null; then
        sudo yum install -y make gcc readline-devel
    elif command -v pacman &> /dev/null; then
        sudo pacman -S --noconfirm base-devel readline
    else
        echo "Unsupported package manager. Please install build-essential and readline-dev manually."
        exit 1
    fi
}

# Install dependencies for building Lua
echo "Installing build dependencies..."
install_dependencies

# Download and install Lua from source
if ! command -v lua &> /dev/null; then
    echo "Downloading Lua version $LUA_VERSION..."
    wget "$LUA_URL"
    
    echo "Extracting Lua..."
    tar -zxf "$LUA_TAR"
    
    cd "lua-$LUA_VERSION" || exit
    echo "Building Lua..."
    make linux test
    
    echo "Installing Lua..."
    sudo make install
    
    cd ..  # Go back to the previous directory
    echo "Cleaning up..."
    rm -rf "lua-$LUA_VERSION" "$LUA_TAR"
else
    echo "Lua is already installed."
fi

# Create the share directory if it doesn't exist
if [ ! -d "$SHARE_DIR" ]; then
    echo "Creating directory: $SHARE_DIR"
    sudo mkdir -p "$SHARE_DIR"
fi

# Copy the binary file
echo "Copying binary file: $BIN_FILE to /usr/bin/"
sudo cp "$BIN_FILE" /usr/bin/
sudo chmod 777 "/usr/bin/$BIN_FILE"

# Copy the configuration files
echo "Copying session data file: $SHARE_FILE1 to $SHARE_DIR"
sudo cp "$SHARE_FILE1" "$SHARE_DIR/"
sudo chmod 666 "$SHARE_DIR/$SHARE_FILE1"
echo "Copying session data file: $SHARE_FILE2 to $SHARE_DIR"
sudo cp "$SHARE_FILE2" "$SHARE_DIR/"
sudo chmod 666 "$SHARE_DIR/$SHARE_FILE2"

# Copy the service file
echo "Copying service file: $SERVICE_FILE to /etc/systemd/system/"
sudo cp "$SERVICE_FILE" /etc/systemd/system/

# Reload the systemd daemon
echo "Reloading systemd daemon"
sudo systemctl daemon-reload

# Enable the service
echo "Enabling service: $SERVICE_FILE"
sudo systemctl enable "$SERVICE_FILE"

echo "Installation completed."
