#!/usr/bin/env bash

#if ~/.config/waybar/scripts/one_window.sh | grep -q true; then
 #   echo '{"text":"", "class":"one-window"}'
#else
 #   echo '{"text":"", "class":"multi-window"}'
#fi
#!/bin/bash
if ~/.config/waybar/scripts/one_window.sh | grep -q true; then
    echo '{"text":"", "class":"one-window"}'
else
    echo '{"text":"", "class":"multi-window"}'
fi

