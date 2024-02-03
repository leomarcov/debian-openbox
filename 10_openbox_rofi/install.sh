#!/bin/bash
# ACTION: Install rofi launcher and config as default launcher
# INFO: Rofi is a simple text app launcher very useful to search installed tools
# DEFAULT: y

# Config variables
base_dir="$(dirname "$(readlink -f "$0")")"
comment_mark="#ARCHLINUX-OPENBOX-rofi"
rofi_command="rofi -show drun"

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

# Install packages
echo -e "\e[1mInstalling packages...\e[0m"
su nobody -c 'paru -Sy rofi --noconfirm'


# Config rofi theme and run mode for all users
echo -e "\e[1mSetting configs to all users...\e[0m"
for d in /etc/skel/  /home/*/ /root; do
    [ "$(dirname "$d")" = "/home" ] && ! id "$(basename "$d")" &>/dev/null && continue	# Skip dirs that no are homes

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
	sed -i "/<keyboard>/a<keybind key=\"C-Tab\"><action name=\"Execute\"><command>${rofi_command}<\/command><\/action><\/keybind>     <\!-- #${comment_mark} -->" "$f"	# Add ctrl+tab shortkey

	# Set as runas in menu:
	#f="$d/menu.xml"
	#sed -i "/<item label=\"Run Program\">/,/<\/item>/d" "$f"	# Delte current Run program entry
	#sed -i "/<menu id=\"root-menu\"/a<item label=\"Run Program\"><action name=\"Execute\"><command>${rofi_command}<\/command><\/action><\/item>    <\!-- #${comment_mark} -->" "$f"	# Add Run Program entry
done

# Copy .desktop power actions
echo -e "\e[1mCopying .desktop power actions...\e[0m"
cp -v "${base_dir}/power.desktop"/* /usr/share/applications/
