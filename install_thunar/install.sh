#!/bin/bash
# ACTION: Install and config Thunar (show toolbar and double-click for active items)
# DEFAULT: y

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

base_dir="$(dirname "$(readlink -f "$0")")"
	
find /var/cache/apt/pkgcache.bin -mtime 0 &>/dev/null ||  apt-get update
apt-get install -y thunar

for d in /etc/skel/  /home/*/ ; do
    # Skip dirs in /home that not are user home
    [ "$(dirname "$d")" = "/home" ] && ! id "$(basename "$d")" &>/dev/null && continue

    # Create config folders if no exists
	d="$d/.config/"; [ ! -d "$d" ] && { mkdir -v "$d"; chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d"; }
	d="$d/xfce4/"; [ ! -d "$d" ] && { mkdir -v "$d"; chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d"; }
	d="$d/xfconf/"; [ ! -d "$d" ] && { mkdir -v "$d"; chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d"; }
	d="$d/xfce-perchannel-xml/"; [ ! -d "$d" ] && { mkdir -v "$d"; chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d"; }
	
	cp -v "$base_dir/thunar.xml" "$d" && chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d/thunar.xml"
done

