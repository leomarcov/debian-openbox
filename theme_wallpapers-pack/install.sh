#!/bin/bash
# ACTION: Install nitrogen,  copy wallpapers pack and set default wallpaper to all users
# INFO: Include beautiful set of solarized Linux wallpapers created by Andreas Linz (https://git.klingt.net/alinz/linux-pictures)
# DEFAULT: y

# Config variables
base_dir="$(dirname "$(readlink -f "$0")")"
wp_base="/usr/share/backgrounds/"

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

# Copy wallpapers folderes
[ ! -d "$wp_base" ] && mkdir -p "$wp_base"
cp -rv "$base_dir/wallpapers"* "$wp_base"

# Select default wallpaper
[ -f "/etc/cron.daily/wallpaper-rotate" ] && /etc/cron.daily/wallpaper-rotate
if [ -f "$wp_base/wallpapers-alinz/wp-rotate.png" ]; then
	wp_dir="wallpapers-alinz"
	wp_default="wp-rotate.png"
else
	wp_dir="wallpapers-pack1"
	wp_default="bl-colorful-aptenodytes-forsteri-by-nixiepro.png"
fi

# Install nitrogen
if ! which nitrogen &>/dev/null; then
	find /var/cache/apt/pkgcache.bin -mtime 0 &>/dev/null ||  apt-get update
	apt-get -y install nitrogen
fi

for d in  /etc/skel/  /home/*/; do
	[ "$(dirname "$d")" = "/home" ] && ! id "$(basename "$d")" &>/dev/null && continue	# Skip dirs that no are homes
	
	# Create config folders if no exists
	d="$d/.config/"; [ ! -d "$d" ] && mkdir -v "$d" && chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d"
	d="$d/nitrogen/"; [ ! -d "$d" ] && mkdir -v "$d" && chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d"

	f="nitrogen.cfg"
	[ ! -f "$d/$f" ] && cp "$base_dir/$f" "$d" && chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d/$f"
	sed -i 's/^dirs *= *.*/dirs='$(echo "$wp_base" | sed 's/\//\\\//g')';/' "$d/$f"

	f="bg-saved.cfg"
	[ ! -f "$d/$f" ] && cp "$base_dir/$f" "$d" && chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d/$f"
	sed -i 's/^file *= *.*/file='$(echo "$wp_base/$wp_dir/$wp_default" | sed 's/\//\\\//g' )'/' "$d/$f"
done




