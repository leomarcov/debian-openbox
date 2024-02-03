#!/bin/bash
# ACTION: Configure pacman to be more colorfull
# INFO: Also it configures some usefull configs
# DEFAULT: y

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }


(
	sed -i '
	s/^#Color/Color/g;
	s/^#CheckSpace/CheckSpace/g;
	/CheckSpace/a ILoveCandy
	/LoveCandy/a ParallelDownloads = 5
	/\[multilib\]/I, +1 s/^#//
' /etc/pacman.conf
)


# Update database
pacman -Sy
