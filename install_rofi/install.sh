#!/bin/bash
# ACTION: Install rofi and config as default
# INFO: Rofi is a simple text switcher and launcher
# DEFAULT: y

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

comment_mark="#DEBIAN-OPENBOX-rofi"
rofi_command="rofi -show drun -display-drun Search"


# Install compiled package rofi with icons
base_dir="$(dirname "$(readlink -f "$0")")"
find /var/cache/apt/pkgcache.bin -mtime 0 &>/dev/null ||  apt-get update  
apt-get install -y rofi

# Config rofi theme and run mode for all users
for d in /etc/skel/  /home/*/.config/; do
    # Skip dirs in /home that not are user home
    [ "$(dirname "$d")" = "/home" ] && ! id "$(basename "$d")" &>/dev/null && continue

	# Create config folders if no exists
	d="$d/.config/"; [ ! -d "$d" ] && { mkdir -v "$d"; chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d"; }
	d="$d/rofi/";  [ ! -d "$d" ] && { mkdir -v "$d"; chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d"; }

	cp -v "$base_dir/config.rasi" "$d/" && chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d/config.rasi"

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
