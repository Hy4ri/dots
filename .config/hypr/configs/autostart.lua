local scripts = os.getenv("HOME") .. "/.config/hypr/scripts"

hl.on("hyprland.start", function()
  -- Startup
  hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP QT_QPA_PLATFORMTHEME")
  hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP --all")

  -- Apps
  hl.exec_cmd("noctalia-shell")
  hl.exec_cmd(scripts .. "/theker")
  -- hl.exec_cmd("")

  -- Plugins
  hl.exec_cmd("hyprmp reload -n")

  -- Timers
  -- hl.timer(function()
  --   hl.exec_cmd(scripts .. "/battery-notify")
  -- end, { timeout = 60000, type = "repeat" })
end)
