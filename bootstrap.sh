#!/usr/bin/env bash
#
# Bootstrap a new machine - configure system and install required packages
# Inspired by https://github.com/zilexa/manjaro-gnome-post-install/blob/main/post-install.sh

set -eu

# DRY_RUN="--dry-run"
DRY_RUN=""

echo "_________________________________________________________________________"
echo "                                                                         "
echo "          Configure updates (every 6hrs > daily), enable AUR             "
echo "                 Test and rank mirrors, select fastest                   "
echo "_________________________________________________________________________"

# Daily updates instead of 4x a day. No tray icon if there are no updates. Enable AUR (Arch User Repository).
sudo sed -i -e 's@RefreshPeriod = 6@RefreshPeriod = 24@g' /etc/pamac.conf
sudo sed -Ei '/NoUpdateHideIcon/s/^#//' /etc/pamac.conf
sudo sed -Ei '/EnableAUR/s/^#//' /etc/pamac.conf
sudo sed -Ei '/CheckAURUpdates/s/^#//' /etc/pamac.conf
sudo sed -Ei '/KeepNumPackages/s/^#//' /etc/pamac.conf
sudo sed -Ei '/KeepNumPackages/s/KeepNumPackages = 3/KeepNumPackages = 1/' /etc/pamac.conf

# Query mirrors servers (on this continent only) to ensure updates are downloaded via the fastest HTTPS server
sudo pacman-mirrors --continent --api -P https
# Perform update, force refresh of update database files
sudo pamac update --force-refresh --no-confirm


echo "_________________________________________________________________________"
echo "                                                                         "
echo "                             APPLICATIONS                                "
echo "        Install must-have applications for various common tasks          "
echo "_________________________________________________________________________"

echo "====> Installing system development tools for building packages"
pamac install --no-confirm $DRY_RUN \
    autoconf \
    automake \
    make \
    patch \
    pkgconf

echo "====> Installing hardware support packages"
pamac install --no-confirm $DRY_RUN \
    brightnessctl \
    nvidia-utils \
    wireplumber
pamac build --no-confirm $DRY_RUN \
    asoundconf \
    auto-cpufreq \
    ideapad-cm

echo "====> Installing command-line packages"
pamac install --no-confirm $DRY_RUN \
    atool \
    atuin \
    bat \
    bluez \
    bluez-utils \
    btop \
    eza \
    fastfetch \
    fd \
    fish \
    fisher \
    git-delta \
    glow \
    grim \
    gvfs \
    highlight \
    imagemagick \
    jq \
    libgtop \
    libnotify \
    lua-language-server \
    lynx \
    mediainfo \
    neovim \
    networkmanager \
    npm \
    ntp \
    pacman-contrib \
    pandoc-cli \
    playerctl \
    power-profiles-daemon \
    procs \
    python \
    python-gpustat \
    ripgrep \
    slurp \
    source-highlight \
    starship \
    tealdeer \
    trash-cli \
    tree \
    upower \
    wl-clipboard \
    yazi \
    zoxide
pamac build --no-confirm $DRY_RUN \
    gibo \
    pfetch \
    vimv

echo "====> Installing fonts"
pamac install --no-confirm $DRY_RUN \
    noto-fonts-emoji \
    otf-monaspace-nerd \
    ttf-font-awesome \
    ttf-recursive-nerd \
    ttf-mononoki-nerd

echo "====> Installing GUI packages"
pamac install --no-confirm $DRY_RUN \
    dart-sass \
    egl-wayland \
    filelight \
    hyprcursor \
    hypridle \
    hyprland \
    hyprlock \
    hyprpaper \
    hyprpicker \
    hyprpolkitagent \
    interception-tools \
    kitty \
    kitty-shell-integration \
    kitty-terminfo \
    meld \
    neovim-qt \
    nsxiv \
    obsidian \
    proton-pass-bin \
    rofi-wayland \
    qalculate-gtk \
    thunar \
    thunar-archive-plugin \
    thunar-media-tags-plugin \
    thunar-volman \
    wf-recorder \
    xdg-desktop-portal-hyprland \
    yad
pamac build --no-confirm $DRY_RUN \
    ags-hyprpanel-git \
    aylurs-gtk-shell-git \
    brave-bin \
    dropbox \
    espanso-wayland \
    grimblast-git \
    insomnium-bin \
    min-browser-bin \
    rofi-greenclip \
    sourcegit-bin \
    spotify \
    sublime-text-3


echo "_________________________________________________________________________"
echo "                                                                         "
echo "                         Configure system                                "
echo "_________________________________________________________________________"

echo "====> Using fish as default shell"
chsh -s /usr/bin/fish

echo "====> Enabling SysRq key (REISUB, REISUO)"
# If the OS ever freezes completely, Linux allows you to use your keyboard to
# perform a graceful reboot or power-off, through combination of keys.
# This prevents any kind of filesystem damage or drive hardware damage,
# especially on HDDs.
# The following enables the key combination.
echo kernel.sysrq=1 | sudo tee --append /etc/sysctl.d/99-sysctl.conf
# See https://forum.manjaro.org/t/howto-reboot-turn-off-your-frozen-computer-reisub-reisuo/3855

echo "====> Starting udevmon.service (for interception-tools to work)"
systemctl enable udevmon.service
systemctl start udevmon.service

echo "====> Setting up interception-tools (vimproved)"
sudo cp _etc/interception/vimproved-config.yaml /etc/interception/
sudo cp _etc/interception/udevmon.d/vimproved.yml /etc/interception/udevmon.d/

echo "====> Setting up laptop battery conservation mode"
ideapad-cm enable


echo "_________________________________________________________________________"
echo "                                                                         "
echo "                  REQUIRED PACKAGES HAVE BEEN INSTALLED                  "
echo "                                Enjoy :)                                 "
echo "_________________________________________________________________________"
