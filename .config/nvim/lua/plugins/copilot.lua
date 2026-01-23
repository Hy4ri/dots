vim.pack.add({ "https://github.com/zbirenbaum/copilot.lua", "https://github.com/copilotlsp-nvim/copilot-lsp" })

-- Defer copilot setup to after UI is ready
vim.api.nvim_create_autocmd("InsertEnter", {
	once = true,
	callback = function()
		require("copilot").setup({
			panel = {
				enabled = false,
			},
			suggestion = {
				enabled = true,
				auto_trigger = false,
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
	end,
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
