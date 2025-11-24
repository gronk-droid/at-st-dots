#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open Neovim in Ghostty
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🦋

# Documentation:
# @raycast.description Opens Neovim in a new Ghostty terminal window.

# Launch Ghostty with yazi
open -na Ghostty.app --args -e nvim