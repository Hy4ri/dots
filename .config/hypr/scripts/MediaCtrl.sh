#!/usr/bin/env bash
music_icon="$HOME/.config/swaync/icons/music.png"

# Play the next track
play_next() {
    playerctl next
}

# Play the previous track
play_previous() {
    playerctl previous
}

# Toggle play/pause
toggle_play_pause() {
    playerctl play-pause
    show_music_notification
}

# Stop playback
stop_playback() {
    playerctl stop
        notify-send -e -u low -i "$music_icon" "Playback Stopped"
}

# Display notification with song information
show_music_notification() {
    status=$(playerctl status)
    if [[ "$status" == "Paused" ]]; then
        song_title=$(playerctl metadata title)
        song_artist=$(playerctl metadata artist)
        notify-send -e -u low -i "$music_icon" "Now Playing:" "$song_title\nby $song_artist"
    elif [[ "$status" == "Playing" ]]; then
        song_title=$(playerctl metadata title)
        notify-send -e -u low -i "$music_icon" "Playback Paused:"  "$song_title"
    fi
}

# Get media control action from command line argument
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
        echo "Usage: $0 [--nxt|--prv|--pause|--stop]"
        exit 1
        ;;
esac
