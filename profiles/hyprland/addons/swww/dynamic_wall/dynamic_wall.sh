#!/usr/bin/env bash

# Make sure swww daemon is already running
while ! swww query; do
	sleep 0.5
done

swww img "$(find ~/Pictures/wallpapers/ | shuf -n1)" --transition-type random
OLD_PID=$!
while true; do
	sleep 2000
	swww img "$(find ~/Pictures/wallpapers/ | shuf -n1)" --transition-type random
	NEXT_PID=$!
	sleep 5
	kill $OLD_PID
	OLD_PID=$NEXT_PID
done
