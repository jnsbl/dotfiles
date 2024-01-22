#!/usr/bin/env bash
#
# Bootstrap a new machine - install optional packages
# Inspired by https://github.com/zilexa/manjaro-gnome-post-install/blob/main/post-install.sh
#
# NOTE: bootstrap.sh is supposed to be run before this script

set -eu

echo "_________________________________________________________________________"
echo "                                                                         "
echo "                         OPTIONAL APPLICATIONS                           "
echo "_________________________________________________________________________"

echo "====> Installing command-line packages"
pamac install --no-confirm \
    1password-cli \
    arch-wiki-docs \
    bonsai.sh-git \
    cmatrix \
    dex \
    figlet \
    gitflow-avh \
    glava \
    lazygit \
    mtr \
    ncmpcpp \
    pipes-rs-git \
    podman \
    thefuck \
    tmux \
    youtube-dl

echo "====> Installing fonts"
pamac install --no-confirm \
    ttf-hack-nerd \
    ttf-jetbrains-mono-nerd \
    ttf-terminus-nerd \
    ttf-victor-mono-nerd

echo "====> Installing GUI packages"
pamac install --no-confirm \
    alacritty \
    alacritty-themes \
    canon-pixma-mg5700-complete \
    datovka \
    dmenu \
    filezilla \
    networkmanager-dmenu-git \
    nitrogen \
    picard \
    virtualbox \
    virtualbox-guest-iso \
    vscodium-bin \
    vscodium-bin-marketplace


echo "_________________________________________________________________________"
echo "                                                                         "
echo "                  OPTIONAL PACKAGES HAVE BEEN INSTALLED                  "
echo "_________________________________________________________________________"
