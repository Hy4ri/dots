-- vimwere.lua
-- Hyprland Lua module: open a floating nvim window to edit text,
-- then paste it back into the previously focused input field.
--
-- This version is non-blocking: the editor is launched in the
-- background and a timer polls for its exit.

local M = {}

local TMP_FILE = "/tmp/vimwere"
local PID_FILE = "/tmp/vimwere.pid"
local APP_ID   = "float_vim_capture"

function M.run()
  -- Clean up leftovers from previous runs
  os.remove(TMP_FILE)
  os.remove(PID_FILE)

  -- Apply floating window rules dynamically
  hl.window_rule({
    match = { class = APP_ID },
    float = true,
  })
  hl.window_rule({
    match = { class = APP_ID },
    size  = { 1000, 500 },
  })
  hl.window_rule({
    match = { class = APP_ID },
    move  = { 500, 60 },
  })

  -- Copy any existing text from the active input field
  hl.dispatch(hl.dsp.send_shortcut({
    mods   = "CTRL",
    key    = "a",
    window = "active",
  }))
  hl.dispatch(hl.dsp.send_shortcut({
    mods   = "CTRL",
    key    = "c",
    window = "active",
  }))

  -- Launch editor in the background and capture its PID.
  -- The shell exits immediately after writing the PID, so os.execute
  -- returns quickly and does not block the compositor.
  os.execute(
    '(foot --app-id="' .. APP_ID .. '" nvim "' .. TMP_FILE .. '")'
    .. ' & echo $! > "' .. PID_FILE .. '"'
  )

  -- Poll until the editor process exits
  local stopped   = false
  local attempts  = 0
  local max_attempts = 1200 -- 10 minutes at 500ms intervals

  hl.timer(function()
    if stopped then
      return
    end

    attempts = attempts + 1
    if attempts > max_attempts then
      stopped = true
      os.remove(PID_FILE)
      return
    end

    -- PID file may not exist yet if the shell hasn't finished launching
    local pid_f = io.open(PID_FILE, "r")
    if not pid_f then
      return
    end
    local pid = pid_f:read("*l")
    pid_f:close()

    if not pid or pid == "" then
      return
    end

    -- Check whether the process is still alive via /proc
    local proc_f = io.open("/proc/" .. pid .. "/stat", "r")
    if proc_f then
      proc_f:close()
      -- Still running; poll again later
      return
    end

    -- Editor has exited
    stopped = true
    os.remove(PID_FILE)

    local content_f = io.open(TMP_FILE, "r")
    if content_f then
      local content = content_f:read("*a")
      content_f:close()

      if content and #content > 0 then
        -- Copy to Wayland clipboard
        local pipe = io.popen("wl-copy", "w")
        if pipe then
          pipe:write(content)
          local ok = pipe:close()
          if ok then
            -- Paste into the previously focused window
            hl.dispatch(hl.dsp.send_shortcut({
              mods   = "CTRL",
              key    = "v",
              window = "active",
            }))
          end
        end
      end

      os.remove(TMP_FILE)
    end
  end, { timeout = 500, type = "repeat" })
end

return M
