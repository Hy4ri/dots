vim.pack.add({ "https://github.com/oskarnurm/koda.nvim" })

require("koda").setup({
	transparent = false,

	styles = {
		functions = { bold = true, italic = true },
		keywords = { bold = false, italic = false },
		comments = { bold = true, italic = true },
		strings = { bold = true, italic = false },
		constants = { bold = true, italic = false },
	},

	-- Override colors
	colors = {
		bg = "#121212", -- editor background
		fg = "#b0b0b0", -- primary text color
		dim = "#222222", -- dimmer bg
		line = "#272727", -- line highlights
		keyword = "#777777", -- language syntax
		comment = "#50585d", -- code comments, line numbers,inlay hints
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

vim.cmd.colorscheme("koda")
