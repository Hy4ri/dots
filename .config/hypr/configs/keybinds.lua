local Mod = "SUPER"
local scripts = os.getenv("HOME") .. "/.config/hypr/scripts"

-- System/Session
hl.bind("CTRL + ALT + Delete", hl.dsp.exit(), { description = "Exit Hyprland session" })
hl.bind("xf86Sleep", hl.dsp.exec_cmd("systemctl suspend"), { locked = true, description = "Suspend the system" })
hl.bind(Mod .. " + SHIFT + R", hl.dsp.exec_cmd(scripts .. "/refresh"), { locked = true, description = "Refresh session" })

-- Turn off screen and lock with a keybind
local lock = false
hl.bind("SUPER + SHIFT + P", function()
    if lock == false then
      hl.dispatch(hl.dsp.exec_cmd("noctalia-shell ipc call lockscreen lock"))
      hl.dispatch(hl.dsp.dpms("toggle"))
      lock = true
    elseif lock == true then
      hl.dispatch(hl.dsp.dpms("toggle"))
      lock = false
    end
  end,
  { locked = true, description = "Toggle DPMS" })


-- Window Management
hl.bind(Mod .. " + Q", hl.dsp.window.close(), { repeating = true, description = "Kill the active window" })
hl.bind(Mod .. " + SHIFT + Q", function()
  local w = hl.get_active_window()
  if w ~= nil and w.pid ~= nil then
    hl.exec_cmd("kill -9 " .. w.pid)
  end
end, { description = "Kill the process of the active window" })
hl.bind(Mod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }),
  { description = "Toggle fullscreen for the active window" })
hl.bind(Mod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = "maximized" }),
  { description = "Toggle maximized state for the window" })
hl.bind(Mod .. " + CTRL + F", hl.dsp.window.float(), { description = "Toggle floating state for the active window" })
hl.bind(Mod .. " + SHIFT + P", hl.dsp.window.pin(), { description = "Pin the active window" })
hl.bind("ALT + Tab", hl.dsp.focus({ last = "f" }), { description = "Focus the last active window" })

-- Navigation (Focus)
hl.bind(Mod .. " + H", hl.dsp.focus({ direction = "left" }), { description = "Move focus to the left window" })
hl.bind(Mod .. " + L", hl.dsp.focus({ direction = "right" }), { description = "Move focus to the right window" })
hl.bind(Mod .. " + K", hl.dsp.focus({ direction = "up" }), { description = "Move focus to the upper window" })
hl.bind(Mod .. " + J", hl.dsp.focus({ direction = "down" }), { description = "Move focus to the lower window" })

-- Manipulation (Move, Resize)
hl.bind(Mod .. " + SHIFT + H", hl.dsp.window.resize({ x = -50, y = 0, relative = true }),
  { repeating = true, description = "Resize window: decrease width" })
hl.bind(Mod .. " + SHIFT + L", hl.dsp.window.resize({ x = 50, y = 0, relative = true }),
  { repeating = true, description = "Resize window: increase width" })
hl.bind(Mod .. " + SHIFT + K", hl.dsp.window.resize({ x = 0, y = -50, relative = true }),
  { repeating = true, description = "Resize window: decrease height" })
hl.bind(Mod .. " + SHIFT + J", hl.dsp.window.resize({ x = 0, y = 50, relative = true }),
  { repeating = true, description = "Resize window: increase height" })

hl.bind(Mod .. " + CTRL + H", hl.dsp.window.move({ direction = "left" }), { description = "Move window to the left" })
hl.bind(Mod .. " + CTRL + L", hl.dsp.window.move({ direction = "right" }), { description = "Move window to the right" })
hl.bind(Mod .. " + CTRL + K", hl.dsp.window.move({ direction = "up" }), { description = "Move window up" })
hl.bind(Mod .. " + CTRL + J", hl.dsp.window.move({ direction = "down" }), { description = "Move window down" })

hl.bind(Mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true, description = "Move window with mouse" })
hl.bind(Mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true, description = "Resize window with mouse" })

