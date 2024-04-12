#!/usr/bin/env bash

set -eu

# DRY_RUN="--dry-run"
DRY_RUN=""

pamac install --no-confirm $DRY_RUN \
    libva \
    pipewire \
    qt5-wayland \
    qt5ct \
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
    libva-nvidia-driver-git \
    xdg-desktop-portal-hyprland-git
