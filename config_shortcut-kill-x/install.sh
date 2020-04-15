#!/bin/bash
# ACTION: Enable CTRL+ALT+BACKSPACE shortcut for kill X server
# INFO: In most systems CTRL+ALT+BACKSPACE  shortcut for kill X server is disabled, but is very useful for go back to login when X is not responding
# DEFAULT: y

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

grep "terminate:ctrl_alt_bksp" /etc/default/keyboard &> /dev/null && exit

if grep "XKBOPTIONS" /etc/default/keyboard &>/dev/null; then
  sed -i "s/XKBOPTIONS=\"/XKBOPTIONS=\"terminate:ctrl_alt_bksp,/" /etc/default/keyboard  
else
  echo 'XKBOPTIONS="terminate:ctrl_alt_bksp"'>> /etc/default/keyboard
fi


