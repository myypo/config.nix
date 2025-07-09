#!/usr/bin/env dash

# Check if another instance of this script is already running
if pgrep -x dynamic_wall >/dev/null; then
    exit 0
fi

# Make sure swww daemon is already running
while ! swww query; do
    sleep 0.5
done

while true; do
    swww img "$(find ~/Pictures/wallpapers/ | shuf -n1)" --transition-type random
    sleep 2000
done
