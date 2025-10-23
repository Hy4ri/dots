# if [[ -z "$TMUX" ]] && uwsm check may-start; then
#     exec uwsm start hyprland.desktop
# fi

if [ "$(tty)" = "/dev/tty1" ] && [ -n "$PS1" ]; then
  hyprland
fi
