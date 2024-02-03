#!/bin/bash
# ACTION: Install some basic GUI packages
# INFO: Debian netinstall comes with few list of GUI installed packages
# INFO: Some basic packages are: vlc gmtp mtp-tools synaptic galternatives evince
# DEFAULT: y

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

# Install free packages
echo -e "\e[1mInstalling packages...\e[0m"
paru -Sy vlc evince --noconfirm