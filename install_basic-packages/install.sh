#!/bin/bash
# ACTION: Install some basic packages
# INFO: Packages: vim vlc zip unzip gmtp mtp-tools mailutils traceroute acl gnupg2 synaptic galternatives yad mlocate evince
# DEFAULT: y

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

# Install free packages
find /var/cache/apt/pkgcache.bin -mtime 0 &>/dev/null ||  apt-get update  
apt-get install -y vim vlc zip unzip gmtp mtp-tools mailutils traceroute acl gnupg2 synaptic galternatives yad mlocate evince

  
