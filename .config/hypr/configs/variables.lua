local home = os.getenv("HOME")
local scripts = home .. "/.config/hypr/scripts"

return {
  home = home,
  scripts = scripts,
  ipc = "noctalia-shell ipc call",
  brightness = scripts .. "/brightness",
  playerctl = scripts .. "/playerctl",
  screenshot = scripts .. "/screenShot",
}
