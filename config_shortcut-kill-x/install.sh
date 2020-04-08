#!/bin/bash
# ACTION: Config CTRL+ALT+BACKSPACE shortcut for kill X server
# DEFAULT: y

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

grep "terminate:ctrl_alt_bksp" /etc/default/keyboard &> /dev/null && exit

if grep "XKBOPTIONS" /etc/default/keyboard &>/dev/null; then
  sed -i "s/XKBOPTIONS=\"/XKBOPTIONS=\"terminate:ctrl_alt_bksp,/" /etc/default/keyboard  
else
  echo 'XKBOPTIONS="terminate:ctrl_alt_bksp"'>> /etc/default/keyboard
fi


