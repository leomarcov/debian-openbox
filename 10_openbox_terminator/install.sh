#!/bin/bash
# ACTION: Install Kitty terminal and configs
# INFO: Openbox dont include a virtual terminal tool
# DEFAULT: y

# Config variables
base_dir="$(dirname "$(readlink -f "$0")")"

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

# Install packages
echo -e "\e[1mInstalling packages...\e[0m"
paru -Sy kitty --noconfirm

# Copy users config
# echo -e "\e[1mSetting configs to all users...\e[0m"
# for d in /etc/skel/  /home/*/ /root; do
# 	[ "$(dirname "$d")" = "/home" ] && ! id "$(basename "$d")" &>/dev/null && continue	# Skip dirs that no are homes 

# 	# Create config folders if no exists
# 	d="$d/.config/"; [ ! -d "$d" ] && mkdir -v "$d" && chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d"
	
# 	f="helpers.rc"
# 	[ ! -d "$d/xfce4" ] && mkdir -v "$d/xfce4" && chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d/xfce4"
# 	cp -v "$base_dir/$f" "$d/xfce4/" && chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d/xfce4/$f"
	
# 	d="$d/terminator/"; [ ! -d "$d" ] && mkdir -v "$d" && chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d"
# 	f="config"
# 	cp -v "$base_dir/$f" "$d/" && chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d/$f"
# done
