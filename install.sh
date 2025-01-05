#!/bin/bash

# Update package list
echo "Updating package list..."
sudo apt-get update -y

# Install prerequisites
echo "Installing prerequisites..."
sudo apt-get install -y wget gpg apt-transport-https snapd

# Install Visual Studio Code
echo "Installing Visual Studio Code..."
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
rm -f packages.microsoft.gpg
sudo apt-get update -y
sudo apt-get install -y code

# Install .NET SDK 8 and 9
echo "Installing .NET SDK 8..."
sudo apt-get install -y dotnet-sdk-8.0
echo "Installing .NET SDK 9..."
sudo apt-get install -y dotnet-sdk-9.0

# Install .NET Runtime 8 and 9
echo "Installing .NET Runtime 8..."
sudo apt-get install -y aspnetcore-runtime-8.0
echo "Installing .NET Runtime 9..."
sudo apt-get install -y aspnetcore-runtime-9.0

# Install Git
echo "Installing Git..."
sudo apt-get install -y git-all

# Install Hexyl
echo "Installing Hexyl..."
sudo apt-get install -y hexyl

# Install Midnight Commander
echo "Installing Midnight Commander..."
sudo apt-get install -y mc

# Install Postman
echo "Installing Postman..."
sudo snap install postman

# Install Chromium
echo "Installing Chromium..."
sudo snap install chromium

# Install Spotify
echo "Installing Spotify..."
sudo snap install spotify

# Final update and cleanup
echo "Final update and cleanup..."
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get autoremove -y

echo "All tools have been successfully installed!"
