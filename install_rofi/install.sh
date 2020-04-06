#!/bin/bash
# ACTION: Install rofi and config as default launcher
# INFO: Rofi is a simple text switcher and launcher
# DEFAULT: y

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

comment_mark="#DEBIAN-OPENBOX-rofi"
rofi_command="rofi -show drun -display-drun Search -comi drun"
base_dir="$(dirname "$(readlink -f "$0")")"

# Install rofi package
find /var/cache/apt/pkgcache.bin -mtime 0 &>/dev/null ||  apt-get update  
apt-get install -y rofi

# Config rofi theme and run mode for all users
for d in /etc/skel/  /home/*/; do
    # Skip dirs in /home that not are user home
    [ "$(dirname "$d")" = "/home" ] && ! id "$(basename "$d")" &>/dev/null && continue

	# Create config folders if no exists
	d2="$d"
	d="$d/.config/"; [ ! -d "$d" ] && mkdir -v "$d" && chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d"
	d="$d/rofi/";  [ ! -d "$d" ] && mkdir -v "$d" && chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d"

	# Copy theme
	f="config.rasi"
	cp -v "$base_dir/$f" "$d/" && chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d/$f"
	
	d="$d2/.config/openbox/"
	f="$d/rc.xml"
	
	# Edit rc.xml config
	sed -i "/${comment_mark}/d" "$f"		# Delete lines added previously
	sed -i "s/<command>gmrun<\/command>/<command>${rofi_command}<\/command>/g" "$f"	# Change alt+f2 shortkey for rofi
	sed -i "/<keyboard>/a<keybind key=\"C-Tab\"><action name=\"Execute\"><command>${rofi_command}<\/command><\/action><\/keybind>     <\!-- #${comment_mark} -->" "$f"	# Add ctrl+tab shortkey
	
	# Set as runas in menu:
	#f="$d/menu.xml"
	#sed -i "/<item label=\"Run Program\">/,/<\/item>/d" "$f"	# Delte current Run program entry
	#sed -i "/<menu id=\"root-menu\"/a<item label=\"Run Program\"><action name=\"Execute\"><command>${rofi_command}<\/command><\/action><\/item>    <\!-- #${comment_mark} -->" "$f"	# Add Run Program entry
done
