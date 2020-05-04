#!/bin/bash
# ACTION: Install some popular fonts
# INFO: Popular fonts: Liberation, Noto, Inconsolata, Droid Sans, Open Sans, Roboto, Microsoft fonts, Oswald, Overpass, Profont, and others.
# DEFAULT: y

# Config variables
base_dir="$(dirname "$(readlink -f "$0")")"

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

# Install packages
echo -e "\e[1mInstalling packages...\e[0m"
[ "$(find /var/cache/apt/pkgcache.bin -mtime 0 2>/dev/null)" ] || apt-get update  
apt-get install -y fonts-droid-fallback fonts-cantarell fonts-liberation fonts-opensymbol fonts-noto-core fonts-noto-mono fonts-inconsolata

# Copy fonts
echo -e "\e[1mCopying fonts...\e[0m"
[ ! -d /usr/share/fonts/extra ] && mkdir /usr/share/fonts/extra/
tar -xzvf "$base_dir"/fonts.tgz -C /usr/share/fonts/extra/


