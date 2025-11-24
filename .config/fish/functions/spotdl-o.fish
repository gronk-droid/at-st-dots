function spotdl-o
    if test (count $argv) -eq 0
        echo "Usage: spotdl-o <spotify-link>"
        return 1
    end

    set link $argv[1]

    # Download songs in mp3 with track numbering
    spotdl $link --output "{track-number}-{title}"

    # Get the downloaded .mp3 files (avoid ls quirks)
    set files (echo *.mp3)

    if test "$files" = "*.mp3"
        echo "No .mp3 files found after download."
        return 0
    end

    for f in $files
        set f (string trim -- $f)
        set dir  (path dirname -- $f)
        set base (path basename -- $f)
        set stem (string replace -r -- '\.mp3$' '' $base)

        # Normalize case and common characters
        set new (string lower -- $stem)
        set new (string replace -a "…" "-" -- $new)
        set new (string replace -a " " "-" -- $new)
        set new (string replace -a "_" "-" -- $new)
        set new (string replace -a "'" "" -- $new)
        set new (string replace -r -- "[^a-z0-9-]+" "-" $new)
        set new (string replace -r -- "-+" "-" $new)
        set new (string trim -c "-" -- $new)

        if test -z "$new"
            set fallback (string replace -r -- '\.mp3$' '' $base)
            set fallback (string trim -- $fallback)
            if test -z "$fallback"
                set new "track-"(date +%s%N)
            else
                set new (string replace -r -- "[^A-Za-z0-9]+" "-" $fallback)
                set new (string lower -- $new)
                set new (string replace -r -- "-+" "-" $new)
                set new (string trim -c "-" -- $new)
                if test -z "$new"
                    set new "track-"(date +%s%N)
                end
            end
        end

        set target "$dir/$new.mp3"
        set target (string trim -- $target)

        if test "$f" != "$target"
            if test -e "$target"
                echo "Warning: '$target' exists, skipping rename of '$f'"
            else
                mv -- "./$f" "./$target"
            end
        end
    end
end