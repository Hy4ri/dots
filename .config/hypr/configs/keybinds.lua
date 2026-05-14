local vars = require("configs.variables")
local scripts = vars.scripts

local function zoom_change(delta)
  local zoom = hl.get_config("cursor.zoom_factor")
  hl.config({
    cursor = { zoom_factor = math.max(1.0, math.min(5.0, zoom + delta)) }
  })
end

-- System/Session
hl.bind("CTRL + ALT + Delete", hl.dsp.exit(), { bypass = true, description = "Exit Hyprland session" })
hl.bind("xf86Sleep", hl.dsp.exec_cmd("systemctl suspend"), { locked = true, description = "Suspend the system" })
hl.bind("SUPER + SHIFT + R", hl.dsp.exec_cmd(scripts .. "/refresh"), { locked = true, description = "Refresh session" })

-- Turn off screen and lock with a keybind
local lock = false
hl.bind("SUPER + SHIFT + P", function()
    if lock == false then
      hl.dispatch(hl.dsp.exec_cmd(vars.ipc .. " lockScreen lock"))
      hl.dispatch(hl.dsp.dpms("toggle"))
      lock = true
    elseif lock == true then
      hl.dispatch(hl.dsp.dpms("toggle"))
      lock = false
    end
  end,
  { locked = true, description = "Toggle DPMS" })


-- Window Management
hl.bind("SUPER + Q", hl.dsp.window.close(), { bypass = true, description = "Kill the active window" })
hl.bind("SUPER + SHIFT + Q", function()
  local w = hl.get_active_window()
  if w ~= nil and w.pid ~= nil then
    hl.exec_cmd("kill -9 " .. w.pid)
  end
end, { description = "Kill the process of the active window" })
hl.bind("SUPER + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }),
  { description = "Toggle fullscreen for the active window" })
hl.bind("SUPER + SHIFT + F", hl.dsp.window.fullscreen({ mode = "maximized" }),
  { description = "Toggle maximized state for the window" })
hl.bind("SUPER + CTRL + F", hl.dsp.window.float(), { description = "Toggle floating state for the active window" })
hl.bind("SUPER + SHIFT + P", hl.dsp.window.pin(), { description = "Pin the active window" })
hl.bind("ALT + Tab", hl.dsp.focus({ last = "f" }), { description = "Focus the last active window" })

-- Navigation (Focus)
hl.bind("SUPER + H", hl.dsp.focus({ direction = "left" }), { description = "Focus left" })
hl.bind("SUPER + L", hl.dsp.focus({ direction = "right" }), { description = "Focus right" })
hl.bind("SUPER + K", hl.dsp.focus({ direction = "up" }), { description = "Focus up" })
hl.bind("SUPER + J", hl.dsp.focus({ direction = "down" }), { description = "Focus down" })

-- Manipulation (Move, Resize)
hl.bind("SUPER + CTRL + H", hl.dsp.window.resize({ x = -50, y = 0, relative = true }),
  { repeating = true, description = "Resize window: decrease width" })
hl.bind("SUPER + CTRL + L", hl.dsp.window.resize({ x = 50, y = 0, relative = true }),
  { repeating = true, description = "Resize window: increase width" })
hl.bind("SUPER + CTRL + K", hl.dsp.window.resize({ x = 0, y = -50, relative = true }),
  { repeating = true, description = "Resize window: decrease height" })
hl.bind("SUPER + CTRL + J", hl.dsp.window.resize({ x = 0, y = 50, relative = true }),
  { repeating = true, description = "Resize window: increase height" })

hl.bind("SUPER + SHIFT + H", hl.dsp.window.move({ direction = "left" }), { description = "Move window left " })
hl.bind("SUPER + SHIFT + L", hl.dsp.window.move({ direction = "right" }), { description = "Move window to the right" })
hl.bind("SUPER + SHIFT + K", hl.dsp.window.move({ direction = "up" }), { description = "Move window up" })
hl.bind("SUPER + SHIFT + J", hl.dsp.window.move({ direction = "down" }), { description = "Move window down" })

hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true, description = "Move window with mouse" })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true, description = "Resize window with mouse" })

-- Workspaces
hl.bind("SUPER + Tab", hl.dsp.focus({ workspace = "m+1" }), { description = "Next workspace" })
hl.bind("SUPER + SHIFT + Tab", hl.dsp.focus({ workspace = "m-1" }), { description = "Previous workspace" })
hl.bind("SUPER + grave", hl.dsp.workspace.toggle_special("mgc"), { description = "Toggle special workspace" })
hl.bind("SUPER + SHIFT + grave", hl.dsp.window.move({ workspace = "special:mgc" }), { description = "Move to special" })

for i = 1, 10 do
  local code = i % 10
  hl.bind("SUPER + " .. code, hl.dsp.focus({ workspace = i }), { description = "Switch to workspace " .. i })
  hl.bind("SUPER + SHIFT + " .. code, hl.dsp.window.move({ workspace = i }), { description = "Move to workspace " })
  hl.bind("SUPER + CTRL + " .. code, hl.dsp.window.move({ workspace = i, follow = false }),
    { description = "Move to workspace silently" })
end

hl.bind("SUPER + ALT + 1", hl.dsp.workspace.move({ monitor = "eDP-1" }),
  { description = "Move current workspace to eDP-1 monitor" })
hl.bind("SUPER + ALT + 2", hl.dsp.workspace.move({ monitor = "HDMI-A-3" }),
  { description = "Move current workspace to HDMI-A-3 monitor" })

-- Layouts & Groups
hl.bind("SUPER + ALT + S", function()
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
end, { description = "Change split direction" })

