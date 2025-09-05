#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title yabai-next-stack
# @raycast.mode silent

# Documentation:
# @raycast.author gronk-droid
# @raycast.authorURL github.com/gronk-droid

if ! yabai -m window --focus stack.next 2>/dev/null; then
  yabai -m window --focus stack.first
fi
