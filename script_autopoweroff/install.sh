#!/bin/bash
# ACTION: Install script poweroff_last for automatize shutdown if no users logged in 20 minutes
# DEFAULT: n

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

base_dir="$(dirname "$(readlink -f "$0")")"
bash "$base_dir/autopoweroff" -I 20
