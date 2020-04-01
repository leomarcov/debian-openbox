#!/bin/bash
# ACTION: Install WPS Office
# DEFAULT: y

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

base_dir="$(dirname "$(readlink -f "$0")")"

atom_url="https://atom.io/download/deb"
t=$(mktemp -d)
wget -P "$t" "$atom_url"  
if [ $? -eq 0 ]; then
  yes | dpkg -i "$t/"*
  apt-get install -f -y 
fi 
rm -rf "$t"
