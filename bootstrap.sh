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
  ideapad-cm

echo "====> Installing CLI/TUI packages"
yay -S --noconfirm --needed \
  stow less tmux yazi glow git-delta procs cmatrix \
  zsh starship \
  markdownlint-cli2

echo "====> Installing development packages"
yay -S --noconfirm --needed \
  npm kubectl k9s minikube

echo "====> Installing GUI packages"
yay -S --noconfirm --needed \
  filelight ghostty meld espanso-wayland sourcegit-bin insomnium-bin \
  proton-pass-bin vscodium-bin vscodium-bin-marketplace

echo "====> Installing webapps"
omarchy-webapp-install "Kubernetes YAML Generator" https://k8syaml.com/ https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/kubernetes.png

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
echo "                              Clean up                                   "
echo "          Uninstall unused applications shipped with Omarchy             "
echo "_________________________________________________________________________"

yay -Rns 1password-beta 1password-cli kdenlive pinta typora xournalpp

echo "====> Uninstalling unused webapps"
omarchy-webapp-remove "Basecamp"
omarchy-webapp-remove "Figma"
omarchy-webapp-remove "HEY"
omarchy-webapp-remove "Google Contacts"
omarchy-webapp-remove "Google Messages"
omarchy-webapp-remove "Google Photos"
omarchy-webapp-remove "X"

echo "_________________________________________________________________________"
echo "                                                                         "
echo "                  REQUIRED PACKAGES HAVE BEEN INSTALLED                  "
echo "                                Enjoy :)                                 "
echo "_________________________________________________________________________"
