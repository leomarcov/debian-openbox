#!/bin/bash
# ACTION: Install Sublime Text, add repositories and set as default editor 
# DEFAULT: y

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

# Install repositories and update
if ! grep -R "download.sublimetext.com" /etc/apt/ &> /dev/null; then
	echo "deb https://download.sublimetext.com/ apt/stable/" | tee /etc/apt/sources.list.d/sublime-text.list
	wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | apt-key add -
	apt-get update
fi


# Install package
apt-get install sublime-text || exit 1

# Set as default
#update-alternatives --install /usr/bin/bl-text-editor bl-text-editor /usr/bin/subl 90 && \
#update-alternatives --set bl-text-editor /usr/bin/subl

