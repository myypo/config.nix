#!/usr/bin/env bash

latest_win_pid=$(makoctl list | jq -r '.data.[0].[0]."desktop-entry".data')
if [ "$latest_win_pid" != "null" ]; then
	makoctl dismiss
	hyprctl dispatch focuswindow pid:"$latest_win_pid" >/dev/null 2>&1
	hyprctl dispatch focuswindow "$latest_win_pid" >/dev/null 2>&1
	exit
fi
latest_win_pid=$(makoctl history | jq -r '.data.[0].[0]."desktop-entry".data')
hyprctl dispatch focuswindow pid:"$latest_win_pid" >/dev/null 2>&1
hyprctl dispatch focuswindow "$latest_win_pid" >/dev/null 2>&1
