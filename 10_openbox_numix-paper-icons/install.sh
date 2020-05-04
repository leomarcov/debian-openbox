#!/bin/bash
# ACTION: Install icon theme Numix-Paper and set as default icons
# INFO: Numix-Paper is a icon theme based on Numix and Paper icon themes
# DEFAULT: y

# Config variables
paper_url="https://snwh.org/paper/download.php?owner=snwh&ppa=ppa&pkg=paper-icon-theme,18.04"
base_dir="$(dirname "$(readlink -f "$0")")"
icon_default="Numix-Paper"

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

# Install packages
echo -e "\e[1mInstalling Numix packages...\e[0m"
[ "$(find /var/cache/apt/pkgcache.bin -mtime 0 2>/dev/null)" ] || apt-get update  
apt-get install -y numix-icon-theme

# Download Paper icon theme and install
echo -e "\e[1mDownloading Paper packages...\e[0m"
t=$(mktemp -u --suffix=".deb")
if wget -O "$t" "$paper_url"; then
	yes | dpkg -i "$t"
	rm -v "$t"
else
	echo "Error downloading Paper icon theme" 1>&2
	echo "Check paper_url variable in $(readlink -f "$0") and set Paper icon theme URL"
	exit 1
fi

if [ ! -d /usr/share/icons/Numix/ ]; then
	echo "$(basename $0) ERROR: Numix icon theme is not installed"
	exit 1
fi
if [ ! -d /usr/share/icons/Paper/ ]; then
	echo "$(basename $0) ERROR: Paper icon theme is not installed"
	exit 1
fi

echo -e "\e[1mInstalling Numix-Paper icon pack...\e[0m"
d="/usr/share/icons/$icon_default"
[ -d "$d" ] && rm -rf "$d"
tar -xzvf "$base_dir"/numix-paper-icon-theme.tgz -C /usr/share/icons/	

# Copy users config
echo -e "\e[1mSetting configs to all users...\e[0m"
for d in  /etc/skel/  /home/*/ /root; do
    # Skip dirs in /home that not are user home
    [ "$(dirname "$d")" = "/home" ] && ! id "$(basename "$d")" &>/dev/null && continue

	f="$d/.gtkrc-2.0"
	[ ! -f "$f" ] && cp -v "$base_dir/gtkrc-2.0" "$d/.gtkrc-2.0" && chown -R $(stat "$(dirname "$d")" -c %u:%g) "$f"
	sed -i 's/^gtk-icon-theme-name *= *.*/gtk-icon-theme-name="'"$icon_default"'"/' "$f"		

	# Create config folders if no exists
	d="$d/.config/"; [ ! -d "$d" ] && mkdir -v "$d" && chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d"
	d="$d/gtk-3.0/"; [ ! -d "$d" ] && mkdir -v "$d" && chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d"

	f="$d/settings.ini"
	[ ! -f "$f" ] && cp -v "$base_dir/settings.ini" "$d" && chown -R $(stat "$(dirname "$d")" -c %u:%g) "$f"
	sed -i 's/^gtk-icon-theme-name *= *.*/gtk-icon-theme-name='"$icon_default"'/' "$f"
done

