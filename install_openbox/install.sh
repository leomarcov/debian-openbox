#!/bin/bash
# ACTION: Install theme GoHome for Openbox and set as default for all users
# INFO: GoHome modified is a clear and cool Openbox theme.
# DEFAULT: y

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

base_dir="$(dirname "$(readlink -f "$0")")"


# INSTALL OPENOX AND DEPENDENCES
find /var/cache/apt/pkgcache.bin -mtime 0 &>/dev/null ||  apt-get update
apt-get install -y openbox obconf obmenu xinit


# COPY OPENBOX THEME
unzip -o "$base_dir"/openbox_theme.zip -d /usr/share/themes/


# COPY OPENBOX CONFIG FILE# COPY OPENBOX CONFIG FILESS
for d in /etc/skel /home/*/; do
    # Skip dirs in /home that not are user home
    [ "$(dirname "$d")" = "/home" ] && ! id "$(basename "$d")" &>/dev/null && continue

	# Create config folders if no exists
	d="$d/.config/"; [ ! -d "$d" ] && { mkdir -v "$d"; chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d"; }
	d="$d/openbox/";  [ ! -d "$d" ] && { mkdir -v "$d"; chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d"; }

	# Copy openbox config file
	cp -v "$base_dir/rc.xml" "$d" 
	# Copy openbox autostart file
	cp -v "$base_dir/autostart" "$d"
done



