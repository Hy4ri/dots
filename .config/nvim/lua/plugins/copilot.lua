vim.pack.add({ "https://github.com/zbirenbaum/copilot.lua" })
vim.pack.add({ "https://github.com/copilotlsp-nvim/copilot-lsp" })

require("copilot").setup({
	panel = {
		enabled = true,
	},
	suggestion = {
		auto_trigger = true,
		hide_during_completion = false,
		keymap = {
			accept_line = "<M-y>",
			next = "<M-]>",
			prev = "<M-[>",
			dismiss = "<C-]>",
		},
	},
	workspace_folders = { "~/Documents/Projects" },
	disable_limit_reached_message = false,
})

-- override copilot highlight groups
-- local function set_copilot_hl()
-- 	vim.api.nvim_set_hl(0, "CopilotSuggestion", { fg = "#50585d" })
-- end
--
-- vim.api.nvim_create_autocmd("ColorScheme", {
-- 	callback = function()
-- 		set_copilot_hl()
-- 		vim.defer_fn(set_copilot_hl, 50)
-- 	end,
-- })
