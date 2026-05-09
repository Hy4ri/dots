--[[
===========================================================================
  Custom Layouts — Guide & Reference
===========================================================================

  ── Registering a Layout ──────────────────────────────────────────────

  hl.layout.register("name", {
    recalculate = function(ctx)
      -- Place every target inside ctx.area
    end,

    -- Optional: handle runtime messages (layoutmsg dispatcher)
    layout_msg = function(ctx, msg)
      -- Parse msg and update layout state
      -- Return true on success, or a string with an error message
    end,
  })


  ── Context (ctx) ─────────────────────────────────────────────────────

  Field       Type     Description
  ─────────── ──────── ─────────────────────────────────────────────────
  ctx.area    table    Work area for this layout { x, y, w, h }
  ctx.targets table[]  List of layout targets (windows, groups, etc.)

  Each target:
    target.window  may be nil (some targets wrap multiple windows)
    target:place(box)     Preferred placement — handles gaps, pseudo-
                          tiling, and reserved space automatically.
    target:set_box(box)   Manual positioning — only when you need full
                          control and want to bypass automatic handling.


  ── Built-in Helpers ──────────────────────────────────────────────────

  Helper                     Description
  ────────────────────────── ───────────────────────────────────────────
  ctx:column(i, n)           Split ctx.area into n vertical columns,
                             return the i-th column.
  ctx:row(i, n)              Split ctx.area into n horizontal rows,
                             return the i-th row.
  ctx:grid_cell(i, cols)     Grid cell for index i with the given
                             number of columns.
  ctx:split(area, side, r)   Split `area` by `side` ("left"/"right"/
                             "top"/"bottom") at ratio r (0.0–1.0).
                             Returns the first part.


  ── State & Input Handling ────────────────────────────────────────────

  • Keep mutable state in a local table outside recalculate().
  • Always clamp ratios and validate inputs inside layout_msg().
  • Return true on success, or an error string on failure.


  ── Minimal Template ──────────────────────────────────────────────────

  hl.layout.register("columns", {
    recalculate = function(ctx)
      local n = #ctx.targets
      if n == 0 then return end

      for i, target in ipairs(ctx.targets) do
        target:place(ctx:column(i, n))
      end
    end,
  })


  ── Message-Enabled Template ──────────────────────────────────────────

  local state = { ratio = 0.6 }

  hl.layout.register("main_stack", {
    recalculate = function(ctx)
      local n = #ctx.targets
      if n == 0 then return end

      local main = ctx:split(ctx.area, "left", state.ratio)
      ctx.targets[1]:place(main)

      for i = 2, n do
        ctx.targets[i]:place(ctx:row(i - 1, n - 1))
      end
    end,

    layout_msg = function(ctx, msg)
      local command, arg = msg:match("^(%S+)%s*(.*)$")
      if command == "ratio" then
        local value = tonumber(arg)
        if not value then
          return "main_stack: ratio expects a number"
        end
        state.ratio = math.max(0.1, math.min(0.9, value))
        return true
      end
      return "main_stack: expected ratio <0.1..0.9>"
    end,
  })


  ── Available Layouts (defined below) ─────────────────────────────────

  Layout          Description
  ─────────────── ──────────────────────────────────────────────────────
  columns         All windows in equal-width vertical columns.
  grid            Windows arranged in a square-ish grid.
  spiral          Recursive split — each new window splits the largest
                  remaining space. Supports grow/shrink/rotate.
  deck            Master on the left, single stacked window on the right
                  (only the last window shows in the stack).

  See each layout's implementation below for available messages.
]]

