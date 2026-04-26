local Mod = "SUPER"
local home = os.getenv("HOME")
local scripts = home .. "/.config/hypr/scripts"

-- App Definitions
local apps = {
  browser  = "vivaldi-snapshot",
  launcher = "noctalia-shell ipc call launcher toggle",
  files    = "yazi",
  term     = "foot",
  term2    = "ghostty",
  browser2 = "appimage-run " .. home .. "/AppImages/helium.appimage",
  vc       = "vesktop",
  music    = "flatpak run com.spotify.Client",
  emoji    = "noctalia-shell ipc call launcher emoji",
}

-- Main Application Binds
hl.bind(Mod .. " + Z", hl.dsp.exec_cmd(apps.launcher), { release = true, description = "Toggle App Launcher" })
hl.bind(Mod .. " + SHIFT + Z", hl.dsp.exec_cmd(home .. "/.config/bemenu/noctaliaScripts"),
  { description = "Launch Scripts Menu" })

hl.bind(Mod .. " + Return", hl.dsp.exec_cmd(apps.term), { description = "Launch Terminal (Foot)" })
hl.bind(Mod .. " + SHIFT + Return", hl.dsp.exec_cmd(apps.term2), { description = "Launch Secondary Terminal (Ghostty)" })

hl.bind(Mod .. " + E", hl.dsp.exec_cmd(apps.term .. " --app-id=" .. apps.files .. " " .. apps.files),
  { description = "Launch File Manager (Yazi)" })
hl.bind("CTRL + SHIFT + Escape", hl.dsp.exec_cmd(apps.term .. " btop"), { description = "Launch System Monitor (Btop)" })

hl.bind(Mod .. " + V", hl.dsp.exec_cmd(apps.browser), { description = "Launch Web Browser" })
hl.bind(Mod .. " + ALT + D", hl.dsp.exec_cmd(apps.vc), { description = "Launch Voice Chat (Vesktop)" })
hl.bind(Mod .. " + period", hl.dsp.exec_cmd(apps.emoji), { description = "Open Emoji Picker" })
hl.bind(Mod .. " + M", hl.dsp.exec_cmd("mpv --player-operation-mode=pseudo-gui"), { description = "Launch MPV" })

-- Multimedia/Function Keys
hl.bind("xf86homepage", hl.dsp.exec_cmd(apps.browser2), { description = "Fn+F1: Launch Helium Browser" })
hl.bind("xf86Mail", hl.dsp.exec_cmd("qalculate-gtk"), { description = "Fn+F2: Launch Calculator" })

-- vim:fileencoding=utf-8:foldmethod=marker:fdl=0
