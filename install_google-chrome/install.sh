#!/bin/bash
# ACTION: Install Google Chrome, add to repositories and set has default browser
# DEFAULT: y

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

# Install repositories and update
if ! grep -R "dl.google.com/linux/chrome/deb/" /etc/apt/ &> /dev/null; then
	echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list
	wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - 
	apt-get update
fi

# Install package
apt-get install -y google-chrome-stable
apt-get remove chromium

# Set as default
update-alternatives --set x-www-browser /usr/bin/google-chrome-stable
update-alternatives --set gnome-www-browser /usr/bin/google-chrome-stable
