#!/bin/bash
# ACTION: Clean system (autoremove not needed packages and remove .deb files)
# INFO: APT stores a lot of unnecesary files and packages
# DEFAULT: y

apt-get -y autoremove
apt-get clean
