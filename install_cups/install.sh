#!/bin/bash
# ACTION: Install CUPS printer system and add user 1000 to lpadmin group
# INFO: CUPS is a printer system for config printers and printer queue
# INFO: Can be managed in http://localhost:631 and admin users must be in lpadmin group
# DEFAULT: n

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

# Install packages
echo -e "\e[1mInstalling packages...\e[0m"
find /var/cache/apt/pkgcache.bin -mtime 0 &>/dev/null ||  apt-get update  
apt-get install -y cups

# Add user 1000 to sudo group
echo -e "\e[1mAdding users to group lpadmin...\e[0m"
user=$(cat /etc/passwd | cut -f 1,3 -d: | grep :1000$ | cut -f1 -d:)
[ "$user" ] && adduser "$user" lpadmin
