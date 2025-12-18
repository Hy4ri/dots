#!/usr/bin/env bash

# Configuration
mediaIdFile="/tmp/mediaId"
pictureCacheDir="$HOME/.cache/spotifyPictureCache"
mkdir -p "$pictureCacheDir"

# Helper: Get/Cache Album Art
get_art_path() {
    local url="$1"
    if [[ -z "$url" ]]; then
        echo ""
        return
    fi

    # Handle local files
    if [[ "$url" == file://* ]]; then
        echo "${url#file://}"
        return
    fi

    # Handle remote URLs (http/https)
    # Use MD5 hash of URL for filename to avoid special char issues
    local filename
    filename=$(echo -n "$url" | md5sum | cut -d" " -f1)
    local dest="$pictureCacheDir/$filename.jpg"

    if [[ -f "$dest" ]]; then
        echo "$dest"
    else
        # Download with timeout (max 2 seconds) to prevent hanging
        curl -s --max-time 2 -o "$dest" "$url"
        echo "$dest"
    fi
}

# Helper: Calculate Percentage
calculate_percent() {
    local pos="$1"
    local len="$2"
    
    # Avoid division by zero
    if [[ -z "$len" || "$len" -eq 0 ]]; then
        echo 0
    else
        # playerctl returns microseconds, bash arithmetic handles this fine
        echo $(( 100 * pos / len ))
    fi
}

# Helper: Format Duration (Microseconds to MM:SS)
format_duration() {
    local micros="$1"
    if [[ -z "$micros" ]]; then echo "0:00"; return; fi
    
    local seconds=$((micros / 1000000))
    local m=$((seconds / 60))
    local s=$((seconds % 60))
    printf "%d:%02d" "$m" "$s"
}

# Main Notification Function
show_music_notification() {
    # Fetch ALL metadata in ONE call for performance
    # Format: Status | Title | Artist | Album | ArtUrl | Position | Length | PlayerName
    metadata=$(playerctl --player=spotify,%any metadata --format \
        '{{status}}|{{title}}|{{artist}}|{{album}}|{{mpris:artUrl}}|{{position}}|{{mpris:length}}|{{playerName}}' 2>/dev/null)

    # If no player is running, exit
    if [ -z "$metadata" ]; then
        return
    fi

    # Parse the metadata string into variables
    IFS='|' read -r status title artist album artUrl position length playerName <<< "$metadata"

    # Process Data
    artPath=$(get_art_path "$artUrl")
    percent=$(calculate_percent "$position" "$length")
    pos_fmt=$(format_duration "$position")
    len_fmt=$(format_duration "$length")

    # Determine Icon/Status
    if [[ "$status" == "Playing" ]]; then
        status_icon="▶"
        summary_text="Now Playing"
    else
        status_icon="II"
        summary_text="Paused"
    fi

    # Capitalize Player Name
    player_display="$(tr '[:lower:]' '[:upper:]' <<< ${playerName:0:1})${playerName:1}"
    
    # Construct Body
    summary="$summary_text - $player_display"
    body="$title\n$artist\n$album\n$pos_fmt / $len_fmt"

    # Send Notification
    # Read previous ID to replace it
    replace_id=$(cat "$mediaIdFile" 2>/dev/null)
    if [[ -z "$replace_id" ]]; then replace_id=0; fi

    # Send and save new ID
    notify-send -p \
        -t 2000 \
        -r "$replace_id" \
        -i "$artPath" \
        --hint int:value:"$percent" \
        "$summary" "$body" > "$mediaIdFile"
}

# Control Functions
play_next() {
    playerctl --player=spotify,%any next
    show_music_notification
}

play_previous() {
    playerctl --player=spotify,%any previous
    show_music_notification
}

toggle_play_pause() {
    playerctl --player=spotify,%any play-pause
    show_music_notification
}

stop_playback() {
    playerctl --player=spotify,%any stop
    notify-send -t 2000 -u low "Playback Stopped"
}

# Argument Handling
case "$1" in
    "--nxt")
        play_next
        ;;
    "--prv")
        play_previous
        ;;
    "--pause")
        toggle_play_pause
        ;;
    "--stop")
        stop_playback
        ;;
    *)
        # If run without arguments, just show status
        show_music_notification
        ;;
esac
