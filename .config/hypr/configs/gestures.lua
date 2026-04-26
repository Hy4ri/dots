local scripts = os.getenv("HOME") .. "/.config/hypr/scripts"

-- Gestures

hl.gesture({
  fingers = 2,
  direction = "pinchin",
  action = "cursorZoom",
  zoom_level = 3.5
})

hl.gesture({
  fingers = 2,
  direction = "pinchout",
  action = "cursorZoom",
  zoom_level = 1 -- Reset zoom
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
  direction = "right",
  action = "move"
})

hl.gesture({
  fingers = 4,
  direction = "left",
  action = "move"
})
