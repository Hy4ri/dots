vim.pack.add({ "https://github.com/oskarnurm/koda.nvim" })
vim.pack.add({ "https://github.com/rebelot/kanagawa.nvim" })

require("koda").setup({
	transparent = false, -- enable for transparent backgrounds

	styles = {
		functions = { bold = true, italic = true },
		keywords = {},
		comments = {},
		strings = {},
		constants = {}, -- includes numbers, booleans
	},

	-- Override colors
	colors = {
		bg = "#121212", -- editor background
		fg = "#b0b0b0", -- primary text color
		line = "#272727", -- line highlights
		paren = "#4d4d4d", -- matching brackets highlight
		keyword = "#777777", -- language syntax
		dim = "#50585d", -- line numbers, inlay hints
		comment = "#50585d", -- code comments
		border = "#ffffff", -- floating window borders
		emphasis = "#ffffff", -- bold text and prominent UI elements
		func = "#ffffff", -- function names and headings
		string = "#e2e2e2", -- string literals
		const = "#990000", -- numbers, booleans, and constants
		highlight = "#770000", -- search results and selection base
		info = "#8ebeec", -- diagnostic hints and informative icons
		success = "#A3BE8C", -- added git lines and positive diagnostics
		warning = "#EBCB8B", -- modified git lines and warning diagnostics
		danger = "#BF616A", -- removed git lines and error diagnostics
	},
})

require("kanagawa").setup({
	transparent = true,
})

-- Apply theme
vim.cmd.colorscheme("koda")
