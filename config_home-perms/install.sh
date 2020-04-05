
#!/bin/bash
# ACTION: Config vim with custom configs
# DEFAULT: y

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

base_dir="$(dirname "$(readlink -f "$0")")"

# Install vim
find /var/cache/apt/pkgcache.bin -mtime 0 &>/dev/null ||  apt-get update
apt-get install -y vim


for d in  /etc/skel/  /home/*/ /root/; do
    # Skip dirs in /home that not are user home
    [ "$(dirname "$d")" = "/home" ] && ! id "$(basename "$d")" &>/dev/null && continue
	
	cp -v "$base_dir/vimrc" "$d/.vimrc" && chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d/.vimrc"
done
