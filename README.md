# dotfiles

Dotfiles use [Dotbot](https://github.com/anishathalye/dotbot) for installation.

## Installation

After cloning this repo, run `install` to automatically set up the development
environment. Note that the install script is idempotent: it can safely be run
multiple times.

```bash
cd ~
mkdir -p code/hobby/dotfiles
cd code/hobby/dotfiles
git clone --recurse-submodules https://github.com/jnsbl/dotfiles.git .
./install
```

_Note: Dotfiles are symlinked to `~/.dotfiles` after installation._

## Features

- [Hyprland](https://hyprland.org/) window manager for Wayland
  with [hyprpanel](https://hyprpanel.com/), [hyprlock](https://github.com/hyprwm/hyprlock/),
  [hypridle](https://github.com/hyprwm/hypridle) and [hyprpaper](https://github.com/hyprwm/hyprpaper)
- [rofi](https://github.com/lbonn/rofi) app launcher
- [fish](https://fishshell.com/) (default shell) configured with
  [fisher](https://github.com/jorgebucaran/fisher), using [starship](https://starship.rs/) prompt
  and lots of [abbreviations](https://github.com/jnsbl/dotfiles/blob/master/fish/config.fish) for
  less typing
- [neovim](https://neovim.io/) as the main editor with a bunch of
  [plugins](https://github.com/jnsbl/dotfiles/tree/master/neovim/lua/plugins)
- [fzf](https://github.com/junegunn/fzf) fuzzy finder for shell and
  [neovim](https://github.com/ibhagwan/fzf-lua)
- [yazi](https://yazi-rs.github.io/) as command-line file manager
- [nsxiv](https://nsxiv.codeberg.page/) as command-line image viewer
- [effortless ctags with git](https://tbaggery.com/2011/08/08/effortless-ctags-with-git.html)
- [catppuccin](https://catppuccin.com/) color theme for many apps
- [lazygit](https://github.com/jesseduffield/lazygit) Git TUI with [delta](https://dandavison.github.io/delta/) syntax-highlighting pager
- [k9s](https://k9scli.io/) Kubernetes CLI
- [zellij](https://zellij.dev/) terminal multiplexer
- [interception-tools](https://gitlab.com/interception/linux/tools) +
  [interception-vimproved](https://github.com/maricn/interception-vimproved) combo for
  turning a useless <kbd>Caps Lock</kbd> key into <kbd>Esc</kbd> when pressed alone and
  a custom modifier when pressed with another key
- [auto-cpufreq](https://github.com/AdnanHodzic/auto-cpufreq) and [ideapad-conservation-mode](https://github.com/archlinux-jerry/ideapad-conservation-mode) (I use Lenovo Legion laptops)

# Bootstrap

Custom shell script is provided for installing all necessary packages (handy when bootstrapping a freshly installed OS).

```bash
cd ~/code/hobby/dotfiles
./bootstrap.sh
./bootstrap-optional.sh
```
