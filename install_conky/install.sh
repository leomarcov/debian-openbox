#!/bin/bash
# ACTION: Install theme Conky with new theme
# DEFAULT: y

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

base_dir="$(dirname "$(readlink -f "$0")")"

for d in /usr/share/bunsen/skel/  /home/*/ ; do
	cp -v "$base_dir"/conkyrc "$d/.conkyrc"
done

# Show /home in conky if /home has mounted in separated partition
if mount | grep -q "on /home[[:blank:]]"; then
for f in  /usr/share/bunsen/skel/.conkyrc  /home/*/.conkyrc; do
	sed -i '/Home usage/s/^#//g' "$f"
done
fi
