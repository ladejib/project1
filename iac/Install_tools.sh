#!/bin/bash
# For Ubuntu 22.04

set -e # Exit script immediately on first error.

# Log all output to file
exec >> /var/log/init-script.log 2>&1

echo "Starting initialization script..."

# Update system
sudo apt update -y

# Install Docker 
sudo apt install docker.io -y
sudo usermod -aG docker ubuntu
sudo systemctl enable --now docker 

# Wait for Docker to initialize
sleep 10

echo "Initialization script completed successfully."