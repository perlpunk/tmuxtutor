#!/usr/bin/env sh

tmux new-session -s demo "cd $PWD && man man/02.prefix.man"