-- Workspaces
hl.bind(Mod .. " + Tab", hl.dsp.focus({ workspace = "m+1" }), { description = "Next workspace" })
hl.bind(Mod .. " + SHIFT + Tab", hl.dsp.focus({ workspace = "m-1" }), { description = "Previous workspace" })
hl.bind(Mod .. " + grave", hl.dsp.workspace.toggle_special("mgc"), { description = "Toggle special workspace" })
hl.bind(Mod .. " + SHIFT + grave", hl.dsp.window.move({ workspace = "special:mgc" }), { description = "Move to special" })

for i = 1, 10 do
  local code = i % 10
  hl.bind(Mod .. " + " .. code, hl.dsp.focus({ workspace = i }), { description = "Switch to workspace " .. i })
  hl.bind(Mod .. " + SHIFT + " .. code, hl.dsp.window.move({ workspace = i }), { description = "Move to workspace " })
  hl.bind(Mod .. " + CTRL +" .. code, hl.dsp.window.move({ workspace = i, follow = false }),
    { description = "Move to workspace silently" })
end

hl.bind(Mod .. " + ALT + 1", hl.dsp.workspace.move({ monitor = "eDP-1" }),
  { description = "Move current workspace to eDP-1 monitor" })
hl.bind(Mod .. " + ALT + 2", hl.dsp.workspace.move({ monitor = "HDMI-A-3" }),
  { description = "Move current workspace to HDMI-A-3 monitor" })

-- Layouts & Groups
hl.bind(Mod .. " + ALT + S", function()
  local layout = hl.get_config("general.layout")

  if layout == "dwindle" then
    hl.dispatch(hl.dsp.layout("togglesplit"))
  elseif layout == "master" then
    hl.dispatch(hl.dsp.layout("orientationcycle top left"))
  elseif layout == "scrolling" then
    local direc = hl.get_config("scrolling.direction")
    if direc == "right" or direc == "left" then
      hl.config({
        scrolling = { direction = "down" }
      })
      hl.dispatch(hl.dsp.layout("fit all"))
    else
      hl.config({
        scrolling = { direction = "right" }

      })
      hl.dispatch(hl.dsp.layout("fit active"))
    end
  end
end, { description = "Change layout (cycle or toggle)" })

hl.bind(Mod .. " + G", hl.dsp.group.toggle(), { description = "Toggle window group" })
hl.bind("ALT + grave", hl.dsp.group.next(), { description = "Focus next window in group" })

-- Multimedia & Function Keys
hl.bind("xf86audioraisevolume", hl.dsp.exec_cmd("noctalia-shell ipc call volume increase"),
  { repeating = true, locked = true, description = "Increase system volume" })
hl.bind("xf86audiolowervolume", hl.dsp.exec_cmd("noctalia-shell ipc call volume decrease"),
  { repeating = true, locked = true, description = "Decrease system volume" })
hl.bind("SHIFT + xf86audioraisevolume", hl.dsp.exec_cmd("noctalia-shell ipc call brightness increase"),
  { repeating = true, locked = true, description = "Increase screen brightness" })
hl.bind("SHIFT + xf86audiolowervolume", hl.dsp.exec_cmd("noctalia-shell ipc call brightness decrease"),
  { repeating = true, locked = true, description = "Decrease screen brightness" })
hl.bind("ALT + xf86audioraisevolume", hl.dsp.exec_cmd(scripts .. "/brightness --kbd-inc"),
  { repeating = true, description = "Increase keyboard brightness" })
hl.bind("ALT + xf86audiolowervolume", hl.dsp.exec_cmd(scripts .. "/brightness --kbd-dec"),
  { repeating = true, description = "Decrease keyboard brightness" })
hl.bind("CTRL + xf86audioraisevolume", hl.dsp.exec_cmd(scripts .. "/playerctl --inc"),
  { repeating = true, description = "Increase player volume" })
hl.bind("CTRL + xf86audiolowervolume", hl.dsp.exec_cmd(scripts .. "/playerctl --dec"),
  { repeating = true, description = "Decrease player volume" })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("noctalia-shell ipc call volume muteOutpot"),
  { locked = true, description = "Mute audio output" })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("noctalia-shell ipc call volume muteInput"),
  { locked = true, description = "Mute microphone input" })
