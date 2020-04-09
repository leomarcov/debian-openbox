#!/bin/bash
# ACTION: Install script autosnap for autosnap windows with double click in titlebar
# INFO: Script autosnap half-maximize windows in Openbox WM.
# DEFAULT: y

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

base_dir="$(dirname "$(readlink -f "$0")")"
comment_mark="#DEBIAN-OPENBOX-autosnap"

# Install dependences
find /var/cache/apt/pkgcache.bin -mtime 0 &>/dev/null ||  apt-get update 
apt-get -y install xdotool

cp -v "$base_dir/autosnap" /usr/bin/
chmod +x /usr/bin/autosnap 

for d in /etc/skel/  /home/*/; do
    # Skip dirs in /home that not are user home
    [ "$(dirname "$d")" = "/home" ] && ! id "$(basename "$d")" &>/dev/null && continue
	
	f="$d/.config/openbox/rc.xml"
	# Skip if Openbox no rc.xml found
	[ ! -f "$f" ] && continue
	
	# Delete all previous lines added
	sed -i "/${comment_mark}/Id" "$f"

	# Add keybinds por each autosnap command
	rc="$(sed '/<keyboard>/q' "$f"; cat "$base_dir/keybinds_rc.xml"; sed -n -e '/<keyboard>/,$p' "$f" | tail +2 )"
	echo "$rc" > "$f"

	# Add context titlebar
	rc="$(sed '/<context name="Titlebar">/q' "$f"; cat "$base_dir/titlebar_rc.xml"; sed -n -e '/<context name="Titlebar">/,$p' "$f" | tail +2)"
	echo "$rc" > "$f"
done
