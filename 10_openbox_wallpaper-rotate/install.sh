#!/bin/bash
# ACTION: Install script to rotate everyday Linux solarized wallpapers pack by Andreas Linz
# INFO: wallpaper-rotate script rotate everyday a link to a wallpaper file
# DEFAULT: y

# Config variables
base_dir="$(dirname "$(readlink -f "$0")")"

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

# Install dependences
if ! which cronie &>/dev/null; then
	echo -e "\e[1mInstalling packages...\e[0m"
	su installer -c 'paru -Sy cronie --noconfirm'
fi

# Copy rotate script in cron.daily dir
echo -e "\e[1mInstalling script...\e[0m"
f="wallpaper-rotate"
cp -v "${base_dir}/$f" /etc/cron.daily/
chmod a+x "/etc/cron.daily/$f"

