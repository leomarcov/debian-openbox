#!/bin/bash
# ACTION: Install vim editor, and apply some configs and plugins
# INFO: Install vim-gtk3, plug plugin manager, airline statusbar and hybrid-material colorsheme
# DEFAULT: y

# Config variables
base_dir="$(dirname "$(readlink -f "$0")")"
comment_mark='"DEBIAN-OPENBOX-vim'

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

# Install vim
echo -e "\e[1mInstalling packages...\e[0m"
[ "$(find /var/cache/apt/pkgcache.bin -mtime 0 2>/dev/null)" ] || apt-get update  
apt-get install -y vim-gtk3 nodejs

# Config vim plug for global (all users)
echo -e "\e[1mInstalling vim plugins for all users in /etc/vim/ ...\e[0m"
mkdir -vp "/etc/vim/autoload"
curl -fLo /etc/vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
mkdir -p "/etc/vim/plugged/"
if [ -s "/etc/vim/vimrc.local" ]; then
	f=/etc/vim/vimrc.local
	sed -i "/${comment_mark}/Id" "$f" 	# Delete all previous lines added
	cat "$base_dir/vimrc.local" /etc/vim/vimrc.local > /etc/vim/vimrc.local
else
	cp -v "$base_dir/vimrc.local" /etc/vim/
fi
vim +'PlugInstall --sync' +qa 		# Download all plugins non-interactively


# Copy users config
echo -e "\e[1mSetting configs to all users...\e[0m"
for d in  /etc/skel/  /home/*/ /root/; do
    [ "$(dirname "$d")" = "/home" ] && ! id "$(basename "$d")" &>/dev/null && continue	# Skip dirs that no are homes 
	
	cp -v "${base_dir}/vimrc" "$d/.vimrc" && chown -R $(stat "$(dirname "$d/.vimrc")" -c %u:%g) "$d/.vimrc"
done
