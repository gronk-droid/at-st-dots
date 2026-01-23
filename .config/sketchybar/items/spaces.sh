#!/bin/bash

sketchybar  --add       space               space_template left                 \
            --set       space_template      icon.highlight_color=0xfffdfff1     \
                                            icon.color=0xff625A60               \
                                            label.drawing=off                   \
                                            icon.font="$FONT:Regular:16.0"      \
                                            drawing=off                         \
                                            updates=on                          \
                                            associated_display=1                \
                                            script="$PLUGIN_DIR/space.sh"       \
                                            click_script="$SPACE_CLICK_SCRIPT"  \
                                                                                \
                                                                                \
            --clone     spaces.one          space_template                      \
            --set       spaces.one          associated_space=1                  \
                                            icon=一                             \
                                            drawing=on                          \
                                            background.padding_left=10          \
                                                                                \
            --clone     spaces.two          space_template                      \
            --set       spaces.two          associated_space=2                  \
                                            icon=二                             \
                                            drawing=on                          \
                                                                                \
            --clone     spaces.three        space_template                      \
            --set       spaces.three        associated_space=3                  \
                                            icon=三                             \
                                            drawing=on                          \
                                                                                \
            --clone     spaces.four         space_template                      \
            --set       spaces.four         associated_space=4                  \
                                            icon=四                             \
                                            drawing=on                          \
                                                                                \
            --clone     spaces.five         space_template                      \
            --set       spaces.five         associated_space=5                  \
                                            icon=五                             \
                                            drawing=on                          \
                                                                                \
            --clone     spaces.six          space_template                      \
            --set       spaces.six          associated_space=6                  \
                                            icon=六                             \
                                            drawing=on                          \
                                                                                \
            --clone     spaces.seven        space_template                      \
            --set       spaces.seven        associated_space=7                  \
                                            icon=七                             \
                                            drawing=on                          \
                                                                                \
            --clone     spaces.eight        space_template                      \
            --set       spaces.eight        associated_space=8                  \
                                            icon=八                             \
                                            drawing=on                          \
                                                                                \
            --clone     spaces.nine         space_template                      \
            --set       spaces.nine         associated_space=9                  \
                                            icon=九                             \
                                            drawing=on                          \
                                                                                \
            --clone     spaces.ten          space_template                      \
            --set       spaces.ten          associated_space=10                 \
                                            icon=〇                             \
                                            drawing=on                          \
                                            background.padding_right=10         \
            --add       bracket             spaces                              \
                                            spaces.one                          \
                                            spaces.two                          \
                                            spaces.three                        \
                                            spaces.four                         \
                                            spaces.five                         \
                                            spaces.six                          \
                                            spaces.seven                        \
                                            spaces.eight                        \
                                            spaces.nine                         \
                                            spaces.ten                          \
            --set       spaces              background.drawing=on               \
                                            padding_left=20                     \
                                            padding_right=20                    \

                                          