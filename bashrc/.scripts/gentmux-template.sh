#!/bin/bash
SESSION_NAME="servers"
cd ~
if ! tmux has-session -t $SESSION_NAME 2>/dev/null; then
  tmux new-session -d -s $SESSION_NAME

  tmux new-window -t $SESSION_NAME -n "stirling"
  tmux new-window -t $SESSION_NAME -n "jupyter"

  tmux send-keys -t $SESSION_NAME:"jupyter" "pyenv && jupyter notebook" Enter
  tmux send-keys -t $SESSION_NAME:"stirling" "cd && stirling-pdf" Enter
fi

tmux attach -t $SESSION_NAME
