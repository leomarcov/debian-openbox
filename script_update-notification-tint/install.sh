#!/bin/bash
# ACTION: Install script update-notification
# INFO: Script update-notification.sh checks periodically APT updates and show in tint2 bar
# DEFAULT: y

base_dir="$(dirname "$(readlink -f "$0")")"
bash "$base_dir/update-notification" -I 
