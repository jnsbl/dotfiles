#!/usr/bin/env bash
fpath=$HOME/Pictures/Screenshots
fname=Screenshot_$(date '+%Y%m%d_%H%M%S').png
if [[ -f /usr/bin/shotgun ]]; then
  shotgun ${fpath}/${fname}
else
  rofi -theme "$HOME/.config/rofi/applets/styles/message.rasi" -e "Please install 'shotgun' first."
fi
