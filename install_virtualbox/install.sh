#!/bin/bash
# ACTION: Install VirtualBox 6.1 and Extension Pack, add to repositories and insert to Openbox menu
# DEFAULT: y

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }


vb_package="virtualbox-6.1"
ep_url="https://download.virtualbox.org/virtualbox/6.1.4/Oracle_VM_VirtualBox_Extension_Pack-6.1.4.vbox-extpack"
main_distro="$(cat /etc/apt/sources.list | grep ^deb | awk '{print $3}' | head -1)"

# Install repositories and update
if ! grep -R "download.virtualbox.org" /etc/apt/ &> /dev/null; then
	echo "deb http://download.virtualbox.org/virtualbox/debian $main_distro contrib" > /etc/apt/sources.list.d/virtualbox.list
	wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | apt-key add -
	wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | apt-key add -
	apt-get update	
fi

# Install packages
find /var/cache/apt/pkgcache.bin -mtime 0 &>/dev/null ||  apt-get update
apt-get install -y linux-headers-$(uname -r) "$vb_package" || exit 1

# Add VirtualBox in OpenBox menu:
for d in /etc/skel/  /home/*/ ; do
    # Skip dirs in /home that not are user home
    [ "$(dirname "$d")" = "/home" ] && ! id "$(basename "$d")" &>/dev/null && continue

	f="$d/.config/openbox/menu.xml"
	[ ! -f "$f" ] && continue
	! grep -q '<command>virtualbox<\/command>' "$f" && sed -i '0,/<separator\/>/s//<item label="VirtualBox"><action name="Execute"><command>virtualbox<\/command><\/action><\/item> <separator\/>/' "$f"
done


# Get Extension Pack
if ! which vboxmanage &> /dev/null; then
  echo "VirtualBox is not installed"
  exit 1
fi

t=$(mktemp -d)
wget -P "$t" "$ep_url"  
[ $? -eq 0 ] && yes | vboxmanage extpack install --replace "$t"/*extpack 
rm -rf "$t"
