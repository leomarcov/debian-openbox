#!/bin/bash
# ACTION: Add paru AUR helper
# INFO: paru it's a AUR wrapper written in Rust
# DEFAULT: y

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }


(
    # Download AUR from the AUR repo
    pushd /tmp
    pacman -Sy git base-devel --noconfirm
    git clone https://aur.archlinux.org/paru-bin

	chown 'nobody:nobody' paru-bin -R
    pushd paru-bin
    su installer -c 'makepkg -sirc --noconfirm'
)


# Update database
paru -Sy
