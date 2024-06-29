#!/usr/bin/env bash

wf_recorder_check() {
	if pgrep -x "wf-recorder" >/dev/null; then
		pkill -INT -x wf-recorder
		exit 0
	fi
}
wf_recorder_check

notify-send "Screen recording" "Will begin in 3 seconds"
sleep 3
makoctl dismiss

file_name=$(date "+%Y-%m-%dT%H:%M:%S")
wf-recorder -f ~/Video/wf/"$file_name".mp4

notify-send "Screen recorder" "Saving file: $file_name"
