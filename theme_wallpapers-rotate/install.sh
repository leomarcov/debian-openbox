#!/bin/bash
# ACTION: Install a collection of Linux topic solarized wallpapers and install script for rotate everyday for all users
# INFO: Wallpaper author: Andreas Linz https://git.klingt.net/alinz
# DEFAULT: y

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

base_dir="$(dirname "$(readlink -f "$0")")"
wp_base="/usr/share/backgrounds/"
wp_dir="wallpapers-alinz"
wp_default="solarized-wallpaper-debian.png"

# Install dependences
if ! which anacron &>/dev/null || ! which nitrogen &>/dev/null; then
	find /var/cache/apt/pkgcache.bin -mtime 0 &>/dev/null ||  apt-get update
	apt-get -y install anacron nitrogen
fi

# Copy wallpapers folder
[ ! -d "$wp_base" ] && mkdir -p "$wp_base"
cp -rv "$base_dir/$wp_dir/" "$wp_base"

for d in  /etc/skel/  /home/*/; do
	# Skip dirs in /home that not are user home
	[ "$(dirname "$d")" = "/home" ] && ! id "$(basename "$d")" &>/dev/null && continue
	
	# Create config folders if no exists
	d="$d/.config/"; [ ! -d "$d" ] && mkdir -v "$d" && chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d"
	d="$d/nitrogen/"; [ ! -d "$d" ] && mkdir -v "$d" && chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d"

	f="nitrogen.cfg"
	[ ! -f "$d/$f" ] && cp "$base_dir/$f" "$d" && chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d/$f"
	sed -i 's/^dirs *= *.*/dirs='$(echo "$wp_base/$wp_dir" | sed 's/\//\\\//g')';/' "$d/$f"

	f="bg-saved.cfg"
	[ ! -f "$d/$f" ] && cp "$base_dir/$f" "$d" && chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d/$f"
	sed -i 's/^file *= *.*/file='$(echo "$wp_base/$wp_dir/$wp_default" | sed 's/\//\\\//g' )'/' "$d/$f"
done


# Copy rotate script in cron.daily dir
f="wallpaper-rotate"
cp -v "${base_dir}/$f" /etc/cron.daily/
chmod a+x "/etc/cron.daily/$f"

# Exec now rotation
"/etc/cron.daily/$f"
