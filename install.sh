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

# Install Visual Studio Code Extensions
echo "Installing C# Dev Kit extension..."
code --install-extension ms-dotnettools.csdevkit
echo "Installing Docker extension..."
code --install-extension ms-azuretools.vscode-docker
echo "Installing GitHub Actions extension..."
code --install-extension github.vscode-github-actions
echo "Installing PowerShell extension..."
code --install-extension ms-vscode.powershell
echo "Installing formatters extension..."
code --install-extension bluebrown.yamlfmt
code --install-extension redhat.vscode-xml

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

# Trust HTTPS certificate on Linux with linux-dev-certs
echo "Installing .NET Linux development certificates..."
sudo dotnet tool update -g linux-dev-certs
sudo dotnet linux-dev-certs install
sudo dotnet dev-certs https --trust

# Dotnet GitVersion
echo "Installing GitVersion tool..."
dotnet tool install --global GitVersion.Tool --version 5.*

echo "Installing nuget command line tool..."
# Mono 
sudo apt install ca-certificates gnupg
sudo gpg --homedir /tmp --no-default-keyring --keyring /usr/share/keyrings/mono-official-archive-keyring.gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
echo "deb [signed-by=/usr/share/keyrings/mono-official-archive-keyring.gpg] https://download.mono-project.com/repo/ubuntu stable-focal main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list
sudo apt update
sudo apt install -y mono-devel
sudo apt install -y curl
# Download the latest stable `nuget.exe` to `/usr/local/bin`
sudo curl -o /usr/local/bin/nuget.exe https://dist.nuget.org/win-x86-commandline/latest/nuget.exe
# Create as alias for nuget
alias nuget="mono /usr/local/bin/nuget.exe"



# Install Git
echo "Installing Git..."
sudo apt-get install -y git-all

# Install Docker
echo "Installing Docker..."
sudo snap install docker

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
echo "Installing Spotify..."r
sudo snap install spotify

# Install VLC player
echo "Installing VLC player..."
sudo snap install vlc

# Install Ghidra
echo "Installing Ghidra..."
sudo snap install ghidra

# Linux Cubic
echo "Installing Linux Cubic..."
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys B7579F80E494ED3406A59DF9081525E2B4F1283B
sudo apt-add-repository -y universe
sudo apt-add-repository -y ppa:cubic-wizard/release
sudo apt update
sudo apt install -y --no-install-recommends cubic


# Add xclip for git log main..HEAD --pretty=format:"- [x] %s (%h)" | xclip
echo "Installing xclip..."
sudo apt install -y xclip 

shell_config="$HOME/.bashrc"
list_command='git log main..HEAD --pretty=format:"- [x] %s (%h)" | tee >(xclip -selection clipboard); echo'

if ! grep -q '.list' "$shell_config"; then
  echo "alias .list=\"$list_command\"" >> "$shell_config"
  echo ".list command added to $shell_config."
else
  echo ".list command already exists in $shell_config."
fi



# Final update and cleanup
echo "Final update and cleanup..."
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get autoremove -y

echo "All tools have been successfully installed!"
