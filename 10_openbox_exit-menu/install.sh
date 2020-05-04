#!/bin/bash
# ACTION: Install script obexit with exit-power menu based on rofi
# INFO: Openbox dont include exit menu to select reboot, poweroff, suspend, lock, etc
# DEFAULT: y

# Config variables
base_dir="$(dirname "$(readlink -f "$0")")"

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

# Install fonts-noto for utf-8 symbols
echo -e "\e[1mInstalling dependences...\e[0m"
[ "$(find /var/cache/apt/pkgcache.bin -mtime 0 2>/dev/null)" ] || apt-get update  
apt-get install -y fonts-noto

# Copy obexit script
echo -e "\e[1mCopying script...\e[0m"
f="obexit"
cp -v "$base_dir/$f" /usr/bin
chmod +x "/usr/bin/$f"

# Copy users config
echo -e "\e[1mSetting configs to all users...\e[0m"
for d in /etc/skel/  /home/*/ /root; do
    [ "$(dirname "$d")" = "/home" ] && ! id "$(basename "$d")" &>/dev/null && continue	# Skip dirs that no are homes

	# Create config folders if no exists
	d2="$d"
	d="$d/.config/"; [ ! -d "$d" ] && mkdir -v "$d" && chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d"
	d="$d/rofi/";  [ ! -d "$d" ] && mkdir -v "$d" && chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d"

	# Copy theme
	f="openbox-menu.rasi"
	cp -v "$base_dir/$f" "$d/" && chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d/$f"
done
