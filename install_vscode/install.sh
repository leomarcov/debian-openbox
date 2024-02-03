#!/bin/bash
# ACTION: Install Visual Studio Code
# INFO: Visual Sutio Code is a powerfuel Microsoft code editor
# DEFAULT: n

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

# Install package
echo -e "\e[1mInstalling packages...\e[0m"
su installer -c'paru -Sy visual-studio-code-bin --noconfirm'


