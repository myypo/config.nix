#!/usr/bin/env bash

if pgrep -x "$1" >/dev/null; then
	if hyprctl workspaces | grep -qE "$3"; then
		exit
	fi
fi
eval "$2"
