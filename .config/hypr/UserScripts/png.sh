#!/bin/bash

echo ""
echo "**Converting to png**"
echo ""
mogrify -format png *.jpg
mogrify -format png *.jpeg
mogrify -format png *.webp
chmod 644 *.png
echo "Done"

echo ""
echo "**Cleaning other formats**"
echo ""
rm *.jpg
rm *.jpeg
rm *.webp
echo "Done"

echo ""
echo "**Resizeing to 1920*1080**"
echo ""
mogrify -resize 1920x1080 *.png
echo "Done"

