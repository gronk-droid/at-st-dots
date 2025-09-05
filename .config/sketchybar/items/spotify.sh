#!/bin/bash

SPOTIFY_EVENT="com.spotify.client.PlaybackStateChanged"

sketchybar  --add       event       spotify_change $SPOTIFY_EVENT                           \
            --add       item        spotify left                                            \
            --set       spotify     script="$PLUGIN_DIR/spotify.sh"                         \
                                    updates=on                                              \
                                    icon=                                                  \
                                    icon.y_offset=1.5                                       \
                                    icon.font="$FONT:Bold Italic:32.0"                      \
                                    label="Spotify"                                         \
                                    background.drawing=on                                   \
                                    icon.padding_left=10                                    \
                                    label.padding_right=10                                  \
                                    background.padding_right=20                             \
                                    background.padding_left=20                              \
                                    drawing=off                                             \
            --subscribe spotify  mouse.clicked spotify_change
