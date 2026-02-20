#!/bin/bash
# ACTION: Install VirtualBoxand Extension Pack from VirtualBox Official Repositories
# INFO: VirtualBox is a free opensource hosted hypervisor
# DEFAULT: y

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

# Install repositories and update
if ! grep -R "download.virtualbox.org" /etc/apt/ &> /dev/null; then
	main_distro="$(cat /etc/apt/sources.list | grep ^deb | awk '{print $3}' | head -1)"
	echo -e "\e[1mConfiguring repositories...\e[0m"	
	wget -qO - "https://www.virtualbox.org/download/oracle_vbox_2016.asc" | gpg --dearmor --yes -o /usr/share/keyrings/virtualbox-keyring.gpg
	echo "deb [arch=amd64 signed-by=/usr/share/keyrings/virtualbox-keyring.gpg] http://download.virtualbox.org/virtualbox/debian $main_distro contrib" | tee /etc/apt/sources.list.d/virtualbox.list
	apt-get update	
fi

# Install packages
vb_package=$(apt-cache pkgnames | grep '^virtualbox-[0-9]' | sort -V | tail -1)
echo -e "\e[1mInstalling ${vb_package} packages...\e[0m"
[ ! "$vb_package" ] && { echo "VirtualBox package not found"; exit 1; }
[ "$(find /var/cache/apt/pkgcache.bin -mtime 0 2>/dev/null)" ] || apt-get update  
apt-get install -y linux-headers-$(uname -r) "$vb_package" || exit 1

# Add VirtualBox in OpenBox menu:
echo -e "\n\e[1mAdding Openbox menu entry...\e[0m"
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
vb_version=$(vboxmanage --version | grep -Eo "^[0-9]\.[0-9]+\.[0-9]+")
ep_url="https://download.virtualbox.org/virtualbox/${vb_version}/Oracle_VM_VirtualBox_Extension_Pack-${vb_version}.vbox-extpack"

echo -e "\n\e[1mDownloading and installing Extension Pack ${vb_version} ...\e[0m"
t=$(mktemp -d)
wget -P "$t" "$ep_url"  
[ $? -eq 0 ] && yes | vboxmanage extpack install --replace "$t"/*extpack 
rm -rf "$t"

