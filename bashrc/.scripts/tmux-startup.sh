#!/bin/bash

cd $HOME

tmux new-session -d -s main
tmux send-keys -t main 'clear && sunshine &' enter
