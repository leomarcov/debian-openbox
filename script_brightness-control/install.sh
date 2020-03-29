#!/bin/bash
# ACTION: Install script brightness
# INFO: Script brightness.sh increase/decrease and set default brightness.
# DEFAULT: y

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

base_dir="$(dirname "$(readlink -f "$0")")"
bash "$base_dir/brightness" -I 
