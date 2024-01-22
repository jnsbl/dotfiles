#!/usr/bin/env bash
#
# Bootstrap a new machine - install necessary packages
# Inspired by https://github.com/zilexa/manjaro-gnome-post-install/blob/main/post-install.sh

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


# Query mirrors servers (on this continent only) to ensure updates are downloaded via the fastest HTTPS server
pacman-mirrors --continent --api -P https
# Perform update, force refresh of update database files
pamac update --force-refresh --no-confirm


echo "_________________________________________________________________________"
echo "                                                                         "
echo "                             APPLICATIONS                                "
echo "        Install must-have applications for various common tasks          "
echo "_________________________________________________________________________"

echo "====> Installing hardware support packages"
pamac install --no-confirm \
    auto-cpufreq \
    xorg-xrandr \
    arandr \
    autorandr \
    mons

echo "====> Installing command-line packages"
pamac install --no-confirm \
    bat \
    btop \
    fd \
    fish \
    gibo \
    git-delta \
    glow \
    highlight \
    jq \
    lf \
    lua-language-server \
    mediainfo \
    mpd \
    mpd-mpris-bin \
    neovim \
    paru-bin \
    patch \
    pfetch \
    playerctl \
    procs \
    redshift \
    ripgrep \
    shotgun \
    starship \
    trash-cli \
    tree \
    ueberzugpp \
    vimv \
    zoxide

echo "====> Installing fonts"
pamac install --no-confirm \
    ttf-font-awesome \
    ttf-mononoki-nerd \
    ttf-recursive

echo "====> Installing GUI packages"
pamac install --no-confirm \
    1password \
    audio-recorder \
    betterlockscreen \
    brave-bin \
    dropbox \
    dunst \
    espanso \
    feh \
    filelight \
    ghc (version?) \
    ghc-libs \
    gitahead-bin \
    gsimplecal \
    insomnium-bin \
    interception-caps2esc \
    interception-tools \
    interception-vimproved-git \
    kitty \
    kitty-shell-integration \
    kitty-terminfo \
    meld \
    min \
    neovim-qt \
    nsxiv \
    obsidian \
    pasystray \
    picom-git \
    polybar \
    polybar-themes-git \
    rofi \
    rofi-greenclip \
    qalculate-gtk \
    skypeforlinux-stable-bin \
    spotify \
    sublime-text-3 \
    unclutter \
    xinit-xsession \
    xterm \
    yad \
    ymuse-bin


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
echo "                               ALL DONE                                  "
echo "                               Enjoy :)                                  "
echo "_________________________________________________________________________"
