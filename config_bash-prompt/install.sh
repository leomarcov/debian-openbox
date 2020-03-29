#!/bin/bash
# ACTION: Config new bash prompt
# DEFAULT: y

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

base_dir="$(dirname "$(readlink -f "$0")")"
comment_mark="#DEBIAN-OPENBOX"

for d in /home/*  /etc/skel/  /root; do
	# Skip dirs in /home that not are user home
	[ "$(dirname "$d")" = "/home" ] && ! id "$(basename "$d")" &>/dev/null && continue
	
	# Delete previous lines added
	sed -i "/$comment_mark/Id" "$d/.bashrc" 2> /dev/null
	
	# Append prompt to bashrc
	cat "$base_dir/bashrc" >> "$d/.bashrc"
done
