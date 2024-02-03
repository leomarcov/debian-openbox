#!/bin/bash
# ACTION: Install some basic CLI packages
# INFO: Debian netinstall comes with few list of CLI installed packages
# INFO: Some basic packages are: vim zip unzip rar unrar mtp-tools mailutils traceroute acl gnupg2 mlocate apt-transport-https curl ntfs-3g
# DEFAULT: y

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

# Install free packages
echo -e "\e[1mInstalling packages...\e[0m"
su nobody -c 'paru -Sy vim zip unzip rar unrar mtp-tools mailutils traceroute acl gnupg2 mlocate apt-transport-https curl ntfs-3g wgetlinux-firmware linux-headers --noconfirm'

