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
    arandr \
    autorandr \
    brightnessctl \
    xorg-xrandr
pamac build --no-confirm $DRY_RUN \
    asoundconf \
    auto-cpufreq \
    mons

echo "====> Installing command-line packages"
pamac install --no-confirm $DRY_RUN \
    atool \
    bat \
    btop \
    eza \
    fd \
    fish \
    fisher \
    git-delta \
    glow \
    highlight \
    imagemagick \
    jq \
    lf \
    libnotify \
    lua-language-server \
    lynx \
    maim \
    mediainfo \
    mpd \
    neovim \
    ntp \
    pandoc-cli \
    playerctl \
    procs \
    redshift \
    ripgrep \
    shotgun \
    source-highlight \
    starship \
    tldr \
    trash-cli \
    tree \
    xclip \
    xdotool \
    xorg-xinput \
    zoxide
pamac build --no-confirm $DRY_RUN \
    flavours \
    gibo \
    mpd-mpris-bin \
    paru-bin \
    pfetch \
    ueberzugpp \
    vimv

echo "====> Installing fonts"
pamac install --no-confirm $DRY_RUN \
    ttf-font-awesome \
    ttf-mononoki-nerd
pamac build --no-confirm $DRY_RUN \
    ttf-recursive

echo "====> Installing GUI packages"
pamac install --no-confirm $DRY_RUN \
    dunst \
    feh \
    filelight \
    ghc \
    ghc-libs \
    gsimplecal \
    interception-caps2esc \
    interception-tools \
    kitty \
    kitty-shell-integration \
    kitty-terminfo \
    libx11 \
    libxft \
    libxinerama \
    libxss \
    meld \
    neovim-qt \
    nsxiv \
    obsidian \
    pasystray \
    polybar \
    rofi \
    qalculate-gtk \
    unclutter \
    xmonad-contrib-git \
    xmonad-git \
    xorg-apps \
    xorg-server \
    xorg-xinit \
    xorg-xmessage \
    xterm \
    yad
pamac build --no-confirm $DRY_RUN \
    1password \
    audio-recorder \
    betterlockscreen \
    brave-bin \
    dropbox \
    espanso-bin \
    gitahead \
    insomnium-bin \
    min \
    picom-ftlabs-git \
    polybar-themes-git \
    rofi-greenclip \
    skypeforlinux-stable-bin \
    spotify \
    sublime-text-3 \
    xinit-xsession \
    ymuse-bin


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

echo "====> Configuring keyboard"
localectl --no-convert set-x11-keymap cz,us pc105 ,intl grp:rctrl_rshift_toggle,terminate:ctrl_alt_bks

echo "====> Starting udevmon.service (for interception-tools to work)"
systemctl enable udevmon.service
systemctl start udevmon.service


echo "_________________________________________________________________________"
echo "                                                                         "
echo "                  REQUIRED PACKAGES HAVE BEEN INSTALLED                  "
echo "                                Enjoy :)                                 "
echo "_________________________________________________________________________"
