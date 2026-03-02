#!/usr/bin/env bash

CONFIG_DIR="$HOME/.config/waybar"
COLOR_FILE="$CONFIG_DIR/color.css"
STATE_FILE="$CONFIG_DIR/.one_window_state"
CHECK_SCRIPT="$CONFIG_DIR/scripts/one_window.sh"

# Initialize previous state
if [ ! -f "$STATE_FILE" ]; then
    echo "false" > "$STATE_FILE"
fi

while true; do
    current="$($CHECK_SCRIPT)"
    previous=$(cat "$STATE_FILE")

    if [ "$current" == "true" ] && [ "$previous" == "false" ]; then
        echo "true" > "$STATE_FILE"
        cat > "$COLOR_FILE" <<EOF
@import url('../../.cache/wal/colors-waybar.css');

@define-color waybar-background alpha(@background, 0.95);
@define-color module-background alpha(@color7, 0.15);
EOF
    elif [ "$current" == "false" ] && [ "$previous" == "true" ]; then
        echo "false" > "$STATE_FILE"
        cat > "$COLOR_FILE" <<EOF
@import url('../../.cache/wal/colors-waybar.css');

@define-color waybar-background alpha(@background, 0);
@define-color module-background alpha(@background, 0.9);
EOF
    fi

    sleep 2
done

