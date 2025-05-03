# https://github.com/sharkdp/bat/
set -x -g MANROFFOPT "-c"
set -x -g MANPAGER "sh -c 'col -bx | bat -l man -p'"
