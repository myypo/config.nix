#!/usr/bin/env bash

if [[ "$(hyprctl monitors)" =~ "@externalMonitorName@" ]]; then
	if [[ $1 == "open" ]]; then
		hyprctl keyword monitor "@internalMonitorName@,@internalMonitorSettings@,0x0,1,mirror,@externalMonitorName@"
	else
		hyprctl keyword monitor "@internalMonitorName@,disable"
	fi
fi
