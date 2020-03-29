#!/bin/bash
# ACTION: Config new bash prompt
# DEFAULT: y

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

base_dir="$(dirname "$(readlink -f "$0")")"
comment_mark="#BL-POSTINSTALL"

for d in /home/*  /etc/skel  /root; do
	# Delete previous lines added
	sed -i "/$comment_mark/Id" "$d/.bashrc" 2> /dev/null
	
	# Append prompt to bashrc
	cat "$base_dir/bashrc" >> "$d/.bashrc"
done
