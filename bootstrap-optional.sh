#!/usr/bin/env bash
#
# Bootstrap a new machine - install optional packages
# Inspired by https://github.com/zilexa/manjaro-gnome-post-install/blob/main/post-install.sh
#
# NOTE: bootstrap.sh is supposed to be run before this script

set -eu

# DRY_RUN="--dry-run"
DRY_RUN=""

echo "_________________________________________________________________________"
echo "                                                                         "
echo "                         OPTIONAL APPLICATIONS                           "
echo "_________________________________________________________________________"

echo "====> Installing command-line packages"
pamac install --no-confirm $DRY_RUN \
    arch-wiki-docs \
    cmatrix \
    dex \
    figlet \
    glava \
    lazygit \
    mtr \
    ncmpcpp \
    podman \
    thefuck \
    tmux
pamac build --no-confirm $DRY_RUN \
    1password-cli \
    bonsai.sh-git \
    gitflow-avh \
    pipes-rs-git \
    youtube-dl \
    zulu-jre-fx-bin

echo "====> Installing fonts"
pamac install --no-confirm $DRY_RUN \
    ttf-hack-nerd \
    ttf-jetbrains-mono-nerd \
    ttf-terminus-nerd \
    ttf-victor-mono-nerd

echo "====> Installing GUI packages"
pamac install --no-confirm $DRY_RUN \
    alacritty \
    datovka \
    dmenu \
    filezilla \
    font-manager \
    libreoffice-fresh \
    nitrogen \
    picard \
    virtualbox \
    virtualbox-guest-iso
pamac build --no-confirm $DRY_RUN \
    alacritty-themes \
    canon-pixma-mg5700-complete \
    vscodium-bin \
    vscodium-bin-marketplace


echo "_________________________________________________________________________"
echo "                                                                         "
echo "                  OPTIONAL PACKAGES HAVE BEEN INSTALLED                  "
echo "_________________________________________________________________________"
