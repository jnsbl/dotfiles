#!/usr/bin/env bash
#
# Bootstrap a new machine - configure system and install required packages

set -eu

echo "_________________________________________________________________________"
echo "                                                                         "
echo "                             APPLICATIONS                                "
echo "        Install must-have applications for various common tasks          "
echo "_________________________________________________________________________"

echo "====> Installing system utilities"
yay -S --noconfirm --needed \
  grub-btrfs inotify-tools os-prober timeshift-autosnap \
  ideapad-cm k9s

echo "====> Installing CLI/TUI packages"
yay -S --noconfirm --needed \
  stow less tmux yazi glow git-delta procs cmatrix \
  zsh starship npm \
  markdownlint-cli2

echo "====> Installing GUI packages"
yay -S --noconfirm --needed \
  filelight ghostty meld espanso-wayland sourcegit-bin insomnium-bin \
  proton-pass-bin vscodium-bin vscodium-bin-marketplace

echo "_________________________________________________________________________"
echo "                                                                         "
echo "                         Configure system                                "
echo "_________________________________________________________________________"

echo "====> Using zsh as default shell"
chsh -s /usr/bin/zsh

echo "====> Setting up laptop battery conservation mode"
ideapad-cm enable

echo "_________________________________________________________________________"
echo "                                                                         "
echo "                  REQUIRED PACKAGES HAVE BEEN INSTALLED                  "
echo "                                Enjoy :)                                 "
echo "_________________________________________________________________________"
