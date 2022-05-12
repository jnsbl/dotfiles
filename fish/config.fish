set -x -g TERM "xterm-kitty"
set -x -g EDITOR "nvim"
set -x -g VISUAL "nvim"
set -g fish_user_paths "$HOME/dotfiles/bin" "/usr/local/sbin" $fish_user_paths

if not set -q abbrs_initialized
  set -U abbrs_initialized
  echo -n Setting abbreviations...

  abbr 1mon 'mons -o'
  abbr 2mon 'mons -e top'

  abbr apl 'ansible-playbook'

  abbr bci 'brew cask install'
  abbr bcl 'brew cleanup'
  abbr bco 'echo -e "\n**********\nOutdated:\n"; and brew cask outdated'
  abbr bcug 'brew cask upgrade'
  abbr bug 'brew upgrade'
  abbr bugl 'brew upgrade; brew cleanup'
  abbr buo 'brew update; echo -e "\n**********\nOutdated:\n"; brew outdated'
  abbr buoco 'brew update; echo -e "\n**********\nOutdated formulae:\n"; brew outdated; echo -e "\n**********\nOutdated casks:\n"; brew cask outdated'
  abbr bucugl 'brew upgrade; brew cleanup; brew cask upgrade'

  # TODO Use 'jruby -G' instead if JRuby is the current runtime
  # see https://github.com/jruby/jruby/wiki/Improving-startup-time#bundle-exec<Paste>
  abbr bex 'bundle exec'

  abbr co 'g co'

  abbr dc 'docker-compose'
  abbr dk 'docker'
  abbr dkex 'docker exec -it'
  abbr dkps 'docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Image}}"'
  abbr dm 'docker-machine'

  # Show human friendly numbers
  abbr df 'df -h'
  abbr dns 'dscacheutil -q host -a name'

  # e like editor
  abbr e 'nvim'

  abbr fk 'fuck'
  abbr fn 'find . -name'

  abbr ge 'gem edit'

  abbr g 'git'
  abbr ga 'git add -A'
  abbr gci 'git ci'
  abbr gcim 'git ci -m'
  abbr gco 'git co'
  abbr gcp 'git cherry-pick'
  abbr gd 'git diff'
  abbr gdc 'git diff --cached -w'
  abbr gds 'git diff --staged -w'
  abbr gdt 'git difftool'
  abbr gdtc 'git difftool --cached'
  abbr gf 'git fetch'
  abbr gi 'e .gitignore'
  abbr gl 'git l'
  abbr gnb 'git nb' # new branch aka checkout -b
  abbr gpl 'git pull'
  abbr gplr 'git pull --rebase'
  abbr gps 'git push'
  abbr grb 'git recent-branches'
  abbr grs 'git reset'
  abbr grsh 'git reset --hard'
  abbr gs 'git status'
  abbr gunc 'git uncommit'
  abbr guns 'git unstage'

  abbr hideFiles 'defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
  abbr showFiles 'defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'

  abbr l 'less'
  abbr lf 'less +F'

  if which exa > /dev/null
    abbr ls 'exa'
    abbr ll 'exa -l'
    abbr la 'exa -la'
  else
    switch (uname)
    case Linux
      abbr ll 'ls -alh --color=auto'
      abbr ls 'ls --color=auto'
    case Darwin
      abbr ll 'ls -alGh'
      abbr ls 'ls -Gh'
    end
  end

  abbr py 'python'

  abbr rb 'ruby'
  abbr rbs 'rbenv shell'
  abbr rbsu 'rbenv shell --unset'
  abbr rbv 'rbenv version'
  abbr rbvs 'rbenv versions'
  abbr rgr 'ranger'

  abbr sc 'nvim ~/.ssh/config'
  abbr sloc 'tokei'
  abbr smtr 'sudo mtr'

  abbr sud 'softwareupdate'
  abbr sudl 'softwareupdate --list'

  abbr t 'todolist'
  abbr tf 'tail -f'

  abbr tas 'tmux attach-session -t'
  abbr tks 'tmux kill-session -t'
  abbr tnew 'tmux new-session -As (echo (basename $PWD) | tr '.' '-')' # http://tilvim.com/2014/07/30/tmux-and-vim.html

  abbr vim 'nvim' # use Neovim instead of the original Vim by default
  abbr vvim '/usr/bin/vim' # the real Vim (not Neovim)

  abbr vtop 'vtop --theme monokai'

  abbr ysg 'yard server --gems'
  abbr ysr 'yard server --reload'

  echo 'Done'
end
