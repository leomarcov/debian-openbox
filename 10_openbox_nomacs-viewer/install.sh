#!/bin/bash
# ACTION: Install nomacs image viewer
# INFO: Openbox dont include image viewer tool
# DEFAULT: y

# Config variables
base_dir="$(dirname "$(readlink -f "$0")")"

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

# Install packages
echo -e "\e[1mInstalling packages...\e[0m"
find /var/cache/apt/pkgcache.bin -mtime 0 &>/dev/null ||  apt-get update
apt-get install -y nomacs

# Copy users config
echo -e "\e[1mSetting configs to all users...\e[0m"
for d in /etc/skel/  /home/*/; do
	# Create config folders if no exists
	d="$d/.config/"; [ ! -d "$d" ] && mkdir -v "$d" && chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d"
	d="$d/nomacs/"; [ ! -d "$d" ] && mkdir -v "$d" && chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d"
	
	f="Image Lounge.conf"
	cp -v "$base_dir/$f" "$d/" && chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d/$f"
done

# Add as x-image-viewer alternative
echo -e "\e[1mSetting as default alternative...\e[0m"
update-alternatives --install /usr/bin/x-image-viewer x-image-viewer $(which nomacs) 90
