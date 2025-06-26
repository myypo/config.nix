#!/usr/bin/env bash

curr_ws=$(hyprctl activeworkspace -j | jq -r .name)
qutebrowser "$@"
sleep 0.1
hyprctl dispatch movetoworkspace name:"$curr_ws"
