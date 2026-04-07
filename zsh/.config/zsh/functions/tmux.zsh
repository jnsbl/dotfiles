# Create a Tmux Dev Layout with editor, file manager, ai, terminal, and a separate window with lazygit
# Usage: tdl [<ai>]
tdl() {
  [[ -z $TMUX ]] && { echo "You must start tmux to use tdl."; return 1; }

  local current_dir="${PWD}"
  local editor_pane ai_pane
  local ai="$1"
  local fm="yazi"

  # Use TMUX_PANE for the pane we're running in (stable even if active window changes)
  editor_pane="$TMUX_PANE"

  # Name the current window after the base directory name
  tmux rename-window -t "$editor_pane" "$(basename "$current_dir")"

  # Split window vertically - top 85%, bottom 15% (target editor pane explicitly)
  tmux split-window -v -l '15%' -t "$editor_pane" -c "$current_dir"

  # If AI provided, split the editor pane horizontally - AI on right 30%
  if [[ -n $ai ]]; then
    ai_pane=$(tmux split-window -h -l '30%' -t "$editor_pane" -c "$current_dir" -P -F '#{pane_id}')
    tmux send-keys -t "$ai_pane" "$ai" C-m
  fi

  # Create a new window after the first one (do not select it), and run "lazygit" in its single pane
  tmux new-window -n "git" -a -d "lazygit"

  # Run editor in the left pane and give it focus
  tmux send-keys -t "$editor_pane" "$EDITOR ." C-m
  tmux select-pane -t "$editor_pane"

  # Create a new window after the first one (do not select it), and run file manager in its single pane
  tmux new-window -n "files" -a -d "$fm"
}

# Create a Tmux Ops Layout with remote shell, local shell, file manager, and a separate window with k9s
# Usage: tol
tol() {
  [[ -z $TMUX ]] && { echo "You must start tmux to use tol."; return 1; }

  local current_dir="${PWD}"
  local main_pane local_shell_pane fm_pane
  local fm="yazi"

  # Use TMUX_PANE for the pane we're running in (stable even if active window changes)
  main_pane="$TMUX_PANE"

  # Name the current window
  tmux rename-window -t "$main_pane" "shell"

  # Split window vertically - top 70%, bottom 30% (capture new pane ID directly)
  local_shell_pane=$(tmux split-window -v -l '30%' -t "$main_pane" -c "$current_dir" -P -F '#{pane_id}')

  # Create a new window after the first one (do not select it), and run "k9s" in its single pane
  tmux new-window -n "k9s" -a -d "k9s"

  # Create a new window after the first one (do not select it), and run file manager in its single pane
  tmux new-window -n "files" -a -d "$fm"

  # Select the main pane for focus
  tmux select-pane -t "$main_pane"
}

