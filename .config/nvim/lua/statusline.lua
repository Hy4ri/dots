local colors = {
	a_bg = "#990000",
	a_fg_norm = "#121212",
	a_fg_ins = "#e2e2e2",

	b_bg = "#222222",
	b_fg = "#c2c2c2",

	c_bg = "#121212",
	c_fg = "#b2b2b2",

	vis_bg = "#121212",
	vis_fg = "#990000",

	diff_add = "#A3BE8C",
	diff_mod = "#EBCB8B",
	diff_rem = "#BF616A",

	diag_err = "#BF616A",
	diag_warn = "#EBCB8B",
	diag_info = "#88C0D0",
	diag_hint = "#81A1C1",

	macro_fg = "#BF616A",

	loc_line = "#990000",
	loc_total = "#770000",
	loc_col = "#b2b2b2",
}

local modes = {
	["n"] = "NORMAL",
	["no"] = "OP-PENDING",
	["nov"] = "OP-PENDING",
	["noV"] = "OP-PENDING",
	["no\22"] = "OP-PENDING",
	["niI"] = "NORMAL",
	["niR"] = "NORMAL",
	["niV"] = "NORMAL",
	["nt"] = "NORMAL",
	["ntT"] = "NORMAL",
	["v"] = "VISUAL",
	["vs"] = "VISUAL",
	["V"] = "VISUAL",
	["Vs"] = "VISUAL",
	["\22"] = "VISUAL",
	["\22s"] = "VISUAL",
	["s"] = "SELECT",
	["S"] = "SELECT",
	["\19"] = "SELECT",
	["i"] = "INSERT",
	["ic"] = "INSERT",
	["ix"] = "INSERT",
	["R"] = "REPLACE",
	["Rc"] = "REPLACE",
	["Rx"] = "REPLACE",
	["Rv"] = "VIRT REPLACE",
	["Rvc"] = "VIRT REPLACE",
	["Rvx"] = "VIRT REPLACE",
	["c"] = "COMMAND",
	["cv"] = "VIM EX",
	["ce"] = "EX",
	["r"] = "PROMPT",
	["rm"] = "MORE",
	["r?"] = "CONFIRM",
	["!"] = "SHELL",
	["t"] = "TERMINAL",
}

local function get_hl(name, opts)
	local hl_name = "Stl" .. name
	vim.api.nvim_set_hl(0, hl_name, opts)
	return "%#" .. hl_name .. "#"
end

local function setup_highlights()
	-- Modes
	get_hl("ModeNorm", { fg = colors.a_fg_norm, bg = colors.a_bg, bold = true })
	get_hl("ModeIns", { fg = colors.a_fg_ins, bg = colors.a_bg, bold = true })
	get_hl("ModeVis", { fg = colors.vis_fg, bg = colors.vis_bg, bold = true }) -- Inverted
	get_hl("ModeRep", { fg = colors.a_fg_norm, bg = colors.a_bg, bold = true })
	-- Time
	get_hl("TimeNorm", { fg = colors.a_fg_norm, bg = colors.a_bg, bold = true })
	get_hl("TimeIns", { fg = colors.a_fg_ins, bg = colors.a_bg, bold = true })
	get_hl("TimeVis", { fg = colors.vis_fg, bg = colors.vis_bg, bold = true })
	get_hl("TimeRep", { fg = colors.a_fg_norm, bg = colors.a_bg, bold = true })

	-- Sections
	get_hl("SecB", { fg = colors.b_fg, bg = colors.b_bg })
	get_hl("SecC", { fg = colors.c_fg, bg = colors.c_bg })

	-- git diff
	get_hl("DiffAdd", { fg = colors.diff_add, bg = colors.c_bg })
	get_hl("DiffMod", { fg = colors.diff_mod, bg = colors.c_bg })
	get_hl("DiffRem", { fg = colors.diff_rem, bg = colors.c_bg })
	-- diagnostics
	get_hl("DiagErr", { fg = colors.diag_err, bg = colors.c_bg })
	get_hl("DiagWarn", { fg = colors.diag_warn, bg = colors.c_bg })
	get_hl("DiagInfo", { fg = colors.diag_info, bg = colors.c_bg })
	get_hl("DiagHint", { fg = colors.diag_hint, bg = colors.c_bg })
	-- Macro indicator
	get_hl("Macro", { fg = colors.macro_fg, bg = colors.c_bg, bold = true })
	-- Line and column
	get_hl("LocLine", { fg = colors.loc_line, bg = colors.b_bg, bold = true, italic = true })
	get_hl("LocTotal", { fg = colors.loc_total, bg = colors.b_bg, italic = true })
	get_hl("LocCol", { fg = colors.loc_col, bg = colors.b_bg, italic = true })
end

---- COMPONENTS

-- modes
local function mode_comp()
	local mode = vim.api.nvim_get_mode().mode
	local txt = modes[mode] or "UNKNOWN"
	local hl = "StlModeNorm"

	if mode:find("i") then
		hl = "StlModeIns"
	elseif mode:find("v") or mode:find("V") or mode == "\22" then
		hl = "StlModeVis"
	elseif mode:find("R") then
		hl = "StlModeRep"
	end

	return "%#" .. hl .. "# " .. txt .. " "
end

-- file name
local function file_comp(is_inactive)
	local file
	if is_inactive then
		file = vim.fn.expand("%:f") -- Relative path
	else
		file = vim.fn.expand("%:t") -- Filename only
	end

	if file == "" then
		file = "[No Name]"
	end
	if vim.bo.modified then
		file = file .. " ●"
	end
	if vim.bo.readonly or not vim.bo.modifiable then
		file = file .. " "
	end

	return "%#StlSecB# " .. file .. " "
