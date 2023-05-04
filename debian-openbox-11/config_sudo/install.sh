#!/bin/bash
# ACTION: Install sudo and add user 1000 to sudo group
# INFO: SUDO allow users exec commands with root privileges without login as root
# DEFAULT: y

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

# Install packages
echo -e "\e[1mInstalling packages...\e[0m"
[ "$(find /var/cache/apt/pkgcache.bin -mtime 0 2>/dev/null)" ] || apt-get update  
apt-get install -y sudo

# Add user 1000 to sudo group
echo -e "\e[1mAdding users to sudo group...\e[0m"
user=$(cat /etc/passwd | cut -f 1,3 -d: | grep :1000$ | cut -f1 -d:)
[ "$user" ] && adduser "$user" sudo