--[[
  columns — All windows in equal-width vertical columns.

  Messages: none
]]
hl.layout.register("columns", {
  recalculate = function(ctx)
    local n = #ctx.targets
    if n == 0 then
      return
    end

    for i, target in ipairs(ctx.targets) do
      target:place(ctx:column(i, n))
    end
  end,
})
--[[
  grid — Windows arranged in a square-ish grid.

  Automatically calculates column count as ceil(sqrt(n)).
  Messages: none
]]
hl.layout.register("grid", {
  recalculate = function(ctx)
    local n = #ctx.targets
    if n == 0 then
      return
    end

    local cols = math.ceil(math.sqrt(n))

    for i, target in ipairs(ctx.targets) do
      target:place(ctx:grid_cell(i, cols))
    end
  end,
})
--[[
  spiral — Recursive split layout.

  Each new window splits the largest remaining space. The split side
  cycles through left → top → right → bottom.

  Messages:
    ratio <0.1..0.9>   Set split ratio directly
    grow               Increase ratio by 0.05
    shrink             Decrease ratio by 0.05
    rotate             Rotate the starting split side
]]
local state = {
  ratio = 0.58,
  offset = 0,
}

local sides = { "left", "top", "right", "bottom" }
local opposite = {
  left = "right",
  right = "left",
  top = "bottom",
  bottom = "top",
}

local function clamp(x, min, max)
  return math.max(min, math.min(max, x))
end

hl.layout.register("spiral", {
  recalculate = function(ctx)
    local n = #ctx.targets
    if n == 0 then
      return
    end

    local area = ctx.area

    for i, target in ipairs(ctx.targets) do
      if i == n then
        target:place(area)
      else
        local side = sides[((i - 1 + state.offset) % #sides) + 1]
        target:place(ctx:split(area, side, state.ratio))
        area = ctx:split(area, opposite[side], 1.0 - state.ratio)
      end
    end
  end,

  layout_msg = function(ctx, msg)
    local command, arg = msg:match("^(%S+)%s*(.*)$")

    if command == "ratio" then
      state.ratio = clamp(tonumber(arg) or state.ratio, 0.1, 0.9)
    elseif command == "grow" then
      state.ratio = clamp(state.ratio + 0.05, 0.1, 0.9)
    elseif command == "shrink" then
      state.ratio = clamp(state.ratio - 0.05, 0.1, 0.9)
    elseif command == "rotate" then
      state.offset = (state.offset + 1) % #sides
    else
      return "spiral: expected ratio <0.1..0.9>, grow, shrink, or rotate"
    end

    return true
  end,
})
--[[
  deck — Master on the left, single stacked window on the right.

  Only the last (newest) window shows in the stack area — older stack
  windows are hidden behind it. The `offset` state variable is declared
  but not currently used in recalculate; it is reserved for future use.

  Messages:
    ratio <0.15..0.85>   Set master ratio directly
    grow                 Increase ratio by 0.05
    shrink               Decrease ratio by 0.05
    offset <n>           Set stack offset (reserved, currently unused)
]]
local deck_state = {
  ratio = 0.6,
  offset = 6,
}

hl.layout.register("deck", {
  recalculate = function(ctx)
    local n = #ctx.targets
    if n == 0 then
      return
    end

    if n == 1 then
      ctx.targets[1]:place(ctx.area)
      return
    end

    local master_box = ctx:split(ctx.area, "left", deck_state.ratio)
    local deck_box = ctx:split(ctx.area, "right", 1.0 - deck_state.ratio)

    ctx.targets[1]:place(master_box)

    local last = ctx.targets[n]
    last:place(deck_box)
  end,

  layout_msg = function(ctx, msg)
    local command, arg = msg:match("^(%S+)%s*(.*)$")

    if command == "ratio" then
      deck_state.ratio = clamp(tonumber(arg) or deck_state.ratio, 0.15, 0.85)
    elseif command == "grow" then
      deck_state.ratio = clamp(deck_state.ratio + 0.05, 0.15, 0.85)
    elseif command == "shrink" then
      deck_state.ratio = clamp(deck_state.ratio - 0.05, 0.15, 0.85)
    elseif command == "offset" then
      deck_state.offset = math.max(0, tonumber(arg) or deck_state.offset)
    else
      return "deck: expected ratio <0.15..0.85>, grow, shrink, or offset <n>"
    end

    return true
  end,
})
