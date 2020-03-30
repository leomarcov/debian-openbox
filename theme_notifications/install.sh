#!/bin/bash
# ACTION: Install clear xfce4-notify theme
# DEFAULT: y

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

base_dir="$(dirname "$(readlink -f "$0")")"

# Install packages
find /var/cache/apt/pkgcache.bin -mtime 0 &>/dev/null ||  apt-get update
apt-get install -y libnotify-bin xfce4-notifyd

# Create theme
mkdir -p "/usr/share/themes/clear-notify/xfce-notify-4.0/"
cp -v "$base_dir/clear_xfce-notify-4.0_gtk.css" "/usr/share/themes/clear-notify/xfce-notify-4.0/gtk.css"

for f in  /etc/skel/  /home/*/ ; do
    # Skip dirs in /home that not are user home
    [ "$(dirname "$d")" = "/home" ] && ! id "$(basename "$d")" &>/dev/null && continue
	
	# Create config folders if no exists
	d="$d/.config/"; [ ! -d "$d" ] && mkdir -v "$d" && chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d"
	d="$d/xfce4/";  [ ! -d "$d" ] && mkdir -v "$d" && chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d"	
	d="$d/xfconf/";  [ ! -d "$d" ] && mkdir -v "$d" && chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d"	
	d="$d/xfce-perchannel-xml/";  [ ! -d "$d" ] && mkdir -v "$d" && chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d"	
	
	f="xfce4-notifyd.xml"
	[ ! -f "$d/$f" ] && cp -v "$base_dir/$f" "$d" && chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d/$f"
	sed -i '/name="theme"/s/value=".*"/value="clear-notify"/' "$f"
done
