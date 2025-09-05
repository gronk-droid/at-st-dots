#!/bin/bash

update ()
{
    # 1) If Spotify isn’t even running, hide the bar and return
    if ! pgrep -x Spotify &> /dev/null; then
        sketchybar -m --set spotify drawing=off
        return
    fi

    local state
    state=$(jq -r '.["Player State"]' <<< "$INFO")

    PLAYING=0
    if [ "$(echo "$INFO" | jq -r '.["Player State"]')" = "Playing" ]; then
        PLAYING=1
        TRACK=$(
        raw="$(jq -r .Name   <<<"$INFO")"
        if (( ${#raw} > 30 )); then
            if [[ "$raw" == *" "* ]]; then
            # >30 chars _and_ has at least one space → first 3 words
            cut -d' ' -f1-3 <<<"$raw"
            else
            # >30 chars _but_ no spaces → first 30 characters
            printf '%s' "${raw:0:10}"
            fi
        else
            # ≤30 chars → the whole thing
            printf '%s' "$raw"
        fi
        )

        ARTIST=$(
        raw="$(jq -r .Artist <<<"$INFO")"
        if (( ${#raw} > 30 )); then
            if [[ "$raw" == *" "* ]]; then
            cut -d' ' -f1-3 <<<"$raw"
            else
            printf '%s' "${raw:0:10}"
            fi
        else
            printf '%s' "$raw"
        fi
        )

        ALBUM=$(
        raw="$(jq -r .Album  <<<"$INFO")"
        if (( ${#raw} > 30 )); then
            if [[ "$raw" == *" "* ]]; then
            cut -d' ' -f1-3 <<<"$raw"
            else
            printf '%s' "${raw:0:10}"
            fi
        else
            printf '%s' "$raw"
        fi
        )
    fi

    args=()
    if [ $PLAYING -eq 1 ]; then
        if [ "$ARTIST" == "" ]; then
            args+=(--set spotify label="${TRACK} --- ${ARTIST}" drawing=off)
        else
            args+=(--set spotify label="${TRACK} --- ${ARTIST}" drawing=on)
        fi
    fi
    sketchybar -m "${args[@]}"
}

play_pause ()
{
    osascript -e 'tell application "Spotify" to playpause'
}

case "$SENDER" in
    "mouse.clicked") play_pause
    ;;
    "forced") exit
    ;;
    *) update
    ;;
esac