#!/bin/bash
#===================================================================================
# FILE: wallpaper-rotate
# DESCRIPTION: select image from directory rotationally and generates link to it
# AUTHOR: Leonardo Marco
# VERSION: 1.0
# CREATED: 2020.04.20
# LICENSE: GNU General Public License v3.0
#===================================================================================


#### CONFIG ############################################################
wps_src="/usr/share/backgrounds/wallpapers-alinz/"				# Directory where all images are stored
wp_rotate_dest="/usr/share/backgrounds/wallpapers-alinz/"		# Directory where rotate wallpaper link will be saved
wp_rotate_name="wp-rotate"										# Name of rotate wallpaper link (extension will be completed automatically)
########################################################################

# Checks
[ ! -d "$wps_src" ] && exit 1
[ ! -w  "wps_rotate_dest" ] && exit 1

# Put all wallpaper paths in array
IFS=$'\n'
wps_paths=($(ls "$wps_src"/*))							# Array with all wallpapers path

# Get today wallpaper position in array
n=${#wps_paths[*]}										# Num of items in array
shopt -s extglob; d=$(date +%j); d=${d##+(0)}			# Today day of year
n=$((d%n))												# Today array position

# Get today wallpaper path
wp_selected="${wps_paths[$n]}"
echo -e "Selected wallpaper is:\t\t$wp_selected"

# Generate link
wp_link="${wp_rotate_dest}/${wp_rotate_name}.${wp_selected##*.}"
echo -e "Creating wallpaper link in:\t$wp_link"
ln -sf "$wp_selected" "$wp_link"
