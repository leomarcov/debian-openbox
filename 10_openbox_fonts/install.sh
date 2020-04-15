#!/bin/bash
# ACTION: Install some popular fonts
# DESC: Popuar fonts: Liberation, Noto, Inconsolata, Droid Sans, Open Sans, Roboto, Microsoft fonts, Oswald, Overpass, Profont, and others.
# DEFAULT: y

# Config variables
base_dir="$(dirname "$(readlink -f "$0")")"

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

# Install packages
find /var/cache/apt/pkgcache.bin -mtime 0 &>/dev/null ||  apt-get update 
apt-get install -y fonts-droid-fallback fonts-cantarell fonts-liberation fonts-opensymbol fonts-noto-core fonts-noto-mono fonts-inconsolata

# Copy fonts
[ ! -d /usr/share/fonts/extra ] && mkdir /usr/share/fonts/extra/
tar -xzvf "$base_dir"/fonts.tgz -C /usr/share/fonts/extra/


