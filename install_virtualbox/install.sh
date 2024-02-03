#!/bin/bash
# ACTION: Install VirtualBox 7.0 and Extension Pack and add to repositories
# INFO: VirtualBox is a free opensource hosted hypervisor
# DEFAULT: y

# Config variables
ep_url="https://download.virtualbox.org/virtualbox/7.0.14/Oracle_VM_VirtualBox_Extension_Pack-7.0.14.vbox-extpack"
main_distro="$(cat /etc/apt/sources.list | grep ^deb | awk '{print $3}' | head -1)"

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

# Install repositories and update
su nobody -c 'paru -Sy virtualbox virtualbox-host-dkms virtualbox-guest-iso linux-headers'

# Install packages
echo -e "\e[1mInstalling packages...\e[0m"
[ "$(find /var/cache/apt/pkgcache.bin -mtime 0 2>/dev/null)" ] || apt-get update

# Add VirtualBox in OpenBox menu:
echo -e "\e[1mAdding Openbox menu entry...\e[0m"
for d in /etc/skel/  /home/*/ ; do
	f="$d/.config/openbox/menu.xml"
	[ ! -f "$f" ] && continue
	! grep -q '<command>virtualbox<\/command>' "$f" && sed -i '0,/<separator\/>/s//<separator\/> <item label="VirtualBox" icon="\/usr\/share\/icons\/openbox-menu\/virtualbox.png"><action name="Execute"><command>virtualbox<\/command><\/action><\/item> /' "$f"
done


# Check if virtualbox is installed
if ! which vboxmanage &> /dev/null; then
  echo "VirtualBox is not installed"
  exit 1
fi

# Install extension pack
echo -e "\e[1mDownloading and installing Extension pack..\e[0m"
t=$(mktemp -d)
wget -P "$t" "$ep_url"
[ $? -eq 0 ] && yes | vboxmanage extpack install --replace "$t"/*extpack
rm -rf "$t"

# Fix Virtualbox not load gtk theme
echo -e "\e[1mFixing Virtualbox GTK settings...\e[0m"
su nobody -c 'paru -Sy qt5-styleplugins'
echo "export QT_QPA_PLATFORMTHEME=gtk2" >> /etc/environment
echo "export QT_STYLE_OVERRIDE=fusion" >> /etc/environment

