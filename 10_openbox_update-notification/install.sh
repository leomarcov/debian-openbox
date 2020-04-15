#!/bin/bash
# ACTION: Install script update-notification for check periodically APT updates and show in tint2 bar executor
# DEFAULT: y

base_dir="$(dirname "$(readlink -f "$0")")"
bash "$base_dir/update-notification" -I 
