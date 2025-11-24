#!/bin/bash

# Universal music events using media-control
# media-control works with any media application, so we use a timer-based approach
# for real-time updates instead of app-specific events

sketchybar  --add       item        music left                                            \
            --set       music       script="$PLUGIN_DIR/music.sh"                         \
                                    updates=on                                              \
                                    update_freq=2                                           \
                                    icon=                                                  \
                                    icon.y_offset=1.5                                       \
                                    icon.font="$FONT:Bold Italic:32.0"                      \
                                    label="Music"                                           \
                                    background.drawing=on                                   \
                                    icon.padding_left=10                                    \
                                    label.padding_right=10                                  \
                                    background.padding_right=20                             \
                                    background.padding_left=20                              \
                                    drawing=off                                             \
            --subscribe music     mouse.clicked