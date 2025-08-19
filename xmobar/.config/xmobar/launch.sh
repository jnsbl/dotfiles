#!/bin/bash

killall -q xmobar
if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    if [[ $m == "eDP-1" ]]; then
      MONITOR=$m xmobar ~/.config/xmobar/primary.config 2>&1 | tee -a ~/.local/tmp/xmobar.log & disown
    else
      MONITOR=$m xmobar ~/.config/xmobar/secondary.config 2>&1 | tee -a ~/.local/tmp/xmobar.log & disown
    fi
  done
else
  xmobar --reload ~/.config/xmobar/primary.config 2>&1 | tee -a ~/.local/tmp/xmobar.log & disown
fi
