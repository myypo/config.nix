#!/usr/bin/env bash

git reset "$(git commit-tree HEAD^\{tree\} -m 'initial commit')"
