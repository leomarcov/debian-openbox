#!/bin/bash
# ACTION: Config modified .profile file with new path (sbin for all users) and color definitions
# INFO: Debian use a profle file wich PATH has no sbin dirs for regular users
# DEFAULT: y

# Config variables
base_dir="$(dirname "$(readlink -f "$0")")"

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

for d in  /home/*/  /etc/skel/  /root; do
	[ "$(dirname "$d")" = "/home" ] && ! id "$(basename "$d")" &>/dev/null && continue	# Skip dirs that no are homes 
    
	cp -v "$base_dir/profile" "$d/.profile"
done
