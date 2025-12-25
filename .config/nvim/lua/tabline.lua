local M = {}

-- Colors
vim.api.nvim_set_hl(0, "oTabLineSel", { bg = "#990000", fg = "#e2e2e2", bold = true, italic = true }) -- Active Tab
vim.api.nvim_set_hl(0, "oTabLine", { bg = "#121212", fg = "#b2b2b2" }) -- Inactive Tabs
vim.api.nvim_set_hl(0, "oTabLineFill", { bg = "#121212" }) -- Background Line

_G.inactive = function()
	return ""
end

-- Unified Click Handler
_G.TabLineHandler = function(bufnr, click, button, mode)
	if button == "l" then
		-- Left click: Switch to buffer
		vim.api.nvim_set_current_buf(bufnr)
	elseif button == "r" then
		-- Right click: Close buffer
		vim.schedule(function()
			if vim.api.nvim_buf_is_valid(bufnr) then
				vim.api.nvim_buf_delete(bufnr, { force = false })
			end
		end)
	end
end

function M.render()
	local parts = {}
	local current_buf = vim.api.nvim_get_current_buf()

	for _, buf in ipairs(vim.t.bufs or vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted then
			local name = vim.fn.bufname(buf)
			name = vim.fn.fnamemodify(name, ":t")
			if name == "" then
				name = "[No Name]"
			end

			local is_active = (buf == current_buf)
			local mod = vim.bo[buf].modified and " ●" or ""

			local component = "%" .. buf .. "@v:lua.TabLineHandler@ " .. name .. mod .. " %X"
			if is_active then
				table.insert(parts, "%#oTabLineSel#" .. component)
			else
				table.insert(parts, "%#oTabLine#" .. component)
			end
		end
	end

	return table.concat(parts, "") .. "%#oTabLineFill#"
end

-- Auto toggle >1
local group = vim.api.nvim_create_augroup("TabLineAuto", { clear = true })
vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete", "BufEnter" }, {
	group = group,
	callback = function()
		local bufs = vim.fn.getbufinfo({ buflisted = 1 })
		if #bufs >= 2 then
			vim.opt.showtabline = 2
			vim.opt.tabline = "%!v:lua.require'tabline'.render()"
		else
			vim.opt.showtabline = 0
		end
	end,
})

return M
