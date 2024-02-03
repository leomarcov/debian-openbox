#!/bin/bash
# ACTION: Install Brave Browser
# INFO: Brave browser it's chrome based browser with powerfull cookie and ad blockers
# DEFAULT: y

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

su installer -c 'paru -Sy brave-bin --noconfirm'
