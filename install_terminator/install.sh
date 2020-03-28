#!/bin/bash
# ACTION: Install Termiantor term and themes
# DEFAULT: y

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

base_dir="$(dirname "$(readlink -f "$0")")"

for d in /usr/share/bunsen/skel/.config/terminator/  /home/*/.config/terminator/; do
	cp -v "$base_dir"/config "$d/"
done
