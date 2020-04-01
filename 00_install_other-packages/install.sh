
#!/bin/bash
# ACTION: Add contrib and non-free repositories and install some basic packages
# INFO: Useful packages: rar ttf-mscorefonts-installer
# DEFAULT: y

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }


apt-get update  

# Install free packages
apt-get install -y vim vlc fonts-freefont-ttf fonts-droid-fallback zip unzip gmtp mtp-tools mailutils traceroute acl gnupg2 synaptic galternatives yad

# Install non-free packages
apt-get install ttf-mscorefonts-installer rar
