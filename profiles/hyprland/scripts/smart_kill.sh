#!/usr/bin/env bash

class=$(hyprctl activewindow -j | jq -r ".class")
if [ "$class" = "Slack" ] || [ "$class" = "org.telegram.desktop" ]; then
	kill "$(hyprctl activewindow -j | jq -r .pid)"
	exit
fi
hyprctl dispatch killactive
