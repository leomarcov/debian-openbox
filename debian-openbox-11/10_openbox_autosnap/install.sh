#!/bin/bash
# ACTION: Install script autosnap for half-maximize windows with mouse middle click in titlebar
# INFO: Openbox lacks autosnap windows function (auto half-maximize)
# INFO: Autosnap script allow half-maximice active window to current quadrant or half screen, accroding mouse location
# INFO: The script is configured to be called when mouse middle is clicked in titlebar
# DEFAULT: y

# Config variables
base_dir="$(dirname "$(readlink -f "$0")")"
comment_mark="#DEBIAN-OPENBOX-autosnap"

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

# Install packages
echo -e "\e[1mInstalling packages...\e[0m"
[ "$(find /var/cache/apt/pkgcache.bin -mtime 0 2>/dev/null)" ] || apt-get update  
apt-get -y install xdotool

# Copy autosnap script
echo -e "\e[1mCopying sript...\e[0m"
cp -v "$base_dir/autosnap" /usr/bin/
chmod +x /usr/bin/autosnap 

# Copy users config
echo -e "\e[1mSetting configs to all users...\e[0m"
for d in /etc/skel/  /home/*/; do
    [ "$(dirname "$d")" = "/home" ] && ! id "$(basename "$d")" &>/dev/null && continue	# Skip dirs that no are homes
	
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
