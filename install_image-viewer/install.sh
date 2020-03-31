#!/bin/bash
# ACTION: Install nomacs image viewer and configs
# DEFAULT: y

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

base_dir="$(dirname "$(readlink -f "$0")")"

# INSTALL OPENOX AND DEPENDENCES
find /var/cache/apt/pkgcache.bin -mtime 0 &>/dev/null ||  apt-get update
apt-get install -y nomacs

# INSTALL CONFIG
for d in /etc/skel/  /home/*/; do
	# Create config folders if no exists
	d="$d/.config/"; [ ! -d "$d" ] && mkdir -v "$d" && chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d"
	d="$d/nomacs/"; [ ! -d "$d" ] && mkdir -v "$d" && chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d"
	
	f="Image Lounge.conf"
	cp -v "$base_dir/$f" "$d/" && chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d/$f"
done

# Add as x-image-viewer alternative
update-alternatives --install /usr/bin/x-image-viewer x-image-viewer $(which nomacs) 90
