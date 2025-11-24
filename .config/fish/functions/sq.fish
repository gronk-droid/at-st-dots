function sq --description "Uses spotqo-dl to download songs to music directory"
    if test (count $argv) -eq 0
        echo "Usage: sq <spotify-url>"
        return 1
    end

    # activate venv
    source ~/gh/spotqo-dl/.venv/bin/activate.fish
    ~/gh/spotqo-dl/.venv/bin/spotqo-dl -q 6 -f "{artist}/{album}/{track-number}-{title}" -o ~/01_music/ $argv
end
