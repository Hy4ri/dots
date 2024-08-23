# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Modified Script for Google Search
# Original Submitted by https://github.com/LeventKaanOguz

# Opens rofi in dmenu mod and waits for input. Then pushes the input to the query of the URL.

# Kill Rofi if already running before execution
if pgrep -x "rofi" >/dev/null; then
    pkill rofi
    exit 0
fi

# Open rofi with a dmenu and pass the selected item to xdg-open for Google search
echo "" | rofi -dmenu -theme $HOME/.config/rofi/launchers/type-3/style-5.rasi -p "Search:" | xargs -I{} xdg-open "https://www.google.com/search?q={}"
