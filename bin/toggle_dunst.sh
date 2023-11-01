#!/usr/bin/env bash
set -eu
is_paused=$(dunstctl is-paused)

if [[ "$is_paused" == "false" ]]; then
  echo "is_paused1=$is_paused"
  dunstify "Disabling notifications"
  sleep 1
  dunstctl close-all
fi

dunstctl set-paused toggle
is_paused=$(dunstctl is-paused)

if [[ "$is_paused" == "false" ]]; then
  echo "is_paused2=$is_paused"
  dunstify "Notifications enabled"
  sleep 1
  dunstctl close
fi
