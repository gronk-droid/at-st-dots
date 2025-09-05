#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title yabai-scratch-toggle
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🔄

# Documentation:
# @raycast.author gronk-droid
# @raycast.authorURL github.com/gronk-droid

# Get current space
current_space=$(yabai -m query --spaces --space | jq -r '.index')

# If we're on scratch space (11), go back to previous space
if [ "$current_space" = "11" ]; then
    # Try to go to space 1 as fallback, or you could implement a more sophisticated
    # system to remember the previous space
    yabai -m space --focus 1
else
    # Focus on scratch space (11)
    yabai -m space --focus 11
fi
