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
pamac build --no-confirm \
    1password-cli \
    bonsai.sh-git \
    gitflow-avh \
    pipes-rs-git \
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
    datovka \
    dmenu \
    filezilla \
    nitrogen \
    picard \
    virtualbox \
    virtualbox-guest-iso
pamac build --no-confirm \
    alacritty-themes \
    canon-pixma-mg5700-complete \
    vscodium-bin \
    vscodium-bin-marketplace


echo "_________________________________________________________________________"
echo "                                                                         "
echo "                  OPTIONAL PACKAGES HAVE BEEN INSTALLED                  "
echo "_________________________________________________________________________"
