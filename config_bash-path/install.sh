#!/bin/bash
# ACTION: Config modified .profile file with new path and color definitions
# DEFAULT: y

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

base_dir="$(dirname "$(readlink -f "$0")")"

for d in  /home/*/  /etc/skel/  /root; do
	# Skip dirs in /home that not are user home
	[ "$(dirname "$d")" = "/home" ] && ! id "$(basename "$d")" &>/dev/null && continue
    
	cp -v "$base_dir/profile" "$d/.profile"
done
