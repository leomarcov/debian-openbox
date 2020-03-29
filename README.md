# debian-openbox
<img align="left"  src="https://user-images.githubusercontent.com/32820131/77852132-2de64c00-71dd-11ea-8a66-e4cd3de916f8.png" width="90"> A collection of scripts to automatize **Openbox** installation and essentials tools and apply configurations, styles and themes to get a beatuful and lightweight environment. Script must be exec over **Debian 10** installation (best on netinstall without desktop environment installed). 

&nbsp; 
## Main features
  * Install Openbox and dependences.
  * Install and config essential Openbox tools: Tint2, Rofi, Terminator, Thunar, volume control, etc.
  * Config a basic themes and styles for Openbox, Gtk, fonts, icon pack, wallpapers.
  * Install some user tools: Brave/Chrome browser, SublimeText, Atom, VirtualBox and Extensión Pack,
  * Config prompt and aliases.
  * Install Sub
  


&nbsp; 
## Install
  * Install Debian 10 netinstall without desktop environment.
  * Clone or download project.
  * Exec `install` script and select scripts you want to install.
  
```
$ ./install -h
Exec scripts actions
Usage: install [-h] [-l] [-a <actions>] [-y] [-d]
   -l		Only list actions 
   -a <actions>	Only do selected actions (e.g: -a 5,6,10-15)
   -y		Auto-answer yes to all actions
   -d		Auto-answer default to all actions
   -h		Show this help


# List all actions:
$ ./install -l
[1] Config first user account for autologin on lightdm (n)
[2] Config first user account for autologin on tty1 (n)
[3] Config useful aliases (y)
[4] Config new bash prompt (y)
[5] Config system for show messages during boot (y)
[6] Config some stupid services for not start during boot (y)
[7] Config GRUB with password for prevent users edit entries (y)
[8] Config GRUB for skip menu (y)
[9] Config CTRL+ALT+BACKSPACE shortcut for kill X server (y)
[10] Config Thunar for show toolbar and double-click for active items (y)
[11] Config vim with custom configs (y)
[12] Install Atom text editor (y)
[13] Install Brave browser, add to repositories and set has default browser (y)
[14] Install Google Chrome, add to repositories and set has default browser (y)
[15] Install playonlinux and MS Office dependencies (n)
[16] Install script ps_mem.py (y)
[17] Install rofi and config as default (y)
[18] Install some useful packages (y)
[19] Install Sublime Text, add repositories and set as default editor  (y)
[20] Install VirtualBox 6.0 and Extension Pack, add to repositories and insert to Openbox menu (y)
[21] Install xfce4-clipman (allow screenshot to clipboard) and replace for clipit (y)
[22] Remove bunsen-welcome autostart script  (y)
[23] Install script poweroff_last for automatize shutdown if no users logged in 20 minutes (y)
[24] Install script autosnap for autosnap windows with double click in titlebar (y)
[25] Install script brightness (y)
[26] Config text mode login using tty instead of lightdm display manager (y)
[27] Install script update-notification (y)
[28] Install theme Arc GTK and set as default (y)
[29] Config theme bl-exit with the classic theme (y)
[30] Install theme Conky with new theme (y)
[31] Install pack of popular fonts (y)
[32] Install clear xfce4-notify theme (y)
[33] Install icon theme Numix-Paper and set as default (y)
[34] Install theme GoHome for Openbox and set as default for all users (y)
[35] Install new Terminator themes (y)
[36] Install new tint2 theme (y)
[37] Copy wallpapers pack and set Aptenodytes wallpaper as default (y)


# Exec all actions interactively:
$ sudo ./install

# Exec all actions and answer yes to all:
$ sudo ./install -y

# Exec all actions and answer default to all:
$ sudo ./install -d

# Exec only actions 5,7,10,11,12,13,14 and 15:
$ sudo ./install -a 5,7,10-15
```
  
&nbsp; 
## Customize
The script can be easily customized. Each action script `.sh` placed in a subdirectory are automatillacy recognized by `install`.
  * For remove action simply delete the action directory.
  * For add action simply add new folder and place the install script `.sh` and dependences. The script must have this header:
  ```
  #!/bin/bash
  # ACTION: Description of the action
  # INFO: Optional aditional info
  # DEFAULT: y
  
  commands to do
  
  ```

&nbsp;  
## Lincense
[GPLv3](LICENSE)

## Contact
My name is Leonardo Marco. I'm sysadmin teacher in [CIFP Carlos III](https://cifpcarlos3.es/), Cartagena, Murcia (Spain).

You can email me for suggestions, contributions, labadmin help or share your feelings: labadmin@leonardomarco.com
