#!/bin/bash

killall -q polybar
if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    if [[ $m == "eDP-1" ]]; then
      MONITOR=$m polybar --reload primary 2>&1 | tee -a ~/.local/tmp/polybar.log & disown
    else
      MONITOR=$m polybar --reload secondary 2>&1 | tee -a ~/.local/tmp/polybar.log & disown
    fi
  done
else
  polybar --reload primary 2>&1 | tee -a ~/.local/tmp/polybar.log & disown
fi
