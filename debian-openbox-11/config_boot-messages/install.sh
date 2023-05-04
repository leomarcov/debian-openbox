#!/bin/bash
# ACTION: Config system for show text messages during boot time
# INFO: In boot process the system can show a stupid logo or messages about the booting process
# DEFAULT: y

# Config variables
base_dir="$(dirname "$(readlink -f "$0")")"

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

# Delete existing lines
for i in $(cat "$base_dir/grub.conf"  | cut -f1 -d=); do
	sed -i "/\b$i=/Id" /etc/default/grub
done

# Add lines
echo -e "\e[1mSetting GRUB config...\e[0m"
cat "$base_dir/grub.conf" >> /etc/default/grub

# Update grub
echo -e "\e[1mUpdating GRUB..\e[0m"
update-grub
