#!/bin/bash
# ACTION: Install pipewire, pavucontrol and volumeicon for volume control
# INFO: Openbox dont include tools for manage sound devices
# DEFAULT: y

# Install packages
base_dir="$(dirname "$(readlink -f "$0")")"

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

# Install packages
echo -e "\e[1mInstalling packages...\e[0m"
[ "$(find /var/cache/apt/pkgcache.bin -mtime 0 2>/dev/null)" ] || apt-get update  
apt-get install -y pipewire pipewire-audio pipewire-pulse wireplumber pavucontrol volumeicon-alsa rtkit

# Copy users config
echo -e "\e[1mSetting configs to all users...\e[0m"
for d in /etc/skel /home/*/ /root; do
    [ "$(dirname "$d")" = "/home" ] && ! id "$(basename "$d")" &>/dev/null && continue	# Skip dirs that no are homes

	# Create config folders if no exists
	d="$d/.config/"; [ ! -d "$d" ] && mkdir -v "$d" && chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d"
	d="$d/volumeicon/";  [ ! -d "$d" ] && mkdir -v "$d" && chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d"

	# Copy volumeicon config file
	cp -v "$base_dir/volumeicon" "$d" && chown $(stat "$(dirname "$d")" -c %u:%g) "$d"/volumeicon
done



