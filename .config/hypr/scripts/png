#!/usr/bin/env bash
set -euo pipefail

# Default resolution
RES="1920x1080"
FORCE=false

# Parse arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    --res)
      RES="$2"
      shift 2
      ;;
    --force)
      FORCE=true
      shift
      ;;
    *)
      echo "Usage: $0 [--res WIDTHxHEIGHT] [--force]"
      exit 1
      ;;
  esac
done

if [ "$FORCE" = false ]; then
    read -p "This script will convert images to PNG, resize them to $RES, rename them, and DELETE original files. Continue? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Aborted."
        exit 1
    fi
fi

# Create a backup directory
BACKUP_DIR="backup_$(date +%s)"
mkdir -p "$BACKUP_DIR"

echo ""
echo "**Backing up originals to $BACKUP_DIR**"
# Copy all potential image files
cp *.jpg *.jpeg *.webp "$BACKUP_DIR" 2>/dev/null || true
echo "Done"

echo ""
echo "**Converting to png**"
[[ -n $(ls *.jpg 2>/dev/null) ]] && mogrify -format png *.jpg
[[ -n $(ls *.jpeg 2>/dev/null) ]] && mogrify -format png *.jpeg
[[ -n $(ls *.webp 2>/dev/null) ]] && mogrify -format png *.webp
echo "Done"

chmod 666 *.png

echo ""
echo "**Cleaning other formats**"
[[ -n $(ls *.jpg 2>/dev/null) ]] && rm *.jpg
[[ -n $(ls *.jpeg 2>/dev/null) ]] && rm *.jpeg
[[ -n $(ls *.webp 2>/dev/null) ]] && rm *.webp
echo "Done"

echo ""
echo "**Resizing to $RES**"
[[ -n $(ls *.png 2>/dev/null) ]] && mogrify -resize "$RES" *.png
echo "Done"

echo ""
echo "**Renaming files sequentially**"
counter=1000
for item in *.png; do
    mv "$item" "$counter.png"
    counter=$((counter + 1))
done
echo "Done"
