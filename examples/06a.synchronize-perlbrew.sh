#!/usr/bin/env sh

SESSION=sync-perlbrew

tmux new-session -d -s $SESSION

# NOTE: first command now needs to have the target session specified, because
# otherwise it chooses the last activate session and might break things there.

tmux send-keys -t $SESSION:0 "perlbrew use perl-5.18.4" C-m

tmux split-window -h

tmux send-keys "perlbrew use perl-5.20.3" C-m

tmux split-window -v

tmux send-keys "perlbrew use perl-5.24.0" C-m

tmux select-pane -t 0

tmux split-window -v

tmux send-keys "perlbrew use perl-5.22.2" C-m

tmux set synchronize-panes on

echo "Created session $SESSION and activated synchronize"

tmux list-sessions

echo "Type
tmux attach-session -t $SESSION"
