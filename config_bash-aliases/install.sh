#!/bin/bash
# ACTION: Config useful aliases
# DEFAULT: y

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

base_dir="$(dirname "$(readlink -f "$0")")"
comment_mark="#BL-POSTINSTALL"

for d in /home/*  /usr/share/bunsen/skel/  /root; do
	sed -i "/$comment_mark/Id" "$d/.bash_aliases" 2> /dev/null
	cat "$base_dir/bash_aliases" >> "$d/.bash_aliases"
done

grep -q ".bash_aliases" /root/.bashrc || echo '
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
' >> /root/.bashrc
