#!/usr/bin/env bash

first_inst_name=$(playerctl -l | grep -o '@mpris-prefix@[^ ]*' | head -n 1)

playerctl -p "$first_inst_name" play-pause
