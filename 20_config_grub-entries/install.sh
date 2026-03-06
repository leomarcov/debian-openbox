#!/bin/bash
# ACTION: Config GRUB for disable recovery and UEFI entreis
# INFO: Extra GRUB meny entries can be annoying
# DEFAULT: n

# Config variables
base_dir="$(dirname "$(readlink -f "$0")")"

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

# Delete existing lines
echo -e "\e[1mSetting GRUB config...\e[0m"
for i in $(cat "$base_dir/grub.conf"  | cut -f1 -d=);do
	sed -i "/\b$i=/Id" /etc/default/grub
done

# Add lines
cat "$base_dir/grub.conf" >> /etc/default/grub

# Disable UEFI firmware
chmod -x /etc/grub.d/30_uefi-firmware

# Update grub
echo -e "\e[1mUpdating GRUB...\e[0m"
update-grub
