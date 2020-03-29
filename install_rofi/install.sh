#!/bin/bash
# ACTION: Install rofi and config as default
# INFO: Rofi is a simple text switcher and launcher
# DEFAULT: y

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

comment_mark="#BL-POSTINSTALL-rofi"
rofi_command="rofi -show drun -display-drun Search"


# Install compiled package rofi with icons
base_dir="$(dirname "$(readlink -f "$0")")"
dpkg -i "$base_dir/"*.deb
find /var/cache/apt/pkgcache.bin -mtime 0 &>/dev/null ||  apt-get update  
apt-get install -f

# Config rofi theme and run mode for all users
for d in /usr/share/bunsen/skel/.config/  /home/*/.config/; do
	# Copy theme
	[ ! -d "$d/rofi/" ] && mkdir -p "$d/rofi/"
	cp -v "$base_dir/android_notification2.rasi" "$d/rofi/config.rasi"

	# Edit rc.xml config
	sed -i "/${comment_mark}/d" "$d/openbox/rc.xml"		# Delete lines added previously
	sed -i "s/<command>gmrun<\/command>/<command>${rofi_command}<\/command>/g" "$d/openbox/rc.xml"	# Change alt+f2 shortkey for rofi
	sed -i "/<keyboard>/a<keybind key=\"C-Tab\"><action name=\"Execute\"><command>${rofi_command}<\/command><\/action><\/keybind>     <\!-- #${comment_mark} -->" "$d/openbox/rc.xml"	# Add ctrl+tab shortkey
	
	# Set as runas in menu:
	sed -i "/<item label=\"Run Program\">/,/<\/item>/d" "$d/openbox/menu.xml"	# Delte current Run program entry
	sed -i "/<menu id=\"root-menu\"/a<item label=\"Run Program\"><action name=\"Execute\"><command>${rofi_command}<\/command><\/action><\/item>    <\!-- #${comment_mark} -->" "$d/openbox/menu.xml"	# Add Run Program entry

	# Config super key as runas
	sed -i '/xcape.*Super_L.*space/s/^/#/g' "$d/openbox/autostart"  
	echo 'xcape -e "Super_L=Control_L|Tab"  '"$comment_mark" | tee -a  "$d/openbox/autostart"
done
