#!/usr/bin/env bash
set -e
focus_file=~/.focus_one_thing
one_thing=$(cat <(printf '(no focus)|') $focus_file | rofi -sep '|' -dmenu -p 'Focus' -theme ~/.config/rofi/launcher_colorful_style5.rasi)
echo -e "$one_thing" | sed 's/(no focus)/.:./' | cat > $focus_file
