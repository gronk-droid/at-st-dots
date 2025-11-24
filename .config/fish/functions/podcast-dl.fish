function podcast-dl
    # Check if URL is provided
    if test (count $argv) -eq 0
        echo "Usage: podcast-dl <youtube_or_spotify_url>"
        return 1
    end

    set url $argv[1]
    
    # Create output directory if it doesn't exist
    set output_dir ~/03_podcasts
    if not test -d $output_dir
        mkdir -p $output_dir
        echo "Created directory: $output_dir"
    end
    
    # Download the podcast using yt-dlp
    echo "Downloading podcast from: $url"
    echo "Output directory: $output_dir"
    
    yt-dlp -x --audio-format mp3 --embed-thumbnail -o "$output_dir/%(title)s.%(ext)s" $url
    
    if test $status -eq 0
        echo "Podcast downloaded successfully to $output_dir"
    else
        echo "Error downloading podcast"
        return 1
    end
end
