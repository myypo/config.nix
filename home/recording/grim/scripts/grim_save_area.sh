#!/usr/bin/env bash

grim -g "$(slurp -b 00000060 -c eba4ac -w 2)" - | satty --filename - --output-filename ~/Pictures/Screenshots/"$time".png --init-tool brush --copy-command wl-copy
