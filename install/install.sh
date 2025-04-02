#!/bin/bash

set -e # Exit on error

echo "Running install script as user: $USER"
echo "Running in path: $PWD"
echo "Set up share: $smb_share"


# Update configuration file (assuming the file template uses placeholders)
sed -i "s|__USER__|$user_name|g" signagePi.conf
sed -i "s|SambaShare=.*|SambaShare=$smb_share|" signagePi.conf
sed -i "s|SambaUser.*|SambaUser=$smb_user|" signagePi.conf
sed -i "s|SambaPassword.*|SambaPassword=$smb_password|" signagePi.conf


echo "Updating package lists..."
sudo apt update

# Install required packages
PACKAGES=(
	vim
	smbclient
	cifs-utils
	inotify-tools
	mpv
)

echo "Installing required packages..."
sudo apt install -y "${PACKAGES[@]}"

# Copy files
echo "Copying files..."
sudo cp -r services/* /etc/systemd/system/
sudo cp -r signagePi.conf /etc/

# Enable and start services
sudo systemctl daemon-reload
sudo systemctl enable signagePi_show.service
sudo systemctl enable signagePi_sync.timer
sudo systemctl start signagePi_show.service
sudo systemctl start signagePi_sync.timer

echo "Installation complete!"
echo "Feel free to config via /etc/signagePi.conf"
