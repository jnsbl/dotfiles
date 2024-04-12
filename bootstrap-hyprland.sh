#!/usr/bin/env bash

set -eu

# DRY_RUN="--dry-run"
DRY_RUN=""

pamac install --no-confirm $DRY_RUN \
    pipewire \
    qt5-wayland \
    waybar \
    wireplumber \
    wofi \
    xorg-xwayland
pamac build --no-confirm $DRY_RUN \
    clipman \
    hyprcursor-git \
    hypridle-git \
    hyprland-git \
    hyprlock-git \
    hyprpaper-git \
    hyprshade \
    xdg-desktop-portal-hyprland-git
