#!/usr/bin/env bash

# Log scroll direction
case $1 in
  up)
    ydotool key 125:1 23:1 23:0 125:0  # mod+i (125 = LSuper, 23 = i)
    ;;
  down)
    ydotool key 125:1 24:1 24:0 125:0  # mod+o (125 = LSuper, 24 = o)
    ;;
esac

echo "Scroll to trigger ydotool"

