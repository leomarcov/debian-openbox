#!/bin/bash
# ACTION: Install script update-notification for check periodically APT updates
# INFO: update-notification is a script that every week check pending ATP updates and alert user in tint2 taskbar executor of new packages
# DEFAULT: y

base_dir="$(dirname "$(readlink -f "$0")")"
bash "$base_dir/update-notification" -I 
