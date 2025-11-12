#!/usr/bin/env bash

shopt -s nullglob

video_exts=("mp4" "mkv" "avi" "mov")
sub_exts=("srt" "ass" "vtt" "sub")

for video in *; do
  ext="${video##*.}"
  [[ " ${video_exts[*]} " =~ " ${ext} " ]] || continue

  if [[ $video =~ ([Ss][0-9]{2}[Ee][0-9]{2}) ]]; then
    episode="${BASH_REMATCH[1]}"
    base="${video%.*}"

    for sub in *; do
      subext="${sub##*.}"
      [[ " ${sub_exts[*]} " =~ " ${subext} " ]] || continue

      if [[ $sub =~ $episode ]]; then
        newname="${base}.ar.${subext}"
        echo "Renaming: '$sub' → '$newname'"
        mv -i -- "$sub" "$newname"
      fi
    done
  fi
done
