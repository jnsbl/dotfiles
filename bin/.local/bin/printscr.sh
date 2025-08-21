#!/usr/bin/env bash
fpath=$HOME/Pictures/Screenshots
fname=Screenshot_$(date '+%Y%m%d_%H%M%S').png

# hyprshot --mode output --silent \
#   --output-folder ${fpath} \
#   --filename ${fname}

grim -o $(hyprctl monitors -j | jq -r '.[] | select(.focused == true).name') \
  $fpath/$fname
