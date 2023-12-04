# dotfiles

Dotfiles use [Dotbot](https://github.com/anishathalye/dotbot) for installation.

## Prerequisites

```bash
paru install awesome-git awesome-freedesktop awesome-bling-git lain dex zoxide fzf
```

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

- [fish](https://fishshell.com/) (default shell) configured with
  [fisher](https://github.com/jorgebucaran/fisher), using [starship](https://starship.rs/) prompt
  and lots of [abbreviations](https://github.com/jnsbl/dotfiles/blob/master/fish/config.fish) for
  less typing
- [neovim](https://neovim.io/) as the main editor with a bunch of
  [plugins](https://github.com/jnsbl/dotfiles/tree/master/neovim/lua/plugins)
- [fzf](https://github.com/junegunn/fzf) fuzzy finder for shell and
  [(neo)vim](https://github.com/junegunn/fzf.vim)
  - w/ custom [fuz](https://github.com/jnsbl/dotfiles/blob/master/bin/fuz) script for
    [simple note-taking with fzf and (neo)vim](https://medium.com/adorableio/simple-note-taking-with-fzf-and-vim-2a647a39cfa)
- [lf](https://github.com/gokcehan/lf) and [ranger](https://github.com/ranger/ranger) as command-line file manager
- [nsxiv](https://nsxiv.codeberg.page/) as command-line image viewer
- [effortless ctags with git](https://tbaggery.com/2011/08/08/effortless-ctags-with-git.html)
- [base16](https://github.com/chriskempson/base16) color theme framework for many apps, all
  configurable at once using [flavours](https://github.com/misterio77/flavours)
  - [alacritty](https://github.com/aarowill/base16-alacritty) and
    [kitty](https://github.com/kdrag0n/base16-kitty) terminals
  - [dunst](https://github.com/tinted-theming/base16-dunst)
  - [fzf](https://github.com/fnune/base16-fzf)
  - [highlight](https://github.com/bezhermoso/base16-highlight) syntax highlighter (used as text
    file previewer in `ranger`)
  - [neovim](https://github.com/bradcush/base16-nvim)
  - [rofi](https://gitlab.com/0xdec/base16-rofi)
  - [shell](https://github.com/chriskempson/base16-shell)
  - [vim](https://github.com/chriskempson/base16-vim) +
    [vim-airline](https://github.com/dawikur/base16-vim-airline-themes)
  - [xresources](https://github.com/binaryplease/base16-xresources)

### Linux-only

- [xmonad](https://xmonad.org/), [awesomewm](https://awesomewm.org/) and [qtile](http://www.qtile.org/) tiling window managers
  - _note: they are sorted in descending order of recency of being used by me (the first one being used currently)_
- [interception-tools](https://gitlab.com/interception/linux/tools) +
  [interception-caps2esc](https://gitlab.com/interception/linux/plugins/caps2esc) combo for
  turning a useless <kbd>Caps Lock</kbd> key into <kbd>Esc</kbd> when pressed alone and
  <kbd>Control</kbd> key when pressed with another key

### macOS-only

- [iTerm2](https://iterm2.com/) profile (w/ hotkey, themes, etc.)
- [Karabiner Elements](https://karabiner-elements.pqrs.org/) +
  [Hammerspoon](https://www.hammerspoon.org/) combo for turning a useless <kbd>Caps Lock</kbd>
  key into <kbd>Esc</kbd> when pressed alone and <kbd>Hyper</kbd> key when pressed with another
  key
- Hammerspoon also for window management (resizing and moving windows with keyboard)

# Testing

Testing is easy with [Podman](https://podman.io/):

```bash
$ podman build . --tag dotfiles
$ podman run --rm -it dotfiles
   /\ /\        root@1bffedb25ce8
  // \  \       os     Alpine Linux v3.16
 //   \  \      host   82BC Lenovo Legion S7 15IMH5
///    \  \     kernel 5.15.55-1-MANJARO
//      \  \    shell  fish
         \      uptime 4h 1m


root in /
🕙[16:06:57] ⬢ [podman] ❯
```
_Inspired by [statico's dotfiles](https://github.com/statico/dotfiles)._
