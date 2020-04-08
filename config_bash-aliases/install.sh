#!/bin/bash
# ACTION: Config useful aliases
# DEFAULT: y

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

base_dir="$(dirname "$(readlink -f "$0")")"
comment_mark="#DEBIAN-OPENBOX"

for d in  /home/*/  /etc/skel/  /root; do
	# Skip dirs in /home that not are user home
	[ "$(dirname "$d")" = "/home" ] && ! id "$(basename "$d")" &>/dev/null && continue
    
	sed -i "/$comment_mark/Id" "$d/.bash_aliases" 2> /dev/null
	cp -v "$base_dir/bash_aliases" "$d/.bash_aliases"
done

grep -q ".bash_aliases" /root/.bashrc || echo '
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
' >> /root/.bashrc
