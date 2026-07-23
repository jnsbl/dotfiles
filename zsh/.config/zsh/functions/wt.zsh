# https://gitlab.com/jnsbl/worktree-cli (private)
wt() {
  local out
  out=$(command wt "$@") || { echo "$out" >&2; return 1; }
  local dir
  dir=$(printf '%s' "$out" | grep '^cd:' | sed 's/^cd://')
  if [ -n "$dir" ]; then
    cd "$dir" || return 1
  else
    printf '%s\n' "$out"
  fi
}
