#!/bin/bash
# ACTION: Add Archlinux multilib repository
# INFO: multilib repository is not enabled by default in Archlinux
# DEFAULT: y

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }


(
	# Uncomment "multilib" repo
	sed -i "/\[multilib\]/I, +1 s/^#/" -i /etc/pacman.conf
)


# Update database
pacman -Sy
