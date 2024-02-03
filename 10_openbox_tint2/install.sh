#!/bin/bash
# ACTION: Install tint2 taskbar and config some taskbar/menu themes
# INFO: Openbox dont include taskbar tool
# DEFAULT: y

# Config variables
base_dir="$(dirname "$(readlink -f "$0")")"

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

# Install packages
echo -e "\e[1mInstalling packages...\e[0m"
su installer -c 'paru -Sy tint2 --noconfirm'

# Check if laptop or virtualmachine
[ -d /proc/acpi/battery/BAT0 ] && laptop="true"
# Check if virtualmachine:
cat /proc/cpuinfo | grep -i hypervisor &>/dev/null && virtualmachine="true"

# Copy users config
echo -e "\e[1mSetting configs to all users...\e[0m"
for d in /etc/skel/  /home/*/ /root; do
    # Skip dirs in /home that not are user home
    [ "$(dirname "$d")" = "/home" ] && ! id "$(basename "$d")" &>/dev/null && continue

	# Create config folders if no exists
	d="$d/.config/"; [ ! -d "$d" ] && mkdir -v "$d" && chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d"
	d="$d/tint2/";  [ ! -d "$d" ] && mkdir -v "$d" && chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d"

	# Copy all tint2 configs
	touch "$d/each .tint2rc file here is autoloaded"
	cp -v "$base_dir/"*.tint2rc_ "$d" && chown $(stat "$(dirname "$d")" -c %u:%g) "$d"/*.tint2rc_

	[ "$laptop" ] && [ ! "$virtualmachine" ] && tint_version="_laptop"

	# Config .tints to autoload
	mv "$d/taskbar${tint_version}.tint2rc_" "$d/taskbar${tint_version}.tint2rc"
	mv "$d/menu.tint2rc_" "$d/menu.tint2rc"
done

# Copy tint2-session
echo -e "\e[1mCopying tint2-session..\e[0m"
f="tint2-session"
cp -v "$base_dir/$f" /usr/bin
chmod a+x "/usr/bin/$f"

# Remove tint2 defualt themes
echo -e "\e[1mRemoving tint2 default themes e[0m"
for f in $(pacman -Ql tint2 | cut -d" " -f2 | grep tint2rc); do
	rm "$f"
done
