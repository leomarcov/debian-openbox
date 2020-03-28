#!/bin/bash
# ACTION: Install script autosnap for autosnap windows with double click in titlebar
# INFO: Script autosnap half-maximize windows in Openbox WM.
# DEFAULT: y

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

base_dir="$(dirname "$(readlink -f "$0")")"
comment_mark="#BL-POSTINSTALL-autosnap"

# Install dependences
find /var/cache/apt/pkgcache.bin -mtime 0 &>/dev/null ||  apt-get update 
apt-get -y install xdotool

cp -v "$base_dir/autosnap" /usr/bin/
chmod +x /usr/bin/autosnap

