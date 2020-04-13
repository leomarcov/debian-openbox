#!/bin/bash
# ACTION: Install script for inc/dec screen brightness (used in taskbar for inc/dec brightness with mouse wheel)
# DEFAULT: y

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

base_dir="$(dirname "$(readlink -f "$0")")"
bash "$base_dir/brightness" -I 
