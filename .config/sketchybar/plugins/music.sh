#!/bin/bash

# Universal music detection using media-control
# This works with any media application on macOS

update() {
    # Get current media information using media-control
    local media_info=$(media-control get 2>/dev/null)
    
    # If media-control fails or no media is playing, hide the bar
    if [ -z "$media_info" ] || [ "$media_info" = "null" ]; then
        sketchybar -m --set music drawing=off
        return
    fi

    # Parse the JSON response using jq
    local playing=$(echo "$media_info" | jq -r '.playing // false')
    local title=$(echo "$media_info" | jq -r '.title // ""')
    local artist=$(echo "$media_info" | jq -r '.artist // ""')
    local album=$(echo "$media_info" | jq -r '.album // ""')
    local bundle_id=$(echo "$media_info" | jq -r '.bundleIdentifier // ""')

    # If not playing, hide the bar
    if [ "$playing" != "true" ]; then
        sketchybar -m --set music drawing=off
        return
    fi

    # Truncate track name if too long
    TRACK=$(
    if (( ${#title} > 30 )); then
        if [[ "$title" == *" "* ]]; then
            # >30 chars _and_ has at least one space → first 3 words
            cut -d' ' -f1-3 <<<"$title"
        else
            # >30 chars _but_ no spaces → first 30 characters
            printf '%s' "${title:0:30}"
        fi
    else
        # ≤30 chars → the whole thing
        printf '%s' "$title"
    fi
    )

    # Truncate artist name if too long
    ARTIST=$(
    if (( ${#artist} > 30 )); then
        if [[ "$artist" == *" "* ]]; then
            cut -d' ' -f1-3 <<<"$artist"
        else
            printf '%s' "${artist:0:30}"
        fi
    else
        printf '%s' "$artist"
    fi
    )

    # Truncate album name if too long
    ALBUM=$(
    if (( ${#album} > 30 )); then
        if [[ "$album" == *" "* ]]; then
            cut -d' ' -f1-3 <<<"$album"
        else
            printf '%s' "${album:0:30}"
        fi
    else
        printf '%s' "$album"
    fi
    )

    # Update the sketchybar with the media information
    args=()
    if [ "$ARTIST" == "" ]; then
        args+=(--set music label="${TRACK}" drawing=on)
    else
        args+=(--set music label="${TRACK} --- ${ARTIST}" drawing=on)
    fi
    sketchybar -m "${args[@]}"
}

play_pause() {
    # Use media-control to toggle play/pause
    media-control toggle-play-pause 2>/dev/null
}

case "$SENDER" in
    "mouse.clicked") play_pause
    ;;
    "forced") exit
    ;;
    *) update
    ;;
esac