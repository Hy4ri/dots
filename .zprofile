# if [[ -z "$TMUX" ]] && uwsm check may-start; then
#     exec uwsm start hyprland.desktop
# fi

if [ "$(tty)" = "/dev/tty1" ] && [ -n "$PS1" ]; then
  Hyprland
elif [ "$(tty)" = "/dev/tty2" ] && [ -n "$PS1" ]; then
  niri
fi
