#!/bin/bash

cd $HOME

tmux new-session -d -s main
tmux new-window -t main -n sunshine
tmux send-keys -t main:sunshine 'clear && sunshine' enter
