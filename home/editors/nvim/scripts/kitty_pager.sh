#!/usr/bin/env bash

export NVIM_APPNAME=minvim
nvim -R -M -c 'lua require("kitty-pager")(INPUT_LINE_NUMBER, CURSOR_LINE, CURSOR_COLUMN)' -
