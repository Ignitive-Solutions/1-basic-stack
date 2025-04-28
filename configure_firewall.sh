#!/bin/bash
# Script to allow incoming traffic on standard web ports (80 and 443) using ufw.

echo "Attempting to configure firewall using ufw..."

# Check if ufw command exists
if ! command -v ufw &> /dev/null
then
    echo "Error: ufw command not found. Please ensure ufw is installed."
    exit 1
fi

echo "Allowing incoming traffic on port 80/tcp (HTTP)..."
sudo ufw allow 80/tcp

echo "Allowing incoming traffic on port 443/tcp (HTTPS)..."
sudo ufw allow 443/tcp

echo "Allowing incoming traffic on port 5678/tcp (HTTPS)..."
sudo ufw allow 5678/tcp

# Optional: Enable ufw if it's inactive. Uncomment the next line if needed.
# sudo ufw enable

sudo ufw reload
echo "Firewall rules updated to allow ports 80 and 443."

# Optional: Display current status. Uncomment the next line if needed.
sudo ufw status verbose

echo "Firewall configuration script finished."