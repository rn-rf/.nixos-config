#!/usr/bin/env bash

# Count tiled windows on current workspace
active_windows=$(hyprctl activeworkspace -j | jq '.windows')

# Set class depending on window presence
if [ "$active_windows" -eq 0 ]; then
    echo '{"class": ""}'     # No windows — transparent
else
    echo '{"class": "active"}'  # Window exists — darker
fi

