#!/bin/bash
# ACTION: Install script ps_mem.py
# INFO: Script ps_mem.py show RAM memory usage per process.
# DEFAULT: y

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

wget -P /usr/bin "https://raw.githubusercontent.com/pixelb/ps_mem/master/ps_mem.py"
chmod +x /usr/bin/ps_mem.py
