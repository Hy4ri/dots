local function updateSmartBorders()
  local ws = hl.get_active_workspace()
  if not ws then return end

  local windows = hl.get_workspace_windows(ws.id)
  local tiled_count = 0

  -- Smart borders should only consider tiled windows.
  for _, w in ipairs(windows) do
    if not w.floating then
      tiled_count = tiled_count + 1
    end
  end

  if tiled_count == 1 then
    hl.config({ general = { border_size = 0 } })
  else
    hl.config({ general = { border_size = 1 } })
  end
end

-- Register events to trigger the check
hl.on("window.open", updateSmartBorders)
hl.on("window.close", updateSmartBorders)
hl.on("workspace.active", updateSmartBorders)
hl.on("window.move_to_workspace", updateSmartBorders)
hl.on("window.fullscreen", updateSmartBorders)
hl.on("window.update_rules", updateSmartBorders)
