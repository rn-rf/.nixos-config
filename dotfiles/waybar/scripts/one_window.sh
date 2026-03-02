#!/usr/bin/env bash

# Hyprland event socket
SOCKET="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"

# CONFIG_DIR="$HOME/.config/waybar"
CONFIG_DIR="$HOME/.nixos-config/dotfiles/waybar"
COLOR_FILE="$CONFIG_DIR/color.css"
STATE_FILE="$CONFIG_DIR/.one_window_state"

# Ensure state file exists
[ -f "$STATE_FILE" ] || echo "false" > "$STATE_FILE"

# Get number of windows on active workspace
get_window_count() {
    ws=$(hyprctl activeworkspace -j | jq '.id')
    hyprctl clients -j | jq "[.[] | select(.workspace.id == $ws)] | length"
}

update_colors() {
    count=$(get_window_count)
    previous=$(cat "$STATE_FILE")

    # Determine state
    if [[ "$count" -eq 1 ]]; then
        current="true"
    else
        current="false"
    fi

    # Skip if nothing changed
    [[ "$current" == "$previous" ]] && return

    echo "$current" > "$STATE_FILE"

    if [[ "$current" == "true" ]]; then
        # ONE WINDOW → opaque bar
        cat > "$COLOR_FILE" <<EOF
@import url('../../.cache/wal/colors-waybar.css');

@define-color waybar-background #181818;
@define-color module-background alpha(@color0, 1);
EOF
    else
        # MULTIPLE WINDOWS → transparent bar
        cat > "$COLOR_FILE" <<EOF
@import url('../../.cache/wal/colors-waybar.css');

@define-color waybar-background alpha(@background, 0);
@define-color module-background alpha(@color0, 1);
EOF
    fi

    # reload Waybar
    # pkill -SIGUSR2 waybar 2>/dev/null
}

# Initial update at startup
update_colors

# Listen for Hyprland events
socat - UNIX-CONNECT:$SOCKET | while read -r line; do
    case "$line" in
        openwindow*|closewindow*|movewindow*|workspace*|focusedmon*)
            update_colors
            ;;
    esac
done
