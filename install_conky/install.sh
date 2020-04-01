#!/bin/bash
# ACTION: Install theme Conky with new theme
# DEFAULT: y

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

base_dir="$(dirname "$(readlink -f "$0")")"

# Install conky
find /var/cache/apt/pkgcache.bin -mtime 0 &>/dev/null ||  apt-get update
apt-get install -y conky

for d in /etc/skel/  /home/*/ ; do
    # Skip dirs in /home that not are user home
    [ "$(dirname "$d")" = "/home" ] && ! id "$(basename "$d")" &>/dev/null && continue
	
	cp -v "$base_dir"/conkyrc "$d/.conkyrc"
done

# Show /home in conky if /home has mounted in separated partition
if mount | grep -q "on /home[[:blank:]]"; then
for f in  /etc/skel/.conkyrc  /home/*/.conkyrc; do
	sed -i '/Home usage/s/^#//g' "$f"
done
fi
