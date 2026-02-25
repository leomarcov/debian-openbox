#!/bin/bash
# ACTION: Install VirtualBox Guest Additions from Oracle
# INFO: VirtualBox Guest Additions is a bundle of device drivers and system applications installed inside a virtual machine to improve performance, graphics, and usability.
# DEFAULT: n

# Check system run on VirtualBox VM
if [ "$(systemd-detect-virt)" != "oracle" ]; then
  echo "Current system not running on VirtualBox guest VM" 1>&2
  exit 1
fi

vb_version=$(wget -qO- https://download.virtualbox.org/virtualbox/LATEST.TXT)
echo -e "\e[1mVirtualBox guest detected. Installing Guest Additions ${vb_version} ...\e[0m"
apt-get install -y build-essential dkms linux-headers-$(uname -r) wget
t=$(mktemp -d)
ga_url="https://download.virtualbox.org/virtualbox/${vb_version}/VBoxGuestAdditions_${vb_version}.iso"
wget -P "$t" "$ga_url"
7z x "$t"/* -o"$t" &>/dev/null
bash "$t/VBoxLinuxAdditions.run"
rm -rf "$t"

