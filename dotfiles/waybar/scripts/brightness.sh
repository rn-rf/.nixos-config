#!/usr/bin/env bash
brightness=$(brightnessctl get)
max=$(brightnessctl max)
percent=$((brightness * 100 / max))

if [ "$percent" -lt 30 ]; then
  icon="󰖨"
elif [ "$percent" -lt 70 ]; then
  icon="󰖨"
else
  icon="󰖨"
fi

echo "{\"icon\": \"$icon\", \"percentage\": $percent}"

