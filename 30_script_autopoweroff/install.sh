#!/bin/bash
# ACTION: Install script poweroff_last for auto-poweroff if no users logged in 20 minutes
# INFO: Automatic poweroff may be useful in public or shared computers to avoid left computers ON needlessly
# DEFAULT: n

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

base_dir="$(dirname "$(readlink -f "$0")")"
bash "$base_dir/autopoweroff" -I 20
