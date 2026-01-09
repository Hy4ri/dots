vim.pack.add({ "https://github.com/lewis6991/hover.nvim" })

require("hover").config({
	--- List of modules names to load as providers.
	--- @type (string|Hover.Config.Provider)[]
	providers = {
		"hover.providers.diagnostic",
		"hover.providers.lsp",
		"hover.providers.dap",
		"hover.providers.man",
		"hover.providers.dictionary",
		"hover.providers.highlight",
		"hover.providers.fold_preview",
		-- 'hover.providers.gh',
		-- 'hover.providers.gh_user',
		-- 'hover.providers.jira',
	},
	preview_opts = {
		border = "single",
	},
	-- Whether the contents of a currently open hover window should be moved
	-- to a :h preview-window when pressing the hover keymap.
	preview_window = true,
	title = true,
})

-- Setup keymaps
-- stylua: ignore start
vim.keymap.set("n", "K", function() require("hover").open() end, { desc = "hover.nvim (open)" })
vim.keymap.set("n", "gK", function() require("hover").enter() end, { desc = "hover.nvim (enter)" })
-- stylua: ignore stop
