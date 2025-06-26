#!/usr/bin/env bash

curr_vol=$(pulsemixer --get-volume | awk '{print $1}')

if [ "$curr_vol" -lt 91 ]; then
	pulsemixer --change-volume +10
else
	pulsemixer --set-volume 100
fi
