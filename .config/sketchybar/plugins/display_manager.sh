#!/usr/bin/env bash

# This script automatically manages space assignments based on connected displays
# When a second display is connected, spaces 6-10 are moved to it
# When disconnected, they're moved back to the primary display

PLUGIN_DIR="$HOME/.config/sketchybar/plugins"

# Get the number of connected displays
display_count=$(yabai -m query --displays | jq 'length')

echo "Display count: $display_count" >> /tmp/display_manager.log

if [ "$display_count" -ge 2 ]; then
    # Second display connected - move spaces 6-10 to display 2
    echo "Moving spaces 6-10 to display 2" >> /tmp/display_manager.log
    
    # Move each space to display 2
    for space in {6..10}; do
        yabai -m space "$space" --display 2 2>/dev/null || true
    done
    
    # Update sketchybar to show spaces 6-10 on display 2
    sketchybar --set spaces.six associated_display=2
    sketchybar --set spaces.seven associated_display=2
    sketchybar --set spaces.eight associated_display=2
    sketchybar --set spaces.nine associated_display=2
    sketchybar --set spaces.ten associated_display=2
    
else
    # Only one display - move spaces 6-10 back to display 1
    echo "Moving spaces 6-10 to display 1" >> /tmp/display_manager.log
    
    # Move each space to display 1
    for space in {6..10}; do
        yabai -m space "$space" --display 1 2>/dev/null || true
    done
    
    # Update sketchybar to show all spaces on display 1
    sketchybar --set spaces.six associated_display=1
    sketchybar --set spaces.seven associated_display=1
    sketchybar --set spaces.eight associated_display=1
    sketchybar --set spaces.nine associated_display=1
    sketchybar --set spaces.ten associated_display=1
fi

# Trigger sketchybar update
sketchybar --trigger space_change
sketchybar --trigger display_change

