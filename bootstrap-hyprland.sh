#!/usr/bin/env bash

set -eu

# DRY_RUN="--dry-run"
DRY_RUN=""

# UPGRADE="--no-upgrade"
UPGRADE=""

pamac install --no-confirm $UPGRADE $DRY_RUN \
    hyprland \
    hyprlang \
    hyprpaper \
     \
    libva-nvidia-driver \
    pipewire \
    qt5-wayland \
    qt5ct \
    waybar \
    wireplumber \
    wofi \
    xdg-desktop-portal-hyprland \
    xorg-xwayland
pamac build --no-confirm $DRY_RUN \
    clipman \
    hypridle-git \
    hyprlock-git \
    hyprshade
