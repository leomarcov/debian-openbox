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
[ "$(find /var/cache/apt/pkgcache.bin -mtime 0 2>/dev/null)" ] || apt-get update  
apt-get install -y gthumb

# Add as x-image-viewer alternative
echo -e "\e[1mSetting as default alternative...\e[0m"
update-alternatives --install /usr/bin/x-image-viewer x-image-viewer $(which gthumb) 90
