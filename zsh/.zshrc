# # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# # Initialization code that may require console input (password prompts, [y/n]
# # confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add prompt
# zinit ice depth"1"
# zinit light romkatv/powerlevel10k
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
zinit ice as"command" from"gh-r" \
          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
          atpull"%atclone" src"init.zsh"
zinit light starship/starship

# Check optional commands
_fzf_installed="false"
if command -v fzf >/dev/null 2>&1; then
  _fzf_installed="true"
fi
_zoxide_installed="false"
if command -v zoxide >/dev/null 2>&1; then
  _zoxide_installed="true"
fi
_arkade_installed="false"
if command -v arkade >/dev/null 2>&1; then
  _arkade_installed="true"
fi

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
if [[ $_fzf_installed = "true" ]]; then
  zinit light Aloxaf/fzf-tab
fi

# # Add in snippets
zinit snippet OMZP::sudo
zinit snippet OMZP::systemadmin

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region
bindkey '^[[3~' delete-char # https://superuser.com/questions/997593/why-does-zsh-insert-a-when-i-press-the-delete-key

# History
HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
if [[ $_fzf_installed = "true" ]]; then
  zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
  if [[ $_zoxide_installed = "true" ]]; then
    zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
  fi
fi

# Aliases
alias -g -- -h='-h 2>&1 | bat --language=help --style=plain'
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'

alias ark='arkade'

alias e=$EDITOR

alias fzf='fzf --preview "bat --color=always --style=numbers --line-range=:500 {}"'

alias g='git'
alias ga='git add -A'
alias gc1='git clone --depth=1'
alias gci='git ci'
alias gcl='git clone'
alias gcim='git ci -m'
alias gco='git co'
alias gcp='git cherry-pick'
alias gd='git diff'
alias gdc='git diff --cached -w'
alias gds='git diff --staged -w'
alias gdt='git difftool'
alias gdtc='git difftool --cached'
alias gf='git fetch'
alias gi='e .gitignore'
alias gl='git l'
alias gnb='git nb' # new branch aka checkout -b
alias gpl='git pull'
alias gplr='git pull --rebase'
alias gps='git push'
alias grb='git recent-branches'
alias grs='git reset'
alias grsh='git reset --hard'
alias gs='git status'
alias gunc='git uncommit'
alias guns='git unstage'

alias k='kubectl'
alias k9h='k9s --context homelab'
alias kubens='kubectl config set-context --current --namespace '

alias less='less --QUIET' # https://wiki.archlinux.org/title/PC_speaker#Less_pager
alias ld='lazydocker'
alias lg='lazygit'

if command -v eza >/dev/null 2>&1; then
  alias ls='eza $eza_params'
  alias l='eza --git-ignore $eza_params'
  alias ll='eza --all --header --long $eza_params'
  alias llm='eza --all --header --long --sort=modified $eza_params'
  alias la='eza -lbhHigUmuSa'
  alias lx='eza -lbhHigUmuSa@'
  alias lt='eza --tree $eza_params'
  alias tree='eza --tree $eza_params'
else
  case $(uname) in
    Linux)
      alias ll='ls -alh --color=auto'
      alias ls='ls --color=auto'
      ;;
    Darwin)
      alias ll='ls -alGh'
      alias ls='ls -Gh'
      ;;
  esac
fi

alias man 'man --pager="less --QUIET"' # https://wiki.archlinux.org/title/PC_speaker#Less_pager
alias md='glow'

alias s='kitten ssh'
alias smtr='sudo mtr'

alias t='tmux'
alias ta='tmux attach -t'
alias tl='tmux ls'
alias tn='tmux new -t'

alias zj='zellij'
alias zja='zellij attach'
alias zjl='zellij list-sessions'
alias zjs='zellij --session'

alias y='yazi'

# Shell integrations
if [[ $_fzf_installed = "true" ]]; then
  eval "$(fzf --zsh)"
fi
if [[ $_zoxide_installed = "true" ]]; then
  export _ZO_ECHO='1'
  eval "$(zoxide init --cmd cd zsh)"
fi
if [[ $_arkade_installed = "true" ]]; then
  eval "$(arkade completion zsh)"
fi
