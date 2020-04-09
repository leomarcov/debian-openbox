#!/bin/bash
# ACTION: Install nitrogen and copy wallpaper pack and set Aptenodytes wallpaper as default
# INFO: Aptenodytes Forsteri Wallpaper by Nixiepro is a clear and beautiful Bunsen wallpaper.
# DEFAULT: y

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

base_dir="$(dirname "$(readlink -f "$0")")"
wp_base="/usr/share/backgrounds/"
wp_dir="wallpapers-pack1"
wp_default="bl-colorful-aptenodytes-forsteri-by-nixiepro.png"

# Install nitrogen
if ! which nitrogen &>/dev/null; then
	find /var/cache/apt/pkgcache.bin -mtime 0 &>/dev/null ||  apt-get update
	apt-get -y install nitrogen
fi

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




