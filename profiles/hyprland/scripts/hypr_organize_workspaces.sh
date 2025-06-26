#!/usr/bin/env bash

ws_state=$(hyprctl workspaces -j)
cli_state=$(hyprctl clients -j | jq -r 'map(select(.workspace.id > 0))')

curr_ws_id=$(hyprctl activeworkspace -j | jq -r .id)
new_ws_id=0
hypr_cmds=""
i=0
while read -r v; do
	((i++))
	if [[ $i == "$v" ]]; then
		continue
	fi

	if [[ $v == "$curr_ws_id" ]]; then
		new_ws_id=$i
	fi

	win_addrs=$(echo "$cli_state" | jq -r --argjson v "$v" 'map(select(.workspace.id == $v)) | sort_by(-.at[0], .at[1]) | .[].address')
	for wa in $win_addrs; do
		hypr_cmds+="dispatch movetoworkspacesilent $i,address:$wa"$' ; '
	done
done < <(echo "$ws_state" | jq -c 'map(select(.id > 0 and .windows > 0)) | map(.id) | sort[]')

if [[ $curr_ws_id -gt $i ]]; then
	new_ws_id=$i
fi
if [[ $new_ws_id -gt 0 ]]; then
	hypr_cmds+="dispatch workspace $new_ws_id"
else
	# HACK: have to do something along these lines to have focus on a window in this case
	hypr_cmds+="dispatch cyclenext"
fi
hyprctl --batch "$hypr_cmds"
