if [ $(id -u) -eq 0 ]; then 	#BL-POSTINSTALL
	PS1="[\[\e]0;\u@\h \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[0m\]]\\$ "; 	#BL-POSTINSTALL
else 	#BL-POSTINSTALL
	PS1="[\[\e]0;\u@\h \w\a\]${debian_chroot:+($debian_chroot)}\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[0m\]]\\$ "; 	#BL-POSTINSTALL
fi 	#BL-POSTINSTALL
