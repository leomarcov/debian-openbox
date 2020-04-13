#!/bin/bash
# ACTION: Install and config Thunar (show toolbar and double-click for active items)
# DEFAULT: y

# Config variables
base_dir="$(dirname "$(readlink -f "$0")")"

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }
	
# Install packages
find /var/cache/apt/pkgcache.bin -mtime 0 &>/dev/null ||  apt-get update
apt-get install -y thunar thunar-archive-plugin thunar-media-tags-plugin catfish gvfs gvfs-fuse gvfs-backends

# Copy users config
for d in /etc/skel/  /home/*/ ; do
    [ "$(dirname "$d")" = "/home" ] && ! id "$(basename "$d")" &>/dev/null && continue	# Skip dirs that no are homes

    # Create config folders if no exists
	d="$d/.config/"; [ ! -d "$d" ] && mkdir -v "$d" && chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d"
	d="$d/xfce4/"; [ ! -d "$d" ] && mkdir -v "$d" && chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d"
	d="$d/xfconf/"; [ ! -d "$d" ] && mkdir -v "$d" && chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d"
	d="$d/xfce-perchannel-xml/"; [ ! -d "$d" ] && mkdir -v "$d" && chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d"
	
	f="thunar.xml"
	cp -v "$base_dir/$f" "$d" && chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d/$f"
done

# Set alternatives
update-alternatives --install /usr/bin/x-file-manager x-file-manager /usr/bin/thunar 90
