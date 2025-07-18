#!/usr/bin/env bash

echo ""
echo "**Converting to png**"
echo ""
[[ -n $(ls *.jpg 2>/dev/null) ]] && mogrify -format png *.jpg
[[ -n $(ls *.jpeg 2>/dev/null) ]] && mogrify -format png *.jpeg
[[ -n $(ls *.webp 2>/dev/null) ]] && mogrify -format png *.webp
chmod 644 *.png
echo "Done"

echo ""
echo "**Cleaning other formats**"
echo ""
[[ -n $(ls *.jpg 2>/dev/null) ]] && rm *.jpg
[[ -n $(ls *.jpeg 2>/dev/null) ]] && rm *.jpeg
[[ -n $(ls *.webp 2>/dev/null) ]] && rm *.webp
echo "Done"

echo ""
echo "**Resizing to 1920*1080**"
echo ""
[[ -n $(ls *.png 2>/dev/null) ]] && mogrify -resize 1920x1080 *.png
echo "Done"

echo ""
echo "**Renaming files sequentially**"
echo ""
counter=1000
for item in *.png; do
    mv "$item" "$counter.png"
    counter=$((counter + 1))
done
echo "Done"
