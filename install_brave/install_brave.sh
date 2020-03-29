#!/bin/bash
# ACTION: Install Brave browser, add to repositories and set has default browser
# DEFAULT: y

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

# Install repositories and update
if ! grep -R "brave-browser" /etc/apt/ &> /dev/null; then
	echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ trusty main" > /etc/apt/sources.list.d/brave-browser-release-trusty.list
	wget -q -O - https://brave-browser-apt-release.s3.brave.com/brave-core.asc | apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
	apt-get update
fi

# Install package
apt-get install -y brave-browser

# Set as default
update-alternatives --install /usr/bin/x-www-browser brave-browser /usr/bin/brave-browser-stable 90
update-alternatives --install /usr/bin/gnome-www-browser brave-browser /usr/bin/brave-browser-stable 90
update-alternatives --set x-www-browser /usr/bin/brave-browser-stable
update-alternatives --set gnome-www-browser /usr/bin/brave-browser-stable
