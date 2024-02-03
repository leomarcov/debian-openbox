#!/bin/bash
# ACTION: Install Flameshot screen shooter
# INFO: Flameshot is a powerful screenshooter
# DEFAULT: y

# Config variables
base_dir="$(dirname "$(readlink -f "$0")")"
comment_mark='"DEBIAN-OPENBOX-vim'

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

# Install flameshot
su installer -c 'paru -Sy flameshot --noconfirm'

# Copy users config
echo -e "\e[1mSetting configs to all users...\e[0m"
for f in /home/*/.config/openbox/rc.xml /etc/skel/.config/openbox/rc.xml; do
	sed -i 's/xfce4-screenshooter/flameshot gui/g' "$f"
done

for d in  /etc/skel/  /home/*/; do
	df="${d}/.config/flameshot/"
	[ ! -d "$df" ] && mkdir "$df"
	cp -v "$base_dir/flameshot.ini" "$df" && chown -R $(stat "$(dirname "$df/.vimrc")" -c %u:%g) "$df"
done
