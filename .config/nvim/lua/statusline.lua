local colors = {
	a_bg = "#990000",
	a_fg_norm = "#121212",
	a_fg_ins = "#e2e2e2",

	b_bg = "#222222",
	b_fg = "#c2c2c2",

	c_bg = "#121212",
	c_fg = "#b2b2b2",

	sep_fg = "#990000",

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

	loc_number = "#e2e2e2",
	loc_total = "#990000",
	loc_letter = "#b2b2b2",
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

local highlights_set = false

local function setup_highlights()
	if highlights_set then
		return
	end
	highlights_set = true

	-- Modes
	vim.api.nvim_set_hl(0, "StlModeNorm", { fg = colors.a_fg_norm, bg = colors.a_bg, bold = true })
	vim.api.nvim_set_hl(0, "StlModeIns", { fg = colors.a_fg_ins, bg = colors.a_bg, bold = true })
	vim.api.nvim_set_hl(0, "StlModeVis", { fg = colors.vis_fg, bg = colors.vis_bg, bold = true })
	vim.api.nvim_set_hl(0, "StlModeRep", { fg = colors.a_fg_norm, bg = colors.a_bg, bold = true })

	-- Time
	vim.api.nvim_set_hl(0, "StlTimeNorm", { fg = colors.a_fg_norm, bg = colors.a_bg, bold = true })
	vim.api.nvim_set_hl(0, "StlTimeIns", { fg = colors.a_fg_ins, bg = colors.a_bg, bold = true })
	vim.api.nvim_set_hl(0, "StlTimeVis", { fg = colors.vis_fg, bg = colors.vis_bg, bold = true })
	vim.api.nvim_set_hl(0, "StlTimeRep", { fg = colors.a_fg_norm, bg = colors.a_bg, bold = true })

	-- Sections
	vim.api.nvim_set_hl(0, "StlSecB", { fg = colors.b_fg, bg = colors.b_bg })
	vim.api.nvim_set_hl(0, "StlSecC", { fg = colors.c_fg, bg = colors.c_bg })

	-- Separator
	vim.api.nvim_set_hl(0, "StlSep", { fg = colors.sep_fg, bg = colors.c_bg })

	-- git diff
	vim.api.nvim_set_hl(0, "StlDiffAdd", { fg = colors.diff_add, bg = colors.c_bg })
	vim.api.nvim_set_hl(0, "StlDiffMod", { fg = colors.diff_mod, bg = colors.c_bg })
	vim.api.nvim_set_hl(0, "StlDiffRem", { fg = colors.diff_rem, bg = colors.c_bg })

	-- diagnostics
	vim.api.nvim_set_hl(0, "StlDiagErr", { fg = colors.diag_err, bg = colors.c_bg })
	vim.api.nvim_set_hl(0, "StlDiagWarn", { fg = colors.diag_warn, bg = colors.c_bg })
	vim.api.nvim_set_hl(0, "StlDiagInfo", { fg = colors.diag_info, bg = colors.c_bg })
	vim.api.nvim_set_hl(0, "StlDiagHint", { fg = colors.diag_hint, bg = colors.c_bg })

	-- Macro indicator
	vim.api.nvim_set_hl(0, "StlMacro", { fg = colors.macro_fg, bg = colors.c_bg, bold = true })

	-- Line and column
	vim.api.nvim_set_hl(0, "StlLocNumber", { fg = colors.loc_number, bg = colors.b_bg, bold = true, italic = true })
	vim.api.nvim_set_hl(0, "StlLocTotal", { fg = colors.loc_total, bg = colors.b_bg, italic = true })
	vim.api.nvim_set_hl(0, "StlLocLetter", { fg = colors.loc_letter, bg = colors.b_bg, italic = true })
end

-- Reset highlights on colorscheme change
vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		highlights_set = false
		setup_highlights()
	end,
})

---- COMPONENTS

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
local branch_cached = ""
local function update_branch()
	-- gitsigns first
	if vim.b.gitsigns_head and vim.b.gitsigns_head ~= "" then
		branch_cached = vim.b.gitsigns_head
		return
	end
	-- fallback to git command
	local result = vim.fn.system("git rev-parse --abbrev-ref HEAD 2>/dev/null")
	if vim.v.shell_error == 0 and result and result ~= "" then
		branch_cached = vim.trim(result)
	else
		branch_cached = ""
	end
end

local function branch_comp()
	-- check gitsigns in real-time in case it loaded after init
	local head = vim.b.gitsigns_head
	if head and head ~= "" then
		return "%#StlSecC#  " .. head .. " "
	end
	if branch_cached == "" then
		return ""
	end
	return "%#StlSecC#  " .. branch_cached .. " "
end

-- git diff
local function diff_comp()
	local a, m, r = 0, 0, 0

	-- gitsigns first
	local gs = vim.b.gitsigns_status_dict
	if gs then
		a, m, r = gs.added or 0, gs.changed or 0, gs.removed or 0
	else
		-- fallback to mini.diff
		local md = vim.b.minidiff_summary
		if md then
			a, m, r = md.add or 0, md.change or 0, md.delete or 0
		else
			return ""
		end
	end

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
	return "%#StlMacro#/ " .. macro_cached .. " "
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

-- buffer indicator (only shows when >1 buffer)
local function buf_comp()
	local bufs = vim.tbl_filter(function(b)
		return vim.api.nvim_buf_is_valid(b) and vim.bo[b].buflisted
	end, vim.api.nvim_list_bufs())

	local total = #bufs
	if total <= 1 then
		return ""
	end

	local current = vim.api.nvim_get_current_buf()
	local idx = 1
	for i, b in ipairs(bufs) do
		if b == current then
			idx = i
			break
		end
	end

	return table.concat({
		"%#StlLocLetter# b:",
		"%#StlLocNumber#" .. idx,
		"%#StlLocTotal#/" .. total,
	})
end

-- line and column
local function loc_comp()
	local line = vim.fn.line(".")
	local total = vim.api.nvim_buf_line_count(0)
	local col = vim.fn.virtcol(".")
	return table.concat({
		buf_comp(),
		"%#StlLocLetter# l:",
		"%#StlLocNumber#" .. line,
		"%#StlLocTotal#/" .. total,
		"%#StlLocLetter# c:",
		"%#StlLocNumber#" .. col .. " ",
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
		"%#StlSep#/",
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
		update_branch()
	end,
})

-- Init
setup_highlights()
update_lsp()
update_macro()
update_branch()

return M
