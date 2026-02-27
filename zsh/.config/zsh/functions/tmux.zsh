# Create a Tmux Dev Layout with editor, file manager, ai, and terminal
# Usage: tdl [<ai>]
tdl() {
  [[ -z $1 ]] && { echo "Usage: tdl [<ai>]"; return 1; }
  [[ -z $TMUX ]] && { echo "You must start tmux to use tdl."; return 1; }

  local current_dir="${PWD}"
  local editor_pane fm_pane ai_pane
  local fm="yazi"
  local ai="$1"

  # Use TMUX_PANE for the pane we're running in (stable even if active window changes)
  editor_pane="$TMUX_PANE"

  # Name the current window after the base directory name
  tmux rename-window -t "$editor_pane" "$(basename "$current_dir")"

  # Split window vertically - top 85%, bottom 15% (target editor pane explicitly)
  tmux split-window -v -p 15 -t "$editor_pane" -c "$current_dir"

  # Split editor pane horizontally - AI on right 30% (capture new pane ID directly)
  fm_pane=$(tmux split-window -h -p 30 -t "$editor_pane" -c "$current_dir" -P -F '#{pane_id}')

  # If AI provided, split the file manager pane vertically
  if [[ -n $ai ]]; then
    ai_pane=$(tmux split-window -v -t "$fm_pane" -c "$current_dir" -P -F '#{pane_id}')
    tmux send-keys -t "$ai_pane" "$ai" C-m
  fi

  # Run file manager in the right pane
  tmux send-keys -t "$fm_pane" "$fm" C-m

  # Run nvim in the left pane
  tmux send-keys -t "$editor_pane" "$EDITOR ." C-m

  # Select the nvim pane for focus
  tmux select-pane -t "$editor_pane"
}

