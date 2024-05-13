#!/usr/bin/env bash
set -eu

wired --dnd off

notify-send "Notifications enabled"
sleep 3
wired --drop latest
