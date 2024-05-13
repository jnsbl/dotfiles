#!/usr/bin/env bash
set -eu

notify-send "Disabling notifications"
sleep 3
wired --drop all

wired --dnd on
