#!/usr/bin/env bash

# Have to disown to make the hyprland swallow work
kitty --listen-on unix:/tmp/kitty-"$RANDOM" &
disown
