#!/bin/bash
# ACTION: Install Openbox and tools for full environment
# DEFAULT: y

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

base_dir="$(dirname "$(readlink -f "$0")")"


# INSTALL OPENBOX AND DEPENDENCES
find /var/cache/apt/pkgcache.bin -mtime 0 &>/dev/null ||  apt-get update
apt-get install -y openbox obconf obmenu xinit lxappearance compton xfce4-clipman 


# COPY OPENBOX THEME
tar -xzvf "$base_dir"/openbox_theme.tgz -C /usr/share/themes/


# COPY OPENBOX CONFIG FILES
for d in /etc/skel /home/*/; do
    # Skip dirs in /home that not are user home
    [ "$(dirname "$d")" = "/home" ] && ! id "$(basename "$d")" &>/dev/null && continue

	# Create config folders if no exists
	d="$d/.config/"; [ ! -d "$d" ] && mkdir -v "$d" && chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d"
	d="$d/openbox/";  [ ! -d "$d" ] && mkdir -v "$d" && chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d"

	# Copy openbox config file
	cp -v "$base_dir/rc.xml" "$d" && chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d/rc.xml"
	# Copy openbox autostart file
	cp -v "$base_dir/autostart" "$d" && chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d/autostart"
done





