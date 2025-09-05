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

# Configuration
SCRATCH_SPACE=11
PREVIOUS_SPACE_FILE="/tmp/yabai_previous_space"

# Get current space
current_space=$(yabai -m query --spaces --space | jq -r '.index')

# If we're on scratch space, go back to previous space
if [ "$current_space" = "$SCRATCH_SPACE" ]; then
    # Read the previous space from file
    if [ -f "$PREVIOUS_SPACE_FILE" ]; then
        previous_space=$(cat "$PREVIOUS_SPACE_FILE")
        # Verify the space still exists before focusing
        if yabai -m query --spaces | jq -e ".[] | select(.index == $previous_space)" > /dev/null 2>&1; then
            yabai -m space --focus "$previous_space"
        else
            # Fallback to space 1 if previous space no longer exists
            yabai -m space --focus 1
        fi
        # Clean up the file
        rm -f "$PREVIOUS_SPACE_FILE"
    else
        # Fallback to space 1 if no previous space recorded
        yabai -m space --focus 1
    fi
else
    # Save current space before going to scratch space
    echo "$current_space" > "$PREVIOUS_SPACE_FILE"
    # Focus on scratch space
    yabai -m space --focus "$SCRATCH_SPACE"
fi
