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
    
    # Remove the unified bracket
    sketchybar --remove spaces 2>/dev/null || true
    
    # Add padding to create visual split
    sketchybar --set spaces.five background.padding_right=10
    sketchybar --set spaces.six background.padding_left=10
    
    # Update display assignments for spaces 6-10
    sketchybar --set spaces.six associated_display=2
    sketchybar --set spaces.seven associated_display=2
    sketchybar --set spaces.eight associated_display=2
    sketchybar --set spaces.nine associated_display=2
    sketchybar --set spaces.ten associated_display=2
    
    # Create separate brackets for each display
    sketchybar --add bracket spaces_primary \
                            spaces.one \
                            spaces.two \
                            spaces.three \
                            spaces.four \
                            spaces.five \
               --set spaces_primary background.drawing=on \
                                    padding_left=20 \
                                    padding_right=20
    
    sketchybar --add bracket spaces_secondary \
                            spaces.six \
                            spaces.seven \
                            spaces.eight \
                            spaces.nine \
                            spaces.ten \
               --set spaces_secondary background.drawing=on \
                                      padding_left=20 \
                                      padding_right=20
    
else
    # Only one display - move spaces 6-10 back to display 1
    echo "Moving spaces 6-10 to display 1" >> /tmp/display_manager.log
    
    # Move each space to display 1
    for space in {6..10}; do
        yabai -m space "$space" --display 1 2>/dev/null || true
    done
    
    # Remove split brackets
    sketchybar --remove spaces_primary 2>/dev/null || true
    sketchybar --remove spaces_secondary 2>/dev/null || true
    
    # Update all spaces to display 1
    sketchybar --set spaces.six associated_display=1
    sketchybar --set spaces.seven associated_display=1
    sketchybar --set spaces.eight associated_display=1
    sketchybar --set spaces.nine associated_display=1
    sketchybar --set spaces.ten associated_display=1
    
    # Remove padding that creates the split and reset edge paddings
    sketchybar --set spaces.one background.padding_left=10 \
               --set spaces.five background.padding_right=0 \
               --set spaces.six background.padding_left=0 \
               --set spaces.ten background.padding_right=10
    
    # Create unified bracket for all spaces
    sketchybar --add bracket spaces \
                            spaces.one \
                            spaces.two \
                            spaces.three \
                            spaces.four \
                            spaces.five \
                            spaces.six \
                            spaces.seven \
                            spaces.eight \
                            spaces.nine \
                            spaces.ten \
               --set spaces background.drawing=on \
                            padding_left=20 \
                            padding_right=20
    
    # Force update of space items to apply new layout
    sketchybar --update spaces.five spaces.six
fi

# Trigger sketchybar update
sketchybar --trigger space_change
sketchybar --trigger display_change

