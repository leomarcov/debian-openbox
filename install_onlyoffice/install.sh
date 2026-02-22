#!/bin/bash
# ACTION: Install ONLYOFFICE package and add to repositories
# INFO: ONLYOFFICE offers a secure online office suite highly compatible with MS Office formats
# DEFAULT: n


# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

# Install repositories and update
if ! grep -R "onlyoffice.com" /etc/apt/ &> /dev/null; then
	echo -e "\e[1mConfiguring repositories...\e[0m"
	wget -qO - "https://download.onlyoffice.com/GPG-KEY-ONLYOFFICE" | gpg --dearmor --yes -o /usr/share/keyrings/onlyoffice-keyring.gpg
	echo 'deb [signed-by=/usr/share/keyrings/onlyoffice-keyring.gpg] https://download.onlyoffice.com/repo/debian squeeze main' | sudo tee /etc/apt/sources.list.d/onlyoffice.list
	apt-get update
fi

# Install package
echo -e "\e[1mInstalling packages...\e[0m"
apt-get install sublime-text || exit 1
