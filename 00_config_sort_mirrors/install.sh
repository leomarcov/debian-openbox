#!/bin/bash
# ACTION: Config pacman mirrorlist
# INFO: Sort the mirrorlist for better performance when downloading pkgs
# DEFAULT: y

# Check Root
[[ "$(id -u)" ]]
# Install reflector
paru -Sy  reflector --noconfirm

# Generate and save new mirrorlist
(
	reflector --score 100 --fastest 50 --sort rate --save /etc/pacman.d/mirrorlist &
) &>/dev/null

# Little animation while wating
echo
while pgrep -x reflector &>/dev/null; do
    for c in "|" "/" "-" "\\"; do
        echo -ne "Generating mirrorlist...  $c \r"
        sleep 0.2
    done
done
echo -e "\e[KMirrorlist generated!" # Erase the last echo output from the loop

# Update repo database
paru -Syy
