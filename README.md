# debian-openbox
<img align="left"  src="https://user-images.githubusercontent.com/32820131/77852132-2de64c00-71dd-11ea-8a66-e4cd3de916f8.png" width="90"> Openbox is a beautifull and lightweight desktop manager, but tediuos to install and config a full usable environment. This script collection automatize **Openbox** installation and essentials tools and apply configurations, styles and themes. Script must be exec over **Debian 10** installation (better on netinstall without desktop environment installed). Each action can be selected interactively in order to install only desired packages and configs.

&nbsp; 
## Main features
  * Install Openbox and dependences.
  * Install and config essential Openbox tools: Tint2, Rofi, Terminator, Thunar, volume control, etc.
  * Config a basic themes and styles for Openbox, Gtk, fonts, icon pack, wallpapers.
  * Install some user tools: Brave/Chrome browser, SublimeText, Atom, VirtualBox and Extensión Pack, sudo,, etc.
  * Config prompt and aliases.
  * Config Grub for skip menu or protect by password and show messages during boot.
  * Install [**`Numix-Paper icon theme`**](https://github.com/leomarcov/debian-openbox/tree/master/theme_numix-paper-icon), a theme based on Numix and Paper icon packs.
  * Install [**`autosnap Windows for Openbox`**](https://github.com/leomarcov/debian-openbox/tree/master/script_autosnap-openbox), a script for autosnap active windows (half-maximice). 
  * Install [**`tty login neofetch`**](https://github.com/leomarcov/debian-openbox/tree/master/script_tty-login-neofetch), a tty login based on neofetch info and config tty lock screen with physlock.
  * Install [**`update-notification script`**](https://github.com/leomarcov/debian-openbox/tree/master/script_update-notification-tint) for check and manage repositories updates.
  * Install [**`brightness control script`**](https://github.com/leomarcov/debian-openbox/tree/master/script_brightness-control) for increase/decrease birghtness screen.

&nbsp; 
## Install
  * Install Debian 10 netinstall without desktop environment.
  * Clone or download project.
  * Exec `install` script and select scripts you want to install.
  
```
$ ./install -h
Exec scripts actions
Usage: install [-l] [-a <actions>] [-y] [-d] [-h]
   -l		Only list actions 
   -a <actions>	Only do selected actions (e.g: -a 5,6,10-15)
   -y		Auto-answer yes to all actions
   -d		Auto-answer default to all actions
   -h		Show this help


# Exec all actions interactively:
$ sudo ./install

# Exec all actions and answer yes to all:
$ sudo ./install -y

# Exec all actions and answer default to all:
$ sudo ./install -d

# Exec only actions 5,7,10,11,12,13,14 and 15:
$ sudo ./install -a 5,7,10-15


# List all actions:
$ ./install -l
[1] Install some basic packages (y)
[2] Install Openbox and tools for full environment (y)
[3] Config useful aliases (y)
[4] Config new bash prompt (y)
[5] Config system for show messages during boot (y)
[6] Config GRUB with password for prevent users edit entries (y)
[7] Config GRUB for skip menu (timeout=0) (n)
[8] Config CTRL+ALT+BACKSPACE shortcut for kill X server (y)
[9] Config vim with custom configs (y)
[10] Install Atom text editor (n)
[11] Install Brave browser, add to repositories and set has default browser (y)
[12] Install Google Chrome, add to repositories and set has default browser (n)
[13] Install script ps_mem.py (y)
[14] Install rofi and config as default (y)
[15] Install Sublime Text, add repositories and set as default editor  (y)
[16] Install sudo and add user 1000 to sudo (y)
[17] Install Termiantor terminal and config theme (y)
[18] Install and config Thunar (show toolbar and double-click for active items) (y)
[19] Install tint2 bar and themes (y)
[20] Install VirtualBox 6.1 and Extension Pack, add to repositories and insert to Openbox menu (y)
[21] Install mixer and volume control (y)
[22] Install script poweroff_last for automatize shutdown if no users logged in 20 minutes (n)
[23] Install script autosnap for autosnap windows with double click in titlebar (y)
[24] Install script brightness (y)
[25] Install exit menu script based on rofi (y)
[26] Config text mode login using tty instead of lightdm display manager (y)
[27] Install script update-notification (y)
[28] Install theme Arc GTK and set as default (y)
[29] Install pack of popular fonts (y)
[30] Install clear xfce4-notify theme (y)
[31] Install icon theme Numix-Paper and set as default (y)
[32] Install nitrogen and copy wallpapers pack and set Aptenodytes wallpaper as default (y)


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
  
  scripts commands
  
  ```

&nbsp;  
## Lincense
[GPLv3](LICENSE)

## Contact
My name is Leonardo Marco. I'm sysadmin teacher in [CIFP Carlos III](https://cifpcarlos3.es/), Cartagena, Murcia (Spain).

You can email me for suggestions, contributions, labadmin help or share your feelings: labadmin@leonardomarco.com
