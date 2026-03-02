#!/usr/bin/env bash
volume=$(pamixer --get-volume)
muted=$(pamixer --get-mute)

if [ "$muted" = "true" ]; then
  icon=""
elif [ "$volume" -lt 30 ]; then
  icon=""
else
  icon=""
fi

echo "{\"icon\": \"$icon\", \"percentage\": $volume}"

