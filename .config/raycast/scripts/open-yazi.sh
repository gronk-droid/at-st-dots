#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Launch Yazi in Ghostty
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🦋
# @raycast.packageName Yazi Tools

# Documentation:
# @raycast.description Opens Yazi file manager in a new Ghostty terminal window.

# Launch Ghostty with yazi
open -na Ghostty.app --args -e yazi