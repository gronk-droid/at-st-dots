#!/bin/bash

sketchybar  --clone     date                label_template                      \
            --set       date                update_freq=60                      \
                                            label.background.color=0xff2d2a2e   \
                                            position=right                      \
                                            drawing=on                          \
                                            icon.drawing=off                    \
                                            script="$PLUGIN_DIR/date.sh"        \
                                            background.drawing=on               \
                                            padding_right=20                    \
                                            label.padding_left=10               \
                                            label.padding_right=10              \
                                            click_script="open \"obsidian://open?vault=GRxx&file=daily/$(date +%Y-%m-%d).md\"" \

sketchybar  --add       item                time right                          \
            --set       time                update_freq=2                       \
                                            icon.drawing=off                    \
                                            position=right                      \
                                            script="$PLUGIN_DIR/time.sh"        \
                                            padding_right=20                    \
                                            background.drawing=on               \
                                            label.padding_left=10               \
                                            label.padding_right=10              \

