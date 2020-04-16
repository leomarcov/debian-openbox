#!/bin/bash
# ACTION: Config vim with custom configs
# INFO: VIM editor has some nice options like show match search, ignore case in search, color scheme, etc.  
# DEFAULT: y

# Config variables
base_dir="$(dirname "$(readlink -f "$0")")"

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

# Install vim
echo -e "\e[1mInstalling packages...\e[0m"
find /var/cache/apt/pkgcache.bin -mtime 0 &>/dev/null ||  apt-get update
apt-get install -y vim

# Copy users config
echo -e "\e[1mSetting configs to all users...\e[0m"
for d in  /etc/skel/  /home/*/ /root/; do
    [ "$(dirname "$d")" = "/home" ] && ! id "$(basename "$d")" &>/dev/null && continue	# Skip dirs that no are homes 
	
	cp -v "$base_dir/vimrc" "$d/.vimrc" && chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d/.vimrc"
done
