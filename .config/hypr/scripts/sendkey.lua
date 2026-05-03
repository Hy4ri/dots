-- sendkey.lua — Hyprland Lua library for sending keyboard/mouse events
--
-- Load once in hyprland.conf:
--   dofile(os.getenv("HOME") .. "/.config/hypr/scripts/sendkey.lua")
--
-- Calling conventions (both work):
--   sendkey.key("class:ghostty", "ctrl+c")       -- positional
--   sendkey.key({window = "class:ghostty", key = "ctrl+c"})  -- table
--
-- From bash:
--   hyprctl eval 'sendkey.shortcut({window="ghostty", key="ctrl+c"})'
--   hyprctl eval 'sendkey.repeat({window="ghostty", key="h"})'

local sendkey = {}

-- ── Internal helpers ──────────────────────────────────────────────

local function normalize_window(w)
  if type(w) ~= "string" then return w end
  if w:find(":") or w == "activewindow" or w == "floating" or w == "tiled" then
    return w
  end
  return "class:" .. w
end

local function parse_key(input)
  if not input then return "", "" end
  local mods, key = "", input
  local plus = input:find("+")
  if plus then
    key = input:sub(plus + 1)
    local parts = {}
    for m in input:sub(1, plus - 1):gmatch("[^+]+") do
      local u = m:upper()
      if u == "CTRL" or u == "SHIFT" or u == "ALT" or u == "SUPER" then
        parts[#parts + 1] = u
      end
    end
    mods = table.concat(parts, "+")
  end
  return mods, key
end

local MOUSE_MAP = {
  left   = "BTN_LEFT",
  right  = "BTN_RIGHT",
  middle = "BTN_MIDDLE",
}

local function parse_mouse(btn)
  return MOUSE_MAP[btn] or btn
end

local function key_state_args(window, key, mods, state)
  local w = normalize_window(window)
  if mods and mods ~= "" then
    return {mods = mods, key = key, state = state, window = w}
  end
  return {mods = "", key = key, state = state, window = w}
end

local function key_press(window, key, mods)
  hl.dispatch(hl.dsp.send_key_state(key_state_args(window, key, mods, "down")))
  hl.dispatch(hl.dsp.send_key_state(key_state_args(window, key, mods, "up")))
end

local function unpack_args(args, keys)
  local n = #keys
  if type(args[1]) == "table" then
    local t = args[1]
    local result = {}
    for i, k in ipairs(keys) do
      result[i] = t[k]
    end
    return table.unpack(result, 1, n)
  end
  return table.unpack(args, 1, n)
end

local timers = {}

local function timer_key(window, key, mods, suffix)
  return normalize_window(window) .. ":" .. key .. ":" .. (mods or "") .. (suffix or "")
end

-- ── Public API ────────────────────────────────────────────────────

function sendkey.mouse(...)
  local x, y = unpack_args({...}, {"x", "y"})
  hl.dispatch(hl.dsp.cursor.move({x = x, y = y}))
end

function sendkey.click(...)
  local window, button, x, y, mods = unpack_args({...}, {"window", "button", "x", "y", "mods"})
  local parsed_mods, parsed_btn = parse_key(button)
  mods = mods or parsed_mods
  local btn = parse_mouse(parsed_btn)

  sendkey.mouse(x, y)
  hl.dispatch(hl.dsp.send_key_state(key_state_args(window, btn, mods, "down")))
  hl.timer(function()
    hl.dispatch(hl.dsp.send_key_state(key_state_args(window, btn, mods, "up")))
  end, {timeout = 20, type = "oneshot"})
end

function sendkey.key(...)
  local window, key, mods = unpack_args({...}, {"window", "key", "mods"})
  if not mods then
    mods, key = parse_key(key)
  end
  key_press(window, key, mods)
end

function sendkey.shortcut(...)
  local window, key, mods = unpack_args({...}, {"window", "key", "mods"})
  if not mods then
    mods, key = parse_key(key)
  end
  hl.dispatch(hl.dsp.send_shortcut({mods = mods or "", key = key, window = normalize_window(window)}))
end

function sendkey.focus(...)
  local window = unpack_args({...}, {"window"})
  hl.dispatch(hl.dsp.focus({window = normalize_window(window)}))
end

function sendkey.scroll(...)
  local window, direction, amount, mods = unpack_args({...}, {"window", "direction", "amount", "mods"})
  amount = amount or 1
  local key = ({up = "Prior", down = "Next"})[direction] or direction
  for _ = 1, amount do
    key_press(window, key, mods)
  end
end

sendkey["repeat"] = function(...)
  local window, key, count, mods = unpack_args({...}, {"window", "key", "count", "mods"})
  if not mods then
    mods, key = parse_key(key)
  end
  count = tonumber(count) or 0
  local id = timer_key(window, key, mods)

  if timers[id] then
    timers[id]:set_enabled(false)
    timers[id] = nil
    hl.dispatch(hl.dsp.send_key_state(key_state_args(window, key, mods, "up")))
    return "off"
  end

  local w = normalize_window(window)

  if count > 0 then
    local i = 0
    local t = hl.timer(function()
      i = i + 1
      hl.dispatch(hl.dsp.send_key_state(key_state_args(w, key, mods, "down")))
      hl.dispatch(hl.dsp.send_key_state(key_state_args(w, key, mods, "up")))
      if i >= count then
        t:set_enabled(false)
        timers[id] = nil
      end
    end, {timeout = 5, type = "repeat"})
    timers[id] = t
    return "on"
  end

  local t = hl.timer(function()
    hl.dispatch(hl.dsp.send_key_state(key_state_args(w, key, mods, "down")))
    hl.dispatch(hl.dsp.send_key_state(key_state_args(w, key, mods, "up")))
  end, {timeout = 5, type = "repeat"})
  timers[id] = t
  return "on"
end

function sendkey.hold(...)
  local window, key, mods = unpack_args({...}, {"window", "key", "mods"})
  if not mods then
    mods, key = parse_key(key)
  end
  local id = timer_key(window, key, mods, ":hold")

  if timers[id] then
    timers[id]:set_enabled(false)
    timers[id] = nil
    hl.dispatch(hl.dsp.send_key_state(key_state_args(window, key, mods, "up")))
    return "off"
  end

  local w = normalize_window(window)

  hl.dispatch(hl.dsp.send_key_state(key_state_args(w, key, mods, "down")))

  local t = hl.timer(function()
    hl.dispatch(hl.dsp.send_key_state(key_state_args(w, key, mods, "down")))
  end, {timeout = 100, type = "repeat"})
  timers[id] = t
  return "on"
end

function sendkey.cleanup()
  for id, t in pairs(timers) do
    t:set_enabled(false)
    timers[id] = nil
  end
end

_G.sendkey = sendkey
return sendkey