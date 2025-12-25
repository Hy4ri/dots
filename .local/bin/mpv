#!/usr/bin/env bash

clip=$(wl-paste)

mpv \
    --fullscreen \
    --speed=2 \
    --ytdl-format="bestvideo[height<=1440]+bestaudio/best" \
    --cache=yes \
    --cache-secs=15000 \
    --demuxer-max-bytes=50M \
    --cache-on-disk=no \
    --ytdl-raw-options=cookies-from-browser=vivaldi \
    "$clip"
