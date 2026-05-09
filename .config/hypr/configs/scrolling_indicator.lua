--[[
  Scrolling Indicator — Gradient border showing neighbor direction

  Active border becomes a gradient:
    • Left side red    → windows to the left
    • Right side red   → windows to the right
    • Both sides red   → windows on both sides
    • Solid base color → only window on the workspace

  The heavy lifting (hyprctl queries + border setting) runs in a
  background script so the compositor never blocks.
]]

local scripts = os.getenv("HOME") .. "/.config/hypr/scripts"

local function update_border()
  if hl.get_config("general.layout") ~= "scrolling" then
    return
  end
  hl.exec_cmd(scripts .. "/scroll-indicator")
end

hl.on("window.active", update_border)
hl.on("window.open",   update_border)
hl.on("window.close",  update_border)
