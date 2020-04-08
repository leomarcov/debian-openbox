#!/bin/bash
# ACTION: Install a collection of solarized wallpapers (author Andreas: Linz https://git.klingt.net/alinz) and config for rotate everyday for all users
# DEFAULT: n

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

base_dir="$(dirname "$(readlink -f "$0")")"

# Install dependences
if ! which anacron &>/dev/null || ! which nitrogen &>/dev/null; then
	find /var/cache/apt/pkgcache.bin -mtime 0 &>/dev/null ||  apt-get update
	apt-get -y install anacron nitrogen
fi

# Copy wallpapers folder
d="/usr/share/backgrounds/"
[ ! -d "$d" ] && mkdir -p "$d"
cp -rv "${base_dir}/wallpapers-alinz/" "$d"

# Copy rotate script in cron.daily dir
f="wallpaper-rotate"
cp -v "${base_dir}/$f" /etc/cron.daily/
chmod a+x "/etc/cron.daily/$f"

# Exec now rotation
"/etc/cron.daily/$f"
