#!/bin/bash
# ACTION: Install Atom text editor and add to repositories
# INFO: Atom is text editor oriented to using in programming languages
# DEFAULT: n

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

# Install repositories and update
if ! grep -R "AtomEditor" /etc/apt/ &> /dev/null; then
	echo -e "\e[1mConfiguring repositories...\e[0m"
	wget -qO - https://packagecloud.io/AtomEditor/atom/gpgkey | gpg --dearmor -o /usr/share/keyrings/atomeditor-keyring.gpg
	echo "deb [arch=amd64 signed-by=/usr/share/keyrings/atomeditor-keyring.gpg] https://packagecloud.io/AtomEditor/atom/any/ any main" | tee /etc/apt/sources.list.d/atomeditor.list
	apt-get update
fi

# Install package
echo -e "\e[1mInstalling packages...\e[0m"
apt-get -y install atom || exit 1
