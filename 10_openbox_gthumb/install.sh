#!/bin/bash
# ACTION: Install Gthumb image viewer
# INFO: Openbox dont include image viewer tool
# DEFAULT: y

# Config variables
base_dir="$(dirname "$(readlink -f "$0")")"

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

# Install packages
echo -e "\e[1mInstalling packages...\e[0m"
su installer -c 'paru -Sy gthumb --noconfirm'