end

-- search count
local function search_comp()
	if vim.v.hlsearch == 0 then
		return ""
	end
	local reg = vim.fn.getreg("/")
	if reg == "" then
		return ""
	end

	local ok, count = pcall(vim.fn.searchcount, { recompute = 1, maxcount = 0 })
	if not ok or count.total == 0 then
		return ""
	end
	return "%#StlSecB# " .. count.current .. "/" .. count.total .. " "
end

-- git branch
local function branch_comp()
	local head = vim.b.gitsigns_head
	if not head then
		return ""
	end
	return "%#StlSecC#  " .. head .. " "
end

-- git diff
local function diff_comp()
	if not vim.b.gitsigns_head then
		return ""
	end
	local s = vim.b.gitsigns_status_dict or {}
	local a, m, r = s.added or 0, s.changed or 0, s.removed or 0
	local ret = ""
	if a > 0 then
		ret = ret .. "%#StlDiffAdd#+" .. a .. " "
	end
	if m > 0 then
		ret = ret .. "%#StlDiffMod#~" .. m .. " "
	end
	if r > 0 then
		ret = ret .. "%#StlDiffRem#-" .. r .. " "
	end
	return ret
end

-- diagnostics
local function diag_comp()
	if #vim.diagnostic.get(0) == 0 then
		return ""
	end
	local c = { 0, 0, 0, 0 }
	for _, d in ipairs(vim.diagnostic.get(0)) do
		c[d.severity] = c[d.severity] + 1
	end
	local ret = ""
	if c[1] > 0 then
		ret = ret .. "%#StlDiagErr# " .. c[1] .. " "
	end
	if c[2] > 0 then
		ret = ret .. "%#StlDiagWarn# " .. c[2] .. " "
	end
	if c[3] > 0 then
		ret = ret .. "%#StlDiagInfo# " .. c[3] .. " "
	end
	if c[4] > 0 then
		ret = ret .. "%#StlDiagHint# " .. c[4] .. " "
	end
	return ret
end

-- Cached LSP
local lsp_cached = ""
local function update_lsp()
	local clients = vim.lsp.get_clients({ bufnr = 0 })
	if #clients == 0 then
		lsp_cached = ""
		return
	end
	local names = {}
	for _, c in ipairs(clients) do
		if not vim.tbl_contains(names, c.name) then
			table.insert(names, c.name)
		end
	end
	lsp_cached = table.concat(names, ", ")
end

local function lsp_comp()
	if lsp_cached == "" then
		return ""
	end
	return "%#StlSecC#" .. lsp_cached .. " "
end

-- Cached Macro
local macro_cached = ""
local function update_macro()
	local reg = vim.fn.reg_recording()
	if reg == "" then
		macro_cached = ""
	else
		macro_cached = " @" .. reg
	end
end

local function macro_comp()
	if macro_cached == "" then
		return ""
	end
	return "%#StlMacro#" .. macro_cached
end

-- file format
local function filefmt_comp()
	local fmt = vim.bo.fileformat
	local icon = ""
	if fmt == "unix" then
		icon = " "
	elseif fmt == "dos" then
		icon = " "
	elseif fmt == "mac" then
		icon = " "
	end
	return "%#StlSecC#" .. icon .. " "
end

-- line and column
local function loc_comp()
	local line = vim.fn.line(".")
	local total = vim.api.nvim_buf_line_count(0)
	local col = vim.fn.virtcol(".")
	return table.concat({
		"%#StlLocLine# l: " .. line,
		"%#StlLocTotal#/" .. total,
		"%#StlLocCol# c:" .. col .. " ", -- Added space
	})
end

-- time
local function time_comp()
	local mode = vim.api.nvim_get_mode().mode
	local hl = "StlTimeNorm"
	if mode:find("i") then
		hl = "StlTimeIns"
	elseif mode:find("v") or mode:find("V") or mode == "\22" then
		hl = "StlTimeVis"
	elseif mode:find("R") then
		hl = "StlTimeRep"
	end

	return "%#" .. hl .. "# " .. os.date("%I:%M") .. " "
end

-- MODULE
local M = {}

function M.active()
	setup_highlights()
	return table.concat({
		mode_comp(),
		file_comp(false),
		search_comp(),
		branch_comp(),
		diff_comp(),
		"%#StlSecC#%=", -- Spacer with C background
		diag_comp(),
		lsp_comp(),
		macro_comp(),
		filefmt_comp(),
		loc_comp(),
		time_comp(),
	})
end

-- AUTOCMDS
local grp = vim.api.nvim_create_augroup("StlUpdates", { clear = true })
-- lsp update
vim.api.nvim_create_autocmd({ "LspAttach", "LspDetach", "BufEnter" }, {
	group = grp,
	callback = function()
		vim.defer_fn(update_lsp, 100)
	end,
})
-- macro update
vim.api.nvim_create_autocmd({ "RecordingEnter", "RecordingLeave" }, {
	group = grp,
	callback = function(data)
		if data.event == "RecordingLeave" then
			macro_cached = ""
		else
			update_macro()
		end
		vim.cmd.redrawstatus()
	end,
})
-- statusline switch
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
	group = grp,
	callback = function()
		vim.wo.statusline = "%!v:lua.require'statusline'.active()"
	end,
})

-- Init
update_lsp()
update_macro()

return M
