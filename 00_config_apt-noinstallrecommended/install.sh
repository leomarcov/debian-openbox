#!/bin/bash
# ACTION: Config APT to not autoinstall recommended packages
# INFO: APT install by default recommended packages for each apt install
# DEFAULT: y

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

echo 'APT::Install-Recommends "false";' > /etc/apt/apt.conf.d/99norecommends
