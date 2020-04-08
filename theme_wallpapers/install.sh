#!/bin/bash
# ACTION: Install nitrogen and copy wallpapers pack and set Aptenodytes wallpaper as default
# INFO: Aptenodytes Forsteri Wallpaper by Nixiepro is a clear and beautiful Bunsen wallpaper.
# DEFAULT: y

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

base_dir="$(dirname "$(readlink -f "$0")")"
wp_dir="/usr/share/backgrounds/wallpapers/"
wp_default="bl-colorful-aptenodytes-forsteri-by-nixiepro.png"

# Install nitrogen
if ! which nitrogen &>/dev/null; then
	find /var/cache/apt/pkgcache.bin -mtime 0 &>/dev/null ||  apt-get update
	apt-get -y install nitrogen
fi

mkdir -p "$wp_dir"
cp -v "$base_dir/wallpapers/"* "$wp_dir"

for d in  /etc/skel/  /home/*/; do
	# Skip dirs in /home that not are user home
	[ "$(dirname "$d")" = "/home" ] && ! id "$(basename "$d")" &>/dev/null && continue
	
	# Create config folders if no exists
	d="$d/.config/"; [ ! -d "$d" ] && mkdir -v "$d" && chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d"
	d="$d/nitrogen/"; [ ! -d "$d" ] && mkdir -v "$d" && chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d"

	f="bg-saved.cfg"
	[ ! -f "$d/$f" ] && cp "$base_dir/$f" "$d" && chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d/$f"
	sed -i 's/^file *= *.*/file='$(echo "$wp_dir/$wp_default" | sed 's/\//\\\//g' )'/' "$d/$f"
 	
	f="nitrogen.cfg"
	[ ! -f "$d/$f" ] && cp "$base_dir/$f" "$d" && chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d/$f"
	sed -i 's/^dirs *= *.*/dirs='$(echo "$wp_dir" | sed 's/\//\\\//g')';/' "$d/$f"
done