hl.bind("SUPER + G", hl.dsp.group.toggle(), { description = "Toggle window group" })
hl.bind("ALT + grave", hl.dsp.group.next(), { description = "Focus next window in group" })

-- Multimedia & Function Keys
hl.bind("xf86audioraisevolume", hl.dsp.exec_cmd(vars.ipc .. " volume increase"),
  { repeating = true, locked = true, description = "Increase system volume" })
hl.bind("xf86audiolowervolume", hl.dsp.exec_cmd(vars.ipc .. " volume decrease"),
  { repeating = true, locked = true, description = "Decrease system volume" })
hl.bind("SHIFT + xf86audioraisevolume", hl.dsp.exec_cmd(vars.ipc .. " brightness increase"),
  { repeating = true, locked = true, description = "Increase screen brightness" })
hl.bind("SHIFT + xf86audiolowervolume", hl.dsp.exec_cmd(vars.ipc .. " brightness decrease"),
  { repeating = true, locked = true, description = "Decrease screen brightness" })
hl.bind("ALT + xf86audioraisevolume", hl.dsp.exec_cmd(vars.brightness .. " --kbd-inc"),
  { repeating = true, description = "Increase keyboard brightness" })
hl.bind("ALT + xf86audiolowervolume", hl.dsp.exec_cmd(vars.brightness .. " --kbd-dec"),
  { repeating = true, description = "Decrease keyboard brightness" })
hl.bind("CTRL + xf86audioraisevolume", hl.dsp.exec_cmd(vars.playerctl .. " --inc"),
  { repeating = true, description = "Increase player volume" })
hl.bind("CTRL + xf86audiolowervolume", hl.dsp.exec_cmd(vars.playerctl .. " --dec"),
  { repeating = true, description = "Decrease player volume" })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(vars.ipc .. " volume muteOutpot"),
  { locked = true, description = "Mute audio output" })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd(vars.ipc .. " volume muteInput"),
  { locked = true, description = "Mute microphone input" })
hl.bind("xf86Rfkill", hl.dsp.exec_cmd(scripts .. "/AirplaneMode"),
  { locked = true, description = "Toggle airplane mode" })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd(vars.ipc .. " media playPause"),
  { locked = true, description = "Toggle media play/pause (Pause)" })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd(vars.ipc .. " media playPause"),
  { locked = true, description = "Toggle media play/pause (Play)" })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd(vars.ipc .. " media previous"),
  { locked = true, description = "Previous media track" })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd(vars.ipc .. " media next"),
  { locked = true, description = "Next media track" })
hl.bind("xf86MonBrightnessDown", hl.dsp.exec_cmd(vars.ipc .. " brightness decrease"),
  { repeating = true, locked = true, description = "Decrease monitor brightness" })
hl.bind("xf86MonBrightnessUp", hl.dsp.exec_cmd(vars.ipc .. " brightness increase"),
  { repeating = true, locked = true, description = "Increase monitor brightness" })

-- System Tools (Screenshots, Launcher, etc.)
hl.bind("SUPER + SHIFT + B", hl.dsp.exec_cmd(vars.ipc .. " bluetooth toggle"),
  { description = "Toggle Bluetooth state" })
hl.bind("SUPER + ALT + V", hl.dsp.exec_cmd(vars.ipc .. " launcher clipboard"),
  { description = "Open clipboard history manager" })
hl.bind("SUPER + W", hl.dsp.exec_cmd(vars.ipc .. " wallpaper toggle"),
  { release = true, description = "Open wallpaper selection menu" })
hl.bind("CTRL + ALT + W", hl.dsp.exec_cmd(vars.ipc .. " wallpaper random"),
  { description = "Set a random wallpaper" })
hl.bind("SUPER + B", hl.dsp.exec_cmd(vars.ipc .. " bar toggle"),
  { release = true, description = "Toggle status bar visibility" })
hl.bind("SUPER + SHIFT + S", hl.dsp.exec_cmd(vars.screenshot .. " --swappy"),
  { locked = true, description = "Screenshot: select region and edit" })
hl.bind("Print", hl.dsp.exec_cmd(vars.screenshot .. " --now"), { locked = true, description = "Screenshot: capture now" })
hl.bind("SUPER + SHIFT + C", hl.dsp.exec_cmd(vars.ipc .. " plugin:screen-toolkit colorPicker"),
  { description = "Open color picker tool" })
hl.bind("SUPER + SHIFT + T", hl.dsp.exec_cmd(vars.ipc .. " plugin:screen-toolkit ocr"),
  { description = "Open OCR (text recognition) tool" })
hl.bind("SUPER + Prior", hl.dsp.exec_cmd(scripts .. "/power --toggle"),
  { release = true, description = "Toggle system performance mode" })
hl.bind("SUPER + Next", hl.dsp.exec_cmd(scripts .. "/power --powersaver"),
  { description = "Enable system powersaving mode" })
-- zoom
hl.bind("SUPER + equal", function() zoom_change(0.1) end, { repeating = true, description = "Zoom in screen" })

hl.bind("SUPER + minus", function() zoom_change(-0.1) end, { repeating = true, description = "Zoom out screen" })

-- Misc
hl.bind("SUPER + SHIFT + i", hl.dsp.exec_cmd(scripts .. "/info"), { description = "Display system information" })
hl.bind("SUPER + i", hl.dsp.exec_cmd(scripts .. "/vimwere"), { description = "vim everywhere" })

local touch = true
local touchpad_name = "dell09e1:00-04f3:30cb-touchpad"
hl.bind("SUPER + Menu", function()
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
