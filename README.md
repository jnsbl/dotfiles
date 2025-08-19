# dotfiles

Dotfiles use [GNU Stow](https://www.gnu.org/software/stow/) for installation.

## Prerequisites

1. Install [Omarchy](https://omarchy.org/) (not required to actually use these dotfiles but that's what I use as daily driver)
2. Install additional packages

  ```bash
  cd path/to/dotfiles/repo
  ./bootstrap.sh
  ```

## Installation

After cloning this repo, run `stow` to symlink the selected dotfiles.

Example:

```bash
cd path/to/dotfiles/repo
stow zsh starship git lazygit bat btop lazyvim tmux hypr alacritty
```

## Features

### CLI & TUI

- [zsh](https://www.zsh.org/), using [starship](https://starship.rs/) prompt
- [fish](https://fishshell.com/) configured with [fisher](https://github.com/jorgebucaran/fisher), using [starship](https://starship.rs/) prompt and lots of [abbreviations](https://github.com/jnsbl/dotfiles/blob/master/fish/config.fish) for less typing
- [neovim](https://neovim.io/) ([LazyVim](https://www.lazyvim.org/)) as the main editor
- [yazi](https://yazi-rs.github.io/) command-line file manager
- [gfzfg](https://github.com/junegunn/fzf) fuzzy finder
- [zoxide](https://github.com/ajeetdsouza/zoxide) smart `cd` alternative
- [ripgrep](https://github.com/BurntSushi/ripgrep) and [fd](https://github.com/sharkdp/fd) for better searching
- [bat](https://github.com/sharkdp/bat) better `cat` alternative
- [btop](https://github.com/aristocratos/btop) resource monitor
- [lazygit](https://github.com/jesseduffield/lazygit) git TUI client
- [tealdeer](https://tealdeer-rs.github.io/tealdeer/) for displaying [tldr](https://tldr.sh/) pages
- [effortless ctags with git](https://tbaggery.com/2011/08/08/effortless-ctags-with-git.html)

### GUI

- [hyprland](https://hypr.land/) Wayland compositor
- [xmonad](https://xmonad.org/), [awesomewm](https://awesomewm.org/) and [qtile](http://www.qtile.org/) Xorg tiling window managers
  - _note: they are sorted in descending order of recency of being used by me_
- [polybar](https://github.com/polybar/polybar) and [xmobar](https://codeberg.org/xmobar/xmobar) status bars for [xmonad](https://xmonad.org/)
- [alacritty](https://github.com/aarowill/base16-alacritty), [ghostty](https://ghostty.org/), [kitty](https://github.com/kdrag0n/base16-kitty) and [wezterm](https://wezterm.org/) terminals
- [rofi](https://davatorium.github.io/rofi/) application launcher and more
- [dunst](https://github.com/tinted-theming/base16-dunst) and [wired](https://github.com/Toqozz/wired-notify) notification daemons
- [nsxiv](https://nsxiv.codeberg.page/) image viewer
- [greenclip](https://github.com/erebe/greenclip) clipboard manager integrated with [rofi](https://davatorium.github.io/rofi/)
- [gsimplecal](https://github.com/dmedvinsky/gsimplecal) simple calendar
- [picom](https://github.com/yshui/picom) Xorg compositor

### Other

- [base16](https://github.com/chriskempson/base16) color theme framework for many apps, all configurable at once using [flavours](https://github.com/misterio77/flavours)
  - [fzf](https://github.com/fnune/base16-fzf)
  - [highlight](https://github.com/bezhermoso/base16-highlight) syntax highlighter (used as text
    file previewer in `ranger`)
  - [neovim](https://github.com/bradcush/base16-nvim)
  - [rofi](https://gitlab.com/0xdec/base16-rofi)
  - [shell](https://github.com/chriskempson/base16-shell)
  - [xresources](https://github.com/binaryplease/base16-xresources)
  - and more
- [interception-tools](https://gitlab.com/interception/linux/tools) +
  [interception-caps2esc](https://gitlab.com/interception/linux/plugins/caps2esc) combo for
  turning a useless <kbd>Caps Lock</kbd> key into <kbd>Esc</kbd> when pressed alone and
  <kbd>Control</kbd> key when pressed with another key
