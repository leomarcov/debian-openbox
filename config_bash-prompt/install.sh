#!/bin/bash
# ACTION: Config new bash prompt
# INFO: Bash prompt show colors and info about current dir and user
# DEFAULT: y

# Config variables
base_dir="$(dirname "$(readlink -f "$0")")"
comment_mark="#DEBIAN-OPENBOX"

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

# Copy users config
echo -e "\e[1mSetting configs to all users...\e[0m"
for d in /home/*  /etc/skel/  /root; do
	[ "$(dirname "$d")" = "/home" ] && ! id "$(basename "$d")" &>/dev/null && continue	# Skip dirs that no are homes 
	
	# Delete previous lines added
	sed -i "/$comment_mark/Id" "$d/.bashrc" 2> /dev/null
	
	# Append prompt to bashrc
	cat "$base_dir/bashrc" >> "$d/.bashrc"
done
