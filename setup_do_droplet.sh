#!/bin/bash

# Script to set up a DigitalOcean Ubuntu Droplet for the AI Dev Stack

echo "--- Starting Droplet Setup ---"

# --- 1. Update System Packages ---
echo "Updating package lists..."
sudo apt-get update -y
echo "Upgrading existing packages..."
sudo apt-get upgrade -y

# --- 2. Verify Docker Installation (Assuming Docker is pre-installed) ---
echo "Verifying Docker installation..."
docker --version
docker compose version
if [ $? -ne 0 ]; then
  echo "Error: Docker or Docker Compose not found. Please ensure they are installed correctly."
  exit 1
fi
echo "Docker and Docker Compose found."

# --- 7. Configure Firewall (UFW) ---
echo "Configuring firewall (UFW)..."
sudo ufw allow ssh       # Allow SSH connections (essential!)
sudo ufw allow 8000/tcp  # Allow FastAPI port
sudo ufw allow 5678/tcp  # Allow n8n port
sudo ufw --force enable  # Enable the firewall without interactive prompt
echo "Firewall configured and enabled."
sudo ufw status verbose # Display firewall status

# --- 8. Add user to docker group (optional, avoids using sudo for docker commands) ---
echo "Adding current user to the docker group..."
sudo usermod -aG docker $USER
echo "IMPORTANT: You need to log out and log back in for the group change to take effect!"

# --- 8. Next Steps (Manual) ---
echo ""
echo "--- Manual Steps Required ---"
echo "1. Log out and log back into the droplet for Docker group changes to apply."
echo "2. Clone your project repository:"
echo "   git clone <your-repository-url>"
echo "   cd <your-repository-directory>"
echo ""
echo "3. Create the .env file from the template:"
echo "   cp .env.template .env"
echo ""
echo "4. Edit the .env file and add your actual secrets/values:"
echo "   nano .env"
echo "   (Fill in DATABASE_URL, N8N_ENCRYPTION_KEY, N8N_USER_MANAGEMENT_JWT_SECRET, etc.)"
echo ""
echo "5. Start the services using Docker Compose:"
echo "   docker compose up -d"
echo ""
echo "6. Check the status of the running containers:"
echo "   docker compose ps"
echo ""
echo "--- Droplet Setup Script Finished ---"