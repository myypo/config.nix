#!/usr/bin/env bash

sleep_for=$1
sleep "$sleep_for"

hyprctl dispatch movetoworkspace previous
