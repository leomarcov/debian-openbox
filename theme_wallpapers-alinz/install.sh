#!/bin/bash
# ACTION: Install a collection of solarized wallpapers (author Andreas: Linz https://git.klingt.net/alinz) and config for rotate everyday for all users
# DEFAULT: y

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

base_dir="$(dirname "$(readlink -f "$0")")"

# Install anacron
if ! which anacron &>/dev/null; then
	find /var/cache/apt/pkgcache.bin -mtime 0 &>/dev/null ||  apt-get update
	apt-get -y install anacron
fi

# Copy wallpapers folder
cp -rv "${base_dir}/wallpapers-alinz/" /usr/share/backgrounds/

# Copy rotate script
f="wallpaper-rotate"
cp -v "${base_dir}/$f" /etc/cron.daily/
chmod a+x "/etc/cron.daily/$f"
