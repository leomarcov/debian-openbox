#!/bin/bash
# ACTION: Install Visual Studio Code and add repositories
# INFO: Visual Sutio Code is a powerfuel Microsoft IDE
# DEFAULT: n

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

# Install repositories and update
if ! grep -R "download.sublimetext.com" /etc/apt/ &> /dev/null; then
	echo -e "\e[1mConfiguring repositories...\e[0m"
	echo "deb https://download.sublimetext.com/ apt/stable/" | tee /etc/apt/sources.list.d/sublime-text.list
	wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | apt-key add -
	apt-get update
fi

# Install package
echo -e "\e[1mInstalling packages...\e[0m"
apt-get install sublime-text || exit 1

# Set as default
echo -e "\e[1mSetting as default alternative...\e[0m"
update-alternatives --install /usr/bin/x-text-editor x-text-editor /usr/bin/subl 90 && \
update-alternatives --set x-text-editor /usr/bin/subl

wget -qO - https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
