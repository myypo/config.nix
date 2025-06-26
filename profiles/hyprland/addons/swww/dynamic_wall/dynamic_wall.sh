#!/usr/bin/env bash

# Make sure swww daemon is already running
while ! swww query; do
    sleep 0.5
done

while true; do
    swww img "$(find ~/Pictures/wallpapers/ | shuf -n1)" --transition-type random
    sleep 2000
done
