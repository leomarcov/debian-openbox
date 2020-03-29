#!/bin/bash
# ACTION: Install icon theme Numix-Paper and set as default
# INFO: Numix-Paper is a icon theme based on Numix and Paper icon themes.
# DEFAULT: y

base_dir="$(dirname "$(readlink -f "$0")")"
icon_default="Numix-Paper"

# INSTALL NUMIX & PAPER ICON PACAKGES
find /var/cache/apt/pkgcache.bin -mtime 0 &>/dev/null ||  apt-get update  
apt-get install -y numix-icon-theme
(cat "$base_dir"/paper-icon-theme*.aa; cat "$base_dir"/paper-icon-theme*.ab) > /tmp/paper-icon-theme.deb
dpkg -i /tmp/paper-icon-theme.deb
dpkg -i "$base_dir"/bunsen-paper-icon-theme*.deb

if [ ! -d /usr/share/icons/Numix/ ]; then
	echo "$(basename $0) ERROR: Numix theme is not installed"
	exit 1
fi

tar -xzvf "$base_dir"/numix-paper-icon-theme.tgz -C /usr/share/icons/	

	
for d in  /etc/skel/  /home/*/ ; do
    # Skip dirs in /home that not are user home
    [ "$(dirname "$d")" = "/home" ] && ! id "$(basename "$d")" &>/dev/null && continue

	f="$d/.gtkrc-2.0"
	[ ! -f "$f" ] && cp -v "$base_dir/gtkrc-2.0" "$d/.gtkrc-2.0"
	sed -i 's/^gtk-icon-theme-name *= *.*/gtk-icon-theme-name="'"$icon_default"'"/' "$f"		

	# Create config folders if no exists
	d="$d/.config/"; [ ! -d "$d" ] && { mkdir -v "$d"; chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d"; }
	d="$d/.gtk-3.0/"; [ ! -d "$d" ] && { mkdir -v "$d"; chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d"; }

	f="$d/settings.ini"
	[ ! -f "$f" ] && cp -v "$base_dir/settings.ini" "$d"	
	sed -i 's/^gtk-icon-theme-name *= *.*/gtk-icon-theme-name='"$icon_default"'/' "$f"
done

