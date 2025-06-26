#!/usr/bin/env bash

wf_recorder_check() {
	if pgrep -x "wf-recorder" >/dev/null; then
		pkill -INT -x wf-recorder
		exit 0
	fi
}
wf_recorder_check

makoctl dismiss

file_name=$(date "+%Y-%m-%dT%H:%M:%S")
wf-recorder -a -g "$(slurp)" -f ~/Video/wf/"$file_name".mp4

notify-send "Area recorder" "Saving file: $file_name"