hl.bind("xf86Rfkill", hl.dsp.exec_cmd(scripts .. "/AirplaneMode"),
  { locked = true, description = "Toggle airplane mode" })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("noctalia-shell ipc call media playPause"),
  { locked = true, description = "Toggle media play/pause (Pause)" })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("noctalia-shell ipc call media playPause"),
  { locked = true, description = "Toggle media play/pause (Play)" })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("noctalia-shell ipc call media previous"),
  { locked = true, description = "Previous media track" })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("noctalia-shell ipc call media next"),
  { locked = true, description = "Next media track" })
hl.bind("xf86MonBrightnessDown", hl.dsp.exec_cmd("noctalia-shell ipc call brightness decrease"),
  { repeating = true, locked = true, description = "Decrease monitor brightness" })
hl.bind("xf86MonBrightnessUp", hl.dsp.exec_cmd("noctalia-shell ipc call brightness increase"),
  { repeating = true, locked = true, description = "Increase monitor brightness" })

-- System Tools (Screenshots, Launcher, etc.)
hl.bind(Mod .. " + SHIFT + B", hl.dsp.exec_cmd("noctalia-shell ipc call bluetooth toggle"),
  { description = "Toggle Bluetooth state" })
hl.bind(Mod .. " + ALT + V", hl.dsp.exec_cmd("noctalia-shell ipc call launcher clipboard"),
  { description = "Open clipboard history manager" })
hl.bind(Mod .. " + W", hl.dsp.exec_cmd("noctalia-shell ipc call wallpaper toggle"),
  { description = "Open wallpaper selection menu" })
hl.bind("CTRL + ALT + W", hl.dsp.exec_cmd("noctalia-shell ipc call wallpaper random"),
  { description = "Set a random wallpaper" })
hl.bind(Mod .. " + B", hl.dsp.exec_cmd("noctalia-shell ipc call bar toggle"),
  { description = "Toggle status bar visibility" })
hl.bind(Mod .. " + SHIFT + S", hl.dsp.exec_cmd(scripts .. "/screenShot --swappy"),
  { description = "Screenshot: select region and edit" })
hl.bind("Print", hl.dsp.exec_cmd(scripts .. "/screenShot --now"), { description = "Screenshot: capture now" })
hl.bind(Mod .. " + SHIFT + C", hl.dsp.exec_cmd("noctalia-shell ipc call plugin:screen-toolkit colorPicker"),
  { description = "Open color picker tool" })
hl.bind(Mod .. " + SHIFT + T", hl.dsp.exec_cmd("noctalia-shell ipc call plugin:screen-toolkit ocr"),
  { description = "Open OCR (text recognition) tool" })
hl.bind(Mod .. " + Prior", hl.dsp.exec_cmd(scripts .. "/power --toggle"),
  { description = "Toggle system performance mode" })
hl.bind(Mod .. " + Next", hl.dsp.exec_cmd(scripts .. "/power --powersaver"),
  { description = "Enable system powersaving mode" })
-- zoom
hl.bind(Mod .. " + equal", function()
  local zoom = hl.get_config("cursor.zoom_factor")
  hl.config({
    cursor = { zoom_factor = math.min(5.0, zoom + 0.1) }
  })
end, { repeating = true, description = "Zoom in screen" })

hl.bind(Mod .. " + minus", function()
  local zoom = hl.get_config("cursor.zoom_factor")
  hl.config({
    cursor = { zoom_factor = math.max(1.0, zoom - 0.1) }
  })
end, { repeating = true, description = "Zoom out screen" })

-- Misc
hl.bind(Mod .. " + SHIFT + i", hl.dsp.exec_cmd(scripts .. "/info"), { description = "Display system information" })
hl.bind(Mod .. " + i", hl.dsp.exec_cmd(scripts .. "/vimwere"), { description = "vim everywhere" })

local touch = true
local touchpad_name = "dell09e1:00-04f3:30cb-touchpad"
hl.bind(Mod .. " + Menu", function()
  if touch == true then
    hl.device({
      name = touchpad_name,
      enabled = false,
    })
    touch = false
  else
    hl.device({
      name = touchpad_name,
      enabled = true,
    })
    touch = true
  end
end, { description = "Toggle touchpad" })
