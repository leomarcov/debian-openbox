# TTY login fetch
This script generate dinamic /etc/issue file with some system info, a logo based on ufetch style and the list of available users.

<p align="center">
	<img src="https://user-images.githubusercontent.com/32820131/81058996-de77f780-8ecf-11ea-9ec0-aa089c637c8a.png">
</p>

## Install
Exec `install.sh` script to install loginfetch, dependences and apply configs. Install do this actions in your system:
  * Install `loginfetch` script for generate a `/etc/issue` each time tty login is displayed.
  * Config runlevel to `multi-user.target`.
  * Install and config [Physlock](https://github.com/muennich/physlock), a tty locker called when come back of suspend mode.
  * Config `tty1` for autoexec startx when login.

&nbsp; 
### Manual install
```bash
# Copy script and config file:
cp -v /etc/issue /etc/issue.old
cp -v ./loginfetch /usr/bin/
chmod -v a+x /usr/bin/loginfetch

# Config getty to run loginfetch every time tty login is displayed:
[ ! -d "/etc/systemd/system/getty@.service.d/" ] && mkdir -vp "/etc/systemd/system/getty@.service.d/"
echo '[Service]
ExecStartPre=-/bin/bash -c "/usr/bin/loginfetch"' | tee "/etc/systemd/system/getty@.service.d/override.conf"

# Recomended: install physlock and config for exec when go back from suspend 
```
