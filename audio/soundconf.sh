#!/bin/bash
# shell script to set default sound device to USB Jabra, if attached
# gets called through udev rule upon usb attachment/detachment
#
# credit: nimarb (https://github.com/nimarb/dotfiles/blob/audioPCM/soundconf.sh)

usbjabra=$(asoundconf list | sed -n '4{p;q}')
intelhda=$(asoundconf list | sed -n '2{p;q}')

if [[ "attached" == "$1" ]]; then
  asoundconf set-default-card $usbjabra
  #echo "$usbjabra ($usbjabra) set as default audio card :)!"
  exit 1
fi

if [[ "detached" == "$1" ]]; then
  asoundconf set-default-card $intelhda
  #echo "intelhda ($intelhda) set as default audio card :)!"
  exit 1
fi
