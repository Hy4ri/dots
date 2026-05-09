local scripts = os.getenv("HOME") .. "/.config/hypr/scripts"

-- Gestures

hl.gesture({
  fingers = 2,
  direction = "pinch",
  action = "cursor_zoom",
  zoom_level = 1,
  mode = "live"
})

hl.gesture({
  fingers = 3,
  direction = "up",
  action = function() hl.exec_cmd(scripts .. "/volume --inc") end
})

hl.gesture({
  fingers = 3,
  direction = "down",
  action = function() hl.exec_cmd(scripts .. "/volume --dec") end
})

hl.gesture({
  fingers = 3,
  direction = "horizontal",
  action = "workspace"
})

hl.gesture({
  fingers = 4,
  direction = "up",
  action = "fullscreen"
})

hl.gesture({
  fingers = 4,
  direction = "down",
  action = "close"
})

hl.gesture({
  fingers = 4,
  direction = "horizontal",
  action = "scroll_move"
})
