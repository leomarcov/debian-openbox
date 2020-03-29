#!/bin/bash
# ACTION: Config vim with custom configs
# DEFAULT: y

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

base_dir="$(dirname "$(readlink -f "$0")")"

for d in  /usr/share/bunsen/skel/  /home/*/ /root/; do
	cp -v "$base_dir/vimrc" "$d/.vimrc"
done
