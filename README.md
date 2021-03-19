# dotfiles

Dotfiles use [Dotbot](https://github.com/anishathalye/dotbot) for installation.

## Installation

After cloning this repo, run `install` to automatically set up the development environment. Note that the install script is idempotent: it can safely be run multiple times.

```bash
cd ~
mkdir -p code/hobby/dotfiles
cd code/hobby/dotfiles
git clone --recurse-submodules https://github.com/jnsbl/dotfiles.git .
./install
```

_Note: Dotfiles are symlinked to `~/.dotfiles` after installation._

## Features

- [fish](https://fishshell.com/) (default shell) configured with [fisher](https://github.com/jorgebucaran/fisher), using [spacefish](https://spacefish.matchai.dev/) prompt and lots of [abbreviations](https://github.com/jnsbl/dotfiles/blob/master/fish/config.fish) for less typing
- [neovim](https://neovim.io/) as the main editor with a bunch of [plugins](https://github.com/jnsbl/dotfiles/blob/master/neovim/settings/main.vimrc)
- [fzf](https://github.com/junegunn/fzf) fuzzy finder for shell and [(neo)vim](https://github.com/junegunn/fzf.vim)
  - w/ custom [fuz](https://github.com/jnsbl/dotfiles/blob/master/bin/fuz) script for [simple note-taking with fzf and (neo)vim](https://medium.com/adorableio/simple-note-taking-with-fzf-and-vim-2a647a39cfa)
- [ranger](https://github.com/ranger/ranger) as command-line file manager
- [effortless ctags with git](https://tbaggery.com/2011/08/08/effortless-ctags-with-git.html)

### macOS-only

- [iTerm2](https://iterm2.com/) profile (w/ hotkey, themes, etc.)
- [Karabiner Elements](https://karabiner-elements.pqrs.org/) + [Hammerspoon](https://www.hammerspoon.org/) combo for turning a useless <kbd>Caps Lock</kbd> key into <kbd>Esc</kbd> when pressed alone and <kbd>Hyper</kbd> key when pressed with another key
- Hammerspoon also for window management (resizing and moving windows with keyboard)

# Testing

Testing is easy with Docker:

```bash
$ docker build . --tag dotfiles
$ docker run --rm -it dotfiles
           .
          ":"
        ___:____     |"\/"|
      ,'        `.    \  /
      |  O        \___/  |
    ~^~^~^~^~^~^~^~^~^~^~^~^~

root in /
$
```
_Inspired by [statico's dotfiles](https://github.com/statico/dotfiles)._