#!/bin/bash
# This script updates the firewall settings:
#    - Adds the HTTPS service to the FedoraWorkstation zone to allow secure web traffic to port 443.
#    - Removes the SSH service from the FedoraWorkstation zone to disable remote access via SSH.
#    - Saves the firewall configuraion to disk so it will be permament
# Requirements:
#    - This script must be run as root
#    - As ssh is being disabled, then you will need access to the virtual server's console to get onto the server
# Usage:
#    - Run the script using `sudo bash setup_https_server.sh`

# Check if the script is run as root - the EUID variable gives the *Effective* numeric ID of the user running the script. The Effective ID takes into account
# privilege escalation via sudo. An EUID of 0 is the root user
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root."
    exit 1
fi

#Set the script to exit on errors... this is a good idea when scripting firewall changes
set -e

# Enable HTTPS service in the firewall
echo "Adding HTTPS service to the firewall..."
firewall-cmd --add-service=https --zone=FedoraWorkstation

# Disable SSH service in the firewall
echo "Removing SSH service from the firewall..."
firewall-cmd --remove-service=ssh --zone=FedoraWorkstation

# Reload the firewall to apply changes
echo "Reloading the firewall..."
firewall-cmd --runtime-to-permanent

echo "Firewall configuration updated successfully."
