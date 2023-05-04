#!/bin/bash
# ACTION: Install script to control screen brightness
# INFO: Script birghtness allow increment and decrement screen brightness
# INFO: Is used in tint2 taskbar config for inc/dec brightness with mouse wheel
# DEFAULT: y

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

base_dir="$(dirname "$(readlink -f "$0")")"
bash "$base_dir/brightness" -I 
